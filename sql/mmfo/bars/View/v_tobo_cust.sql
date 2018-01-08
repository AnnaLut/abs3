

PROMPT ===================================================================================== 
PROMPT *** Run *** ========== Scripts /Sql/BARS/View/V_TOBO_CUST.sql =========*** Run *** ==
PROMPT ===================================================================================== 


PROMPT *** Create  view V_TOBO_CUST ***

  CREATE OR REPLACE FORCE VIEW BARS.V_TOBO_CUST ("RNK", "TGR", "CUSTTYPE", "COUNTRY", "NMK", "NMKV", "NMKK", "CODCAGENT", "PRINSIDER", "OKPO", "ADR", "SAB", "TAXF", "C_REG", "C_DST", "RGTAX", "DATET", "ADM", "DATEA", "STMT", "DATE_ON", "DATE_OFF", "NOTES", "NOTESEC", "CRISK", "PINCODE", "ND", "RNKP", "ISE", "FS", "OE", "VED", "K050", "SED", "NOMPDV", "MB", "LIM", "RGADM", "BC", "BRANCH", "TOBO", "ISP", "NREZID_CODE", "REQ_TYPE", "REQ_STATUS", "CUSTTYPENAME") AS 
  SELECT c."RNK",c."TGR",c."CUSTTYPE",c."COUNTRY",c."NMK",c."NMKV",c."NMKK",c."CODCAGENT",c."PRINSIDER",c."OKPO",c."ADR",c."SAB",c."TAXF",c."C_REG",c."C_DST",c."RGTAX",c."DATET",c."ADM",c."DATEA",c."STMT",c."DATE_ON",c."DATE_OFF",c."NOTES",c."NOTESEC",c."CRISK",c."PINCODE",c."ND",c."RNKP",c."ISE",c."FS",c."OE",c."VED",c."K050",c."SED",c."NOMPDV",c."MB",c."LIM",c."RGADM",c."BC",c."BRANCH",c."TOBO",c."ISP",c."NREZID_CODE",c."REQ_TYPE",c."REQ_STATUS",c."CUSTTYPENAME"
     FROM v_customer c;

PROMPT *** Create  grants  V_TOBO_CUST ***
grant SELECT                                                                 on V_TOBO_CUST     to BARSREADER_ROLE;
grant SELECT                                                                 on V_TOBO_CUST     to BARS_ACCESS_DEFROLE;
grant SELECT                                                                 on V_TOBO_CUST     to UPLD;
grant DELETE,FLASHBACK,INSERT,SELECT,UPDATE                                  on V_TOBO_CUST     to WR_ALL_RIGHTS;
grant SELECT                                                                 on V_TOBO_CUST     to WR_CUSTLIST;
grant SELECT                                                                 on V_TOBO_CUST     to WR_CUSTREG;
grant SELECT                                                                 on V_TOBO_CUST     to WR_ND_ACCOUNTS;
grant SELECT                                                                 on V_TOBO_CUST     to WR_VIEWACC;



PROMPT ===================================================================================== 
PROMPT *** End *** ========== Scripts /Sql/BARS/View/V_TOBO_CUST.sql =========*** End *** ==
PROMPT ===================================================================================== 
