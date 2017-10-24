

PROMPT ===================================================================================== 
PROMPT *** Run *** ========== Scripts /Sql/BARS/View/V_META_TABLES.sql =========*** Run *** 
PROMPT ===================================================================================== 


PROMPT *** Create  view V_META_TABLES ***

  CREATE OR REPLACE FORCE VIEW BARS.V_META_TABLES ("TABID", "TABNAME", "TABSEMANTIC", "COLID", "COLNAME", "COLSEMANTIC") AS 
  select t.tabid, t.tabname, t.semantic tabsemantic,
       c.colid, c.colname, c.semantic colsemantic
from meta_tables t, meta_columns c
where t.tabid=c.tabid
 ;

PROMPT *** Create  grants  V_META_TABLES ***
grant DELETE,FLASHBACK,INSERT,SELECT,UPDATE                                  on V_META_TABLES   to WR_ALL_RIGHTS;



PROMPT ===================================================================================== 
PROMPT *** End *** ========== Scripts /Sql/BARS/View/V_META_TABLES.sql =========*** End *** 
PROMPT ===================================================================================== 
