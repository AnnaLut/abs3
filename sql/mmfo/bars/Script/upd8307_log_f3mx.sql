
prompt   update nbur_log_f3mx -изменение размера поля F02D

begin
   EXECUTE IMMEDIATE 'alter table NBUR_LOG_F3MX  modify (F02D  varchar2(2))';

exception when others
   then   if SQLCODE = -01430 then null;   else raise; end if;
     -- ORA-01430: column being added already exists in table
end;
/
