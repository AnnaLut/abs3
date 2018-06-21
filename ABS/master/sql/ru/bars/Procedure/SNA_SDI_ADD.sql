CREATE OR REPLACE PROCEDURE BARS.SNA_SDI_ADD (p_DAT01 date ) IS

sna  nbu23_rez%rowtype;
sp   specparam%rowtype; 
rc   rez_cr%rowtype; 

l_dat31  date :=  Dat_last_work (p_dat01 - 1);  -- последний рабочий день мес€ца

begin

   delete from nbu23_rez where fdat = p_dat01 and tip in ('SNA','SDI','SDA','SDM','SDF') and tipa=3;

   for k in ( select 'CCK2/'||n.nd||'/'||a.acc ID, a.rnk, a.nbs,a.kv, n.nd, d.cc_id, a.acc,a.nls,a.branch, -a.ostc/100 bv , decode(trim(c.sed),'91',3,c.custtype) custtype, 
                      f_ddd(a.nbs) ddd, -decode(kv,980,ostc/100,p_icurval(a.kv,ostc,l_dat31)/100) bvq,  d.wdate, d.sdate, c.okpo, substr(c.nmk,1,35) nmk, 
                     DECODE (NVL (c.codcagent, 1), '2', 2, '4', 2, '6', 2, 1) rz, a.ob22, a.tip, 
                     0 rez23, 0 rezq23, 3 tipa,0 ead, 0eadq, 0 cr, 0 crq,3 tip_351
              from accounts a, nd_acc n, cc_deal d, customer c  
              where tip in ('SNA','SDI','SDA','SDM','SDF') and ostc<>0 and a.acc=n.acc and n.nd=d.nd and  a.rnk=c.rnk and nbs not in ('3648','3666'))
   LOOP
      begin 
         select * into rc from rez_cr    where fdat = p_dat01 and nd = k.nd and pd_0 <> 1 and bv > 0 and rownum = 1;
      exception when no_data_found then null;
      end ; 
      begin
         SELECT * into sp FROM specparam WHERE acc  = k.acc; 
      exception when no_data_found then null;
      end ; 

      sna.fdat    := p_dat01;
      --sna.kf      := sys_context('bars_context','user_mfo');
      sna.id      := k.id; 
      sna.rnk     := k.rnk; 
      sna.nbs     := k.nbs;      
      sna.kv      := k.kv;       
      sna.nd      := k.nd;       
      sna.cc_id   := k.cc_id;    
      sna.acc     := k.acc;      
      sna.nls     := k.nls;      
      sna.branch  := k.branch;   
      sna.fin     := rc.fin;
      sna.vkr     := rc.vkr;
      sna.tip_351 := rc.tipa;
      sna.kat     := 1;
      sna.bv      := k.bv;
      sna.bvq     := k.bvq;
      sna.ob22    := k.ob22;
      sna.tip     := k.tip;
      sna.rez     := 0;
      sna.idr     := 0;
      sna.rezq    := 0;
      sna.istval  := 0;
      sna.rez23   := 0;
      sna.ead     := 0;
      sna.rezq23  := 0;
      sna.eadq    := 0;
      sna.cr      := 0;
      sna.crq     := 0;
      sna.custtype:= k.custtype;
      sna.wdate   := k.wdate;
      sna.sdate   := k.sdate;
      sna.okpo    := k.okpo;
      sna.nmk     := k.nmk;
      sna.rz      := k.rz;
      sna.tipa    := k.tipa;
      sna.r013    := sp.r013;
      sna.r011    := sp.r011;
      sna.s180    := sp.s180;

      insert into nbu23_rez  values sna ;               
   end loop;
end;
/
show err;

PROMPT *** Create  grants SNA_SDI_ADD ***
grant EXECUTE       on SNA_SDI_ADD        to BARS_ACCESS_DEFROLE;
grant EXECUTE       on SNA_SDI_ADD        to RCC_DEAL;
grant EXECUTE       on SNA_SDI_ADD        to START1;

        

