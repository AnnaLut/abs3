CREATE OR REPLACE FORCE VIEW BARS.V_TMP_T605
(
   MD,
   ND,
   G01,
   G02,
   G03,
   G04,
   G05,
   G06,
   G07,
   IR,
   G08,
   G09,
   G10,
   G11,
   NCOL
)
AS
   SELECT "MD",
          "ND",
          "G01",
          "G02",
          "G03",
          "G04",
           CASE
             WHEN G04 = G06 then G05
             ELSE G05 + G06 end G05,
          "G06",
          "G07",
          CASE
             WHEN G08 > 0
             THEN
                G08
             WHEN G08 = 0
             THEN
                BARS.getbrat (G01,
                              100,
                              980,
                              0)*2
             ELSE
                G08
          END AS IR,
          CASE
             WHEN G08 > 0
             THEN
                G08 / 2
             WHEN G08 = 0
             THEN
                BARS.getbrat (G01,
                              100,
                              980,
                              0)
             ELSE
                G08
          END
             AS G08,
          CASE WHEN G09 < 0 THEN G09 * -1 ELSE G09 END AS G09,
          "G10",
          TRUNC (G11, 2) "G11",
          "NCOL"
     FROM tmp_t605;


GRANT SELECT ON BARS.V_TMP_T605 TO BARS_ACCESS_DEFROLE;