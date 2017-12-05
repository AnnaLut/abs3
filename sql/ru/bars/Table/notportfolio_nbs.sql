begin
  bpa.alter_policy_info(p_table_name    => 'NOTPORTFOLIO_NBS',
                        p_policy_group  => 'WHOLE',
                        p_select_policy => null,
                        p_insert_policy => null,
                        p_update_policy => null,
                        p_delete_policy => null);
end;
/
begin
    execute immediate
    'create table NOTPORTFOLIO_NBS
     (
        nbs CHAR(4) not null,
        userid number(38),
        portfolio_code varchar2(4000 byte)
     )';
 exception when others then 
    if sqlcode = -955 then null; else raise; 
    end if; 
end;
/ 

declare
    column_already_exists exception;
    pragma exception_init(column_already_exists, -1430);
begin
    execute immediate 'alter table notportfolio_nbs add userid number(38)';
exception
    when column_already_exists then
         null;
end;
/

declare
    column_already_exists exception;
    pragma exception_init(column_already_exists, -1430);
begin
    execute immediate 'alter table notportfolio_nbs add portfolio_code varchar2(4000 byte)';
exception
    when column_already_exists then
         null;
end;
/

