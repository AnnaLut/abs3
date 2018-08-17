DROP VIEW BARS.V_ASVO_IMMOBILE_SEND2RU;

/* Formatted on 03.07.2018 10:41:55 (QP5 v5.265.14096.37972) */
CREATE OR REPLACE FORCE VIEW BARS.V_ASVO_IMMOBILE_SEND2RU
(
   TVBV,
   KEY,
   FIO,
   IDCODE,
   DOCTYPE,
   PASP_S,
   PASP_N,
   PASP_W,
   PASP_D,
   BIRTHDAT,
   BIRTHPL,
   SEX,
   POSTIDX,
   REGION,
   DISTRICT,
   CITY,
   ADDRESS,
   PHONE_H,
   PHONE_J,
   LANDCOD,
   REGDATE,
   DEPCODE,
   DEPVIDNAME,
   ACC_CARD,
   DEPNAME,
   NLS,
   ID,
   DATO,
   OST,
   SUM,
   DATN,
   ATTR,
   MARK,
   VER,
   KOD_OTD,
   BRANCH,
   BSD,
   OB22DE,
   BSN,
   OB22IE,
   BSD7,
   OB22D7,
   FL,
   DZAGR,
   REF,
   SOURCE,
   KV,
   ND,
   DPTID,
   ERRMSG,
   BATCH_ID,
   STATUS
)
AS
     SELECT a."TVBV",
            a."KEY",
            a."FIO",
            a."IDCODE",
            a."DOCTYPE",
            a."PASP_S",
            a."PASP_N",
            a."PASP_W",
            a."PASP_D",
            a."BIRTHDAT",
            a."BIRTHPL",
            a."SEX",
            a."POSTIDX",
            a."REGION",
            a."DISTRICT",
            a."CITY",
            a."ADDRESS",
            a."PHONE_H",
            a."PHONE_J",
            a."LANDCOD",
            a."REGDATE",
            a."DEPCODE",
            a."DEPVIDNAME",
            a."ACC_CARD",
            a."DEPNAME",
            a."NLS",
            a."ID",
            a."DATO",
            a."OST",
            a."SUM",
            a."DATN",
            a."ATTR",
            a."MARK",
            a."VER",
            a."KOD_OTD",
            a."BRANCH",
            a."BSD",
            a."OB22DE",
            a."BSN",
            a."OB22IE",
            a."BSD7",
            a."OB22D7",
            a."FL",
            a."DZAGR",
            a."REF",
            a."SOURCE",
            a."KV",
            a."ND",
            a."DPTID",
            a."ERRMSG",
            a."BATCH_ID",
            f.status
       FROM asvo_immobile a, asvo_immobile_fl f
      WHERE     a.fl = f.fl
            AND a.ost <
                   CASE kv
                      WHEN 980 THEN 10000
                    /*  WHEN 978 THEN 100  -- COBUMMFO-8455
                      WHEN 840 THEN 100
                      WHEN 398 THEN 25500
                      WHEN 36 THEN 100
                      WHEN 826 THEN 100
                      WHEN 124 THEN 100
                      WHEN 756 THEN 100
                      WHEN 985 THEN 600
                      WHEN 643 THEN 8500
                      WHEN 348 THEN 40000
                      ELSE 100*/
                   END
            AND '/' || f_ourmfo || a.branch LIKE
                      SUBSTR (SYS_CONTEXT ('bars_context', 'user_branch'),
                              1,
                              15)
                   || '%'
            AND a.fl = 5
   ORDER BY a.FIO;


GRANT SELECT ON BARS.V_ASVO_IMMOBILE_SEND2RU TO BARS_ACCESS_DEFROLE;
