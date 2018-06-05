CREATE OR REPLACE FORCE VIEW BARS.V_CUST_RNK_BUS_LINE
(
   RNK,
   BUS_LINE
)
AS
   SELECT cw.rnk, cw.VALUE AS bus_line
     FROM customerw cw
    WHERE cw.tag = 'BUSSL';
/    
grant select on V_CUST_RNK_BUS_LINE to BARS_ACCESS_DEFROLE;
/