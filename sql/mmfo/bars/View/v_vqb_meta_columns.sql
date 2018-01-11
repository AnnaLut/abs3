

PROMPT ===================================================================================== 
PROMPT *** Run *** ========== Scripts /Sql/BARS/View/V_VQB_META_COLUMNS.sql =========*** Run
PROMPT ===================================================================================== 


PROMPT *** Create  view V_VQB_META_COLUMNS ***

  CREATE OR REPLACE FORCE VIEW BARS.V_VQB_META_COLUMNS ("TABID", "COLID", "COLNAME", "COLTYPE", "SEMANTIC", "TYPENAME") AS 
  SELECT c.tabid, c.colid, c.colname, c.coltype, c.semantic, t.typename
    FROM
        meta_columns c,
        meta_coltypes t
    WHERE (c.coltype=t.coltype) AND (c.semantic IS NOT NULL);

PROMPT *** Create  grants  V_VQB_META_COLUMNS ***
grant SELECT                                                                 on V_VQB_META_COLUMNS to BARSREADER_ROLE;
grant SELECT                                                                 on V_VQB_META_COLUMNS to BARS_ACCESS_DEFROLE;
grant SELECT                                                                 on V_VQB_META_COLUMNS to START1;
grant SELECT                                                                 on V_VQB_META_COLUMNS to UPLD;



PROMPT ===================================================================================== 
PROMPT *** End *** ========== Scripts /Sql/BARS/View/V_VQB_META_COLUMNS.sql =========*** End
PROMPT ===================================================================================== 
