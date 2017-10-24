

PROMPT ===================================================================================== 
PROMPT *** Run *** ========== Scripts /Sql/BARS/View/PAR_PROVODKI.sql =========*** Run *** =
PROMPT ===================================================================================== 


PROMPT *** Create  view PAR_PROVODKI ***

  CREATE OR REPLACE FORCE VIEW BARS.PAR_PROVODKI ("D", "K", "Z", "X", "V", "TAG", "T", "NAZN", "Y") AS 
  select   NVL( pul.GET('D'),'%') D,
         NVL( pul.GET('K'), '%') K,
         'Тільки "Корригуючі"'    Z,
         'Тільки "Сторно"'         X,
         'Тільки "Вал.Поз"'  V,
         NVL( pul.GET('T'),  'TAG'      ) TAG ,        'По "Дод.реквіз."'  T,  -- = Код дод.реквізиту
         NVL( pul.GET('Y'),  '%признач%') NAZN,        'По "Призначенню"'  Y   -- = Признач.пл схоже на
 from  dual;

PROMPT *** Create  grants  PAR_PROVODKI ***
grant SELECT                                                                 on PAR_PROVODKI    to BARS_ACCESS_DEFROLE;
grant SELECT                                                                 on PAR_PROVODKI    to START1;



PROMPT ===================================================================================== 
PROMPT *** End *** ========== Scripts /Sql/BARS/View/PAR_PROVODKI.sql =========*** End *** =
PROMPT ===================================================================================== 
