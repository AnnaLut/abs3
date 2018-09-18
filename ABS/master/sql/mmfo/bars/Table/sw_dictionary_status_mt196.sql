begin
bars_policy_adm.alter_policy_info('sw_dictionary_status_mt196', 'FILIAL', null, 'E', 'E','E');
bars_policy_adm.alter_policy_info('sw_dictionary_status_mt196', 'WHOLE', null, null,null,null);
end;
/


begin
execute immediate 'create table sw_dictionary_status_mt196(id varchar2(20), name varchar2(50), description varchar2(100))';
exception when others then if(sqlcode=-955) then null; else raise; end if;
end;
/

begin
execute immediate 'ALTER TABLE BARS.SW_DICTIONARY_STATUS_MT196 ADD 
CONSTRAINT PK_SW_DICTIONARY_STATUS_MT196
 PRIMARY KEY (ID)
 ENABLE
 VALIDATE';
exception when others then if(sqlcode=-2260) then null; else raise; end if;
end;
/ 


begin
bars_policy_adm.alter_policies('sw_dictionary_status_mt196');
end;
/
commit
/

begin
delete from sw_dictionary_status_mt196;

insert into sw_dictionary_status_mt196(id, name, description) values('PDCR','Незавершений','');
insert into sw_dictionary_status_mt196(id, name, description) values('CNCL','Анульований','');
insert into sw_dictionary_status_mt196(id, name, description) values('RJCR','Відхилений','');
end;
/
commit
/

