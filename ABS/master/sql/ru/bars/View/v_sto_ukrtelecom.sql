

PROMPT ===================================================================================== 
PROMPT *** Run *** ========== Scripts /Sql/BARS/View/V_STO_UKRTELECOM.sql =========*** Run *
PROMPT ===================================================================================== 


PROMPT *** Create  view V_STO_UKRTELECOM ***

  CREATE OR REPLACE FORCE VIEW BARS.V_STO_UKRTELECOM ("ID", "CUSTOMER_ID", "CUSTOMER_NMK", "PAYER_ACCOUNT", "CURRENCY_ID", "ORDER_KIND_ID", "ORDER_KIND_NAME", "REGULAR_AMOUNT", "STOP_DATE", "RECEIVER", "PAYMENT_DETAILS", "PRIORITY", "USER_NAME", "ORD_STATE", "REG_ORD_DATE", "ORD_STATE_NAME", "BRANCH", "SMSSEND") AS 
  SELECT "ID","CUSTOMER_ID","CUSTOMER_NMK","PAYER_ACCOUNT","CURRENCY_ID","ORDER_KIND_ID","ORDER_KIND_NAME","REGULAR_AMOUNT","STOP_DATE","RECEIVER","PAYMENT_DETAILS","PRIORITY","USER_NAME","ORD_STATE","REG_ORD_DATE","ORD_STATE_NAME","BRANCH","SMSSEND"
     FROM v_sto_order
    WHERE id IN (SELECT t2.id
                   FROM STO_SBON_PRODUCT t1, sto_order t2
                  WHERE     t1.receiver_edrpou IN ('21560766',
                                                   '1189910',
                                                   '1184901',
                                                   '1182204',
                                                   '1184114',
                                                   '1189425',
                                                   '1181877',
                                                   '1186030',
                                                   '23251963',
                                                   '1187526',
                                                   '1188052',
                                                   '1182500',
                                                   '1184835',
                                                   '25438186',
                                                   '22838086',
                                                   '25614660',
                                                   '23825401',
                                                   '1186975',
                                                   '25543196',
                                                   '22211233',
                                                   '1184385',
                                                   '1186691',
                                                   '22437619',
                                                   '1188661',
                                                   '26549551',
                                                   '33685988')
                        AND T1.ID = T2.product_id)
   UNION ALL
   SELECT "ID","CUSTOMER_ID","CUSTOMER_NMK","PAYER_ACCOUNT","CURRENCY_ID","ORDER_KIND_ID","ORDER_KIND_NAME","REGULAR_AMOUNT","STOP_DATE","RECEIVER","PAYMENT_DETAILS","PRIORITY","USER_NAME","ORD_STATE","REG_ORD_DATE","ORD_STATE_NAME","BRANCH","SMSSEND"
     FROM v_sto_order
    WHERE id IN (SELECT t1.id
                   FROM STO_SBON_ORDER_FREE t1, sto_order t2
                  WHERE     t1.receiver_edrpou IN ('21560766',
                                                   '1189910',
                                                   '1184901',
                                                   '1182204',
                                                   '1184114',
                                                   '1189425',
                                                   '1181877',
                                                   '1186030',
                                                   '23251963',
                                                   '1187526',
                                                   '1188052',
                                                   '1182500',
                                                   '1184835',
                                                   '25438186',
                                                   '22838086',
                                                   '25614660',
                                                   '23825401',
                                                   '1186975',
                                                   '25543196',
                                                   '22211233',
                                                   '1184385',
                                                   '1186691',
                                                   '22437619',
                                                   '1188661',
                                                   '26549551',
                                                   '33685988')
                        AND T1.ID = T2.id);

PROMPT *** Create  grants  V_STO_UKRTELECOM ***
grant SELECT                                                                 on V_STO_UKRTELECOM to BARS_ACCESS_DEFROLE;



PROMPT ===================================================================================== 
PROMPT *** End *** ========== Scripts /Sql/BARS/View/V_STO_UKRTELECOM.sql =========*** End *
PROMPT ===================================================================================== 
