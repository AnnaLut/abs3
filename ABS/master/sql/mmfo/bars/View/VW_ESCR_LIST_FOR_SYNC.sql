CREATE OR REPLACE VIEW VW_ESCR_LIST_FOR_SYNC AS
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
