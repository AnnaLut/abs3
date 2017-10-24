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

COMMENT ON TABLE v_forex_swift IS 'FOREX: Формування SWIFT повідомлень';   
COMMENT ON COLUMN v_forex_swift.swref IS 'Референс~повідомлення';
COMMENT ON COLUMN v_forex_swift.mt IS 'Тип~повідомлення';
COMMENT ON COLUMN v_forex_swift.io_ind IS 'Напрямок';
COMMENT ON COLUMN v_forex_swift.trn IS 'SWIFT референс~повідомлення';
COMMENT ON COLUMN v_forex_swift.sender IS 'Відправник';
COMMENT ON COLUMN v_forex_swift.receiver IS 'Отримувач';
COMMENT ON COLUMN v_forex_swift.vdate IS 'Дата~валютування';
COMMENT ON COLUMN v_forex_swift.date_in IS 'Дата~надходження';