

PROMPT ===================================================================================== 
PROMPT *** Run *** ========== Scripts /Sql/BARS/View/V_CUSTOMER_SEGMENTS3.sql =========*** R
PROMPT ===================================================================================== 


PROMPT *** Create  view V_CUSTOMER_SEGMENTS3 ***

  CREATE OR REPLACE FORCE VIEW BARS.V_CUSTOMER_SEGMENTS3 ("RNK", "CUSTOMER_SEGMENT_ACTIVITY", "CSA_DATE_START", "CSA_DATE_STOP", "CUSTOMER_SEGMENT_FINANCIAL", "CSF_DATE_START", "CSF_DATE_STOP", "CUSTOMER_SEGMENT_BEHAVIOR", "CSB_DATE_START", "CSB_DATE_STOP", "CUSTOMER_SEGMENT_PROD_AMNT", "CSP_DATE_START", "CSP_DATE_STOP", "CUSTOMER_SEGMENT_TRAN", "CST_DATE_START", "CST_DATE_STOP") AS 
  with attribute_kinds as (select attribute_utl.get_attribute_id('CUSTOMER_SEGMENT_ACTIVITY') activity_segment_id,
                                attribute_utl.get_attribute_id('CUSTOMER_SEGMENT_FINANCIAL') financial_segment_id,
                                attribute_utl.get_attribute_id('CUSTOMER_SEGMENT_BEHAVIOR') behavior_segment_id,
                                attribute_utl.get_attribute_id('CUSTOMER_SEGMENT_PRODUCTS_AMNT') prod_amount_segment_id,
                                attribute_utl.get_attribute_id('CUSTOMER_SEGMENT_TRANSACTIONS') transactional_segment_id

                         from   dual)
select /*+ leading(t1)*/ t.RNK,
       csact.number_value customer_segment_activity,
       csact.date_from csa_date_start,
       csact.date_through csa_date_stop,
       csfin.number_value customer_segment_financial,
       csfin.date_from csf_date_start,
       csfin.date_through csf_date_stop,
       csbeh.number_value customer_segment_behavior,
       csbeh.date_from csb_date_start,
       csbeh.date_through csb_date_stop,
       csprod.number_value customer_segment_prod_amnt,
       csprod.date_from csp_date_start,
       csprod.date_through csp_date_stop,
       cstran.number_value customer_segment_tran,
       cstran.date_from cst_date_start,
       cstran.date_through cst_date_stop

from   customer t
cross join attribute_kinds k
cross join table(saldo_utl.pipe_attribute_value_by_date(k.activity_segment_id, t.rnk, gl.bd())) csact
cross join table(saldo_utl.pipe_attribute_value_by_date(k.financial_segment_id, t.rnk, gl.bd())) csfin
cross join table(saldo_utl.pipe_attribute_value_by_date(k.behavior_segment_id, t.rnk, gl.bd())) csbeh
cross join table(saldo_utl.pipe_attribute_value_by_date(k.prod_amount_segment_id, t.rnk, gl.bd())) csprod
cross join table(saldo_utl.pipe_attribute_value_by_date(k.transactional_segment_id, t.rnk, gl.bd())) cstran

left join vip_flags f on f.rnk = t.rnk
left join customerw w on w.rnk = t.rnk and w.tag = 'VIP_K'
;

PROMPT *** Create  grants  V_CUSTOMER_SEGMENTS3 ***
grant SELECT                                                                 on V_CUSTOMER_SEGMENTS3 to UPLD;



PROMPT ===================================================================================== 
PROMPT *** End *** ========== Scripts /Sql/BARS/View/V_CUSTOMER_SEGMENTS3.sql =========*** E
PROMPT ===================================================================================== 
