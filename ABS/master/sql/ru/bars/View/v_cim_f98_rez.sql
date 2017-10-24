

PROMPT ===================================================================================== 
PROMPT *** Run *** ========== Scripts /Sql/BARS/View/V_CIM_F98_REZ.sql =========*** Run *** 
PROMPT ===================================================================================== 


PROMPT *** Create  view V_CIM_F98_REZ ***

  CREATE OR REPLACE FORCE VIEW BARS.V_CIM_F98_REZ ("DT", "KO_1", "KO_1_TXT", "R1_1", "R2_1", "K020", "NOMNAK", "DATANAK", "SANKSIA1", "SANKSIA1_TXT", "SRSANK11", "NOMNAKSK", "DATNAKSK", "SRSANK12", "STATUS", "V_SANK", "OUR_CLIENT") AS 
  select min(f.dt), min(to_number(f.ko_1)), min(o.knb), min(f.r1_1), min(f.r2_1), f.k020, f.nomnak, f.datanak, f.sanksia1,
          case when f.sanksia1='I' or f.sanksia1='�' then '�����i������� �i����������'
               when f.sanksia1='�' then '��������� ��������� �i�������i'
               when f.sanksia1='ϲ' and f.sanksia1='�' then '������������'
          end,
          min(f.srsank11), f.nomnaksk, f.datnaksk, min(f.srsank12),
          decode(f.v_sank,'2', '²�̲��',
                 case when f.sanksia1='�' or f.sanksia1='ϲ' then '�O����������'
                      when f.nakaz like '��������%' then '������������'
                      else '������������'
                 end), v_sank, nvl2(min(c.rnk), 1, null)
   from cim_f98 f
        left outer join kodobl o on o.ko=to_number(f.ko_1)
        left outer join customer c on c.okpo=f.k020
   where f.k030='1' and f.delete_date is null
   group by f.k020, f.nomnak, f.datanak, f.nomnaksk, f.datnaksk, f.sanksia1, f.v_sank, f.srsank12, f.nakaz
   order by f.k020, nvl(f.datnaksk, f.datanak), f.v_sank;

PROMPT *** Create  grants  V_CIM_F98_REZ ***
grant SELECT                                                                 on V_CIM_F98_REZ   to BARS_ACCESS_DEFROLE;



PROMPT ===================================================================================== 
PROMPT *** End *** ========== Scripts /Sql/BARS/View/V_CIM_F98_REZ.sql =========*** End *** 
PROMPT ===================================================================================== 
