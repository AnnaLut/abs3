

PROMPT ===================================================================================== 
PROMPT *** Run *** ========== Scripts /Sql/BARS/View/V_CUSTOMER_ACTIVE.sql =========*** Run 
PROMPT ===================================================================================== 


PROMPT *** Create  view V_CUSTOMER_ACTIVE ***

  CREATE OR REPLACE FORCE VIEW BARS.V_CUSTOMER_ACTIVE ("RNK", "TGR", "CUSTTYPE", "COUNTRY", "NMK", "NMKV", "NMKK", "CODCAGENT", "PRINSIDER", "OKPO", "ADR", "SAB", "C_REG", "C_DST", "RGTAX", "DATET", "ADM", "DATEA", "STMT", "DATE_ON", "DATE_OFF", "NOTES", "NOTESEC", "CRISK", "PINCODE", "ND", "RNKP", "ISE", "FS", "OE", "VED", "SED", "LIM", "MB", "RGADM", "BC", "BRANCH", "TOBO", "ISP", "TAXF", "NOMPDV", "K050", "NREZID_CODE", "KF") AS 
  SELECT RNK
       ,TGR
       ,CUSTTYPE
       ,COUNTRY
       ,NMK
       ,NMKV
       ,NMKK
       ,CODCAGENT
       ,PRINSIDER
       ,OKPO
       ,ADR
       ,SAB
       ,C_REG
       ,C_DST
       ,RGTAX
       ,DATET
       ,ADM
       ,DATEA
       ,STMT
       ,DATE_ON
       ,DATE_OFF
       ,NOTES
       ,NOTESEC
       ,CRISK
       ,PINCODE
       ,ND
       ,RNKP
       ,ISE
       ,FS
       ,OE
       ,VED
       ,SED
       ,LIM
       ,MB
       ,RGADM
       ,BC
       ,BRANCH
       ,TOBO
       ,ISP
       ,TAXF
       ,NOMPDV
       ,K050
       ,NREZID_CODE
       ,KF
  FROM baRS.customer t
 WHERE t.date_off IS NULL;

PROMPT *** Create  grants  V_CUSTOMER_ACTIVE ***
grant SELECT                                                                 on V_CUSTOMER_ACTIVE to BARS_ACCESS_DEFROLE;



PROMPT ===================================================================================== 
PROMPT *** End *** ========== Scripts /Sql/BARS/View/V_CUSTOMER_ACTIVE.sql =========*** End 
PROMPT ===================================================================================== 
