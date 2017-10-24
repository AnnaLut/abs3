

PROMPT ===================================================================================== 
PROMPT *** Run *** ========== Scripts /Sql/BARS/Procedure/CP_IN_MT.sql =========*** Run *** 
PROMPT ===================================================================================== 


PROMPT *** Create  procedure CP_IN_MT ***

  CREATE OR REPLACE PROCEDURE BARS.CP_IN_MT 
         (p_datb date, p_date date, p_nbs varchar2,
          p_kv int default 0, p_mode int default 0) is
-- *** v.2.12N 09/12-10  ***
dat_b date;
dat_e date;
last_dat date;
frst_dat date;
f_dat date;
last_prv date;
l_idu int;
l_mode int;
l_kv int;
l_nbs varchar2(5);
l_kv_c varchar2(3);
l_days int;  f_acc int;
k_day int;
in_kor char(2);
in_p char(2);
S_P number;  S_PQ number;
S_KOR number;  S_KORQ number;
S_KOR10 number; S_KOR11 number; S_KOR12 number;
S_KOR13 number; S_KOR14 number; S_KOR15 number;
S_KOR10q number; S_KOR11q number; S_KOR12q number;
S_KOR13q number; S_KOR14q number; S_KOR15q number;

s_i10 number; s_i11 number; s_i12 number;
s_i13 number; s_i14 number; s_i15 number;
s_i10q number; s_i11q number; s_i12q number;
s_i13q number; s_i14q number; s_i15q number;
fdat_kor date;
fl1 int;  fl5 int;  fl7 int; fl8 int;
D_min number; K_max number; IN_max varchar2(2); IN_min varchar2(2);

l_cp_in varchar2(2);
l_eost number; l_nost number;
f_eost number; f_nost number;
l_row fx_in_mt%rowtype;
l_kor fx_in_mt%rowtype;
l_sum fx_in_mt.in10%type;

begin
--l_mode:=0;
l_mode:=p_mode;
l_kv:=p_kv;       --l_kv:=0;
l_idu:=user_id;    fl1:=0;
l_kv_c:='val';
--l_nbs:='%';
l_nbs:=p_nbs;
dat_b:=p_datb;
dat_e:=p_date;
--dat_b:=to_date('01/01/2010','dd/mm/yyyy');
--dat_e:=to_date('31/10/2010','dd/mm/yyyy');
last_dat:=last_day(dat_e);
l_days:=dat_e-dat_b+1;
frst_dat:=to_date('01'||to_char(dat_b,'mmyyyy'),'ddmmyyyy');
    --ADD_MONTHS (LAST_DAY(DAT1_),-1)+1
last_prv:=frst_dat-1;
k_day:=0; f_acc:=-1;
f_dat:=to_date('01/01/2010','dd/mm/yyyy');
logger.info('cp_in_mt  START:   '||'з '||dat_b||' по '||dat_e);

l_row.ost10:=0; l_row.ost11:=0; l_row.ost12:=0;
l_row.ost13:=0; l_row.ost14:=0; l_row.ost15:=0;
l_row.ost10q:=0; l_row.ost11q:=0; l_row.ost12q:=0;
l_row.ost13q:=0; l_row.ost14q:=0; l_row.ost15q:=0;
in_p:='88'; S_P:=0; S_PQ:=0;
l_kor.ost10:=0; l_kor.ost11:=0; l_kor.ost12:=0;
l_kor.ost13:=0; l_kor.ost14:=0; l_kor.ost15:=0;
l_kor.ost10q:=0; l_kor.ost11q:=0; l_kor.ost12q:=0;
l_kor.ost13q:=0; l_kor.ost14q:=0; l_kor.ost15q:=0;
l_kor.i_ost:=0;  l_kor.i_ostq:=0;

delete from tmp_in_mt where id_u=l_idu;  --and to_char(fdat,'YYYYMM')=to_char(frst_dat,'YYYYMM');

for rx in
  (select acc, nbs, nls, kv from accounts
   where nbs in (1819,1919,3540,3640)
         and nbs like l_nbs||'%' and dazs is NULL
   order by nbs,nls,kv)
loop

S_I10:=0; S_I11:=0; S_I12:=0; S_I13:=0; S_I14:=0; S_I15:=0;
S_I10q:=0; S_I11q:=0; S_I12q:=0; S_I13q:=0; S_I14q:=0; S_I15q:=0;
l_eost:=0; l_nost:=0;
f_eost:=0; f_nost:=0;
in_p:='88'; S_P:=0; S_PQ:=0;
--logger.trace('cp_in_mt 1 '||rx.kv||' '||rx.nls);

l_row.ost10:=0; l_row.ost11:=0; l_row.ost12:=0;
l_row.ost13:=0; l_row.ost14:=0; l_row.ost15:=0;
l_row.ost10q:=0; l_row.ost11q:=0; l_row.ost12q:=0;
l_row.ost13q:=0; l_row.ost14q:=0; l_row.ost15q:=0;

fl5:=0;
---      ѕерехiднi вiртуальнi залишки з FX_IN_MT
--       дл€ нового ACC   --c.fdat=frst_dat then
begin
select * into l_kor
from FX_IN_MT
where nls=rx.nls and kv=rx.kv and fdat=last_prv and acc=rx.acc;
fl5:=1;
logger.trace('cp_in_mt k '||rx.kv||' '||rx.nls||' '||l_kor.fdat
            ||' 10='||l_kor.ost10||' 10q='||l_kor.ost10q
            ||' 11='||l_kor.ost11||' 11q='||l_kor.ost11q
            ||' 12='||l_kor.ost12||' 12q='||l_kor.ost12q
            ||' 13='||l_kor.ost13||' 13q='||l_kor.ost13q
            ||' 14='||l_kor.ost14||' 14q='||l_kor.ost14q
            ||' 15='||l_kor.ost15||' 15q='||l_kor.ost15q
            ||' i_ost '||l_kor.i_ost||' i_ostq '||l_kor.i_ostq);
exception when no_data_found then NULL;
l_kor.ost10:=0; l_kor.ost11:=0; l_kor.ost12:=0;
l_kor.ost13:=0; l_kor.ost14:=0; l_kor.ost15:=0;
l_kor.ost10q:=0; l_kor.ost11q:=0; l_kor.ost12q:=0;
l_kor.ost13q:=0; l_kor.ost14q:=0; l_kor.ost15q:=0;
l_kor.i_ost:=0;  l_kor.i_ostq:=0;
end;

--  обробка перехiдних залишкiв
if fl5=1 then
l_eost:=l_kor.i_ostq; l_nost:=l_kor.i_ost;
f_eost:=l_kor.i_ostq; f_nost:=l_kor.i_ost;
begin
if l_kor.ost10q !=0 then
insert into tmp_IN_MT
(id_u,nbs,acc,nls,kv,fdat,dat_b,dat_e,cp_in,cp_mt,dos,kos,del,
 dosn,kosn,deln,kv_c,n_ost,e_ost,day_k)
values
(l_idu,rx.nbs,rx.acc,rx.nls,rx.kv,l_kor.fdat,dat_b,dat_e,'10',' ',
0,0,l_kor.ost10q,0,0,l_kor.ost10,'KOR',l_nost,l_eost,l_days);
in_p:='10'; S_pq:=l_kor.ost10q; S_p:=l_kor.ost10;
l_nost:=0; l_eost:=0;
end if;

if l_kor.ost11q !=0 then
insert into tmp_IN_MT
(id_u,nbs,acc,nls,kv,fdat,dat_b,dat_e,cp_in,cp_mt,dos,kos,del,
 dosn,kosn,deln,kv_c,n_ost,e_ost,day_k)
values
(l_idu,rx.nbs,rx.acc,rx.nls,rx.kv,l_kor.fdat,dat_b,dat_e,'11',' ',
0,0,l_kor.ost11q,0,0,l_kor.ost11,'KOR',l_nost,l_eost,l_days);
in_p:='11'; S_pq:=l_kor.ost11q; S_p:=l_kor.ost11;
l_nost:=0; l_eost:=0;
end if;

if l_kor.ost12q !=0 then
insert into tmp_IN_MT
(id_u,nbs,acc,nls,kv,fdat,dat_b,dat_e,cp_in,cp_mt,dos,kos,del,
 dosn,kosn,deln,kv_c,n_ost,e_ost,day_k)
values
(l_idu,rx.nbs,rx.acc,rx.nls,rx.kv,l_kor.fdat,dat_b,dat_e,'12',' ',
0,0,l_kor.ost12q,0,0,l_kor.ost12,'KOR',l_nost,l_eost,l_days);
in_p:='12'; S_pq:=l_kor.ost12q; S_p:=l_kor.ost12;
l_nost:=0; l_eost:=0;
end if;

if l_kor.ost13q !=0 then
insert into tmp_IN_MT
(id_u,nbs,acc,nls,kv,fdat,dat_b,dat_e,cp_in,cp_mt,dos,kos,del,
 dosn,kosn,deln,kv_c,n_ost,e_ost,day_k)
values
(l_idu,rx.nbs,rx.acc,rx.nls,rx.kv,l_kor.fdat,dat_b,dat_e,'13',' ',
0,0,l_kor.ost13q,0,0,l_kor.ost13,'KOR',l_nost,l_eost,l_days);
in_p:='13'; S_pq:=l_kor.ost13q; S_p:=l_kor.ost13;
l_nost:=0; l_eost:=0;
end if;

if l_kor.ost14q !=0 then
insert into tmp_IN_MT
(id_u,nbs,acc,nls,kv,fdat,dat_b,dat_e,cp_in,cp_mt,dos,kos,del,
 dosn,kosn,deln,kv_c,n_ost,e_ost,day_k)
values
(l_idu,rx.nbs,rx.acc,rx.nls,rx.kv,l_kor.fdat,dat_b,dat_e,'14',' ',
0,0,l_kor.ost14q,0,0,l_kor.ost14,'KOR',l_nost,l_eost,l_days);
in_p:='14'; S_pq:=l_kor.ost14q; S_p:=l_kor.ost14;
l_nost:=0; l_eost:=0;
end if;

if l_kor.ost15q !=0 then
insert into tmp_IN_MT
(id_u,nbs,acc,nls,kv,fdat,dat_b,dat_e,cp_in,cp_mt,dos,kos,del,
 dosn,kosn,deln,kv_c,n_ost,e_ost,day_k)
values
(l_idu,rx.nbs,rx.acc,rx.nls,rx.kv,l_kor.fdat,dat_b,dat_e,' ',' ',
0,0,l_kor.ost15q,0,0,l_kor.ost15,'KOR',l_nost,l_eost,l_days);
in_p:='15'; S_pq:=l_kor.ost15q; S_p:=l_kor.ost15;
l_nost:=0; l_eost:=0;
end if;

end;
end if;     -- fl5=1


k_day:=0; f_acc:=rx.acc;
fl1:=0;  fl7:=0;

--   †аналiз по SAL, SALB
for c in
(select s.acc, s.nbs, s.nls, s.kv, s.fdat,
  s.dos/100 n_dos , s.kos/100 n_kos, s.ost/100 N_OST,
  sb.dos/100 e_dos , sb.kos/100 e_kos, sb.ost/100 E_OST
 from sal s, salb sb
 where
      s.acc = rx.acc   and rx.acc = sb.acc(+)
      and s.acc=sb.acc(+) and s.fdat=sb.fdat(+)
      and (s.dos!=0 or s.kos!=0 or sb.dos!=0 or sb.kos!=0)
      and s.fdat>=dat_b and s.fdat<=dat_e
  order by s.fdat)
loop

fl1:=1;  fl8:=0;
k_day:=k_day+1;

l_eost:=c.e_ost; l_nost:=c.n_ost;
f_eost:=c.e_ost; f_nost:=c.n_ost;
D_min:=0; K_max:=0; IN_max:='88'; IN_min:='88';

/***
if fl7=0 then       -- перехiднi з попереднього мiс€ц€ вже записанi
l_row.ost10:=0; l_row.ost11:=0; l_row.ost12:=0;
l_row.ost13:=0; l_row.ost14:=0; l_row.ost15:=0;
l_row.ost10q:=0; l_row.ost11q:=0; l_row.ost12q:=0;
l_row.ost13q:=0; l_row.ost14q:=0; l_row.ost15q:=0;
fl7:=1;
end if;
***/

if c.kv!=980 then

for k in (
select c.NBS, c.nls,          --   max(decode(l_mode,0,c.nls,c.nbs)) NLS,
       substr(F_DOP(o.REF,'CP_IN'),1,2) CP_IN,
       substr(F_DOP(o.REF,'CP_MR'),1,2) CP_MT,
       Sum(decode(o.dk,0,o.sq,0))/100 DOS,    Sum(decode(o.dk,1,o.sq,0))/100 KOS,
       Sum(decode(o.dk,0,-o.sq,o.sq))/100 DEL,
       c.kv KV,         --   decode(l_kv,0,999,c.kv) KV,
       Sum(decode(o.dk,0, o.s,0))/100 DOSN, Sum(decode(o.dk,1, o.s,0))/100 KOSN,
       Sum(decode(o.dk,0, -o.s,o.s))/100 DELN,
       'VAL' kv_c
from  opldok o, oper p
where c.kv!=980
      and o.sos=5 and o.ref=p.ref and o.acc=C.acc
      and o.fdat = c.fdat          --  and p.vdat = c.fdat
group by c.nbs, c.nls,             -- decode(l_reg,0,c.nls,c.nbs),
         c.kv,                     --decode(l_kv,0,999,c.kv),
                       --decode(l_kv,0,decode(c.kv,980,980,0),999,c.kv),
         substr(F_DOP (o.REF,'CP_IN'),1,2),
         substr(F_DOP (o.REF,'CP_MR'),1,2)
order by 1,2,3,4,8)
loop
---
logger.trace('cp_in_mt 2 '||c.kv||' '||c.nls||' '||c.fdat||' IN='||k.cp_in
                          ||' del='||k.del||' dos='||k.dos||' kos='||k.kos
                          ||' deln='||k.deln||' dosn='||k.dosn||' kosn='||k.kosn);
S_KOR:=0; S_KORQ:=0; l_cp_in:=k.cp_in;

if k.cp_in    = '10' then S_KOR:= k.deln+l_row.ost10;
                       --   S_KORq:= k.del+l_row.ost10q;
                          S_KORq:=round(gl.p_icurval(rx.KV,S_KOR,c.fdat),2);
                          S_I10q:=S_KORq; S_I10:=S_KOR;
                          l_row.ost10q:=S_KORq; l_row.ost10:=S_KOR;
elsif k.cp_in = '11' then S_KOR:= k.deln+l_row.ost11;
                       -- S_KORq:= k.del+l_row.ost11q;
                          S_KORq:=round(gl.p_icurval(rx.KV,S_KOR,c.fdat),2);
                          S_I11q:=S_KORq; S_I11:=S_KOR;
                          l_row.ost11q:=S_KORq; l_row.ost11:=S_KOR;
elsif k.cp_in = '12' then S_KOR:= k.deln+l_row.ost12;
                       -- S_KORq:= k.del+l_row.ost12q;
                          S_KORq:=round(gl.p_icurval(rx.KV,S_KOR,c.fdat),2);
                          S_I12q:=S_KORq; S_I12:=S_KOR;
                          l_row.ost12q:=S_KORq; l_row.ost12:=S_KOR;
elsif k.cp_in = '13' then S_KOR:= k.deln+l_row.ost13;
                       -- S_KORq:= k.del+l_row.ost13q;
                          S_KORq:=round(gl.p_icurval(rx.KV,S_KOR,c.fdat),2);
                          S_I13q:=S_KORq; S_I13:=S_KOR;
                          l_row.ost13q:=S_KORq; l_row.ost13:=S_KOR;
elsif k.cp_in = '14' then S_KOR:= k.deln+l_row.ost14;
                       -- S_KORq:= k.del+l_row.ost14q;
                          S_KORq:=round(gl.p_icurval(rx.KV,S_KOR,c.fdat),2);
                          S_I14q:=S_KORq; S_I14:=S_KOR;
                          l_row.ost14q:=S_KORq; l_row.ost14:=S_KOR;
elsif k.cp_in is NULL  then S_KOR:= k.deln+l_row.ost15;
                       -- S_KORq:= k.del+l_row.ost15q;
                          S_KORq:=round(gl.p_icurval(rx.KV,S_KOR,c.fdat),2);
                          S_I15q:=S_KORq; S_I15:=S_KOR;
                          l_row.ost15q:=S_KORq; l_row.ost15:=S_KOR;
else  NULL;
      l_cp_in:='88';
      S_KOR:= k.deln+l_row.ost15;
  --  S_KORq:= k.del+l_row.ost15q;
      S_KORq:=round(gl.p_icurval(rx.KV,S_KOR,c.fdat),2);
      S_I15q:=S_KORq; S_I15:=S_KOR;
      l_row.ost15q:=S_KORq; l_row.ost15:=S_KOR;
end if;
logger.trace('cp_in_mt 2a IN='||l_cp_in||' s_kor='||s_kor||' s_korq='||s_korq);
---
insert into tmp_IN_MT
(id_u,nbs,acc,nls,kv,fdat,dat_b,dat_e,cp_in,cp_mt,dos,kos,del,
 dosn,kosn,deln,kv_c,n_ost,e_ost,day_k)
values
(l_idu,c.nbs,c.acc,c.nls,c.kv,c.fdat,dat_b,dat_e,k.cp_in,k.cp_mt,
k.dos,k.kos,S_KORQ,k.dosn,k.kosn,S_KOR,k.kv_c,l_nost,l_eost,l_days);

if S_KORq < 0 then
   if D_min > S_KORQ then D_min:=S_KORQ; IN_MIN:=k.cp_in; end if;
end if;

if S_KORq > 0 then
   if K_max < S_KORQ then K_max:=S_KORQ; IN_MAX:=k.cp_in; end if;
end if;

l_nost:=0; l_eost:=0;

end loop;

end if;         -- kv!=980


if c.kv=980 then

for r in (
select c.NBS, c.nls,          --max(decode(l_mode,0,c.nls,c.nbs)) NLS,
       substr(F_DOP(o.REF,'CP_IN'),1,2) CP_IN,    substr(F_DOP(o.REF,'CP_MR'),1,2) CP_MT,
       Sum(decode(o.dk,0, o.sq,0))/100 DOS,       Sum(decode(o.dk,1, o.sq,0))/100 KOS,
       Sum(decode(o.dk,0, -o.sq,o.sq))/100 DEL,
       c.kv,
   --    o.fdat,
       Sum(decode(o.dk,0, o.s,0))/100 DOSN, Sum(decode(o.dk,1, o.s,0))/100 KOSN,
       Sum(decode(o.dk,0, -o.s,o.s))/100 DELN,
       'UAH' kv_c
from  opldok o, oper p
where c.kv=980
      and o.sos=5 and o.ref=p.ref and o.acc=C.acc
      and o.fdat = c.fdat  --  and p.vdat = c.fdat
group by c.nbs, c.nls,        --decode(l_mode,0,c.nls,c.nbs),
         c.kv,
         substr(F_DOP (o.REF,'CP_IN'),1,2),
         substr(F_DOP (o.REF,'CP_MR'),1,2)
order by 1,2,3,4,8)
loop

logger.trace('cp_in_mt 4 '||c.kv||' '||c.nls||' '||c.fdat||' IN='||r.cp_in
                          ||' del='||r.del||' dos='||r.dos||' kos='||r.kos
                          ||' deln='||r.deln||' dosn='||r.dosn||' kosn='||r.kosn);

S_KOR:=0; S_KORQ:=0; l_cp_in:=r.cp_in;
--D_min:=   K_max:=
if r.cp_in = '10' then S_KORQ:= r.del+l_row.ost10q; S_KOR:= r.deln+l_row.ost10;
                       S_I10q:=S_KORq; S_I10:=S_KOR;
                          l_row.ost10q:=S_KORq; l_row.ost10:=S_KOR;
elsif r.cp_in = '11' then S_KORQ:= r.del+l_row.ost11q; S_KOR:= r.deln+l_row.ost11;
                       S_I11q:=S_KORq; S_I11:=S_KOR;
                          l_row.ost11q:=S_KORq; l_row.ost11:=S_KOR;
elsif r.cp_in = '12' then S_KORQ:= r.del+l_row.ost12q; S_KOR:= r.deln+l_row.ost12;
                       S_I12q:=S_KORq; S_I12:=S_KOR;
                          l_row.ost12q:=S_KORq; l_row.ost12:=S_KOR;
elsif r.cp_in = '13' then S_KORQ:= r.del+l_row.ost13q; S_KOR:= r.deln+l_row.ost13;
                       S_I13q:=S_KORq; S_I13:=S_KOR;
                          l_row.ost13q:=S_KORq; l_row.ost13:=S_KOR;
elsif r.cp_in = '14' then S_KORQ:= r.del+l_row.ost14q; S_KOR:= r.deln+l_row.ost14;
                       S_I14q:=S_KORq; S_I14:=S_KOR;
                          l_row.ost14q:=S_KORq; l_row.ost14:=S_KOR;
elsif r.cp_in is NULL  then S_KORQ:= r.del+l_row.ost15q; S_KOR:= r.deln+l_row.ost15;
                       S_I15q:=S_KORq; S_I15:=S_KOR;
                          l_row.ost15q:=S_KORq; l_row.ost15:=S_KOR;
else  NULL;
      l_cp_in:='88';
      S_KORq:= r.del+l_row.ost15q; S_KOR:= r.deln+l_row.ost15;
      S_I15q:=S_KORq; S_I15:=S_KOR;
      l_row.ost15q:=S_KORq; l_row.ost15:=S_KOR;
end if;

logger.trace('cp_in_mt 4a IN='||l_cp_in||' s_kor='||s_kor||' s_korq='||s_korq);

insert into tmp_IN_MT
(id_u,nbs,acc,nls,kv,fdat,dat_b,dat_e,cp_in,cp_mt,dos,kos,del,
 dosn,kosn,deln,kv_c,n_ost,e_ost,day_k)
values
(l_idu,c.nbs,c.acc,c.nls,c.kv,c.fdat,dat_b,dat_e,r.cp_in,r.cp_mt,
 r.dos,r.kos,S_KORQ,r.dosn,r.kosn,S_KOR,r.kv_c,l_nost,l_eost,l_days);

l_nost:=0; l_eost:=0;

end loop;  -- r

end if;  -- kv=980

-- переробити алгоритм
-- зам?сть попереднього
-- вирахувати загальне сальдо за дату ы посадити за одним  INITIATOR
-- ? внести один запис в tmp_IN_MT за дану дату т?льки за одним INITIATOR

/***
 S_PQ:=S_PQ + (S_I10q+S_I11q+S_I12q+S_I13q+S_I14q+S_I15q);
 S_P :=S_P + (S_I10+S_I11+S_I12+S_I13+S_I14+S_I15);
if abs(S_I10q) > abs(S_PQ) then in_p:='10': S_PQ:=S_PQ + S_I10q; end if;
***/

end loop;   -- c  по  SAL, SALB  одного ACC

begin
update tmp_in_mt set day_o=k_day where acc=f_acc
                                       and fdat>=dat_b - 1 and fdat<=dat_e
                                       and id_u=l_idu;
exception when others then NULL;
end;

if l_mode=1 and (fl1=1 or fl5=1) then
null;
   l_row.ost10:=l_row.ost10 + l_kor.ost10;
--   l_row.ost10q:=l_row.ost10q + l_kor.ost10q;
   l_row.ost11:=l_row.ost11 + l_kor.ost11;
--   l_row.ost11q:=l_row.ost11q + l_kor.ost11q;
   l_row.ost12:=l_row.ost12 + l_kor.ost12;
--   l_row.ost12q:=l_row.ost12q + l_kor.ost12q;
   l_row.ost13:=l_row.ost13 + l_kor.ost13;
--   l_row.ost13q:=l_row.ost13q + l_kor.ost13q;
   l_row.ost14:=l_row.ost14 + l_kor.ost14;
--   l_row.ost14q:=l_row.ost14q + l_kor.ost14q;
   l_row.ost15:=l_row.ost15 + l_kor.ost15;
--   l_row.ost15q:=l_row.ost15q + l_kor.ost15q;

S_I10:= l_row.ost10;
S_I11:= l_row.ost11;
S_I12:= l_row.ost12;
S_I13:= l_row.ost13;
S_I14:= l_row.ost14;
S_I15:= l_row.ost15;

-- S_I10q:= l_row.ost10q;
-- S_I11q:= l_row.ost11q;
-- S_I12q:= l_row.ost12q;
-- S_I13q:= l_row.ost13q;
-- S_I14q:= l_row.ost14q;
-- S_I15q:= l_row.ost15q;

S_I10q:=round(gl.p_icurval(rx.KV,l_row.ost10,last_dat),2);
S_I11q:=round(gl.p_icurval(rx.KV,l_row.ost11,last_dat),2);
S_I12q:=round(gl.p_icurval(rx.KV,l_row.ost12,last_dat),2);
S_I13q:=round(gl.p_icurval(rx.KV,l_row.ost13,last_dat),2);
S_I14q:=round(gl.p_icurval(rx.KV,l_row.ost14,last_dat),2);
S_I15q:=round(gl.p_icurval(rx.KV,l_row.ost15,last_dat),2);

/***
 logger.trace('cp_in_mt 5 '||rx.kv||' '||rx.nls||' '
                          ||' 10='||l_row.ost10||' 10q='||l_row.ost10q
                          ||' 11='||l_row.ost11||' 11q='||l_row.ost11q
                          ||' 12='||l_row.ost12||' 12q='||l_row.ost12q
                          ||' 13='||l_row.ost13||' 13q='||l_row.ost13q
                          ||' 14='||l_row.ost14||' 14q='||l_row.ost14q
                          ||' 15='||l_row.ost15||' 15q='||l_row.ost15q);
***/

 logger.trace('cp_in_mt 5 '||rx.kv||' '||rx.nls||' '
                           ||' 10='||S_I10||' 10q='||S_I10q
                           ||' 11='||S_I11||' 11q='||S_I11q
                           ||' 12='||S_I12||' 12q='||S_I12q
                           ||' 13='||S_I13||' 13q='||S_I13q
                           ||' 14='||S_I14||' 14q='||S_I14q
                           ||' 15='||S_I15||' 15q='||S_I15q);

 insert into FX_IN_MT
 (fdat,acc,nbs,nls,kv,in10,ost10,ost10q,in11,ost11,ost11q,in12,ost12,ost12q,
  in13,ost13,ost13q,in14,ost14,ost14q,in15,ost15,ost15q,i_ost,i_ostq,day_o)
 values(last_dat,rx.acc,rx.nbs,rx.nls,rx.kv,'10',S_I10,S_I10q,'11',S_I11,S_I11q,
 '12',S_I12,S_I12q,'13',S_I13,S_I13q,'14',S_I14,S_I14q,' ',S_I15,S_I15q,
   F_NOST,F_EOST,k_day);
end if;

end loop;  -- Accounts

COMMIT;

logger.info('cp_in_mt  FINISH1:   '||'з '||dat_b||' по '||dat_e||' user='||L_IDU);

declare
  DAT1_ date;
begin
--  update KDI set cp_in = nvl(cp_in,'00'),  cp_MT = nvl(cp_MT,'00');
  update tmp_in_mt set cp_in = nvl(cp_in,' '),  cp_MT = nvl(cp_MT,' ');
logger.info('cp_in_mt  STA started:');

  for k in (select * from tmp_in_mt
                     where id_u = l_idu
                     order by acc,cp_in,kv_c,fdat)
  loop
    select NVL(min(fdat), k.DAT_E + 1) into DAT1_   from tmp_in_mt
    where acc=k.acc       and cp_in = k.cp_in  and cp_mt = k.cp_mt
          and id_u = l_idu    and kv_c = k.kv_c
          and fdat > k.FDAT   and fdat <= DAT_E;

    insert into tmp_in_mt
      (FDAT, DOS,KOS, DOSN,KOSN, DELN, DEL,
       ID_U,NBS,ACC,NLS,KV,DAT_B,DAT_E,CP_IN,CP_MT,
       KV_C,N_OST,E_OST,DAY_K,DAY_F,DAY_O)
    select
       CDAT, 0, 0, 0, 0, k.DELN , round(gl.p_icurval(k.KV,k.DELN,CDAT),2) DEL,
       k.ID_U , k.NBS  , k.ACC  , k.NLS  , k.KV,
       k.DAT_B, k.DAT_E,
       decode(k.cp_in,NULL,' ',k.cp_in),
     --  k.CP_IN,
       k.CP_MT,
       k.KV_C , k.N_OST, k.E_OST, k.DAY_K, k.DAY_F, k.DAY_O
    from (select k.FDAT+c.num CDAT from conductor c where k.FDAT+c.num<DAT1_);
  end loop;
end ;

COMMIT;
logger.info('cp_in_mt  FINISH:   ');
end;
/
show err;

PROMPT *** Create  grants  CP_IN_MT ***
grant EXECUTE                                                                on CP_IN_MT        to BARS_ACCESS_DEFROLE;
grant EXECUTE                                                                on CP_IN_MT        to CP_ROLE;



PROMPT ===================================================================================== 
PROMPT *** End *** ========== Scripts /Sql/BARS/Procedure/CP_IN_MT.sql =========*** End *** 
PROMPT ===================================================================================== 
