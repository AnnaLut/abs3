

PROMPT ===================================================================================== 
PROMPT *** Run *** ========== Scripts /Sql/BARS/View/V_CIM_MONTHES.sql =========*** Run *** 
PROMPT ===================================================================================== 


PROMPT *** Create  view V_CIM_MONTHES ***

  CREATE OR REPLACE FORCE VIEW BARS.V_CIM_MONTHES ("M_ID", "M_NAME") AS 
  select '1',      'січень'  from dual
union
select '2',      'лютий'  from dual
union
select '3',      'березень'  from dual
union
select '4',      'квітень'  from dual
union
select '5',      'травень'  from dual
union
select '6',      'червень'  from dual
union
select '7',      'липень'  from dual
union
select '8',      'серпень'  from dual
union
select '9',      'вересень'  from dual
union
select 'A',      'жовтень'  from dual
union
select 'B',      'листопад'  from dual
union
select 'C',      'грудень'  from dual;

PROMPT *** Create  grants  V_CIM_MONTHES ***
grant SELECT                                                                 on V_CIM_MONTHES   to BARS_ACCESS_DEFROLE;



PROMPT ===================================================================================== 
PROMPT *** End *** ========== Scripts /Sql/BARS/View/V_CIM_MONTHES.sql =========*** End *** 
PROMPT ===================================================================================== 
