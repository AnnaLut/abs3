
 
 PROMPT ===================================================================================== 
 PROMPT *** Run *** ========== Scripts /Sql/BARS/type/t_dictionary_list.sql =========*** Run 
 PROMPT ===================================================================================== 
 
  CREATE OR REPLACE TYPE BARS.T_DICTIONARY_LIST as table of T_DICTIONARY
/

 show err;
 
PROMPT *** Create  grants  T_DICTIONARY_LIST ***
grant EXECUTE                                                                on T_DICTIONARY_LIST to BARS_ACCESS_DEFROLE;

 
 
 PROMPT ===================================================================================== 
 PROMPT *** End *** ========== Scripts /Sql/BARS/type/t_dictionary_list.sql =========*** End 
 PROMPT ===================================================================================== 
 