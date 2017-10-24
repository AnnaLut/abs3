

PROMPT ===================================================================================== 
PROMPT *** Run *** ========== Scripts /Sql/BARS/Procedure/P_MBK_DPS.sql =========*** Run ***
PROMPT ===================================================================================== 


PROMPT *** Create  procedure P_MBK_DPS ***

  CREATE OR REPLACE PROCEDURE BARS.P_MBK_DPS (p_dat1 date, p_dat2 date, p_kv number, p_ir1 number, p_ir2 number, p_ir3 number,  p_ir4 number,  p_ir5 number)
is
  dMax_   date ;
  l_kv  number := nvl(p_kv,0);
  l_Dat1  date ;
  ndat_ number;
begin
     l_Dat1 := NVL(p_dat1, trunc(gl.bdate, 'MM') );

     delete from TMP_SAL_ACC;

     insert into TMP_SAL_ACC (ACC, NBS)  select acc, substr(nls,1,4)   from accounts  a
     where a.nls not in (select nlsa from cp_accc where nlsa is not null )   and  substr(a.nls,1,4) in (select nbs from ani331 )
                 and ( a.dazs is null or a.dazs >= l_dat1)                   and l_kv in (0, a.kv) ;

      delete from tmp_mbk_dps;

  for d in ( select (rownum -1)  n from accounts )
    loop  dMax_ := l_dat1 +d.N ;
        If dMax_ > p_dat2 OR  dMax_ >= nvl(gl.bdate, trunc(sysdate) )
            then   PUL.Set_Mas_Ini( 'KOL', to_char(d.n), 'KOL' );
           RETURN ;
        end if;
        ndat_ := to_number ( to_char(dMax_,'YYYYMMDD'));

        insert into tmp_mbk_dps (SROK, KV, PR, N1, N2)
                     select  ndat_,l_kv, x.id, sum(y.ost), round( sum(y.osts)/sum(y.ost),2)
               from ani331 x, (select  nbs, fost (acc,dMax_) ost, fost (acc,dMax_)*get_int_rate(acc,dMax_) osts from TMP_SAL_ACC where fost(acc,dMax_)<>0) y
               where x.nbs = y.nbs  and x.id=8   group by x.id having sum(y.ost) <>0 ;

        update  tmp_mbk_dps t
               set (n3, n4)= (select nvl(sum(y.ost),0) ost,  y.ir
               from ani331 x, (select  nbs, fost (acc,dMax_) ost, get_int_rate(acc,dMax_) ir
                                                from TMP_SAL_ACC
                                      where fost(acc,dMax_)<>0) y
                    where x.nbs = y.nbs     and x.id=8 and  y.ir=p_ir1
              group by x.id, y.ir having sum(y.ost) <>0  )
            where t.srok=ndat_;

        update  tmp_mbk_dps t
               set (n5, n6)= (select (nvl(sum(y.ost),0)) ost , y.ir
               from ani331 x, (select  nbs, fost (acc,dMax_) ost, get_int_rate(acc,dMax_) ir
                                                from TMP_SAL_ACC
                                      where fost(acc,dMax_)<>0) y
                    where x.nbs = y.nbs     and x.id=8 and  y.ir=p_ir2
               group by x.id, y.ir having sum(y.ost) <>0  )
               where t.srok=ndat_;

         update  tmp_mbk_dps t
               set (n7, n8)= (select (nvl(sum(y.ost),0)) ost , y.ir
               from ani331 x, (select  nbs, fost (acc,dMax_) ost, get_int_rate(acc,dMax_) ir
                                                from TMP_SAL_ACC
                                      where fost(acc,dMax_)<>0) y
                    where x.nbs = y.nbs     and x.id=8 and  y.ir=p_ir3
               group by x.id, y.ir having sum(y.ost) <>0  )
               where t.srok=ndat_;

        update  tmp_mbk_dps t
               set (n9, n10)= (select (nvl(sum(y.ost),0)) ost , y.ir
               from ani331 x, (select  nbs, fost (acc,dMax_) ost, get_int_rate(acc,dMax_) ir
                                                from TMP_SAL_ACC
                                      where fost(acc,dMax_)<>0) y
                    where x.nbs = y.nbs     and x.id=8 and  y.ir=p_ir4
               group by x.id, y.ir having sum(y.ost) <>0  )
               where t.srok=ndat_;

        update  tmp_mbk_dps t
               set (n11, n12)= (select (nvl(sum(y.ost),0)) ost , y.ir
               from ani331 x, (select  nbs, fost (acc,dMax_) ost, get_int_rate(acc,dMax_) ir
                                                from TMP_SAL_ACC
                                      where fost(acc,dMax_)<>0) y
                    where x.nbs = y.nbs     and x.id=8 and  y.ir=p_ir5
               group by x.id, y.ir having sum(y.ost) <>0  )
               where t.srok=ndat_;





    end loop;

end;
/
show err;

PROMPT *** Create  grants  P_MBK_DPS ***
grant EXECUTE                                                                on P_MBK_DPS       to BARS_ACCESS_DEFROLE;
grant EXECUTE                                                                on P_MBK_DPS       to START1;



PROMPT ===================================================================================== 
PROMPT *** End *** ========== Scripts /Sql/BARS/Procedure/P_MBK_DPS.sql =========*** End ***
PROMPT ===================================================================================== 
