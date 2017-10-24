

PROMPT ===================================================================================== 
PROMPT *** Run *** ========== Scripts /Sql/BARS/View/V_CVK_CA.sql =========*** Run *** =====
PROMPT ===================================================================================== 


PROMPT *** Create  view V_CVK_CA ***

  CREATE OR REPLACE FORCE VIEW BARS.V_CVK_CA ("MFO", "NB", "NLS", "DAOS", "VID", "TVO", "NAME_BLOK", "FIO_BLOK", "FIO_ISP", "INF_ISP", "ADDR", "OKPO") AS 
  select substr(f_ourmfo,1,9) mfo,
       (select substr(val,1,38) from branch_parameters where tag = 'NAME_BRANCH' and branch = s.branch) nb,
       s.nls, s.daos,
       decode(s.vid,13,'1',14,'2','3') vid,
       (select nvl(min(substr(value,1,3)),0) from accountsw where acc = s.acc and tag = 'CVK_TVO') tvo,
       (select min(substr(value,1,38)) from accountsw where acc = s.acc and tag = 'CVK_BLOK') name_blok,
       (select min(substr(value,1,76)) from accountsw where acc = s.acc and tag = 'CVK_FIOR') fio_blok,
       substr(t.fio,1,38) fio_isp,
       (select min(substr(value,1,38)) from accountsw where acc = s.acc and tag = 'CVK_INF') inf_isp,
       (select substr(val,1,38) from branch_parameters where tag = 'ADR_BRANCH' and branch = s.branch) addr,
       c.okpo
  from accounts s, staff t, customer c
 where substr(s.nbs,1,3) = '264' and s.dazs is null
   and s.isp = t.id
   and s.rnk = c.rnk;

PROMPT *** Create  grants  V_CVK_CA ***
grant SELECT                                                                 on V_CVK_CA        to BARS_ACCESS_DEFROLE;
grant SELECT                                                                 on V_CVK_CA        to RPBN002;



PROMPT ===================================================================================== 
PROMPT *** End *** ========== Scripts /Sql/BARS/View/V_CVK_CA.sql =========*** End *** =====
PROMPT ===================================================================================== 
