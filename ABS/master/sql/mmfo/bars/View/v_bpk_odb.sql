

PROMPT ===================================================================================== 
PROMPT *** Run *** ========== Scripts /Sql/BARS/View/V_BPK_ODB.sql =========*** Run *** ====
PROMPT ===================================================================================== 


PROMPT *** Create  view V_BPK_ODB ***

  CREATE OR REPLACE FORCE VIEW BARS.V_BPK_ODB ("ACC", "BRANCH", "RNK", "CUSTTYPE", "DAOS", "ACC_TYPE", "CURR", "CLIENT_N", "COND_SET", "TYPE", "LACCT", "BRN", "CRD", "ID_A", "KK", "WORK", "REG_NR", "PHONE", "CNTRY", "PCODE", "CITY", "STREET", "OFFICE", "PHONE_W", "CNTRY_W", "PCODE_W", "CITY_W", "STREET_W", "MIN_BAL", "DEPOSIT", "RESIDENT", "NAME", "ID_C", "B_DATE", "M_NAME", "MT", "FLAG_ODB") AS 
  select a.acc, a.branch, c.rnk, c.custtype, a.daos,
       m.type ACC_TYPE,
       t.lcv CURR,
       rpad(substr(c.nmk,1,40),40) CLIENT_N,
       (select min(to_number(substr(demand_cond_set,1,3))) from specparam_int where acc = a.acc) COND_SET,
       decode(c.custtype,3,decode(nvl(trim(c.sed),'00'),'91','F','T'),'F') TYPE,
       a.nls LACCT,
       rpad((select min(demand_brn) from specparam_int where acc = a.acc),5) BRN,
       a.lim/100 CRD,
       c.okpo ID_A,
       i.demand_kk KK,
       rpad((select min(substr(value,1,30)) from accountsw where acc = a.acc and tag='PK_WORK'),30) WORK,
       null REG_NR,
       rpad(substr(p.teld,1,11),11) PHONE,
       rpad(substr(ct.name,1,15),15) CNTRY,
       (select min(substr(value,1,6)) from customerw where rnk = c.rnk and tag='FGIDX') PCODE,
       rpad((select min(substr(value,1,15)) from customerw where rnk = c.rnk and tag='FGTWN'),15) CITY,
       rpad((select min(substr(value,1,30)) from customerw where rnk = c.rnk and tag='FGADR'),30) STREET,
       rpad((select min(substr(value,1,25)) from accountsw where acc = a.acc and tag='PK_OFFIC'),25) OFFICE,
       rpad(substr(p.telw,1,11),11) PHONE_W,
       rpad((select min(substr(value,1,15)) from accountsw where acc = a.acc and tag='PK_CNTRW'),15) CNTRY_W,
       (select min(substr(value,1,6)) from accountsw where acc = a.acc and tag='PK_PCODW') PCODE_W,
       rpad((select min(substr(value,1,15)) from accountsw where acc = a.acc and tag='PK_CITYW'),15) CITY_W,
       rpad((select min(substr(value,1,30)) from accountsw where acc = a.acc and tag='PK_STRTW'),30) STREET_W,
       0 MIN_BAL,
       0 DEPOSIT,
       decode(d.rezid,1,'T','F') RESIDENT,
       rpad((select min(substr(value,1,24)) from accountsw where acc = a.acc and tag='PK_NAME'),24) NAME,
       rpad(substr(p.ser||p.numdoc,1,14),14) ID_C,
       null B_DATE,
       rpad((select min(substr(value,1,20)) from customerw where rnk = c.rnk and tag='PC_MF'),20) M_NAME,
       null MT,
       nvl(w.value, 0) flag_odb
  from accounts a, tabval$global t, bpk_acc o, customer c, person p,
       codcagent d, country ct, demand_acc_type m, specparam_int i, accountsw w
 where a.kv = t.kv
   and a.dazs is null
   and a.acc = o.acc_pk
   and a.rnk = c.rnk
   and c.rnk = p.rnk(+)
   and c.codcagent = d.codcagent
   and c.country = ct.country(+)
   and a.tip = m.tip
   and a.acc = i.acc
   and a.acc = w. acc(+) and w.tag(+) = 'PK_ODB';

PROMPT *** Create  grants  V_BPK_ODB ***
grant SELECT                                                                 on V_BPK_ODB       to BARS_ACCESS_DEFROLE;
grant SELECT                                                                 on V_BPK_ODB       to OBPC;



PROMPT ===================================================================================== 
PROMPT *** End *** ========== Scripts /Sql/BARS/View/V_BPK_ODB.sql =========*** End *** ====
PROMPT ===================================================================================== 
