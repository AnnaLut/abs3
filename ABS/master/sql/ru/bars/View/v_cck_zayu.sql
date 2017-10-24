

PROMPT ===================================================================================== 
PROMPT *** Run *** ========== Scripts /Sql/BARS/View/V_CCK_ZAYU.sql =========*** Run *** ===
PROMPT ===================================================================================== 


PROMPT *** Create  view V_CCK_ZAYU ***

  CREATE OR REPLACE FORCE VIEW BARS.V_CCK_ZAYU ("PROD", "NAME", "TERM", "AIM", "VVOD") AS 
  select c.NBS||c.ob22                                          prod,
      substr(s.txt,1,100)                                     name,
      DECODE(substr(c.nbs,4,1),'3','Довгий','Короткий')       term,
      DECODE(substr(c.nbs,3,1),'6','Поточнi',
                               '7','Iнвестиц.',
                                   'Iпотека'   )              AIM,
make_url('/barsroot/credit/cck_zay.aspx', 'Заявка на кредит',
      'PROD', c.NBS||c.ob22, 'NAME', substr(s.txt,1,100), 'CUSTTYPE', '2') VVOD
from CCK_OB22 c,    sb_ob22 s
where s.d_close is null and s.r020=c.nbs and s.ob22=c.ob22
  and c.nbs in ('2062','2063','2072','2073','2082','2083');

PROMPT *** Create  grants  V_CCK_ZAYU ***
grant FLASHBACK,SELECT                                                       on V_CCK_ZAYU      to BARS_ACCESS_DEFROLE;
grant SELECT                                                                 on V_CCK_ZAYU      to RCC_DEAL;
grant DELETE,FLASHBACK,INSERT,SELECT,UPDATE                                  on V_CCK_ZAYU      to WR_ALL_RIGHTS;
grant SELECT                                                                 on V_CCK_ZAYU      to WR_CREDIT;
grant FLASHBACK,SELECT                                                       on V_CCK_ZAYU      to WR_REFREAD;



PROMPT ===================================================================================== 
PROMPT *** End *** ========== Scripts /Sql/BARS/View/V_CCK_ZAYU.sql =========*** End *** ===
PROMPT ===================================================================================== 
