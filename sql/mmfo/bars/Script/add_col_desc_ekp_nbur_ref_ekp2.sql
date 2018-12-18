PROMPT ******** Start add column DESC_EKP to BARS.nbur_ref_ekp2
--scripts
begin  EXECUTE IMMEDIATE 'ALTER TABLE BARS.nbur_ref_ekp2 ADD (DESC_EKP CLOB) ' ;
exception when others then   if SQLCODE = - 01430 then null;   else raise; end if; -- ORA-01430: column being added already exists in table
end;
/
comment on column BARS.nbur_ref_ekp2.DESC_EKP is 'Опис правил формування показника з файлу Registry_XXX.xls';
/
PROMPT ******** And add column DESC_EKP to BARS.nbur_ref_ekp2
