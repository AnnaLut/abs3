

PROMPT ===================================================================================== 
PROMPT *** Run *** ========== Scripts /Sql/BARS/Procedure/PLAY_INTA.sql =========*** Run ***
PROMPT ===================================================================================== 


PROMPT *** Create  procedure PLAY_INTA ***

  CREATE OR REPLACE PROCEDURE BARS.PLAY_INTA 
 (p_D1 date, p_D2 date, p_bran varchar2, p_NBS varchar2, p_KV int, P_AP int) is

 -- 24.03.2010 Sta ОВР с метр=7
 -- 22-03-2010 Sta отсечь 1 день для депозитов
 -- 02-03-2010
 -- На старом пакедже начисления % ACRO
  kv_ int    := nvl(p_kv,0);
  S_ number  := 0; q_ number  := 0; int_ number:= 0;
  ir_ number ;
  DAT1_ date ;
begin
  delete from CCK_SUM_POG;

  for k in (select a.BRANCH, a.daos,
                   i.ID, a.kv, a.acc, a.nls, a.rnk, i.acra, i.acr_dat,
                   least( nvl(i.STP_DAT, p_D2) , p_D2) DAT2,
                   i.metr
            from accounts a, int_accn i
            where a.nbs NOT like '8%'
              and a.branch like '%' || p_bran || '%'
              and a.kv= decode (kv_,0, a.kv, kv_)
              and a.nbs like '%'||p_NBS||'%'
              and a.acc=i.acc and i.id in (0,1)
--              and i.acra is not null
--and a.nls='260033025537'
            )
  loop
    DAT1_ := greatest(k.daos, p_D1) ;

    If k.id = 1 and DAT1_ > p_D1 then
       DAT1_ := Dat1_ +1;
    end if;

    If DAT1_ <= k.DAT2 then
       if P_AP is null OR P_AP=k.id   then
          int_ := 0;

          If k.metr=7 then
             update int_accn set metr=1 where acc=k.acc and id=k.id;
          end if;

          acrO.p_int(k.acc, k.id, DAT1_, k.DAT2, int_, NULL, 0);

          If k.metr=7 then
             update int_accn set metr=7 where acc=k.acc and id=k.id;
          end if;

          S_:= round(int_,0);

          if s_<> 0 then
             Q_:=S_;
             If k.KV<>gl.baseval then
                Q_ := gl.p_icurval(k.KV,S_,k.DAT2);
             end if;

             ir_ := acrn.FPROCN(k.acc,k.id,k.DAT2);

             insert into CCK_SUM_POG (ACC,ND,KV,NMK,CC_ID,G1,G2, rnk,g3, g4)
                values (nvl(k.acRA,0),  k.id,k.kv,k.branch,
to_char(DAT1_,'dd.mm.yy') || ' - ' || to_char(k.DAT2,'dd.mm.yy'),
                  s_/100, q_/100, k.rnk, k.nls, IR_ );
          end if;
       end if;
    end if;
  end loop;
  commit;
end PLAY_INTa;
/
show err;

PROMPT *** Create  grants  PLAY_INTA ***
grant EXECUTE                                                                on PLAY_INTA       to BARS_ACCESS_DEFROLE;
grant EXECUTE                                                                on PLAY_INTA       to SALGL;



PROMPT ===================================================================================== 
PROMPT *** End *** ========== Scripts /Sql/BARS/Procedure/PLAY_INTA.sql =========*** End ***
PROMPT ===================================================================================== 
