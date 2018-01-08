

PROMPT ===================================================================================== 
PROMPT *** Run *** ========== Scripts /Sql/BARS/View/V_CM_REQUEST.sql =========*** Run *** =
PROMPT ===================================================================================== 


PROMPT *** Create  view V_CM_REQUEST ***

  CREATE OR REPLACE FORCE VIEW BARS.V_CM_REQUEST ("ID", "DATEIN", "DATEMOD", "OPER_STATUS", "OPERSTATUS_NAME", "OPER_TYPE", "OPERTYPE_NAME", "RESP_TXT", "BRANCH", "CLIENTTYPE", "RNK", "OKPO", "NAME", "ACC", "NLS", "CARD_TIP", "PRODUCT_CODE", "CARD_CODE") AS 
  SELECT v.id,
          trunc (v.datein) DATEIN,
          v.datemod,
          v.oper_status,
          s.name operstatus_name,
          v.oper_type,
          o.name opertypename,
          v.resp_txt,
          v.branch,
          v.clienttype,
          v.rnk,
          v.taxpayeridentifier,
          DECODE (
             SUBSTR (regnumberclient, -8),
             '00000000', 'Instant',
             DECODE (v.clienttype,
                     1, v.companyname,
                     v.lastname || ' ' || v.firstname || ' ' || v.middlename))
             name,
          v.acc,
          v.contractnumber,
          DECODE (a.tip, 'W4V', 'LC', 'W4'),
          v.productcode,
          v.card_type
     FROM v_cm_client v,
          cm_opertype o,
          cm_operstatus s,
          accounts a
    WHERE     v.oper_type = o.id
          AND v.oper_status = s.id                    -- необработанные заявки
          AND (v.arc = 0                       -- обработанные принятые заявки
                        OR v.arc = 1 AND oper_status = 3)
          AND v.acc = a.acc
          order by 2 desc
--   and a.branch like sys_context('bars_context','user_branch_mask');

PROMPT *** Create  grants  V_CM_REQUEST ***
grant SELECT                                                                 on V_CM_REQUEST    to BARSREADER_ROLE;
grant SELECT                                                                 on V_CM_REQUEST    to BARS_ACCESS_DEFROLE;
grant SELECT                                                                 on V_CM_REQUEST    to OW;
grant SELECT                                                                 on V_CM_REQUEST    to UPLD;



PROMPT ===================================================================================== 
PROMPT *** End *** ========== Scripts /Sql/BARS/View/V_CM_REQUEST.sql =========*** End *** =
PROMPT ===================================================================================== 
