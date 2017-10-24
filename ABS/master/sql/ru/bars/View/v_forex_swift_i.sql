CREATE OR REPLACE FORCE VIEW bars.v_forex_swift_i
(
   SWREF,
   MT,
   IO_IND,
   TRN,
   SENDER,
   RECEIVER,
   VDATE,
   DATE_IN)
AS
   SELECT j.swref,
          j.mt,
          j.io_ind,
          j.trn,
          j.sender,
          j.receiver,
          j.vdate,
          j.date_in
     FROM sw_journal j,
          (SELECT io_ind, swref
             FROM sw_journal
            WHERE mt = 300
           MINUS
           SELECT io_ind, swref
             FROM (
                   SELECT 'I' io_ind, swo_ref swref
                     FROM fx_deal
                    WHERE swo_ref IS NOT NULL)) q
    WHERE     j.mt = '300'
          AND j.io_ind='I'
          AND j.swref = q.swref
          AND j.vdate BETWEEN bankdate_g - 7 AND bankdate_g + 7;          
          
          
COMMENT ON TABLE bars.v_forex_swift_i IS 'FOREX: Прив`язка вихідних SWIFT повідомлень';
COMMENT ON COLUMN bars.v_forex_swift_i.SWREF IS 'Референс~повідомлення';
COMMENT ON COLUMN bars.v_forex_swift_i.MT IS 'Тип~повідомлення';
COMMENT ON COLUMN bars.v_forex_swift_i.IO_IND IS 'Напрямок';
COMMENT ON COLUMN bars.v_forex_swift_i.TRN IS 'SWIFT референс~повідомлення';
COMMENT ON COLUMN bars.v_forex_swift_i.SENDER IS 'Відправник';
COMMENT ON COLUMN bars.v_forex_swift_i.RECEIVER IS 'Отримувач';
COMMENT ON COLUMN bars.v_forex_swift_i.VDATE IS 'Дата~валютування';
COMMENT ON COLUMN bars.v_forex_swift_i.DATE_IN IS 'Дата~надходження';

GRANT SELECT ON bars.v_forex_swift_i TO bars_ACCESS_DEFROLE;