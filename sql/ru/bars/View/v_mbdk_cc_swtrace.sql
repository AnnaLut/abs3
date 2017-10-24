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

COMMENT ON TABLE  v_mbdk_cc_swtrace IS 'МБДК: Збережені параметри тарс договорів';
COMMENT ON COLUMN v_mbdk_cc_swtrace.RNK IS 'РНК';
COMMENT ON COLUMN v_mbdk_cc_swtrace.KV IS 'Код валюти';
COMMENT ON COLUMN v_mbdk_cc_swtrace.SWO_BIC IS 'BIC-код партнера';
COMMENT ON COLUMN v_mbdk_cc_swtrace.SWO_ACC IS 'Номер рахунку партнера';
COMMENT ON COLUMN v_mbdk_cc_swtrace.SWO_ALT IS 'Альтерн. вихідна траса (57D)';
COMMENT ON COLUMN v_mbdk_cc_swtrace.INTERM_B IS 'Реквізити посредника по стороні Б (56A)';
COMMENT ON COLUMN v_mbdk_cc_swtrace.FIELD_58D IS 'Поле 58D для рублів';
COMMENT ON COLUMN v_mbdk_cc_swtrace.NLS IS 'Рахунок партнера';

GRANT SELECT, INSERT, UPDATE, DELETE ON v_mbdk_cc_swtrace TO bars_access_defrole;
GRANT SELECT, INSERT, UPDATE, DELETE ON v_mbdk_cc_swtrace TO start1;