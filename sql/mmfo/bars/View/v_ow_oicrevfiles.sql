

PROMPT ===================================================================================== 
PROMPT *** Run *** ========== Scripts /Sql/BARS/View/V_OW_OICREVFILES.sql =========*** Run *
PROMPT ===================================================================================== 


PROMPT *** Create  view V_OW_OICREVFILES ***

  CREATE OR REPLACE FORCE VIEW BARS.V_OW_OICREVFILES ("FILE_NAME", "FILE_DATE", "FILE_N", "FILE_S", "FILE_R", "TICK_NAME", "TICK_DATE", "TICK_STATUS", "TICK_ACCEPT_REC", "TICK_REJECT_REC") AS 
  select f.file_name, f.file_date, f.file_n, f.file_s, 0 file_rr,
       f.tick_name, f.tick_date, f.tick_status, f.tick_accept_rec, f.tick_reject_rec
  from ow_oicrevfiles f;

PROMPT *** Create  grants  V_OW_OICREVFILES ***
grant SELECT                                                                 on V_OW_OICREVFILES to BARS_ACCESS_DEFROLE;



PROMPT ===================================================================================== 
PROMPT *** End *** ========== Scripts /Sql/BARS/View/V_OW_OICREVFILES.sql =========*** End *
PROMPT ===================================================================================== 
