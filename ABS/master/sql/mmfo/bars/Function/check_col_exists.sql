
 
 PROMPT ===================================================================================== 
 PROMPT *** Run *** ========== Scripts /Sql/BARS/function/check_col_exists.sql =========*** R
 PROMPT ===================================================================================== 
 
  CREATE OR REPLACE FUNCTION BARS.CHECK_COL_EXISTS (
   table_ varchar2,  -- название таблицы
   col_   varchar2   -- название поля
) return number
is
   type_  varchar2(106);
begin
   SELECT data_type
     into type_
     FROM sys.user_tab_columns
    WHERE upper(table_name)=table_ AND upper(column_name)=col_;
   return 1;   -- существует
exception
   when no_data_found then
   return 0;   -- не существует
end;
 
/
 show err;
 
PROMPT *** Create  grants  CHECK_COL_EXISTS ***
grant EXECUTE                                                                on CHECK_COL_EXISTS to BARS_ACCESS_DEFROLE;
grant EXECUTE                                                                on CHECK_COL_EXISTS to DPT_ADMIN;
grant EXECUTE                                                                on CHECK_COL_EXISTS to DPT_ROLE;
grant EXECUTE                                                                on CHECK_COL_EXISTS to WR_ALL_RIGHTS;

 
 
 PROMPT ===================================================================================== 
 PROMPT *** End *** ========== Scripts /Sql/BARS/function/check_col_exists.sql =========*** E
 PROMPT ===================================================================================== 
 