
 
 PROMPT ===================================================================================== 
 PROMPT *** Run *** ========== Scripts /Sql/BARS/type/r_duplicate_ebk.sql =========*** Run **
 PROMPT ===================================================================================== 
 
  CREATE OR REPLACE TYPE BARS.R_DUPLICATE_EBK as object ( kf varchar2(6),
                                                   rnk number(38)  );
/

 show err;
 
PROMPT *** Create  grants  R_DUPLICATE_EBK ***
grant EXECUTE                                                                on R_DUPLICATE_EBK to BARS_ACCESS_DEFROLE;

 
 
 PROMPT ===================================================================================== 
 PROMPT *** End *** ========== Scripts /Sql/BARS/type/r_duplicate_ebk.sql =========*** End **
 PROMPT ===================================================================================== 
 