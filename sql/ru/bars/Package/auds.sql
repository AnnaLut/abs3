
 
 PROMPT ===================================================================================== 
 PROMPT *** Run *** ========== Scripts /Sql/BARS/package/auds.sql =========*** Run *** ======
 PROMPT ===================================================================================== 
 
  CREATE OR REPLACE PACKAGE BARS.AUDS IS

  G_HEADER_VERSION constant varchar2(64)  := 'version 1.3 13.01.2014';

  -- Пакедж для аудита спецпараметров
/*
  Sta r013  Контроль и замена параметра R013
  Sta S180  при замене не должен противоречить БС
  Наташа Ч. Добавлен портфель БПК
*/
  function header_version return varchar2 ;
  function body_version   return varchar2 ;

  PROCEDURE r013 (mode_ int, p_acc specparam.acc%type, p_r013 specparam.r013%type, p_kl varchar2 )  ;
  PROCEDURE s180 (mode_ int  ) ;

END AUDS;
/
CREATE OR REPLACE PACKAGE BODY BARS.AUDS IS

  G_BODY_VERSION constant varchar2(64)  := 'version 1.2 21.12.2011';
  ----------------------------------------------------------------
  function header_version return varchar2 is begin  return 'Package header RKO '||G_HEADER_VERSION;  end header_version;
  function body_version return varchar2   is begin  return 'Package body RKO '||G_BODY_VERSION;  end body_version;

PROCEDURE r013 (mode_ int, p_acc specparam.acc%type, p_r013 specparam.r013%type, p_kl varchar2)   is
  old_r013     specparam.r013%type := '.'                ;
  new_r013s    specparam.r013%type := nvl( p_r013, 'N')  ;
  new_r013k    specparam.r013%type := substr(p_kl, 6, 1) ;
  new_r013     specparam.r013%type ;
  l_nbs        accounts.nbs%type   := substr(p_kl, 1,4)  ;
begin

  begin
     select nvl(r013,'.') into old_r013 from specparam where acc = p_acc ;
  exception when no_data_found then  null;
  end;

  If old_r013 <> new_r013s and new_r013s <> 'N' then  new_r013 :=  p_r013;
  else                                                new_r013 := substr(p_kl,6,1);
  end if;

logger.info ( 'AUDS '||  p_acc ||'- ' ||  p_r013 || '- ' ||  p_kl || ' ' || l_nbs || ' - ' || new_r013);

  begin
    select r013 into new_r013
    from KL_R013 where prem ='КБ'  and d_close is null and r020 = l_nbs and r013 = new_r013;
  exception when no_data_found then raise_application_error(-20100, 'Помилкова комбiнацiя R020.R013 = '|| l_nbs ||'.'|| new_r013 );
  end;
  update specparam set r013 = new_r013 where acc = p_acc;
  if SQL%rowcount = 0 then  insert into specparam (acc,r013) values( p_acc, new_r013 ); end if;
end r013 ;
----------

PROCEDURE s180 (mode_ int)  IS

   l_s180  specparam.s180%type;
   l_sdate saldoa.fdat%type   ;
   l_r180  specparam.s180%type;
   l_O180  specparam.s180%type;

-- скорректированное на БС значеие (не более B для 22_2, 20_2)
   l_k180  specparam.s180%type;

begin
  -- mode_ =
  -- 0 - только аудит
  -- 1 - замена на основном счете  на расчетное значение    и затем аудит
  -- 2 - замена на дочерних счетах на значение из основного и затем аудит
  -- 3 - 1+2

-- перевiрка S180 по КП

EXECUTE IMMEDIATE 'TRUNCATE TABLE CCK_AN_TMP_UPB';

------------------------------------------------------------------
-- Главный цикл-K по основным счетам (первоначальное тело кредита)
------------------------------------------------------------------
for k in (select 'КП ' PORTF, d.nd,d.cc_id,d.sdate,a.mdate,a.acc,a.kv,a.nls,
                 a.branch,a.nbs,a.rnk,s.s180 , a.mdate DAT2
          from cc_deal d, cc_add ad, specparam s, accounts a
          where d.sos   < 15
            and d.vidd in (1,2,3,11,12,13)
            and d.nd    = ad.nd
            and ad.accs = s.acc(+)
            and ad.accs = a.acc
            and ad.adds = 0
            union all
          select 'БПК' PORTF, to_number(null) ND, to_char(d.nd), a.daos,
                 add_months(a.daos,12), a.acc,a.kv,a.nls, a.branch,a.nbs,a.rnk,
                 s.s180 , to_date(null) DAT2
          from bpk_acc d, specparam s, accounts a
          where a.dazs is null
            and d.acc_ovr = a.acc
            and d.acc_ovr = s.acc(+)
          )
loop
  --дата деб.оборота
  select nvl( decode ( substr(k.nbs,1,1),'2', min(fdat), max(fdat) ), k.sdate )
  into l_sdate
  from saldoa where dos>0 and acc=k.acc ;

  --для влитых МФО
  If l_sdate - k.sdate > 7 then   l_sdate := k.sdate;  end if;

  --расчетное значение
  l_r180  := nvl( f_srok (l_sdate,k.mdate,2 ),'0') ;
  l_O180  := nvl( k.s180, Fs180 (acc_=>k.acc,bdat_=>l_sdate ));

  If l_R180 <> l_O180 and mode_ in (1,3) then

     ---21.12.2011 Sta при замене не должен противоречить БС
     If k.nbs like '22_2' or k.nbs like '20_2' then l_k180 := least( l_R180,'B');
     else                                           l_k180 :=        l_R180     ;
     end if;

     update specparam set s180 = l_k180 where acc = k.acc;
     if SQL%rowcount = 0 then
        insert into specparam (s180,acc) values (l_k180,k.acc);
     end if;

     l_O180 := l_r180;

  end if;

  If l_R180 <> l_O180 then
     insert into CCK_AN_TMP_UPB (tobo,  s, cc_id, SDATE, WDATE,
                                 nbs, kv, nls, name, vidd )
     values (k.branch, k.nd, k.cc_id, l_sdate, k.DAT2, l_r180 || l_O180, k.kv, k.nls,
            '1. НЕвiдповiднiсть дат параметру R180<>S180/1', k.PORTF);
  end if;

  --------------------------------------------------------------------------
  -- Вложенный цикл по дополн.к основному (первонач.телу кредита) счетам
  -- нач%. просрочки и т.д.
  --------------------------------------------------------------------------
  for p in (select Nvl(s.s180, Fs180(a.acc) ) s180,
                  a.kv, a.nls, a.branch, a.acc, a.NBS
            from bpk_acc n, specparam s, accounts a
            where n.acc_ovr = k.ACC
              and a.acc in ( nvl(n.ACC_9129, k.acc), nvl(n.ACC_2208, k.acc) )
              and a.acc =  s.acc(+)
              and a.dazs is null
             )
   loop

      l_s180 := p.s180;

      If l_O180 <> l_s180 or l_R180 <> l_s180 then

         If    mode_ = 2 then l_s180 := l_O180;
         elsIf mode_ = 3 then l_s180 := l_R180;
         end if;

         ---при замене не должен противоречить БС
         If mode_ in (2,3) and l_s180 <> p.s180 then

            ---21.12.2011 Sta при замене не должен противоречить БС
            If k.nbs like '22_2' or k.nbs like '20_2' then l_k180:=least(l_s180,'B');
            else                                           l_k180:=      l_s180     ;
            end if;

            update specparam set s180 = l_k180 where acc = p.acc;
            if SQL%rowcount = 0 then
                 insert into specparam (s180,acc) values (l_k180,p.acc);
            end if;
         end if;
      end if;

      If l_O180 <> l_s180 then
         insert into CCK_AN_TMP_UPB (tobo,s,cc_id,SDATE,WDATE,
                                     ratn,ROW_NUM,nbs,kv,nls,name, vidd)
         values (p.branch,  k.nd, k.cc_id, l_sdate, k.DAT2,
                 p.kv, to_number(p.nls), l_R180 || l_O180 || l_s180, k.kv, k.nls,
                 '2. НЕвiдповiднiсть з основним рахунком параметру S180/1<>S180/2',
                 k.PORTF);
      end if;

   end loop;

end loop;

end S180;

END AUDS;
/
 show err;
 
PROMPT *** Create  grants  AUDS ***
grant EXECUTE                                                                on AUDS            to BARS_ACCESS_DEFROLE;
grant EXECUTE                                                                on AUDS            to SALGL;

 
 
 PROMPT ===================================================================================== 
 PROMPT *** End *** ========== Scripts /Sql/BARS/package/auds.sql =========*** End *** ======
 PROMPT ===================================================================================== 
 