
prompt   update nbur_log_f3mx -изменение размера поля Q001_1

begin
   EXECUTE IMMEDIATE 'alter table NBUR_LOG_F3MX  modify (Q001_1  varchar2(200))';

exception when others
   then   if SQLCODE = -01430 then null;   else raise; end if;
     -- ORA-01430: column being added already exists in table
end;
/

prompt   update nbur_log_f3mx -изменение размера поля Q001_2

begin
   EXECUTE IMMEDIATE 'alter table NBUR_LOG_F3MX  modify (Q001_2  varchar2(200))';

exception when others
   then   if SQLCODE = -01430 then null;   else raise; end if;
     -- ORA-01430: column being added already exists in table
end;
/
