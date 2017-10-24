CREATE OR REPLACE VIEW v_mbdk_cc_pawn as
SELECT pawn,
       name,
       pr_rez,
       nbsz,
       nbsz1,
       nbsz2,
       nbsz3,
       s031,
       kat,
       d_close,
       code,
       s031_279,
       name_279,
       pawn_23,
       grp23,
       ob22_fo,
       ob22_uo,
       ob22_u0
FROM cc_pawn;

GRANT SELECT ON V_MBDK_CC_PAWN TO bars_access_defrole;

COMMENT ON TABLE BARS.V_MBDK_CC_PAWN IS 'МБДК: Види забезпчення';
COMMENT ON COLUMN BARS.V_MBDK_CC_PAWN.PAWN IS 'Код виду забезпечення (внутрішній може відрізнятися від коду НБУ)';
COMMENT ON COLUMN BARS.V_MBDK_CC_PAWN.NAME IS 'Найменування виду забезпечення';
COMMENT ON COLUMN BARS.V_MBDK_CC_PAWN.PR_REZ IS 'Не используется';
COMMENT ON COLUMN BARS.V_MBDK_CC_PAWN.NBSZ IS 'Балансовий рахунок застави 1 (для авто відкриття рахунків застави в кредитному портфелі)';
COMMENT ON COLUMN BARS.V_MBDK_CC_PAWN.NBSZ1 IS 'Балансовый счет залога 2 (для автоткрытия счетов залога в кредитном портфеле)';
COMMENT ON COLUMN BARS.V_MBDK_CC_PAWN.NBSZ2 IS 'Балансовий рахунок застави 2 (для автовідкриття рахунків застави в кредитному портфелі)';
COMMENT ON COLUMN BARS.V_MBDK_CC_PAWN.NBSZ3 IS 'Балансовий рахунок застави 4 (для авто відкриття рахунків застави в кредитному портфелі)';
COMMENT ON COLUMN BARS.V_MBDK_CC_PAWN.S031 IS 'Код виду застави за класифікацією НБУ';
COMMENT ON COLUMN BARS.V_MBDK_CC_PAWN.CODE IS 'Cимвольний код';
COMMENT ON COLUMN BARS.V_MBDK_CC_PAWN.OB22_FO IS 'Значення ОБ22 для ФО';
COMMENT ON COLUMN BARS.V_MBDK_CC_PAWN.OB22_UO IS 'Значення ОБ22 для ЮО';