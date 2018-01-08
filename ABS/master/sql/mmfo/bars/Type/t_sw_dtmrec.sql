
 
 PROMPT ===================================================================================== 
 PROMPT *** Run *** ========== Scripts /Sql/BARS/type/t_sw_dtmrec.sql =========*** Run *** ==
 PROMPT ===================================================================================== 
 
  CREATE OR REPLACE TYPE BARS.T_SW_DTMREC is object (dtmtag char(5), value varchar2(1024))
/

 show err;
 
PROMPT *** Create  grants  T_SW_DTMREC ***
grant EXECUTE                                                                on T_SW_DTMREC     to WR_ALL_RIGHTS;

 
 
 PROMPT ===================================================================================== 
 PROMPT *** End *** ========== Scripts /Sql/BARS/type/t_sw_dtmrec.sql =========*** End *** ==
 PROMPT ===================================================================================== 
 