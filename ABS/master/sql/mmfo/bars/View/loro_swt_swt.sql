

PROMPT ===================================================================================== 
PROMPT *** Run *** ========== Scripts /Sql/BARS/View/LORO_SWT_SWT.sql =========*** Run *** =
PROMPT ===================================================================================== 


PROMPT *** Create  view LORO_SWT_SWT ***

  CREATE OR REPLACE FORCE VIEW BARS.LORO_SWT_SWT ("KV", "SWREF", "MT", "SENDER", "NLS", "DATE_IN", "S", "VDATE", "NMS", "ACCD", "K50", "K70", "K72", "K57", "K58", "K59", "OTM", "KOD_N") AS 
  SELECT kv, SWREF, MT, SENDER, nls, date_in, S, vdate, NMS, accd, k50, k70, k72, k57, k58, k59, 0 otm, '1222' KOD_N
 from (SELECT x.kv,x.SWREF, x.MT, x.SENDER, x.nls, x.date_in, x.S, x.vdate, x.NMS, x.accd, x.k50, x.k70, x.k72, x.k57, x.k58, x.k59
       FROM (SELECT j.SWREF, j.MT, j.SENDER, a.nls, j.date_in, j.AMOUNT/100 S, j.vdate, a.nms, j.accd, a.kv ,
               SUBSTR((SELECT REPLACE(VALUE,CHR(13)||CHR(10),'~') FROM SW_OPERW WHERE SWREF=j.swref AND TAG='50')||'~',1,160)  k50,
               SUBSTR((SELECT REPLACE(VALUE,CHR(13)||CHR(10),'~') FROM SW_OPERW WHERE SWREF=j.swref AND TAG='57')||'~',1,160)  k57,
               SUBSTR((SELECT REPLACE(VALUE,CHR(13)||CHR(10),'~') FROM SW_OPERW WHERE SWREF=j.swref AND TAG='58')||'~',1,160)  k58,
               SUBSTR((SELECT REPLACE(VALUE,CHR(13)||CHR(10),'~') FROM SW_OPERW WHERE SWREF=j.swref AND TAG='59')||'~',1,160)  k59,
               SUBSTR((SELECT REPLACE(VALUE,CHR(13)||CHR(10),'~') FROM SW_OPERW WHERE SWREF=j.swref AND TAG='70')||'~',1,160)  k70,
               SUBSTR((SELECT REPLACE(VALUE,CHR(13)||CHR(10),'~') FROM SW_OPERW WHERE SWREF=j.swref AND TAG='72')||'~',1,160)  k72
             FROM sw_journal j, (select * from accounts  where kv<>980 AND nbs='1600') a
             WHERE j.io_ind='O' AND j.mt<300 AND j.CURRENCY<>'UAH' AND j.date_pay IS NULL AND j.accd=a.acc
       ) x
      )
 where k57||k58 like '%/1600%COSBUAUK%'  or k57||k58 not like '%COSBUAUK%';

PROMPT *** Create  grants  LORO_SWT_SWT ***
grant SELECT                                                                 on LORO_SWT_SWT    to BARS_ACCESS_DEFROLE;
grant SELECT                                                                 on LORO_SWT_SWT    to START1;



PROMPT ===================================================================================== 
PROMPT *** End *** ========== Scripts /Sql/BARS/View/LORO_SWT_SWT.sql =========*** End *** =
PROMPT ===================================================================================== 
