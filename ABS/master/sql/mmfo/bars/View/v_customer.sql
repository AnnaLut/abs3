

PROMPT ===================================================================================== 
PROMPT *** Run *** ========== Scripts /Sql/BARS/View/V_CUSTOMER.sql =========*** Run *** ===
PROMPT ===================================================================================== 


PROMPT *** Create  view V_CUSTOMER ***

  CREATE OR REPLACE FORCE VIEW BARS.V_CUSTOMER ("RNK", "TGR", "CUSTTYPE", "COUNTRY", "NMK", "NMKV", "NMKK", "CODCAGENT", "PRINSIDER", "OKPO", "ADR", "SAB", "TAXF", "C_REG", "C_DST", "RGTAX", "DATET", "ADM", "DATEA", "STMT", "DATE_ON", "DATE_OFF", "NOTES", "NOTESEC", "CRISK", "PINCODE", "ND", "RNKP", "ISE", "FS", "OE", "VED", "K050", "SED", "NOMPDV", "MB", "LIM", "RGADM", "BC", "BRANCH", "TOBO", "ISP", "NREZID_CODE", "REQ_TYPE", "REQ_STATUS", "CUSTTYPENAME") AS 
  SELECT c.RNK,
          c.TGR,
          c.CUSTTYPE,
          c.COUNTRY,
          c.NMK,
          c.NMKV,
          c.NMKK,
          c.CODCAGENT,
          c.PRINSIDER,
          c.OKPO,
          c.ADR,
          c.SAB,
          c.TAXF,
          c.C_REG,
          c.C_DST,
          c.RGTAX,
          c.DATET,
          c.ADM,
          c.DATEA,
          c.STMT,
          c.DATE_ON,
          c.DATE_OFF,
          c.NOTES,
          c.NOTESEC,
          c.CRISK,
          c.PINCODE,
          c.ND,
          c.RNKP,
          c.ISE,
          c.FS,
          c.OE,
          c.VED,
          c.K050,
          c.SED,
          c.NOMPDV,
          c.MB,
          c.LIM,
          c.RGADM,
          c.BC,
          c.BRANCH,
          c.TOBO,
          c.ISP,
          c.nrezid_code,
          q.req_type,
          CASE
             WHEN NVL (q.req_type, 0) = 1
             THEN
                'Потребує контролю'
             ELSE
                'Підтверджена'
          END
             AS req_status,
          t.name AS custtypename
     FROM customer c, clv_request q, custtype t
    WHERE     c.rnk = q.rnk(+)
          AND c.custtype = t.custtype
          --AND canilookclient (c.rnk) = 1
   UNION ALL
   SELECT c.RNK,
          c.TGR,
          c.CUSTTYPE,
          c.COUNTRY,
          c.NMK,
          c.NMKV,
          c.NMKK,
          c.CODCAGENT,
          c.PRINSIDER,
          c.OKPO,
          c.ADR,
          c.SAB,
          c.TAXF,
          c.C_REG,
          c.C_DST,
          c.RGTAX,
          c.DATET,
          c.ADM,
          c.DATEA,
          c.STMT,
          c.DATE_ON,
          NULL DATE_OFF,
          c.NOTES,
          c.NOTESEC,
          c.CRISK,
          NULL PINCODE,
          c.ND,
          c.RNKP,
          c.ISE,
          c.FS,
          c.OE,
          c.VED,
          c.K050,
          c.SED,
          c.NOMPDV,
          NULL MB,
          NULL LIM,
          c.RGADM,
          0 BC,
          c.BRANCH,
          c.branch TOBO,
          c.ISP,
          c.nrezid_code,
          q.req_type,
          CASE
             WHEN q.req_type = 0 THEN 'Нова'
             ELSE 'Відхилена'
          END
             AS req_status,
          t.name AS custtypename
     FROM clv_customer c, clv_request q, custtype t
    WHERE     c.rnk = q.rnk
          AND q.req_type IN (0, 2)
          AND c.custtype = t.custtype;

PROMPT *** Create  grants  V_CUSTOMER ***
grant SELECT                                                                 on V_CUSTOMER      to BARSREADER_ROLE;
grant FLASHBACK,SELECT                                                       on V_CUSTOMER      to BARS_ACCESS_DEFROLE;
grant SELECT                                                                 on V_CUSTOMER      to CUST001;
grant SELECT                                                                 on V_CUSTOMER      to UPLD;
grant DELETE,FLASHBACK,INSERT,SELECT,UPDATE                                  on V_CUSTOMER      to WR_ALL_RIGHTS;
grant FLASHBACK,SELECT                                                       on V_CUSTOMER      to WR_REFREAD;



PROMPT ===================================================================================== 
PROMPT *** End *** ========== Scripts /Sql/BARS/View/V_CUSTOMER.sql =========*** End *** ===
PROMPT ===================================================================================== 
