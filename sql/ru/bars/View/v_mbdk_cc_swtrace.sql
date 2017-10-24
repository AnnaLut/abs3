CREATE OR REPLACE VIEW v_mbdk_cc_swtrace AS
SELECT
   rnk,        
   kv,         
   swo_bic,    
   swo_acc,   
   swo_alt,
   interm_b,
   field_58d,
   nls
FROM cc_swtrace;        

COMMENT ON TABLE  v_mbdk_cc_swtrace IS '����: �������� ��������� ���� ��������';
COMMENT ON COLUMN v_mbdk_cc_swtrace.RNK IS '���';
COMMENT ON COLUMN v_mbdk_cc_swtrace.KV IS '��� ������';
COMMENT ON COLUMN v_mbdk_cc_swtrace.SWO_BIC IS 'BIC-��� ��������';
COMMENT ON COLUMN v_mbdk_cc_swtrace.SWO_ACC IS '����� ������� ��������';
COMMENT ON COLUMN v_mbdk_cc_swtrace.SWO_ALT IS '�������. ������� ����� (57D)';
COMMENT ON COLUMN v_mbdk_cc_swtrace.INTERM_B IS '�������� ���������� �� ������ � (56A)';
COMMENT ON COLUMN v_mbdk_cc_swtrace.FIELD_58D IS '���� 58D ��� �����';
COMMENT ON COLUMN v_mbdk_cc_swtrace.NLS IS '������� ��������';

GRANT SELECT, INSERT, UPDATE, DELETE ON v_mbdk_cc_swtrace TO bars_access_defrole;
GRANT SELECT, INSERT, UPDATE, DELETE ON v_mbdk_cc_swtrace TO start1;