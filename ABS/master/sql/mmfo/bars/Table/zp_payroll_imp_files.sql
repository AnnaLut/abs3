exec bars.bpa.alter_policy_info( 'ZP_PAYROLL_IMP_FILES', 'WHOLE' , null, null, null, null ); 
/
exec bars.bpa.alter_policy_info( 'ZP_PAYROLL_IMP_FILES ', 'FILIAL', null, null, null, null );
/
begin execute immediate'create table bars.zp_payroll_imp_files  (
   id              number,
   id_pr           number,
   imp_date        date,
   file_name       varchar2(150),
   sos             number,  
   err_text        varchar2(4000),
   cnt_doc         number,
   cnt_doc_reject  number,
   file_clob       clob,
   file_blob       blob,
   file_type       varchar2(100), 
   
   constraint pk_zp_payroll_imp_files_id          primary key (id),
   constraint cc_zp_payroll_imp_files_sos         check (sos in (1,2,3,0)),  
   constraint fk_zp_payroll_imp_files_id_pr       foreign key (id_pr)  references bars.zp_payroll(id)
  )';
exception when others then  
  if sqlcode = -00955 then null;   else raise; end if;   
end;
/
exec  bars.bpa.alter_policies('ZP_PAYROLL_IMP_FILES'); 
/
begin
    execute immediate 'create index idx_zp_payroll_imp_files_id_pr on BARS.zp_payroll_imp_files (id_pr)';
 exception when others then 
    if sqlcode = -955 or sqlcode = -1408 then null; else raise; 
    end if; 
end;
/
comment on table  bars.ZP_PAYROLL_IMP_FILES is 'Імпортовані файли по відомостям';
/
grant select,delete,update,insert on bars.ZP_PAYROLL_IMP_FILES to bars_access_defrole;
/



