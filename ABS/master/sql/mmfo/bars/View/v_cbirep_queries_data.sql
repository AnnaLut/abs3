

PROMPT ===================================================================================== 
PROMPT *** Run *** ========== Scripts /Sql/BARS/View/V_CBIREP_QUERIES_DATA.sql =========*** 
PROMPT ===================================================================================== 


PROMPT *** Create  view V_CBIREP_QUERIES_DATA ***

  CREATE OR REPLACE FORCE VIEW BARS.V_CBIREP_QUERIES_DATA ("QUERIES_ID", "FILE_DATA", "FILE_TYPE") AS 
  SELECT "QUERIES_ID", "FILE_DATA", "FILE_TYPE" FROM CBIREP_QUERIES_DATA;

PROMPT *** Create  grants  V_CBIREP_QUERIES_DATA ***
grant DELETE,INSERT,SELECT,UPDATE                                            on V_CBIREP_QUERIES_DATA to BARS_ACCESS_DEFROLE;



PROMPT ===================================================================================== 
PROMPT *** End *** ========== Scripts /Sql/BARS/View/V_CBIREP_QUERIES_DATA.sql =========*** 
PROMPT ===================================================================================== 
