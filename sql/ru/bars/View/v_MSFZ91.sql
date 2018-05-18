CREATE OR REPLACE FORCE VIEW BARS.V_MSFZ91 as 
select X.* FROM 
(SELECT d.vidd, d.nd, d.sdate, d.wdate, d.sos, d.rnk, d.cc_id, a.kv, COUNT (*) kol,
    SUM (DECODE (a.tip, 'SS ', decode (a.dazs, null,1,0), 0)) SS, -SUM (DECODE (a.tip, 'SS ', a.ostc, 0)) / 100 SS1,
    SUM (DECODE (a.tip, 'SS ', decode (a.dazs, null,0,1), 0)) SX, 
    SUM (DECODE (a.tip, 'SN ', 1, 0)) SN , -SUM (DECODE (a.tip, 'SN ', a.ostc, 0)) / 100 SN1,
    SUM (DECODE (a.tip, 'SP ', 1, 0)) SP , -SUM (DECODE (a.tip, 'SP ', a.ostc, 0)) / 100 SP1,
    SUM (DECODE (a.tip, 'SDI', 1, 0)) SDI, -SUM (DECODE (a.tip, 'SDI', a.ostc, 0)) / 100 SDI1,
    SUM (DECODE (a.tip, 'SPN', 1, 0)) SPN, -SUM (DECODE (a.tip, 'SPN', a.ostc, 0)) / 100 SPN1,
    SUM (DECODE (a.tip, 'SNA', 1, 0)) SNA, -SUM (DECODE (a.tip, 'SNA', a.ostc, 0)) / 100 SNA1,
    SUM (DECODE (a.tip, 'SNO', 1, 0)) SNO, -SUM (DECODE (a.tip, 'SNO', a.ostc, 0)) / 100 SNO1,
    SUM (DECODE (a.tip, 'S36', 1, 0)) S36, -SUM (DECODE (a.tip, 'S36', a.ostc, 0)) / 100 S361,
    SUM (DECODE (a.tip, 'ISG', 1, 0)) ISG, -SUM (DECODE (a.tip, 'ISG', a.ostc, 0)) / 100 ISG1,
    SUM (DECODE (a.tip, 'SG ', 1, 0)) SG , -SUM (DECODE (a.tip, 'SG ', a.ostc, 0)) / 100 SG1
 FROM bars.cc_deal d, bars.nd_acc n, bars.accounts a
 WHERE     d.vidd IN (2, 3)   AND a.acc = n.acc   AND n.nd = d.nd
    AND a.tip NOT IN ('LIM','SK9','SD ','ODB','ZZI')
--    and a.dazs is null 
    and ( a.dazs is null or a.dazs is not null and a.tip ='SS ') 
    AND d.rnk = a.rnk AND a.nls < '4' AND a.nls > '2' AND a.nbs NOT LIKE '357_'  AND d.sos < 14 AND d.ndg IS NULL
           --   and d.nd = 108067
 GROUP BY d.vidd, d.nd, d.sdate, d.wdate, d.sos, a.kv, d.rnk, d.cc_id
) x;

 
 GRANT SELECT ON bars.v_MSFZ91  TO BARS_ACCESS_DEFROLE;