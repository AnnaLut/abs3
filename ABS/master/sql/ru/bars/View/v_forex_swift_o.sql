CREATE OR REPLACE FORCE VIEW BARS.V_FOREX_SWIFT_O
(
   SWREF,
   MT,
   IO_IND,
   TRN,
   SENDER,
   RECEIVER,
   VDATE,
   DATE_IN,
   AMOUNT
)
AS
   SELECT j.swref,
          j.mt,
          j.io_ind,
          j.trn,
          j.sender,
          j.receiver,
          j.vdate,
          j.date_in,
          j.amount/100 amount
        FROM sw_journal j,
          (SELECT io_ind, swref
             FROM sw_journal
            WHERE mt = 300
           MINUS
           SELECT io_ind, swref
             FROM (SELECT 'O' io_ind, swi_ref swref
                     FROM fx_deal
                    WHERE swi_ref IS NOT NULL)
                   ) q
    WHERE     j.mt = '300'
          AND j.io_ind='O'
          AND j.swref = q.swref
          AND j.vdate BETWEEN bankdate_g - 7 AND bankdate_g + 7;  

COMMENT ON TABLE BARS.V_FOREX_SWIFT_O IS 'FOREX: Прив`язка вхідних SWIFT повідомлень';
COMMENT ON COLUMN BARS.V_FOREX_SWIFT_O.SWREF IS 'Референс~повідомлення';
COMMENT ON COLUMN BARS.V_FOREX_SWIFT_O.MT IS 'Тип~повідомлення';
COMMENT ON COLUMN BARS.V_FOREX_SWIFT_O.IO_IND IS 'Напрямок';
COMMENT ON COLUMN BARS.V_FOREX_SWIFT_O.TRN IS 'SWIFT референс~повідомлення';
COMMENT ON COLUMN BARS.V_FOREX_SWIFT_O.SENDER IS 'Відправник';
COMMENT ON COLUMN BARS.V_FOREX_SWIFT_O.RECEIVER IS 'Отримувач';
COMMENT ON COLUMN BARS.V_FOREX_SWIFT_O.VDATE IS 'Дата~валютування';
COMMENT ON COLUMN BARS.V_FOREX_SWIFT_O.DATE_IN IS 'Дата~надходження';

GRANT SELECT ON BARS.V_FOREX_SWIFT_O TO BARS_ACCESS_DEFROLE;



