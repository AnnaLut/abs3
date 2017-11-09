declare
    mat_view_doesnt_exist exception;
    pragma exception_init(mat_view_doesnt_exist, -12003);
begin
    execute immediate 'drop materialized view mv_global_context';
exception
    when mat_view_doesnt_exist then
         null;
end;
/

create materialized view mv_global_context
refresh force on demand
as
select client_identifier,
       user_id,
       login_name,
       last_activity_at,
       current_branch,
       current_bank_date
from   (select c.client_identifier, c.namespace, c.attribute, c.value from v$globalcontext c
        where (c.namespace = 'BARS_GLOBAL' and c.attribute in ('LAST_CALL', 'USER_ID', 'USER_NAME')) or
              (c.namespace = 'BARS_CONTEXT' and c.attribute in ('USER_BRANCH')) or
              (c.namespace = 'BARS_GL' and c.attribute = 'BANKDATE')) d
pivot  (min(d.value) for (namespace, attribute) in (('BARS_GLOBAL', 'USER_ID') as user_id,
                                                    ('BARS_GLOBAL', 'USER_NAME') as login_name,
                                                    ('BARS_GLOBAL', 'LAST_CALL') as last_activity_at,
                                                    ('BARS_CONTEXT', 'USER_BRANCH') as current_branch,
                                                    ('BARS_GL', 'BANKDATE') as current_bank_date));
