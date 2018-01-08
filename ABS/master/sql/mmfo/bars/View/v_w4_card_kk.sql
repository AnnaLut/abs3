

PROMPT ===================================================================================== 
PROMPT *** Run *** ========== Scripts /Sql/BARS/View/V_W4_CARD_KK.sql =========*** Run *** =
PROMPT ===================================================================================== 


PROMPT *** Create  view V_W4_CARD_KK ***

  CREATE OR REPLACE FORCE VIEW BARS.V_W4_CARD_KK ("CODE", "PRODUCT_CODE", "SUB_CODE", "SUB_NAME") AS 
  select c.code,  c.product_code,   c.sub_code,   s.name
    from w4_card c, w4_subproduct s
where     c.sub_code = s.code
      and s.flag_kk = 1
      and nvl (c.date_open, bankdate) <= bankdate
      and nvl (c.date_close, bankdate + 1) > bankdate;

PROMPT *** Create  grants  V_W4_CARD_KK ***
grant SELECT                                                                 on V_W4_CARD_KK    to BARS_ACCESS_DEFROLE;
grant SELECT                                                                 on V_W4_CARD_KK    to OW;



PROMPT ===================================================================================== 
PROMPT *** End *** ========== Scripts /Sql/BARS/View/V_W4_CARD_KK.sql =========*** End *** =
PROMPT ===================================================================================== 
