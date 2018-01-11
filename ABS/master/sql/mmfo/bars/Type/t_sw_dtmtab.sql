
 
 PROMPT ===================================================================================== 
 PROMPT *** Run *** ========== Scripts /Sql/BARS/type/t_sw_dtmtab.sql =========*** Run *** ==
 PROMPT ===================================================================================== 
 
  CREATE OR REPLACE TYPE BARS.T_SW_DTMTAB is table of t_sw_dtmrec
/

 show err;
 
PROMPT *** Create  grants  T_SW_DTMTAB ***
grant EXECUTE                                                                on T_SW_DTMTAB     to WR_ALL_RIGHTS;

 
 
 PROMPT ===================================================================================== 
 PROMPT *** End *** ========== Scripts /Sql/BARS/type/t_sw_dtmtab.sql =========*** End *** ==
 PROMPT ===================================================================================== 
 