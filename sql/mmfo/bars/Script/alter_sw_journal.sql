begin
execute immediate 'alter table bars.sw_journal add STI varchar2(10)';
exception when others then if (sqlcode=-1430) then null; else raise; end if;
end;
/

begin
execute immediate 'alter table bars.sw_journal add UETR varchar2(36)';
exception when others then if (sqlcode=-1430) then null; else raise; end if;
end;
/
begin
execute immediate 'alter table bars.sw_journal add COV varchar2(10)';
exception when others then if (sqlcode=-1430) then null; else raise; end if;
end;
/
comment on column sw_journal.sti is 'Service type identifier'
/
comment on column sw_journal.uetr is 'Unique End-to-end Transaction Reference'
/
comment on column sw_journal.cov is 'Mark COV - STP and others'
/