

PROMPT ===================================================================================== 
PROMPT *** Run *** ========== Scripts /Sql/BARS/View/V_VQB_META_TABLES.sql =========*** Run 
PROMPT ===================================================================================== 


PROMPT *** Create  view V_VQB_META_TABLES ***

  CREATE OR REPLACE FORCE VIEW BARS.V_VQB_META_TABLES ("TABID", "TABNAME", "SEMANTIC", "TABRELATION") AS 
  SELECT t.tabid, t.tabname, t.semantic, t.tabrelation
 FROM
  meta_tables t,
  (SELECT tabid, colid FROM meta_columns WHERE (semantic IS NOT NULL) ) c,
                VQB_VISIBILITY v,
                staff s
 WHERE (t.semantic IS NOT NULL) AND (t.tabid=c.tabid) AND
       (t.tabname=v.table_name) and
       (v.user_id=s.id) and
       (s.logname=USER)
 GROUP BY t.tabid, t.tabname, t.semantic, t.tabrelation
 HAVING COUNT(c.colid)>0;

PROMPT *** Create  grants  V_VQB_META_TABLES ***
grant SELECT                                                                 on V_VQB_META_TABLES to BARS_ACCESS_DEFROLE;
grant SELECT                                                                 on V_VQB_META_TABLES to START1;



PROMPT ===================================================================================== 
PROMPT *** End *** ========== Scripts /Sql/BARS/View/V_VQB_META_TABLES.sql =========*** End 
PROMPT ===================================================================================== 
