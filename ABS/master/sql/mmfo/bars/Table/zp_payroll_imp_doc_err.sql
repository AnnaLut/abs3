exec bars.bpa.alter_policy_info( 'ZP_PAYROLL_IMP_DOC_ERR', 'WHOLE' , null, null, null, null ); 
/
exec bars.bpa.alter_policy_info( 'ZP_PAYROLL_IMP_DOC_ERR ', 'FILIAL', null, null, null, null );
/
begin execute immediate'create table bars.zp_payroll_imp_doc_err
(
  id_file   number,
  s         number,
  okpob     varchar2(4000 byte),
  namb      varchar2(4000 byte),
  mfob      varchar2(4000 byte),
  nlsb      varchar2(4000 byte),
  err_text  varchar2(4000 byte),
  nazn      varchar2(4000 byte),
  constraint fk_zp_pr_imp_doc_err_id_file  foreign key (id_file) references bars.zp_payroll_imp_files (id)
)';
exception when others then  
  if sqlcode = -00955 then null;   else raise; end if;   
end;
/
exec  bars.bpa.alter_policies('ZP_PAYROLL_IMP_DOC_ERR'); 
/
comment on table  bars.ZP_PAYROLL_IMP_DOC_ERR is 'Імпортовані документи с помилками по відомостям';
/
begin
    execute immediate 'create index bars.idx_zp_pr_imp_doc_err_id_file on bars.zp_payroll_imp_doc_err(id_file)';
 exception when others then 
    if sqlcode = -955 or sqlcode = -1408 then null; else raise; 
    end if; 
end;
/
grant select,delete,update,insert on bars.ZP_PAYROLL_IMP_DOC_ERR to bars_access_defrole;
/