
 
 PROMPT ===================================================================================== 
 PROMPT *** Run *** ========== Scripts /Sql/BARS/type/t_dictionary_item.sql =========*** Run 
 PROMPT ===================================================================================== 
 
  CREATE OR REPLACE TYPE BARS.T_DICTIONARY_ITEM force as object
(
       key varchar2(32767 byte),
       value varchar2(32767 byte)
)
/

 show err;
 
PROMPT *** Create  grants  T_DICTIONARY_ITEM ***
grant EXECUTE                                                                on T_DICTIONARY_ITEM to BARS_ACCESS_DEFROLE;

 
 
 PROMPT ===================================================================================== 
 PROMPT *** End *** ========== Scripts /Sql/BARS/type/t_dictionary_item.sql =========*** End 
 PROMPT ===================================================================================== 
 