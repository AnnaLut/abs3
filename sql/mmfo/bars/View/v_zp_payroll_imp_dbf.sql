create or replace force view bars.v_zp_payroll_imp_dbf
(
   id,
   name
)
as
   select distinct id, name from zp_payroll_imp_dbf 
   where (branch LIKE SYS_CONTEXT ('bars_context', 'user_branch_mask') or branch is null) and id <>-99999;
/
grant delete, insert, select, update on bars.v_zp_payroll to bars_access_defrole;
/

