

PROMPT ===================================================================================== 
PROMPT *** Run *** ========== Scripts /Sql/BARS/View/V_CIM_F98_NOTREZ.sql =========*** Run *
PROMPT ===================================================================================== 


PROMPT *** Create  view V_CIM_F98_NOTREZ ***

  CREATE OR REPLACE FORCE VIEW BARS.V_CIM_F98_NOTREZ ("DT", "K040", "K040_TXT", "R4", "ADRIN", "NOMNAK", "DATANAK", "SANKSIA1", "SANKSIA1_TXT", "SRSANK11", "NOMNAKSK", "DATNAKSK", "SRSANK12", "STATUS", "V_SANK") AS 
  select min(f.dt), min(to_number(f.k040)), min(c.name), f.r4, min(f.adrin), f.nomnak, f.datanak, f.sanksia1,
          case when f.sanksia1='I' or f.sanksia1='І' then 'Індивiдуальне лiцензування'
               when f.sanksia1='З' then 'Тимчасове зупинення дiяльностi'
               when f.sanksia1='ПІ' and f.sanksia1='П' then 'Попередження'
          end,
          min(f.srsank11), f.nomnaksk, f.datnaksk, f.srsank12,
          decode(f.v_sank,'2', 'ВІДМІНА',
                 case when f.sanksia1='П' or f.sanksia1='ПІ' then 'ПOПЕРЕДЖЕННЯ'
                      when f.nakaz like 'ПРИЗУПИН%' then 'ПРИЗУПИНЕННЯ'
                      else 'ЗАСТОСУВАННЯ'
                 end), v_sank
   from cim_f98 f, country c
   where c.country(+)=to_number(f.k040) and f.k030='2' and f.delete_date is null
   group by f.r4, f.nomnak, f.datanak, f.nomnaksk, f.datnaksk, f.sanksia1, f.v_sank, f.srsank12, f.nakaz
   order by f.r4, nvl(f.datnaksk, f.datanak), f.v_sank;

PROMPT *** Create  grants  V_CIM_F98_NOTREZ ***
grant SELECT                                                                 on V_CIM_F98_NOTREZ to BARS_ACCESS_DEFROLE;



PROMPT ===================================================================================== 
PROMPT *** End *** ========== Scripts /Sql/BARS/View/V_CIM_F98_NOTREZ.sql =========*** End *
PROMPT ===================================================================================== 
