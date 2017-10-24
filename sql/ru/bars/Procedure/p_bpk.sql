

PROMPT ===================================================================================== 
PROMPT *** Run *** ========== Scripts /Sql/BARS/Procedure/P_BPK.sql =========*** Run *** ===
PROMPT ===================================================================================== 


PROMPT *** Create  procedure P_BPK ***

  CREATE OR REPLACE PROCEDURE BARS.P_BPK (p_dat01 date) IS

/* ������ 2.0   15-03-2017  16-02-2017
   ������������ �������� ��� �� �������� ����
   -------------------------------------
 2) 15-03-2017 - w4_acc �� �������: NOT_USE_REZ23 is null, bpk_acc: dat_end is null
 1) 10-03-2017 - restr = 0, ���� �� ����������� ���������

*/

 w4        v_w4_acc%rowtype ; bpk  v_bbpk_acc%rowtype; L_VKR varchar2(3); l_nbs  accounts.nbs%type; l_ob22  accounts.ob22%type;
 l_acc     accounts.acc%type;
 l_restr   number ;
 l_commit  integer; l_grp integer; l_s250 integer;
 l_dat31   date   ;

BEGIN
   z23.to_log_rez (user_id , 351 , p_dat01 ,'������ �������� ���');
   l_dat31 := Dat_last_work (p_dat01 - 1);  -- ��������� ������� ���� ������
   pul_dat(to_char(p_dat01,'dd-mm-yyyy'),'');
   delete from rez_w4_bpk;
   l_commit := 0;
   z23.to_log_rez (user_id , 351 , p_dat01 ,'W4_ACC');
   FOR K IN ( SELECT w.* FROM W4_ACC W where NOT_USE_REZ23 is null )
   LOOP
      for s in (select a.acc, a.rnk, a.nbs, a.nls, a.kv, a.ob22, nvl(t.tip,a.tip) tip  from  accounts a, bpk_nbs_tip t
                 where a.acc in (k.ACC_PK  , k.ACC_OVR , k.ACC_9129 , k.ACC_3570 , k.ACC_2208 , k.ACC_2627, k.ACC_2207,
                                 k.ACC_3579, k.ACC_2209, k.ACC_2625X, k.ACC_2627X, k.ACC_2625D, k.ACC_2203)
                       and a.nbs not in ('3550','3551') and ost_korr(a.acc,l_dat31,null,a.nbs) < 0 and a.nbs = t.nbs(+)
                )
      LOOP
         insert into rez_w4_bpk (nd  , kv  , nls  , nbs  , ob22  , acc  , tip  , tip_kart, fin23  , rnk  , sdate      , wdate    , acc_pk  )
                         values (k.nd, s.kv, s.nls, s.nbs, s.ob22, s.acc, s.tip, 42      , k.fin23, s.rnk, k.dat_begin, k.dat_end, k.acc_pk) ;
         l_commit := l_commit + 1 ;
         If l_commit > 1000 then commit; l_commit := 0; end if;
      end LOOP;
   end LOOP;
   l_commit := 0;
   z23.to_log_rez (user_id , 351 , p_dat01 ,'BPK_ACC');
   FOR K IN (SELECT w.* FROM bpk_acc W  where dat_end is null )
   LOOP
      for s in (select a.acc, a.rnk, a.nbs, a.nls, a.kv, a.ob22, nvl(t.tip,a.tip) tip  from  accounts a, bpk_nbs_tip t
                   where a.acc in (k.ACC_PK  , k.ACC_OVR , k.ACC_9129 , k.ACC_3570 , k.ACC_2208 , k.ACC_2207,
                                   k.ACC_3579, k.ACC_2209)
                         and a.nbs not in ('3550','3551') and ost_korr(a.acc,l_dat31,null,a.nbs) < 0 and a.nbs = t.nbs(+)
                  )
      LOOP
         insert into rez_w4_bpk (nd  , kv  , nls  , nbs  , ob22  , acc  , tip  , tip_kart, fin23  , rnk  , sdate, wdate    ,acc_pk  )
                         values (k.nd, s.kv, s.nls, s.nbs, s.ob22, s.acc, s.tip, 41      , k.fin23, s.rnk, NULL , k.dat_end,k.acc_pk);
         l_commit := l_commit + 1 ;
         If l_commit > 1000 then commit; l_commit := 0; end if;
      end LOOP;
   end LOOP;
   z23.to_log_rez (user_id , 351 , p_dat01 ,'VNCRR + S250');
   l_commit := 0;
   FOR K IN ( SELECT r.rowid RI , r.* FROM rez_w4_bpk r )
   LOOP
      l_grp := NULL;
      l_vkr := F_Get_Bpk_Params(k.nd,'VNCRR');
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

   z23.to_log_rez (user_id , 351 , p_dat01 ,'ʳ���� �������� ���');
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
