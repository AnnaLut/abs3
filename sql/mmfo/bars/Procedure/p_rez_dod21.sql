

PROMPT ===================================================================================== 
PROMPT *** Run *** ========== Scripts /Sql/BARS/Procedure/P_REZ_DOD21.sql =========*** Run *
PROMPT ===================================================================================== 


PROMPT *** Create  procedure P_REZ_DOD21 ***

  CREATE OR REPLACE PROCEDURE BARS.P_REZ_DOD21 (dat_ date) is

-- процедура для отчета "Резервы Демарк"
userid_  number;
nd_      number;

s9129_   number;
s9129q_  number;
acc9129_ number;
ird_     number;

zdep_    number;
zcp_     number;
zner_    number;
zruh_    number;
zv1_     number;
zv2_     number;

pr_      number;
rez_     number;

begin

SELECT id
INTO userid_
FROM staff
WHERE upper(logname)=upper(USER);

delete
from tmp_rez_dmark;

-- договора КП + овердрафты
for k in
(
select d.nd,
d.cc_id ndog,
d.SDATE sdate,
d.wdate edate,
d.rnk,
a.acc,
ad.kv,
a.nls,
a.nbs,
c.NMK,
nvl(p.S080,1) s080,
-  (s.ostf-s.dos+s.kos)/100 S,
-  gl.p_Icurval(a.KV,(s.ostf-s.dos+s.kos)/100,dat_) SQ
from cc_deal d,
customer c,
accounts a,
nd_acc n,
saldoa s,
cc_add ad,
specparam p
where d.sos not in (0,15)
  and d.rnk=c.rnk
  and d.nd=n.nd
  and a.acc =p.acc(+)
  and ad.nd = d.nd
  and ad.ADDS = 0
  and n.acc=a.acc
  and a.tip in ('SS ','CR9x')
  and a.acc=s.acc
  and substr(nbs,1,1) <> '9'
  and (a.acc,s.fdat) = ( select acc, max(fdat)
                         from saldoa
						 where acc=a.acc
						 and fdat <= dat_
						 group by acc )
  and s.ostf-s.dos+s.kos<0
)
loop

-- обязательства
begin
select a.acc,sum(-(s.ostf-s.dos+s.kos)/100),sum(-gl.p_Icurval(a.KV,(s.ostf-s.dos+s.kos)/100,dat_))
into acc9129_,s9129_,s9129q_
from cc_deal d,customer c,accounts a,saldoa s, nd_acc n
where d.sos not in (0,15)
  and d.rnk=c.rnk
  and d.nd = k.nd
  and n.nd = d.nd
  and n.acc = a.acc
  and a.tip in ('CR9')
  and a.acc=s.acc
  and (a.acc,s.fdat) = ( select acc, max(fdat)
                         from saldoa
						 where acc=a.acc
						 and fdat <= dat_
						 group by acc )
  and s.ostf-s.dos+s.kos<0
  and rownum = 1
  group by a.acc ;

exception when no_data_found then
 s9129_  := 0;
 s9129q_ := 0;
end;

begin
  select ir into ird_
  from int_ratn
  where acc=k.acc
    and id=0
    and bdat=(select max(bdat) from int_ratn
               where  id=0 and acc=k.acc and bdat<=dat_)
order by  bdat desc;
exception when no_data_found then
  ird_:=0;
end;

zdep_ :=0;
zcp_  :=0;
zner_ :=0;
zruh_ :=0;
zv1_  :=0;

for i in
(
 select cp.S031,sum(gl.P_ICURVAL(a.kv,rez.ostc96( a.acc, dat_),dat_))/100 S
 from cc_accp z, accounts a, pawn_acc sz, cc_pawn cp
 where z.accs  = k.acc
   and z.acc   = a.acc
   and cp.pawn = sz.pawn
   and sz.acc  = z.acc
 group by cp.S031
)
loop
 if i.s031 = '19' then
  zdep_:=i.s;
 elsif i.s031 = '14' then
  zcp_:=i.s;
 elsif i.s031 = '13' then
  zner_:=i.s;
 elsif i.s031 = '12' then
  zruh_:=i.s;
 end if;
end loop;

zv1_:=zdep_+zruh_+zcp_+zner_;

zv2_:=round(rez.CA_FQ_OBESP(k.acc,dat_,0)+rez.CA_FQ_OBESP(acc9129_,dat_,0))/100;

begin
 select c.REZ
 into pr_
 from crisk c
 where c.CRISK=k.s080;
exception when no_data_found then
 pr_:=0;
end ;

rez_:=greatest(k.sQ+s9129Q_-zv2_,0);

insert into TMP_REZ_DMARK (
RNK,
NMK,
NDOG,
DATD,
DATP,
SK,
SZ,
SV,
KV,
PR,
ZDEP,
ZCP,
ZNER,
ZRUH,
ZV1,
ZV2,
S080,
SRISK,
REZ,
REZK,
REZZ,
ISP,
OTD
)
values
(
k.RNK,
k.NMK,
k.NDOG,
'',
'',
k.sQ,
s9129Q_,
k.sQ+s9129Q_,
k.kv,
ird_,
zdep_,zcp_,zner_,zruh_,zv1_,zv2_,k.s080,
rez_,
round(rez_*pr_/100,2),
round(rez_*pr_*k.sQ/(100*(k.sQ+s9129Q_)),2),
round(rez_*pr_*s9129Q_/(100*(k.sQ+s9129Q_)),2),
'',
''
);

end loop;


end p_rez_dod21;
/
show err;



PROMPT ===================================================================================== 
PROMPT *** End *** ========== Scripts /Sql/BARS/Procedure/P_REZ_DOD21.sql =========*** End *
PROMPT ===================================================================================== 
