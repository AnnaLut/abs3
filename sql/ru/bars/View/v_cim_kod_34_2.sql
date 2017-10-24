

PROMPT ===================================================================================== 
PROMPT *** Run *** ========== Scripts /Sql/BARS/View/V_CIM_KOD_34_2.sql =========*** Run ***
PROMPT ===================================================================================== 


PROMPT *** Create  view V_CIM_KOD_34_2 ***

  CREATE OR REPLACE FORCE VIEW BARS.V_CIM_KOD_34_2 ("ID", "NAME") AS 
  select 1, 'розрахунки за кредитом завершені' from dual
union
select 2, 'розрахунки за кредитом не завершені' from dual
union
select 3, 'кредит не отриманий, строк дії реєстрації договору не закінчився' from dual
union
select 4, 'розрахунки за кредитом завершено достроково' from dual
union
select 5, 'строк дії реєстрації договору закінчився, у тому числі анулювання реєстраційного свідоцтва' from dual
;

PROMPT *** Create  grants  V_CIM_KOD_34_2 ***
grant SELECT                                                                 on V_CIM_KOD_34_2  to BARS_ACCESS_DEFROLE;



PROMPT ===================================================================================== 
PROMPT *** End *** ========== Scripts /Sql/BARS/View/V_CIM_KOD_34_2.sql =========*** End ***
PROMPT ===================================================================================== 
