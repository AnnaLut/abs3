
 
 PROMPT ===================================================================================== 
 PROMPT *** Run *** ========== Scripts /Sql/BARS_DM/type/tr_cust_segment.sql =========*** Run
 PROMPT ===================================================================================== 
 
  CREATE OR REPLACE TYPE BARS_DM.TR_CUST_SEGMENT as object
                      (
                        per_id  number,
                        kf  varchar2(6),
                        rnk  number(15),
                        segment_act  varchar2(100),
                        segment_fin  varchar2(100),
                        segment_beh  varchar2(100),
                        social_vip  varchar2(100),
                        segment_trans  number(5),
                        product_amount  number(32,12),
                        deposit_ammount  number(32,12),
                        credits_ammount  number(32,12),
                        garantcredits_ammount  number(32,12),
                        cardcredits_ammount  number(32,12),
                        energycredits_ammount  number(32,12),
                        cards_ammount  number(32,12),
                        accounts_ammount  number(32,12),
                        lastchangedt  date
                      )
/

 show err;
 
 
 
 PROMPT ===================================================================================== 
 PROMPT *** End *** ========== Scripts /Sql/BARS_DM/type/tr_cust_segment.sql =========*** End
 PROMPT ===================================================================================== 
 