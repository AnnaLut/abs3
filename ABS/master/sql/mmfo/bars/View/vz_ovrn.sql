

PROMPT ===================================================================================== 
PROMPT *** Run *** ========== Scripts /Sql/BARS/View/VZ_OVRN.sql =========*** Run *** ======
PROMPT ===================================================================================== 


PROMPT *** Create  view VZ_OVRN ***

  CREATE OR REPLACE FORCE VIEW BARS.VZ_OVRN ("NPP", "TXT", "ACC") AS 
  select s.npp, NVL(z.txt,s.txt) TXT, z.ACC
from (select * from OVR_REP_ZAG where acc = to_number( pul.Get_Mas_Ini_Val('ACC') ) ) z,
     (select 1 NPP,         '***Заступнику Голови правління-' txt  from dual union all
      select 2 NPP,                '***фінансовому директору' txt  from dual union all
      select 4 NPP,                        '***Петренко О.В.' txt  from dual union all
      select 5 NPP,            '***10008, Львівська область,' txt  from dual union all
      select 6 NPP, '***м. Львів, вул. Гетьмана, буд.3, оф.5' txt  from dual union all
      select 8 NPP,    '***Шановний Олександр Володимирович!' txt  from dual
     ) s
where s.npp = z.npp (+)  ;

PROMPT *** Create  grants  VZ_OVRN ***
grant SELECT                                                                 on VZ_OVRN         to BARSREADER_ROLE;
grant SELECT                                                                 on VZ_OVRN         to BARS_ACCESS_DEFROLE;
grant SELECT                                                                 on VZ_OVRN         to START1;
grant SELECT                                                                 on VZ_OVRN         to UPLD;



PROMPT ===================================================================================== 
PROMPT *** End *** ========== Scripts /Sql/BARS/View/VZ_OVRN.sql =========*** End *** ======
PROMPT ===================================================================================== 
