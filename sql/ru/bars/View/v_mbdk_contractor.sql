CREATE OR REPLACE FORCE VIEW BARS.V_MBDK_CONTRACTOR
(
   RNK,
   NMK,
   OKPO,
   MFO,
   BIC,
   KOD_B,
   CUSTTYPE,
   DATE_ON,
   DATE_OFF,
   TGR,
   C_DST,
   C_REG,
   ND,
   CODCAGENT,
   COD_NAME,
   COUNTRY,
   PRINSIDER,
   PRINS_NAME,
   STMT,
   SAB,
   CRISK,
   ADR,
   VED,
   SED
)
AS 
 SELECT c.rnk,
            c.NMK,
            c.okpo,
            MFO,
            BIC,
            KOD_B,
            c.custtype,
            c.date_on,
            c.date_off,
            c.tgr,
            c.c_dst,
            c.c_reg,
            c.nd,
            c.codcagent,
            g.name cod_name,
            c.country,
            c.prinsider,
            p.name prins_name,
            c.stmt,
            c.SAB,
            c.crisk,
            c.adr,
            c.ved,
            c.sed
       FROM CUSTOMER c
            JOIN CUSTBANK b ON (c.rnk = b.rnk)
            JOIN CODCAGENT g ON (c.codcagent = g.codcagent)
            JOIN PRINSIDER p ON (c.prinsider = p.prinsider)
      WHERE     c.DATE_OFF IS NULL
            AND c.custtype = 1
            AND  (   (c.codcagent = 1 AND b.mfo <> '300465')  OR (c.codcagent = 2 AND b.bic IS NOT NULL))
            AND c.kf = SYS_CONTEXT ('bars_context', 'user_mfo')
            AND c.codcagent IN (1, 2)
      ORDER BY 1;
      
COMMENT ON TABLE BARS.V_MBDK_CONTRACTOR IS 'Контрагенти МБДК';

COMMENT ON COLUMN BARS.V_MBDK_CONTRACTOR.RNK IS 'РНК~контрагента';

COMMENT ON COLUMN BARS.V_MBDK_CONTRACTOR.NMK IS 'Найменування контрагента';

COMMENT ON COLUMN BARS.V_MBDK_CONTRACTOR.OKPO IS 'Код ЗКПО';

COMMENT ON COLUMN BARS.V_MBDK_CONTRACTOR.CUSTTYPE IS 'Тип (1-Банк,2-ЮО,~3-ФО)';

COMMENT ON COLUMN BARS.V_MBDK_CONTRACTOR.DATE_ON IS 'Дата~відкриття';

COMMENT ON COLUMN BARS.V_MBDK_CONTRACTOR.DATE_OFF IS 'Дата~закриття';

COMMENT ON COLUMN BARS.V_MBDK_CONTRACTOR.TGR IS 'ТГР(1-ЄДР.,2-ДРФ.,~3-тимчас.)';

COMMENT ON COLUMN BARS.V_MBDK_CONTRACTOR.C_DST IS 'Код район. ДПІ';

COMMENT ON COLUMN BARS.V_MBDK_CONTRACTOR.C_REG IS 'Код обл.';

COMMENT ON COLUMN BARS.V_MBDK_CONTRACTOR.ND IS '№ договору';

COMMENT ON COLUMN BARS.V_MBDK_CONTRACTOR.CODCAGENT IS 'Хар-ка';

COMMENT ON COLUMN BARS.V_MBDK_CONTRACTOR.COD_NAME IS 'Назва коду';

COMMENT ON COLUMN BARS.V_MBDK_CONTRACTOR.COUNTRY IS 'Код країни';

COMMENT ON COLUMN BARS.V_MBDK_CONTRACTOR.PRINSIDER IS 'Код інсайдера';

COMMENT ON COLUMN BARS.V_MBDK_CONTRACTOR.PRINS_NAME IS 'Назва коду';

COMMENT ON COLUMN BARS.V_MBDK_CONTRACTOR.STMT IS 'Формат~виписки';

COMMENT ON COLUMN BARS.V_MBDK_CONTRACTOR.SAB IS 'Ел. код';

COMMENT ON COLUMN BARS.V_MBDK_CONTRACTOR.CRISK IS 'Категорія';

COMMENT ON COLUMN BARS.V_MBDK_CONTRACTOR.ADR IS 'Адреса';

COMMENT ON COLUMN BARS.V_MBDK_CONTRACTOR.VED IS 'Викд~економічної~діяльності';

COMMENT ON COLUMN BARS.V_MBDK_CONTRACTOR.SED IS 'Код~галузі~економіки';


GRANT SELECT ON BARS.V_MBDK_CONTRACTOR TO BARS_ACCESS_DEFROLE;      