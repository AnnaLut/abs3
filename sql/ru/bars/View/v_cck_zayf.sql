

PROMPT ===================================================================================== 
PROMPT *** Run *** ========== Scripts /Sql/BARS/View/V_CCK_ZAYF.sql =========*** Run *** ===
PROMPT ===================================================================================== 


PROMPT *** Create  view V_CCK_ZAYF ***

  CREATE OR REPLACE FORCE VIEW BARS.V_CCK_ZAYF ("PROD", "NAME", "TERM", "AIM", "VVOD") AS 
  select c.NBS||c.ob22                                      prod,
      substr(s.txt,1,100)                                 name,
      DECODE(substr(c.nbs,4,1),'3','Довгий','Короткий')   term,
      DECODE(substr(c.nbs,3,1),'0','Поточнi',
                                   'Iпотека'   )          AIM,
      make_url('/barsroot/credit/cck_zay.aspx', 'Заявка на кредит',
      'PROD', c.NBS||c.ob22, 'NAME', substr(s.txt,1,100), 'CUSTTYPE', '3') VVOD
 from CCK_OB22 c,    sb_ob22 s
 where s.d_close is null and s.r020=c.nbs and s.ob22=c.ob22
  and c.nbs in ('2202','2203','2232','2233');

PROMPT *** Create  grants  V_CCK_ZAYF ***
grant FLASHBACK,SELECT                                                       on V_CCK_ZAYF      to BARS_ACCESS_DEFROLE;
grant SELECT                                                                 on V_CCK_ZAYF      to RCC_DEAL;
grant DELETE,FLASHBACK,INSERT,SELECT,UPDATE                                  on V_CCK_ZAYF      to WR_ALL_RIGHTS;
grant SELECT                                                                 on V_CCK_ZAYF      to WR_CREDIT;
grant FLASHBACK,SELECT                                                       on V_CCK_ZAYF      to WR_REFREAD;



PROMPT ===================================================================================== 
PROMPT *** End *** ========== Scripts /Sql/BARS/View/V_CCK_ZAYF.sql =========*** End *** ===
PROMPT ===================================================================================== 
