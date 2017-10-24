

PROMPT ===================================================================================== 
PROMPT *** Run *** ========== Scripts /Sql/BARS/View/V_MBM_CUSTOMERS.sql =========*** Run **
PROMPT ===================================================================================== 


PROMPT *** Create  view V_MBM_CUSTOMERS ***

  CREATE OR REPLACE FORCE VIEW BARS.V_MBM_CUSTOMERS ("RNK", "TGR", "CUSTTYPE", "COUNTRY", "NMK", "NMKV", "NMKK", "CODCAGENT", "PRINSIDER", "OKPO", "ADR", "SAB", "C_REG", "C_DST", "RGTAX", "DATET", "ADM", "DATEA", "STMT", "DATE_ON", "DATE_OFF", "NOTES", "NOTESEC", "CRISK", "PINCODE", "ND", "RNKP", "ISE", "FS", "OE", "VED", "SED", "LIM", "MB", "RGADM", "BC", "BRANCH", "TOBO", "ISP", "TAXF", "NOMPDV", "K050", "NREZID_CODE", "BANK_DATE") AS 
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

PROMPT *** Create  grants  V_MBM_CUSTOMERS ***
grant SELECT                                                                 on V_MBM_CUSTOMERS to BARS_ACCESS_DEFROLE;



PROMPT ===================================================================================== 
PROMPT *** End *** ========== Scripts /Sql/BARS/View/V_MBM_CUSTOMERS.sql =========*** End **
PROMPT ===================================================================================== 
