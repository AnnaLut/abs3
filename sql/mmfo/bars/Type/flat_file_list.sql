
 
 PROMPT ===================================================================================== 
 PROMPT *** Run *** ========== Scripts /Sql/BARS/type/flat_file_list.sql =========*** Run ***
 PROMPT ===================================================================================== 
 
  CREATE OR REPLACE TYPE BARS.FLAT_FILE_LIST is table of flat_file_line
/

 show err;
 
PROMPT *** Create  grants  FLAT_FILE_LIST ***
grant EXECUTE                                                                on FLAT_FILE_LIST  to BARS_ACCESS_DEFROLE;

 
 
 PROMPT ===================================================================================== 
 PROMPT *** End *** ========== Scripts /Sql/BARS/type/flat_file_list.sql =========*** End ***
 PROMPT ===================================================================================== 
 