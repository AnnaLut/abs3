
 
 PROMPT ===================================================================================== 
 PROMPT *** Run *** ========== Scripts /Sql/BARS/type/object_deal_info.sql =========*** Run *
 PROMPT ===================================================================================== 
 
  CREATE OR REPLACE TYPE BARS.OBJECT_DEAL_INFO AS OBJECT
(
  deal_id  NUMBER  ,
  deal_date_from  DATE,
  doc_date DATE,
  avr_DATE DATE ,
  REG_KIND NUMBER
)
/

 show err;
 
PROMPT *** Create  grants  OBJECT_DEAL_INFO ***
grant EXECUTE                                                                on OBJECT_DEAL_INFO to BARS_ACCESS_DEFROLE;

 
 
 PROMPT ===================================================================================== 
 PROMPT *** End *** ========== Scripts /Sql/BARS/type/object_deal_info.sql =========*** End *
 PROMPT ===================================================================================== 
 