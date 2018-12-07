PROMPT ===================================================================================== 
PROMPT *** Run *** ========== Scripts /Sql/BARS/Procedure/P_BPK.sql =========*** Run *** ===
PROMPT ===================================================================================== 


PROMPT *** Create  procedure P_BPK ***

  CREATE OR REPLACE PROCEDURE BARS.P_BPK (p_dat01 date) IS

/* Версия 2.1   29-09-2017  15-03-2017  16-02-2017
   Формирование портфеля БПК на отчетную дату
   -------------------------------------
 3) 29-09-2017(2.1) - Тип счета определяется не через bpk_nbs_tip (Новый план счетов)
 2) 15-03-2017 - w4_acc по условию: NOT_USE_REZ23 is null, bpk_acc: dat_end is null
 1) 10-03-2017 - restr = 0, если не установлены параметры

*/

 w4        v_w4_acc%rowtype ; bpk  v_bbpk_acc%rowtype; L_VKR varchar2(3); l_nbs  accounts.nbs%type; l_ob22  accounts.ob22%type;
 l_acc     accounts.acc%type;
 l_restr   number ;
 l_commit  integer; l_grp integer; l_s250 integer; l_cls  integer;
 l_dat31   date   ;

procedure p_ins_w4 (p_nd    INTEGER, p_kv  number , p_nls    VARCHAR2, p_nbs   CHAR, p_ob22   CHAR   , p_acc INTEGER , p_tip CHAR, p_tip_kart INTEGER, 
                    p_fin23 INTEGER, p_rnk INTEGER, p_sdate  DATE    , p_wdate DATE, p_acc_pk INTEGER, p_vkr varchar2)  is
                                                                                                     
begin
   insert into rez_w4_bpk (nd  , kv  , nls  , nbs  , ob22  , acc  , tip  , tip_kart  , fin23  , rnk  , sdate  , wdate  , acc_pk  , vkr   )
                   values (p_nd, p_kv, p_nls, p_nbs, p_ob22, p_acc, p_tip, p_tip_kart, p_fin23, p_rnk, p_sdate, P_wdate, p_acc_pk, p_VKR ) ;
end p_ins_w4;

BEGIN
   z23.to_log_rez (user_id , 351 , p_dat01 ,'Начало Портфель БПК');
   l_dat31 := Dat_last_work (p_dat01 - 1);  -- последний рабочий день месяца
   pul_dat(to_char(p_dat01,'dd-mm-yyyy'),'');
   delete from rez_w4_bpk;
   l_commit := 0;
   z23.to_log_rez (user_id , 351 , p_dat01 ,'W4_ACC');
   FOR K IN ( SELECT w.* FROM W4_ACC W where NOT_USE_REZ23 is null )
   LOOP
      for s in (select a.acc, a.rnk, a.nbs, a.nls, a.kv, a.ob22,
                       DECODE (ACC, k.ACC_PK  , 'SP ', k.ACC_OVR , 'SS ', k.ACC_9129, 'CR9', k.ACC_9129I, 'CR9', k.ACC_3570 , 'ODB', k.ACC_2208 , 'SN ', k.ACC_2627 , 'SP ', 
                                    k.ACC_2207, 'SP ', k.ACC_3579, 'SK9', k.ACC_2209, 'SPN', k.ACC_2625X, 'SP ', k.ACC_2627X, 'SP ', k.ACC_2625D, 'SP ', k.ACC_2203 , 'SS ') tip
                from   accounts a
                where  a.acc in (k.ACC_PK  , k.ACC_OVR , k.ACC_9129 , k.ACC_9129I, k.ACC_3570 , k.ACC_2208 , k.ACC_2627, k.ACC_2207,
                                 k.ACC_3579, k.ACC_2209, k.ACC_2625X, k.ACC_2627X, k.ACC_2625D, k.ACC_2203)
                       and a.nbs not in ('3550','3551') and ost_korr(a.acc,l_dat31,null,a.nbs) < 0
                )
      LOOP
         p_ins_w4 (p_nd    => k.nd   , p_kv  => s.kv , p_nls   => s.nls      , p_nbs   => s.nbs    , p_ob22   => s.ob22  , p_acc => s.acc, p_tip => s.tip, p_tip_kart => 42, 
                   p_fin23 => k.fin23, p_rnk => s.rnk, p_sdate => k.dat_begin, p_wdate => k.dat_end, p_acc_pk => k.acc_pk, p_vkr => null);  
         l_commit := l_commit + 1 ;
         If l_commit > 1000 then commit; l_commit := 0; end if;
      end LOOP;
   end LOOP;
   l_commit := 0;
   z23.to_log_rez (user_id , 351 , p_dat01 ,'BPK_ACC');
   FOR K IN (SELECT w.* FROM bpk_acc W  where dat_end is null )
   LOOP
      for s in (select a.acc, a.rnk, a.nbs, a.nls, a.kv, a.ob22,
                       DECODE (ACC, k.ACC_PK  , 'SP ', k.ACC_OVR , 'SS ', k.ACC_9129, 'CR9', k.ACC_3570 , 'ODB', k.ACC_2208 , 'SN ',
                                    k.ACC_2207, 'SP ', k.ACC_3579, 'SK9', k.ACC_2209, 'SPN') tip
                from   accounts a
                where  a.acc in (k.ACC_PK  , k.ACC_OVR , k.ACC_9129 , k.ACC_3570 , k.ACC_2208 , k.ACC_2207,
                                 k.ACC_3579, k.ACC_2209)
                         and a.nbs not in ('3550','3551') and ost_korr(a.acc,l_dat31,null,a.nbs) < 0
                  )
      LOOP
         p_ins_w4 (p_nd    => k.nd   , p_kv  => s.kv , p_nls   => s.nls, p_nbs  => s.nbs    , p_ob22   => s.ob22  , p_acc => s.acc, p_tip => s.tip, p_tip_kart => 41, 
                   p_fin23 => k.fin23, p_rnk => s.rnk, p_sdate => NULL, p_wdate => k.dat_end, p_acc_pk => k.acc_pk, p_vkr => null);  
         l_commit := l_commit + 1 ;
         If l_commit > 1000 then commit; l_commit := 0; end if;
      end LOOP;
   end LOOP;
   z23.to_log_rez (user_id , 351 , p_dat01 ,'W4_ACC_INST');
   for s in ( select w.acc_pk,w.CHAIN_IDT nd,a.acc, a.rnk, a.nbs, a.nls, a.kv, a.ob22, f_get_tip_W4(a.tip) TIP, a.daos sdate, a.mdate wdate, nd nd_W4
              from   accounts a, W4_ACC_INST w
              where  w.acc=a.acc and ost_korr(a.acc,l_dat31,null,a.nbs) < 0
            )
   LOOP
      l_vkr := F_Get_Bpk_Params(s.nd_w4,'VNCRR');
      l_cls := nvl(fin_nbu.zn_p_nd('CLS',  60, p_dat01, s.nd_w4, s.rnk),0);
      p_ins_w4 (p_nd    => s.nd , p_kv  => s.kv , p_nls   => s.nls  , p_nbs   => s.nbs  , p_ob22   => s.ob22  , p_acc => s.acc, p_tip => s.tip, p_tip_kart => 44, 
                p_fin23 => l_cls, p_rnk => s.rnk, p_sdate => s.sdate, p_wdate => s.wdate, p_acc_pk => s.acc_pk, p_vkr => l_vkr);  
      l_commit := l_commit + 1 ;
      If l_commit > 1000 then commit; l_commit := 0; end if;
   end LOOP;
   z23.to_log_rez (user_id , 351 , p_dat01 ,'VNCRR + S250');
   l_commit := 0;
   FOR K IN ( SELECT r.rowid RI , r.* FROM rez_w4_bpk r )
   LOOP
      l_grp := NULL;
      l_vkr := substr(F_Get_Bpk_Params(k.nd,'VNCRR'),1,3);
      l_grp := f_2401_grp(k.nbs,k.ob22);
      if l_grp is not null THEN l_s250 := 8;
      else                      l_s250 := NULL;
      end if;
      l_restr := 0;
      if l_s250 = 8 THEN
         begin
            select nvl(f_acc_tag(k.acc_pk, 'REZ_R',9),0) +
                   nvl(f_acc_tag(k.acc_pk, 'REZ_P',9),0) +
                   nvl(f_acc_tag(k.acc_pk, 'REZ_Z',9),0) into l_restr from dual;
         EXCEPTION WHEN NO_DATA_FOUND THEN l_restr := 0;
         end;
      end if;
      Update  rez_w4_bpk set vkr = l_vkr, s250 = l_s250, grp = l_grp, restr = l_restr where rowid = k.ri;
      l_commit := l_commit + 1 ;
      If l_commit > 1000 then commit; l_commit := 0; end if;
   end LOOP;

   z23.to_log_rez (user_id , 351 , p_dat01 ,'Кінець Портфель БПК');
end;
/
show err;

PROMPT *** Create  grants  P_BPK ***
grant EXECUTE                                                                on P_BPK           to BARS_ACCESS_DEFROLE;
grant EXECUTE                                                                on P_BPK           to RCC_DEAL;
grant EXECUTE                                                                on P_BPK           to START1;



PROMPT ===================================================================================== 
PROMPT *** End *** ========== Scripts /Sql/BARS/Procedure/P_BPK.sql =========*** End *** ===
PROMPT ===================================================================================== 
