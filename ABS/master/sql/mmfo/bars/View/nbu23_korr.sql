

PROMPT ===================================================================================== 
PROMPT *** Run *** ========== Scripts /Sql/BARS/View/NBU23_KORR.sql =========*** Run *** ===
PROMPT ===================================================================================== 


PROMPT *** Create  view NBU23_KORR ***

  CREATE OR REPLACE FORCE VIEW BARS.NBU23_KORR ("RNK", "ND", "WDATE", "CC_ID", "VIDD", "FIN23", "OBS23", "KAT23", "K23", "TOBO", "VNCRR", "KHIST", "NEINF") AS 
  SELECT a.RNK, a.acc, a.mdate, a.nls, TO_NUMBER (a.nbs), c.crisk,q.OBS, q.KAT, q.K, a.tobo,
 (select nt.value  VNCRR  from accountsw nt  where nt.acc  = a.acc and nt.tag ='VNCRR'),
 (select nt.value  KHIST  from accountsw nt  where nt.acc  = a.acc and nt.tag ='KHIST'),
 (select nt.value  NEINF  from accountsw nt  where nt.acc  = a.acc and nt.tag ='NEINF')
  FROM v_gl a, ACC_FIN_OBS_KAT q,customer c
 WHERE a.acc = q.acc(+) AND a.dazs IS NULL  and a.rnk=c.rnk
          AND A.nbs IN
                 ('1500', '1502', '1508', '1509');

PROMPT *** Create  grants  NBU23_KORR ***
grant SELECT                                                                 on NBU23_KORR      to BARSREADER_ROLE;
grant SELECT,UPDATE                                                          on NBU23_KORR      to BARS_ACCESS_DEFROLE;
grant SELECT,UPDATE                                                          on NBU23_KORR      to START1;
grant SELECT                                                                 on NBU23_KORR      to UPLD;



PROMPT ===================================================================================== 
PROMPT *** End *** ========== Scripts /Sql/BARS/View/NBU23_KORR.sql =========*** End *** ===
PROMPT ===================================================================================== 
