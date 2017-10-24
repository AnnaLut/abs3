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

COMMENT ON TABLE BARS.V_FOREX_SWIFT_O IS 'FOREX: ����`���� ������� SWIFT ����������';
COMMENT ON COLUMN BARS.V_FOREX_SWIFT_O.SWREF IS '��������~�����������';
COMMENT ON COLUMN BARS.V_FOREX_SWIFT_O.MT IS '���~�����������';
COMMENT ON COLUMN BARS.V_FOREX_SWIFT_O.IO_IND IS '��������';
COMMENT ON COLUMN BARS.V_FOREX_SWIFT_O.TRN IS 'SWIFT ��������~�����������';
COMMENT ON COLUMN BARS.V_FOREX_SWIFT_O.SENDER IS '³��������';
COMMENT ON COLUMN BARS.V_FOREX_SWIFT_O.RECEIVER IS '���������';
COMMENT ON COLUMN BARS.V_FOREX_SWIFT_O.VDATE IS '����~�����������';
COMMENT ON COLUMN BARS.V_FOREX_SWIFT_O.DATE_IN IS '����~�����������';

GRANT SELECT ON BARS.V_FOREX_SWIFT_O TO BARS_ACCESS_DEFROLE;



