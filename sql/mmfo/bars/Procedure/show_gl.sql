

PROMPT ===================================================================================== 
PROMPT *** Run *** ========== Scripts /Sql/BARS/Procedure/SHOW_GL.sql =========*** Run *** =
PROMPT ===================================================================================== 


PROMPT *** Create  procedure SHOW_GL ***

  CREATE OR REPLACE PROCEDURE BARS.SHOW_GL (DAT_ date, MOD_ int, TOBO_ varchar2) is

-------------------------------------------------------------------------------
-- Прооцедура населяющая стартовое окно в форме Баланс-Счет-Документ         --
--                                                                           --
--   Директивы:                                                              --
--   KAZ - казначейство с поддержкой валюты                                  --
--   SNP - поддержка SNAP таблиц (ощад мультимфо - региональн. управления)   --
--                                                                           --
--                                                                           --
-- author     : sta                                                          --
-- version    : 1.4                                                          --
-- last modif : 12.03.2010                                                   --
-------------------------------------------------------------------------------

--
-- SNP  Схема с таблицами accm_SNaP_balances, accm_calendar
--      поддержка SNAP таблиц (ощад мультимфо - региональн. управления)
--      вызов: AWK Show_GL.sql Show_GL.SNP SNP
--

 l_caldt_ID   number; -- accm_calendar.caldt_id%type
 l_caldt_DATE date  ; -- accm_calendar.caldt_DATE%type
 k_840 number; k_978 number; K_643 number;
 BRANCH_ accounts.branch%type;
 l_subtobo varchar2(500);

begin

   if MOD_ = 1 then RETURN;
   end if;

   execute immediate ' truncate table bars.tmp_show_gl ';

   Begin
      BRANCH_ := sys_context('bars_context','user_branch');
      if TOBO_ is null then
         l_subtobo := '';
      elsif nvl(instr(TOBO_,'%'),0) = 0 then
         l_subtobo := ' and a.branch = ''' || TOBO_ || '''';
      else
         l_subtobo := ' and a.branch like ''' || TOBO_ ||'''';
      end if;

      SELECT rate_o/bsum  INTO k_840  FROM cur_rates
      WHERE (kv,vdate) = (SELECT kv,MAX(vdate) FROM cur_rates
                          WHERE vdate <= DAT_ AND kv = 840 GROUP BY kv );
      SELECT rate_o/bsum  INTO k_978  FROM cur_rates
      WHERE (kv,vdate) = (SELECT kv,MAX(vdate) FROM cur_rates
                          WHERE vdate <= DAT_ AND kv = 978 GROUP BY kv );
      SELECT rate_o/bsum  INTO k_643  FROM cur_rates
      WHERE (kv,vdate) = (SELECT kv,MAX(vdate) FROM cur_rates
                          WHERE vdate <= DAT_ AND kv = 643 GROUP BY kv );

      If DAT_ = bankdate_G then
         --тек.день
         execute immediate
        'insert into Tmp_Show_GL (nbs, DOSR, KOSR, OSTD, OSTK )
         select nbs,
                sum(decode(kv,980,      dos         ,
                              840,round(dos*:k_840,0),
                              978,round(doS*:k_978,0),
                              643,round(dos*:k_643,0),
                        gl.p_icurval(KV,dos,:DAT_))) DOSR,
                sum(decode(kv,980,      kos         ,
                              840,round(kos*:k_840,0),
                              978,round(koS*:k_978,0),
                              643,round(kos*:k_643,0),
                        gl.p_icurval(KV,kos,:DAT_))) KOSR,
                sum(decode(kv,980,      osd         ,
                              840,round(osd*:k_840,0),
                              978,round(osd*:k_978,0),
                              643,round(osd*:k_643,0),
                        gl.p_icurval(KV,osd,:DAT_))) OSTD,
                sum(decode(kv,980,      osk        ,
                              840,round(osk*:k_840,0),
                              978,round(osk*:k_978,0),
                              643,round(osk*:k_643,0),
                        gl.p_icurval(KV,osk,:DAT_))) OSTK
         from (select kv, nbs,
                      sum(decode(dapp,:DAT_,dos,0) ) DOS,
                      sum(decode(dapp,:DAT_,kos,0) ) KOS,
                      sum(decode( sign(ostc),-1, -ostc, 0 )) OSD,
                      sum(decode( sign(ostc), 1,  ostc, 0 )) OSK
                 from accounts a
                where nbs not like ''8%''
                  and branch like '''|| BRANCH_ ||'%'' ' || l_subtobo || '
                group by kv,nbs )
         group by nbs '
         using k_840, k_978, k_643, DAT_,
               k_840, k_978, k_643, DAT_,
               k_840, k_978, k_643, DAT_,
               k_840, k_978, k_643, DAT_,
               DAT_ , DAT_ ;
      else
         --прош.день
         select caldt_ID into l_caldt_ID from accm_calendar where caldt_DATE=DAT_;
         --синхронизация
         bars_accm_sync.sync_snap('BALANCE', DAT_);

         execute immediate
        'insert into  Tmp_Show_GL (nbs, DOSQ, KOSQ, DOSR, KOSR, OSTD, OSTK )
         select nbs,
                sum( dosq ) DOSQ, sum( kosq ) KOSQ ,
                sum(decode(kv,980,      dos         ,
                              840,round(dos*:k_840,0),
                              978,round(doS*:k_978,0),
                              643,round(dos*:k_643,0),
                        gl.p_icurval(KV,dos,:DAT_))) DOSR,
                sum(decode(kv,980,      kos         ,
                              840,round(kos*:k_840,0),
                              978,round(koS*:k_978,0),
                              643,round(kos*:k_643,0),
                        gl.p_icurval(KV,kos,:DAT_))) KOSR,
                sum( osdq ) OSDQ, sum( oskq ) OSKQ
         from (select a.kv, a.nbs,
                      sum(b.dosq) DOSQ, sum(b.kosq) KOSQ ,
                      sum(b.dos ) DOS , sum(b.kos ) KOS  ,
                      sum(decode( sign(b.ostq),-1, -b.ostq, 0 )) OSDQ,
                      sum(decode( sign(b.ostq), 1,  b.ostq, 0 )) OSKQ
                 from accm_snap_balances b, accounts a
                where b.caldt_id  = :l_caldt_id  and b.acc = a.acc
                  and a.nbs not like ''8%'' and  (b.dosq>0 or b.kosq>0 or b.ostq<>0)
                  and a.branch like '''|| BRANCH_ || '%'' ' || l_subtobo || '
                group by a.kv,a.nbs )
         group by nbs '
         using k_840, k_978, k_643, DAT_,
               k_840, k_978, k_643, DAT_,
               l_caldt_id ;
      end if;

   exception when NO_DATA_FOUND THEN null;
   end;


   RETURN;

end;
/
show err;

PROMPT *** Create  grants  SHOW_GL ***
grant EXECUTE                                                                on SHOW_GL         to BARS_ACCESS_DEFROLE;
grant EXECUTE                                                                on SHOW_GL         to CUST001;
grant EXECUTE                                                                on SHOW_GL         to RCC_DEAL;
grant EXECUTE                                                                on SHOW_GL         to SALGL;
grant EXECUTE                                                                on SHOW_GL         to WR_ALL_RIGHTS;



PROMPT ===================================================================================== 
PROMPT *** End *** ========== Scripts /Sql/BARS/Procedure/SHOW_GL.sql =========*** End *** =
PROMPT ===================================================================================== 
