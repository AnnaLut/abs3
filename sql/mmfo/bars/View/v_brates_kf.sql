

PROMPT ===================================================================================== 
PROMPT *** Run *** ========== Scripts /Sql/BARS/View/V_BRATES_KF.sql =========*** Run *** ==
PROMPT ===================================================================================== 


PROMPT *** Create  view V_BRATES_KF ***

  CREATE OR REPLACE FORCE VIEW BARS.V_BRATES_KF ("BR_ID", "BR_NAME", "TYPE_ID", "TYPE_NAME", "INUSE") AS 
  SELECT br.br_id
       , br.name
       , bt.br_type
       , bt.name
       , br.INUSE
    FROM brates br
    JOIN br_types bt
      on ( bt.BR_TYPE = br.BR_TYPE );

PROMPT *** Create  grants  V_BRATES_KF ***
grant SELECT                                                                 on V_BRATES_KF     to BARS_ACCESS_DEFROLE;



PROMPT ===================================================================================== 
PROMPT *** End *** ========== Scripts /Sql/BARS/View/V_BRATES_KF.sql =========*** End *** ==
PROMPT ===================================================================================== 
