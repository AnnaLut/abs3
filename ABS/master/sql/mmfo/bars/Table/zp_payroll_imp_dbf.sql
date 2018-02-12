exec bars.bpa.alter_policy_info( 'ZP_PAYROLL_IMP_DBF', 'WHOLE' , null, null, null, null ); 
/
exec bars.bpa.alter_policy_info( 'ZP_PAYROLL_IMP_DBF ', 'FILIAL', null, null, null, null );
/
begin execute immediate'create table bars.zp_payroll_imp_dbf  (
   id              number,
   name            varchar2(4000),
   file_col_name   varchar2(4000),
   doc_col_name    varchar2(4000),
   sum             number,
   constraint cc_zp_payroll_imp_dbf_sum         check (sum in (0,1,100)),
   constraint pk_zp_payroll_imp_dbf primary     key(id,doc_col_name) ,
   constraint uq_zp_payroll_imp_dbf unique      (id,file_col_name),
   constraint cc_zp_payroll_imp_dbf_dcn         check (doc_col_name in (''S'',''NAMB'',''OKPOB'',''MFOB'',''NLSB'',''NAZN''))
  )';
exception when others then  
  if sqlcode = -00955 then null;   else raise; end if;   
end;
/
begin
    execute immediate 'alter table zp_payroll_imp_dbf add ( branch varchar2(400))';
 exception when others then 
    if sqlcode = -1430 then null; else raise; 
    end if; 
end;
/
begin
    execute immediate 'alter table zp_payroll_imp_dbf add ( encoding varchar2(400))';
 exception when others then 
    if sqlcode = -1430 then null; else raise; 
    end if; 
end;
/
exec  bars.bpa.alter_policies('ZP_PAYROLL_IMP_DBF'); 
/
comment on table  bars.ZP_PAYROLL_IMP_DBF is 'Довідник метаопису імпортованих файлів';
/
grant select,delete,update,insert on bars.ZP_PAYROLL_IMP_DBF to bars_access_defrole;
/

