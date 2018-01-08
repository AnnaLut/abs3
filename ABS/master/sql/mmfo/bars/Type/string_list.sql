
 
 PROMPT ===================================================================================== 
 PROMPT *** Run *** ========== Scripts /Sql/BARS/type/string_list.sql =========*** Run *** ==
 PROMPT ===================================================================================== 
 
  CREATE OR REPLACE TYPE BARS.STRING_LIST force as table of varchar2(4000 byte);
/

 show err;
 
PROMPT *** Create  grants  STRING_LIST ***
grant EXECUTE                                                                on STRING_LIST     to BARSR;
grant EXECUTE                                                                on STRING_LIST     to BARS_ACCESS_DEFROLE;

 
 
 PROMPT ===================================================================================== 
 PROMPT *** End *** ========== Scripts /Sql/BARS/type/string_list.sql =========*** End *** ==
 PROMPT ===================================================================================== 
 