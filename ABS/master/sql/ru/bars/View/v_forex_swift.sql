CREATE OR REPLACE VIEW v_forex_swift AS
SELECT 
     swref,
     mt,
     io_ind,
     trn,
     sender,
     receiver,
     vdate,
     date_in
FROM v_sw300_header;

GRANT SELECT ON v_forex_swift TO bars_access_defrole;  

COMMENT ON TABLE v_forex_swift IS 'FOREX: ���������� SWIFT ����������';   
COMMENT ON COLUMN v_forex_swift.swref IS '��������~�����������';
COMMENT ON COLUMN v_forex_swift.mt IS '���~�����������';
COMMENT ON COLUMN v_forex_swift.io_ind IS '��������';
COMMENT ON COLUMN v_forex_swift.trn IS 'SWIFT ��������~�����������';
COMMENT ON COLUMN v_forex_swift.sender IS '³��������';
COMMENT ON COLUMN v_forex_swift.receiver IS '���������';
COMMENT ON COLUMN v_forex_swift.vdate IS '����~�����������';
COMMENT ON COLUMN v_forex_swift.date_in IS '����~�����������';