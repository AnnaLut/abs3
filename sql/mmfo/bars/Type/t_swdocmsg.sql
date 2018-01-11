
 
 PROMPT ===================================================================================== 
 PROMPT *** Run *** ========== Scripts /Sql/BARS/type/t_swdocmsg.sql =========*** Run *** ===
 PROMPT ===================================================================================== 
 
  CREATE OR REPLACE TYPE BARS.T_SWDOCMSG as object(
                           ref    number(38),
                           flag   char(10)  );
/

 show err;
 
PROMPT *** Create  grants  T_SWDOCMSG ***
grant EXECUTE                                                                on T_SWDOCMSG      to WR_ALL_RIGHTS;

 
 
 PROMPT ===================================================================================== 
 PROMPT *** End *** ========== Scripts /Sql/BARS/type/t_swdocmsg.sql =========*** End *** ===
 PROMPT ===================================================================================== 
 