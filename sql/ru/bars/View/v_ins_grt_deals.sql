PROMPT ===================================================================================== 
PROMPT *** Run *** ========== Scripts /Sql/BARS/View/V_INS_GRT_DEALS.sql =========*** Run **
PROMPT ===================================================================================== 


PROMPT *** Create  view V_INS_GRT_DEALS ***


CREATE OR REPLACE FORCE VIEW BARS.V_INS_GRT_DEALS
(
   DEAL_ID,
   TYPE_ID,
   TYPE_NAME,
   DEAL_NUM,
   DEAL_DATE,
   GRT_NAME,
   DEAL_RNK,
   CTYPE,
   FIO,
   INN,
   DOC_SER,
   DOC_NUM,
   DOC_ISSUER,
   DOC_DATE
)
AS
SELECT d.deal_id,
       d.grt_type_id AS type_id,
       t.type_name,
       d.deal_num,
       d.deal_date,
       d.grt_name,
       d.deal_rnk,
       c.custtype AS ctype,
       c.nmk AS fio,
       c.okpo AS inn,
       p.ser AS doc_ser,
       p.numdoc AS doc_num,
       p.organ AS doc_issuer,
       p.pdate AS doc_date
  FROM grt_deals d,
       grt_types t,
       grt_groups g,
       customer c,
       person p
 WHERE     d.grt_type_id = t.type_id
       AND t.GROUP_ID = g.GROUP_ID
       AND d.deal_rnk = c.rnk
       AND d.deal_rnk = p.rnk
UNION ALL
  SELECT a.acc AS deal_id,
         SZ.PAWN AS type_id,
         ccp.name AS type_name,
         TO_CHAR (n.nd) AS deal_num,
         SZ.sdatz AS deal_date,
         TO_CHAR (NULL) AS grt_name,
         C.rnk AS deal_rnk,
         C.CUSTTYPE AS ctype,
         C.nmk AS fio,
         c.okpo AS inn,
         pp.ser AS doc_ser,
         pp.numdoc AS doc_num,
         PP.ORGAN AS doc_issuer,
         PP.PDATE AS doc_date
    FROM accounts A,
         tabval T,
         customer C,
         pawn_acc SZ,
         nd_acc n,
         cc_accp p,
         cc_pawn ccp,
         person pp
   WHERE     A.acc = SZ.acc(+)
         AND sz.pawn = CCP.pawn(+)
         AND c.rnk = pp.rnk
         AND a.rnk = C.rnk
         AND A.kv = T.kv
         AND A.acc = P.acc
         --AND n.nd = 37145418
         AND p.accs = n.acc
GROUP BY a.acc,
         sz.pawn,
         ccp.name,
         n.nd,
         sz.sdatz,
         c.rnk,
         c.custtype,
         c.nmk,
         c.okpo,
         pp.ser,
         pp.numdoc,
         pp.organ,
         pp.pdate;


COMMENT ON TABLE BARS.V_INS_GRT_DEALS IS 'Дані забезпечення для страховок (Представлення)';

COMMENT ON COLUMN BARS.V_INS_GRT_DEALS.DEAL_ID IS 'Код договору';

COMMENT ON COLUMN BARS.V_INS_GRT_DEALS.TYPE_ID IS 'Код типу договору';

COMMENT ON COLUMN BARS.V_INS_GRT_DEALS.TYPE_NAME IS 'Тип забезпечення';

COMMENT ON COLUMN BARS.V_INS_GRT_DEALS.DEAL_NUM IS 'Номер договору забезпечення';

COMMENT ON COLUMN BARS.V_INS_GRT_DEALS.DEAL_DATE IS 'Дата договору забезпечення';

COMMENT ON COLUMN BARS.V_INS_GRT_DEALS.GRT_NAME IS 'Повна назва забезпечення';

COMMENT ON COLUMN BARS.V_INS_GRT_DEALS.DEAL_RNK IS 'Код клієнта (RNK)';

COMMENT ON COLUMN BARS.V_INS_GRT_DEALS.CTYPE IS 'Тип клієнта (2-юр.особа/3-фіз.особа)';

COMMENT ON COLUMN BARS.V_INS_GRT_DEALS.FIO IS 'ПІБ клієнта';

COMMENT ON COLUMN BARS.V_INS_GRT_DEALS.INN IS 'Ідентифікаційний номер';

COMMENT ON COLUMN BARS.V_INS_GRT_DEALS.DOC_SER IS 'Документ - серія';

COMMENT ON COLUMN BARS.V_INS_GRT_DEALS.DOC_NUM IS 'Документ - номер';

COMMENT ON COLUMN BARS.V_INS_GRT_DEALS.DOC_ISSUER IS 'Документ - місце видачі';

COMMENT ON COLUMN BARS.V_INS_GRT_DEALS.DOC_DATE IS 'Документ - дата видачі';



GRANT SELECT ON BARS.V_INS_GRT_DEALS TO BARS_ACCESS_DEFROLE;


PROMPT ===================================================================================== 
PROMPT *** End *** ========== Scripts /Sql/BARS/View/V_INS_GRT_DEALS.sql =========*** End **
PROMPT ===================================================================================== 
