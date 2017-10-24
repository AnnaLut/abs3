

PROMPT ===================================================================================== 
PROMPT *** Run *** ========== Scripts /Sql/BARS/Procedure/PENY_PAY.sql =========*** Run *** 
PROMPT ===================================================================================== 


PROMPT *** Create  procedure PENY_PAY ***

  CREATE OR REPLACE PROCEDURE BARS.PENY_PAY (DAT date,mode_ NUMBER)
IS

    S_ oper.s%type;
   PS_ oper.s%type;
   l_dat date:=trunc(nvl(DAT,gl.bdate));
 NLSD_ accounts.nls%type:=GetGlobalOption('SPN_SD8');
  /*

     Функция по автоматическому сворачиванию пени.
         особенности СБЕРБАНКА только i.ob22='01'   (но легко может быть исправлена для любого коммерческого банка)

  DAT date,           -- Дата за которую необходимо свернуть пеню
  mode_ NUMBER        -- Зарезервирована (не используется)



   Функция по автоматическому сворачиванию пени.
  Функцию может запускать как и работник так и встроена на финиш дня.
  Функция анализирует все поступления (документы) на счет 6397 и ob22='01' по указанному идентификационному коду в документе находит
  кредитные договора клиента с начисленной пеней на счетах 8008 с типом 'SN8'.
  Для данных документов функция дописывает бухгалтерскую модель по сворачиванию начисленной пени на 8-м классе.

  Особенности работы программы
    1. Программа имеет защиту от двойного списания при повторном запуске но программа не ОТСЛЕЖИВАЕТ проводки списания
       пени созданные ОТДЕЛЬНЫМ  документом.
    2. Сворачиваются проводки только у которых для счета А или Б указан идентификационный код КЛИЕНТА, а не код банка.
    3. При наличии у клиента двух договоров пеня будет списана сначала с КД договора с большей суммой начисленной пени.
       При наличии остатка после списания с первого договора оставшаяся сумма будет использована для списания следующего договора.

    27/01/2015 Исправлена ошибка которая при не полном списание суммы  (в т. ч. и из за изм-ся курса вал)
               по 8 классу приводила к повторному списанию всей суммы , а не а недостающей     PS_:=p.sq;  ==> p.sq-p.sq_sn8


  */
begin
  -- відбір операцій погашення пені з рахунків клієнтів
  for p in (select ref,fdat,sq,sq_sn8,okpo from
            (select o.ref ,o.fdat,o.s SQ,
                   (select nvl(sum(GL.P_ICURVAL(a2.kv,o2.s,GL.bd)),0) from opldok o2,accounts a2
                     where a2.acc=o2.acc and o2.ref=O.REF and a2.tip='SN8'
                   ) SQ_SN8,
                   (select (case when ID_A<>gl.AOKPO and substr(ID_A,1,5)<>'99999' and substr(ID_A,1,5)<>'00000' then ID_A
                                 when ID_B<>gl.AOKPO and substr(ID_A,1,5)<>'99999' and substr(ID_A,1,5)<>'00000' then ID_B
                                 else null end ) OKPO
                      from oper where ref=o.ref
                   ) OKPO
             from opldok o
            where FDAT = l_dat and                 -- за поточний банківський день
                    --fdat = to_date('05/01/2009','dd/mm/yyyy') and
                  o.acc in (
                            select a.acc from accounts a, specparam_int i
                             where a.nls like '6397%' and i.ob22='01' and i.acc=a.acc
                           )
                  and exists (select 1 from oper where ref=o.ref and SOS=5 and (ID_A<>gl.AOKPO or ID_B<>gl.AOKPO))
                   -- and exists (select 1 from oper where ref=o.ref and SOS=5)
            ) where OKPO is not null and abs(sq-sq_sn8)>0
              order by okpo desc
           )
  loop
     logger.trace('PENY_PAY: 1.Main ref='||to_char(p.ref)||' fdat='||to_char(p.fdat)|| ' sq='||to_char(p.sq)||' sq_sn8='||to_char(p.sq_sn8)||' okpo='||p.okpo);
    PS_:=p.sq-nvl(p.sq_sn8,0); -- узнаем не погашенную сумму
    --
    FOR k in ( select a.nls,a.kv,abs(greatest(fost_h(a.acc,gl.bd),a.OSTC)) OSTC,n.nd
                 from accounts a,CUSTOMER c,ND_ACC n
                where a.acc=n.acc and a.tip='SN8' and a.rnk=c.rnk and c.okpo=p.okpo and a.ostc<0
                order by a.ostc desc
             )
    LOOP

      IF (k.KV=gl.baseval) then s_:=greatest(PS_,0)   ;        -- якщо гривня
      ELSE                      S_:=gl.p_Ncurval(k.kv,greatest(PS_,0), l_dat); -- якщо валюта
      END IF;

      S_:=least(s_,k.OSTC);

         logger.trace('PENY_PAY: 2. append REF='||to_char(p.ref)||' DAT='||to_char(p.FDAT)||' KV='||to_char(k.kv)||' NLSD='||NLSD_||' NLSA='||k.NLS||' Сумма='||to_char(S_)||' Реф КД='||to_char(k.nd));
      GL.PAYV(1, p.ref, p.FDAT, 'CC8', 1, k.kv, NLSD_, S_, k.kv, k.NLS, S_);
      update opldok set txt='Сплата пені' where stmt=gl.aSTMT and ref=p.ref;

        LOGGER.info  ( 'PENY_PAY: Списано нараховану пеню згідно ПД (реф.№ '||to_char(p.REF)||')' );
      PS_:=PS_-gl.p_Icurval(k.kv,S_,gl.bd);
    END LOOP;

  end loop;

end PENY_PAY;
/
show err;

PROMPT *** Create  grants  PENY_PAY ***
grant EXECUTE                                                                on PENY_PAY        to BARS_ACCESS_DEFROLE;
grant EXECUTE                                                                on PENY_PAY        to RCC_DEAL;



PROMPT ===================================================================================== 
PROMPT *** End *** ========== Scripts /Sql/BARS/Procedure/PENY_PAY.sql =========*** End *** 
PROMPT ===================================================================================== 
