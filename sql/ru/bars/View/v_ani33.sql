CREATE OR REPLACE FORCE VIEW BARS.V_ANI33
(
   SROK,
   KV,
   S01,
   S02,
   S21,
   S22,
   S03,
   S04,
   S05,
   S24,
   S25,
   S06,
   S07,
   S17,
   S08,
   S09,
   S10,
   S11,
   P01,
   P02,
   P21,
   P22,
   P03,
   P04,
   P05,
   P24,
   P25,
   P06,
   P07,
   P17,
   P08,
   P09,
   P10,
   P11,
   SNET,
   SAKT,
   SPAS,
   FX_SWAP_IN_UAH,
   FX_SWAP_OUT_UAH,
   CASH_REST_1001_1004,
   CASH_REST_1001_1017
)
AS
    SELECT SROK,
          kv,
          s01,
         round( s02, 4)  s02,
         round( s21, 4)  s21,
         round( s22, 4)  s22,
         round( s03, 4)  s03,
         round( s04, 4)  s04,
         round( s05, 4)  s05,
         round( s24, 4)  s24,
         round( s25, 4)  s25,
         round( s06, 4)  s06,
         round( s07, 4)  s07,
         round( s17, 4)  s17,
         round( s08, 4)  s08,
         round( s09, 4)  s09,
         round( s10, 4)  s10,
         round( s11, 4)  s11,
          p01,
          round(p02,4) p02,
          p21,
          p22,
          round(p03,4) p03,
          p04,
          p05,
          p24,
          p25,
          p06,
          p07,
          p17,
          p08,
          p09,
          p10,
          p11,
         round((+s03 + s06),4) SNET,
         round(  (+S06 + s07 + s08 + s09),4) SAKT,
         round( (+S03 + s17 + s10 + s11),4) SPAS,
         round( s26 + s27,4) fx_swap_in_UAH,
         round( s28 + s29,4) fx_swap_out_UAH,
         round( s30,4) CASH_REST_1001_1004,
          s31 CASH_REST_1001_1017
     FROM (  SELECT    SUBSTR (TO_CHAR (srok), 7, 2)
                    || '.'
                    || SUBSTR (TO_CHAR (srok), 5, 2)
                    || '.'
                    || SUBSTR (TO_CHAR (srok), 1, 4)
                       SROK,
                    kv,
                    --       substr(to_char(srok),1,4) ||'.' || substr(to_char(srok),5,2)  || '.' ||  substr(to_char(srok),7,2) SROK, kv,
                    SUM (DECODE (pr, 1, n1, 0)) / 100 s01,
                    SUM (DECODE (pr, 1, n2, 0)) p01,  -- Залучено~МБК овернайт
                    SUM (DECODE (pr, 2, n1, 0)) / 100 s02,
                    SUM (DECODE (pr, 2, n2, 0)) p02,  -- Залучено~МБК строкові
                    SUM (DECODE (pr, 21, n1, 0)) / 100 s21,
                    SUM (DECODE (pr, 21, n2, 0)) p21, -- Залучено~ДЕПО-СВОП овернайт
                    SUM (DECODE (pr, 22, n1, 0)) / 100 s22,
                    SUM (DECODE (pr, 22, n2, 0)) p22, -- Залучено~ДЕПО-СВОП строкові
                      ------------
                      SUM (CASE WHEN pr IN (1, 2, 21, 22) THEN N1 ELSE 0 END)
                    / 100
                       s03,                         -- Залучено~МБК+DSW ВСЬОГО
                    DIV0 (
                       SUM (
                          CASE
                             WHEN pr IN (1, 2, 21, 22) THEN N1 * N2
                             ELSE 0
                          END),
                       SUM (CASE WHEN pr IN (1, 2, 21, 22) THEN N1 ELSE 0 END))
                       p03,
                    ---------------
                    SUM (DECODE (pr, 4, n1, 0)) / 100 s04,
                    SUM (DECODE (pr, 4, n2, 0)) p04, -- Розмiщено~МБК овернайт
                    SUM (DECODE (pr, 5, n1, 0)) / 100 s05,
                    SUM (DECODE (pr, 5, n2, 0)) p05, -- Розмiщено~МБК строкові
                    SUM (DECODE (pr, 24, n1, 0)) / 100 s24,
                    SUM (DECODE (pr, 24, n2, 0)) p24, -- Розмiщено~ДЕПО-СВОП овернайт
                    SUM (DECODE (pr, 25, n1, 0)) / 100 s25,
                    SUM (DECODE (pr, 25, n2, 0)) p25, -- Розмiщено~ДЕПО-СВОП строкові
                      ------------
                      SUM (CASE WHEN pr IN (4, 5, 24, 25) THEN N1 ELSE 0 END)
                    / 100
                       s06,                        -- Розмiщено~МБК+DSW ВСЬОГО
                    DIV0 (
                       SUM (
                          CASE
                             WHEN pr IN (4, 5, 24, 25) THEN N1 * N2
                             ELSE 0
                          END),
                       SUM (CASE WHEN pr IN (4, 5, 24, 25) THEN N1 ELSE 0 END))
                       p06,
                    ---------------
                    SUM (DECODE (pr, 7, n1, 0)) / 100 s07,
                    SUM (DECODE (pr, 7, n2, 0)) p07, -- Розмiщено~РЕПО~з/без перех
                    SUM (DECODE (pr, 17, n1, 0)) / 100 s17,
                    SUM (DECODE (pr, 17, n2, 0)) p17, -- Залучено~РЕПО~з/без перех/ 1622
                    SUM (DECODE (pr, 8, n1, 0)) / 100 s08,
                    SUM (DECODE (pr, 8, n2, 0)) p08,        -- Деп.сертиф.~НБУ
                    SUM (DECODE (pr, 09, n1, 0)) / 100 s09,
                    SUM (DECODE (pr, 09, n2, 0)) p09,    -- Розмiщено~НБУ РЕПО
                    SUM (DECODE (pr, 10, n1, 0)) / 100 s10,
                    SUM (DECODE (pr, 10, n2, 0)) p10, -- Залучено~НБУ овернайт
                    SUM (DECODE (pr, 11, n1, 0)) / 100 s11,
                    SUM (DECODE (pr, 11, n2, 0)) p11,     -- Залучено~НБУ РЕПО
                    SUM (DECODE (pr, 26, n1, 0)) / 100 s26, -- Розмiщено UAH овернайт
                    SUM (DECODE (pr, 27, n1, 0)) / 100 s27, -- Розмiщено UAH строкові
                    SUM (DECODE (pr, 28, n1, 0)) / 100 s28, -- Залучено UAH овернайт
                    SUM (DECODE (pr, 29, n1, 0)) / 100 s29, -- Залучено UAH строкові
                    SUM (DECODE (pr, 30, n1, 0)) / 100 s30, -- Остатки по 1001-1004
                    SUM (DECODE (pr, 31, n1, 0)) / 100 s31 -- Остатки по 1001-1017
               FROM CCK_AN_TMP
           GROUP BY srok, kv
           UNION ALL
             SELECT '*Срд.зваж.' SROK,
                    kv,
                      div0 (SUM (DECODE (pr, 1, n1, 0)),
                            TO_NUMBER (pul.Get_Mas_Ini_Val ('KOL')))
                    / 100
                       S01,
                    div0 (SUM (DECODE (pr, 1, n1 * n2, 0)),
                          SUM (DECODE (pr, 1, n1, 0)))
                       P01,
                      div0 (SUM (DECODE (pr, 2, n1, 0)),
                            TO_NUMBER (pul.Get_Mas_Ini_Val ('KOL')))
                    / 100
                       S02,
                    div0 (SUM (DECODE (pr, 2, n1 * n2, 0)),
                          SUM (DECODE (pr, 2, n1, 0)))
                       P02,
                      div0 (SUM (DECODE (pr, 21, n1, 0)),
                            TO_NUMBER (pul.Get_Mas_Ini_Val ('KOL')))
                    / 100
                       S21,
                    div0 (SUM (DECODE (pr, 21, n1 * n2, 0)),
                          SUM (DECODE (pr, 21, n1, 0)))
                       P21,
                      div0 (SUM (DECODE (pr, 22, n1, 0)),
                            TO_NUMBER (pul.Get_Mas_Ini_Val ('KOL')))
                    / 100
                       S22,
                    div0 (SUM (DECODE (pr, 22, n1 * n2, 0)),
                          SUM (DECODE (pr, 22, n1, 0)))
                       P22,
                      -------
                      div0 (
                         SUM (
                            CASE WHEN pr IN (1, 2, 21, 22) THEN N1 ELSE 0 END),
                         TO_NUMBER (pul.Get_Mas_Ini_Val ('KOL')))
                    / 100
                       S03,
                    div0 (
                       SUM (
                          CASE
                             WHEN pr IN (1, 2, 21, 22) THEN N1 * N2
                             ELSE 0
                          END),
                       SUM (CASE WHEN pr IN (1, 2, 21, 22) THEN N1 ELSE 0 END))
                       P03,
                      -------
                      div0 (SUM (DECODE (pr, 4, n1, 0)),
                            TO_NUMBER (pul.Get_Mas_Ini_Val ('KOL')))
                    / 100
                       S04,
                    div0 (SUM (DECODE (pr, 4, n1 * n2, 0)),
                          SUM (DECODE (pr, 4, n1, 0)))
                       P04,
                      div0 (SUM (DECODE (pr, 5, n1, 0)),
                            TO_NUMBER (pul.Get_Mas_Ini_Val ('KOL')))
                    / 100
                       S05,
                    div0 (SUM (DECODE (pr, 5, n1 * n2, 0)),
                          SUM (DECODE (pr, 5, n1, 0)))
                       P05,
                      div0 (SUM (DECODE (pr, 24, n1, 0)),
                            TO_NUMBER (pul.Get_Mas_Ini_Val ('KOL')))
                    / 100
                       S24,
                    div0 (SUM (DECODE (pr, 24, n1 * n2, 0)),
                          SUM (DECODE (pr, 24, n1, 0)))
                       P24,
                      div0 (SUM (DECODE (pr, 25, n1, 0)),
                            TO_NUMBER (pul.Get_Mas_Ini_Val ('KOL')))
                    / 100
                       S25,
                    div0 (SUM (DECODE (pr, 25, n1 * n2, 0)),
                          SUM (DECODE (pr, 25, n1, 0)))
                       P25,
                      ------------
                      div0 (
                         SUM (
                            CASE WHEN pr IN (4, 5, 24, 25) THEN N1 ELSE 0 END),
                         TO_NUMBER (pul.Get_Mas_Ini_Val ('KOL')))
                    / 100
                       S06,
                    div0 (
                       SUM (
                          CASE
                             WHEN pr IN (4, 5, 24, 25) THEN N1 * N2
                             ELSE 0
                          END),
                       SUM (CASE WHEN pr IN (4, 5, 24, 25) THEN N1 ELSE 0 END))
                       P06,
                      --------
                      div0 (SUM (DECODE (pr, 7, n1, 0)),
                            TO_NUMBER (pul.Get_Mas_Ini_Val ('KOL')))
                    / 100
                       S07,
                    div0 (SUM (DECODE (pr, 07, n1 * n2, 0)),
                          SUM (DECODE (pr, 07, n1, 0)))
                       P07,
                      div0 (SUM (DECODE (pr, 17, n1, 0)),
                            TO_NUMBER (pul.Get_Mas_Ini_Val ('KOL')))
                    / 100
                       S17,
                    div0 (SUM (DECODE (pr, 17, n1 * n2, 0)),
                          SUM (DECODE (pr, 17, n1, 0)))
                       P17,
                      div0 (SUM (DECODE (pr, 8, n1, 0)),
                            TO_NUMBER (pul.Get_Mas_Ini_Val ('KOL')))
                    / 100
                       S08,
                    div0 (SUM (DECODE (pr, 08, n1 * n2, 0)),
                          SUM (DECODE (pr, 08, n1, 0)))
                       P08,
                      div0 (SUM (DECODE (pr, 9, n1, 0)),
                            TO_NUMBER (pul.Get_Mas_Ini_Val ('KOL')))
                    / 100
                       S09,
                    div0 (SUM (DECODE (pr, 09, n1 * n2, 0)),
                          SUM (DECODE (pr, 09, n1, 0)))
                       P09,
                      div0 (SUM (DECODE (pr, 10, n1, 0)),
                            TO_NUMBER (pul.Get_Mas_Ini_Val ('KOL')))
                    / 100
                       S10,
                    div0 (SUM (DECODE (pr, 10, n1 * n2, 0)),
                          SUM (DECODE (pr, 10, n1, 0)))
                       P10,
                      div0 (SUM (DECODE (pr, 11, n1, 0)),
                            TO_NUMBER (pul.Get_Mas_Ini_Val ('KOL')))
                    / 100
                       S11,
                    div0 (SUM (DECODE (pr, 11, n1 * n2, 0)),
                          SUM (DECODE (pr, 11, n1, 0)))
                       P11,
                      div0 (SUM (DECODE (pr, 26, n1, 0)),
                            TO_NUMBER (pul.Get_Mas_Ini_Val ('KOL')))
                    / 100
                       S26,
                      div0 (SUM (DECODE (pr, 27, n1, 0)),
                            TO_NUMBER (pul.Get_Mas_Ini_Val ('KOL')))
                    / 100
                       S27,
                      div0 (SUM (DECODE (pr, 28, n1, 0)),
                            TO_NUMBER (pul.Get_Mas_Ini_Val ('KOL')))
                    / 100
                       S28,
                      div0 (SUM (DECODE (pr, 29, n1, 0)),
                            TO_NUMBER (pul.Get_Mas_Ini_Val ('KOL')))
                    / 100
                       S29,
                    ROUND (
                         div0 (SUM (DECODE (pr, 30, n1, 0)),
                               TO_NUMBER (pul.Get_Mas_Ini_Val ('KOL')))
                       / 100,
                       2)
                       S30,
                    ROUND (
                         div0 (SUM (DECODE (pr, 31, n1, 0)),
                               TO_NUMBER (pul.Get_Mas_Ini_Val ('KOL')))
                       / 100,
                       2)
                       S31
               FROM CCK_AN_TMP
           GROUP BY kv);


GRANT SELECT ON BARS.V_ANI33 TO BARS_ACCESS_DEFROLE;

GRANT SELECT ON BARS.V_ANI33 TO START1;
