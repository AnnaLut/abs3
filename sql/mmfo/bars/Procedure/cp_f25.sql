

PROMPT ===================================================================================== 
PROMPT *** Run *** ========== Scripts /Sql/BARS/Procedure/CP_F25.sql =========*** Run *** ==
PROMPT ===================================================================================== 


PROMPT *** Create  procedure CP_F25 ***

  CREATE OR REPLACE PROCEDURE BARS.CP_F25 (p_dat1 date default NULL, p_dat2 date default NULL, p_isin varchar2 default '%') is
-- ***** v.1.18a 22/05-15   14/02-14   *****
l_userid number;
l_sumb number; l_ref int; l_nd varchar2(10);
l_nar number; l_narf number; l_spog number; l_Npog number;
l_narq number; l_narfq number; l_spogq number; l_Npogq number;
l_nom number; l_kup number;  l_kupf number;
l_nomq number; l_kupq number;  l_kupfq number;
l_npp int;  l_npp_max int;
l_days int;  l_nom_d number; l_nom_fin number;
l_sumR number; l_sumR2 number;
l_DOK cp_dat.dok%type; l_DNK cp_dat.dok%type;
l_DOKf cp_dat.dok%type;
l_datr date; l_dat1 date; l_dat2 date;  l_dr date; l_dat_max date;
l_datd date;
l_ISIN varchar2(20); l_country cp_kod.country%type; l_kv int;

l_Ssumn number; l_Snar number; l_Snarf number; l_Spogn number; l_Snom number;
l_Snarq number; l_Snarfq number; l_Spognq number; l_Snomq number;
l_SsumR number; l_Skol int;  l_kol int;
l_id int; l_fl int; l_err varchar2(100);
l_cp_id cp_kod.cp_id%type;
l_dat_em cp_kod.dat_em%type; l_datp cp_kod.datp%type;
l_cena  cp_kod.cena%type;  l_cena_st  cp_kod.cena_start%type;
l_cena_t  cp_kod.cena%type;
l_ir  cp_kod.ir%type;   l_cena_kup  cp_kod.cena_kup%type;
l_emi  cp_kod.emi%type; l_period_kup  cp_kod.period_kup%type;
l_pf int; l_pfname varchar2(70);
l_ryn int; l_rynname varchar2(35);
l_rnk int; l_eminame varchar2(70);
l_trace  varchar2(100):= '';  l_mdl varchar2(5);

 ern CONSTANT POSITIVE   := 208; err EXCEPTION; erm VARCHAR2(80);
 err_num number;  err_msg varchar2(80);

procedure LOG(p_info char, p_lev char default 'TRACE', p_reg int default 0) is
begin
MON_U.to_log(p_reg,p_lev,l_mdl,l_trace||p_info);
end;

begin
l_trace:='ЦП F25 '; l_mdl:='CP';
l_userid:=user_id;  l_err:=NULL;

l_dat1:=p_dat1;
if p_dat1 is NULL then l_dat1:=bankdate; end if;
l_dat2:=p_dat2;
if p_dat2 is NULL then l_dat2:=bankdate; end if;
if p_dat2 < p_dat1 then l_dat2:=l_dat1; end if;
l_isin:=trim(p_isin);
if trim(p_isin) = '0' then l_isin:='%'; end if;
LOG('F25 STARTED-***','INFO');
LOG('start dat1='||l_dat1||' dat2='||l_dat2||' ISIN '||p_isin,'INFO',0);
if trim(p_ISIN) = '0' then goto EX2; end if;
delete from tmp_cp_ua  where 1=1  /*and id_u=l_userid*/ and frm='25';

for p in (select distinct v.id from cp_v v
          where sos=5
                and v.tip=1         --   and v.kv=980  -- !?
                and v.OSTAF !=0
                and v.mdate >= l_dat1 and v.cp_id like l_isin
                --and v.dat_em <= l_dat1
                and v.id> 0
          order by id)
loop

l_Ssumn:=0; l_Ssumr:=0; l_Skol:=0; l_Snar:=0;
l_Snarq:=0;
l_Snarf:=0; l_Spogn:=0; l_Snom:=0; l_kup:=0;
l_Snarfq:=0; l_Spognq:=0; l_Snomq:=0; l_kupq:=0;
l_datr:=NULL;
l_err:='';

begin
select k.id, k.cp_id, trunc(k.dat_em) DAT_EM, trunc(k.datp) DATP,
       k.cena, k.ir, k.emi, k.rnk, k.name, k.cena_start,
       k.period_kup, nvl(cena_kup0,0), dok, dnk, country, kv
into   l_id, l_cp_id, l_dat_em, l_datp, l_cena, l_ir, l_emi, l_rnk,
       l_eminame, l_cena_st,
       l_period_kup, l_cena_kup, l_dok, l_dnk, l_country, l_kv
from cp_kod k where id=p.id;
if l_country != 804 then goto EX1; end if;
if l_datp < l_dat1 then goto EX1; end if;
LOG(l_cp_id||'/'||l_kv||' dat_em='||l_dat_em||' datp='||l_datp);
l_days:= l_datp - l_dat_em +1;
l_cena_t:=l_cena;
------ if nvl(l_ir,0) = 0 then goto EX1; end if;
EXCEPTION WHEN NO_DATA_FOUND THEN
       raise_application_error(-(20203),
       'PR_F25: ЦП № '||l_ID||'. НЕ знайдено !?', TRUE);
 RETURN ;
end;
                  -- а дисконтні ?    а якщо купон через ставку ?
begin
l_fl:=0;
select 1 into l_fl from dual
where exists (select 1 from cp_dat where id = p.id);
select max(npp),max(dok) into l_npp_max,l_dat_max from cp_dat where id=p.id;
select nvl(nom,l_cena) into l_nom_fin from cp_dat where id=p.id and npp=l_npp_max;
exception when NO_DATA_FOUND then
l_err:=substr(trim(l_cp_id)||' Не внесено графік купонів/погашення',1,50);
LOG(l_cp_id||' Не внесено графік купонів/погашення','ERROR');
goto EX1;
end;

 for pf in (select distinct v.vidd, v.id, v.ryn, v.pf
           from cp_v v
          where  l_datp >= l_dat1
             and v.sos=5
             and v.OSTAF !=0
             and v.id = p.id)
 loop

l_err:='';  l_pf:=pf.pf;
for l in (select sumb,v.acc,v.accr,v.accr2,v.osta,v.ostr,v.ostr2, v.ostaf,
          v.ref, v.mdate, v.vidd,v.ryn, v.pfname, v.datp DATP_O, v.dapp,
          v.datd, v.nd
          from cp_v v
          where  l_datp >= l_dat1
            and v.sos=5
            and v.OSTAF !=0       -- and v.ref=.....
            and v.id = pf.id and v.vidd=pf.vidd and v.ryn=pf.ryn
                 order by v.ref)
loop
--LOG(l_cp_id||' ref='||l.ref||' ryn='||l.ryn,'TRACE');

l_pfname:=l.pfname;   l_spog:=0;   l_Npog:=0;
l_kol:= -l.ostaf/l_cena;   -- ! врахувати часткове погашення ном-лу з CP_DAT
l_ryn:=l.ryn;     l_dok:=l.DATP_O;  l_ref:=l.ref; l_datd:=l.datd; l_nd:=l.nd;
begin
select name into l_rynname from cp_ryn where ryn=l_ryn;
exception when no_data_found then  l_rynname:='?';
end;

l_kupf:=l_cena_kup; l_kupf:=0;
l_dokf:=l_dat_em;
--LOG(l_cp_id||'/'||l_kv||' ref='||l.ref||' dat_k='||l_datd||' ryn='||l.ryn||' '||-l.ostaf||' '||l_kol,'INFO');
LOG(l_cp_id||'/'||l_kv||' ref='||l.ref||' dat_k='||l_datd||' ryn='||l.ryn||' '||l_kol||' шт.','INFO');

for x in (select d.id,d.npp,d.dok,d.kup,nvl(d.nom,0) NOM
          from cp_dat d  where d.id=pf.id
                   --  d.dok>=l_dok    -- and d.dok<l_dat2
                     and npp>0
               order by npp)
loop

l_dr:=x.dok; l_npp:=x.npp;  l_kup:=null;
if x.kup is not null then l_kup:=x.kup; end if;

if x.dok>=l_DAT1 and x.dok<=l_DAT2 then

  if l_cena != l_cena_st then
  select  l_cena_st - sum(nvl(a.nom,0))  into l_cena_t
  from cp_dat a  where a.id=x.ID and a.DOK < x.dok;
  end if;

LOG('cp_id='||l_cp_id||' ref='||l.ref||' x.DOK='||x.dok
                  ||' dokf='||l_dokf||' '||x.npp||' в періоді'||' kup='||l_kup,'TRACE');
if l.ref=605696201 then
LOG('cp_id='||l_cp_id||' ref='||l.ref||' x.DOK='||x.dok
                  ||' dokf='||l_dokf||' '||x.npp||' в періоді'||' kup='||l_kup,'INFO');
end if;
l_dok:=l_dokf;
l_dokf:=x.dok;   l_dnk:=x.dok;
NULL;
goto VKL;
end if;

if x.dok>l_DAT2 then    --and l_DAT1!=l_DAT2 then
   l_dok:=l_dokf;
--LOG(' cp_id='||l_cp_id||' ref='||l.ref||' x.DOK='||x.dok
--                  ||' dokf='||l_dok||' '||x.npp||' майбутній період','TRACE');
if l.ref=605696201 then
LOG('cp_id='||l_cp_id||' ref='||l.ref||' x.DOK='||x.dok
                  ||' dokf='||l_dok||' '||x.npp||' майбутній період','INFO');
end if;
l_dokf:=x.dok;
goto EX_X; end if;

if l.DATP_O < x.dok and x.npp=1 then
l_dnk:=x.dok; l_dokf:=l_dat_em; l_dok:=l_dat_em;
if x.kup is not null then l_kup:=x.kup; end if;
l_kupf:=l_kup;
LOG('ISIN='||l_cp_id||' ref='||l.ref||' x.DOK='||x.dok
                  ||' l_dok='||l_dok||' '||x.npp||' 1-й період','INFO');

elsif l.DATP_O < x.dok and x.npp>1 then
l_dnk:=x.dok; l_dok:=l_dokf;
if x.kup is not null then l_kup:=x.kup; end if;
l_kupf:=l_kup;
if l.ref=605696201 then
LOG('ISIN='||l_cp_id||' ref='||l.ref||' x+DOK='||x.dok
                  ||' dokf='||l_dok||' '||x.npp||' вже куплений','INFO');
end if;
l_dokf:=x.dok;

elsif l.DATP_O > x.dok and x.npp=1 then
l_kupf:=l_cena_kup;  l_dokf:=l_dat_em;
if x.kup is not null then l_kup:=x.kup; end if;
l_dnk:=x.dok;
--LOG('ISIN='||l_cp_id||' ref='||l.ref||' x1DOK='||x.dok
--                  ||' dokf='||l_dok||' '||x.npp,'TRACE');
if l.ref=605696201 then
LOG('cp_id='||l_cp_id||' ref='||l.ref||' x1DOK='||x.dok
                  ||' dokf='||l_dok||' '||x.npp,'INFO');
end if;
l_dokf:=x.dok;
goto EX_X;

elsif l.DATP_O >= x.dok then
if x.kup is not null then l_kup:=x.kup; end if;
l_dnk:=x.dok;    l_dok:=l_dokf;
l_kupf:=l_kup;  --l_dnk:='01-jan-2055';
--LOG('ISIN='||l_cp_id||' ref='||l.ref||' x!DOK='||x.dok
--                  ||' dokf='||l_dok||' '||x.npp,'TRACE');
if l.ref=605696201 then
LOG('cp_id='||l_cp_id||' ref='||l.ref||' x!DOK='||x.dok
                  ||' dokf='||l_dok||' '||x.npp,'INFO');
end if;
l_dokf:=x.dok;
goto EX_X;
end if;

------

l_datr:=x.dok;

if l_datr<l_DAT1 then
--LOG('ISIN='||l_cp_id||' ref='||l.ref||' x<DOK='||x.dok
--                  ||' dokf='||l_dok||' '||x.npp|| ' НЕ вкл. в період','TRACE');
if l.ref=605696201 then
LOG('cp_id='||l_cp_id||' ref='||l.ref||' x<DOK='||x.dok
                  ||' dokf='||l_dok||' '||x.npp||' НЕ вкл. в період','INFO');
end if;
l_dokf:=x.dok;
goto EX_X;
elsif l_datr>l_DAT2 then
--LOG('ISIN='||l_cp_id||' ref='||l.ref||' x>DOK='||x.dok
--                  ||' dokf='||l_dok||' '||x.npp||' майбутній період','TRACE');
if l.ref=605696201 then
LOG('cp_id='||l_cp_id||' ref='||l.ref||' x>DOK='||x.dok
                  ||' dokf='||l_dok||' '||x.npp||' майбутній період','INFO');
end if;
l_dokf:=x.dok;
goto EX_X;
else NULL; l_dokf:=x.dok;
end if;

-------
<<VKL>> NULL;
l_datr:=x.dok;
l_period_kup:=l_dnk - l_dok;

begin
l_sumR:=0;
if l_dokf=l_dat_em then
l_dr:=l_dnk-1;
else
l_dr:=l_dokf-1;
end if;
l_nom:=-fost(l.acc,l_dr)/100;
l_kol:= l_nom/l_cena_t;     --  ****
l_sumR2:=0;
if l.accr2 is not null and l_dr<=bankdate then
l_sumR2:=-fost(l.accr2,l_dr)/100;
end if;

l_spog:=nvl(l_kup,0)*l_kol;      -- plan

if x.dok>=l.DATP_O and l_dr<=bankdate then
l_sumR:=-fost(l.accr,l_dr)/100;
l_sumR:=l_sumR+fdos(l.accr,l_dr+1,l_dr+1)/100;
l_spog:=l_sumR+l_sumR2;      -- fact
elsif x.dok>bankdate then
NULL;
else
NULL;
--l_sumR:=-fost(l.accr,l_dokf-1)/100;
end if;

if x.dok=l_DATP  and 1=2  then
   l_Npog:=l_nom;          --  ?
else
   l_Npog:= x.nom * l_kol;
end if;

l_spogq:=p_icurval(l_kv,l_spog*100,l_datr)/100;

exception when OTHERS then  NULL;
LOG(l_cp_id||' kol='||l_kol||' dnk='||l_dnk,'INFO');
raise;
end;

<<ZAP>> NULL;
begin
insert into tmp_CP_ua
(id,cp_id,dat_em,datp,ir,kv,cena,nom,kol,s_nar, s_narq,
 s_spl,
 k_spl,
 dok, dnk, cena_kup, dat_r, vidd, bal,
 period_kup,emi,rnk,dn,err, pf, pfname, ryn, ryn_name, ref, dat_k, nd,
 id_u,frm,ord_z)
values
(p.id,l_cp_id,l_dat_em,l_datp,l_ir,l_kv,l_cena_t,l_nom,l_kol,nvl(l_spog,0),nvl(l_spogq,0),
 nvl(l_Npog,0),
 nvl(l_Npog,0)+nvl(l_Spog,0),
 l_DOK, l_dnk, l_kup, l_datr, l.vidd, l.vidd,
 l_period_kup,l_emi,NULL,l_days,l_err, l_pf, l_pfname, l_ryn, l_rynname,
 l_ref, l_datd, l_nd,
 l_userid,'25',l_npp);

exception when others then  NULL;
LOG(l_cp_id||' ? помилка INSERT'||' ref='||l.ref,'ERROR');
end;

<<EX_X>> NULL;
end loop;    -- x
end loop;    -- l
end loop;  -- pf
<<EX1>> NULL;
end loop;     -- p
<<EX2>> NULL;
LOG(' ended','INFO');
commit;
end;
/
show err;

PROMPT *** Create  grants  CP_F25 ***
grant EXECUTE                                                                on CP_F25          to BARS_ACCESS_DEFROLE;
grant EXECUTE                                                                on CP_F25          to CP_ROLE;
grant EXECUTE                                                                on CP_F25          to START1;



PROMPT ===================================================================================== 
PROMPT *** End *** ========== Scripts /Sql/BARS/Procedure/CP_F25.sql =========*** End *** ==
PROMPT ===================================================================================== 
