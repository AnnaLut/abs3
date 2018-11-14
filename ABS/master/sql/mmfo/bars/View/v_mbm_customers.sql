/* Formatted on 03/08/2018 14:20:07 (QP5 v5.267.14150.38573) */
PROMPT View V_MBM_CUSTOMERS;
--
-- V_MBM_CUSTOMERS  (View)
--

CREATE OR REPLACE FORCE VIEW BARS.V_MBM_CUSTOMERS
(
   RNK,
   TGR,
   CUSTTYPE,
   COUNTRY,
   NMK,
   NMKV,
   NMKK,
   CODCAGENT,
   PRINSIDER,
   OKPO,
   ADR,
   SAB,
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
   SED,
   LIM,
   MB,
   RGADM,
   BC,
   BRANCH,
   TOBO,
   ISP,
   TAXF,
   NOMPDV,
   K050,
   NREZID_CODE,
   PHONE,
   BANK_NAME,
   ADDRESS_BANK,
   TORG_ACC,
   BUY_COM,
   SELL_COM,
   KONV_COM,
   BANK_DATE
)
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
          (SELECT    ca.zip
                  || ', '
                  || (SELECT name
                        FROM bars.country
                       WHERE country = ca.country)
				  || ', ' || ca.locality || 
                  || ', '
                  || ca.address
             FROM bars.customer_address ca
            WHERE ca.rnk = c.rnk AND ca.type_id = 1)
             adr,
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
          (SELECT p.telw
             FROM bars.person p
            WHERE p.rnk = c.rnk)
             phone,
          (SELECT t.val
             FROM params t
            WHERE t.par = 'NAME')
             bank_name,
          (SELECT bav.attribute_value
             FROM branch_attribute_value bav
            WHERE     bav.attribute_code = 'ADDRESS'
                  AND bav.branch_code = '/' || c.kf || '/')
             address_bank,
          cz.NLS29 torg_acc,
          cz.kom buy_com,
          cz.kom2 sell_com,
          cz.kom3 konv_com,
          GL.BD AS BANK_DATE
     FROM bars.customer c LEFT JOIN bars.cust_zay cz ON (c.rnk = cz.rnk)
    WHERE custtype IN (2, 3)
/

COMMENT ON TABLE BARS.V_MBM_CUSTOMERS IS 'Клієнти доступні для підлючення до мобільного банкінгу'
/



Prompt Grants on VIEW V_MBM_CUSTOMERS TO BARSREADER_ROLE to BARSREADER_ROLE;
GRANT SELECT ON BARS.V_MBM_CUSTOMERS TO BARSREADER_ROLE
/

Prompt Grants on VIEW V_MBM_CUSTOMERS TO BARS_ACCESS_DEFROLE to BARS_ACCESS_DEFROLE;
GRANT SELECT ON BARS.V_MBM_CUSTOMERS TO BARS_ACCESS_DEFROLE
/

Prompt Grants on VIEW V_MBM_CUSTOMERS TO UPLD to UPLD;
GRANT SELECT ON BARS.V_MBM_CUSTOMERS TO UPLD
/
