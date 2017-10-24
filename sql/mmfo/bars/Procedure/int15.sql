

PROMPT ===================================================================================== 
PROMPT *** Run *** ========== Scripts /Sql/BARS/Procedure/INT15.sql =========*** Run *** ===
PROMPT ===================================================================================== 


PROMPT *** Create  procedure INT15 ***

  CREATE OR REPLACE PROCEDURE BARS.INT15 (p_dat date)
is

-- 10.09.2014 Инга + Сухова Т.
-- Оптовое начисление налога (15 %) от депозитного купона по проводкам собственно начисления купона (%%1)
-- по постанове кабмина 4110

-- ver.3 13/11/2014 BRSMAIN-3023 нотариусы
-- Допрацювати зняття податку 15 % від суми нарахованих відсотків приватних нотаріусів з інст. сек. економіки рівному 14201 і 14101 та ФОП з інст. сек. економіки рівному 14100.


   l_tax_nls varchar2(14) ;  l_tax number;    l_s15 number := 0 ; l_s15q number := 0 ;  l_tax_date_begin date  ;  l_tax_date_end   date; nTmp_  int;   nTmp2_ int;
   l_comment varchar2(5000);
   l_tax_method  int := nvl(to_number(GetGlobalOption('TAX_METHOD')), 1);
begin
   if l_tax_method in (1,3)
   then
           l_tax            := nvl( to_number(GetGlobalOption('TAX_INT')) , 20/100 ) ;                 -- % налога
           l_tax_date_begin := to_date(nvl(GetGlobalOption('TAX_DON'), '01.08.2014'),'dd.mm.yyyy');   -- начало действия пост 4110
           l_tax_date_end   := to_date(    GetGlobalOption('TAX_DOFF')               ,'dd.mm.yyyy');   -- конец  действия пост 4110
           l_tax_date_end   := nvl( l_tax_date_end, add_months(p_dat,1) );                             --  ???
           if p_dat  NOT between l_tax_date_begin and l_tax_date_end  then RETURN; end if;          -- дата вне интервала


           for k in (select o.REF, o.S, a.KV, a.rnk, a.nbs, a.nls, a.acc , a.ostc , a.branch           -- выборка необходимых
                     from  (select * from opldok   where tt in ('%%1','DU%') and dk  = 1 and fdat = p_dat ) o,
                           (select * from accounts where blkd=0 and dapp = p_dat and dazs is null and ostc >0 and
                                                                          (    nbs = '2638'
                                                                            or nbs = '2628' and ob22 not in ('16','19','22','23')
                                                                            or nbs in ('2608','2618') )
                            ) a
                     where o.acc = a.acc
                     and not exists (select 1 from opldok where tt ='%15' and dk  = 1 and fdat = p_dat and ref = o.ref)
                    )
           loop
             l_comment := '';
            --nTmp_ := 1 - не выполнять вставку дочерней операции, причины: дочерняя уже существует, 2608/18 не принадлежит СПДФО

              begin select 1 into nTmp_ from opldok where ref = k.ref and tt ='%15' and rownum=1;     --защита от дубля
              exception when no_data_found then nTmp_ := 0; end;
            --nTmp_ := 0 - не найдено дочерней
             l_comment := l_comment || 'Process ref = '|| to_char(k.ref)|| ' acc=' || to_char(k.acc)|| ' '|| case when nTmp_ = 0 then ' %15 not exists; ' else ' %15 already exists; ' end;

                 If k.nbs in  ('2608','2618')  then
                    begin select 1 into nTmp2_ from customer where rnk = k.rnk and (ise in ('14200','14100') and sed = '91' or ise in ('14201','14101')) ;  -- только СПД +нотариусы
                     exception when no_data_found then nTmp2_ := 2; end;
                  l_comment := l_comment ||'NBS = ' || to_char(k.nbs) || case when nTmp2_ = 1 then ' Ok, SPDFO; ' else ' Skip; ' end;
                 end if ;

            --nTmp2_ := 2 - счет 2608/18 не принадлежит СПДФО
            --nTmp2_ := 1 - счет 2608/18    принадлежит СПДФО
               begin
                        l_s15  := ROUND( k.s*l_tax , 0 );
                        l_s15q := p_icurval( k.kv, l_s15, p_dat)        ;  -- расч сумма

                        l_comment := l_comment || ' s = ' || to_char(l_s15)||', sq='||to_char(l_s15q);
                        l_comment := l_comment || ' nvl(nTmp_,0) = '|| to_char(nvl(nTmp_,0))|| ' nvl(nTmp2_,1) = '|| to_char(nvl(nTmp2_,1));
                        l_comment := l_comment || case when (nvl(nTmp_,0) =  0 and nvl(nTmp2_,1) = 1) then ' OK, ' else ' SKIP' end;
                        if (nvl(nTmp_,0) =  0 and nvl(nTmp2_,1) = 1)
                        then
                             l_comment := l_comment || case when (l_s15 > 0 and k.ostc  >= l_s15) then ' payv starts ' else ' payv skips' end;
                             l_comment := l_comment || ' l_s15='||to_char(l_s15) || ' k.ostc =' || to_char(k.ostc);
                             if l_s15 > 0 and k.ostc  >= l_s15  then
                                If length (k.branch) = 15 then k.branch := k.branch || '06'|| substr(k.branch,-5) ; end if;  -- подбор сч 3622 на 3-м уровне
                                l_comment := l_comment || 'check branch: ' || to_char(k.branch);
                                l_tax_nls := nbs_ob22_null('3622','37',k.branch );
                                l_comment := l_comment || '3622/37='|| to_char(l_tax_nls)||'; dates gl.bdate=' || to_char(gl.bdate,'dd/mm/yyyy') || ' p_dat=' ||  to_char(p_dat,'dd/mm/yyyy') ;
                                gl.payv(1, k.ref, gl.bdate,'%15', 1, k.kv, k.nls, l_s15, gl.baseval , l_tax_nls, l_s15q );    -- доч.проводка
                             end if;
                        end if;

               bars_audit.info(l_comment);

               exception when others then
                   bars_audit.error(l_comment|| ' Exception:' ||sqlcode || sqlerrm);
               end;

               nTmp_ := null; nTmp2_ := null;

           end loop;
   end if;
end int15;
/
show err;

PROMPT *** Create  grants  INT15 ***
grant EXECUTE                                                                on INT15           to BARS_ACCESS_DEFROLE;
grant EXECUTE                                                                on INT15           to START1;



PROMPT ===================================================================================== 
PROMPT *** End *** ========== Scripts /Sql/BARS/Procedure/INT15.sql =========*** End *** ===
PROMPT ===================================================================================== 
