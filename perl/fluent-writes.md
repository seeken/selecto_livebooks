# Perl: fluent writes, domain actions, and editable rows

Run these cells together with `python3 scripts/run_perl_workbook.py`. They use
native `selecto-perl` APIs and independently authored isolated teaching tables.
The default SQLite run needs DBI, DBD::SQLite and the sibling Perl dependencies.
For PostgreSQL, set `SELECTO_NOTEBOOK_ADAPTER=postgresql`,
`SELECTO_NOTEBOOK_DSN`, and optional `SELECTO_NOTEBOOK_USER` /
`SELECTO_NOTEBOOK_PASSWORD` in the host environment. Connection details are never
included in observations. SQLite uses private in-memory tables; PostgreSQL uses
connection-local temporary tables. The runner records the native source revision and
workbook digest. This is a teaching run, not a new certification profile.

## setup — Configure the domain, connection, and trusted context

The application owns the domain and authenticates tenant 8. The helper binds a
configured engine; it does not turn a client tenant value into authority.

```perl
use 5.034;
use strict;
use warnings;
use utf8;
use DBI ();
use JSON::PP ();
use Storable qw(dclone);
use Selecto;

my @observations;
sub record { my ($id, %values) = @_; push @observations, dclone({id => $id, %values}) }
sub check { die "workbook assertion failed: $_[1]\n" unless $_[0] }
sub refused {
    my ($work) = @_;
    my $ok = eval { $work->(); 1 };
    my $error = $@;
    check(!$ok && ref($error) eq 'Selecto::Error', 'native refusal required');
    return {code => $error->code, reason => $error->message};
}
my $backend = $ENV{SELECTO_NOTEBOOK_ADAPTER} // 'sqlite';
check($backend eq 'sqlite' || $backend eq 'postgresql', 'supported workbook adapter');
my $dsn = $ENV{SELECTO_NOTEBOOK_DSN} // ($backend eq 'sqlite' ? 'dbi:SQLite:dbname=:memory:' : undef);
die "PostgreSQL workbook requires host connection configuration\n" unless defined $dsn;
check($backend ne 'sqlite' || $dsn eq 'dbi:SQLite:dbname=:memory:', 'SQLite teaching database is private memory');
my $dbh = eval { DBI->connect($dsn, $ENV{SELECTO_NOTEBOOK_USER}, $ENV{SELECTO_NOTEBOOK_PASSWORD},
    {RaiseError => 1, PrintError => 0, AutoCommit => 1,
        ($backend eq 'sqlite' ? (sqlite_unicode => 1) : (pg_enable_utf8 => 1))}) };
die "workbook database connection unavailable\n" unless $dbh;
my $identity_sql = $backend eq 'sqlite' ? 'INTEGER PRIMARY KEY' : 'BIGSERIAL PRIMARY KEY';
my $table_kind = $backend eq 'sqlite' ? 'TABLE' : 'TEMP TABLE';
$dbh->do("CREATE $table_kind helper_items(id $identity_sql, tenant_id INTEGER NOT NULL, name TEXT NOT NULL, state TEXT NOT NULL, archive_reason TEXT)");
$dbh->do("CREATE TEMP TABLE helper_notes(id $identity_sql, tenant_id INTEGER NOT NULL, item_id BIGINT NOT NULL REFERENCES helper_items(id), name TEXT UNIQUE NOT NULL)")
    if $backend eq 'postgresql';
sub relation_contract {
    my ($table, @fields) = @_;
    return {
        name => $table,
        source => {source_table => $table, primary_key => 'id', tenant_field => 'tenant_id',
            fields => \@fields, associations => {}, columns => {map {
                $_ => {type => /\A(?:id|tenant_id|item_id)\z/ ? 'integer' : 'string'}
            } @fields}},
        schemas => {}, joins => {},
        writes => {
            operations => {map { $_ => {enabled => JSON::PP::true, returning => 'all'} } qw(insert update delete)},
            fields => {map { $_ => {insertable => JSON::PP::true, updatable => JSON::PP::true,
                ($_ eq 'tenant_id' ? (immutable => JSON::PP::true, required_on => ['insert']) : ())} }
                grep { $_ ne 'id' } @fields},
            scope => {tenant => {field => 'tenant_id', required => JSON::PP::true,
                satisfied_by => ['trusted_context']}},
        },
    };
}
my $contract = relation_contract('helper_items', qw(id tenant_id name state archive_reason));
$contract->{writes}{transitions} = {state => {done => ['archived']}};
$contract->{writes}{relationships}{notes} = {
    writable => JSON::PP::true, ownership => 'owned', cardinality => 'many',
    allowed_ops => ['insert'], child_key => 'item_id', identity_fields => ['id'],
    write => {modes => ['append_only'], create => JSON::PP::true},
    domain => relation_contract('helper_notes', qw(id tenant_id item_id name)),
};
$contract->{actions}{archive} = {
    type => 'transition', scope => 'row', capability => 'items.archive',
    transition => {field => 'state', from => 'done', to => 'archived'},
    inputs => {reason => {type => 'string', required => JSON::PP::true}},
    execution => {kind => 'updato', operation => 'update',
        set => {state => 'archived', archive_reason => ['input', 'reason']}},
};
$contract->{capabilities}{'items.archive'} = {operations => ['action', 'update'], action => 'archive'};
my $domain = Selecto::Domain->parse($contract);
my $adapter = Selecto->adapter($backend => (dbh => $dbh));
my $engine = Selecto::Engine->new(domain => $domain, adapter => $adapter)->with_tenant(8);
record('setup', backend => $backend, domain => $contract);
```

## returning — Insert without repeating the tenant assignment

Separate setters and chained calls use the same draft. `preview` exposes actual
native SQL and parameters, performs no target DML, and does not consume the draft.
`returning` returns ordinary values; it does not issue an editable row handle.

```perl
my $write = $engine->write()->insert();
$write->assignments(name => 'Tokyo 東京', state => 'done');
$write->returning(qw(id tenant_id name));
my $insert_preview = $write->preview();
check($dbh->selectrow_array('SELECT count(*) FROM helper_items') == 0, 'preview did not insert');
my $inserted = eval { $write->execute() };
my $insert_error = $@;
die $insert_error if $insert_error;
my $id = $inserted->values->{id};
check($inserted->values->{tenant_id} == 8, 'tenant supplied by host');
check($inserted->values->{name} eq 'Tokyo 東京', 'native Unicode value');
record('returning', preview => $insert_preview, result => $inserted->to_hash);
```

## tenant-refusals — Reject contradictory assignments

Omission is permitted. An explicit different tenant or null is a contradiction,
and is refused rather than overwritten. The persisted row count stays one.

```perl
my @tenant_refusals;
for my $tenant (9, undef) {
    push @tenant_refusals, refused(sub {
        $engine->write()->insert()
            ->assignments(name => 'Refused', state => 'done', tenant_id => $tenant)->execute();
    });
}
check($dbh->selectrow_array('SELECT count(*) FROM helper_items') == 1, 'tenant refusals did not insert');
record('tenant-refusals', refusals => \@tenant_refusals, persisted_rows => 1);
```

## domain-actions — Invoke the declared action and authorize each phase

The domain above defines the operation, inputs, transition, assignments and
capability. The host resolver below represents an authenticated application
policy; it is teaching policy, not a client-provided callback. The native result
retains the action envelope and its underlying write result.

```perl
my @phases;
my $policy = sub {
    my ($request, $context) = @_;
    push @phases, $request->{phase};
    return ($context->{actor}{id} // '') eq 'teacher' ? 'enabled' : 'disabled';
};
my $action = $engine->action('archive');
$action->target($id);
$action->inputs(reason => 'completed');
my $action_preview = $action->preview(resolver => $policy, context => {actor => {id => 'teacher'}});
my $action_result = eval { $action->execute(resolver => $policy, context => {actor => {id => 'teacher'}}) };
my $action_error = $@;
die $action_error if $action_error;
check(join(',', @phases) eq 'preview,execute', 'fresh permission for each phase');
check($dbh->selectrow_array('SELECT state FROM helper_items WHERE id = ?', undef, $id) eq 'archived', 'declared effect persisted');
record('domain-actions', preview => $action_preview,
    result => {%$action_result, result => $action_result->{result}->to_hash}, phases => \@phases);
my $stale = refused(sub { $engine->action('archive')->target($id)
    ->inputs(reason => 'again')->execute(resolver => $policy, context => {actor => {id => 'teacher'}}) });
my $missing = refused(sub { $engine->action('archive')->target($id)->inputs(reason => 'again')->execute() });
record('action-refusals', stale_transition => $stale, missing_resolver => $missing);
```

## editable-parent — Return a live handle and insert an owned child

This PostgreSQL workflow performs follow-up work in one pinned transaction.
The child key and tenant come from the governed relationship, not assignments.
The handle expires when the callback ends; copied values remain readable.
SQLite refuses editable handles explicitly and does not acquire equivalent row
locks. Native core integration tests separately verify real second-connection
contention; this workbook uses one connection.

```perl
my ($editable_id, $expired_row);
if ($backend eq 'postgresql') {
    my $created = $engine->transaction(sub {
        my ($tx) = @_;
        my $w = $tx->write()->insert()
            ->assignments(name => 'Editable', state => 'done')->return_for_update(qw(id tenant_id name));
        my $preview = $w->preview();
        my $parent = $w->execute();
        $editable_id = $parent->values->{id};
        $expired_row = $parent->row();
        my $child = $parent->row()->related_write('notes')->insert()
            ->assignments(name => 'First note')->returning(qw(id item_id tenant_id name));
        my $child_preview = $child->preview();
        my $child_result = $child->execute();
        check($child_result->values->{item_id} == $editable_id, 'native parent binding');
        check($child_result->values->{tenant_id} == 8, 'native child tenant');
        record('editable-parent', preview => $preview, values => $parent->values,
            related_preview => $child_preview, related_result => $child_result->to_hash);
        return $parent;
    });
    record('handle-expiry', refusal => refused(sub { $expired_row->write() }), values_after_commit => $created->values);
} else {
    my $unsupported = refused(sub { $engine->transaction(sub {
        my ($tx) = @_;
        $tx->write()->insert()->assignments(name => 'Unsupported', state => 'done')
            ->return_for_update('id')->execute();
    }) });
    check($dbh->selectrow_array('SELECT count(*) FROM helper_items') == 1, 'unsupported handle inserted nothing');
    record('editable-parent', unsupported => $unsupported);
}
```

## select-for-update — Read, lock, and update the same row

Select the granted identity and provide an exact key filter. Preview shows
`FOR UPDATE` without acquiring a business row lock. Execution acquires the root
lock; the follow-up rechecks domain and tenant governance using the private key.

```perl
if ($backend eq 'postgresql') {
    $engine->transaction(sub {
        my ($tx) = @_;
        my $query = $tx->query()->filter(Selecto::Expression->eq('id', $editable_id))
            ->select_for_update(qw(id name));
        my $preview = $query->preview();
        my $editable = $query->execute();
        my $update = $editable->row()->write()->update()->assignments(name => 'Changed');
        my $update_preview = $update->preview();
        my $updated = $update->execute();
        record('select-for-update', preview => $preview, update_preview => $update_preview,
            result => $updated->to_hash);
    });
    my $rollback = refused(sub { $engine->transaction(sub {
        my ($tx) = @_;
        my $parent = $tx->write()->insert()->assignments(name => 'Rolled back', state => 'done')
            ->return_for_update('id')->execute();
        refused(sub { $parent->row()->related_write('notes')->insert()->assignments(name => 'First note')->execute() });
    }) });
    check($dbh->selectrow_array("SELECT count(*) FROM helper_items WHERE name = 'Rolled back'") == 0, 'caught child failure rolled back parent');
    record('child-rollback', refusal => $rollback, persisted_parent_rows => 0);
}
record('final-state', items => $dbh->selectall_arrayref('SELECT id,tenant_id,name,state,archive_reason FROM helper_items ORDER BY id'),
    notes => $backend eq 'postgresql' ? $dbh->selectall_arrayref('SELECT id,tenant_id,item_id,name FROM helper_notes ORDER BY id') : []);
$dbh->disconnect();
print JSON::PP->new->canonical()->utf8()->encode({backend => $backend, observations => \@observations}), "\n";
```

These observed results do not grant execution permission. Preview and execute
authorize independently. Compound root handles require every key field in the
projection and each exact read-key predicate; see the native
[usage guide](https://github.com/seeken/selecto-perl/blob/062545f51efa8971a55cecfeea262519418b7f0f/docs/fluent-writes.md).
Action-produced handles, row-bound action convenience, shared relationships,
synchronization, compound bulk-action targets, multi-column relationship bindings,
and editable adapters beyond PostgreSQL remain unsupported.
