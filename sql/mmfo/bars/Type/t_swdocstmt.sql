
 
 PROMPT ===================================================================================== 
 PROMPT *** Run *** ========== Scripts /Sql/BARS/type/t_swdocstmt.sql =========*** Run *** ==
 PROMPT ===================================================================================== 
 
  CREATE OR REPLACE TYPE BARS.T_SWDOCSTMT as object(
                           stmt   number(3),
                           ref    number(38),
                           flag   char(10)   );
/

 show err;
 
PROMPT *** Create  grants  T_SWDOCSTMT ***
grant EXECUTE                                                                on T_SWDOCSTMT     to WR_ALL_RIGHTS;

 
 
 PROMPT ===================================================================================== 
 PROMPT *** End *** ========== Scripts /Sql/BARS/type/t_swdocstmt.sql =========*** End *** ==
 PROMPT ===================================================================================== 
 