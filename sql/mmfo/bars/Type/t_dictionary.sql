
 
 PROMPT ===================================================================================== 
 PROMPT *** Run *** ========== Scripts /Sql/BARS/type/t_dictionary.sql =========*** Run *** =
 PROMPT ===================================================================================== 
 
  CREATE OR REPLACE TYPE BARS.T_DICTIONARY force as table of t_dictionary_item
/

 show err;
 
PROMPT *** Create  grants  T_DICTIONARY ***
grant EXECUTE                                                                on T_DICTIONARY    to BARS_ACCESS_DEFROLE;

 
 
 PROMPT ===================================================================================== 
 PROMPT *** End *** ========== Scripts /Sql/BARS/type/t_dictionary.sql =========*** End *** =
 PROMPT ===================================================================================== 
 