

PROMPT ===================================================================================== 
PROMPT *** Run *** ========== Scripts /Sql/BARS/Procedure/CP_OBU7.sql =========*** Run *** =
PROMPT ===================================================================================== 


PROMPT *** Create  procedure CP_OBU7 ***

  CREATE OR REPLACE PROCEDURE BARS.CP_OBU7 
 ( p_ID  int , -- какую ЦБ   ( или все =0)
   p_dat2 date,   -- дата
   p_reg int default 0
   )  is

-- *** v.1.08  6/03-13         ***

  NLSV_  accounts.nls%type ;
  acc_   accounts.acc%type ;
  NLS_   accounts.nls%type ;
  NMS_   accounts.nms%type ;
  accc_  accounts.accc%type;
  r1_    int;
  ref_   oper.ref%type     ;  l_ref_pr oper.ref%type;  l_ref_mv oper.ref%type;
  l_ref2 oper.ref%type     ;  l_ref3 oper.ref%type     ;
  l_ref_g int;       l_ref5 int;
  tt_    oper.tt%type      := 'FXB';
  dk_    oper.dk%type      ;
  s_     oper.s%type       ;  s_pr opldok.s%type;  s_pr_op number;
  s_63 number;                s_kupl_op number;
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

  -- залишки
  SN_ number;
  SD_ number; SP_ number; SS_ number; SR_ number; SR2_ number;  SZ_ number;
  SDV_ number; SPV_ number;
  SN_Q number;
  SD_Q number; SP_Q number; SS_Q number; SR_Q number; SR2_Q number; SZ_Q number;
  SDV_Q number; SPV_Q number;
  SN_N number;
  SD_N number; SP_N number; SS_N number; SR_N number; SR2_N number;
  SDV_N number; SPV_N number;
  SN_NQ number;
  SD_NQ number; SP_NQ number; SS_NQ number; SR_NQ number; SR2_NQ number;
  SDV_NQ number; SPV_NQ number ;

  SN_31 number;
  SD_31 number; SP_31 number; SS_31 number; SR_31 number; SR2_31 number;
  SDV_31 number; SPV_31 number;  SZ_31 number;
  SN_31Q number;
  SD_31Q number; SP_31Q number; SS_31Q number; SR_31Q number; SR2_31Q number;
  SDV_31Q number; SPV_31Q number;

  sumb_pr number;

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
  ODDV_K number;  ODPV_K number; OKDV_K number;  OKPV_K number;
  ODDV_KQ number;  ODPV_KQ number; OKDV_KQ number;  OKPV_KQ number;
  ODDV_p number;  ODPV_p number;  OKDV_p number;  OKPV_p number;
  ODDV_pq number;  ODPV_pq number;  OKDV_pq number;  OKPV_pq number;

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

  s_odn_new number; s_okn_new number;
  s_odd_new number; s_okd_new number;
  s_odp_new number; s_okp_new number;
  s_odr_new number; s_okr_new number;
  s_odr2_new number; s_okr2_new number;
  s_ods_new number; s_oks_new number;

  s_odn_q_new number; s_okn_q_new number;
  s_odd_q_new number; s_okd_q_new number;
  s_odp_q_new number; s_okp_q_new number;
  s_odr_q_new number; s_okr_q_new number;
  s_odr2_q_new number; s_okr2_q_new number;
  s_ods_q_new number; s_oks_q_new number;



  --------------------------
  l_accb accounts.acc%Type ;
  l_IO   proc_dr.io%type   ;
----------------------------
  f_SS int  ;  -- флаг сворачивания SS
--------------
 l_dat1 date; l_dat2 date;  l_vdat date;   l_dat3 date;
 l_dat_k date; l_dat_pr date; t_dat date;  l_dat31 date; l_dat_mv date;
 l_dat_ir date; l_dat_k2 date;  l_dat1131 date;  l_dat_g date;
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
 l_userid int;

 t_ost_n number; t_ost_d number; t_ost_p number;
 t_ost_r number; t_ost_r2 number; t_ost_s number; t_ost_z number;
 BV_1 number; BV_31 number;  t_bv number;
 kol_n int; kol_t int;
 sn_pr number; op_pr number;
 cena0 number; cena1 number; cena2 number; cena4 number; cena31 number;

 cena_k2 number; cena_p2 number;
 cena_bay number; cena_pr number;  cena_bay_n number;
 kl1 number; kl_k number; kl_k2 number; kl_p2 number;
 kl31 number; kl4 number;
 N_bay number;  D_bay number; P_bay number; R_bay number; S_bay number;
 l_fl int;  l_fl_k int;  l_fl_p int; vob2 int;
 DF_ number;  tr_31 number;  n2_k number;  n2_p number; n3_p number;
 nm_kup varchar2(30); nm_kup4 varchar2(30);
 nm_pr varchar2(30);  nm_pr2 varchar2(30);
 --n_p2 number;
 l_tiket varchar2(20000);    ---blob;  --long raw;  --varchar2(4000);
 nls_3739 varchar2(15); acc_3739 int;
 nls_3739_840 varchar2(15); acc_3739_840 int;

Function s_opl(p_ref int, p_acc int) return number is
l_s number;
begin
select sum(s) into l_s from opldok
where ref=p_ref and acc=p_acc and rownum=1;
return nvl(l_s,0);
end s_opl;

function get_kontragent(P_ref int, P_ISK varchar2 default 'Контрагенту',
                 p_vx int default 1)
return varchar is
l_ref int;
ttt1 varchar2(4000);  pos int;
l_isk varchar2(11);
l_MFO varchar2(12);
l_name  varchar2(30);
begin
l_ref:=P_ref;
l_isk:=P_isk;
select get_stiket(l_ref) into ttt1 from dual;
if ttt1 is null then return '***?'; end if;
select INSTR(ttt1,l_isk,1,p_vx) into pos from dual;
if pos!=0 then
--l_mfo:=substr(ttt1,pos+85,12);
l_name:=substr(ttt1,pos+11,30);
else
-- logger.error( 'cp_rep.get_MFO '||'ключ P_ISK НЕ знайдено');
--l_mfo:='??';
l_name:='??';
end if;
return l_name;   --l_mfo;
end;

procedure LOG(p_info char, p_lev char default 'TRACE', p_reg int default 0) is
begin
MON_U.to_log(p_reg,p_lev,l_mdl,l_trace||p_info);
end;


begin
if p_reg=0 then goto EX2; end if;   -- без формування
t_dat := bankdate;
l_dat1131:=to_date('31/12/2011','dd/mm/yyyy');
l_dat1:=to_date('01/01/2012','dd/mm/yyyy');
--l_dat2:=p_dat2;
l_dat2:=to_date('30/12/2012','dd/mm/yyyy');
l_dat31:=to_date('30/12/2012','dd/mm/yyyy');
l_userid := user_id;
LOG('CP_OBU дата '||p_dat2||' p_id='||p_id,'INFO',0);
begin
select acc,nls into acc_3739, nls_3739
from accounts where nls='37392555' and kv=980;
exception when NO_DATA_FOUND then acc_3739:=-100; nls_3739:='37392555';
end;
begin
select acc,nls into acc_3739_840, nls_3739_840
from accounts where nls='37392555' and kv=840;
exception when NO_DATA_FOUND then acc_3739_840:=-100; nls_3739_840:='37392555';
end;

delete from tmp_cp_obu7 where 1=1 and userid=l_userid;   --id=p_id;
commit;
for k in (select e.ID, e.RYN,
                 e.ACC, e.REF, -a.ostc/100 SA, o.nd, o.vdat dat_k,
                 ar.sumb/100 SUMB,  ar.ref_repo,  ar.n/100 SUMN, ar.stiket,
                 substr(a.nls,1,4) nbs1,    o.s/100 s_kupl,
                 a.kv, a.pap, a.rnk, a.grp, a.isp, a.mdate,
                 a.nls,  substr(a.nms,1,38) nms, g.nls NLSG,
                 e.accD, e.accP,e.accR,e.accR2,e.AccS,
                 substr(d.nms,1,38) nms_d, substr(p.nms,1,38) nms_p,
                 substr(r.nms,1,38) nms_r, substr(r2.nms,1,38) nms_r2,
                 substr(s.nms,1,38) nms_s,
                 a.pap pap_n, d.pap pap_d, p.pap pap_p, s.pap pap_s,
                 r.pap pap_r, r2.pap pap_r2,
                 k.cp_id, k.emi, k.DATP DAT_PG,
                 k.ir, k.cena, nvl(k.cena_start,k.cena) cena_start,
                 -d.ostc/100  SD , d.nls NLSD,
                 -p.ostc/100  SP , p.nls NLSP,
                 -nvl(r.ostc,0)/100  SR , r.nls NLSR,
                 -nvl(r2.ostc,0)/100 SR2, r2.nls NLSR2,
                 -s.ostc/100  SS , s.nls NLSS ,
                 e.ref_new      --,e.pf_new,        --e.ryn_new,
          from cp_deal e, cp_kod k, accounts g, oper o, cp_arch ar,
               accounts a,accounts d,accounts p,accounts r,accounts r2,
               accounts s
          where e.acc   = a.acc    --   and (a.ostc <> 0 or a.ostb !=0)    ---
            and a.accc  = g.acc and e.id = k.id
            and o.ref = e.ref and e.ref = ar.ref
            and e.accd  = d.acc  (+)
            and e.accp  = p.acc  (+)
            and e.accr  = r.acc  (+)
            and e.accr2 = r2.acc (+)
            and e.accs  = s.acc  (+)
            and e.id    = decode (nvl(p_id ,0), 0, e.id , p_id  )
            and k.tip=1 and k.country=804  --and k.kv=980
            and k.datp > l_dat1
            and o.sos = 5   and k.emi not in (0,6)
order by 4       --1,3,4
             )
loop

    cena1:=k.cena_start; cena31:=k.cena_start; cena4:=k.cena_start;
    cena_bay_n:=k.cena_start; cena_p2:=null;  --  cena_p2:=k.cena_start;
    vob2:=null;
    cena_k2:=null;   kl1:=null;   sumb_pr:=0; s_pr_op:=0; s_kupl_op:=0;
    s_63:=0; tr_31:=0;
    n2_k:=0; n2_p:=0;  n3_p:=null;
    nm_kup:=null; nm_pr:=null;  nm_kup4:=null; nm_pr2:=null;
    l_tiket:=null;  l_tiket:=k.stiket;

    begin
      l_fl :=0 ;
      select 1 into l_fl from dual
      where exists (select 1 from cp_dat where id = k.ID);

  if k.cena != k.cena_start then

  select k.cena_start - sum(nvl(a.nom,0))  into cena1
  from cp_dat a  where a.id=k.ID and a.DOK <= l_dat1;

  select k.cena_start - sum(nvl(a.nom,0))  into cena_bay_n
  from cp_dat a  where a.id=k.ID and a.DOK <= k.dat_k;

  select k.cena_start - sum(nvl(a.nom,0))  into cena31
  from cp_dat a  where a.id=k.ID and a.DOK <= l_dat31;

  select k.cena_start - sum(nvl(a.nom,0))  into cena4
  from cp_dat a  where a.id=k.ID and a.DOK <= bankdate;

  end if;

    exception when NO_DATA_FOUND then  l_fl:=0;    --null;
    cena1:=k.cena_start; cena31:=k.cena_start; cena4:=k.cena_start;
    cena_bay_n:=k.cena_start;
    end;
              --   cena1:=nvl(k.cena,500);  --! otl
 if nvl(cena1,0)=0 then cena1:=k.cena_start; end if;     --- ?

 l_dat_k := null; l_dat_k2 := null;

 if k.dat_k >= l_dat1 then l_dat_k2:=k.dat_k; end if;
 if k.dat_k < l_dat1 then l_dat_k:=k.dat_k; end if;

N_bay:=0; D_bay:=0; P_bay:=0; R_bay:=0; S_bay:=0;
cena0:=k.cena_start;
cena_bay:=k.cena_start;
cena_pr:=null; n2_p:=null;
kl_p2:=null;
t_ost_n := k.SA; t_ost_d := k.SD; t_ost_p := k.SP;
t_ost_r := k.SR; t_ost_r2 := k.SR2; t_ost_s := k.SS; t_ost_z := 0;
SN_31:=0; SN_31Q:=0;  SD_31:=0; SD_31Q:=0;
BV_1:=0; BV_31:=0; t_bv:=0;
t_bv:=t_ost_n+t_ost_d+t_ost_p+t_ost_r+t_ost_r2+t_ost_s+t_ost_z;

l_kv:=k.kv;
s_pr := 0;  l_ref_mv := k.ref_new;  s_pr_op:=0;
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
SN_NQ:=0; SD_NQ:=0; SP_NQ:=0; SS_NQ:=0; SR_NQ:=0; SR2_NQ:=0; SDV_NQ:=0; SPV_NQ:=0;
ODN_N:=0; ODD_N:=0; ODP_N:=0; ODS_N:=0; ODR_N:=0; ODR2_N:=0;
accd_v:=null; accp_v:=null; accd_vn:=null; accp_vn:=null;
vd_d:=0; vp_d:=0; vd_k:=0; vp_k:=0;
vd_dn:=0; vp_dn:=0; vd_kn:=0; vp_kn:=0;
oddv_p:=0; odpv_p:=0; okdv_p:=0; okpv_p:=0;
oddv_pq:=0; odpv_pq:=0; okdv_pq:=0; okpv_pq:=0;
oddv_p_new:=0; odpv_p_new:=0; okdv_p_new:=0; okpv_p_new:=0;
oddv_pq_new:=0; odpv_pq_new:=0; okdv_pq_new:=0; okpv_pq_new:=0;


   s_odn_new:=0; s_okn_new:=0;  s_odd_new:=0; s_okd_new:=0;   s_odp_new:=0; s_okp_new:=0;
   s_odr_new:=0; s_okr_new:=0;  s_odr2_new:=0; s_okr2_new:=0; s_ods_new:=0; s_oks_new:=0;
   s_odn_q_new:=0; s_okn_q_new:=0;  s_odd_q_new:=0; s_okd_q_new:=0;   s_odp_q_new:=0; s_okp_q_new:=0;
   s_odr_q_new:=0; s_okr_q_new:=0;  s_odr2_q_new:=0; s_okr2_q_new:=0; s_ods_q_new:=0; s_oks_q_new:=0;

 kol_n:=0; kol_t:=0;
 l_dat_pr:=null; l_dat_mv:=null;

LOG('CP_OBU ID='||k.id||' '||k.cp_id||' '||k.ref,'INFO',0);

select s/100 into s_kupl_op
from oper where ref=k.ref;

select Nvl(sum(decode(o.dk,0,1,0)*o.s),0)/100  --, Nvl(sum(decode(o.dk,0,1,0)*o.sq),0)/100,
                into N_bay
                from opldok o
                where o.ref = k.ref and acc = k.acc;

select Nvl(sum(decode(o.dk,0,1,0)*o.s),0)/100  --, Nvl(sum(decode(o.dk,0,1,0)*o.sq),0)/100,
                into D_bay
                from opldok o
                where o.ref = k.ref and acc = k.accd;

select Nvl(sum(decode(o.dk,0,1,0)*o.s),0)/100  --, Nvl(sum(decode(o.dk,0,1,0)*o.sq),0)/100,
                into P_bay
                from opldok o
                where o.ref = k.ref and acc = k.accp;

select Nvl(sum(decode(o.dk,0,1,0)*o.s),0)/100  --, Nvl(sum(decode(o.dk,0,1,0)*o.sq),0)/100,
                into R_bay
                from opldok o
                where o.ref = k.ref and acc = nvl(k.accr2,k.accr);   --

 if l_dat_k2 is not null then
 kl_k2:=round(n_bay/cena_bay_n,2);   n2_k:=n_bay;
 --if nvl(kl_k2,0)=0 then kl_k2:=1; end if;   ---
 cena_bay:=round(nvl(k.sumb,s_kupl_op)/kl_k2,2);  kl_k:=null;
 cena_k2:=cena_bay;
 cena0:=null;
 if l_tiket is not null then nm_pr2:=trim(get_kontragent(k.ref)); end if;
 elsif l_dat_k is not null then
 kl_k:=round(n_bay/cena_bay_n,2);
 if nvl(kl_k,0) =0 then kl_k:=1; end if;  ---
 cena_bay:=round(nvl(k.sumb,s_kupl_op)/kl_k,2); cena0:=cena_bay;  ---
 kl_k2:=null;  cena_k2:=null;
 if l_tiket is not null then nm_pr:=trim(get_kontragent(k.ref)); end if;
 else
 kl_k:=null; kl_k2:=null;  cena_k2:=7; cena0:=7;
 null;
 end if;

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

begin
select pf into l_pf1 from cp_v where acc=k.acc;
exception when NO_DATA_FOUND then NULL; l_pf1:=99;
end;

begin
--select * into r_gl2 from cp_accp
--where pf=pf_new and ryn=ryn_new and vidd=...  and emi=k.emi;
NULL;
end;

if k.ref_new is not null then
begin
select vdat into l_dat_mv      --l_vdat
from oper where ref=k.ref_new                  and sos=5;
exception when NO_DATA_FOUND then NULL;
l_dat_mv:=null; l_ref_pr:=null;
l_ref_mv:=null;
end;
else
l_dat_mv:=null; l_ref_pr:=null;
l_ref_mv:=null;
end if;

 begin
 select * into r_dl1 from cp_deal where ref=k.ref;
 end;
--LOG('CP_OBU dl1='||r_dl1.acc||' '||r_dl1.accd||' '||r_dl1.accr,'INFO',0);

begin
select pf into l_pf2 from cp_v where acc=r_dl1.acc;
exception when NO_DATA_FOUND then NULL; l_pf2:=99;
end;

---------
 ODN_:=0; OKN_:=0; SN_:=0; ODN_q:=0; OKN_q:=0; SN_Q:=0;
 SN_31:=0; SN_31Q:=0;

 if r_dl1.acc is not null then
 select -rez.ostc96(r_dl1.acc,l_dat1131)/100 into SN_ from dual;
 select gl.p_icurval(k.kv,SN_,l_dat1131) into SN_Q from dual;

 ---select -fost_q(r_dl1.acc,l_dat1131,l_dat1131)/100 into SN_Q from dual;

    if (k.dat_k < l_dat1 and  SN_ =0) then  goto EX1; end if;   -- OBU/BARS!
    if (k.dat_k > l_dat31) then  goto EX1; end if;

  --  потрібно по OPLDOK з аналізом TT
 select fdos(r_dl1.acc,l_dat1,l_dat2)/100,
        fkos(r_dl1.acc,l_dat1,l_dat2)/100 into ODN_, OKN_ from dual;
 select fdosn(l_kv,r_dl1.acc,l_dat1,l_dat2)/100,
        fkosn(l_kv,r_dl1.acc,l_dat1,l_dat2)/100 into ODN_q, OKN_q from dual;

 select -rez.ostc96(r_dl1.acc,l_dat31)/100 into SN_31 from dual;
 ---select -fost_q(r_dl1.acc,l_dat31,l_dat31)/100 into SN_31Q from dual;
 select gl.p_icurval(k.kv,SN_31,l_dat31) into SN_31Q from dual;
 kl31:=round(SN_31/cena31,2);

 else
 ODN_:=0; OKN_:=0; SN_:=0; ODN_q:=0; OKN_q:=0; SN_Q:=0;
 SN_31:=0; SN_31Q:=0;
 end if;

---------
       --***
    begin
      l_fl_p :=0 ;
      select 1 into l_fl_p from dual
      where exists (select 1 from opldok
                    where acc=r_dl1.acc and dk=1
                    and fdat >=l_dat1 and fdat <= l_dat31);
     exception when NO_DATA_FOUND then NULL;  l_fl_p:=0;
    end;

   OKN_K:=0;
 begin
 select sum(o.s)/100
 into   OKN_K
 from opldok o, OPER P
 where o.acc = k.acc and o.dk=1  and o.ref=p.ref
       and      o.sos=5     ---o.sos>0     -- ? OBU/BARS
       and fdat >=l_dat1          --and fdat <= l_dat31
       and p.vdat > l_dat1
       and (p.vdat <= l_dat31 or vob=096 and p.vdat > l_dat31);
 end;

 DF_:=555;     --N2_P:=OKN_K;
 if  OKN_K != SN_31 - SN_ then   DF_:= OKN_K - (SN_31 - SN_);  null;  end if;


 SN_PR:=0; kl_p2:=0; s_pr:=0; s_pr_op:=0; n3_p :=88;   n2_p:=88;
 begin
 select o.ref, decode(vob,096,p.vdat,o.fdat), o.s/100, P.VOB, p.s/100
 into l_ref_pr, l_dat_pr, sn_pr, VOB2, s_pr_op
 from opldok o, cp_deal d, OPER P
 where o.acc = k.acc and o.acc=d.acc and o.dk=1  and o.ref=p.ref
       and rownum=1  and o.sos=5     ---o.sos>0  -- OBU/BARS
       and o.fdat =
       (select min(fdat) from opldok
        where fdat>=k.dat_k and fdat>l_dat1      --  and fdat<=l_dat2
                           and acc=d.acc)
       and p.vdat > l_dat1
       and (p.vdat <= l_dat31 or vob=096 and p.vdat > l_dat31);

     l_ref2:=l_ref_pr;   N2_P:=SN_PR;
 exception when NO_DATA_FOUND then NULL;
  --l_dat_pr := null;                    N2_p:=null;
  sn_pr := 0;  l_ref_pr := l_ref_mv;   s_pr_op:=0;
  l_ref3 := null; l_dat3 := null;
  l_ref2:=l_ref_mv; l_dat_pr:=l_dat_mv;  -- l_ref2 := null;

 end;

 begin
 if l_fl_p = 1 then
 select * into r_dl2 from cp_deal where ref= l_ref_pr;
 else
 r_dl2:=null;
 end if;
 exception when NO_DATA_FOUND then NULL; r_dl2:=null;
 end;

          --  ***


                           /***
               --****
 --SN_PR:=0; kl_p2:=0;
 sumb_pr:=0; op_pr:=null; n3_p:=888;  n2_p:=888;
 begin
 select o.ref, decode(vob,096,p.vdat,o.fdat), o.s/100, P.VOB
 into l_ref_pr, l_dat_pr, sn_pr, VOB2
 from opldok o, cp_deal d, OPER P
 where o.acc = r_dl1.acc and o.acc=d.acc and o.dk=1  and o.ref=p.ref
       and rownum=1  and o.sos=5     ---o.sos>0
       and o.fdat =
       (select min(fdat) from opldok
        where fdat>k.dat_k and fdat>l_dat1      --  and fdat<=l_dat2
                           and acc=d.acc);
 if l_dat_pr > l_dat31  then
    l_ref3 := l_ref_pr; l_dat3 := l_dat_pr; l_ref2:=l_ref_mv;
 else l_ref2:= l_ref_pr; l_dat2 := l_dat_pr; l_ref3:=null;  l_dat3:=null;
 end if;

 if l_dat_pr >= k.dat_pg  then
 l_dat_g:=l_dat_pr; l_ref_g:=l_ref_pr;
 else
 l_dat_g:=null; l_ref_g:=null;
 end if;

 exception when NO_DATA_FOUND then NULL;
  s_pr := 0;      l_ref_pr := l_ref_mv;
  l_ref3 := null; l_dat3 := null;
  --l_dat_pr := null;
  l_ref2:=l_ref_mv; l_dat_pr:=l_dat_mv;  -- l_ref2 := null;
 end;
                              ***/

  if l_fl = 1 and l_dat_pr is not null  and k.cena != k.cena_start then
  begin
  select k.cena_start - sum(nvl(a.nom,0))  into cena_p2
  from cp_dat a  where a.id=k.ID and a.DOK <= l_dat_pr;
  end;
  else
  cena_p2:=k.cena;
  end if;
  if nvl(cena_p2,0)=0 then cena_p2:=1;  /*500;*/ end if;

 if l_ref_pr is not null and l_dat_pr is not null
             and l_dat_pr <= l_dat31  then       -- 31

   begin
   select sumb/100, op, n/100, stiket
   into sumb_pr, op_pr, n2_p, l_tiket
   from cp_arch where ref=l_ref_pr;

   --nm_kup:=trim(get_kontragent(l_ref_pr));

  exception when NO_DATA_FOUND then NULL;
   n2_p:=sn_pr;
   sumb_pr:=0; op_pr:=null;      -- n2_p:=null;       n2_p:=99;
   end;
 elsif l_ref_pr is not null then  n2_p:=null;
 begin
 select sumb/100, op, n/100, stiket
   into sumb_pr, op_pr, n3_p, l_tiket
   from cp_arch where ref=l_ref_pr;
  -- nm_kup4:=trim(get_kontragent(l_ref_pr));
 exception when NO_DATA_FOUND then NULL;
   sumb_pr:=0; op_pr:=null; n3_p:=88;
 --  ????
 end;
 else
 n2_p:=sn_pr;
 sumb_pr:=0; op_pr:=null; kl_p2:=null; cena_p2:=null; --n2_p:=null;
 n3_p:=null;
 end if;   -- 31

 if sn_pr is not null then
  kl_p2:=round(SN_PR/cena_p2,2);  -- ?
  if nvl(kl_p2,0) =0 then kl_p2:=1; end if;
  cena_pr:=round(nvl(sumb_pr,s_pr_op)/kl_p2,2);
     -- op_pr   2 - sale  3 - move
 end if;

              -- ***

              -- sale   =======
 if l_ref2 is not null then      -- k.ref_new
-- бухмодель sale/move/перекласифікації для старих рах-в
select Nvl(sum(decode(o.dk,0,1,0)*o.s),0)/100, Nvl(sum(decode(o.dk,0,1,0)*o.sq),0)/100,
       Nvl(sum(decode(o.dk,0,0,1)*o.s),0)/100, Nvl(sum(decode(o.dk,0,0,1)*o.sq),0)/100
                into ODN_P, ODN_PQ, OKN_P, OKN_PQ
                from opldok o
                where o.ref = l_ref2 and acc = r_dl1.acc;  -- k.ref_new

  if SN_pr = 0 then  sn_pr:=OKN_P;  end if;   -- ???

select Nvl(sum(decode(o.dk,0,1,0)*o.s),0)/100, Nvl(sum(decode(o.dk,0,1,0)*o.sq),0)/100,
       Nvl(sum(decode(o.dk,0,0,1)*o.s),0)/100, Nvl(sum(decode(o.dk,0,0,1)*o.sq),0)/100
                into ODD_P, ODD_PQ, OKD_P, OKD_PQ
                from opldok o
                where o.ref = l_ref2 and acc = r_dl1.accd;

select Nvl(sum(decode(o.dk,0,1,0)*o.s),0)/100, Nvl(sum(decode(o.dk,0,1,0)*o.sq),0)/100,
       Nvl(sum(decode(o.dk,0,0,1)*o.s),0)/100, Nvl(sum(decode(o.dk,0,0,1)*o.sq),0)/100
                into ODP_P, ODP_PQ, OKP_P, OKP_PQ
                from opldok o
                where o.ref = l_ref2 and acc = r_dl1.accp;

select Nvl(sum(decode(o.dk,0,1,0)*o.s),0)/100, Nvl(sum(decode(o.dk,0,1,0)*o.sq),0)/100,
       Nvl(sum(decode(o.dk,0,0,1)*o.s),0)/100, Nvl(sum(decode(o.dk,0,0,1)*o.sq),0)/100
                into ODR_P, ODR_PQ, OKR_P, OKR_PQ
                from opldok o
                where o.ref = l_ref2 and acc = r_dl1.accr;

select Nvl(sum(decode(o.dk,0,1,0)*o.s),0)/100, Nvl(sum(decode(o.dk,0,1,0)*o.sq),0)/100,
       Nvl(sum(decode(o.dk,0,0,1)*o.s),0)/100, Nvl(sum(decode(o.dk,0,0,1)*o.sq),0)/100
                into ODR2_P, ODR2_PQ, OKR2_P, OKR2_PQ
                from opldok o
                where o.ref = l_ref2 and acc = r_dl1.accr2;

select Nvl(sum(decode(o.dk,0,1,0)*o.s),0)/100, Nvl(sum(decode(o.dk,0,1,0)*o.sq),0)/100,
       Nvl(sum(decode(o.dk,0,0,1)*o.s),0)/100, Nvl(sum(decode(o.dk,0,0,1)*o.sq),0)/100
                into ODS_P, ODS_PQ, OKS_P, OKS_PQ
                from opldok o
                where o.ref = l_ref2 and acc = r_dl1.accs;
 end if; --   l_ref2     --ref_new

         /*******
 begin
 if k.ref_new is not null then
 select * into r_dl2 from cp_deal where ref=k.ref_new;
 else
 r_dl2:=null;
 end if;
 end;
--LOG('CP_OBU dl2='||r_dl2.acc||' '||r_dl2.accd||' '||r_dl2.accr,'INFO',0);
            *****/

 begin
 if l_ref2 is not null and op_pr =3 then             -- move
 select * into r_dl2 from cp_deal where ref=l_ref2;
 else
 r_dl2:=null;
 end if;
 end;
--LOG('CP_OBU dl2='||r_dl2.acc||' '||r_dl2.accd||' '||r_dl2.accr,'INFO',0);

if l_ref2 is not null and op_pr in (2,4) then             -- sale/gash
   l_ref5:=l_ref2;
 ---  torg. rez-t   *****+++++++++
   if k.kv=980 then
 begin
 select decode(o.dk,0,1,1,-1) * o.s/100
 into  s_63
 from opldok o, opldok k, accounts ak
 where o.acc = acc_3739    --137465
       -- and o.dk = 1 - k.dk
       and o.ref=k.ref  and o.stmt=k.stmt  and o.tt='FXT'
       and o.ref=l_ref5     --114857099
       and ak.acc=k.acc
       and ak.nls like '6393%'  and rownum=1
       and o.sos=5;
 exception when NO_DATA_FOUND then NULL;  s_63:=0;
 end;
 tr_31:=tr_31+s_63;
    else s_63:=0;
    end if;
 else
 l_ref5:=null;  s_63:=0;
 end if;

  ----- l_dat2:=l_vdat;   --   -1;

if l_ref2 is     null then           --- k.ref_new
 --  l_dat2:=l_dat31;
   ODN_P_new:=0; ODN_PQ_new:=0; OKN_P_new:=0; OKN_PQ_new:=0;
   ODD_P_new:=0; ODD_PQ_new:=0; OKD_P_new:=0; OKD_PQ_new:=0;
   ODP_P_new:=0; ODP_PQ_new:=0; OKP_P_new:=0; OKP_PQ_new:=0;
   ODR_P_new:=0; ODR_PQ_new:=0; OKR_P_new:=0; OKR_PQ_new:=0;
   ODR2_P_new:=0; ODR2_PQ_new:=0; OKR2_P_new:=0; OKR2_PQ_new:=0;
   ODS_P_new:=0; ODS_PQ_new:=0; OKS_P_new:=0; OKS_PQ_new:=0;
else

-- бухмодель MOVE/перекласифікації для нових рах-в
select Nvl(sum(decode(o.dk,0,1,0)*o.s),0)/100, Nvl(sum(decode(o.dk,0,1,0)*o.sq),0)/100,
       Nvl(sum(decode(o.dk,0,0,1)*o.s),0)/100, Nvl(sum(decode(o.dk,0,0,1)*o.sq),0)/100
                into ODN_P_new, ODN_PQ_new, OKN_P_new, OKN_PQ_new
                from opldok o
                where o.ref = l_ref2 and acc = r_dl2.acc;

select Nvl(sum(decode(o.dk,0,1,0)*o.s),0)/100, Nvl(sum(decode(o.dk,0,1,0)*o.sq),0)/100,
       Nvl(sum(decode(o.dk,0,0,1)*o.s),0)/100, Nvl(sum(decode(o.dk,0,0,1)*o.sq),0)/100
                into ODD_P_new, ODD_PQ_new, OKD_P_new, OKD_PQ_new
                from opldok o
                where o.ref = l_ref2 and acc = r_dl2.accd;

select Nvl(sum(decode(o.dk,0,1,0)*o.s),0)/100, Nvl(sum(decode(o.dk,0,1,0)*o.sq),0)/100,
       Nvl(sum(decode(o.dk,0,0,1)*o.s),0)/100, Nvl(sum(decode(o.dk,0,0,1)*o.sq),0)/100
                into ODP_P_new, ODP_PQ_new, OKP_P_new, OKP_PQ_new
                from opldok o
                where o.ref = l_ref2 and acc = r_dl2.accp;

select Nvl(sum(decode(o.dk,0,1,0)*o.s),0)/100, Nvl(sum(decode(o.dk,0,1,0)*o.sq),0)/100,
       Nvl(sum(decode(o.dk,0,0,1)*o.s),0)/100, Nvl(sum(decode(o.dk,0,0,1)*o.sq),0)/100
                into ODR_P_new, ODR_PQ_new, OKR_P_new, OKR_PQ_new
                from opldok o
                where o.ref = l_ref2 and acc = r_dl2.accr;

select Nvl(sum(decode(o.dk,0,1,0)*o.s),0)/100, Nvl(sum(decode(o.dk,0,1,0)*o.sq),0)/100,
       Nvl(sum(decode(o.dk,0,0,1)*o.s),0)/100, Nvl(sum(decode(o.dk,0,0,1)*o.sq),0)/100
                into ODR2_P_new, ODR2_PQ_new, OKR2_P_new, OKR2_PQ_new
                from opldok o
                where o.ref = l_ref2 and acc = r_dl2.accr2;

select Nvl(sum(decode(o.dk,0,1,0)*o.s),0)/100, Nvl(sum(decode(o.dk,0,1,0)*o.sq),0)/100,
       Nvl(sum(decode(o.dk,0,0,1)*o.s),0)/100, Nvl(sum(decode(o.dk,0,0,1)*o.sq),0)/100
                into ODS_P_new, ODS_PQ_new, OKS_P_new, OKS_PQ_new
                from opldok o
                where o.ref = l_ref2 and acc = r_dl2.accs;
end if;  -- ref_new

if r_dl1.acc is not null or r_dl2.acc is not null then

-- вих. залишки та обороти по  складових рах-х
-- для old за l_dat1 по l_dat2           (звітний період)
-- для new за l_dat2 по l_dat2+1       (...)
l_dat2:=l_dat31;
                           /****
 if r_dl1.acc is not null then
 select -rez.ostc96(r_dl1.acc,l_dat1131)/100 into SN_ from dual;
 ---select -fost_q(r_dl1.acc,l_dat1131,l_dat1131)/100 into SN_Q from dual;
 select gl.p_icurval(k.kv,SN_,l_dat1131) into SN_Q from dual;
  --  потрібно по OPLDOK з аналізом TT
 select fdos(r_dl1.acc,l_dat1,l_dat2)/100,
        fkos(r_dl1.acc,l_dat1,l_dat2)/100 into ODN_, OKN_ from dual;
 select fdosn(l_kv,r_dl1.acc,l_dat1,l_dat2)/100,
        fkosn(l_kv,r_dl1.acc,l_dat1,l_dat2)/100 into ODN_q, OKN_q from dual;
 else
 ODN_:=0; OKN_:=0; SN_:=0; ODN_q:=0; OKN_q:=0; SN_Q:=0;
 end if;
                           ****/
 --cena2:=k.cena;
 --cena_p2:=k.cena;
 kol_n:=round(SN_/k.cena_start,2);
 kol_t:=round(SN_/cena4,2);
 if SN_ != 0 then kl1:=round(SN_/cena1,2); end if;
 kl_p2:=round(SN_PR/cena_p2,2);

 --- 31/12
 select -rez.ostc96(r_dl1.acc,l_dat31)/100 into SN_31 from dual;
 ---select -fost_q(r_dl1.acc,l_dat31,l_dat31)/100 into SN_31Q from dual;
 select gl.p_icurval(k.kv,SN_31,l_dat31) into SN_31Q from dual;
 kl31:=round(SN_31/cena31,2);


 if k.ref_new is not null and r_dl2.acc is not null then
 select fdos(r_dl2.acc,l_dat1,l_dat2)/100,
        fkos(r_dl2.acc,l_dat1,l_dat2)/100 into ODN_N, OKN_N from dual;
 select fost(r_dl2.acc,l_dat2)/100 into SN_N from dual;
 select fdosn(l_kv,r_dl2.acc,l_dat1,l_dat2)/100,
        fkosn(l_kv,r_dl2.acc,l_dat1,l_dat2)/100 into ODN_Nq, OKN_Nq from dual;
 ---select fost_q(r_dl2.acc,l_dat2,l_dat2)/100 into SN_NQ from dual;
 else
 ODN_N:=0; OKN_N:=0; SN_N:=0; ODN_Nq:=0; OKN_Nq:=0; SN_NQ:=0;
 end if;

 if k.ref_new is not null  and op_pr=3 then
begin
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
          (select * from cp_deal where ref=k.ref_new) r_dl2d,
               accounts a,accounts d,accounts p,accounts r,accounts r2,accounts s
          where r_dl2d.acc   = a.acc
            and nvl(r_dl2d.accd,-100)  = d.acc  (+)
            and nvl(r_dl2d.accp,-100)  = p.acc  (+)
            and nvl(r_dl2d.accr,-100)  = r.acc  (+)
            and nvl(r_dl2d.accr2,-100) = r2.acc (+)
            and nvl(r_dl2d.accs,-100)  = s.acc  (+);
exception when NO_DATA_FOUND then NULL;
     l_nls_n2:=null; l_nls_d2:=null; l_nls_p2:=null;
     l_nls_r2:=null; l_nls_r22:=null; l_nls_s2:=null;
end;
else
     l_nls_n2:=null; l_nls_d2:=null; l_nls_p2:=null;
     l_nls_r2:=null; l_nls_r22:=null; l_nls_s2:=null;
 end if;

-- визначати  залишки по рахунках-складових пакету на відповідні дати.
-- по SALDOA
           -- old virt  на момент створення
   /****
begin
select
--decode (a.tip,'2VD',nvl((select sum(s)/100 from opldok where ref =r.ref and acc = a.acc and dk=0),0),0),
--decode (a.tip,'2VP',nvl((select sum(s)/100 from opldok where ref =r.ref and acc = a.acc and dk=0),0),0),
--decode (a.tip,'2VD',nvl((select sum(s)/100 from opldok where ref =r.ref and acc = a.acc and dk=1),0),0),
--decode (a.tip,'2VP',nvl((select sum(s)/100 from opldok where ref =r.ref and acc = a.acc and dk=1),0),0),
decode (a.tip,'2VD',a.acc,null), decode (a.tip,'2VP',a.acc,null),
a.nls, substr(a.nms,1,38) nms,a.pap
into --oddv_p, odpv_p, okdv_p, okpv_p,
accd_v, accp_v, nls_v, nms_v, pap_v
from cp_ref_acc r, accounts a where r.ref= k.ref and r.acc= a.acc;
exception when NO_DATA_FOUND then NULL;
oddv_p:=0; odpv_p:=0; okdv_p:=0; okpv_p:=0;
accd_v:=null; accp_v:=null; nls_v:=null; nms_v:=null; pap_v:=null;
end;
    -- old virt  на момент переклас-ї
if accd_v is not null then
select Nvl(sum(decode(o.dk,0,1,0)*o.s),0)/100, Nvl(sum(decode(o.dk,0,1,0)*o.sq),0)/100,
       Nvl(sum(decode(o.dk,0,0,1)*o.s),0)/100, Nvl(sum(decode(o.dk,0,0,1)*o.sq),0)/100
                into ODDv_P, ODDv_PQ, OKDv_P, OKDv_PQ
                from opldok o
                where o.ref = k.ref_new and acc = accd_v;

select Nvl(sum(decode(o.dk,0,1,0)*o.s),0)/100, Nvl(sum(decode(o.dk,0,1,0)*o.sq),0)/100,
       Nvl(sum(decode(o.dk,0,0,1)*o.s),0)/100, Nvl(sum(decode(o.dk,0,0,1)*o.sq),0)/100
                into ODPv_P, ODPv_PQ, OKPv_P, OKPv_PQ
                from opldok o
                where o.ref = k.ref_new and acc = accp_v;
else
ODDv_P:=0; ODDv_PQ:=0; OKDv_P:=0; OKDv_PQ:=0;
end if;
        -- new virt    на момент створення
if k.ref_new is not null then
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
accd_vn:=null; accp_vn:=null; nls_vn:=null; nms_vn:=null;
end;
else
oddv_p_new:=0; odpv_p_new:=0; okdv_p_new:=0; okpv_p_new:=0;
accd_vn:=null; accp_vn:=null; nls_vn:=null; nms_vn:=null;
end if;
        *****/

if l_dat_pr is not null then  oddv_p_new:=s_pr; end if;

-- N
if 1=2
       and  r_dl1.acc is not null then
select Nvl(sum(decode(o.dk,0,1,0)*o.s),0)/100, Nvl(sum(decode(o.dk,0,1,0)*o.sq),0)/100,
       Nvl(sum(decode(o.dk,0,0,1)*o.s),0)/100, Nvl(sum(decode(o.dk,0,0,1)*o.sq),0)/100
                into ODN_K, ODN_KQ, OKN_K, OKN_KQ
                from opldok o, oper p
                where p.ref = o.ref and o.sos=5 and o.fdat >= to_date('01/01/2012','dd/mm/yyyy')
                 and p.vdat >= l_dat1 and o.tt in ('FXH','FXH')
                 and o.acc = r_dl1.acc;
else
ODN_K:=0; ODN_KQ:=0;    --OKN_K:=0;
OKN_KQ:=0;
end if;


if 1=2
    and k.ref_new is not null and r_dl2.acc is not null then
select Nvl(sum(decode(o.dk,0,1,0)*o.s),0)/100, Nvl(sum(decode(o.dk,0,1,0)*o.sq),0)/100,
       Nvl(sum(decode(o.dk,0,0,1)*o.s),0)/100, Nvl(sum(decode(o.dk,0,0,1)*o.sq),0)/100
                into ODN_K_new, ODN_KQ_new, OKN_K_new, OKN_KQ_new
                from opldok o, oper p
                where p.ref = o.ref and o.sos=5 and o.fdat >= to_date('01/01/2012','dd/mm/yyyy')
                 and p.vdat >= l_dat1 and o.tt in ('FXH','FXH')
                 and o.acc = r_dl2.acc;
else
ODN_K_new:=0; ODN_KQ_new:=0; OKN_K_new:=0; OKN_KQ_new:=0;
end if;

if k.ref_new is not null and r_dl2.acc is not null then
select Nvl(sum(decode(o.dk,0,1,0)*o.s),0)/100, Nvl(sum(decode(o.dk,0,1,0)*o.sq),0)/100,
       Nvl(sum(decode(o.dk,0,0,1)*o.s),0)/100, Nvl(sum(decode(o.dk,0,0,1)*o.sq),0)/100
                into S_ODN_new, S_ODN_Q_new, S_OKN_new, s_OKN_Q_new
                from opldok o, oper p
                where p.ref = o.ref and o.sos=5 and o.fdat = l_dat2
                 and p.vdat = l_dat2        --     and o.tt  in ('FXH','FXH')
                 and o.ref!=k.ref_new
                 and o.acc = r_dl2.acc;
else
S_ODN_new:=0; S_ODN_Q_new:=0; S_OKN_new:=0; S_OKN_Q_new:=0;
end if;

 ODN_:=ODN_-ODN_P; OKN_:=OKN_-OKN_P;
 ODN_q:=ODN_q-ODN_Pq; OKN_q:=OKN_q-OKN_Pq;
 SN_N:= SN_N + s_odn_new - s_okn_new + odn_k_new - okn_k_new;
 SN_Nq:= SN_Nq + s_odn_q_new - s_okn_q_new + odn_kq_new - okn_kq_new;

    /*****
 begin
 insert into tmp_cp_obu7
 (id,isin,kv,dat_p,  nls, nms, vid_r, pap,  ref, ost_v, ost_vq,
  S_D, S_C,   S_DK, S_CK,
  nls_p, OST_P, ost_pq,
  s_dp, s_cp,    --nms_p,
  s_dp_new, s_cp_new, s_dk_new, s_ck_new,
  s_dpq_new, s_cpq_new, s_dkq_new,            s_ckq_new,
  nls_p1,     nls_s,
  S_Dq, S_Cq, S_DPq, S_CPq,  S_DKq, S_CKq,
  nbs_new, nbs_old, pf_new, pf_old,  ost_v31, ost_vt,
  ref2,userid,dat_k,dat_r)
 values
 (k.id,k.cp_id,l_kv,l_dat2, k.nls,k.nms,'N',k.pap_n,k.ref, SN_, SN_Q,
  ODN_, OKN_, ODN_K, OKN_K,
  l_nls_n2, SN_N, SN_NQ,
  ODN_P, OKN_P, --l_nms_n2,
  odn_p_new, okn_p_new, odn_k_new, okn_k_new,
  odn_pq_new, okn_pq_new, odn_kq_new,         df_,      ---okn_kq_new,
  l_nls_n2, r_dl2.acc,
  ODN_q, OKN_q, ODN_Pq, OKN_Pq, ODN_Kq, OKN_Kq,
  substr(l_nls_n2,1,4), substr(k.nls,1,4), null,      ---k.pf_new,
  l_pf2,  SA_31, k.SA,
  l_ref_pr,l_userid,
  l_dat_k,t_dat);    -- k.ref_new
 exception when others then NULL;
 LOG('CP_OBU error N ID='||k.cp_id||' ref='||k.ref,'ERROR',0);
 end;
                               ****/
end if;   -- N

 SD_31:=0; SD_31Q:=0;

if r_dl1.accd is not null or r_dl2.accd is not null then
if r_dl1.accd is not null then
       SD_:=77777; SD_Q:=777;
 select -rez.ostc96(r_dl1.accd,l_dat1131)/100 into SD_ from dual;
 ---select -fost_q(r_dl1.accd,l_dat1131,l_dat1131)/100 into SD_Q from dual;
 select gl.p_icurval(k.kv,SD_,l_dat1131) into SD_Q from dual;
  --  потрібно по OPLDOK з аналізом TT
 select fdos(r_dl1.accd,l_dat1,l_dat2)/100,
        fkos(r_dl1.accd,l_dat1,l_dat2)/100 into ODD_, OKD_ from dual;
 select fdosn(l_kv,r_dl1.accd,l_dat1,l_dat2)/100,
        fkosn(l_kv,r_dl1.accd,l_dat1,l_dat2)/100 into ODD_q, OKD_q from dual;

 select -rez.ostc96(r_dl1.accd,l_dat31)/100 into SD_31 from dual;
 ---select -fost_q(r_dl1.accd,l_dat31,l_dat31)/100 into SD_31Q from dual;
 select gl.p_icurval(k.kv,SD_31,l_dat31) into SD_31Q from dual;

else
SD_:=0; SD_Q:=0;  ODD_:=0; OKD_:=0; ODD_q:=0; OKD_q:=0;
SD_31:=0; SD_31Q:=0;
end if;

 if k.ref_new is not null and r_dl2.accd is not null then
       SD_N:=4.50; SD_NQ:=4.55;
 select fdos(r_dl2.accd,l_dat1,l_dat2)/100,
        fkos(r_dl2.accd,l_dat1,l_dat2)/100 into ODD_N, OKD_N from dual;
 select fost(r_dl2.accd,l_dat2)/100 into SD_N from dual;
 select fdosn(l_kv,r_dl2.accd,l_dat1,l_dat2)/100,
        fkosn(l_kv,r_dl2.accd,l_dat1,l_dat2)/100 into ODD_Nq, OKD_Nq from dual;
 ---select fost_q(r_dl2.accd,l_dat2,l_dat2)/100 into SD_NQ from dual;
 else
 ODD_N:=0; OKD_N:=0; SD_N:=0;  ODD_Nq:=0; OKD_Nq:=0; SD_NQ:=0;
 end if;   -- r_dl2

if 1=2
       and r_dl1.accd is not null then
select Nvl(sum(decode(o.dk,0,1,0)*o.s),0)/100, Nvl(sum(decode(o.dk,0,1,0)*o.sq),0)/100,
       Nvl(sum(decode(o.dk,0,0,1)*o.s),0)/100, Nvl(sum(decode(o.dk,0,0,1)*o.sq),0)/100
                into ODD_K, ODD_KQ, OKD_K, OKD_KQ
                from opldok o, oper p
                where p.ref = o.ref and o.sos=5  and o.fdat >= to_date('01/01/2012','dd/mm/yyyy')
                 and p.vdat >= l_dat1 and o.tt in ('FXH','FXH')
                 and o.acc = r_dl1.accd;
else
ODD_K:=0; ODD_KQ:=0; OKD_K:=0; OKD_KQ:=0;
end if;

if 1=2
       and k.ref_new is not null and r_dl2.accd is not null then
select Nvl(sum(decode(o.dk,0,1,0)*o.s),0)/100, Nvl(sum(decode(o.dk,0,1,0)*o.sq),0)/100,
       Nvl(sum(decode(o.dk,0,0,1)*o.s),0)/100, Nvl(sum(decode(o.dk,0,0,1)*o.sq),0)/100
                into ODD_K_new, ODD_KQ_new, OKD_K_new, OKD_KQ_new
                from opldok o, oper p
                where p.ref = o.ref and o.sos=5  and o.fdat >= to_date('01/01/2012','dd/mm/yyyy')
                 and p.vdat >= l_dat1 and o.tt in ('FXH','FXH')
                 and o.acc = r_dl2.accd;
else
ODD_K_new:=0; ODD_KQ_new:=0; OKD_K_new:=0; OKD_KQ_new:=0;
end if;

if k.ref_new is not null and r_dl2.accd is not null then
select Nvl(sum(decode(o.dk,0,1,0)*o.s),0)/100, Nvl(sum(decode(o.dk,0,1,0)*o.sq),0)/100,
       Nvl(sum(decode(o.dk,0,0,1)*o.s),0)/100, Nvl(sum(decode(o.dk,0,0,1)*o.sq),0)/100
                into S_ODD_new, S_ODD_Q_new, S_OKD_new, s_OKD_Q_new
                from opldok o, oper p
                where p.ref = o.ref and o.sos=5 and o.fdat = l_dat_pr  --l_dat2    --to_date('01/01/2012','dd/mm/yyyy')
                 and p.vdat = l_dat_pr  --l_dat2
                 and o.ref!=k.ref_new
                 and o.acc = r_dl2.accd;
else
S_ODD_new:=0; S_ODD_Q_new:=0; S_OKD_new:=0; S_OKD_Q_new:=0;
end if;

 ODD_:=ODD_-ODD_P; OKD_:=OKD_-OKD_P; ODD_q:=ODD_q-ODD_Pq; OKD_q:=OKD_q-OKD_Pq;

 SD_N:= SD_N + s_odd_new - s_okd_new + odd_k_new - okd_k_new;
 SD_Nq:= SD_Nq + s_odd_q_new - s_okd_q_new + odd_kq_new - okd_kq_new;

                                   /***
 begin
 insert into tmp_cp_obu7
 (id,isin,kv,dat_p,    nls,nms,vid_r,pap,   ref,ost_v, ost_vq,
  S_D, S_C,   S_DK, S_CK,
  nls_p, ost_p, ost_pq,
  s_dp, s_cp,  --nms_p,
  s_dp_new, s_cp_new, s_dk_new, s_ck_new,
  s_dpq_new, s_cpq_new, s_dkq_new, s_ckq_new,
  nls_p1, nls_s,
  S_Dq, S_Cq, S_DPq, S_CPq,  S_DKq, S_CKq,
  nbs_new, nbs_old, pf_new,  ost_v31, ost_vt,
  D0, D1, D2, D31, D4,
  ref2,userid,dat_k,dat_r)
 values
 (k.id,k.cp_id,l_kv,l_dat2, k.NLSD,k.nms_d,'D',k.pap_d,k.ref,  SD_, SD_Q,
  ODD_, OKD_, ODD_K, OKD_K,
  l_nls_d2, SD_N, SD_NQ,
  ODD_P, OKD_P,       --l_nms_d2,
  odd_p_new, okd_p_new, odd_k_new, okd_k_new,
  odd_pq_new, okd_pq_new, odd_kq_new, okd_kq_new,
  l_nls_d2, r_dl2.accd,
  ODD_q, OKD_q, ODD_Pq, OKD_Pq, ODD_Kq, OKD_Kq,
  --substr(l_nls_d2,1,4),
  decode(r_dl2.accd,NULL,decode(r_dl2.accp,NULL,substr(l_nls_s2,1,4),substr(l_nls_p2,1,4)),substr(l_nls_d2,1,4)),
  --substr(k.nlsd,1,4),
  decode(r_dl1.accd,NULL,decode(r_dl1.accp,NULL,decode(r_dl1.accs,NULL,NULL,substr(k.nlss,1,4)), substr(k.nlsp,1,4)),substr(k.nlsd,1,4) ),
  null,      ---  k.pf_new,
  SD_31, k.SD,
  77.5, 88.5, 9.5, SD_31, k.SD,
  l_ref_pr,l_userid,
  l_dat_k,t_dat);
 exception when others then NULL;
 LOG('CP_OBU error D ID='||k.cp_id||' ref='||k.ref,'ERROR',0);
 end;
                       ***/
end if;     -- D

               -- virt D
 SDV_:=0; ODDV_:=0; OKDV_:=0;  SDV_q:=0; ODDV_q:=0; OKDV_q:=0;
 ODDV_P:=0; ODDV_PQ:=0; OKDV_P:=0; OKDV_PQ:=0;

 SDV_N:=0; ODDV_N:=0; OKDV_N:=0;  SDV_Nq:=0; ODDV_Nq:=0; OKDV_Nq:=0;
 ODDV_K_new:=0; ODDV_KQ_new:=0; OKDV_K_new:=0; OKDV_KQ_new:=0;
 ODDV_P_new:=0; ODDV_PQ_new:=0; OKDV_P_new:=0; OKDV_PQ_new:=0;

 ODDV_:=ODDV_-ODDV_P;  OKDV_:=OKDV_-OKDV_P;
 ODDV_q:=ODDV_q-ODDV_Pq;  OKDV_q:=OKDV_q-OKDV_Pq;

      -- P
 SP_31:=0; SP_31Q:=0;
 SP_:=0; SP_Q:=0; ODP_:=0; OKP_:=0; ODP_q:=0; OKP_q:=0;
 SP_31:=0; SP_31Q:=0;

 ODP_N:=0; OKP_N:=0; SP_N:=0;  ODP_Nq:=0; OKP_Nq:=0; SP_NQ:=0;
 ODP_K:=0; ODP_KQ:=0; OKP_K:=0; OKP_KQ:=0;
 ODP_K_new:=0; ODP_KQ_new:=0; OKP_K_new:=0; OKP_KQ_new:=0;
 S_ODP_new:=0; S_ODP_Q_new:=0; S_OKP_new:=0; S_OKP_Q_new:=0;

if r_dl1.accp is not null or r_dl2.accp is not null then

if r_dl1.accp is not null then
     --SP_:=99; SP_Q:=999; SP_:=9.9; SP_Q:=9.99;
 select -rez.ostc96(r_dl1.accp,l_dat1131)/100 into SP_ from dual;
 ---select -fost_q(r_dl1.accp,l_dat1131,l_dat1131)/100 into SP_Q from dual;
 select gl.p_icurval(k.kv,SP_,l_dat1131) into SP_Q from dual;
  --  потрібно по OPLDOK з аналізом TT
 select fdos(r_dl1.accp,l_dat1,l_dat2)/100,
        fkos(r_dl1.accp,l_dat1,l_dat2)/100 into ODP_, OKP_ from dual;
 select fdosn(l_kv,r_dl1.accp,l_dat1,l_dat2)/100,
        fkosn(l_kv,r_dl1.accp,l_dat1,l_dat2)/100 into ODP_q, OKP_q from dual;

 select -rez.ostc96(r_dl1.accp,l_dat31)/100 into SP_31 from dual;
 ---select -fost_q(r_dl1.accp,l_dat31,l_dat31)/100 into SP_31Q from dual;
 select gl.p_icurval(k.kv,SP_31,l_dat31) into SP_31Q from dual;

else
 SP_:=0; SP_Q:=0; ODP_:=0; OKP_:=0; ODP_q:=0; OKP_q:=0;
 SP_31:=0; SP_31Q:=0;
end if;

 if 1=2      -- *
        and k.ref_new is not null and r_dl2.accp is not null then
 select fdos(r_dl2.accp,l_dat1,l_dat2)/100,
        fkos(r_dl2.accp,l_dat1,l_dat2)/100 into ODP_N, OKP_N from dual;
 select fost(r_dl2.accp,l_dat2)/100 into SP_N from dual;
 select fdosn(l_kv,r_dl2.accp,l_dat1,l_dat2)/100,
        fkosn(l_kv,r_dl2.accp,l_dat1,l_dat2)/100 into ODP_Nq, OKP_Nq from dual;
 ---select fost_q(r_dl2.accp,l_dat2,l_dat2)/100 into SP_NQ from dual;
 else
 ODP_N:=0; OKP_N:=0; SP_N:=0;  ODP_Nq:=0; OKP_Nq:=0; SP_NQ:=0;
 end if;

 if 1=2
        and r_dl1.accp is not null then
 select Nvl(sum(decode(o.dk,0,1,0)*o.s),0)/100, Nvl(sum(decode(o.dk,0,1,0)*o.sq),0)/100,
        Nvl(sum(decode(o.dk,0,0,1)*o.s),0)/100, Nvl(sum(decode(o.dk,0,0,1)*o.sq),0)/100
                into ODP_K, ODP_KQ, OKP_K, OKP_KQ
                from opldok o, oper p
                where p.ref = o.ref and o.sos=5 and o.fdat >= l_dat1  --to_date('01/01/2012','dd/mm/yyyy')
                 and p.vdat >= l_dat1 and o.tt in ('FXH','FXH')
                 and o.acc = r_dl1.accp;
 else
 ODP_K:=0; ODP_KQ:=0; OKP_K:=0; OKP_KQ:=0;
 end if;

 if 1=2     -- *
        and k.ref_new is not null and r_dl2.accp is not null then
 select Nvl(sum(decode(o.dk,0,1,0)*o.s),0)/100, Nvl(sum(decode(o.dk,0,1,0)*o.sq),0)/100,
        Nvl(sum(decode(o.dk,0,0,1)*o.s),0)/100, Nvl(sum(decode(o.dk,0,0,1)*o.sq),0)/100
                into ODP_K_new, ODP_KQ_new, OKP_K_new, OKP_KQ_new
                from opldok o, oper p
                where p.ref = o.ref and o.sos=5 and o.fdat >= l_dat2  --to_date('01/01/2012','dd/mm/yyyy')
                 and p.vdat >= l_dat1 and o.tt in ('FXH','FXH')
                 and o.acc = r_dl2.accp;
 else
 ODP_K_new:=0; ODP_KQ_new:=0; OKP_K_new:=0; OKP_KQ_new:=0;
 end if;

if k.ref_new is not null and r_dl2.accp is not null then
select Nvl(sum(decode(o.dk,0,1,0)*o.s),0)/100, Nvl(sum(decode(o.dk,0,1,0)*o.sq),0)/100,
       Nvl(sum(decode(o.dk,0,0,1)*o.s),0)/100, Nvl(sum(decode(o.dk,0,0,1)*o.sq),0)/100
                into S_ODP_new, S_ODP_Q_new, S_OKP_new, s_OKP_Q_new
                from opldok o, oper p
                where p.ref = o.ref and o.sos=5 and o.fdat = l_dat_pr  --l_dat2   --to_date('01/01/2012','dd/mm/yyyy')
                 and p.vdat = l_dat_pr  --l_dat2    -- and o.tt  in ('FXH','FXH')
                 and o.ref!=k.ref_new
                 and o.acc = r_dl2.accp;
else
S_ODP_new:=0; S_ODP_Q_new:=0; S_OKP_new:=0; S_OKP_Q_new:=0;
end if;


  ODP_:=ODP_-ODP_P;  OKP_:=OKP_-OKP_P;
  ODP_q:=ODP_q-ODP_Pq;  OKP_q:=OKP_q-OKP_Pq;

 SP_N:= SP_N + s_odp_new - s_okp_new + odp_k_new - okp_k_new;
 SP_Nq:= SP_Nq + s_odp_q_new - s_okp_q_new + odp_kq_new - okp_kq_new;

                               /***
 begin
 insert into tmp_cp_obu7
 (id,isin,kv,dat_p,    nls,nms,vid_r,pap,   ref,ost_v, ost_vq,
  S_D, S_C,   S_DK, S_CK,
  nls_p, OST_P, OST_PQ, s_dp, s_cp,   --nms_p,
  s_dp_new, s_cp_new, s_dk_new, s_ck_new,
  s_dpq_new, s_cpq_new, s_dkq_new, s_ckq_new,
  nls_p1, nls_s,
  S_Dq, S_Cq, S_DPq, S_CPq,  S_DKq, S_CKq,
  nbs_new, nbs_old, pf_new, ost_v31, ost_vt,
  P0, P1, P2, P31, P4,
  ref2,userid,dat_k,dat_r)
 values
 (k.id,k.cp_id,l_kv,l_dat2, k.NLSP,k.nms_p,'P',k.pap_p,k.ref, SP_, SP_Q,
  ODP_,OKP_, ODP_K, OKP_K,
  l_nls_p2, SP_N, SP_NQ, ODP_P, OKP_P, --l_nms_p2,
  odp_p_new, okp_p_new, odp_k_new, okp_k_new,
  odp_pq_new, okp_pq_new, odp_kq_new, okp_kq_new,
  l_nls_p2, r_dl2.accp,
  ODP_q, OKP_q, ODP_Pq, OKP_Pq, ODP_Kq, OKP_Kq,
  --substr(l_nls_p2,1,4),
  decode(r_dl2.accp,NULL,decode(r_dl2.accd,NULL,substr(l_nls_s2,1,4),substr(l_nls_d2,1,4)),substr(l_nls_p2,1,4)),
 -- substr(k.nlsp,1,4),
  decode(r_dl1.accp,NULL,decode(r_dl1.accd,NULL,decode(r_dl1.accs,NULL,NULL,substr(k.nlss,1,4)), substr(k.nlsd,1,4)),substr(k.nlsp,1,4) ),
  null,    ---k.pf_new,
  SP_31, k.SP,
  77.5, 88.5, 9.5, SP_31, k.SP,
  l_ref_pr,l_userid,
  l_dat_k,t_dat);
 exception when others then NULL;
 LOG('CP_OBU error P ID='||k.cp_id||' '||k.ref,'ERROR',0);
 end;
                 ***/
end if;   -- P
                                   /*****
               -- virt P
 SPV_:=0; SPV_q:=0; ODPV_:=0; OKPV_:=0; ODPV_q:=0; OKPV_q:=0;
 ODPV_P:=0; ODPV_PQ:=0; OKPV_P:=0; OKPV_PQ:=0;

 SPV_N:=0; ODPV_N:=0; OKPV_N:=0;  SPV_Nq:=0; ODPV_Nq:=0; OKPV_Nq:=0;
 ODPV_K_new:=0; ODPV_KQ_new:=0; OKPV_K_new:=0; OKPV_KQ_new:=0;
 ODPV_P_new:=0; ODPV_PQ_new:=0; OKPV_P_new:=0; OKPV_PQ_new:=0;

if accp_v is not null or accp_vn is not null  then
 if accp_v is not null then
 select fost(accp_v,l_dat1)/100 into SPV_ from dual;
 ---select fost_q(accp_v,l_dat1,l_dat1)/100 into SPV_q from dual;
  --  потрібно по OPLDOK з аналізом TT
 select fdos(accp_v,l_dat1,l_dat2)/100,
        fkos(accp_v,l_dat1,l_dat2)/100 into ODPV_, OKPV_ from dual;
 select fdosn(l_kv,accp_v,l_dat1,l_dat2)/100,
        fkosn(l_kv,accp_v,l_dat1,l_dat2)/100 into ODPV_q, OKPV_q from dual;

 select Nvl(sum(decode(o.dk,0,1,0)*o.s),0)/100, Nvl(sum(decode(o.dk,0,1,0)*o.sq),0)/100,
        Nvl(sum(decode(o.dk,0,0,1)*o.s),0)/100, Nvl(sum(decode(o.dk,0,0,1)*o.sq),0)/100
                into ODPV_P, ODPV_PQ, OKPV_P, OKPV_PQ
                from opldok o
                where o.ref = k.ref_new and acc = accp_v;
 else
 SPV_:=0; SPV_q:=0; ODPV_:=0; OKPV_:=0; ODPV_q:=0; OKPV_q:=0;
 ODPV_P:=0; ODPV_PQ:=0; OKPV_P:=0; OKPV_PQ:=0;
 end if;
 if accp_vn is not null then
 select fost(accp_vn,l_dat2)/100 into SPV_n from dual;
 select fdos(accp_vn,l_dat1,l_dat2)/100,
        fkos(accp_vn,l_dat1,l_dat2)/100 into ODPV_N, OKPV_N from dual;
 ---select fost_q(accp_vn,l_dat2,l_dat2)/100 into SPV_nq from dual;
 select fdosn(l_kv,accp_vn,l_dat1,l_dat2)/100,
        fkosn(l_kv,accp_vn,l_dat1,l_dat2)/100 into ODPV_Nq, OKPV_Nq from dual;

select Nvl(sum(decode(o.dk,0,1,0)*o.s),0)/100, Nvl(sum(decode(o.dk,0,1,0)*o.sq),0)/100,
       Nvl(sum(decode(o.dk,0,0,1)*o.s),0)/100, Nvl(sum(decode(o.dk,0,0,1)*o.sq),0)/100
                into ODPV_K_new, ODPV_KQ_new, OKPV_K_new, OKPV_KQ_new
                from opldok o, oper p
                where p.ref = o.ref and o.sos=5 and o.fdat >= to_date('01/01/2012','dd/mm/yyyy')
                 and p.vdat >= l_dat1 and o.tt in ('FXH','FXH')
                 and o.acc = accp_vn;

select Nvl(sum(decode(o.dk,0,1,0)*o.s),0)/100, Nvl(sum(decode(o.dk,0,1,0)*o.sq),0)/100,
       Nvl(sum(decode(o.dk,0,0,1)*o.s),0)/100, Nvl(sum(decode(o.dk,0,0,1)*o.sq),0)/100
                into ODPv_P_new, ODPv_PQ_new, OKPv_P_new, OKPv_PQ_new
                from opldok o
                where o.ref = k.ref_new and acc = accp_vn;
 else
 SPV_N:=0; ODPV_N:=0; OKPV_N:=0;  SPV_Nq:=0; ODPV_Nq:=0; OKPV_Nq:=0;
 ODPV_K_new:=0; ODPV_KQ_new:=0; OKPV_K_new:=0; OKPV_KQ_new:=0;
 ODPV_P_new:=0; ODPV_PQ_new:=0; OKPV_P_new:=0; OKPV_PQ_new:=0;
 end if; --

 ODPV_:=ODPV_-ODPV_P;  OKPV_:=OKPV_-OKPV_P;
 ODPV_q:=ODPV_q-ODPV_Pq;  OKPV_q:=OKPV_q-OKPV_Pq;

 begin
 insert into tmp_cp_obu7
 (id,isin,kv,dat_p,    nls,nms,vid_r,pap,   ref,ost_v, ost_vq,
  S_D, S_C,
  S_DK, S_CK,
  nls_p, OST_P, OST_PQ, s_dp, s_cp,  --nms_p,
  s_dp_new, s_cp_new, s_dk_new, s_ck_new,
  s_dpq_new, s_cpq_new, s_dkq_new, s_ckq_new,
  nls_p1, nls_s,
  S_Dq, S_Cq, S_DPq, S_CPq,  S_DKq, S_CKq,
  nbs_new, nbs_old, pf_new,
  ref2,userid)
 values
 (k.id,k.cp_id,l_kv,l_dat2, NLS_V,nms_v,'PV',pap_v,k.ref,  SPV_, SPV_Q,
  ODPV_, OKPV_,
  ODPV_K, OKPV_K,
  nls_vn, SPV_N, SPV_NQ, ODPV_P, OKPV_P,     -- nms_vn,
  odpv_p_new, okpv_p_new, ODPV_K_new, OKPV_K_new,
  odpv_pq_new, okpv_pq_new, ODPV_Kq_new, OKPV_Kq_new,
  nls_vn, accp_vn,
  ODPV_q, OKPV_q, ODPV_Pq, OKPV_Pq, ODPV_Kq, OKPV_Kq,
  substr(nls_Vn,1,4),
  substr(nls_v,1,4), null,       ---k.pf_new,
  k.ref_new,l_userid);
 exception when others then NULL;
 LOG('CP_OBU error PV ID='||k.cp_id||' '||k.ref,'ERROR',0);
 end;

end if;   -- virt P
                                     **********/
 -- ==========
 SPV_N:=0; ODPV_N:=0; OKPV_N:=0;  SPV_Nq:=0; ODPV_Nq:=0; OKPV_Nq:=0;
 ODPV_K_new:=0; ODPV_KQ_new:=0; OKPV_K_new:=0; OKPV_KQ_new:=0;
 ODPV_P_new:=0; ODPV_PQ_new:=0; OKPV_P_new:=0; OKPV_PQ_new:=0;

 SPV_:=0; SPV_q:=0; ODPV_:=0; OKPV_:=0; ODPV_q:=0; OKPV_q:=0;
 ODPV_P:=0; ODPV_PQ:=0; OKPV_P:=0; OKPV_PQ:=0;

 ---========
-- ODPV_q:= t_ost_n; OKPV_q:= t_ost_d; ODPV_Pq:= t_ost_p;
-- OKPV_Pq:= t_ost_r; ODPV_Kq:= t_ost_r2; OKPV_Kq:= t_ost_s;
                    /***
 begin
 insert into tmp_cp_obu7
 (id,isin,kv,dat_p,    nls,nms,vid_r,pap,   ref,ost_v, ost_vq,
  S_D, S_C,
  S_DK, S_CK,
  nls_p, OST_P, OST_PQ, s_dp, s_cp,  --nms_p,
  s_dp_new, s_cp_new, s_dk_new, s_ck_new,
  s_dpq_new, s_cpq_new, s_dkq_new, s_ckq_new,
  nls_p1, nls_s,
  S_Dq, S_Cq, S_DPq, S_CPq,  S_DKq, S_CKq,
  nbs_new, nbs_old, pf_new,
  ref2,userid,
  dat_k,dat_r)
 values
 (k.id,k.cp_id,l_kv,l_dat_pr, NLS_V,nms_v,'PV',pap_v,k.ref,  SPV_, SPV_Q,
  ODPV_, OKPV_,
  ODPV_K, OKPV_K,
  nls_vn, SPV_N, SPV_NQ, ODPV_P, OKPV_P, --nms_vn,
  odpv_p_new, okpv_p_new, ODPV_K_new, OKPV_K_new,
  odpv_pq_new, okpv_pq_new, ODPV_Kq_new, OKPV_Kq_new,
  nls_vn, accp_vn,
  ODPV_q, OKPV_q, ODPV_Pq, OKPV_Pq, ODPV_Kq, OKPV_Kq,
  substr(nls_Vn,1,4),
  substr(nls_v,1,4), null,     ---k.pf_new,
  l_ref_pr,l_userid,
  l_dat_k,t_dat);    -- k.ref_new

 exception when others then NULL;
 LOG('CP_OBU error PV ID='||k.cp_id||' '||k.ref,'ERROR',0);
 end;
                        ***/
  --- ================
 SR_31:=0; SR_31Q:=0;
 ODR_:=0; OKR_:=0; SR_:=0;   ODR_q:=0; OKR_q:=0; SR_Q:=0;

 ODR_N:=0; OKR_N:=0; SR_N:=0;   ODR_Nq:=0; OKR_Nq:=0; SR_NQ:=0;
 ODR_K:=0; ODR_KQ:=0; OKR_K:=0; OKR_KQ:=0;
 ODR_5:=0; ODR_5Q:=0;
 S_ODR_new:=0; S_ODR_Q_new:=0; S_OKR_new:=0; S_OKR_Q_new:=0;

if r_dl1.accr is not null or r_dl2.accr is not null then
 if r_dl1.accr is not null then
        SR_:=5; SR_Q:=5.5;
 select -rez.ostc96(r_dl1.accr,l_dat1131)/100 into SR_ from dual;
 ---select -fost_q(r_dl1.accr,l_dat1131,l_dat1131)/100 into SR_Q from dual;
 select gl.p_icurval(k.kv,SR_,l_dat1131) into SR_Q from dual;
  --  потрібно по OPLDOK з аналізом TT
 select fdos(r_dl1.accr,l_dat1,l_dat2)/100,
        fkos(r_dl1.accr,l_dat1,l_dat2)/100 into ODR_, OKR_ from dual;
 select fdosn(l_kv,r_dl1.accr,l_dat1,l_dat2)/100,
        fkosn(l_kv,r_dl1.accr,l_dat1,l_dat2)/100 into ODR_q, OKR_q from dual;

 select -rez.ostc96(r_dl1.accr,l_dat31)/100 into SR_31 from dual;
 ---select -fost_q(r_dl1.accr,l_dat31,l_dat31)/100 into SR_31Q from dual;
 select gl.p_icurval(k.kv,SR_31,l_dat31) into SR_31Q from dual;

 begin
 select acr_dat into l_dat_ir
 from int_accn where acc=r_dl1.accr and id=1 and metr=4;
 exception when others then NULL;  l_dat_ir:=null;
 end;

 else
 ODR_:=0; OKR_:=0; SR_:=0;   ODR_q:=0; OKR_q:=0; SR_Q:=0;
 SR_31:=0; SR_31Q:=0;
 end if;

 if k.ref_new is not null and r_dl2.accr is not null then
    SR_N:=5.1; SR_NQ:=5.2;
 select fdos(r_dl2.accr,l_dat1,l_dat2)/100,
        fkos(r_dl2.accr,l_dat1,l_dat2)/100 into ODR_N, OKR_N from dual;
 select fost(r_dl2.accr,l_dat2)/100 into SR_N from dual;
 select fdosn(l_kv,r_dl2.accr,l_dat1,l_dat2)/100,
        fkosn(l_kv,r_dl2.accr,l_dat1,l_dat2)/100 into ODR_Nq, OKR_Nq from dual;
 ---select fost_q(r_dl2.accr,l_dat2,l_dat2)/100 into SR_NQ from dual;
 else
 ODR_N:=0; OKR_N:=0; SR_N:=0;   ODR_Nq:=0; OKR_Nq:=0; SR_NQ:=0;
 end if;

 if r_dl1.accr is not null then
 select Nvl(sum(decode(o.dk,0,1,0)*o.s),0)/100, Nvl(sum(decode(o.dk,0,1,0)*o.sq),0)/100,
       Nvl(sum(decode(o.dk,0,0,1)*o.s),0)/100, Nvl(sum(decode(o.dk,0,0,1)*o.sq),0)/100
                into ODR_K, ODR_KQ, OKR_K, OKR_KQ
                from opldok o, oper p
                where p.ref = o.ref and o.sos=5 and o.fdat >= to_date('01/01/2012','dd/mm/yyyy')
                 and p.vdat >= l_dat1 and o.tt in ('FXH','FXH')
                 and o.acc = r_dl1.accr;
 else
 ODR_K:=0; ODR_KQ:=0; OKR_K:=0; OKR_KQ:=0;
 end if;

 if k.ref_new is not null and r_dl2.accr is not null then
 select Nvl(sum(decode(o.dk,0,1,0)*o.s),0)/100, Nvl(sum(decode(o.dk,0,1,0)*o.sq),0)/100,
       Nvl(sum(decode(o.dk,0,0,1)*o.s),0)/100, Nvl(sum(decode(o.dk,0,0,1)*o.sq),0)/100
                into ODR_K_new, ODR_KQ_new, OKR_K_new, OKR_KQ_new
                from opldok o, oper p
                where p.ref = o.ref and o.sos=5 and o.fdat >= to_date('01/01/2012','dd/mm/yyyy')
                 and p.vdat >= l_dat1 and o.tt in ('FXH','FXH')
                 and o.acc = r_dl2.accr;

   --  нараховані  %-ти по NEW R в день переклас-ії
 select Nvl(sum(decode(o.dk,0,1,0)*o.s),0)/100, Nvl(sum(decode(o.dk,0,1,0)*o.sq),0)/100
  --   Nvl(sum(decode(o.dk,0,0,1)*o.s),0)/100, Nvl(sum(decode(o.dk,0,0,1)*o.sq),0)/100
                into ODR_5, ODR_5Q   --, OKR_5, OKR_5Q
                from opldok o, oper p
                where p.ref = o.ref and o.sos=5 and o.fdat >= to_date('01/01/2012','dd/mm/yyyy')
                 and p.vdat = l_dat2 and o.tt in ('FXU','FXU')
                 and o.acc = r_dl2.accr;
 else
 ODR_K_new:=0; ODR_KQ_new:=0; OKR_K_new:=0; OKR_KQ_new:=0;
 ODR_5:=0; ODR_5Q:=0;
 end if;

if k.ref_new is not null and r_dl2.accr is not null then
select Nvl(sum(decode(o.dk,0,1,0)*o.s),0)/100, Nvl(sum(decode(o.dk,0,1,0)*o.sq),0)/100,
       Nvl(sum(decode(o.dk,0,0,1)*o.s),0)/100, Nvl(sum(decode(o.dk,0,0,1)*o.sq),0)/100
                into S_ODR_new, S_ODR_Q_new, S_OKR_new, s_OKR_Q_new
                from opldok o, oper p
                where p.ref = o.ref and o.sos=5 and o.fdat = l_dat2         --to_date('01/01/2012','dd/mm/yyyy')
                 and p.vdat = l_dat2        --     and o.tt  in ('FXH','FXH')
                 and o.ref!=k.ref_new
                 and o.acc = r_dl2.accr;
else
S_ODR_new:=0; S_ODR_Q_new:=0; S_OKR_new:=0; S_OKR_Q_new:=0;
end if;


   ODR_:=ODR_-ODR_P;  OKR_:=OKR_-OKR_P;
   ODR_q:=ODR_q-ODR_Pq;  OKR_q:=OKR_q-OKR_Pq;
 --  SR_N:= SR_N - (-ODR_5);  SR_Nq:= SR_Nq - (-ODR_5q);

 SR_N:= SR_N + s_odr_new - s_okr_new + odr_k_new - okr_k_new;
 SR_Nq:= SR_Nq + s_odr_q_new - s_okr_q_new + odr_kq_new - okr_kq_new;

                            /***
 begin
 insert into tmp_cp_obu7
 (id,isin,kv,dat_p,    nls,nms,vid_r,pap,   ref,ost_v, ost_vq,
  S_D, S_C,   S_DK, S_CK,
  nls_p, OST_P, OST_PQ, s_dp, s_cp,   --nms_p,
  s_dp_new, s_cp_new, s_dk_new, s_ck_new,
  s_dpq_new, s_cpq_new, s_dkq_new, s_ckq_new,
  nls_p1, nls_s,
  S_Dq, S_Cq, S_DPq, S_CPq,  S_DKq, S_CKq,
  nbs_new, nbs_old, pf_new,  ost_v31, ost_vt,
  R0, R1, R2, R31, R4,
  ref2,userid,dat_k,dat_r)
 values
 (k.id,k.cp_id,l_kv,l_dat2,  k.NLSR,k.nms_r,'R',k.pap_r,k.ref, SR_, SR_Q,
  ODR_, OKR_, ODR_K, OKR_K,
  l_nls_r2, SR_N, SR_NQ, ODR_P, OKR_P, --l_nms_r2,
  odr_p_new, okr_p_new, odr_k_new, okr_k_new,
  odr_pq_new, okr_pq_new, odr_kq_new, okr_kq_new,
  l_nls_r2, r_dl2.accr,
  ODR_q, OKR_q, ODR_Pq, OKR_Pq, ODR_Kq, OKR_Kq,
  substr(l_nls_r2,1,4), substr(k.nlsr,1,4), null,    ---k.pf_new,
  SR_31, k.SR,
  77, SR_, 88, SR_31, k.SR,
  l_ref_pr,l_userid,
  l_dat_k,t_dat);
 exception when others then NULL;
 LOG('CP_OBU error R ID='||k.cp_id||' '||k.ref,'ERROR',0);
 end;
               ***/
end if;   -- R

 SR2_31:=0; SR2_31Q:=0;
 ODR2_N:=0; OKR2_N:=0; SR2_N:=0; ODR2_Nq:=0; OKR2_Nq:=0; SR2_Nq:=0;
 ODR2_K:=0; ODR2_KQ:=0; OKR2_K:=0; OKR2_KQ:=0;
 S_ODR2_new:=0; S_ODR2_Q_new:=0; S_OKR2_new:=0; S_OKR2_Q_new:=0;

if r_dl1.accr2 is not null then

 select -rez.ostc96(r_dl1.accr2,l_dat1131)/100 into SR2_ from dual;
 ---select -fost_q(r_dl1.accr2,l_dat1131,l_dat1131)/100 into SR2_q from dual;
 select gl.p_icurval(k.kv,SR2_,l_dat1131) into SR2_Q from dual;
  --  потрібно по OPLDOK з аналізом TT
 select fdos(r_dl1.accr2,l_dat1,l_dat2)/100,
        fkos(r_dl1.accr2,l_dat1,l_dat2)/100 into ODR2_, OKR2_ from dual;
 select fdosn(l_kv,r_dl1.accr2,l_dat1,l_dat2)/100,
        fkosn(l_kv,r_dl1.accr2,l_dat1,l_dat2)/100 into ODR2_q, OKR2_q from dual;

 select -rez.ostc96(r_dl1.accr2,l_dat31)/100 into SR2_31 from dual;
 ---select -fost_q(r_dl1.accr2,l_dat31,l_dat31)/100 into SR2_31Q from dual;
 select gl.p_icurval(k.kv,SR2_31,l_dat31) into SR2_31Q from dual;

 if k.ref_new is not null and r_dl2.accr2 is not null then
 select fdos(r_dl2.accr2,l_dat1,l_dat2)/100,
        fkos(r_dl2.accr2,l_dat1,l_dat2)/100 into ODR2_N, OKR2_N from dual;
 select fost(r_dl2.accr2,l_dat2)/100 into SR2_N from dual;
 select fdosn(l_kv,r_dl2.accr2,l_dat1,l_dat2)/100,
        fkosn(l_kv,r_dl2.accr2,l_dat1,l_dat2)/100 into ODR2_Nq, OKR2_Nq from dual;
 ---select fost_q(r_dl2.accr2,l_dat2,l_dat2)/100 into SR2_Nq from dual;
 else
 ODR2_N:=0; OKR2_N:=0; SR2_N:=0; ODR2_Nq:=0; OKR2_Nq:=0; SR2_Nq:=0;
 end if;

if r_dl1.accr2 is not null then
select Nvl(sum(decode(o.dk,0,1,0)*o.s),0)/100, Nvl(sum(decode(o.dk,0,1,0)*o.sq),0)/100,
       Nvl(sum(decode(o.dk,0,0,1)*o.s),0)/100, Nvl(sum(decode(o.dk,0,0,1)*o.sq),0)/100
                into ODR2_K, ODR2_KQ, OKR2_K, OKR2_KQ
                from opldok o, oper p
                where p.ref = o.ref and o.sos=5 and o.fdat >= to_date('01/01/2012','dd/mm/yyyy')
                 and p.vdat >= l_dat1 and o.tt in ('FXH','FXH')
                 and o.acc = r_dl1.accr2;
else
ODR2_K:=0; ODR2_KQ:=0; OKR2_K:=0; OKR2_KQ:=0;
end if;


if k.ref_new is not null and r_dl2.accr2 is not null then
select Nvl(sum(decode(o.dk,0,1,0)*o.s),0)/100, Nvl(sum(decode(o.dk,0,1,0)*o.sq),0)/100,
       Nvl(sum(decode(o.dk,0,0,1)*o.s),0)/100, Nvl(sum(decode(o.dk,0,0,1)*o.sq),0)/100
                into ODR2_K_new, ODR2_KQ_new, OKR2_K_new, OKR2_KQ_new
                from opldok o, oper p
                where p.ref = o.ref and o.sos=5 and o.fdat >= to_date('01/01/2012','dd/mm/yyyy')
                 and p.vdat >= l_dat1 and o.tt in ('FXH','FXH')
                 and o.acc = r_dl2.accr2;
else
ODR2_K_new:=0; ODR2_KQ_new:=0; OKR2_K_new:=0; OKR2_KQ_new:=0;
end if;

if k.ref_new is not null and r_dl2.accr2 is not null then
select Nvl(sum(decode(o.dk,0,1,0)*o.s),0)/100, Nvl(sum(decode(o.dk,0,1,0)*o.sq),0)/100,
       Nvl(sum(decode(o.dk,0,0,1)*o.s),0)/100, Nvl(sum(decode(o.dk,0,0,1)*o.sq),0)/100
                into S_ODR2_new, S_ODR2_Q_new, S_OKR2_new, s_OKR2_Q_new
                from opldok o, oper p
                where p.ref = o.ref and o.sos=5 and o.fdat = l_dat2         --to_date('01/01/2012','dd/mm/yyyy')
                 and p.vdat = l_dat2
                 and o.ref!=k.ref_new
                 and o.acc = r_dl2.accr2;
else
S_ODR2_new:=0; S_ODR2_Q_new:=0; S_OKR2_new:=0; S_OKR2_Q_new:=0;
end if;


  ODR2_:=ODR2_-ODR2_P;  OKR2_:=OKR2_-OKR2_P;
  ODR2_q:=ODR2_q-ODR2_Pq;  OKR2_q:=OKR2_q-OKR2_Pq;

 SR2_N:= SR2_N + s_odr2_new - s_okr2_new + odr2_k_new - okr2_k_new;
 SR2_Nq:= SR2_Nq + s_odr2_q_new - s_okr2_q_new + odr2_kq_new - okr2_kq_new;

                 /***
 begin
 insert into tmp_cp_obu7
 (id,isin,kv,dat_p,    nls,nms,vid_r,pap,   ref,ost_v, ost_vq,
  S_D, S_C,   S_DK, S_CK,
  nls_p, OST_P, OST_PQ, s_dp, s_cp,  --nms_p,
  s_dp_new, s_cp_new, s_dk_new, s_ck_new,
  s_dpq_new, s_cpq_new, s_dkq_new, s_ckq_new,
  nls_p1, nls_s,
  S_Dq, S_Cq, S_DPq, S_CPq,  S_DKq, S_CKq,
  nbs_new, nbs_old, pf_new,  ost_v31, ost_vt,
  ref2,userid,dat_k,dat_r)
 values
 (k.id,k.cp_id,l_kv,l_dat2, k.NLSR2,k.nms_r2,'R2',k.pap_r2,k.ref, SR2_, SR2_Q,
  ODR2_, OKR2_, ODR2_K, OKR2_K,
 l_nls_r22, SR2_N, SR2_NQ, ODR2_P, OKR2_P, --l_nms_r22,
 odr2_p_new, okr2_p_new, odr2_k_new, okr2_k_new,
 odr2_pq_new, okr2_pq_new, odr2_kq_new, okr2_kq_new,
 l_nls_r22, r_dl2.accr2,
 ODR2_q, OKR2_q, ODR2_Pq, OKR2_Pq, ODR2_Kq, OKR2_Kq,
 substr(l_nls_r22,1,4), substr(k.nlsr2,1,4), null,   ---k.pf_new,
 SR2_31, k.SR2,
 l_ref_pr,l_userid,
 l_dat_k,t_dat);
 exception when others then NULL;
 LOG('CP_OBU error R2 ID='||k.cp_id||' '||k.ref,'ERROR',0);
 end;
                ***/
end if;  -- R2

 SS_31:=0; ss_31q:=0;
 SS_:=0; SS_q:=0; ODS_:=0; OKS_:=0; ODS_q:=0; OKS_q:=0;
 ODS_N:=0; OKS_N:=0; SS_N:=0;   ODS_Nq:=0; OKS_Nq:=0; SS_Nq:=0;
 ODS_K:=0; ODS_KQ:=0; OKS_K:=0; OKS_KQ:=0;
 ODS_K_new:=0; ODS_KQ_new:=0; OKS_K_new:=0; OKS_KQ_new:=0;
 S_ODS_new:=0; S_ODS_Q_new:=0; S_OKS_new:=0; S_OKS_Q_new:=0;

if r_dl1.accs is not null or r_dl2.accs is not null then
 if r_dl1.accs is not null then
 select -rez.ostc96(r_dl1.accs,l_dat1131)/100 into SS_ from dual;
 ---select -fost_q(r_dl1.accs,l_dat1131,l_dat1131)/100 into SS_q from dual;
 select gl.p_icurval(k.kv,SS_,l_dat1131) into SS_Q from dual;
  --  потрібно по OPLDOK з аналізом TT
 select fdos(r_dl1.accs,l_dat1,l_dat2)/100,
        fkos(r_dl1.accs,l_dat1,l_dat2)/100 into ODS_, OKS_ from dual;
 select fdosn(l_kv,r_dl1.accs,l_dat1,l_dat2)/100,
        fkosn(l_kv,r_dl1.accs,l_dat1,l_dat2)/100 into ODS_q, OKS_q from dual;

 select -rez.ostc96(r_dl1.accs,l_dat31)/100 into SS_31 from dual;
 ---select -fost_q(r_dl1.accs,l_dat31,l_dat31)/100 into SS_31Q from dual;
 select gl.p_icurval(k.kv,SS_31,l_dat31) into SS_31Q from dual;

 else
 SS_:=0; SS_q:=0; ODS_:=0; OKS_:=0; ODS_q:=0; OKS_q:=0;
 SS_31:=0; SS_31Q:=0;
 end if;
 if k.ref_new is not null and r_dl2.accs is not null then
 select fdosn(l_kv,r_dl2.accs,l_dat1,l_dat2)/100,
        fkosn(l_kv,r_dl2.accs,l_dat1,l_dat2)/100 into ODS_Nq, OKS_Nq from dual;
 select fost(r_dl2.accs,l_dat2)/100 into SS_N from dual;
 select fdos(r_dl2.accs,l_dat1,l_dat2)/100,
        fkos(r_dl2.accs,l_dat1,l_dat2)/100 into ODS_N, OKS_N from dual;
 ---select fost_q(r_dl2.accs,l_dat2,l_dat2)/100 into SS_Nq from dual;
 else
 ODS_N:=0; OKS_N:=0; SS_N:=0;   ODS_Nq:=0; OKS_Nq:=0; SS_Nq:=0;
 end if;

 if r_dl1.accs is not null then
 select Nvl(sum(decode(o.dk,0,1,0)*o.s),0)/100, Nvl(sum(decode(o.dk,0,1,0)*o.sq),0)/100,
        Nvl(sum(decode(o.dk,0,0,1)*o.s),0)/100, Nvl(sum(decode(o.dk,0,0,1)*o.sq),0)/100
                into ODS_K, ODS_KQ, OKS_K, OKS_KQ
                from opldok o, oper p
                where p.ref = o.ref and o.sos=5 and o.fdat >= to_date('01/01/2012','dd/mm/yyyy')
                 and p.vdat >= l_dat1 and o.tt in ('FXH','FXH')
                 and o.acc = r_dl1.accs;
 else
 ODS_K:=0; ODS_KQ:=0; OKS_K:=0; OKS_KQ:=0;
 end if;

 if k.ref_new is not null and r_dl2.accs is not null then
 select Nvl(sum(decode(o.dk,0,1,0)*o.s),0)/100, Nvl(sum(decode(o.dk,0,1,0)*o.sq),0)/100,
       Nvl(sum(decode(o.dk,0,0,1)*o.s),0)/100, Nvl(sum(decode(o.dk,0,0,1)*o.sq),0)/100
                into ODS_K_new, ODS_KQ_new, OKS_K_new, OKS_KQ_new
                from opldok o, oper p
                where p.ref = o.ref and o.sos=5 and o.fdat >= l_dat1  --to_date('01/01/2012','dd/mm/yyyy')
                 and p.vdat >= l_dat1 and o.tt in ('FXH','FXH')
                 and o.acc = r_dl2.accs;
 else
 ODS_K_new:=0; ODS_KQ_new:=0; OKS_K_new:=0; OKS_KQ_new:=0;
 end if;

if k.ref_new is not null and r_dl2.accs is not null then
select Nvl(sum(decode(o.dk,0,1,0)*o.s),0)/100, Nvl(sum(decode(o.dk,0,1,0)*o.sq),0)/100,
       Nvl(sum(decode(o.dk,0,0,1)*o.s),0)/100, Nvl(sum(decode(o.dk,0,0,1)*o.sq),0)/100
                into S_ODS_new, S_ODS_Q_new, S_OKS_new, s_OKS_Q_new
                from opldok o, oper p
                where p.ref = o.ref and o.sos=5 and o.fdat = l_dat2      --to_date('01/01/2012','dd/mm/yyyy')
                 and p.vdat = l_dat2        --     and o.tt  in ('FXH','FXH')
                 and o.ref!=k.ref_new
                 and o.acc = r_dl2.accs;
else
S_ODS_new:=0; S_ODS_Q_new:=0; S_OKS_new:=0; S_OKS_Q_new:=0;
end if;


 ODS_:=ODS_-ODS_P;  OKS_:=OKS_-OKS_P;
 ODS_q:=ODS_q-ODS_Pq;  OKS_q:=OKS_q-OKS_Pq;

 SS_N:= SS_N + s_ods_new - s_oks_new + ods_k_new - oks_k_new;
 SS_Nq:= SS_Nq + s_ods_q_new - s_oks_q_new + ods_kq_new - oks_kq_new;

                         /***
 begin
 insert into tmp_cp_obu7
 (id,isin,kv, dat_p,    nls,nms,vid_r,pap,   ref,ost_v, ost_vq,
  S_D, S_C,
  S_DK, S_CK,
  nls_p, OST_P, OST_PQ, s_dp, s_cp,  --nms_p,
  s_dp_new, s_cp_new, s_dk_new, s_ck_new,
  s_dpq_new, s_cpq_new, s_dkq_new, s_ckq_new,
  nls_p1, nls_s,
  S_Dq, S_Cq, S_DPq, S_CPq,  S_DKq, S_CKq,
  nbs_new, nbs_old, pf_new,  ost_v31, ost_vt,
  ref2,userid,dat_k,dat_r)
 values
 (k.id,k.cp_id,l_kv,l_dat2, k.NLSS,k.nms_s,'S',k.pap_s,k.ref, SS_, SS_Q,
  ODS_,OKS_,
  ODS_K, OKS_K,
  l_nls_s2, SS_N, SS_NQ, ODS_P, OKS_P, --l_nms_s2,
  ods_p_new, oks_p_new, ods_k_new, oks_k_new,
  ods_pq_new, oks_pq_new, ods_kq_new, oks_kq_new,
  l_nls_s2, r_dl2.accs,
  ODS_q, OKS_q, ODS_Pq, OKS_Pq, ODS_Kq, OKS_Kq,
  decode(r_dl2.accs,NULL,decode(r_dl2.accd,NULL,substr(l_nls_p2,1,4),substr(l_nls_d2,1,4)),substr(l_nls_s2,1,4)),
  substr(k.nlss,1,4), null,    ---k.pf_new,
  SS_31, k.SS,
  l_ref_pr,l_userid,
  l_dat_k,t_dat);
 exception when others then NULL;
 LOG('CP_OBU error S ID='||k.cp_id||' '||k.ref,'ERROR',0);
 end;
                             ***/
end if;

 BV_1:=SN_ + SD_ + SP_ + SR_ + SR2_ + SS_;    -- SZ_
 --if nvl(kl1,0)=0 then kl1:=1;  end if;  ---
 cena1:=round(bv_1/nvl(kl1,1),2);
 if nvl(kl1,0)=0 then kl1:=null;  end if;
 if bv_1=0 then cena1:=null; end if;
 BV_31:=SN_31 + SD_31 + SP_31 + SR_31 + SR2_31 + SS_31;    -- SZ_31

 cena_p2:=cena_pr;
   ---
 if (k.dat_k < l_dat1 and  SN_ !=0) or k.dat_k >= l_dat1 then
 begin
 insert into tmp_cp_obu7
 (id, isin, kv, dat_p,  nls,nms, vid_r, pap,  ref, ost_v, ost_vq,
  S_D, S_C,   S_DK, S_CK,
  nls_p, OST_P, ost_pq,
  s_dp, s_cp,   --nms_p,
  s_dp_new, s_cp_new, s_dk_new, s_ck_new,
  s_dpq_new, s_cpq_new, s_dkq_new, s_ckq_new,
  nls_p1, nls_s,
  S_Dq, S_Cq, S_DPq, S_CPq,  S_DKq, S_CKq,
  nbs_new, nbs_old, pf_new, pf_old,
  ref2,userid,   ost_v31, ost_vt,
  N0, D0, P0, R0,
  N1, N2, N31,
  N4, D4, P4, R4, S4,
  D1, P1, R1, S1,   BV1,
  kl1, kl2,  r2,     kl0, kl31,  kl_k2,
  D31, P31, R31, S31, BV31,
  cena, cena_start, ir,   cena0, cena_p2,  dat_ir,  n2_p,
  dat_k2,  cena_k2,
  d_k, TR1_31,      kl2_p,
  nm_prod, nm_prod2, nm_pok, nm_pok4,
  dat_k,dat_r,dat_pg)
 values
 (k.id, k.cp_id, l_kv, l_dat_pr,      --nvl(l_dat_pr,l_dat2),
  k.nls, k.nms, 'N', k.pap_n, k.ref, SN_, SN_Q,
  ODN_, OKN_, ODN_K, OKN_K,
  l_nls_n2, SN_N, SN_NQ,
  ODN_P, OKN_P,   --l_nms_n2,
  odn_p_new, okn_p_new,  SN_31, kol_n,          --odn_k_new, okn_k_new,
  odn_pq_new, okn_pq_new, odn_kq_new, okn_kq_new,
  l_nls_n2, r_dl2.acc,
  ODN_q, OKN_q, ODN_Pq, OKN_Pq, ODN_Kq, OKN_Kq,
  substr(l_nls_n2,1,4), substr(k.nls,1,4), l_ref5,   ---k.pf_new,
  l_pf2,
  l_ref_pr,l_userid,  SN_31, k.SA,
  n_bay, d_bay, p_bay, r_bay,
  SN_, N2_k, SN_31,
  t_ost_n, t_ost_d, t_ost_p, t_ost_r, t_ost_s,         --k.SA,
  SD_, SP_, SR_+SR2_,  SS_,  BV_1,
  kl1,  kl_p2,  odr_+odr2_,   decode(kl_k,0,kl_k2,kl_k), kl31,   kl_k2,
  SD_31, SP_31, SR_31+SR2_31, SS_31, bv_31,
  cena1, k.cena_start, k.ir, decode(cena0,0,cena_k2,cena0), cena_p2, l_dat_ir, n2_p,
  l_dat_k2,  cena_k2,
  op_pr,  tr_31,  kl_p2,
  nm_pr, nm_pr2, nm_kup, nm_kup4,
  l_dat_k,t_dat,k.dat_pg);    -- k.ref_new
 exception when others then NULL;
 LOG('CP_OBU error N ID='||k.cp_id||' ref='||k.ref,'ERROR',0);
 end;
      /***
 else
 begin
 insert into tmp_cp_obu7
 (id, isin, kv, dat_p,  nls,nms, vid_r, pap,  ref, ost_v, ost_vq)
  values
 (k.id, k.cp_id, l_kv, l_dat_pr,
  k.nls,'*********','N-',k.pap_n,k.ref, SN_, SN_Q);
 exception when others then NULL;
 end;        ***/
 end if;
                           -----
<<EX1>> null;
commit;
end loop;
<<EX2>> null;
--commit;
end;  -- cp_obu
/
show err;

PROMPT *** Create  grants  CP_OBU7 ***
grant EXECUTE                                                                on CP_OBU7         to BARS_ACCESS_DEFROLE;
grant EXECUTE                                                                on CP_OBU7         to CP_ROLE;



PROMPT ===================================================================================== 
PROMPT *** End *** ========== Scripts /Sql/BARS/Procedure/CP_OBU7.sql =========*** End *** =
PROMPT ===================================================================================== 
