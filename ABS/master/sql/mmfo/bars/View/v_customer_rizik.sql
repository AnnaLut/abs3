PROMPT ===================================================================================== 
PROMPT *** Run *** ========== Scripts /Sql/BARS/View/V_CUSTOMER_RIZIK.sql =========*** Run *
PROMPT ===================================================================================== 


PROMPT *** Create  view V_CUSTOMER_RIZIK ***

  CREATE OR REPLACE FORCE VIEW BARS.V_CUSTOMER_RIZIK ("RNK", "TGR", "CUSTTYPE", "COUNTRY", "BRANCH", "NMK", "NMKV", "NMKK", "CODCAGENT", "PRINSIDER", "OKPO", "ADR", "SAB", "TAXF", "C_REG", "C_DST", "RGTAX", "DATET", "ADM", "DATEA", "STMT", "DATE_ON", "DATE_OFF", "NOTES", "NOTESEC", "CRISK", "PINCODE", "ND", "RNKP", "ISE", "FS", "OE", "VED", "K050", "SED", "NOMPDV", "MB", "LIM", "RGADM", "BC", "TOBO", "ISP", "RIZIK", "RIZIK_DATE", "MM_DATE_ON") AS 
  SELECT c.rnk AS rnk,
          tgr AS tgr,
          custtype AS custtype,
          country AS country,
          branch AS branch,
          nmk AS nmk,
          nmkv AS nmkv,
          nmkk AS nmkk,
          codcagent AS codcagent,
          prinsider AS prinsider,
          okpo AS okpo,
          adr AS adr,
          sab AS sab,
          taxf AS taxf,
          c_reg AS c_reg,
          c_dst AS c_dst,
          rgtax AS rgtax,
          datet AS datet,
          adm AS adm,
          datea AS datea,
          stmt AS stmt,
          date_on AS date_on,
          date_off AS date_off,
          notes AS notes,
          notesec AS notesec,
          crisk AS crisk,
          pincode AS pincode,
          nd AS nd,
          rnkp AS rnkp,
          ise AS ise,
          fs AS fs,
          oe AS oe,
          ved AS ved,
          k050 AS k050,
          sed AS sed,
          nompdv AS nompdv,
          mb AS mb,
          lim AS lim,
          rgadm AS rgadm,
          bc AS bc,
          tobo AS tobo,
          isp AS isp,
          SUBSTR (TRIM (cww.VALUE), 1, 20) AS rizik,
          cww.chgdate AS rizik_date,
          extract(month from c.date_on) AS mm_date_on
     FROM customer c,
          (SELECT rnk, chgdate, VALUE
             FROM (SELECT cw.*,
                          ROW_NUMBER ()
                             OVER (PARTITION BY rnk ORDER BY idupd DESC)
                             rn
                     FROM customerw_update cw
                    WHERE tag = 'RIZIK')
            WHERE rn = 1) cww
    WHERE c.rnk = cww.rnk(+) 
	AND c.date_off IS NULL
;

PROMPT *** Create  grants  V_CUSTOMER_RIZIK ***
grant SELECT                                                                 on V_CUSTOMER_RIZIK to BARS_ACCESS_DEFROLE;
grant SELECT                                                                 on V_CUSTOMER_RIZIK to CUST001;
grant SELECT                                                                 on V_CUSTOMER_RIZIK to START1;
grant DELETE,FLASHBACK,INSERT,SELECT,UPDATE                                  on V_CUSTOMER_RIZIK to WR_ALL_RIGHTS;



PROMPT ===================================================================================== 
PROMPT *** End *** ========== Scripts /Sql/BARS/View/V_CUSTOMER_RIZIK.sql =========*** End *
PROMPT ===================================================================================== 
