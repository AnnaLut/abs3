
 
 PROMPT ===================================================================================== 
 PROMPT *** Run *** ========== Scripts /Sql/BARS/package/cp_rep.sql =========*** Run *** ====
 PROMPT ===================================================================================== 
 
  CREATE OR REPLACE PACKAGE BARS.CP_REP as

-----------------------------------------------------------------
function header_version return varchar2;

function body_version return varchar2;

function get_MFO(P_ref int, P_ISK varchar2 default 'МФО',p_vx int default 1)
return varchar;

--
procedure PR_F1 (p_dat1 date, p_dat2 date);
--
procedure PR_F1r (p_dat1 date, p_dat2 date, p_reg varchar2 default '0');
--
procedure PR_F2 (p_dat1 date, p_dat2 date);

procedure cp_klass(p_id int, p_dat2 date);
--------------------------------

procedure rep2a (p_dat2 date, p_isin char default '%');

procedure rep2b (p_dat2 date, p_isin char default '%');


--НБУ ДС. Iнформацiя щодо нарахувань. Додаток 4.
--30.09.2011. Сухова.  - перший варіант
procedure PR_F4 (p_dat date);

/*
20-10-11 изменения по форме 4:
1) Колонки 07 ("Штук сертиф.") и 11 ("Сума залучення") заполнять первоначальными данными.
Т.е. на момент размещения депозитных сертификатов.
2) Возможность формирования формы на заданную дату.

14.10.11 ДС НБУ Форма 4 Чт 13.10.2011 18:14
Лист 11.05.2011 №24-113/791  щодо формування та друку додаткових форм, для обл_ку ДС НБУ.
Зауваження до форми 4. вiд Лариси перед вiдпусткою.
- в останнi роки емiтуються ДС до 90 днiв (тому достатньо колонок для 3-х мiсяцiв)
- якщо перехiднi мiсяцi з минулого року то правильно впорядкувати мiсяцi
  з урахуванням року
- якщо ДС вже погашений - все одно потрiбно заповнювати колонки 7,11 (зараз вони пустi)
*/
---------------------------------

procedure PR_F7 (p_dat1 date, p_dat2 date);

procedure LOG(p_info char, p_lev char default 'TRACE', p_reg int default 0);

G_HEADER_VERSION    constant varchar2(64) := 'version 1.05 02.11.2011';

l_trace  varchar2(100):= '';  l_mdl varchar2(5);
l_userid number;
end;
/
CREATE OR REPLACE PACKAGE BODY BARS.CP_REP IS

G_BODY_VERSION    constant varchar2(64) := 'version 1.09 03.11.2011';

-----------------------------------------------------------------
function header_version return varchar2   is
begin
return 'package header CP: ' || G_HEADER_VERSION;
end header_version;

-----------------------------------------------------------------
function body_version return varchar2    is
begin
return 'package body CP: ' || G_BODY_VERSION || chr(10);
end body_version;

-----------------------------------------------------------------
function get_MFO(P_ref int, P_ISK varchar2 default 'МФО', p_vx int default 1)
return varchar is
l_ref int;
ttt1 varchar2(4000);  pos int;
l_isk varchar2(10);
l_MFO varchar2(12);
begin
l_ref:=P_ref;
l_isk:=P_isk;
select get_stiket(l_ref) into ttt1 from dual;
select INSTR(ttt1,l_isk,1,p_vx) into pos from dual;
if pos!=0 then
l_mfo:=substr(ttt1,pos+85,12);
else
-- logger.error( 'cp_rep.get_MFO '||'ключ P_ISK НЕ знайдено');
l_mfo:='??';
end if;
return l_mfo;
end;

procedure PR_F1(p_dat1 date, p_dat2 date) is
p_reg varchar2(1):='0';
--l_userid number;
l_sumb number; l_ref int; l_nd varchar2(10);
l_nar number; l_narf number;
l_nom number; l_spl number;  l_kol number; l_dosN number;
l_sumR number; l_sumR2 number;
l_dosR number; l_kosR number;
l_dosR2 number; l_kosR2 number;
l_dat01 date :=to_date('20110101','YYYYMMDD');
l_dat1 date; l_dat_dp date; l_dat_d date; l_dat_g date;
l_zal number; l_s_d number; l_ir number;
l_ref_f int; l_id_f int;  l_datp date; l_dat_em date;
l_mfo varchar2(6);  l_sab char(4); l_nb varchar2(38);
 ern CONSTANT POSITIVE   := 208; err EXCEPTION; erm VARCHAR2(80);
 err_num number;  err_msg varchar2(80);
begin
--l_userid:=user_id;

LOG('F1 STARTED-***','INFO',0);
LOG('start dat1='||p_dat1||' dat2='||p_dat2||' режим='||p_reg,'INFO');

l_dat01:=to_date(to_char(p_dat1,'YYYY')||'0101','YYYYMMDD');
l_dat1:=p_dat1;
if p_dat1=p_dat2 then l_dat1:=l_dat01; end if;
delete from tmp_cp_rep where id_u=l_userid and frm='1';
l_ref_f:=0; l_id_f:=0;

for l in (select k.id,k.cp_id,trunc(k.dat_em) DAT_EM,trunc(k.datp) DATP,k.cena,k.ir,k.emi,
          sumb,v.acc,nvl(v.accr,-1) accr,v.accr2,v.osta,v.ostr,v.ostr2,
          v.ref,v.mdate,k.period_kup,v.osta/k.cena kol, v.dapp, v.datp DATP_O,
          s.fdat,s.dos/100 DOS,s.kos/100 KOS, v.datd
          from cp_kod k, cp_v v, saldoa s
          where k.tip=2 and v.vidd like '332%' and k.emi=3 and k.id=v.id
                and k.datp > p_dat1 and k.dat_em <= p_dat2
             --   and v.sos > 0
                and v.sos=5
                and v.acc = s.acc
                and (s.dos!=0 and p_reg='1' or s.kos!=0 and p_reg='0')
                and s.fdat <= p_dat2  and s.fdat>=p_dat1
                order by k.cp_id,v.ref)
loop
LOG('F1: cp_id='||l.cp_id||' '||l.id||' дата розм.='||l.datp_o||' ref='||l.ref,'TRACE');
l_datp:=l.datp; l_dat_em:=l.dat_em; l_dat_g:=NULL;
if l_ref_f!=l.ref then l_ref_f:=l.ref;
   l_dat_dp:=l.datd;
else l_dat_dp:=l_dat_d;
end if;
l_dat_d:=l.fdat;  l_ir:=l.ir; l_dosN:=0;
if l_dat_d != l.datp and p_reg='1' then l_dat_g:=l_dat_d; end if;

begin
l_mfo:=trim(cp_rep.get_mfo(l.ref));
if p_reg='0' then
l_zal:=fost(l.acc,l_dat_d-1)/100;
l_nom:=fost(l.acc,l.datp_o)/100;   l_kol:=round(l_nom/l.cena,0);
else
l_zal:=fost(l.acc,l_dat_d-1)/100;  l_kol:=round(l_zal/l.cena,0);
l_nom:=fost(l.acc,l_dat_d)/100;
end if;
l_dosN:=FDOS(l.acc,l_dat01,p_dat2)/100;

l_s_d:=l_zal-l_nom;                -- сума часткового дост. погашення
--l_spov:=0;
--l_kol:=l_nom/l.cena;
l_sumR:=fost(l.accr,l_dat_d)/100;
if p_reg='0' then
l_dosR:=FDOS(l.accr,l_dat01,p_dat2)/100;
l_kosR:=FKOS(l.accr,l_dat01,p_dat2)/100;
else
l_datp:=l_dat_d; l_nom:=l_s_d; l_kol:=round(l_nom/l.cena,0);
if l_dat_d!=l.datp then
l_ir:=round(l.ir*0.2,2);
l_dat_em:=NULL;    --to_date('11/01/2000','dd/mm/yyyy');
end if;
l_dosR:=FDOS(l.accr,l_dat_dp+1,l_dat_d)/100;
l_kosR:=FKOS(l.accr,l_dat_dp+1,l_dat_d)/100;
end if;
if l.accr2 is null then
l_sumR2:=0;
l_dosR2:=0; l_kosR2:=0;
else
l_sumR2:=fost(l.accr2,l_dat_d)/100;
if p_reg='0' then
l_dosR2:=FDOS(l.accr2,l_dat01,p_dat2)/100;
l_kosR2:=FKOS(l.accr2,l_dat01,p_dat2)/100;
else
l_dosR2:=FDOS(l.accr2,l_dat_dp+1,l_dat_d)/100;
l_kosR2:=FKOS(l.accr2,l_dat_dp+1,l_dat_d)/100;
end if;
end if;
l_narf:=l.ostr+l.ostr2;
l_nar:=l_kosR+l_kosR2;
l_spl:=l_dosR+l_dosR2;
exception when OTHERS then  NULL;
-- logger.error( 'cp_rep.PR_F1 .... ');
raise;
end;

if l_mfo ='??' or l_mfo is NULL then
l_sab:=''; l_nb:='??';
else
begin
select sab,nb into l_sab, l_nb
from banks where mfo=l_mfo;
exception when NO_DATA_FOUND then  NULL;
l_sab:=''; l_nb:='??';
end;
end if;
              /***
begin
insert into tmp_cp_rep
(id,mfo,tu,name,
 cp_id,dat_em,datp,ir,kv,cena,nom,kol,k_nar,s_nar,k_spl,
 s_zm, dat_dpog,
 s_dpog,period_kup,emi,ref,rnk,
 id_u,frm,gr_z)
values
(l.id,l_mfo,l_sab,l_nb,
 l.cp_id,l_dat_em,l_datp,l_ir,980,l.cena,l_nom,l_kol,l_nar,l_narf, l_spl,
 decode(p_reg,'0',l_dosN,l_nar-l_spl), l_dat_g,
 l_dosN,l.period_kup,l.emi,l.ref,l.kol,
 l_userid,'1',p_reg);
--LOG('cp_id='||l.cp_id||' ref='||l.ref,'TRACE');
exception                           --when no_data_found then  NULL;
          when others then NULL;
LOG('cp_id='||l.cp_id||' ? помилка INSERT'||' ref='||l.ref,'ERROR');
end;
         ***/

end loop;

commit;
end;

-------------------------------------
procedure PR_F1r(p_dat1 date, p_dat2 date, p_reg varchar2 default '0') is
--l_userid number;
l_sumb number; l_ref int; l_nd varchar2(10);
l_nar number; l_narf number;
l_nom number; l_spl number;  l_kol number; l_dosN number;
l_sumR number; l_sumR2 number;
l_dosR number; l_kosR number;    l_spov number;
l_dosR2 number; l_kosR2 number;
l_dat01 date :=to_date('20110101','YYYYMMDD');
l_dat1 date; l_dat_dp date; l_dat_d date; l_dat_g date;
l_zal number; l_s_d number; l_ir number;
l_ref_f int; l_id_f int;  l_datp date; l_dat_em date;
l_mfo varchar2(6);  l_sab char(4); l_nb varchar2(38); fl int;
 ern CONSTANT POSITIVE   := 208; err EXCEPTION; erm VARCHAR2(80);
 err_num number;  err_msg varchar2(80);
begin
--l_userid:=user_id;

LOG('F1 STARTED-***','INFO',0);
LOG('start dat1='||p_dat1||' dat2='||p_dat2||' режим='||p_reg,'INFO');

l_dat01:=to_date(to_char(p_dat1,'YYYY')||'0101','YYYYMMDD');
l_dat1:=p_dat1;
if p_dat1=p_dat2 then l_dat1:=l_dat01; end if;
delete from tmp_cp_rep where id_u=l_userid and frm='1';
l_ref_f:=0; l_id_f:=0; fl:=0;
      /***
for l in (select k.id,k.cp_id,trunc(k.dat_em) DAT_EM,trunc(k.datp) DATP,k.cena,k.ir,k.emi,
          sumb,v.acc,nvl(v.accr,-1) accr,v.accr2,v.osta,v.ostr,v.ostr2,
          v.ref,v.mdate,k.period_kup,v.osta/k.cena kol, v.dapp, v.datp DATP_O,
          s.fdat,s.dos/100 DOS,s.kos/100 KOS, v.datd
          from cp_kod k, cp_v v, saldoa s
          where k.tip=2 and v.vidd like '332%' and k.emi=3 and k.id=v.id
                and k.datp > p_dat1 and k.dat_em <= p_dat2
             --   and v.sos > 0
                and v.sos=5
                and v.acc = s.acc
                and (s.dos!=0 and p_reg='1' or s.kos!=0 and p_reg='0')
                and s.fdat <= p_dat2 and s.fdat>=p_dat1
                order by k.cp_id,v.ref)
loop
LOG('F1: cp_id='||l.cp_id||' '||l.id||' дата розм.='||l.datp_o||' ref='||l.ref,'TRACE');
l_datp:=l.datp; l_dat_em:=l.dat_em; l_dat_g:=NULL;
if l_ref_f!=l.ref then l_ref_f:=l.ref;
   l_dat_dp:=l.datd; fl:=0;
else l_dat_dp:=l_dat_d; fl:=1;
end if;
l_dat_d:=l.fdat;  l_ir:=l.ir; l_dosN:=0;
if l_dat_d != l.datp and p_reg='1' then l_dat_g:=l_dat_d; end if;

begin
l_mfo:=trim(cp_rep.get_mfo(l.ref));
if p_reg='0' then
l_zal:=fost(l.acc,l_dat_d-1)/100;
--l_nom:=fost(l.acc,l.datp_o)/100;   l_kol:=round(l_nom/l.cena,0);
l_nom:=fost(l.acc,l_dat_d)/100;   l_kol:=round(l_nom/l.cena,0);
else
l_zal:=fost(l.acc,l_dat_d-1)/100;  l_kol:=round(l_zal/l.cena,0);
l_nom:=fost(l.acc,l_dat_d)/100;
end if;
l_dosN:=FDOS(l.acc,l_dat01,p_dat2)/100;

l_s_d:=l_zal-l_nom;                -- сума часткового/повного погашення
l_sumR:=fost(l.accr,l_dat_d)/100;

if p_reg='0' then    -- розміщення  рах-ки купонів
l_dosR:=FDOS(l.accr,l_dat01,p_dat2)/100;
l_kosR:=FKOS(l.accr,l_dat01,p_dat2)/100;
else                 -- погашення
l_datp:=l_dat_d; l_nom:=l_s_d; l_kol:=round(l_nom/l.cena,0);

if l_dat_d!=l.datp then
   l_ir:=round(l.ir*0.2,2);
l_dat_em:=NULL;     --to_date('11/01/2000','dd/mm/yyyy');

begin
 SELECT  nvl(sum(o.s),0)/100 into l_dosR         -- сплачено
   FROM  opldok o, opldok o1
   WHERE o.acc  = l.accr and o.sos=5
        -- and o.tt in ....
        and o.dk=0    --and o.sos>0
        and o.ref=o1.ref and o.stmt=o1.stmt and o1.dk=1-o.dk
        and o1.acc in (select acc from accounts where nbs='4621')
        and o.fdat > l_dat_dp AND o.fdat <= l_dat_d;
end;
begin
 SELECT  nvl(sum(o.s),0)/100 into l_kosR       -- нараховано
   FROM  opldok o, opldok o1
   WHERE o.acc  = l.accr and o.sos=5
        -- and o.tt in ....
        and o.dk=1     --and o.sos>0
        and o.ref=o1.ref and o.stmt=o1.stmt and o1.dk=1-o.dk
        and o1.acc in (select acc from accounts where nbs like '7%')
        and o.fdat > l_dat_dp AND o.fdat <= l_dat_d;
end;

begin
 SELECT  nvl(sum(o.s),0)/100 into l_spov     -- повернуто на 7 клас
   FROM  opldok o, opldok o1
   WHERE o.acc  = l.accr and o.sos=5
        -- and o.tt in ....
        and o.dk=0     --and o.sos>0
        and o.ref=o1.ref and o.stmt=o1.stmt and o1.dk=1-o.dk
        and o1.acc in (select acc from accounts where nbs like '7%')
        and o.fdat > l_dat_dp AND o.fdat <= l_dat_d;
end;

else
l_spov:=0;

if fl = 0 then
l_dosR:=FDOS(l.accr,l_dat_dp,l_dat_d)/100;
l_kosR:=FKOS(l.accr,l_dat_dp,l_dat_d)/100;
--NULL;
else
l_dosR:=FDOS(l.accr,l_dat_dp+1,l_dat_d)/100;
l_kosR:=FKOS(l.accr,l_dat_dp+1,l_dat_d)/100;
--NULL;
end if;

end if;
end if;

if l.accr2 is null then
l_sumR2:=0;
l_dosR2:=0; l_kosR2:=0;
else
l_sumR2:=fost(l.accr2,l_dat_d)/100;
if p_reg='0' then
l_dosR2:=FDOS(l.accr2,l_dat01,p_dat2)/100;
l_kosR2:=FKOS(l.accr2,l_dat01,p_dat2)/100;
else
l_dosR2:=FDOS(l.accr2,l_dat_dp+1,l_dat_d)/100;
l_kosR2:=FKOS(l.accr2,l_dat_dp,l_dat_d)/100;
end if;
end if;

--
-- ! аналіз R2 - не враховуємо (Для ДС НБУ консолідовані р-ки R2=R)
-- довгі рах-ки R2 можливі, але в нормі для ДС угоди розміщення роблять без них
l_narf:=l.ostr+l.ostr2;
if l_dat_d != l.datp   then
l_nar:=l_dosR+l_spov;              -- нар=пог+пов  ! при частковому погашенні
else
l_nar:=l_kosR+l_kosR2;             -- при остаточному пог-ні
end if;
l_spl:=l_dosR+l_dosR2;

if p_reg='0' then l_nar:=l_kosR; end if;

exception when OTHERS then  NULL;
-- logger.error( 'cp_rep.PR_F1 .... ');
raise;
end;

if l_mfo ='??' or l_mfo is NULL then
l_sab:=''; l_nb:='??';
else
begin
select sab,nb into l_sab, l_nb
from banks where mfo=l_mfo;
exception when NO_DATA_FOUND then  NULL;
l_sab:=''; l_nb:='??';
end;
end if;

begin
insert into tmp_cp_rep
(id,mfo,tu,name,
 cp_id,dat_em,datp,ir,kv,cena,nom,kol,k_nar,s_nar,k_spl,
 s_zm, dat_dpog,
 s_dpog,period_kup,emi,ref,rnk,
 id_u,frm,gr_z)
values
(l.id,l_mfo,l_sab,l_nb,
 l.cp_id,l_dat_em,l_datp,l_ir,980,l.cena,l_nom,l_kol,l_nar,l_narf, l_spl,
 --decode(p_reg,'0',l_dosN,l_nar-l_spl),
 l_nar-l_spl,
 l_dat_g,
 l_dosN,l.period_kup,l.emi,l.ref,l.kol,
 l_userid,'1',p_reg);
--LOG('cp_id='||l.cp_id||' ref='||l.ref,'TRACE');
exception
          when others then NULL;
LOG('cp_id='||l.cp_id||' ? помилка INSERT'||' ref='||l.ref,'ERROR');
end;
end loop;

commit;
  ***/
end;
-------------------------------------

procedure PR_F2(p_dat1 date, p_dat2 date) is
--l_userid number;
l_sumb number; l_ref int; l_nd varchar2(10);
l_nar number; l_narf number;
l_nom number; l_spl number;
l_sumR number; l_sumR2 number;
l_sumR_1 number; l_sumRp number;
l_dosR number; l_kosR number;
l_dosR2 number; l_kosR2 number;
l_spov number;
l_dat01 date :=to_date('20110101','YYYYMMDD');
l_dat1 date; l_dat2 date; l_dat_d date; l_dat_dp date;
l_dn int; l_dn_d int;   l_ref_f int;
l_zal number; l_s_d number; l_kol int;
l_mfo varchar2(6);  l_sab char(4); l_nb varchar2(38);
 ern CONSTANT POSITIVE   := 208; err EXCEPTION; erm VARCHAR2(80);
 err_num number;  err_msg varchar2(80);
begin
--l_userid:=user_id;

LOG('F2: STARTED','INFO',0);
LOG('F2: start dat1='||p_dat1||' dat2='||p_dat2,'INFO');

l_dat1:=p_dat1;
if p_dat1=p_dat2 then l_dat1:=l_dat01; end if;
delete from tmp_cp_rep where id_u=l_userid and frm='2';
l_ref_f:=0;

for l in
(select k.id,k.cp_id,k.dat_em,trunc(k.datp) DATP,k.cena,k.ir,k.emi,
          sumb,v.acc,nvl(v.accr,-1) accr,v.accr2,v.osta,v.ostr,v.ostr2,
          v.ref,trunc(v.mdate) MDATE,k.period_kup,v.osta/k.cena kol,v.dapp,
          s.fdat,s.dos/100 DOS,s.kos/100 KOS, v.datd
          from cp_kod k, cp_v v, saldoa s
          where k.tip=2 and v.vidd like '332%' and k.emi=3
                and k.datp > l_dat1 and k.dat_em <= p_dat2
              --  and v.sos > 0
                and v.sos=5
              --  and v.osta !=0
                and v.acc = s.acc  and s.dos!=0
                and s.fdat <= p_dat2 and s.fdat >= l_dat1
                and k.id=v.id order by k.cp_id,v.ref)

loop

--if trunc(l.dapp) <= l.datp and l.dapp!=l.dat_em then
if l.fdat < l.datp and l.dapp!=l.dat_em then
l_dn_d:=l.fdat - l.dat_em - 1; if l_dn_d=0 then l_dn_d:=1; end if;
l_dat2:=l.dapp;  -- l_dat2:=l.fdat;
LOG('F2: cp_id='||l.cp_id||' '||l.id||' dapp='||l.dapp||' '||l.ref,'INFO');
else
LOG('F2: NO cp_id='||l.cp_id||' '||l.id||' dapp='||l.dapp||' '||l.ref,'INFO');
goto EX2;
end if;

--if l.fdat=l.datp then
--LOG('F2: погашено остаточно cp_id='||l.cp_id||' '||l.id
--                         ||' dat_d=datp='||l.fdat||' '||l.ref,'TRACE');
--goto EX2;
--end if;

begin
if l_ref_f!=l.ref then l_ref_f:=l.ref;
   l_dat_dp:=l.datd;
else l_dat_dp:=l_dat_d;
end if;
l_dat_d:=l.fdat;
l_mfo:=trim(cp_rep.get_mfo(l.ref));
l_zal:=fost(l.acc,l_dat_d-1)/100;  l_kol:=round(l_zal/l.cena,0);
l_nom:=fost(l.acc,l_dat_d)/100;
l_s_d:=l_zal-l_nom;                -- сума часткового дост. погашення
l_spov:=0;

l_sumR:=fost(l.accr,l_dat_d)/100;     -- вих.залишок на р-ку R в дату погашення
--l_sumR_1:=fost(l.accr,l_dat_d-1)/100;
l_sumRp:=fost(l.accr,l_dat_dp)/100;
begin
--l_dosR:=FDOS(l.accr,l.datd,l_dat_d)/100;
 SELECT  nvl(sum(o.s),0)/100 into l_dosR         -- сплачено
   FROM  opldok o, opldok o1
   WHERE o.acc  = l.accr and o.sos=5
        -- and o.tt in ....
        and o.dk=0    --and o.sos>0
        and o.ref=o1.ref and o.stmt=o1.stmt and o1.dk=1-o.dk
        and o1.acc in (select acc from accounts where nbs='4621')
        and o.fdat > l_dat_dp AND o.fdat <= l_dat_d;
end;
begin
--l_kosR:=FKOS(l.accr,l.datd,l_dat_d)/100;
 SELECT  nvl(sum(o.s),0)/100 into l_kosR       -- нараховано
   FROM  opldok o, opldok o1
   WHERE o.acc  = l.accr and o.sos=5
        -- and o.tt in ....
        and o.dk=1     --and o.sos>0
        and o.ref=o1.ref and o.stmt=o1.stmt and o1.dk=1-o.dk
        and o1.acc in (select acc from accounts where nbs like '7%')
        and o.fdat > l_dat_dp AND o.fdat <= l_dat_d;
end;

begin
 SELECT  nvl(sum(o.s),0)/100 into l_spov     -- повернуто на 7 клас
   FROM  opldok o, opldok o1
   WHERE o.acc  = l.accr and o.sos=5
        -- and o.tt in ....
        and o.dk=0     --and o.sos>0
        and o.ref=o1.ref and o.stmt=o1.stmt and o1.dk=1-o.dk
        and o1.acc in (select acc from accounts where nbs like '7%')
        and o.fdat > l_dat_dp AND o.fdat <= l_dat_d;
end;

/*
begin
SELECT  nvl(sum(decode(o.dk,0,o.s,0)),0)/100 vypl,
        nvl(sum(decode(o.dk,1,o.s,0)),0)/100 nar
 into l_dosR,l_kosR        -- сплачено/нараховано
 FROM  opldok o, opldok o1
 WHERE o.acc  = l.accr   and o.sos=5
                        -- and o.sos>0
       -- and o.tt in ....   --   and o.dk=0
       and o.ref=o1.ref and o.stmt=o1.stmt and o1.dk=1-o.dk
       and o1.acc in (select acc from accounts where nbs=decode(o.dk,0,'4621','7032'))
       and o.fdat >= l.datd AND o.fdat <= l_dat_d;
end;
  */

l_dn:=l.datp - l.dat_em - 1;
if l.accr2 is null then       -- р-к R2
l_sumR2:=0;
l_dosR2:=0; l_kosR2:=0;
else
l_sumR2:=fost(l.accr2,l_dat_d)/100;
l_dosR2:=FDOS(l.accr2,l.datd,l_dat_d)/100;
l_kosR2:=FKOS(l.accr2,l.datd,l_dat_d)/100;
end if;
l_narf:=l.ostr+l.ostr2;   --поточний вих.залишок на р-х R та R2
--l_nar:=l_sumR+l_sumR2;  --вих.залишок на р-х R та R2 в дату погашення
l_nar:=l_kosR+l_kosR2+l_sumRp;    -- купон нарахований на дату погашення
l_spl:=l_dosR+l_dosR2;    -- купон виплачений банку на дату погашення
if l_dat_d != l.datp   then
l_nar:=l_dosR+l_spov;
end if;
if l.cp_id='9949' then
--LOG('F2: cp_id='||l.cp_id||' ref='||l.ref||' dat_d='||l_dat_dp
--    ||' '||l_nar||' '||l_kosR||' '||l_sumRp||' '||l_sumR,'INFO');
NULL;
end if;
exception when OTHERS then  NULL;
-- logger.error( 'cp_rep.PR_F2 .... ');
raise;
end;

if l_mfo ='??' or l_mfo is NULL then
l_sab:=''; l_nb:='??';
else
begin
select sab,nb into l_sab, l_nb
from banks where mfo=l_mfo;
exception when NO_DATA_FOUND then  NULL;
l_sab:=''; l_nb:='??';
end;
end if;

if l_dat_d=l.datp then
LOG('F2: погашено остаточно cp_id='||l.cp_id||' '||l.id
                         ||' dat_d=datp='||l_dat_d||' '||l.ref,'TRACE');
NULL;
goto EX2;
end if;

<<ZAP>> NULL;
    /***
begin
insert into tmp_cp_rep
(id,mfo,tu,name,
 cp_id,dat_em,datp,ir,kv,cena,nom,kol,k_nar,s_nar,k_spl,
 s_zm, dn,
 s_dpog,dat_dpog,dn_d,ir_d,period_kup,emi,ref, s_spl,
 id_u,frm)
values
(l.id,l_mfo,l_sab,l_nb,
 l.cp_id,l.dat_em,l.datp,l.ir,980,l.cena,l_zal,l_kol,l_nar,
 l_narf, l_spl,
 l_spov,    --l_nar-l_spl,
 l_dn,
 l_s_d,l_dat_d,l_dn_d,l.ir*0.2,l.period_kup,l.emi,l.ref, l_nom,
 l_userid,'2');
exception     --when no_data_found then  NULL;
          when others then NULL;
LOG('F2: cp_id='||l.cp_id||' ? помилка INSERT'||' ref='||l.ref,'ERROR');
end;
     ***/
<<EX2>> NULL;
end loop;

commit;
end;


procedure PR_F4(p_dat date) is
--НБУ ДС. Iнформацiя щодо нарахувань. Додаток 4.
--30.09.2011. Сухова.
                                        M_10 number; M_11 number; M_12 number;
 r_01 number; r_02 number; r_03 number; r_04 number; r_05 number; r_06 number;
 r_07 number; r_08 number; r_09 number; r_10 number; r_11 number; r_12 number; r_13 number;

-- i_01 number; i_02 number; i_03 number; i_04 number; i_05 number; i_06 number; i_00 number;
-- i_07 number; i_08 number; i_09 number; i_10 number; i_11 number; i_12 number; i_13 number;

 l_nbs   accounts.nbs%type;
 l_mfo   varchar2(6)      ;
 l_nb    varchar2(38)     ;
 L_YYYY  INT  ;
 l_mm    int  ;
 dat1_   date ;

begin
-- If p_mode <> 0 then  return; end if;
LOG('F4 STARTED-***','INFO',0);


--- delete from ds_d4 where id = user_id;

-- i_01 :=0 ; i_02 :=0; i_03 :=0; i_04 :=0; i_05 :=0; i_06 :=0; i_00 :=0;
-- i_07 :=0 ; i_08 :=0; i_09 :=0; i_10 :=0; i_11 :=0; i_12 :=0; i_13 :=0;

 L_YYYY := to_number(to_char(p_dat,'YYYY'));
 l_mm   := to_number(to_char(p_dat,'MM'));
 dat1_  := trunc(p_dat,'yyyy');
                    /****
 for k in (SELECT  O.VDAT                DT_01 ,
                   K.DATP                DT_02 ,
                   k.cp_id               CP_06 ,
                   FOST(a.acc,a.daos)/(K.CENA*100)   KL_07 ,
                   k.ir                  IR_08 ,
                   K.CENA                NO_09 ,
                   K.DATP - O.VDAT       KL_10 ,
                   FOST(a.acc,a.daos)/100            SN_11 ,
                   e.ref, e.ACC, e.accr, a.daos
           FROM cp_kod k, cp_deal e, accounts a,   oper o
           WHERE o.REF = e.REF
             AND k.ID  = e.ID
             AND a.acc = e.acc
             AND K.TIP = 2
             AND O.SOS = 5
             AND ( FOST(a.acc,p_dat)>0 or K.DATP >= dat1_ and k.dat_em < p_dat)
             AND K.CENA >0
             )
 loop

   begin
     select substr(trim(cp_rep.get_MFO(k.ref)),1,6) into l_mfo from dual;
     begin
       select nb into l_nb from banks where mfo =l_mfo;
     exception when no_data_found then l_nb :=null;
     end;
   exception   when others        then l_mfo := null;
   end;
                                  M_10 :=0; M_11 :=0; M_12 :=0;
   r_01 :=0 ; r_02 :=0; r_03 :=0; r_04 :=0; r_05 :=0; r_06 :=0;
   r_07 :=0 ; r_08 :=0; r_09 :=0; r_10 :=0; r_11 :=0; r_12 :=0; r_13 :=0;

   for x in (select to_number(to_char(o.vdat,'mm'  )) MM  ,
                    to_number(to_char(o.vdat,'YYYY')) YYYY,
                    p.DK, p.S/100 S, p.ref, p.STMT from oper o, opldok p
             where p.ref=o.ref
               and p.acc = k.ACCR
               and p.fdat >= k.DAOS
               and p.sos=5)
   loop
      If x.dk = 1 then

         -- збiльшення нарахування
         iF L_YYYY = x.yyyy THEN
            If    x.mm = 1 then r_01 := r_01 + x.s;
            elsIf x.mm = 2 then r_02 := r_02 + x.s;
            elsIf x.mm = 3 then r_03 := r_03 + x.s;
            elsIf x.mm = 4 then r_04 := r_04 + x.s;
            elsIf x.mm = 5 then r_05 := r_05 + x.s;
            elsIf x.mm = 6 then r_06 := r_06 + x.s;
            elsIf x.mm = 7 then r_07 := r_07 + x.s;
            elsIf x.mm = 8 then r_08 := r_08 + x.s;
            elsIf x.mm = 9 then r_09 := r_09 + x.s;
            elsIf x.mm =10 then r_10 := r_10 + x.s;
            elsIf x.mm =11 then r_11 := r_11 + x.s;
            elsIf x.mm =12 then r_12 := r_12 + x.s;
            end if;
         ELSE
            If    x.mm =10 then M_10 := M_10 + x.s;
            elsIf x.mm =11 then M_11 := M_11 + x.s;
            elsIf x.mm =12 then M_12 := M_12 + x.s;
            end if;
         end if;

      else
         begin
            select a.nbs
            into l_nbs
            from accounts a, opldok o
            where o.ref  = x.ref
              and o.stmt = x.stmt
              and o.dk   = 1-x.dk
              and a.acc  = o.acc;
            if l_nbs like '7%' OR l_nbs like '6%' then

               -- зменшення нарахування
               iF L_YYYY = x.yyyy THEN
                  If    x.mm = 1 then r_01 := r_01 - x.s;
                  elsIf x.mm = 2 then r_02 := r_02 - x.s;
                  elsIf x.mm = 3 then r_03 := r_03 - x.s;
                  elsIf x.mm = 4 then r_04 := r_04 - x.s;
                  elsIf x.mm = 5 then r_05 := r_05 - x.s;
                  elsIf x.mm = 6 then r_06 := r_06 - x.s;
                  elsIf x.mm = 7 then r_07 := r_07 - x.s;
                  elsIf x.mm = 8 then r_08 := r_08 - x.s;
                  elsIf x.mm = 9 then r_09 := r_09 - x.s;
                  elsIf x.mm =10 then r_10 := r_10 - x.s;
                  elsIf x.mm =11 then r_11 := r_11 - x.s;
                  elsIf x.mm =12 then r_12 := r_12 - x.s;
                  end if;
               ELSE
                  If    x.mm =10 then M_10 := M_10 - x.s;
                  elsIf x.mm =11 then M_11 := M_11 - x.s;
                  elsIf x.mm =12 then M_12 := M_12 - x.s;
                  end if;
               end if;
            else                    r_13 := r_13 + x.s;
                -- сплата
            end if;
         exception when no_data_found then  NULL;
         end;
      end if;
   end loop;
                    *****/

--   i_01:=i_01+r_01; i_02:=i_02+r_02; i_03:=i_03+r_03; i_04:=i_04+r_04; i_05:=i_05+r_05;
--   i_06:=i_06+r_06; i_07:=i_07+r_07; i_08:=i_08+r_08; i_09:=i_09+r_09; i_10:=i_10+r_10;
--   i_11:=i_11+r_11; i_12:=i_12+r_12; i_13:=i_13+r_13; i_00:=i_00+k.SN_11;
                 /****
   insert into DS_D4
(  DT_01,  DT_02,  CP_06,  KL_07,  IR_08,  NO_09,  KL_10,   SN_11,
   RR_01,  RR_02,  RR_03,  RR_04,  RR_05,  RR_06,  RR_07,   RR_08, RR_09,RR_10,RR_11,RR_12,
   SP_13,  ref  ,  id   ,  MF_03,  NB_04,  Rm_10,  Rm_11,   Rm_12
  )     values
(k.DT_01,k.DT_02,k.CP_06,k.KL_07,k.IR_08,k.NO_09,k.KL_10, k.SN_11,
    r_01,   r_02,   r_03,   r_04,   r_05,   r_06,   r_07,    r_08,  r_09, r_10, r_11, r_12,
    r_13,k.ref  , gl.aUid, l_mfo,  l_nb ,   m_10,   m_11,    m_12 );

 end loop;        ****/

/****
   insert into DS_D4
(  DT_01,  DT_02,  CP_06,  KL_07,  IR_08,  NO_09,  KL_10,   SN_11,
   RR_01,  RR_02,  RR_03,  RR_04,  RR_05,  RR_06,  RR_07,   RR_08, RR_09,RR_10,RR_11,RR_12,
   SP_13,  ref  ,  id)
values
(   null, null ,'УСЬОГО', null, null, null, null, i_00,
    i_01,  i_02,   i_03 , i_04, i_05, i_06, i_07, i_08, i_09, i_10, i_11, i_12,
    i_13, 0    , gl.aUid);
****/
     /***
-- скрыть/открыть колонки
declare
 l_tabid        meta_tables.tabid%type        ;
 l_NOT_TO_SHOW  meta_columns.NOT_TO_SHOW%type ;
 l_colname      meta_columns.colname%type     ;

begin

  select tabid into l_tabid from  meta_tables where tabname = 'DS_D4';
  for k in (select c.num mm from conductor c where c.num <=12)
  loop

     l_colname := 'RR_' || substr( '00' || k.mm, -2 );

     if k.mm <= l_mm then l_NOT_TO_SHOW := 0 ;        -- показать
     else                 l_NOT_TO_SHOW := 1 ;        -- скрыть
     end if;

     update meta_columns
            set NOT_TO_SHOW =  l_NOT_TO_SHOW
            where tabid = l_tabid and COLNAME = l_colname;
  NULL;
  end loop;

exception when no_data_found then  NULL;
end;
 ***/


end PR_F4;
--------------------------------

procedure PR_F7(p_dat1 date, p_dat2 date) is
--l_userid number;
l_sumb number; l_ref int; l_nd varchar2(10);
l_nar number; l_narf number;
l_nom number;
l_days int;
l_sumR number; l_sumR2 number;
 ern CONSTANT POSITIVE   := 208; err EXCEPTION; erm VARCHAR2(80);
 err_num number;  err_msg varchar2(80);
begin
--l_userid:=user_id;

LOG('F7 STARTED','INFO',0);
LOG('start dat1='||p_dat1||' dat2='||p_dat2,'INFO');

delete from tmp_cp_rep where id_u=l_userid and frm='7';

for l in (select k.id,k.cp_id,k.dat_em,k.datp,k.cena,k.ir,k.emi,
          sumb,v.acc,nvl(v.accr,-1) accr,nvl(v.accr2,-1) accr2,
          v.osta,v.ostr,v.ostr2,
          v.ref,v.mdate,k.period_kup,v.osta/k.cena kol
          from cp_kod k, cp_v v
          where k.tip=2 and v.vidd like '332%' and k.emi=3
                and k.datp > p_dat1 --and k.dat_em <= p_dat1
             --   and v.sos > 0
                and v.sos=5
                and k.id=v.id order by k.cp_id)
loop

l_days:= l.datp - l.dat_em +1;

begin
l_nom:=fost(l.acc,p_dat1)/100;
l_sumR:=fost(l.accr,p_dat1)/100;
l_sumR2:=fost(l.accr2,p_dat1)/100;
l_narf:=l.ostr+l.ostr2;
l_nar:=l_sumR+l_sumR2;
exception when OTHERS then  NULL;
--  logger.error( 'cp_rep.PR_F7  .....);
raise;
end;
   /***
begin
insert into tmp_cp_rep
(id,cp_id,dat_em,datp,ir,kv,cena,nom,kol,k_nar,s_nar,
 s_dpog,period_kup,emi,rnk,dn,
 id_u,frm)
values
(l.id,l.cp_id,l.dat_em,l.datp,l.ir,980,l.cena,l_nom,l.kol,l_nar,l_narf,
 l.osta,l.period_kup,l.emi,l.ref,l_days,
 l_userid,'7');
exception when others then  NULL;
LOG('F7: cp_id='||l.cp_id||' ? помилка INSERT'||' ref='||l.ref,'ERROR');
end;
      ***/
end loop;

commit;
end;
------------------------

PROCEDURE cp_klass
 ( p_ID  int , -- какую ЦБ   ( или все =0)
   p_dat2 date   -- дата звіту
   )  is

-- *** v.1.0  04/09-12   ***

  NLSV_  accounts.nls%type ;
  acc_   accounts.acc%type ;
  NLS_   accounts.nls%type ;
  NMS_   accounts.nms%type ;
  accc_  accounts.accc%type;
  r1_    int;
  ref_   oper.ref%type     ;
  tt_    oper.tt%type      := 'FXB';
  dk_    oper.dk%type      ;
  s_     oper.s%type       ;
  accD_  accounts.acc%type ;
  accP_  accounts.acc%type ;
  accS_  accounts.acc%type ;
  accR_  accounts.acc%type ;
  accR2_ accounts.acc%type ;
  accVD_ accounts.acc%type ;  vd_ number;  vd_d number;  vd_k number;
  accVP_ accounts.acc%type ;  vp_ number;  vp_d number;  vp_k number;
  VD_ACC accounts.acc%type ;
  VP_ACC accounts.acc%type ;
  accD_V accounts.acc%type ;
  accP_V accounts.acc%type ;
  accD_Vn accounts.acc%type ;
  accP_Vn accounts.acc%type ;
  l_kv   accounts.kv%type  ;
  l_NLS  accounts.nls%type ;
  l_NMS  accounts.nms%type ;
  nls_v accounts.nls%type;  nls_vn accounts.nls%type;
  nms_v accounts.nms%type;  pap_v accounts.pap%type;
  nms_vn accounts.nms%type;

  r_oper oper%rowtype      ;
  --------------------------
  r_pf1  cp_pf%rowtype     ;  -- з якого портф
  r_ryn1 cp_ryn%rowtype    ;  -- з якого суб/портф
  r_GL1  cp_accc%rowtype   ;
  --------------------------
  r_pf2  cp_pf%rowtype     ;  -- в який портф
  r_ryn2 cp_ryn%rowtype    ;  -- в який суб/портф
  r_GL2  cp_accc%rowtype   ;
  l_pf1  cp_pf.pf%type;
  l_pf2  cp_pf.pf%type;
  l_name cp_kod.name%type;
  l_dok  cp_kod.dok%type;
  l_dnk  cp_kod.dnk%type;
  l_cena cp_kod.cena%type;
  l_kol int;

  -- залишки
  SN_ number;
  SD_ number; SP_ number; SS_ number; SR_ number; SR2_ number;
  SDV_ number; SPV_ number;
  SN_Q number;
  SD_Q number; SP_Q number; SS_Q number; SR_Q number; SR2_Q number;
  SDV_Q number; SPV_Q number;
  SN_N number;
  SD_N number; SP_N number; SS_N number; SR_N number; SR2_N number;
  SDV_N number; SPV_N number;
  SN_NQ number;
  SD_NQ number; SP_NQ number; SS_NQ number; SR_NQ number; SR2_NQ number;
  SDV_NQ number; SPV_NQ number ;

  -- обороти
  ODN_ number ; ODN_K number; OKN_K number;  ODN_P number; OKN_P number;
  ODD_ number ; ODP_ number ;  ODS_ number ; ODR_ number; ODR2_ number;
  ODN_Q number;
  ODD_Q number; ODP_Q number; ODS_Q number; ODR_Q number; ODR2_Q number;

  ODD_K number ; ODP_K number ;  ODS_K number ; ODR_K number; ODR2_K number;
  ODN_KQ number;
  ODD_KQ number; ODP_KQ number; ODS_KQ number; ODR_KQ number; ODR2_KQ number;
  ODD_P number ; ODP_P number ;  ODS_P number ; ODR_P number; ODR2_P number;
  ODN_PQ number;
  ODD_PQ number; ODP_PQ number;  ODS_PQ number; ODR_PQ number; ODR2_PQ number;
  ODR_5 number;  ODR_5Q number;
  ODDV_ number ;  ODPV_ number;
  ODDV_Q number;  ODPV_Q number;
  ODDV_K number;  ODPV_K number ; OKDV_K number ;  OKPV_K number ;
  ODDV_KQ number;  ODPV_KQ number ; OKDV_KQ number ;  OKPV_KQ number ;
  ODDV_p number ;  ODPV_p number;  OKDV_p number ;  OKPV_p number;
  ODDV_pq number ;  ODPV_pq number;  OKDV_pq number ;  OKPV_pq number;

  ODN_N number;
  ODD_N number; ODP_N number;  ODS_N number; ODR_N number; ODR2_N number;
  ODN_Nq number;
  ODD_Nq number; ODP_Nq number;  ODS_Nq number; ODR_Nq number; ODR2_Nq number;

   -- обороти
  ON_ number ;
  OD_ number ; OP_ number ;  OS_ number ; OR_ number; OR2_ number;

  OKN_ number ;
  OKD_ number ; OKP_ number ;  OKS_ number ; OKR_ number; OKR2_ number;
  OKN_Q number ;
  OKD_Q number ; OKP_Q number ; OKS_Q number; OKR_Q number; OKR2_Q number;
  OKD_K number; OKP_K number;  OKS_K number; OKR_K number; OKR2_K number;
  OKN_KQ number ;
  OKD_KQ number; OKP_KQ number;  OKS_KQ number; OKR_KQ number; OKR2_KQ number;
  OKN_PQ number;
  OKD_P number; OKP_P number;  OKS_P number; OKR_P number; OKR2_P number;
  OKD_PQ number; OKP_PQ number;  OKS_PQ number; OKR_PQ number; OKR2_PQ number;
  OKDV_ number;  OKPV_ number;
  OKDV_Q number;  OKPV_Q number;

  ON_N number ;
  OD_N number ; OP_N number ;  OS_N number ; OR_N number; OR2_N number;

  OKN_N number;
  OKD_N number; OKP_N number;  OKS_N number; OKR_N number; OKR2_N number;
  OKN_Nq number;
  OKD_Nq number; OKP_Nq number;  OKS_Nq number; OKR_Nq number; OKR2_Nq number;

  ODN_P_new number; OKN_P_new number;
  ODD_P_new number ; ODP_P_new number ;  ODS_P_new number ; ODR_P_new number; ODR2_P_new number;
  ODN_PQ_new number;
  ODD_PQ_new number; ODP_PQ_new number;  ODS_PQ_new number; ODR_PQ_new number; ODR2_PQ_new number;

  OKN_PQ_new number;
  OKD_P_new number; OKP_P_new number;  OKS_P_new number; OKR_P_new number; OKR2_P_new number;
  OKD_PQ_new number; OKP_PQ_new number;  OKS_PQ_new number; OKR_PQ_new number; OKR2_PQ_new number;

  ODDV_n number ;  ODPV_n number;    OKDV_n number;  OKPV_n number;
  ODDV_nq number ;  ODPV_nq number;    OKDV_nq number;  OKPV_nq number;
  ODDV_p_new number ; ODPV_p_new number; OKDV_p_new number ; OKPV_p_new number;
  ODDV_pq_new number ; ODPV_pq_new number; OKDV_pq_new number ; OKPV_pq_new number;

  accVD_n accounts.acc%type ;  vd_n number;  vd_dn number;  vd_kn number;
  accVP_n accounts.acc%type ;  vp_n number;  vp_dn number;  vp_kn number;

  ODN_K_new number;
  ODD_K_new number; ODP_K_new number; ODS_K_new number; ODR_K_new number; ODR2_K_new number;
  ODN_KQ_new number;
  ODD_KQ_new number; ODP_KQ_new number; ODS_KQ_new number; ODR_KQ_new number; ODR2_KQ_new number;
  OKN_K_new number;
  OKD_K_new number; OKP_K_new number; OKS_K_new number; OKR_K_new number; OKR2_K_new number;
  OKN_KQ_new number;
  OKD_KQ_new number; OKP_KQ_new number; OKS_KQ_new number; OKR_KQ_new number; OKR2_KQ_new number;
  ODDV_K_new number; ODPV_K_new number; OKDV_K_new number; OKPV_K_new number ;
  ODDV_KQ_new number; ODPV_KQ_new number; OKDV_KQ_new number; OKPV_KQ_new number;

  pap_n int; pap_d int; pap_p int; pap_r int; pap_r2 int; pap_s int;
  pap_n_n int; pap_d_n int; pap_p_n int; pap_r_n int; pap_r2_n int; pap_s_n int;
  pap_dv int; pap_pv int; pap_dv_n int; pap_pv_n int;

  --------------------------
  l_accb accounts.acc%Type ;
  l_IO   proc_dr.io%type   ;
----------------------------
  f_SS int  ;  -- флаг сворачивания SS
--------------
 l_dat1 date; l_dat2 date;  l_vdat date;
 r_dl1  cp_deal%rowtype   ;
 r_dl2  cp_deal%rowtype   ;
 l_nls_n2 accounts.nls%type ;
 l_nls_d2 accounts.nls%type ;
 l_nls_p2 accounts.nls%type ;
 l_nls_r2 accounts.nls%type ;
 l_nls_r22 accounts.nls%type;
 l_nls_s2 accounts.nls%type ;

 l_nms_n2 accounts.nms%type ;
 l_nms_d2 accounts.nms%type ;
 l_nms_p2 accounts.nms%type ;
 l_nms_r2 accounts.nms%type ;
 l_nms_r22 accounts.nms%type;
 l_nms_s2 accounts.nms%type ;

 l_mdl varchar2(20) := 'CPN';
 l_trace  varchar2(1000):= '';
 --l_userid int;


Function s_opl(p_ref int, p_acc int) return number is
l_s number;
begin
select sum(s) into l_s from opldok
where ref=p_ref and acc=p_acc and rownum=1;
return nvl(l_s,0);
end s_opl;


begin
l_dat1:=to_date('01/01/2012','dd/mm/yyyy');
l_dat2:=p_dat2;
--l_userid := user_id;
LOG('CP_KLASS дата '||p_dat2||' p_id='||p_id,'INFO',0);
delete from tmp_cp_rep where 1=1 and userid=l_userid and frm='55';   --id=p_id;
commit;
for k in (select e.ID, e.RYN,    -- e.pf_new, e.ryn_new,
                 e.ACC, e.REF, a.ostc SA, o.nd, ar.sumb,
                 substr(a.nls,1,4) nbs1,
                 a.kv, a.pap, a.rnk, a.grp, a.isp, a.mdate,
                 a.nls,  substr(a.nms,1,38) nms, g.nls NLSG,
                 e.accD, e.accP,e.accR,e.accR2,e.AccS,
                 substr(d.nms,1,38) nms_d, substr(p.nms,1,38) nms_p,
                 substr(r.nms,1,38) nms_r, substr(r2.nms,1,38) nms_r2,
                 substr(s.nms,1,38) nms_s,
                 a.pap pap_n, d.pap pap_d, p.pap pap_p, s.pap pap_s,
                 r.pap pap_r, r2.pap pap_r2,
                 k.cp_id, k.emi, k.DATP,
                 d.ostc  SD , d.nls NLSD,
                 p.ostc  SP , p.nls NLSP,
                 nvl(r.ostc,0)  SR , r.nls NLSR,
                 nvl(r2.ostc,0) SR2, r2.nls NLSR2,
                 s.ostc  SS , s.nls NLSS,
                 k.name, k.dok, k.dnk, k.cena,
                 e.ref ref_new          -- !!
          from cp_deal e, cp_kod k, accounts g, oper o, cp_arch ar,
               accounts a,accounts d,accounts p,accounts r,accounts r2,
               accounts s
          where e.acc   = a.acc       --and a.ostc <> 0
            and a.accc  = g.acc and e.id = k.id
            and o.ref = e.ref and e.ref = ar.ref
            and e.accd  = d.acc  (+)
            and e.accp  = p.acc  (+)
            and e.accr  = r.acc  (+)
            and e.accr2 = r2.acc (+)
            and e.accs  = s.acc  (+)
            and e.id    = decode (nvl(p_id ,0), 0, e.id , p_id  )
        --    and e.ref   = decode (nvl(p_ref,0), 0, e.ref, p_ref )
        --    and e.ryn   = decode (nvl(p_R1,0 ), 0, e.ryn, p_R1 )
            and k.datp >= l_dat2 and k.dat_em <= l_dat2
        --    and e.ref_new is not null
        --    and e.ref_new in                     -- !! sos=5
        --        (select ref from oper where tt in ('FXG','FXI') and sos>0)
order by 1,3,4
             )
loop
l_kv:=k.kv;  l_name := k.name;
l_dok:=k.dok; l_dnk:=k.dnk; l_cena:=k.cena; l_kol:=abs(k.sa/l_cena);
ON_:=0; OD_:=0; OP_:=0; OS_:=0; OR_:=0; OR2_:=0;
SN_:=0; SD_:=0; SP_:=0; SS_:=0; SR_:=0; SR2_:=0; SDV_:=0; SPV_:=0;
SN_Q:=0; SD_Q:=0; SP_Q:=0; SS_Q:=0; SR_Q:=0; SR2_Q:=0; SDV_Q:=0; SPV_Q:=0;

ODN_:=0; ODD_:=0; ODP_:=0; ODS_:=0; ODR_:=0; ODR2_:=0;
ODN_Q:=0; ODD_Q:=0; ODP_Q:=0; ODS_Q:=0; ODR_Q:=0; ODR2_Q:=0;
ODN_P:=0; ODD_P:=0; ODP_P:=0; ODS_P:=0; ODR_P:=0; ODR2_P:=0;
ODR_5:=0; ODR_5Q:=0;
ODN_PQ:=0; ODD_PQ:=0; ODP_PQ:=0; ODS_PQ:=0; ODR_PQ:=0; ODR2_PQ:=0;

ODN_K:=0; ODD_K:=0; ODP_K:=0; ODS_K:=0; ODR_K:=0; ODR2_K:=0; ODDV_:=0; ODPV_:=0;
ODDV_K:=0; ODPV_K:=0;
ODN_KQ:=0; ODD_KQ:=0; ODP_KQ:=0; ODS_KQ:=0; ODR_KQ:=0; ODR2_KQ:=0;
ODDV_KQ:=0; ODPV_KQ:=0;

OKN_:=0; OKD_:=0; OKP_:=0; OKS_:=0; OKR_:=0; OKR2_:=0;
OKN_Q:=0; OKD_Q:=0; OKP_Q:=0; OKS_Q:=0; OKR_Q:=0; OKR2_Q:=0;
OKN_P:=0; OKD_P:=0; OKP_P:=0; OKS_P:=0; OKR_P:=0; OKR2_P:=0;
OKN_PQ:=0; OKD_PQ:=0; OKP_PQ:=0; OKS_PQ:=0; OKR_PQ:=0; OKR2_PQ:=0;

OKN_K:=0; OKD_K:=0; OKP_K:=0; OKS_K:=0; OKR_K:=0; OKR2_K:=0; OKDV_:=0; OKPV_:=0;
OKN_KQ:=0; OKD_KQ:=0; OKP_KQ:=0; OKS_KQ:=0; OKR_KQ:=0; OKR2_KQ:=0; OKDV_Q:=0; OKPV_Q:=0;
OKDV_K:=0; OKPV_K:=0;
OKDV_KQ:=0;

ODN_K_new:=0; ODD_K_new:=0; ODP_K_new:=0; ODS_K_new:=0; ODR_K_new:=0; ODR2_K_new:=0;
ODDV_K_new:=0; ODPV_K_new:=0;
ODN_KQ_new:=0; ODD_KQ_new:=0; ODP_KQ_new:=0; ODS_KQ_new:=0; ODR_KQ_new:=0; ODR2_KQ_new:=0;
ODDV_KQ_new:=0; ODPV_KQ_new:=0;

OKN_K_new:=0; OKD_K_new:=0; OKP_K_new:=0; OKS_K_new:=0; OKR_K_new:=0; OKR2_K_new:=0;
OKDV_K_new:=0; OKPV_K_new:=0;
OKN_KQ_new:=0; OKD_KQ_new:=0; OKP_KQ_new:=0; OKS_KQ_new:=0; OKR_KQ_new:=0; OKR2_KQ_new:=0;
OKDV_KQ_new:=0; OKPV_KQ_new:=0;

ODN_P_new:=0; ODD_P_new:=0; ODP_P_new:=0; ODS_P_new:=0; ODR_P_new:=0; ODR2_P_new:=0;
OKN_P_new:=0; OKD_P_new:=0; OKP_P_new:=0; OKS_P_new:=0; OKR_P_new:=0; OKR2_P_new:=0;
ODN_Pq_new:=0; ODD_Pq_new:=0; ODP_Pq_new:=0; ODS_Pq_new:=0; ODR_Pq_new:=0; ODR2_Pq_new:=0;
OKN_Pq_new:=0; OKD_Pq_new:=0; OKP_Pq_new:=0; OKS_Pq_new:=0; OKR_Pq_new:=0; OKR2_Pq_new:=0;

ON_N:=0; OD_N:=0; OP_N:=0; OS_N:=0; OR_N:=0; OR2_N:=0;
SN_N:=0; SD_N:=0; SP_N:=0; SS_N:=0; SR_N:=0; SR2_N:=0; SDV_N:=0; SPV_N:=0;
SN_Nq:=0; SD_Nq:=0; SP_Nq:=0; SS_Nq:=0; SR_Nq:=0; SR2_Nq:=0; SDV_Nq:=0; SPV_Nq:=0;
ODN_N:=0; ODD_N:=0; ODP_N:=0; ODS_N:=0; ODR_N:=0; ODR2_N:=0;
accd_v:=null; accp_v:=null; accd_vn:=null; accp_vn:=null;
vd_d:=0; vp_d:=0; vd_k:=0; vp_k:=0;
vd_dn:=0; vp_dn:=0; vd_kn:=0; vp_kn:=0;
oddv_p:=0; odpv_p:=0; okdv_p:=0; okpv_p:=0;
oddv_pq:=0; odpv_pq:=0; okdv_pq:=0; okpv_pq:=0;
oddv_p_new:=0; odpv_p_new:=0; okdv_p_new:=0; okpv_p_new:=0;
oddv_pq_new:=0; odpv_pq_new:=0; okdv_pq_new:=0; okpv_pq_new:=0;

LOG('CP_KLASS ID='||k.id||' '||k.cp_id||' '||k.ref,'INFO',0);

/***
--------
select    -- e.ref,
nvl((select  sum(s)/100 from opldok where ref =e.ref and acc = e.acc),0)  a,
nvl((select  sum(s)/100 from opldok where ref =e.ref and acc = e.accd),0) d,
nvl((select  sum(s)/100 from opldok where ref =e.ref and acc = e.accp),0) p,
nvl((select  sum(s)/100 from opldok where ref =e.ref and acc = e.accr),0) r,
nvl((select  sum(s)/100 from opldok where ref =e.ref and acc = e.accr2),0) r2,
nvl((select  sum(s)/100 from opldok where ref =e.ref and acc = e.accs),0) s
into ON_,OD_,OP_,OR_,OR2_,OS_
 from cp_deal e where e.ref= k.ref_new;
  ****/

select pf into l_pf1 from cp_v where acc=k.acc;

begin
--select * into r_gl2 from cp_accp
--where pf=pf_new and ryn=ryn_new and vidd=...  and emi=k.emi;
NULL;
end;
--begin
--select vdat into l_vdat from oper where ref=k.ref_new;
--exception when NO_DATA_FOUND then NULL;
--end;

 begin
 select * into r_dl1 from cp_deal where ref=k.ref;
 end;
--LOG('CP_KLASS dl1='||r_dl1.acc||' '||r_dl1.accd||' '||r_dl1.accr,'INFO',0);

  select pf into l_pf2 from cp_v where acc=r_dl1.acc;

-- бухмодель перекласифікації для старих рах-в
select Nvl(sum(decode(o.dk,0,1,0)*o.s),0)/100, Nvl(sum(decode(o.dk,0,1,0)*o.sq),0)/100,
       Nvl(sum(decode(o.dk,0,0,1)*o.s),0)/100, Nvl(sum(decode(o.dk,0,0,1)*o.sq),0)/100
                into ODN_P, ODN_PQ, OKN_P, OKN_PQ
                from opldok o
                where o.ref = k.ref_new and acc = r_dl1.acc;

select Nvl(sum(decode(o.dk,0,1,0)*o.s),0)/100, Nvl(sum(decode(o.dk,0,1,0)*o.sq),0)/100,
       Nvl(sum(decode(o.dk,0,0,1)*o.s),0)/100, Nvl(sum(decode(o.dk,0,0,1)*o.sq),0)/100
                into ODD_P, ODD_PQ, OKD_P, OKD_PQ
                from opldok o
                where o.ref = k.ref_new and acc = r_dl1.accd;

select Nvl(sum(decode(o.dk,0,1,0)*o.s),0)/100, Nvl(sum(decode(o.dk,0,1,0)*o.sq),0)/100,
       Nvl(sum(decode(o.dk,0,0,1)*o.s),0)/100, Nvl(sum(decode(o.dk,0,0,1)*o.sq),0)/100
                into ODP_P, ODP_PQ, OKP_P, OKP_PQ
                from opldok o
                where o.ref = k.ref_new and acc = r_dl1.accp;

select Nvl(sum(decode(o.dk,0,1,0)*o.s),0)/100, Nvl(sum(decode(o.dk,0,1,0)*o.sq),0)/100,
       Nvl(sum(decode(o.dk,0,0,1)*o.s),0)/100, Nvl(sum(decode(o.dk,0,0,1)*o.sq),0)/100
                into ODR_P, ODR_PQ, OKR_P, OKR_PQ
                from opldok o
                where o.ref = k.ref_new and acc = r_dl1.accr;

select Nvl(sum(decode(o.dk,0,1,0)*o.s),0)/100, Nvl(sum(decode(o.dk,0,1,0)*o.sq),0)/100,
       Nvl(sum(decode(o.dk,0,0,1)*o.s),0)/100, Nvl(sum(decode(o.dk,0,0,1)*o.sq),0)/100
                into ODR2_P, ODR2_PQ, OKR2_P, OKR2_PQ
                from opldok o
                where o.ref = k.ref_new and acc = r_dl1.accr2;

select Nvl(sum(decode(o.dk,0,1,0)*o.s),0)/100, Nvl(sum(decode(o.dk,0,1,0)*o.sq),0)/100,
       Nvl(sum(decode(o.dk,0,0,1)*o.s),0)/100, Nvl(sum(decode(o.dk,0,0,1)*o.sq),0)/100
                into ODS_P, ODS_PQ, OKS_P, OKS_PQ
                from opldok o
                where o.ref = k.ref_new and acc = r_dl1.accs;

 begin
 if k.ref_new is not null then
 select * into r_dl2 from cp_deal where ref=k.ref_new;
 end if;
 end;
--LOG('CP_KLASS dl2='||r_dl2.acc||' '||r_dl2.accd||' '||r_dl2.accr,'INFO',0);

   l_dat2:=l_vdat;   --   -1;

if k.ref_new is     null then
   l_dat2:=to_date('31/12/2012','dd/mm/yyyy');
else

-- бухмодель перекласифікації для нових рах-в
select Nvl(sum(decode(o.dk,0,1,0)*o.s),0)/100, Nvl(sum(decode(o.dk,0,1,0)*o.sq),0)/100,
       Nvl(sum(decode(o.dk,0,0,1)*o.s),0)/100, Nvl(sum(decode(o.dk,0,0,1)*o.sq),0)/100
                into ODN_P_new, ODN_PQ_new, OKN_P_new, OKN_PQ_new
                from opldok o
                where o.ref = k.ref_new and acc = r_dl2.acc;

select Nvl(sum(decode(o.dk,0,1,0)*o.s),0)/100, Nvl(sum(decode(o.dk,0,1,0)*o.sq),0)/100,
       Nvl(sum(decode(o.dk,0,0,1)*o.s),0)/100, Nvl(sum(decode(o.dk,0,0,1)*o.sq),0)/100
                into ODD_P_new, ODD_PQ_new, OKD_P_new, OKD_PQ_new
                from opldok o
                where o.ref = k.ref_new and acc = r_dl2.accd;

select Nvl(sum(decode(o.dk,0,1,0)*o.s),0)/100, Nvl(sum(decode(o.dk,0,1,0)*o.sq),0)/100,
       Nvl(sum(decode(o.dk,0,0,1)*o.s),0)/100, Nvl(sum(decode(o.dk,0,0,1)*o.sq),0)/100
                into ODP_P_new, ODP_PQ_new, OKP_P_new, OKP_PQ_new
                from opldok o
                where o.ref = k.ref_new and acc = r_dl2.accp;

select Nvl(sum(decode(o.dk,0,1,0)*o.s),0)/100, Nvl(sum(decode(o.dk,0,1,0)*o.sq),0)/100,
       Nvl(sum(decode(o.dk,0,0,1)*o.s),0)/100, Nvl(sum(decode(o.dk,0,0,1)*o.sq),0)/100
                into ODR_P_new, ODR_PQ_new, OKR_P_new, OKR_PQ_new
                from opldok o
                where o.ref = k.ref_new and acc = r_dl2.accr;

select Nvl(sum(decode(o.dk,0,1,0)*o.s),0)/100, Nvl(sum(decode(o.dk,0,1,0)*o.sq),0)/100,
       Nvl(sum(decode(o.dk,0,0,1)*o.s),0)/100, Nvl(sum(decode(o.dk,0,0,1)*o.sq),0)/100
                into ODR2_P_new, ODR2_PQ_new, OKR2_P_new, OKR2_PQ_new
                from opldok o
                where o.ref = k.ref_new and acc = r_dl2.accr2;

select Nvl(sum(decode(o.dk,0,1,0)*o.s),0)/100, Nvl(sum(decode(o.dk,0,1,0)*o.sq),0)/100,
       Nvl(sum(decode(o.dk,0,0,1)*o.s),0)/100, Nvl(sum(decode(o.dk,0,0,1)*o.sq),0)/100
                into ODS_P_new, ODS_PQ_new, OKS_P_new, OKS_PQ_new
                from opldok o
                where o.ref = k.ref_new and acc = r_dl2.accs;
end if;  -- ref_new

if r_dl1.acc is not null or r_dl2.acc is not null then

-- вих. залишки та обороти по  складових рах-х
-- для old за l_dat1 по l_dat2           (по дату перек-ії включно)
-- для new за l_dat2 по l_dat2+1       (по дату перек-ії включно)
 select fost(r_dl1.acc,l_dat1)/100 into SN_ from dual;
-- select fostdn(r_dl1.acc,l_dat1)/100 into SN_q from dual;
  --  потрібно по OPLDOK з аналізом TT
 select fdos(r_dl1.acc,l_dat1,l_dat2)/100,
        fkos(r_dl1.acc,l_dat1,l_dat2)/100 into ODN_, OKN_ from dual;
 select fdosn(l_kv,r_dl1.acc,l_dat1,l_dat2)/100,
        fkosn(l_kv,r_dl1.acc,l_dat1,l_dat2)/100 into ODN_q, OKN_q from dual;
 if k.ref_new is not null then
 select fdos(r_dl2.acc,l_dat1,l_dat2)/100,
        fkos(r_dl2.acc,l_dat1,l_dat2)/100 into ODN_N, OKN_N from dual;
 select fost(r_dl2.acc,l_dat2)/100 into SN_N from dual;
 select fdosn(l_kv,r_dl2.acc,l_dat1,l_dat2)/100,
        fkosn(l_kv,r_dl2.acc,l_dat1,l_dat2)/100 into ODN_Nq, OKN_Nq from dual;
 select fostdn(r_dl2.acc,l_dat2,l_dat2)/100 into SN_Nq from dual;
 else
 ODN_N:=0; OKN_N:=0; SN_N:=0; ODN_Nq:=0; OKN_Nq:=0;
 end if;

--********
begin
-- if k.ref_new is not null then
select
      a.nls,                --  e.accD, e.accP, e.accR, e.accR2, e.AccS,
      d.nls NLSD, p.nls NLSP, r.nls NLSR, r2.nls NLSR2, s.nls NLSS,
      a.nms,
      d.nms NMSD, p.nms NMSP, r.nms NMSR, r2.nms NMSR2, s.nms NMSS,
      a.pap, d.pap, p.pap, r.pap, r2.pap, s.pap
                 -- virt D/P,
               --  d.ostc  SD , d.nls NLSD,
               --  p.ostc  SP , p.nls NLSP,
               --  nvl(r.ostc,0)  SR , r.nls NLSR,
               --  nvl(r2.ostc,0) SR2, r2.nls NLSR2,
               --  s.ostc  SS, s.nls NLSS
      into l_nls_n2, l_nls_d2, l_nls_p2, l_nls_r2, l_nls_r22, l_nls_s2,
           l_nms_n2, l_nms_d2, l_nms_p2, l_nms_r2, l_nms_r22, l_nms_s2,
           pap_n_n, pap_d_n, pap_p_n, pap_r_n, pap_r2_n, pap_s_n
          from
          (select * from cp_deal where ref=k.ref_new) r_dl2,
               accounts a,accounts d,accounts p,accounts r,accounts r2,accounts s
          where r_dl2.acc   = a.acc
            and nvl(r_dl2.accd,-100)  = d.acc  (+)
            and nvl(r_dl2.accp,-100)  = p.acc  (+)
            and nvl(r_dl2.accr,-100)  = r.acc  (+)
            and nvl(r_dl2.accr2,-100) = r2.acc (+)
            and nvl(r_dl2.accs,-100)  = s.acc  (+);
exception when NO_DATA_FOUND then NULL;
     l_nls_n2:='XXXXX';
-- end if;
end;
--********

-- визначати  залишки по рахунках-складових пакету на відповідні дати.
-- по SALDOA
           -- old virt  на момент створення
begin
select
decode (a.tip,'2VD',nvl((select sum(s)/100 from opldok where ref =r.ref and acc = a.acc and dk=0),0),0),
decode (a.tip,'2VP',nvl((select sum(s)/100 from opldok where ref =r.ref and acc = a.acc and dk=0),0),0),
decode (a.tip,'2VD',nvl((select sum(s)/100 from opldok where ref =r.ref and acc = a.acc and dk=1),0),0),
decode (a.tip,'2VP',nvl((select sum(s)/100 from opldok where ref =r.ref and acc = a.acc and dk=1),0),0),
decode (a.tip,'2VD',a.acc,null), decode (a.tip,'2VP',a.acc,null),
a.nls, substr(a.nms,1,38) nms,a.pap
into oddv_p, odpv_p, okdv_p, okpv_p, accd_v, accp_v, nls_v, nms_v, pap_v
from cp_ref_acc r, accounts a where r.ref= k.ref and r.acc= a.acc;
exception when NO_DATA_FOUND then NULL;
oddv_p:=0; odpv_p:=0; okdv_p:=0; okpv_p:=0;
accd_v:=null; accp_v:=null; nls_v:=null; nms_v:=null;
end;
        -- new virt    на момент створення
-- if k.ref_new is not null then
begin
select
decode (a.tip,'2VD',nvl((select sum(s)/100 from opldok where ref =r.ref and acc = a.acc and dk=0),0),0),
decode (a.tip,'2VP',nvl((select sum(s)/100 from opldok where ref =r.ref and acc = a.acc and dk=0),0),0),
decode (a.tip,'2VD',nvl((select sum(s)/100 from opldok where ref =r.ref and acc = a.acc and dk=1),0),0),
decode (a.tip,'2VP',nvl((select sum(s)/100 from opldok where ref =r.ref and acc = a.acc and dk=1),0),0),
decode (a.tip,'2VD',a.acc,null), decode (a.tip,'2VP',a.acc,null),
a.nls, substr(a.nms,1,38) nms
into oddv_p_new, odpv_p_new, okdv_p_new, okpv_p_new, accd_vn, accp_vn, nls_vn, nms_vn
from cp_ref_acc r, accounts a where r.ref= k.ref_new and r.acc= a.acc;
exception when NO_DATA_FOUND then NULL;
oddv_p_new:=0; odpv_p_new:=0; okdv_p_new:=0; okpv_p_new:=0;
accd_vn:=null; accp_vn:=null; nls_vn:=null;
end;
-- end if;
select Nvl(sum(decode(o.dk,0,1,0)*o.s),0)/100, Nvl(sum(decode(o.dk,0,1,0)*o.sq),0)/100,
       Nvl(sum(decode(o.dk,0,0,1)*o.s),0)/100, Nvl(sum(decode(o.dk,0,0,1)*o.sq),0)/100
                into ODN_K_new, ODN_KQ_new, OKN_K_new, OKN_KQ_new
                from opldok o, oper p
                where p.ref = o.ref and o.sos=5
                 and p.vdat >= l_dat1 and o.tt in ('FXH','FXH')
                 and o.acc = r_dl2.acc;

 ODN_:=ODN_-ODN_P; OKN_:=OKN_-OKN_P;
 ODN_q:=ODN_q-ODN_Pq; OKN_q:=OKN_q-OKN_Pq;

 begin
 insert into tmp_cp_rep
 (id,isin,kv,dat_p, cena,  nls,nms, vid_r, pap,  ref, ost_v, ost_vq,
  S_D, S_C,   S_DK, S_CK,
 --  nls_p, OST_P, ost_pq,
 -- s_dp, s_cp, nms_p,
 -- s_dp_new, s_cp_new, s_dk_new, s_ck_new,
 -- s_dpq_new, s_cpq_new, s_dkq_new, s_ckq_new,
 -- nls_p1, nls_s,
 -- S_Dq, S_Cq, S_DPq, S_CPq,  S_DKq, S_CKq,
  nbs_old, nbs_new,                          --pf_new, pf_old,
  name, dok, dnk, kol,
  ref2,userid,frm)
 values
 (k.id,k.cp_id,l_kv,l_dat2, l_cena, k.nls,k.nms,'N',k.pap_n,k.ref, SN_, SN_Q,
  ODN_, OKN_, ODN_K, OKN_K,
 -- l_nls_n2, SN_N, SN_Nq,
 -- ODN_P, OKN_P, l_nms_n2,
 -- odn_p_new, okn_p_new, odn_k_new, okn_k_new,
 -- odn_pq_new, okn_pq_new, odn_kq_new, okn_kq_new,
 -- l_nls_n2, r_dl2.acc,
 -- ODN_q, OKN_q, ODN_Pq, OKN_Pq, ODN_Kq, OKN_Kq,
  substr(l_nls_n2,1,4), substr(k.nls,1,4),     -- k.pf_new, l_pf2,
  l_name, l_dok, l_dnk, l_kol,
  k.ref_new,l_userid,'55');
 exception when others then NULL;
 LOG('CP_KLASS error N ID='||k.cp_id||' '||k.ref,'ERROR',0);
 end;

 goto zap5;
            /***
 begin
 insert into tmp_cp_rep
 (id,isin,kv,dat_p,  nls,nms, vid_r, pap,  ref, ost_v, ost_vq,
  S_D, S_C,   S_DK, S_CK,
  nls_p, OST_P, ost_pq,
  s_dp, s_cp, nms_p,
  s_dp_new, s_cp_new, s_dk_new, s_ck_new,
  s_dpq_new, s_cpq_new, s_dkq_new, s_ckq_new,
  nls_p1, nls_s,
  S_Dq, S_Cq, S_DPq, S_CPq,  S_DKq, S_CKq,
  nbs_old, nbs_new,                          --pf_new, pf_old,
  ref2,userid)
 values
 (k.id,k.cp_id,l_kv,l_dat2, k.nls,k.nms,'N',k.pap_n,k.ref, SN_, SN_Q,
  ODN_, OKN_, ODN_K, OKN_K,
  l_nls_n2, SN_N, SN_Nq,
  ODN_P, OKN_P, l_nms_n2,
  odn_p_new, okn_p_new, odn_k_new, okn_k_new,
  odn_pq_new, okn_pq_new, odn_kq_new, okn_kq_new,
  l_nls_n2, r_dl2.acc,
  ODN_q, OKN_q, ODN_Pq, OKN_Pq, ODN_Kq, OKN_Kq,
  substr(l_nls_n2,1,4), substr(k.nls,1,4),     -- k.pf_new, l_pf2,
  k.ref_new,l_userid);
 exception when others then NULL;
 LOG('CP_KLASS error N ID='||k.cp_id||' '||k.ref,'ERROR',0);
 end;
                   ****/
end if;

if r_dl1.accd is not null or r_dl2.accd is not null then

 select fost(r_dl1.accd,l_dat1)/100 into SD_ from dual;
-- select fostdn(l_kv,r_dl1.accd,l_dat1)/100 into SD_q from dual;
  --  потрібно по OPLDOK з аналізом TT
 select fdos(r_dl1.accd,l_dat1,l_dat2)/100,
        fkos(r_dl1.accd,l_dat1,l_dat2)/100 into ODD_, OKD_ from dual;
 select fdosn(l_kv,r_dl1.accd,l_dat1,l_dat2)/100,
        fkosn(l_kv,r_dl1.accd,l_dat1,l_dat2)/100 into ODD_q, OKD_q from dual;
 if k.ref_new is not null then
 select fdos(r_dl2.accd,l_dat1,l_dat2)/100,
        fkos(r_dl2.accd,l_dat1,l_dat2)/100 into ODD_N, OKD_N from dual;
 select fost(r_dl2.accd,l_dat2)/100 into SD_N from dual;
 select fdosn(l_kv,r_dl2.accd,l_dat1,l_dat2)/100,
        fkosn(l_kv,r_dl2.accd,l_dat1,l_dat2)/100 into ODD_Nq, OKD_Nq from dual;
-- select fost(r_dl2.accd,l_dat2)/100 into SD_Nq from dual;
 else
 ODD_N:=0; OKD_N:=0; SD_N:=0;  ODD_Nq:=0; OKD_Nq:=0; SD_Nq:=0;

 end if;

if k.ref_new is not null then
select Nvl(sum(decode(o.dk,0,1,0)*o.s),0)/100, Nvl(sum(decode(o.dk,0,1,0)*o.sq),0)/100,
       Nvl(sum(decode(o.dk,0,0,1)*o.s),0)/100, Nvl(sum(decode(o.dk,0,0,1)*o.sq),0)/100
                into ODD_K_new, ODD_KQ_new, OKD_K_new, OKD_KQ_new
                from opldok o, oper p
                where p.ref = o.ref and o.sos=5
                 and p.vdat >= l_dat1 and o.tt in ('FXH','FXH')
                 and o.acc = r_dl2.accd;
else
ODD_K_new:=0; ODD_KQ_new:=0; OKD_K_new:=0; OKD_KQ_new:=0;
end if;

 ODD_:=ODD_-ODD_P; OKD_:=OKD_-OKD_P;  ODD_q:=ODD_q-ODD_Pq;  OKD_q:=OKD_q-OKD_Pq;

 begin
 insert into tmp_cp_rep
 (id,isin,kv,dat_p,    nls,nms,vid_r,pap,   ref,ost_v, ost_vq,
  S_D, S_C,   S_DK, S_CK,
  nls_p, ost_p, ost_pq,
  s_dp, s_cp,  nms_p,
  s_dp_new, s_cp_new, s_dk_new, s_ck_new,
  s_dpq_new, s_cpq_new, s_dkq_new, s_ckq_new,
  nls_p1, nls_s,
  S_Dq, S_Cq, S_DPq, S_CPq,  S_DKq, S_CKq,
  nbs_old, nbs_new,     -- pf_new,
  ref2,userid)
 values
 (k.id,k.cp_id,l_kv,l_dat2, k.NLSD,k.nms_d,'D',k.pap_d,k.ref,  SD_, SD_Q,
  ODD_, OKD_, ODD_K, OKD_K,
  l_nls_d2, SD_N, SD_NQ,
  ODD_P, OKD_P,
  l_nms_d2,
  odd_p_new, okd_p_new, odd_k_new, okd_k_new,
  odd_pq_new, okd_pq_new, odd_kq_new, okd_kq_new,
  l_nls_d2, r_dl2.accd,
  ODD_q, OKD_q, ODD_Pq, OKD_Pq, ODD_Kq, OKD_Kq,
  substr(l_nls_d2,1,4), substr(k.nlsd,1,4),       --k.pf_new,
  k.ref_new, l_userid);
 exception when others then NULL;
 LOG('CP_KLASS error D ID='||k.cp_id||' '||k.ref,'ERROR',0);
 end;

end if;


if r_dl1.accp is not null or r_dl2.accp is not null then

 select fost(r_dl1.accp,l_dat1)/100 into SP_ from dual;
-- select fostdn(l_kv,r_dl1.accp,l_dat1)/100 into SP_q from dual;
  --  потрібно по OPLDOK з аналізом TT
 select fdos(r_dl1.accp,l_dat1,l_dat2)/100,
        fkos(r_dl1.accp,l_dat1,l_dat2)/100 into ODP_, OKP_ from dual;
 select fdosn(l_kv,r_dl1.accp,l_dat1,l_dat2)/100,
        fkosn(l_kv,r_dl1.accp,l_dat1,l_dat2)/100 into ODP_q, OKP_q from dual;

 if k.ref_new is not null then
 select fdos(r_dl2.accp,l_dat1,l_dat2)/100,
        fkos(r_dl2.accp,l_dat1,l_dat2)/100 into ODP_N, OKP_N from dual;
 select fost(r_dl2.accp,l_dat2)/100 into SP_N from dual;
 select fdosn(l_kv,r_dl2.accp,l_dat1,l_dat2)/100,
        fkosn(l_kv,r_dl2.accp,l_dat1,l_dat2)/100 into ODP_Nq, OKP_Nq from dual;
-- select fostdn(l_kv,r_dl2.accp,l_dat2)/100 into SP_Nq from dual;
 else
 ODP_N:=0; OKP_N:=0; SP_N:=0;  ODP_Nq:=0; OKP_Nq:=0; SP_Nq:=0;
 end if;

 if k.ref_new is not null then
select Nvl(sum(decode(o.dk,0,1,0)*o.s),0)/100, Nvl(sum(decode(o.dk,0,1,0)*o.sq),0)/100,
       Nvl(sum(decode(o.dk,0,0,1)*o.s),0)/100, Nvl(sum(decode(o.dk,0,0,1)*o.sq),0)/100
                into ODP_K_new, ODP_KQ_new, OKP_K_new, OKP_KQ_new
                from opldok o, oper p
                where p.ref = o.ref and o.sos=5
                 and p.vdat >= l_dat1 and o.tt in ('FXH','FXH')
                 and o.acc = r_dl2.accp;
 else
 ODP_K_new:=0; ODP_KQ_new:=0; OKP_K_new:=0; OKP_KQ_new:=0;
 end if;

  ODP_:=ODP_-ODP_P;  OKP_:=OKP_-OKP_P;
  ODP_q:=ODP_q-ODP_Pq;  OKP_q:=OKP_q-OKP_Pq;

 begin
 insert into tmp_cp_rep
 (id,isin,kv,dat_p,    nls,nms,vid_r,pap,   ref,ost_v, ost_vq,
  S_D, S_C,   S_DK, S_CK,
  nls_p, OST_P, OST_PQ, s_dp, s_cp,   nms_p,
  s_dp_new, s_cp_new, s_dk_new, s_ck_new,
  s_dpq_new, s_cpq_new, s_dkq_new, s_ckq_new,
  nls_p1, nls_s,
  S_Dq, S_Cq, S_DPq, S_CPq,  S_DKq, S_CKq,
  nbs_old, nbs_new,      --pf_new,
  ref2,userid)
 values
 (k.id,k.cp_id,l_kv,l_dat2, k.NLSP,k.nms_p,'P',k.pap_p,k.ref, SP_, SP_Q,
  ODP_,OKP_, ODP_K, OKP_K,
  l_nls_p2, SP_N, SP_NQ, ODP_P, OKP_P, l_nms_p2,
  odp_p_new, okp_p_new, odp_k_new, okp_k_new,
  odp_pq_new, okp_pq_new, odp_kq_new, okp_kq_new,
  l_nls_p2, r_dl2.accp,
  ODP_q, OKP_q, ODP_Pq, OKP_Pq, ODP_Kq, OKP_Kq,
  substr(l_nls_p2,1,4), substr(k.nlsp,1,4),          --k.pf_new,
  k.ref_new,l_userid);
 exception when others then NULL;
 LOG('CP_KLASS error P ID='||k.cp_id||' '||k.ref,'ERROR',0);
 end;

end if;

if r_dl1.accr is not null then

 select fost(r_dl1.accr,l_dat1)/100 into SR_ from dual;
-- select fostdn(l_kv,r_dl1.accr,l_dat1)/100 into SR_q from dual;
  --  потрібно по OPLDOK з аналізом TT
 select fdos(r_dl1.accr,l_dat1,l_dat2)/100,
        fkos(r_dl1.accr,l_dat1,l_dat2)/100 into ODR_, OKR_ from dual;
 select fdosn(l_kv,r_dl1.accr,l_dat1,l_dat2)/100,
        fkosn(l_kv,r_dl1.accr,l_dat1,l_dat2)/100 into ODR_q, OKR_q from dual;

 if k.ref_new is not null then
 select fdos(r_dl2.accr,l_dat1,l_dat2)/100,
        fkos(r_dl2.accr,l_dat1,l_dat2)/100 into ODR_Nq, OKR_Nq from dual;
 select fost(r_dl2.accr,l_dat2)/100 into SR_N from dual;
 select fdosn(l_kv,r_dl2.accr,l_dat1,l_dat2)/100,
        fkosn(l_kv,r_dl2.accr,l_dat1,l_dat2)/100 into ODR_N, OKR_N from dual;
-- select fost(l_kv,r_dl2.accr,l_dat2)/100 into SR_Nq from dual;
 else
 ODR_N:=0; OKR_N:=0; SR_N:=0;   ODR_Nq:=0; OKR_Nq:=0; SR_Nq:=0;
 end if;

if k.ref_new is not null then
select Nvl(sum(decode(o.dk,0,1,0)*o.s),0)/100, Nvl(sum(decode(o.dk,0,1,0)*o.sq),0)/100,
       Nvl(sum(decode(o.dk,0,0,1)*o.s),0)/100, Nvl(sum(decode(o.dk,0,0,1)*o.sq),0)/100
                into ODR_K_new, ODR_KQ_new, OKR_K_new, OKR_KQ_new
                from opldok o, oper p
                where p.ref = o.ref and o.sos=5
                 and p.vdat >= l_dat1 and o.tt in ('FXH','FXH')
                 and o.acc = r_dl2.accr;

   --  нараховані  %-ти по NEW R в день переклас-ії
select Nvl(sum(decode(o.dk,0,1,0)*o.s),0)/100, Nvl(sum(decode(o.dk,0,1,0)*o.sq),0)/100
  --   Nvl(sum(decode(o.dk,0,0,1)*o.s),0)/100, Nvl(sum(decode(o.dk,0,0,1)*o.sq),0)/100
                into ODR_5, ODR_5Q   --, OKR_5, OKR_5Q
                from opldok o, oper p
                where p.ref = o.ref and o.sos=5
                 and p.vdat = l_dat2 and o.tt in ('FXU','FXU')
                 and o.acc = r_dl2.accr;
else
ODR_K_new:=0; ODR_KQ_new:=0; OKR_K_new:=0; OKR_KQ_new:=0;
ODR_5:=0; ODR_5Q:=0;
end if;

   ODR_:=ODR_-ODR_P;  OKR_:=OKR_-OKR_P;
   SR_N:= SR_N - (-ODR_5);

 begin
 insert into tmp_cp_rep
 (id,isin,kv,dat_p,    nls,nms,vid_r,pap,   ref,ost_v, ost_vq,
  S_D, S_C,   S_DK, S_CK,
  nls_p, OST_P, OST_PQ, s_dp, s_cp,   nms_p,
  s_dp_new, s_cp_new, s_dk_new, s_ck_new,
  s_dpq_new, s_cpq_new, s_dkq_new, s_ckq_new,
  nls_p1, nls_s,
  S_Dq, S_Cq, S_DPq, S_CPq,  S_DKq, S_CKq,
  nbs_old, nbs_new,      --pf_new,
  ref2,userid)
 values
 (k.id,k.cp_id,l_kv,l_dat2,  k.NLSR,k.nms_r,'R',k.pap_r,k.ref, SR_, SR_Q,
  ODR_, OKR_, ODR_K, OKR_K,
  l_nls_r2, SR_N, SR_NQ, ODR_P, OKR_P, l_nms_r2,
  odr_p_new, okr_p_new, odr_k_new, okr_k_new,
  odr_pq_new, okr_pq_new, odr_kq_new, okr_kq_new,
  l_nls_r2, r_dl2.accr,
  ODR_q, OKR_q, ODR_Pq, OKR_Pq, ODR_Kq, OKR_Kq,
  substr(l_nls_r2,1,4), substr(k.nlsr,1,4),          --k.pf_new,
  k.ref_new,l_userid);
 exception when others then NULL;
 LOG('CP_KLASS error R ID='||k.cp_id||' '||k.ref,'ERROR',0);
 end;

end if;

if r_dl1.accr2 is not null then

 select fost(r_dl1.accr2,l_dat1)/100 into SR2_ from dual;
-- select fostdn(l_kv,r_dl1.accr2,l_dat1)/100 into SR2_q from dual;
  --  потрібно по OPLDOK з аналізом TT
 select fdos(r_dl1.accr2,l_dat1,l_dat2)/100,
        fkos(r_dl1.accr2,l_dat1,l_dat2)/100 into ODR2_, OKR2_ from dual;
 select fdosn(l_kv,r_dl1.accr2,l_dat1,l_dat2)/100,
        fkosn(l_kv,r_dl1.accr2,l_dat1,l_dat2)/100 into ODR2_q, OKR2_q from dual;

 if k.ref_new is not null then
 select fdos(r_dl2.accr2,l_dat1,l_dat2)/100,
        fkos(r_dl2.accr2,l_dat1,l_dat2)/100 into ODR2_N, OKR2_N from dual;
 select fost(r_dl2.accr2,l_dat2)/100 into SR2_N from dual;
 select fdosn(l_kv,r_dl2.accr2,l_dat1,l_dat2)/100,
        fkosn(l_kv,r_dl2.accr2,l_dat1,l_dat2)/100 into ODR2_Nq, OKR2_Nq from dual;
-- select fost(r_dl2.accr2,l_dat2)/100 into SR2_Nq from dual;
 else
 ODR2_N:=0; OKR2_N:=0; SR2_N:=0; ODR2_Nq:=0; OKR2_Nq:=0; SR2_Nq:=0;
 end if;

if k.ref_new is not null then
select Nvl(sum(decode(o.dk,0,1,0)*o.s),0)/100, Nvl(sum(decode(o.dk,0,1,0)*o.sq),0)/100,
       Nvl(sum(decode(o.dk,0,0,1)*o.s),0)/100, Nvl(sum(decode(o.dk,0,0,1)*o.sq),0)/100
                into ODR2_K_new, ODR2_KQ_new, OKR2_K_new, OKR2_KQ_new
                from opldok o, oper p
                where p.ref = o.ref and o.sos=5
                 and p.vdat >= l_dat1 and o.tt in ('FXH','FXH')
                 and o.acc = r_dl2.accr2;

else
ODR2_K_new:=0; ODR2_KQ_new:=0; OKR2_K_new:=0; OKR2_KQ_new:=0;
end if;

  ODR2_:=ODR2_-ODR2_P;  OKR2_:=OKR2_-OKR2_P;

 begin
 insert into tmp_cp_rep
 (id,isin,kv,dat_p,    nls,nms,vid_r,pap,   ref,ost_v, ost_vq,
  S_D, S_C,   S_DK, S_CK,
  nls_p, OST_P, OST_PQ, s_dp, s_cp,  nms_p,
  s_dp_new, s_cp_new, s_dk_new, s_ck_new,
  s_dpq_new, s_cpq_new, s_dkq_new, s_ckq_new,
  nls_p1, nls_s,
  S_Dq, S_Cq, S_DPq, S_CPq,  S_DKq, S_CKq,
  nbs_old, nbs_new,      --pf_new,
  ref2,userid)
 values
 (k.id,k.cp_id,l_kv,l_dat2, k.NLSR2,k.nms_r2,'R2',k.pap_r2,k.ref, SR2_, SR2_Q,
  ODR2_, OKR2_, ODR2_K, OKR2_K,
 l_nls_r22, SR2_N, SR2_NQ, ODR2_P, OKR2_P, l_nms_r22,
 odr2_p_new, okr2_p_new, odr2_k_new, okr2_k_new,
 odr2_pq_new, okr2_pq_new, odr2_kq_new, okr2_kq_new,
 l_nls_r22, r_dl2.accr2,
 ODR2_q, OKR2_q, ODR2_Pq, OKR2_Pq, ODR2_Kq, OKR2_Kq,
 substr(l_nls_r22,1,4), substr(k.nlsr2,1,4),       --k.pf_new,
 k.ref_new,l_userid);
 exception when others then NULL;
 LOG('CP_KLASS error R2 ID='||k.cp_id||' '||k.ref,'ERROR',0);
 end;

end if;


if r_dl1.accs is not null or r_dl2.accs is not null then

 select fost(r_dl1.accs,l_dat1)/100 into SS_ from dual;
-- select fostdn(l_kv,r_dl1.accs,l_dat1)/100 into SS_q from dual;
  --  потрібно по OPLDOK з аналізом TT
 select fdos(r_dl1.accs,l_dat1,l_dat2)/100,
        fkos(r_dl1.accs,l_dat1,l_dat2)/100 into ODS_, OKS_ from dual;
 select fdosn(l_kv,r_dl1.accs,l_dat1,l_dat2)/100,
        fkosn(l_kv,r_dl1.accs,l_dat1,l_dat2)/100 into ODS_q, OKS_q from dual;
 if k.ref_new is not null then
 select fdosn(l_kv,r_dl2.accs,l_dat1,l_dat2)/100,
        fkosn(l_kv,r_dl2.accs,l_dat1,l_dat2)/100 into ODS_Nq, OKS_Nq from dual;
 select fost(r_dl2.accs,l_dat2)/100 into SS_N from dual;
 select fdos(r_dl2.accs,l_dat1,l_dat2)/100,
        fkos(r_dl2.accs,l_dat1,l_dat2)/100 into ODS_N, OKS_N from dual;
-- select fostdn(l_kv,r_dl2.accs,l_dat2)/100 into SS_Nq from dual;
 else
 ODS_N:=0; OKS_N:=0; SS_N:=0;   ODS_Nq:=0; OKS_Nq:=0; SS_Nq:=0;
 end if;

if k.ref_new is not null then
select Nvl(sum(decode(o.dk,0,1,0)*o.s),0)/100, Nvl(sum(decode(o.dk,0,1,0)*o.sq),0)/100,
       Nvl(sum(decode(o.dk,0,0,1)*o.s),0)/100, Nvl(sum(decode(o.dk,0,0,1)*o.sq),0)/100
                into ODS_K_new, ODS_KQ_new, OKS_K_new, OKS_KQ_new
                from opldok o, oper p
                where p.ref = o.ref and o.sos=5
                 and p.vdat >= l_dat1 and o.tt in ('FXH','FXH')
                 and o.acc = r_dl2.accs;
else
ODS_K_new:=0; ODS_KQ_new:=0; OKS_K_new:=0; OKS_KQ_new:=0;
end if;

  ODS_:=ODS_-ODS_P;  OKS_:=OKS_-OKS_P;
  ODS_q:=ODS_q-ODS_Pq;  OKS_q:=OKS_q-OKS_Pq;

 begin
 insert into tmp_cp_rep
 (id,isin,kv, dat_p,    nls,nms,vid_r,pap,   ref,ost_v, ost_vq,
  S_D, S_C,
  S_DK, S_CK,
  nls_p, OST_P, OST_PQ, s_dp, s_cp,  nms_p,
  s_dp_new, s_cp_new, s_dk_new, s_ck_new,
  s_dpq_new, s_cpq_new, s_dkq_new, s_ckq_new,
  nls_p1, nls_s,
  S_Dq, S_Cq, S_DPq, S_CPq,  S_DKq, S_CKq,
  nbs_old, nbs_new,              --pf_new,
  ref2,userid)
 values
 (k.id,k.cp_id,l_kv,l_dat2, k.NLSS,k.nms_s,'S',k.pap_s,k.ref, SS_, SS_Q,
  ODS_,OKS_,
  ODS_K, OKS_K,
  l_nls_s2, SS_N, SS_NQ, ODS_P, OKS_P, l_nms_s2,
  ods_p_new, oks_p_new, ods_k_new, oks_k_new,
  ods_pq_new, oks_pq_new, ods_kq_new, oks_kq_new,
  l_nls_s2, r_dl2.accs,
  ODS_q, OKS_q, ODS_Pq, OKS_Pq, ODS_Kq, OKS_Kq,
  substr(l_nls_s2,1,4), substr(k.nlss,1,4),              --k.pf_new,
  k.ref_new,l_userid);
 exception when others then NULL;
 LOG('CP_KLASS error S ID='||k.cp_id||' '||k.ref,'ERROR',0);
 end;

end if;
<<ZAP5>> NULL;
commit;
end loop;
--commit;
end;  -- cp_klass
-----------------------------------------

procedure rep2a (p_dat2 date, p_isin char default '%') is
  l_dok  cp_kod.dok%type;
  l_dnk  cp_kod.dnk%type;
  l_cena cp_kod.cena%type;
  l_kol int;

begin
delete from tmp_cp_rep where 1=1 and userid=l_userid and frm='2a';
commit;

for k in
(select ar.id,ar.dat_ug,ar.sumb,ar.n,ar.d,ar.p,ar.r,ar.s,ar.op,ar.ref_repo,
            d.ref, A.NLS,ar.acc,d.sos,d.nd,d.cp_id,
            k.name,k.cena,abs(ar.n/k.cena) kol,k.dok,k.dnk
from cp_arch ar, cp_v d, accounts a,cp_kod k
where ar.ref=d.ref(+) and d.acc=a.acc(+) and ar.id=k.id and ar.op in (1,2,3)
order by ar.dat_ug,ar.id,ar.ref)
loop


null;
end loop;
null;
end;

-----------------------------------------
procedure rep2b (p_dat2 date, p_isin char default '%') is
  l_dok  cp_kod.dok%type;
  l_dnk  cp_kod.dnk%type;
  l_cena cp_kod.cena%type;
  l_kol int;
  l_dat2 date;
  s_r number; s_r2 number;
-- v 22/09-12
begin
delete from tmp_cp_rep where 1=1 and userid=l_userid and frm='2b';
commit;

for k in
(select ar.id,ar.dat_ug,ar.sumb/100 SUMB,
            ar.n,ar.d,ar.p,ar.r/100 R,ar.s,ar.op,
            ar.ref_repo,
            d.ref, d.datp DAT_OP, d.ostr, d.ostr2,
            d.accr, d.accr2,
            A.NLS, a.pap, substr(a.nms,1,18) nms, ar.ref ref2,
            ar.acc,
            d.sos,d.nd,k.cp_id, k.kv,
            k.name,k.cena,abs(ar.n/k.cena) kol,k.dok,k.dnk,
            r.nls NLSR,   --r.ostc OSTC_R,
            r2.nls NLSR2, --r2.ostc OSTC_R2,
            k.datp DAT_POG
from cp_arch ar, cp_v d, accounts a, cp_kod k, accounts r, accounts r2
where ar.ref=d.ref(+) and d.acc=a.acc(+) and ar.id=k.id and ar.op in (1,2,3)
        and k.tip=1
        and d.accr=r.acc(+)  and d.accr2=r2.acc(+)
order by ar.dat_ug,ar.id,ar.ref)

loop
l_cena:=k.cena; l_kol:=k.kol; l_dat2:=p_dat2;
 s_r:=0; s_r2:=0;   l_dat2:=k.dat_op;

 begin
 select    max(dok) into l_dok
 from cp_dat where id=k.id and dok< l_dat2
 group by id;
 exception when others then NULL;
 end;

 begin
 select    min(dok) into l_dnk
 from cp_dat where id=k.id and dok>= l_dat2
 group by id;
 exception when others then NULL;
 end;

if k.accr is not null then
-- select fost(k.accr,l_dat2)/100 into S_r from dual;
NULL;
end if;
if k.accr2 is not null then
-- select fost(k.accr2,l_dat2)/100 into S_r2 from dual;
NULL;
end if;

 begin
 insert into tmp_cp_rep
 (id,isin,kv,dat_p, cena,  nls,nms, vid_r, pap,  ref, --ost_v, ost_vq,
  --S_D, S_C,   S_DK, S_CK,
  name, dok, dnk, kol    ,  nls_p1,
  s_dpog, ost_v, ost_p,
  ref2,userid,frm
  )
 values
 (k.id,k.cp_id,k.kv,k.dat_ug, l_cena, k.nls,k.nms,'N',k.pap,k.ref, -- SN_, SN_Q,
  --ODN_, OKN_, ODN_K, OKN_K,
  k.name, l_dok, l_dnk, l_kol    , decode(k.op,1,'купівля',2,'продаж','?'),
--  s_r+s_r2,
  k.R,
  decode(k.op,1,k.sumb,null), decode(k.op,2,k.sumb,null),
  decode(k.op,2,k.ref2,null),
  l_userid,'2b'
  );
 exception when others then NULL;
 LOG('CP_REP2 error N ID='||k.cp_id||' '||k.ref,'ERROR',0);
 end;


null;
end loop;
null;
end;

---------------------------------------

procedure LOG(p_info char, p_lev char default 'TRACE', p_reg int default 0) is
begin
--MON_U.to_log(p_reg,p_lev,l_mdl,l_trace||p_info);
logger.info(l_mdl||' '||l_trace||' '||p_info);
NULL;
end log;

BEGIN /* анонімний блок */
NULL;
l_userid:=user_id;
l_trace:='cp_rep '; l_mdl:='CP';
END CP_REP;
/
 show err;
 
PROMPT *** Create  grants  CP_REP ***
grant EXECUTE                                                                on CP_REP          to BARS_ACCESS_DEFROLE;
grant EXECUTE                                                                on CP_REP          to START1;

 
 
 PROMPT ===================================================================================== 
 PROMPT *** End *** ========== Scripts /Sql/BARS/package/cp_rep.sql =========*** End *** ====
 PROMPT ===================================================================================== 
 