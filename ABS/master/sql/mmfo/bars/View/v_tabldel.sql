

PROMPT ===================================================================================== 
PROMPT *** Run *** ========== Scripts /Sql/BARS/View/V_TABLDEL.sql =========*** Run *** ====
PROMPT ===================================================================================== 


PROMPT *** Create  view V_TABLDEL ***

  CREATE OR REPLACE FORCE VIEW BARS.V_TABLDEL ("TABNAME", "SEMANTIC") AS 
  select m.tabname, m.semantic
from meta_tables m
where nvl(m.tabldel,0)<>0
  and m.tabname in
     (select table_name from all_tab_columns
      where owner='BARS' and column_name='DELETED')
 ;

PROMPT *** Create  grants  V_TABLDEL ***
grant SELECT                                                                 on V_TABLDEL       to ABS_ADMIN;
grant SELECT                                                                 on V_TABLDEL       to BARSREADER_ROLE;
grant SELECT                                                                 on V_TABLDEL       to BARS_ACCESS_DEFROLE;
grant SELECT                                                                 on V_TABLDEL       to UPLD;
grant DELETE,FLASHBACK,INSERT,SELECT,UPDATE                                  on V_TABLDEL       to WR_ALL_RIGHTS;



PROMPT ===================================================================================== 
PROMPT *** End *** ========== Scripts /Sql/BARS/View/V_TABLDEL.sql =========*** End *** ====
PROMPT ===================================================================================== 
