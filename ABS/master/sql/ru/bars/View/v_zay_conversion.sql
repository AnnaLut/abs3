

PROMPT ===================================================================================== 
PROMPT *** Run *** ========== Scripts /Sql/BARS/View/V_ZAY_CONVERSION.sql =========*** Run *
PROMPT ===================================================================================== 


PROMPT *** Create  view V_ZAY_CONVERSION ***

  CREATE OR REPLACE FORCE VIEW BARS.V_ZAY_CONVERSION ("DOC_ID", "CUST_ID", "PAYER_ACCOUNT", "PAYER_CURRENCY", "PAYER_BANK_CODE", "PAYEE_ACCOUNT", "PAYEE_CURRENCY", "PAYEE_BANK_CODE", "PURCHASING_CUR_RATE", "PURCHASING_REASON", "PURCHASING_COMISS", "DOC_SUM", "DOC_NUMBER", "DOC_DATE", "DOC_DESC", "BRANCH") AS 
  SELECT e.doc_id,
          a.rnk,
          SUBSTR (
             get_doc_xml (e.doc_id).EXTRACT (
                '/SIGNED_DOCUMENT/DOCUMENT/ATTRIBUTES/ATTRIBUTE[@ATTR_ID="PAYER_ACCOUNT"]/text()').getstringval (),
             1,
             15),
          SUBSTR (
             get_doc_xml (e.doc_id).EXTRACT (
                '/SIGNED_DOCUMENT/DOCUMENT/ATTRIBUTES/ATTRIBUTE[@ATTR_ID="PAYER_CURRENCY"]/text()').getstringval (),
             1,
             3),
          SUBSTR (
             get_doc_xml (e.doc_id).EXTRACT (
                '/SIGNED_DOCUMENT/DOCUMENT/ATTRIBUTES/ATTRIBUTE[@ATTR_ID="PAYER_BANK_CODE"]/text()').getstringval (),
             1,
             6),
          SUBSTR (
             get_doc_xml (e.doc_id).EXTRACT (
                '/SIGNED_DOCUMENT/DOCUMENT/ATTRIBUTES/ATTRIBUTE[@ATTR_ID="PAYEE_ACCOUNT"]/text()').getstringval (),
             1,
             15),
          SUBSTR (
             get_doc_xml (e.doc_id).EXTRACT (
                '/SIGNED_DOCUMENT/DOCUMENT/ATTRIBUTES/ATTRIBUTE[@ATTR_ID="PAYEE_CURRENCY"]/text()').getstringval (),
             1,
             3),
          SUBSTR (
             get_doc_xml (e.doc_id).EXTRACT (
                '/SIGNED_DOCUMENT/DOCUMENT/ATTRIBUTES/ATTRIBUTE[@ATTR_ID="PAYEE_BANK_CODE"]/text()').getstringval (),
             1,
             6),
          SUBSTR (
             get_doc_xml (e.doc_id).EXTRACT (
                '/SIGNED_DOCUMENT/DOCUMENT/ATTRIBUTES/ATTRIBUTE[@ATTR_ID="PURCHASING_CUR_RATE"]/text()').getstringval (),
             1,
             38),
          SUBSTR (
             get_doc_xml (e.doc_id).EXTRACT (
                '/SIGNED_DOCUMENT/DOCUMENT/ATTRIBUTES/ATTRIBUTE[@ATTR_ID="PURCHASING_REASON"]/text()').getstringval (),
             1,
             200),
          SUBSTR (
             get_doc_xml (e.doc_id).EXTRACT (
                '/SIGNED_DOCUMENT/DOCUMENT/ATTRIBUTES/ATTRIBUTE[@ATTR_ID="CURREXCH_FEE"]/text()').getstringval (),
             1,
             38),
          SUBSTR (
             get_doc_xml (e.doc_id).EXTRACT (
                '/SIGNED_DOCUMENT/DOCUMENT/ATTRIBUTES/ATTRIBUTE[@ATTR_ID="DOC_SUM"]/text()').getstringval (),
             1,
             38),
          SUBSTR (
             get_doc_xml (e.doc_id).EXTRACT (
                '/SIGNED_DOCUMENT/DOCUMENT/ATTRIBUTES/ATTRIBUTE[@ATTR_ID="DOC_NUMBER"]/text()').getstringval (),
             1,
             10),
          TO_DATE (
             SUBSTR (
                get_doc_xml (e.doc_id).EXTRACT (
                   '/SIGNED_DOCUMENT/DOCUMENT/ATTRIBUTES/ATTRIBUTE[@ATTR_ID="DOC_DATE"]/text()').getstringval (),
                1,
                10),
             'yyyy/mm/dd'),
          doc_desc,
          C.BRANCH
     FROM barsaq.doc_export e, barsaq.v_kf_accounts a, bars.customer c
    WHERE     e.type_id = 'I_CUREXCH'
          AND get_doc_xml (e.doc_id).EXTRACT (
                 '/SIGNED_DOCUMENT/DOCUMENT/ATTRIBUTES/ATTRIBUTE[@ATTR_ID="BUY_SELL_FLAG"]/text()').getstringval () =
                 '3'
          AND get_doc_xml (e.doc_id).EXTRACT (
                 '/SIGNED_DOCUMENT/DOCUMENT/ATTRIBUTES/ATTRIBUTE[@ATTR_ID="PAYER_BANK_CODE"]/text()').getstringval () =
                 a.kf
          AND get_doc_xml (e.doc_id).EXTRACT (
                 '/SIGNED_DOCUMENT/DOCUMENT/ATTRIBUTES/ATTRIBUTE[@ATTR_ID="PAYER_ACCOUNT"]/text()').getstringval () =
                 a.nls
          AND get_doc_xml (e.doc_id).EXTRACT (
                 '/SIGNED_DOCUMENT/DOCUMENT/ATTRIBUTES/ATTRIBUTE[@ATTR_ID="PAYER_CURRENCY"]/text()').getstringval () =
                 a.kv
          AND a.rnk = c.rnk;

PROMPT *** Create  grants  V_ZAY_CONVERSION ***
grant SELECT                                                                 on V_ZAY_CONVERSION to BARS_ACCESS_DEFROLE;
grant SELECT                                                                 on V_ZAY_CONVERSION to ZAY;



PROMPT ===================================================================================== 
PROMPT *** End *** ========== Scripts /Sql/BARS/View/V_ZAY_CONVERSION.sql =========*** End *
PROMPT ===================================================================================== 
