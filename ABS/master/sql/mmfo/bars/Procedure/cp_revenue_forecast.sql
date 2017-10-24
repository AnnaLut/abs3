

PROMPT ===================================================================================== 
PROMPT *** Run *** ========== Scripts /Sql/BARS/Procedure/CP_REVENUE_FORECAST.sql =========*
PROMPT ===================================================================================== 


PROMPT *** Create  procedure CP_REVENUE_FORECAST ***

  CREATE OR REPLACE PROCEDURE BARS.CP_REVENUE_FORECAST           ( p_mode int, p_dat31 date) is
-- p_dat31 - прогноз ПО дату включно.

/***   ver 3.5 13/07-15 ***

13/07-15   Коректне приведення до грн. екв-ту прогнозу амортизації
10/07-15   Розгалуження по аналізу metr для купона
 8/07.15   Пр-ра INT_CP_P + додатков_ умови щодо прогнозу амортизац_ї
01.06.2015 Sta Чисто дисконтные ЦБ + прогноз купона
                                     времменно. пока не будет 100 % готовности INT_CP_P
17.06.2015 Sta  Исправление колонок Вид дог и название суб.портф

p_mode = 0  COBUSUPABS-3105
 Розробити функц_ю в АРМ <Ц_нн_ папери>,
 яка б давала змогу прорахувати процентн_ доходи/витрати та суму амортизац_ї дисконту/прем_ї,
 як_ будуть в_дображен_ на рахунках 6 класу до к_нця зв_тного м_сяця.
 Дана функц_я повинна залежати в_д факт_в проведених нарахувань в поточному м_сяц_.
 В прогноз має включатись т_льки та, сума, що буде донарахована.
*/

 ee  cp_deal%rowtype;
 l_dat01 date  ; -- прогноз: начиная c этой датыу.
 dTmp1   date  ; -- промежуточная дата в этом периоде
 dTmp2   date  ; -- промежуточная дата в этом периоде
 l_dat31 date  ; -- прогноз: по такую дату включительно.
 l_dat31a date  ; -- для аморт-ии
 l_int  number ;
 l_kup  number ; -- сумма купонного прогноз-дохода
 l_dis  number ; -- сумма дисконтного прогноз-дохода
 l_kupQ number ; -- сумма купонного прогноз-дохода
 l_disQ number ; -- сумма дисконтного прогноз-дохода
 l_a01  number ;
 l_a31  number ;
 ii int_accn%rowtype   ;
 l_DP   number; NO_A int;
 s_err  varchar2(40);  l_otl int;  fl5 int;
begin
 logger.info('CP_REVENUE start dat31 '||p_dat31);
 If p_mode <> 0 then return; end if;
 execute immediate  'truncate table tmp_CP_REP_DOX ';
 l_dat31 := nvl(p_dat31, last_day (gl.bd) );  l_otl:=0; -- l_otl:=nvl(p_otl,0);
for U in ( SELECT e.dat_ug, e.REF, a.acc, a.accc, a.daos,  k.IR, k.id, k.cp_id, k.kv, k.dat_em, k.datp,
                  k.cena_kup, e.erat/100 IRR, e.erate/100 ERR,
                   -div0(a.ostc/100,k.cena) KOL , a.nls , e.ryn, r.name rname , e.accd, e.accp, e.pf
           FROM cp_deal e,  cp_kod k, accounts a, cp_ryn r
           WHERE k.ID = e.ID AND k.tip = 1 AND e.acc = a.acc AND k.dox > 1 and a.ostc < 0 and e.ryn = r.ryn
        )
loop
   -------------------------------------------------
   l_dat01 := U.daos ;   l_kup := 0 ;   l_dis := 0 ;
   -------------------------------------------------
   begin  -------- ########################################## для купона
      s_err:=' купон % карточка НЕ найдена ';
      select * into ii from int_accn where acc=U.acc and id = 0 ;
      l_dat01 := greatest (ii.acr_dat + 1, u.daos) ;
      dTmp1  := l_dat01; s_err:=null;
      for D in (select x.kup, x.dok, (select nvl(max(dok), u.dat_em) from cp_dat where id = x.Id and dok < x.dok ) dok1, x.npp
                from cp_dat x
                where x.id = U.id  and x.dok > l_dat01
                order by x.dok
               )
      loop

        dTmp2 := LEAST ( l_dat31, d.dok-1);
        If dTmp1 <= dTmp2 and dTmp1 >= l_dat01 and dTmp2 <= l_dat31 and dTmp1 <= l_dat31 then

         --  if l_otl=0 and u.ref in (288973888,163824166,288972558) then logger.info('CP_REVENUE dok='||d.dok||' ref='||u.ref);  end if;

         ---- времменно. пока не будет 100 % готовности INT_CP_P
           if ii.metr in (8,23,515) then
              INT_CP_P ( p_METR=>ii.metr,  p_Acc=>ii.acc,  p_Id=>ii.id,  p_Dat1=>dTmp1,  p_Dat2=>dTmp2,  p_Int=>l_int,  p_Ost=>null,  p_Mode=>0 );
              l_kup := l_kup - l_int ;
           else
              l_kup := l_kup + round( d.kup * 100 * DIV0( (dTmp2-dTmp1+1) , (d.dok-d.dok1) ) ,0 ) * u.kol ;
           end if;

        end if;
        dTmp1 := dTmp2 + 1;
      end loop;  --- d

      if l_otl=0 and u.ref in (288973888,163824166,288972558) then
      logger.info('CP_REVENUE % dat '||dTmp2||' ref='||u.ref||' kup='||l_kup);  end if;
   exception when NO_DATA_FOUND then null;
   if l_otl=1 and nvl(u.ir,0) !=0 then logger.info('CP_REVENUE ref '||u.ref||s_err); end if;
   end;

   begin  -------- ########################################## для дисконта/премии
      s_err:=' аморт % карточка НЕ найдена ';
      select * into ii from int_accn where acc=U.acc and id = decode (u.accD, null, 3, 2) ;
      l_dp:=0; NO_A:=0; s_err:=null;
      select fost(decode(u.accd,null,u.accp,u.accd),l_dat01) into l_dp from dual;
      begin
      s_err:=' Портфель НЕ визначено ';
      select nvl(no_a,0) into NO_A from cp_pf where pf=u.pf;
      s_err:=null;
      exception when NO_DATA_FOUND then null;  NO_A := 0;  -- все одно амортизуємо
   --   if u.accd is not null or u.accp is not null then logger.info('CP_REVENUE ref '||u.ref||s_err); end if;
      end;
      l_dat01 := greatest (ii.acr_dat + 1, u.daos) ;
      l_dat31a := LEAST ( l_dat31+1, u.datp);

      if nvl(l_dp,0) !=0 and NO_A != 1 then
      -- норма дисконта/премии  на l_dat01
      SELECT nvl ( SUM((SS1+SN2)/POWER(1+U.ERR,(FDAT-l_dat01)/365) - (SS1+SN2)/POWER(1+U.IRR,(FDAT-l_dat01)/365) ) ,0)    into l_a01
      FROM cp_many WHERE REF=u.REF AND fdat>=l_dat01;

      -- норма дисконта.премии на l_dat31
      SELECT nvl ( SUM((SS1+SN2)/POWER(1+U.ERR,(FDAT-l_daT31a)/365) - (SS1+SN2)/POWER(1+U.IRR,(FDAT-l_dat31a)/365) ) , 0)   into l_a31
      FROM cp_many WHERE REF=u.REF AND fdat>=l_dat31a;

      -- прогноз-сумма амортизации дисконта/премии
      l_dis := round ( (l_a01-l_a31), 2 ) ;
      end if;

   exception when NO_DATA_FOUND then null;
   if u.accd is not null or u.accp is not null then logger.info('CP_REVENUE ref '||u.ref||s_err); end if;
   end;

   If l_dis <> 0 or l_kup <> 0 then

      If u.kv <> gl.baseval then
         l_kupQ := gl.p_icurval(u.kv,l_kup,p_dat31);
         l_disQ := gl.p_icurval(u.kv,l_dis*100,p_dat31)/100;
      else                       l_kuPQ :=                   l_kup;          l_disQ :=                   l_dis;
      end if ;
      l_dis := l_dis;  l_disQ := round(l_disQ,2);
      l_kup := l_kup/100;  l_kupQ := l_kupQ/100 ;

      insert into tmp_CP_REP_DOX (DAT_UG, CP_ID, KV, DATP, KOL, CENA_KUP, d01, D31, REF, ID, SR, SD, SRQ, SDQ, nbs, nms )
        VALUES(u.DAT_UG,U.cp_id,u.kv,u.datp,u.kol,u.CENA_KUP, l_dat01,l_dat31,u.ref,u.id,l_kup,l_dis,l_kupQ, l_disQ,
        substr(u.nls,1,4) , u.rname  );
   end if;

end loop ;
logger.info('CP_REVENUE finish');

end CP_revenue_forecast;
/
show err;

PROMPT *** Create  grants  CP_REVENUE_FORECAST ***
grant EXECUTE                                                                on CP_REVENUE_FORECAST to BARS_ACCESS_DEFROLE;
grant EXECUTE                                                                on CP_REVENUE_FORECAST to START1;



PROMPT ===================================================================================== 
PROMPT *** End *** ========== Scripts /Sql/BARS/Procedure/CP_REVENUE_FORECAST.sql =========*
PROMPT ===================================================================================== 
