CREATE OR REPLACE FORCE VIEW BARS.V_FOREX_ACCOUNT_MODEL
(
   REF,
   FDAT,
   TT,
   AMNT_DB,
   AMNT_CR,
   SOS,
   NMS,
   NLS,
   KV,
   DIG,
   DEAL_TAG
)
AS
     SELECT o.REF,
            o.fdat,
            o.tt,
            DECODE (o.dk, 0, o.s, 0) / POWER (10, t.dig) AS amnt_DB,
            DECODE (o.dk, 1, o.s, 0) / POWER (10, t.dig) AS AMNT_CR,
            o.sos,
            a.nms,
            a.nls,
            a.kv,
            t.dig,
            fd.deal_tag
       FROM bars.opldok o
            JOIN bars.accounts a ON (a.KF = o.KF AND a.acc = o.acc)
            JOIN bars.tabval$global t ON a.kv = t.kv
            JOIN bars.fx_deal_ref fd ON o.REF = fd.REF
   ORDER BY o.fdat,
            o.REF,
            o.stmt,
            o.dk;

COMMENT ON TABLE BARS.V_FOREX_ACCOUNT_MODEL IS 'FOREX: ������ ������������� ����� �����';

COMMENT ON COLUMN BARS.V_FOREX_ACCOUNT_MODEL.REF IS '��������';

COMMENT ON COLUMN BARS.V_FOREX_ACCOUNT_MODEL.FDAT IS '����';

COMMENT ON COLUMN BARS.V_FOREX_ACCOUNT_MODEL.TT IS '��� ��������';

COMMENT ON COLUMN BARS.V_FOREX_ACCOUNT_MODEL.AMNT_DB IS '�����';

COMMENT ON COLUMN BARS.V_FOREX_ACCOUNT_MODEL.AMNT_CR IS '������';

COMMENT ON COLUMN BARS.V_FOREX_ACCOUNT_MODEL.NMS IS '����� �������';

COMMENT ON COLUMN BARS.V_FOREX_ACCOUNT_MODEL.NLS IS '�������';

COMMENT ON COLUMN BARS.V_FOREX_ACCOUNT_MODEL.KV IS '������';

COMMENT ON COLUMN BARS.V_FOREX_ACCOUNT_MODEL.DIG IS '���';

COMMENT ON COLUMN BARS.V_FOREX_ACCOUNT_MODEL.DEAL_TAG IS '����� ��������';


GRANT SELECT ON BARS.V_FOREX_ACCOUNT_MODEL TO BARS_ACCESS_DEFROLE;
