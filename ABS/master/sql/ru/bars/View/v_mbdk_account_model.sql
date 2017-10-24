CREATE OR REPLACE VIEW v_mbdk_account_model AS
SELECT o.ref, 
       o.fdat, 
       o.tt,
       decode(o.dk,0,o.s,0)/power(10,t.dig) as amnt_DB,
       decode(o.dk,1,o.s,0)/power(10,t.dig) as AMNT_CR,
       o.sos, 
       a.nms, 
       a.nls, 
       a.kv, 
       t.dig,
       mb.ND
  FROM bars.opldok o
  JOIN bars.accounts a ON ( a.KF = o.KF and a.acc = o.acc )
  JOIN bars.tabval$global t ON a.kv = t.kv 
  JOIN bars.mbd_k_r mb ON o.ref=mb.ref
ORDER BY o.fdat, o.ref, o.stmt, o.dk;

GRANT SELECT ON v_mbdk_account_model TO BARS_ACCESS_DEFROLE;

COMMENT ON TABLE v_mbdk_account_model IS '����: ������ ������������� ����� �����';
COMMENT ON COLUMN v_mbdk_account_model.ref IS '��������';
COMMENT ON COLUMN v_mbdk_account_model.fdat IS '����';
COMMENT ON COLUMN v_mbdk_account_model.tt IS '��� ��������';
COMMENT ON COLUMN v_mbdk_account_model.nls IS '�������';
COMMENT ON COLUMN v_mbdk_account_model.kv IS '������';
COMMENT ON COLUMN v_mbdk_account_model.amnt_DB IS '�����';
COMMENT ON COLUMN v_mbdk_account_model.amnt_CR IS '������';
COMMENT ON COLUMN v_mbdk_account_model.nms IS '����� �������';
COMMENT ON COLUMN v_mbdk_account_model.nd IS '����� ��������';
COMMENT ON COLUMN v_mbdk_account_model.dig IS '���';

