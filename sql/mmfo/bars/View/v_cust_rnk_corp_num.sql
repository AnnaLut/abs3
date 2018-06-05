CREATE OR REPLACE FORCE VIEW BARS.V_CUST_RNK_CORP_NUM
(
   RNK,
   CORP_NUM
)
AS
   SELECT cw.rnk, cw.VALUE AS corp_num
     FROM customerw cw
    WHERE cw.tag = 'OBPCP';
/
grant select on V_CUST_RNK_CORP_NUM to BARS_ACCESS_DEFROLE;
/