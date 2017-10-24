

PROMPT ===================================================================================== 
PROMPT *** Run *** ========== Scripts /Sql/BARS/View/V_NBUR_MESSAGES.sql =========*** Run **
PROMPT ===================================================================================== 


PROMPT *** Create  view V_NBUR_MESSAGES ***

  CREATE OR REPLACE FORCE VIEW BARS.V_NBUR_MESSAGES ("REPORT_DATE", "KF", "REPORT_CODE", "VERSION_ID", "ID", "TXT", "USERID", "FIO") AS 
  SELECT l.report_date,
          l.kf,
          l.report_code,
          l.version_id,
          l.message_id id,
          l.message_txt txt,
          l.userid,
          nvl(f.fio, 'Автоматичний процес формування')
     FROM NBUR_LST_MESSAGES l, staff f
    WHERE l.userid = f.id(+);

PROMPT *** Create  grants  V_NBUR_MESSAGES ***
grant SELECT                                                                 on V_NBUR_MESSAGES to BARS_ACCESS_DEFROLE;
grant SELECT                                                                 on V_NBUR_MESSAGES to RPBN002;
grant SELECT                                                                 on V_NBUR_MESSAGES to START1;



PROMPT ===================================================================================== 
PROMPT *** End *** ========== Scripts /Sql/BARS/View/V_NBUR_MESSAGES.sql =========*** End **
PROMPT ===================================================================================== 
