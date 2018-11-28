prompt create table DICT_TREASURY_STATUS
begin
    execute immediate '
create table DICT_TREASURY_STATUS
(
status_id number,
status_name varchar2(100),
constraint XPK_DICT_TREASURY_STATUS primary key (status_id)
)
organization index';
exception
    when others then
        if sqlcode = -955 then null; else raise; end if;
end;
/
grant select on DICT_TREASURY_STATUS to bars_access_defrole;