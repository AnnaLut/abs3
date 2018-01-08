

PROMPT ===================================================================================== 
PROMPT *** Run *** ========== Scripts /Sql/BARS/View/CHECK_04.sql =========*** Run *** =====
PROMPT ===================================================================================== 


PROMPT *** Create  view CHECK_04 ***

  CREATE OR REPLACE FORCE VIEW BARS.CHECK_04 ("RECID", "ODATE", "NLS", "KV", "CODCAGENT", "INTS", "S180", "K081", "K092", "DOS", "KOS") AS 
  select "RECID","ODATE","NLS","KV","CODCAGENT","INTS","S180","K081","K092","DOS","KOS" from rnbu_history;

PROMPT *** Create  grants  CHECK_04 ***
grant SELECT                                                                 on CHECK_04        to BARSREADER_ROLE;
grant SELECT                                                                 on CHECK_04        to BARS_ACCESS_DEFROLE;
grant SELECT                                                                 on CHECK_04        to START1;
grant SELECT                                                                 on CHECK_04        to UPLD;



PROMPT ===================================================================================== 
PROMPT *** End *** ========== Scripts /Sql/BARS/View/CHECK_04.sql =========*** End *** =====
PROMPT ===================================================================================== 
