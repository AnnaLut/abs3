CREATE OR REPLACE FORCE VIEW BARS.V_FOREX_DEAL_DOCUMENTS
(
   REF,
   TT,
   USERID,
   ND,
   NLSA,
   S,
   KV,
   PDAT,
   S2,
   KV2,
   MFOB,
   NLSB,
   DK,
   DATD,
   NAZN,
   BRANCH,
   ID_A,
   NAM_A,
   ID_B,
   NAM_B,
   DEAL_TAG,
   SOS
)
AS
     SELECT o.REF,
            o.tt,
            o.userid,
            o.nd,
            o.nlsa,
            o.s/100,
            o.kv,
            o.pdat,
            o.s2/100,
            o.kv2,
            o.mfob,
            o.nlsb,
            o.dk,
            o.datd,
            o.nazn,
            o.branch,
            o.id_a,
            o.nam_a,
            o.id_b,
            o.nam_b,
            fx.deal_tag,
            o.sos
       FROM oper o JOIN fx_deal_ref fx ON o.REF = fx.REF
   ORDER BY REF DESC;

COMMENT ON TABLE BARS.V_FOREX_DEAL_DOCUMENTS IS 'FOREX: Документи по угоді';
COMMENT ON COLUMN BARS.V_FOREX_DEAL_DOCUMENTS.REF IS 'Референс';
COMMENT ON COLUMN BARS.V_FOREX_DEAL_DOCUMENTS.TT IS 'Код операції';
COMMENT ON COLUMN BARS.V_FOREX_DEAL_DOCUMENTS.USERID IS 'Ід. Користувача';
COMMENT ON COLUMN BARS.V_FOREX_DEAL_DOCUMENTS.ND IS 'Номер~документу';
COMMENT ON COLUMN BARS.V_FOREX_DEAL_DOCUMENTS.NLSA IS 'Рахунок-А';
COMMENT ON COLUMN BARS.V_FOREX_DEAL_DOCUMENTS.S IS 'Сума';
COMMENT ON COLUMN BARS.V_FOREX_DEAL_DOCUMENTS.KV IS 'Код валюти';
COMMENT ON COLUMN BARS.V_FOREX_DEAL_DOCUMENTS.PDAT IS 'Дата~валютування';
COMMENT ON COLUMN BARS.V_FOREX_DEAL_DOCUMENTS.S2 IS 'Сума по~валюті В';
COMMENT ON COLUMN BARS.V_FOREX_DEAL_DOCUMENTS.KV2 IS 'Код~валюти В';
COMMENT ON COLUMN BARS.V_FOREX_DEAL_DOCUMENTS.MFOB IS 'МФО-В';
COMMENT ON COLUMN BARS.V_FOREX_DEAL_DOCUMENTS.NLSB IS 'Рахунок-В';
COMMENT ON COLUMN BARS.V_FOREX_DEAL_DOCUMENTS.DK IS 'Дб~Кр';
COMMENT ON COLUMN BARS.V_FOREX_DEAL_DOCUMENTS.DATD IS 'Дата~документа';
COMMENT ON COLUMN BARS.V_FOREX_DEAL_DOCUMENTS.NAZN IS 'Призначення платежу';
COMMENT ON COLUMN BARS.V_FOREX_DEAL_DOCUMENTS.BRANCH IS 'Код відділення';
COMMENT ON COLUMN BARS.V_FOREX_DEAL_DOCUMENTS.ID_A IS 'ЗКПО-А';
COMMENT ON COLUMN BARS.V_FOREX_DEAL_DOCUMENTS.NAM_A IS 'Відправник';
COMMENT ON COLUMN BARS.V_FOREX_DEAL_DOCUMENTS.ID_B IS 'ЗКПО-Б';
COMMENT ON COLUMN BARS.V_FOREX_DEAL_DOCUMENTS.NAM_B IS 'Отримувач';
COMMENT ON COLUMN BARS.V_FOREX_DEAL_DOCUMENTS.DEAL_TAG IS 'Номер угоди';
COMMENT ON COLUMN BARS.V_FOREX_DEAL_DOCUMENTS.SOS IS 'Стан документу';

GRANT SELECT ON BARS.V_FOREX_DEAL_DOCUMENTS TO BARS_ACCESS_DEFROLE;
