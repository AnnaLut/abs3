prompt =======================================================
prompt COBUSUPABS-3949
prompt ----------------
prompt АРМ «Деб.заборг за госп.діяльністю банку»: 
prompt  Щодо додатк.реквізитів: № договору, дата,  та можливо признач.платежу (на загальну суму згідно договору) 
prompt  Після оплати загальної суми платежу розносити на окремі рахунки дебіторської заборгованості , 
prompt  що відповідають рахункам із різними значеннями параметра аналітичного розрізу ОВ22 
prompt  та контролювати закриття загальної суми розрахунків. 
prompt =======================================================

CREATE OR REPLACE FORCE VIEW BARS.OPER_XOZ
(
   REF,
   TT,
   VOB,
   ND,
   PDAT,
   VDAT,
   S,
   DATD,
   NAM_A,
   NLSA,
   NAM_B,
   NLSB,
   MFOB,
   NAZN,
   ID_B,
   KPR
)
AS
   SELECT "REF",
          "TT",
          "VOB",
          "ND",
          "PDAT",
          "VDAT",
          "S/100",
          "DATD",
          "NAM_A",
          "NLSA",
          "NAM_B",
          "NLSB",
          "MFOB",
          "NAZN",
          "ID_B",
          "KPR"
     FROM (SELECT REF,
                  TT,
                  VOB,
                  ND,
                  PDAT,
                  VDAT,
                  S / 100,
                  DATD,
                  NAM_A,
                  NLSA,
                  NAM_B,
                  NLSB,
                  MFOB,
                  NAZN,
                  ID_B,
                  (SELECT COUNT (*) / 2
                     FROM bars.opldok
                    WHERE REF = o.REF)
                     kpr
             FROM bars.oper o
            WHERE     kv = kv2
                  AND kv = 980
                  AND sos > 0
                  AND O.USERID = bars.USER_ID
                  AND pdat >= TRUNC (SYSDATE))
    WHERE kpr = 1;

/  