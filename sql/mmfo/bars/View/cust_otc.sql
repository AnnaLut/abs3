

PROMPT ===================================================================================== 
PROMPT *** Run *** ========== Scripts /Sql/BARS/View/CUST_OTC.sql =========*** Run *** =====
PROMPT ===================================================================================== 


PROMPT *** Create  view CUST_OTC ***

  CREATE OR REPLACE FORCE VIEW BARS.CUST_OTC ("RNK", "TGR", "CUSTTYPE", "COUNTRY", "NMK", "NMKV", "NMKK", "CODCAGENT", "PRINSIDER", "OKPO", "ADR", "SAB", "TAXF", "C_REG", "C_DST", "RGTAX", "DATET", "ADM", "DATEA", "STMT", "DATE_ON", "DATE_OFF", "NOTES", "NOTESEC", "CRISK", "PINCODE", "ISE", "FS", "OE", "VED", "SED", "RNKP", "ND") AS 
  select "RNK","TGR","CUSTTYPE","COUNTRY","NMK","NMKV","NMKK","CODCAGENT","PRINSIDER","OKPO","ADR","SAB","TAXF","C_REG","C_DST","RGTAX","DATET","ADM","DATEA","STMT","DATE_ON","DATE_OFF","NOTES","NOTESEC","CRISK","PINCODE","ISE","FS","OE","VED","SED","RNKP","ND" from customer;

PROMPT *** Create  grants  CUST_OTC ***
grant SELECT                                                                 on CUST_OTC        to BARSREADER_ROLE;
grant DELETE,INSERT,SELECT,UPDATE                                            on CUST_OTC        to BARS_ACCESS_DEFROLE;
grant SELECT                                                                 on CUST_OTC        to CUST001;
grant SELECT                                                                 on CUST_OTC        to UPLD;



PROMPT ===================================================================================== 
PROMPT *** End *** ========== Scripts /Sql/BARS/View/CUST_OTC.sql =========*** End *** =====
PROMPT ===================================================================================== 
