CREATE OR REPLACE PROCEDURE BARS.nbu23_sr (P_dat01 DATE)  IS
 
l_nd       number;
l_ostq     number;
l_tip_fip  number;
l_fin      number;
l_fin_okpo number;
l_tip_fin  number;

cust      customer%rowtype;
l_id      nbu23_rez.id%type;
l_pawn    tmp_rez_obesp23.pawn%type;
l_rz      nbu23_rez.rz%type;
l_ddd_6b  nbu23_rez.ddd_6b%type;
l_pd_0    nbu23_rez.pd_0%type;
l_dd      nbu23_rez.dd%type;
l_ddd     nbu23_rez.ddd%type;
l_s080    nbu23_rez.s080%type;
l_emi     cp_kod.emi%type;


l_sdate   date;
l_wdate   date;
l_dat31   date;

l_vkr     varchar2(3);
sdat01_   char(10);

begin
   sdat01_ := to_char( p_DAT01,'dd.mm.yyyy');
   PUL_dat(sdat01_,'');
   l_dat31 := Dat_last_work (p_dat01 -1 );
   for k in (select substr(nls,1,4) nbs_n, 9 tipa, a.*, -ost_korr(acc,l_dat31,null,nbs) ost
             from accounts a
             where  substr(nls,1,4) in ('1415','3115') and nbs is null and -ost_korr(acc,l_dat31,null,nbs) <>0 and tip='SR')
   LOOP
      l_pd_0 := 0;
      l_ostq := p_icurval(k.kv,k.ost,l_dat31)/100;
      k.ost  := k.ost/100;
      begin 
         select cp_ref into l_nd  from cp_accounts c where c.cp_acc = k.acc ;
      EXCEPTION WHEN NO_DATA_FOUND THEN l_nd := null; 
      end;
      begin 
         select * into cust from customer where rnk = k.rnk;
      EXCEPTION WHEN NO_DATA_FOUND THEN null;
      end;
      cust.nmk   := substr(cust.nmk,1,35);
      l_id       := 'CACP/'|| l_nd || '/' || k.acc;  
      case  cust.custtype  when 2  then  l_tip_fin := 2;
      else                               l_tip_fin := 1;
      end case;
      l_fin      := f_rnk_maxfin(p_dat01, cust.okpo, l_tip_fin, l_nd, 1);
      l_fin_okpo := f_get_fin_okpo (cust.rnk);
      if l_fin_okpo is not null THEN l_fin := least(l_fin,l_fin_okpo); end if;
      if l_emi in (0,6)       or
         k.nls like '30%'     or
         k.nls like '140%' THEN l_pd_0 := 1; l_fin := 1; 
      end if;
      begin
         select pawn into l_pawn from tmp_rez_obesp23 where dat = p_dat01 and nd = l_nd and pawn = 11 and rownum=1;
      EXCEPTION WHEN NO_DATA_FOUND THEN l_pawn := 0;          
      end;
      if l_pawn = 11 THEN l_pd_0 := 1; l_fin := 1; end if;
      l_s080 := f_get_s080 (p_dat01,l_tip_fin, l_fin);             
      If cust.custtype = 3 and trim(cust.sed) <> '91'  then  l_dd := cust.custtype;
      else                                                   l_dd := 2;
      end if;
      begin
         select ddd into l_ddd from kl_f3_29 where kf='1B' and r020 = k.nbs_n;
      EXCEPTION WHEN NO_DATA_FOUND THEN l_ddd := null;          
      end;  
      if NVL (cust.codcagent, 1) in ('2','4','6') THEN  l_RZ := 2;
      else                                              l_RZ := 1;
      end if;
      begin
         SELECT kk.vncrr, kk.EMI into l_VKR, l_emi
         FROM cp_deal d,  accounts a, CP_KOD KK
         WHERE d.ref = l_nd and D.ID = KK.ID AND (d.acc = a.acc AND KK.DOX > 1    OR     d.accp = a.acc  AND KK.DOX = 1 ); 
      EXCEPTION WHEN NO_DATA_FOUND THEN l_vkr := null;          
      end;  
      l_ddd_6b := f_ddd_6B(k.nbs_n);
      begin
         insert into nbu23_rez  (fdat   , acc   , kv   , nbs    , bv   , bvq   , rez   , rezq    , rnk  , nd  , nls  , fin  , kat, dd  , ddd  , okpo     , nmk     , 
                                 rz     , ob22  , tip  , tipa   , vkr  , id    , s080  , ddd_6b  , custtype     )
                         values (P_dat01, k.acc , k.kv , k.nbs_n, k.ost, l_ostq, 0     , 0       , k.rnk, l_nd, k.nls, l_fin, 1  , l_dd, l_ddd, cust.okpo, cust.nmk, 
                                 l_rz   , k.ob22, k.tip, k.tipa , l_vkr, l_id  , l_s080, l_ddd_6b, cust.custtype);
   exception when others then
   if SQLCODE = -00001 then NULL;
            -- raise_application_error(-20000, 'NBU23_REZ dubl '|| to_char(DAT01_,'dd.mm.yyyy') || ' '|| id23_ );
   else raise;
   end if;
   end;
end LOOP;
commit;
end;
/
show err;

PROMPT *** Create  grants  nbu23_sr ***
grant EXECUTE                                                                on nbu23_sr          to BARS_ACCESS_DEFROLE;
grant EXECUTE                                                                on nbu23_sr          to RCC_DEAL;
grant EXECUTE                                                                on nbu23_sr          to START1;



