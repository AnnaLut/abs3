

PROMPT ===================================================================================== 
PROMPT *** Run *** ========== Scripts /Sql/BARS/View/V_CUSTOMER_BYDATE.sql =========*** Run 
PROMPT ===================================================================================== 


PROMPT *** Create  view V_CUSTOMER_BYDATE ***

  CREATE OR REPLACE FORCE VIEW BARS.V_CUSTOMER_BYDATE ("RNK", "CUSTTYPE", "COUNTRY", "NMK", "NMKV", "NMKK", "CODCAGENT", "PRINSIDER", "OKPO", "ADR", "SAB", "C_REG", "C_DST", "RGTAX", "DATET", "ADM", "DATEA", "STMT", "DATE_ON", "DATE_OFF", "NOTES", "NOTESEC", "CRISK", "PINCODE", "CHGDATE", "CHGACTION", "TGR", "IDUPD", "DONEBY", "BRANCH", "ND", "RNKP", "ISE", "FS", "OE", "VED", "SED", "LIM", "MB", "RGADM", "BC", "TOBO", "ISP", "TAXF", "NOMPDV", "K050", "EFFECTDATE") AS 
  select "RNK","CUSTTYPE","COUNTRY","NMK","NMKV","NMKK","CODCAGENT","PRINSIDER","OKPO","ADR","SAB","C_REG","C_DST","RGTAX","DATET","ADM","DATEA","STMT","DATE_ON","DATE_OFF","NOTES","NOTESEC","CRISK","PINCODE","CHGDATE","CHGACTION","TGR","IDUPD","DONEBY","BRANCH","ND","RNKP","ISE","FS","OE","VED","SED","LIM","MB","RGADM","BC","TOBO","ISP","TAXF","NOMPDV","K050","EFFECTDATE"
  from customer_update
 where (rnk, idupd) in ( select rnk, max(idupd) idupd
                           from customer_update u
                          where trunc(chgdate) <= to_date(pul.get_mas_ini_val('DAT'), 'dd/mm/yyyy')
                            and chgaction in (1,2)
                          group by rnk );

PROMPT *** Create  grants  V_CUSTOMER_BYDATE ***
grant SELECT                                                                 on V_CUSTOMER_BYDATE to BARSREADER_ROLE;
grant SELECT                                                                 on V_CUSTOMER_BYDATE to UPLD;



PROMPT ===================================================================================== 
PROMPT *** End *** ========== Scripts /Sql/BARS/View/V_CUSTOMER_BYDATE.sql =========*** End 
PROMPT ===================================================================================== 
