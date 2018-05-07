PROMPT ===================================================================================== 
PROMPT *** Run *** ====== Scripts /Sql/BARS/type/T_ow_iicfiles_oper_lst.sql =======*** Run *
PROMPT ===================================================================================== 

create or replace type T_ow_iicfiles_oper_lst FORCE is table of T_ow_iicfiles_oper
/

show err;
 
PROMPT *** Create  grants  T_ow_iicfiles_oper_lst ***
grant EXECUTE  on T_ow_iicfiles_oper_lst to WR_ALL_RIGHTS;
 
PROMPT ===================================================================================== 
PROMPT *** End *** ====== Scripts /Sql/BARS/type/T_ow_iicfiles_oper_lst.sql =======*** End *
PROMPT ===================================================================================== 

