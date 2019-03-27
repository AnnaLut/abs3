/* Formatted on 17/04/2018 13:11:06 (QP5 v5.227.12220.39724) */
CREATE OR REPLACE VIEW BARS.V_NBUR_#C5_DTL_TMP
(
   NBUC,
   FIELD_CODE,
   SEG_01,
   SEG_02,
   SEG_03,
   SEG_04,
   SEG_05,
   SEG_06,
   SEG_07,
   SEG_08,
   SEG_09,
   SEG_10,
   FIELD_VALUE,
   DESCRIPTION,
   ACC_ID,
   ACC_NUM,
   KV,
   MATURITY_DATE,
   CUST_ID,
   ND,
   REF
)
AS
   SELECT p.NBUC,
          p.kodp FIELD_CODE,
          SUBSTR (p.kodp, 1, 1) AS SEG_01,
          SUBSTR (p.kodp, 2, 4) AS SEG_02,
          SUBSTR (p.kodp, 6, 1) AS SEG_03,
          SUBSTR (p.kodp, 7, 1) AS SEG_04,
          SUBSTR (p.kodp, 8, 3) AS SEG_05,
          SUBSTR (p.kodp, 11, 1) AS SEG_06,
          SUBSTR (p.kodp, 12, 1) AS SEG_07,
          SUBSTR (p.kodp, 13, 3) AS SEG_08,
          SUBSTR (p.kodp, 16, 1) AS SEG_09,
          SUBSTR (p.kodp, 17, 1) AS SEG_10,
          p.znap FIELD_VALUE,
          p.comm DESCRIPTION,
          p.acc ACC_ID,
          p.nls ACC_NUM,
          p.KV,
          p.mdate MATURITY_DATE,
          p.rnk CUST_ID,
          p.ND,
          p.REF
     FROM rnbu_trace p;
/	