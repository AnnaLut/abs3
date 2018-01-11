

PROMPT ===================================================================================== 
PROMPT *** Run *** ========== Scripts /Sql/BARS/View/V_ACCOUNT_EVENTS.sql =========*** Run *
PROMPT ===================================================================================== 


PROMPT *** Create  view V_ACCOUNT_EVENTS ***

  CREATE OR REPLACE FORCE VIEW BARS.V_ACCOUNT_EVENTS ("AC_ID", "USR_ID", "USR_NM", "EV_ID", "EV_DT", "EV_DSC", "EV_QTY") AS 
  select e.ACC, e.ISP, s.FIO
     , e.ID, e.FDAT, e.TXT
     , count(1) over ( partition by e.ACC )
  from ACC_SOB    e
  join STAFF$BASE s
    on ( s.ID = e.ISP )
 order by e.FDAT;

PROMPT *** Create  grants  V_ACCOUNT_EVENTS ***
grant SELECT                                                                 on V_ACCOUNT_EVENTS to BARS_ACCESS_DEFROLE;
grant SELECT                                                                 on V_ACCOUNT_EVENTS to UPLD;



PROMPT ===================================================================================== 
PROMPT *** End *** ========== Scripts /Sql/BARS/View/V_ACCOUNT_EVENTS.sql =========*** End *
PROMPT ===================================================================================== 
