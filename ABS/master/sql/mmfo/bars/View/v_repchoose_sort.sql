

PROMPT ===================================================================================== 
PROMPT *** Run *** ========== Scripts /Sql/BARS/View/V_REPCHOOSE_SORT.sql =========*** Run *
PROMPT ===================================================================================== 


PROMPT *** Create  view V_REPCHOOSE_SORT ***

  CREATE OR REPLACE FORCE VIEW BARS.V_REPCHOOSE_SORT ("ID", "DESCRIPT", "SRT") AS 
  select 'сумі', 'по сумі в межах рахунку',  0 from dual
union all
select 'даті',  'по даті в межах рахунку', 1 from dual
union all
select 'рахунку', 'по рахунку в звіті',  2 from dual
 ;

PROMPT *** Create  grants  V_REPCHOOSE_SORT ***
grant SELECT                                                                 on V_REPCHOOSE_SORT to BARSREADER_ROLE;
grant SELECT                                                                 on V_REPCHOOSE_SORT to BARS_ACCESS_DEFROLE;
grant SELECT                                                                 on V_REPCHOOSE_SORT to RPBN001;
grant SELECT                                                                 on V_REPCHOOSE_SORT to UPLD;



PROMPT ===================================================================================== 
PROMPT *** End *** ========== Scripts /Sql/BARS/View/V_REPCHOOSE_SORT.sql =========*** End *
PROMPT ===================================================================================== 
