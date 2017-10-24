

PROMPT ===================================================================================== 
PROMPT *** Run *** ========== Scripts /Sql/BARS/View/V_CUSTOMER_RIZIK.sql =========*** Run *
PROMPT ===================================================================================== 


PROMPT *** Create  view V_CUSTOMER_RIZIK ***

  CREATE OR REPLACE FORCE VIEW BARS.V_CUSTOMER_RIZIK ("RNK", "TGR", "CUSTTYPE", "COUNTRY", "BRANCH", "NMK", "NMKV", "NMKK", "CODCAGENT", "PRINSIDER", "OKPO", "ADR", "SAB", "TAXF", "C_REG", "C_DST", "RGTAX", "DATET", "ADM", "DATEA", "STMT", "DATE_ON", "DATE_OFF", "NOTES", "NOTESEC", "CRISK", "PINCODE", "ND", "RNKP", "ISE", "FS", "OE", "VED", "K050", "SED", "NOMPDV", "MB", "LIM", "RGADM", "BC", "TOBO", "ISP", "RIZIK", "RIZIK_DATE", "MMRIZIK_DATE") AS 
  SELECT c.RNK,
          TGR,
          CUSTTYPE,
          COUNTRY,
          BRANCH,
          NMK,
          NMKV,
          NMKK,
          CODCAGENT,
          PRINSIDER,
          OKPO,
          ADR,
          SAB,
          TAXF,
          C_REG,
          C_DST,
          RGTAX,
          DATET,
          ADM,
          DATEA,
          STMT,
          DATE_ON,
          DATE_OFF,
          NOTES,
          NOTESEC,
          CRISK,
          PINCODE,
          ND,
          RNKP,
          ISE,
          FS,
          OE,
          VED,
          K050,
          SED,
          NOMPDV,
          MB,
          LIM,
          RGADM,
          BC,
          TOBO,
          ISP,
          substr(trim(cww.value),1,20),
          to_char( cww.chgdate,'DD/MM/YYYY HH24:MI:SS'),
          to_char(cww.chgdate,'MM.YYYY')
     FROM customer c,
              (SELECT rnk, chgdate, VALUE
             FROM (SELECT cw.*,
                          ROW_NUMBER ()
                             OVER (PARTITION BY rnk ORDER BY idupd DESC)
                             rn
                     FROM customerw_update cw
                    WHERE tag = 'RIZIK')
            WHERE rn = 1) cww
      where c.rnk = cww.rnk(+)
      and c.date_off IS NULL;

PROMPT *** Create  grants  V_CUSTOMER_RIZIK ***
grant SELECT                                                                 on V_CUSTOMER_RIZIK to BARS_ACCESS_DEFROLE;
grant SELECT                                                                 on V_CUSTOMER_RIZIK to CUST001;
grant SELECT                                                                 on V_CUSTOMER_RIZIK to START1;
grant DELETE,FLASHBACK,INSERT,SELECT,UPDATE                                  on V_CUSTOMER_RIZIK to WR_ALL_RIGHTS;



PROMPT ===================================================================================== 
PROMPT *** End *** ========== Scripts /Sql/BARS/View/V_CUSTOMER_RIZIK.sql =========*** End *
PROMPT ===================================================================================== 
