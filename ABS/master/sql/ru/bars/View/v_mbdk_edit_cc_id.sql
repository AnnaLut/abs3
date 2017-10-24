CREATE OR REPLACE VIEW v_mbdk_edit_cc_id AS
SELECT nd, 
       cc_id
FROM CC_deal;
 
GRANT SELECT, UPDATE ON v_mbdk_edit_cc_id TO bars_access_defrole;  
 
COMMENT ON TABLE  v_mbdk_edit_cc_id IS 'МБДК: Редагування № договору(тікету)';
COMMENT ON COLUMN v_mbdk_edit_cc_id.nd IS 'Референс';
COMMENT ON COLUMN v_mbdk_edit_cc_id.cc_id IS '№ договору(тікета)';
