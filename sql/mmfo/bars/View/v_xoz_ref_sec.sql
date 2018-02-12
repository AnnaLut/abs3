PROMPT ===================================================================================== 
PROMPT *** Run *** ======== Scripts /Sql/BARS/View/V_XOZ_REF_SEC.sql =======*** Run *** ====
PROMPT ===================================================================================== 


PROMPT *** Create  view V_XOZ_REF_SEC ***

CREATE OR REPLACE VIEW V_XOZ_REF_SEC AS
SELECT REC_ID,
       to_char(REC_DATE, 'dd.mm.yyyy' ) as REC_DATE,
       to_char(REC_DATE, 'HH24:MI:SS' ) as REC_TIME,
       REC_BDATE,
       substr(REC_MESSAGE, 10, 6) as MES_TYPE,
       substr(REC_MESSAGE, 17) as REC_MESSAGE,
       MACHINE,
       REC_UID
   from sec_audit
   WHERE REC_TYPE = 'INFO'
   AND substr(REC_MESSAGE,1,7) = 'XOZ_REF';

COMMENT ON TABLE BARS.V_XOZ_REF_SEC IS 'Історія змін по картотеці договорів госп. деб. заборг.';

COMMENT ON COLUMN BARS.V_XOZ_REF_SEC.REC_ID IS 'ID запису в SEC_AUDIT';

COMMENT ON COLUMN BARS.V_XOZ_REF_SEC.REC_DATE IS 'Глобальна дата зміни';

COMMENT ON COLUMN BARS.V_XOZ_REF_SEC.REC_TIME IS 'Глобальний час зміни';

COMMENT ON COLUMN BARS.V_XOZ_REF_SEC.REC_BDATE IS 'Банківська дата зміни';

COMMENT ON COLUMN BARS.V_XOZ_REF_SEC.MES_TYPE IS 'Тип зміни (insert, delete, update)';

COMMENT ON COLUMN BARS.V_XOZ_REF_SEC.REC_MESSAGE IS 'Опис зміни';

COMMENT ON COLUMN BARS.V_XOZ_REF_SEC.MACHINE IS 'Станція';

COMMENT ON COLUMN BARS.V_XOZ_REF_SEC.REC_UID IS 'Ідентифікатор користувача';


PROMPT *** Create  grants  V_XOZ_REF_SEC ***
grant SELECT,UPDATE,INSERT,DELETE                     on V_XOZ_REF_SEC      to BARS_ACCESS_DEFROLE;


PROMPT ===================================================================================== 
PROMPT *** End *** ========= Scripts /Sql/BARS/View/V_XOZ_REF_SEC.sql =======*** End *** ===
PROMPT ===================================================================================== 
