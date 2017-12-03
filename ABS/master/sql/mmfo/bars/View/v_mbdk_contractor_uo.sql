CREATE OR REPLACE FORCE VIEW BARS.V_MBDK_CONTRACTOR_UO
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
            NULL MFO,
            NULL BIC,
            NULL KOD_B,
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
            --JOIN CUSTBANK  b ON (c.rnk       = b.rnk)
            JOIN CODCAGENT g ON (c.codcagent = g.codcagent)
            JOIN PRINSIDER p ON (c.prinsider = p.prinsider)
      WHERE     c.DATE_OFF IS NULL
            AND c.custtype = 2
            --AND ((c.codcagent = 1 AND b.mfo <> '300465')  OR (c.codcagent = 2 AND b.bic IS NOT NULL))
            AND c.kf = SYS_CONTEXT ('bars_context', 'user_mfo')
            AND c.codcagent IN (3, 4)
      ORDER BY 1;
      
COMMENT ON TABLE BARS.V_MBDK_CONTRACTOR_UO IS 'Контрагенти МБДК (2700,3660)';
COMMENT ON COLUMN BARS.V_MBDK_CONTRACTOR_UO.RNK IS 'РНК~контрагента';
COMMENT ON COLUMN BARS.V_MBDK_CONTRACTOR_UO.NMK IS 'Найменування контрагента';
COMMENT ON COLUMN BARS.V_MBDK_CONTRACTOR_UO.OKPO IS 'Код ЗКПО';
COMMENT ON COLUMN BARS.V_MBDK_CONTRACTOR_UO.CUSTTYPE IS 'Тип (1-Банк,2-ЮО,~3-ФО)';
COMMENT ON COLUMN BARS.V_MBDK_CONTRACTOR_UO.DATE_ON IS 'Дата~відкриття';
COMMENT ON COLUMN BARS.V_MBDK_CONTRACTOR_UO.DATE_OFF IS 'Дата~закриття';
COMMENT ON COLUMN BARS.V_MBDK_CONTRACTOR_UO.TGR IS 'ТГР(1-ЄДР.,2-ДРФ.,~3-тимчас.)';
COMMENT ON COLUMN BARS.V_MBDK_CONTRACTOR_UO.C_DST IS 'Код район. ДПІ';
COMMENT ON COLUMN BARS.V_MBDK_CONTRACTOR_UO.C_REG IS 'Код обл.';
COMMENT ON COLUMN BARS.V_MBDK_CONTRACTOR_UO.ND IS '№ договору';
COMMENT ON COLUMN BARS.V_MBDK_CONTRACTOR_UO.CODCAGENT IS 'Хар-ка';
COMMENT ON COLUMN BARS.V_MBDK_CONTRACTOR_UO.COD_NAME IS 'Назва коду';
COMMENT ON COLUMN BARS.V_MBDK_CONTRACTOR_UO.COUNTRY IS 'Код країни';
COMMENT ON COLUMN BARS.V_MBDK_CONTRACTOR_UO.PRINSIDER IS 'Код інсайдера';
COMMENT ON COLUMN BARS.V_MBDK_CONTRACTOR_UO.PRINS_NAME IS 'Назва коду';
COMMENT ON COLUMN BARS.V_MBDK_CONTRACTOR_UO.STMT IS 'Формат~виписки';
COMMENT ON COLUMN BARS.V_MBDK_CONTRACTOR_UO.SAB IS 'Ел. код';
COMMENT ON COLUMN BARS.V_MBDK_CONTRACTOR_UO.CRISK IS 'Категорія';
COMMENT ON COLUMN BARS.V_MBDK_CONTRACTOR_UO.ADR IS 'Адреса';
COMMENT ON COLUMN BARS.V_MBDK_CONTRACTOR_UO.VED IS 'Викд~економічної~діяльності';
COMMENT ON COLUMN BARS.V_MBDK_CONTRACTOR_UO.SED IS 'Код~галузі~економіки';

GRANT SELECT ON BARS.V_MBDK_CONTRACTOR_UO TO BARS_ACCESS_DEFROLE;      