/* Formatted on 1/6/2016 3:22:08 PM (QP5 v5.227.12220.39754) */
CREATE OR REPLACE FORCE VIEW V_MBM_CUSTOMERS
AS
   SELECT c."RNK",
          c."TGR",
          c."CUSTTYPE",
          c."COUNTRY",
          c."NMK",
          c."NMKV",
          c."NMKK",
          c."CODCAGENT",
          c."PRINSIDER",
          c."OKPO",
          c."ADR",
          c."SAB",
          c."C_REG",
          c."C_DST",
          c."RGTAX",
          c."DATET",
          c."ADM",
          c."DATEA",
          c."STMT",
          c."DATE_ON",
          c."DATE_OFF",
          c."NOTES",
          c."NOTESEC",
          c."CRISK",
          c."PINCODE",
          c."ND",
          c."RNKP",
          c."ISE",
          c."FS",
          c."OE",
          c."VED",
          c."SED",
          c."LIM",
          c."MB",
          c."RGADM",
          c."BC",
          c."BRANCH",
          c."TOBO",
          c."ISP",
          c."TAXF",
          c."NOMPDV",
          c."K050",
          c."NREZID_CODE",
          GL.BD as BANK_DATE
     FROM customer c
    WHERE custtype IN (2,3);

COMMENT ON TABLE BARS.V_MBM_CUSTOMERS IS 'Клієнти доступні для підлючення до мобільного банкінгу';



GRANT SELECT ON BARS.V_MBM_CUSTOMERS TO BARS_ACCESS_DEFROLE;
