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

COMMENT ON TABLE BARS.V_FOREX_DEAL_DOCUMENTS IS 'FOREX: ��������� �� ����';
COMMENT ON COLUMN BARS.V_FOREX_DEAL_DOCUMENTS.REF IS '��������';
COMMENT ON COLUMN BARS.V_FOREX_DEAL_DOCUMENTS.TT IS '��� ��������';
COMMENT ON COLUMN BARS.V_FOREX_DEAL_DOCUMENTS.USERID IS '��. �����������';
COMMENT ON COLUMN BARS.V_FOREX_DEAL_DOCUMENTS.ND IS '�����~���������';
COMMENT ON COLUMN BARS.V_FOREX_DEAL_DOCUMENTS.NLSA IS '�������-�';
COMMENT ON COLUMN BARS.V_FOREX_DEAL_DOCUMENTS.S IS '����';
COMMENT ON COLUMN BARS.V_FOREX_DEAL_DOCUMENTS.KV IS '��� ������';
COMMENT ON COLUMN BARS.V_FOREX_DEAL_DOCUMENTS.PDAT IS '����~�����������';
COMMENT ON COLUMN BARS.V_FOREX_DEAL_DOCUMENTS.S2 IS '���� ��~����� �';
COMMENT ON COLUMN BARS.V_FOREX_DEAL_DOCUMENTS.KV2 IS '���~������ �';
COMMENT ON COLUMN BARS.V_FOREX_DEAL_DOCUMENTS.MFOB IS '���-�';
COMMENT ON COLUMN BARS.V_FOREX_DEAL_DOCUMENTS.NLSB IS '�������-�';
COMMENT ON COLUMN BARS.V_FOREX_DEAL_DOCUMENTS.DK IS '��~��';
COMMENT ON COLUMN BARS.V_FOREX_DEAL_DOCUMENTS.DATD IS '����~���������';
COMMENT ON COLUMN BARS.V_FOREX_DEAL_DOCUMENTS.NAZN IS '����������� �������';
COMMENT ON COLUMN BARS.V_FOREX_DEAL_DOCUMENTS.BRANCH IS '��� ��������';
COMMENT ON COLUMN BARS.V_FOREX_DEAL_DOCUMENTS.ID_A IS '����-�';
COMMENT ON COLUMN BARS.V_FOREX_DEAL_DOCUMENTS.NAM_A IS '³��������';
COMMENT ON COLUMN BARS.V_FOREX_DEAL_DOCUMENTS.ID_B IS '����-�';
COMMENT ON COLUMN BARS.V_FOREX_DEAL_DOCUMENTS.NAM_B IS '���������';
COMMENT ON COLUMN BARS.V_FOREX_DEAL_DOCUMENTS.DEAL_TAG IS '����� �����';
COMMENT ON COLUMN BARS.V_FOREX_DEAL_DOCUMENTS.SOS IS '���� ���������';

GRANT SELECT ON BARS.V_FOREX_DEAL_DOCUMENTS TO BARS_ACCESS_DEFROLE;
