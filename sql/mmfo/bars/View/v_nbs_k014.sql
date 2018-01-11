

PROMPT ===================================================================================== 
PROMPT *** Run *** ========== Scripts /Sql/BARS/View/V_NBS_K014.sql =========*** Run *** ===
PROMPT ===================================================================================== 


PROMPT *** Create  view V_NBS_K014 ***

  CREATE OR REPLACE FORCE VIEW BARS.V_NBS_K014 ("K014", "K014_NAME", "NBS") AS 
  select k014,
       case
         when k014 = 1 then 'Юридична особа'
         when k014 = 2 then 'Фiзична особа - пiдприємець'
         when k014 = 3 then 'Фiзична особа'
         when k014 = 4 then 'Фiнансова установа - кореспондент'
         when k014 = 5 then 'Наш Банк'
         else null
       end k014_name,
       nbs
  from nbs_k014;

PROMPT *** Create  grants  V_NBS_K014 ***
grant SELECT                                                                 on V_NBS_K014      to BARSREADER_ROLE;
grant DELETE,FLASHBACK,INSERT,SELECT,UPDATE                                  on V_NBS_K014      to BARS_ACCESS_DEFROLE;
grant DELETE,INSERT,SELECT                                                   on V_NBS_K014      to CUST001;
grant DELETE,INSERT,SELECT,UPDATE                                            on V_NBS_K014      to PAP;
grant DELETE,INSERT,SELECT                                                   on V_NBS_K014      to START1;
grant SELECT                                                                 on V_NBS_K014      to UPLD;
grant FLASHBACK,SELECT                                                       on V_NBS_K014      to WR_REFREAD;



PROMPT ===================================================================================== 
PROMPT *** End *** ========== Scripts /Sql/BARS/View/V_NBS_K014.sql =========*** End *** ===
PROMPT ===================================================================================== 
