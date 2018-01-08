
 
 PROMPT ===================================================================================== 
 PROMPT *** Run *** ========== Scripts /Sql/BARS/type/blob_list.sql =========*** Run *** ====
 PROMPT ===================================================================================== 
 
  CREATE OR REPLACE TYPE BARS.BLOB_LIST force as table of blob;
/

 show err;
 
PROMPT *** Create  grants  BLOB_LIST ***
grant EXECUTE                                                                on BLOB_LIST       to BARS_ACCESS_DEFROLE;

 
 
 PROMPT ===================================================================================== 
 PROMPT *** End *** ========== Scripts /Sql/BARS/type/blob_list.sql =========*** End *** ====
 PROMPT ===================================================================================== 
 