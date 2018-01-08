

PROMPT ===================================================================================== 
PROMPT *** Run *** ========== Scripts /Sql/BARS/View/VW_ESCR_ERRORS.sql =========*** Run ***
PROMPT ===================================================================================== 


PROMPT *** Create  view VW_ESCR_ERRORS ***

  CREATE OR REPLACE FORCE VIEW BARS.VW_ESCR_ERRORS ("DEAL_NUMB", "TAG_VALUE", "TAG_NAME", "MFO", "CUSTOMER_ID", "BRANCH", "ERR_TYPE_CODE", "ERR_TYPE") AS 
  (
SELECT t.nd deal_numb
      ,t.txt tag_value
      ,ct.name tag_name
      ,t.kf mfo
      ,cc.rnk customer_id
      ,cc.branch branch
      ,'EVENTS' AS err_type_code
      ,'Помилка в заході' AS err_type
  FROM nd_txt t, cc_tag ct, cc_deal cc
 WHERE cc.nd = t.nd
   AND ct.tag = t.tag
   AND t.txt NOT IN (SELECT to_char(ev.id) FROM escr_events ev)
   AND t.tag IN ('ES104'
                ,'ES110'
                ,'ES116'
                ,'ES122'
                ,'ES128'
                ,'ES134'
                ,'ES140'
                ,'ES146'
                ,'ES152'
                ,'ES158'
                ,'ES164'
                ,'ES170'
                ,'ES176'
                ,'ES182'
                ,'ES188'
                ,'ES194'
                ,'ES200'
                ,'ES206'
                ,'ES212'
                ,'ES218'
                ,'ES242'
                ,'ES248'
                ,'ES254'
                ,'ES260'
                ,'ES266'
                ,'ES272'
                ,'ES278'
                ,'ES284'
                ,'ES290'
                ,'ES296'
                ,'ES302'
                ,'ES308'
                ,'ES314'
                ,'ES320'
                ,'ES326'
                ,'ES332'
                ,'ES338'
                ,'ES344'
                ,'ES350'
                ,'ES356'
                ,'ES380'
                ,'ES386'
                ,'ES392'
                ,'ES398'
                ,'ES404'
                ,'ES410'
                ,'ES416'
                ,'ES422'
                ,'ES428'
                ,'ES434'
                ,'ES440'
                ,'ES446'
                ,'ES452'
                ,'ES458'
                ,'ES464'
                ,'ES470'
                ,'ES476'
                ,'ES482'
                ,'ES488'
                ,'ES494')
UNION ALL
SELECT t.nd deal_numb
      ,t.txt tag_value
      ,ct.name tag_name
      ,t.kf mfo
      ,cc.rnk customer_id
      ,cc.branch branch
      ,'GOOD_COST' AS err_type_code
      ,'Некоректно заповнено вартість товару' AS err_type
  FROM nd_txt t, cc_tag ct, cc_deal cc
 WHERE cc.nd = t.nd
   AND ct.tag = t.tag
   AND NOT regexp_like(t.txt, '^(\d+)([.]?)(\d*)$')
   AND t.tag = 'ES001'
UNION ALL
SELECT t.nd deal_numb
      ,t.txt tag_value
      ,ct.name tag_name
      ,t.kf mfo
      ,cc.rnk customer_id
      ,cc.branch branch
      ,'DOCS_DATE' AS err_type_code
      ,'Некоректно заповнено параметр ''Дата передачі документу до банку про цільове викор''' AS err_type
  FROM nd_txt t, cc_tag ct, cc_deal cc
 WHERE cc.nd = t.nd
   AND ct.tag = t.tag
   AND f_date_check(t.txt) = 1
   AND t.tag = 'ES002'
UNION ALL
SELECT cc.nd deal_numb
      ,cw.value tag_value
      ,cf.name tag_name
      ,cc.kf mfo
      ,cw.rnk customer_id
      ,cc.branch branch
      ,'DOCS_DATE' AS err_type_code
      ,'Некоректна дата субсидії' AS err_type
  FROM customerw cw, customer_field cf, cc_deal cc
 WHERE cw.rnk = cc.rnk
   AND cw.tag = cf.tag
   AND cw.tag = 'SUBSD'
   AND f_date_check(cw.value) = 1);

PROMPT *** Create  grants  VW_ESCR_ERRORS ***
grant SELECT                                                                 on VW_ESCR_ERRORS  to BARS_ACCESS_DEFROLE;



PROMPT ===================================================================================== 
PROMPT *** End *** ========== Scripts /Sql/BARS/View/VW_ESCR_ERRORS.sql =========*** End ***
PROMPT ===================================================================================== 
