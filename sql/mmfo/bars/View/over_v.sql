

PROMPT ===================================================================================== 
PROMPT *** Run *** ========== Scripts /Sql/BARS/View/OVER_V.sql =========*** Run *** =======
PROMPT ===================================================================================== 


PROMPT *** Create  view OVER_V ***

  CREATE OR REPLACE FORCE VIEW BARS.OVER_V ("FLAG", "ND", "SOS", "DNEY", "RNK", "NMK", "BLKD", "KV", "MDATE", "NDOC", "ACC_2600", "NLS_2600", "OST_2600", "LIM_2600", "DOS_2600", "DAPP_2600", "ACC_2000", "NLS_2000", "OST_2000", "SD_2600", "ACC_2008", "NLS_2008", "OST_2008", "INT_2000", "DATD2", "CRISK", "ACC_9129", "ACC_8000", "NLS_3578", "OST_3578", "FIN", "OBS", "S080", "USERID", "OBSNAME", "NLS_9129", "OST_9129", "DATD", "NLS_2067", "NLS_2096", "OST_2096", "ACC_2096", "NLS_2480", "OST_2480", "ACC_2480") AS 
  select
rr.flag,
rr.nd,
nvl(rr.sos,0),
rr.day||decode(rr.tipo,7,'b',14,'k',' '),
c.rnk,
c.nmk,
decode(rr.tip,'BLD',1,0) blkd,
rr.kv,
rr.mdate,
rr.ndoc,
rr.acc,
rr.nls,
decode(nvl(rr.sos,0),0,rr.ostc,ostco),
decode(rr.acco,rr.acc,rr.lim,0),
rr.dos,
rr.dapp,
rr.acco,
decode(rr.acco,rr.acc,to_number(null),rr.nlso),
decode(sign(rr.OSTCO),-1,rr.OSTCO,0),
rr.sd,
rr.acco_i,
rr.NLSO_I,
rr.OSTCO_I,
ACRN.FPROC(rr.acco),
rr.datd2,
f.name,
nvl(rr.ACC_9129,0),
nvl(rr.ACC_8000,0),
rr.NLS_8000_I,
abs(OSTC_8000_I),
c.crisk,
rr.obs,
s.s080,
rr.userid,
so.name,
rr.NLS_9129,
abs(rr.OSTC_9129),
rr.datd,
rr.NLS_2067,
rr.NLS_2096,
rr.ostc_2096,
rr.acc_2096,
rr.NLS_2096_I,
rr.ostc_2096_I,
rr.acc_2096_I
from
customer C,
cust_acc CU,
stan_fin f,
stan_obs so,
specparam S,
(select max(decode(zz.n,'ACC',ZZ.nls,null)) NLS,
        max(decode(zz.n,'ACCO',ZZ.nls,null)) NLSO,
        max(decode(zz.n,'ACC_9129',ZZ.nls,null)) NLS_9129,
        max(decode(zz.n,'ACC_2067',ZZ.nls,null)) NLS_2067,
        max(decode(zz.n,'ACC_2096',ZZ.nls,null)) NLS_2096,
        max(decode(zz.n,'ACCO_I',ZZ.nls,null)) NLSO_I,
        max(decode(zz.n,'ACC_2096_I',ZZ.nls,null)) NLS_2096_I,
        max(decode(zz.n,'ACC_8000_I',ZZ.nls,null)) NLS_8000_I,
        max(decode(zz.n,'ACC',ZZ.acc,null)) ACC,
        max(decode(zz.n,'ACCO',ZZ.acc,null)) ACCO,
        max(decode(zz.n,'ACCO_I',ZZ.acc,null)) ACCO_I,
        max(decode(zz.n,'ACC_9129',ZZ.acc,null)) ACC_9129,
        max(ACC_8000) ACC_8000,
        max(decode(zz.n,'ACC_2096',ZZ.acc,null)) ACC_2096,
        max(decode(zz.n,'ACC_2096_I',ZZ.acc,null)) ACC_2096_I,
        max(decode(zz.n,'ACC',ZZ.lim,null)) lim,
        max(decode(zz.n,'ACC',zz.dapp,null)) dapp,
        max(decode(zz.n,'ACC',zz.dos,null)) dos,
        max(decode(zz.n,'ACC',zz.ostc,null)) OSTC,
        max(decode(zz.n,'ACCO',zz.ostc,null)) OSTCO,
        max(decode(zz.n,'ACCO_I',ZZ.OSTC,null)) OSTCO_I,
        max(decode(zz.n,'ACC_2096',ZZ.OSTC,null)) OSTC_2096,
        max(decode(zz.n,'ACC_2096_I',ZZ.OSTC,null)) OSTC_2096_I,
        max(decode(zz.n,'ACC_8000_I',ZZ.ostc,null)) OSTC_8000_I,
        max(decode(zz.n,'ACC_9129',ZZ.ostc,null)) OSTC_9129,
        max(decode(zz.n,'ACCO',ZZ.tip,null)) tip,
        max(decode(zz.n,'ACCO',ZZ.kv,null)) kv,
        max(decode(zz.n,'ACC',ZZ.mdate,null)) MDATE,
        max(obs) obs,
        max(flag) flag,
        max(nd) nd,
        max(day) day,
        max(tipo) tipo,
        max(ndoc) ndoc,
        max(sd) sd,
        max(datd) datd,
        max(datd2) datd2,
        max(userid) userid,
        zz.sos
from
(select a.acc,a.nls,a.kv,a.tip,a.ostc,a.OSTB,a.mdate,a.lim,a.dapp,dos,yy.* from
ACCOUNTS A,
(select acc acc_R, 'ACC' N,acc ACC_M,sos,obs,flag,nd,day,tipo,ndoc,sd,datd,datd2,userid,acc_8000
from v_acc_over where tipo<>200
union all
select acco acc_R, 'ACCO' N,acc ACC_M,sos,null obs,null flag,null nd,null day,null tipo,null ndoc,null sd,null datd,null datd2,null userid,null acc_8000
from v_acc_over where tipo<>200
union all
select ACC_9129 acc_R, 'ACC_9129' N,acc ACC_M,sos,null obs,null flag,null nd,null day,null tipo,null ndoc,null sd,null datd,null datd2,null userid,null acc_8000
from v_acc_over where tipo<>200
union all
select decode(ACC_2067,0,to_number(null),ACC_2067) acc_R,'ACC_2067' N,acc ACC_M,sos,null obs,null flag,null nd,null day,null tipo,null ndoc,null sd,null datd,null datd2,null userid,null acc_8000
from v_acc_over where tipo<>200
union all
select ACC_2096 acc_R,'ACC_2096' N,acc ACC_M,sos,null obs,null flag,null nd,null day,null tipo,null ndoc,null sd,null datd,null datd2,null userid,null acc_8000
from v_acc_over where tipo<>200
union all
select acra acc_R,N,xx.acc ACC_M,xx.sos,null obs,null flag,null nd,null day,null tipo,null ndoc,null sd,null datd,null datd2,null userid,null acc_8000
from int_accn i , (       select acco accc, 'ACCO_I' N,acc,sos
                          from v_acc_over where tipo<>200
                          union all
                          select acc_2096 accc,'ACC_2096_I' N,acc,sos
                          from v_acc_over where tipo<>200
                          union all
                          select ACC_8000 accc,'ACC_8000_I' N,acc,sos
                          from v_acc_over where tipo<>200) XX
where i.acc=XX.accc and i.id=0) YY
where yy.acc_R=a.acc  and
      a.dazs is null and
      a.tip not like 'PK_') ZZ
group by zz.acc_m,sos) RR
where
CU.acc=RR.acc and
CU.rnk=c.rnk and
f.fin(+)=c.crisk and
rr.acco =s.acc (+) and
s.acc(+)=rr.acc and
nvl(RR.obs,1)=so.obs and
(nvl(RR.sos,0)=0 or (nvl(RR.sos,0)=1 and (nvl(rr.ostco,0)+nvl(rr.ostco_i,0)+nvl(rr.ostc_2096,0))<>0))
 ;

PROMPT *** Create  grants  OVER_V ***
grant SELECT                                                                 on OVER_V          to ABS_ADMIN;
grant SELECT                                                                 on OVER_V          to BARS009;
grant SELECT                                                                 on OVER_V          to BARS_ACCESS_DEFROLE;
grant SELECT                                                                 on OVER_V          to TECH005;
grant SELECT                                                                 on OVER_V          to TECH006;
grant DELETE,FLASHBACK,INSERT,SELECT,UPDATE                                  on OVER_V          to WR_ALL_RIGHTS;



PROMPT ===================================================================================== 
PROMPT *** End *** ========== Scripts /Sql/BARS/View/OVER_V.sql =========*** End *** =======
PROMPT ===================================================================================== 
