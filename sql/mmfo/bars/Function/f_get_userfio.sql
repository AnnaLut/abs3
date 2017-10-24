
 
 PROMPT ===================================================================================== 
 PROMPT *** Run *** ========== Scripts /Sql/BARS/function/f_get_userfio.sql =========*** Run 
 PROMPT ===================================================================================== 
 
  CREATE OR REPLACE FUNCTION BARS.F_GET_USERFIO (p_id staff.id%type)
return staff.fio%type
is
l_fio staff.fio%type;
l_tabname user_tables.table_name%type;
 begin
   begin
        select table_name into l_tabname
         from user_tables
            where upper(table_name)='STAFF$BASE';
         exception when no_data_found then
              l_tabname:='STAFF';
     end;
     execute immediate 'select fio from '||l_tabname||' where id='||p_id into l_fio;
     return l_fio;
   end f_get_userfio;
/
 show err;
 
PROMPT *** Create  grants  F_GET_USERFIO ***
grant EXECUTE                                                                on F_GET_USERFIO   to BARS_ACCESS_DEFROLE;

 
 
 PROMPT ===================================================================================== 
 PROMPT *** End *** ========== Scripts /Sql/BARS/function/f_get_userfio.sql =========*** End 
 PROMPT ===================================================================================== 
 