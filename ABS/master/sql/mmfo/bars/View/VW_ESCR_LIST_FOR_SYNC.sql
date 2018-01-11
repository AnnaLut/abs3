

PROMPT ===================================================================================== 
PROMPT *** Run *** ========== Scripts /Sql/BARS/View/VW_ESCR_LIST_FOR_SYNC.sql =========*** 
PROMPT ===================================================================================== 


PROMPT *** Create  view VW_ESCR_LIST_FOR_SYNC ***

  CREATE OR REPLACE FORCE VIEW BARS.VW_ESCR_LIST_FOR_SYNC ("DEAL_ID", "CREDIT_STATUS_ID", "STATE_ID", "KF", "COMMENT", "IS_SET") AS 
  SELECT d.nd deal_id
      ,to_number(t.txt)  credit_status_id,
      TO_NUMBER(NULL) AS state_id
      ,t.kf
      ,'' AS "COMMENT"
       ,'false' AS is_set
  FROM bars.cc_deal d, bars.nd_txt t, bars.escr_reg_status t1
 WHERE t.nd = d.nd
   AND t.tag = 'ES000'
   AND t.txt NOT IN (5, 8, 9, 12, 13, 15, 11,-999,16,10)
   AND t1.id = t.txt;

PROMPT *** Create  grants  VW_ESCR_LIST_FOR_SYNC ***
grant SELECT                                                                 on VW_ESCR_LIST_FOR_SYNC to BARSREADER_ROLE;
grant SELECT                                                                 on VW_ESCR_LIST_FOR_SYNC to BARS_ACCESS_DEFROLE;
grant SELECT                                                                 on VW_ESCR_LIST_FOR_SYNC to UPLD;



PROMPT ===================================================================================== 
PROMPT *** End *** ========== Scripts /Sql/BARS/View/VW_ESCR_LIST_FOR_SYNC.sql =========*** 
PROMPT ===================================================================================== 
