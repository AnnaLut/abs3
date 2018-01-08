
 
 PROMPT ===================================================================================== 
 PROMPT *** Run *** ========== Scripts /Sql/BARS/type/t_sw_msgjournal.sql =========*** Run **
 PROMPT ===================================================================================== 
 
  CREATE OR REPLACE TYPE BARS.T_SW_MSGJOURNAL is table of t_sw_msgjournal_rec
/

 show err;
 
PROMPT *** Create  grants  T_SW_MSGJOURNAL ***
grant EXECUTE                                                                on T_SW_MSGJOURNAL to WR_ALL_RIGHTS;

 
 
 PROMPT ===================================================================================== 
 PROMPT *** End *** ========== Scripts /Sql/BARS/type/t_sw_msgjournal.sql =========*** End **
 PROMPT ===================================================================================== 
 