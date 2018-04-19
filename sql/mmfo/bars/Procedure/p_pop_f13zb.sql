

PROMPT ===================================================================================== 
PROMPT *** Run *** ========== Scripts /Sql/BARS/Procedure/P_POP_F13ZB.sql =========*** Run *
PROMPT ===================================================================================== 


PROMPT *** Create  procedure P_POP_F13ZB ***

CREATE OR REPLACE PROCEDURE BARS.P_POP_F13ZB(datb_ IN DATE, date_ IN DATE,
                                        nmode_ IN NUMBER) IS
/*%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
% DESCRIPTION :    Процедура наполнения позабалансовых символов в табл.
%             :    OTCN_F13_ZBSK для файла #13 (КБ)
% COPYRIGHT   :    Copyright UNITY-BARS Limited, 1999.All Rights Reserved.
% VERSION     :    21/11/2017 (21/09/2017, 02/08/2017)
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
    параметры: Datb_  - начальная дата
               Date_  - конечная дата
               nmode_ - вариант наполнения (0-с удалением, 1-добавление, 2 - просмотр)
                        в библиотеке - вызывается с nmode_ = 1
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
21.11.2017 добавлены изменения выполненные Вирко для оптимизации
21.09.2017 поле SK_ZB (позабалансовый символ) не будет изменяться при повторном
           наполнении чтобы не изменять откоректированные значения
02.08.2017 изменены некоторые условия для отбора документов из OPLDOK
11.07.2017 для формирования символа 97 добавил  p.NLSB like '2600%' из OPER
10.07.2017 для формирования символа 97 убрал условие nazn like '%ПТКС%'
           а добавил  p.NLSB like '2650%' из OPER
07.07.2017 для формирования символа 97 добавлено условия наличия данного REF
           в OTCN_F13_ZBSK (при повторном наполнении были двойники)
16.06.2017 данная версия работает на ММФО и она будет работать в РУ.
           Добавлен блок для наполнения симвода 97 (Дт 2909 OB22='43' и наличие
           контрагента в таблице CUST_PTKC).
11.01.2017 в табл. OTCN_F13_ZBSK добавлено поле STMT и при вставке проверяем
           два поля REF и STMT
           добавлена обработка Дт 3739 Кт 2620 и назначение "%оплата пенсійних
           реєстрів%" (символ 87)
23.08.2016 для переменнной "kol_" будем присваивать 1 если не изменилось
           значение REFеренса (получили задвоение REF).
24.04.2015 для проводок Дт 2924 Кт 2625 назначения платежа '%дохід підприємця%'
           или '%доход предпринимателя%' или '%перерах%відпскні%'
           будем формировать значение 84
21.04.2015 для проводок Дт 2924 Кт 2625 проверяем документ в OPER и если это
           Дт 2628, 2630, 2635, 2638 Кт 2625 то позабаланс. символ обнуляем
           и обратные проводки также обнуляем
04.07.2013 для проводок Дт 2924 Кт 2625 и назначения платежа "перенесення залишку"
           или "переведення залишку" будем формировать значение SK_ZB=0
13.06.2013 для проводок Дт 2924 Кт 2625 назначения платежа
           '%зарахування зарплата%' будем формировать значение 84
31.05.2013 для проводок Дт 2924 Кт 2625, Дт 2909 Кт 2620 и назначения платежа
           '%зарахування в_дпускних%' будем формировать значение 84
02.01.2013 для проводок Дт 2625 Кт 2924 и назначения платежа "перенесення залишку"
           или "переведення залишку" будем формировать значение SK_ZB=0
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%*/
mfo_    number;
isp_    number;
acc_    number;
sk_zb_  number;
sk_zb_d number;
sk_zb_k number;
sk_zb_o number;
kol_    number;
kol1_   number;
nbsd_   varchar2(15);
nbsk_   varchar2(15);
dat1_   Date;
ko_     integer;
tobo_   varchar2(12);
ko_b    integer;
tobo_b  varchar2(200);
ob22_   varchar2(2);
comm_   kl_f13_zbsk.comm%type;
pref_   number := null;
BEGIN
   commit;

   EXECUTE IMMEDIATE 'ALTER SESSION ENABLE PARALLEL DML';
   EXECUTE IMMEDIATE 'ALTER SESSION SET SORT_AREA_SIZE = 131072';

   -------------------------------------------------------------------
   logger.info ('P_POPF13: Begin for '||to_char(datb_,'dd.mm.yyyy')||' '||
        to_char(date_,'dd.mm.yyyy')||' mode = '||to_char(nmode_));

   mfo_ := F_OURMFO();
   dat1_ := TRUNC(date_,'MM');

   select trim(val)
      into tobo_b
   from params
   where par = 'OUR_TOBO';

   if length(tobo_b) = 20
   then
      tobo_b := substr(tobo_b, 9, 12);
   elsif length(tobo_b) <> 12 then
      tobo_b := substr(tobo_b, 1, 12);
   end if;

   ko_b := substr(tobo_b,2,2);

   if nmode_ = 0
   then
      delete from otcn_f13_zbsk o where fdat between datb_ and date_ ;
      kol1_ := 0;
   elsif nmode_ = 2 then
      select count(*)
         into kol1_
      from otcn_f13_zbsk o where fdat between datb_ and date_;
   end if;

    if kol1_ > 0
    then
       delete from otcn_f13_zbsk z
       where z.ref in (select a.ref
                       from otcn_f13_zbsk a, oper b
                       where a.fdat between dat1_ and date_
                         and a.ref = b.ref
                         and b.sos <> 5);
    end if;

    if nmode_ <> 2 or (nmode_ = 2 and kol1_ = 0)
    then
       for k in (SELECT o.fdat,
                       o.ref,
                       o.tt,
                       (case when o.dk = 0 then o.acc else o1.acc end) accd,
                       (case when o.dk = 0 then a.nls else a1.nls end) nlsd,
                       a.kv,
                       (case when o.dk = 1 then o.acc else o1.acc end) acck,
                       (case when o.dk = 1 then a.nls else a1.nls end) nlsk,
                       o.s, o.sq,
                       p.nazn,
                       p.userid isp,
                       o.stmt,
                       o.kf
                  FROM opldok o,
                       accounts a,
                       opldok o1,
                       accounts a1,
                       oper p
                 WHERE     O.FDAT = any (select fdat from fdat where fdat BETWEEN datb_ AND date_)
                       AND o.tt NOT IN ('АСВ', 'KB8')
                       AND o.acc = a.acc
                       AND a.kv = 980
                       AND REGEXP_LIKE (a.NLS, '^(26(2|3))')
                       AND o.REF = o1.REF
                       AND o.stmt = o1.stmt
                       AND o.dk <> o1.dk
                       AND o1.acc = a1.acc
                       and o.ref = p.ref
                       and p.vob not in (96, 99)
                       and p.sos = 5
                    )

        loop
           if substr(k.nlsd,1,4) not in ('1001','1002','1003','1004') and
              substr(k.nlsk,1,4) not in ('1001','1002','1003','1004')
           then

              acc_ := k.accd;

              IF substr(k.nlsd,1,3) not in ('262','263') and k.nlsd not like '2909%'
              THEN
                acc_ := k.acck;
              END IF;

              tobo_ := NVL(substr(F_Codobl_Tobo(acc_,5),3,12),tobo_b);

              if tobo_ = tobo_b
              then
                ko_ := ko_b;
              ELSE
                ko_ := substr(tobo_,7,2);
              END IF;

              sk_zb_ := 0;
              comm_ := null;

              BEGIN
                 select sk_zb, comm
                    into sk_zb_, comm_
                 from (
                     select sk_zb, trim(comm) comm
                     from (
                        select z.SK_ZB, Z.COMM,
                           (case when trim(z.nbsd) = trim(k.nlsd) and trim(z.nbsk) = trim(k.nlsk) then 1 else 0 end) p1,
                           (case when trim(z.nbsd) = trim(k.nlsd) and trim(z.nbsk) = trim(substr(k.nlsk,1,4)) then 1 else 0 end) p2,
                           (case when trim(z.nbsd) = trim(substr(k.nlsd,1,4)) and trim(z.nbsk) = trim(k.nlsk) then 1 else 0 end) p3,
                           (case when trim(z.nbsd) = trim(substr(k.nlsd,1,4)) and trim(z.nbsk) = trim(substr(k.nlsk,1,4)) then 1 else 0 end) p4,
                           (case when trim(z.tt) = k.tt then 1 else 0 end) p5
                        from kl_f13_zbsk z
                        where trim(k.nlsd) like trim(z.nbsd) ||'%'
                          and trim(k.nlsk) like trim(z.nbsk) ||'%'
                          and NVL(trim(z.tt),k.tt)=k.tt
                        )
                    order by p1+p2+p3+p4+p5 desc, p1 desc, p2 desc, p3 desc, p4 desc, p5 desc)
                 where rownum=1;
              EXCEPTION WHEN NO_DATA_FOUND THEN
                   sk_zb_ := 0;
                   comm_ := null;
              END;

              isp_:=k.isp;

              if sk_zb_ >= 0
              then
                 sk_zb_k := sk_zb_;

                 acc_ := k.accd;

                 IF substr(k.nlsd,1,3) not in ('262','263')
                 THEN
                    acc_ := k.acck;
                 END IF;

                 tobo_ := NVL(substr(F_Codobl_Tobo(acc_,5),3,12),tobo_b);

                 if tobo_=tobo_b
                 then
                    ko_:=ko_b;
                 ELSE
                    ko_:= substr(tobo_,7,2);
                 END IF;

                 BEGIN
                    select o.sk, substr(trim(w.value),1,2)
                       into sk_zb_o, sk_zb_d
                    from oper o, operw w
                    where o.ref = k.ref
                      and o.ref = w.ref(+)
                      and w.tag(+) = 'SK_ZB';

                    if sk_zb_d in ('84','86','87','88','93','94','95','96')
                    then
                       sk_zb_ := sk_zb_d;
                    end if;

                    if sk_zb_o in ('84','86','87','88','93','94','95','96')
                    then
                       sk_zb_ := sk_zb_o;
                    end if;
                 EXCEPTION WHEN OTHERS THEN
                    sk_zb_d := null;
                 END;

                 if k.nazn like 'Скасування зняття гот_вки%' OR
                    k.nazn like 'Отмена снятия наличных%' OR
                    k.nazn like '%Отмена сняти_ наличных%' OR
                    k.nazn like 'Скасування куп_вл_%' OR
                    k.nazn like 'Повернення куп_вл_%' OR
                    k.nazn like '%Возврат покупки%' OR
                    k.nazn like '%Отмена покупки%' OR
                    k.nazn like 'Отмена покупки%' OR
                    k.nazn like 'в_дм_на зняття гот%' OR
                    k.nazn like '_овернено зайв_ зарах%'
                 then
                    sk_zb_ := 0;
                 end if;

                 if k.nlsd like '2909%' and k.nlsk like '2620%' and
                    (k.nazn like '%в_дрядження%') and sk_zb_ <> 88
                 then
                     sk_zb_ := 88;
                 end if;

                 if k.nlsd like '2909%' and k.nlsk like '2620%' and
                    ( LOWER(k.nazn) like '%зараховано на рахун%' or
                      LOWER(k.nazn) like '%зараховано на вклад%' or
                      LOWER(k.nazn) like '%зарахування на рахун%' or
                      LOWER(k.nazn) like '%зарахування  на рахун%' or
                      LOWER(k.nazn) like '%зарахування на вклад_%' or
                      LOWER(k.nazn) like '%зарах_на вклад_%' or
                      LOWER(k.nazn) like '%зачислено на счет_%'
                    ) and sk_zb_ <> 88
                 then
                     sk_zb_ := 88;
                 end if;

                 if k.nlsd like '2909%' and k.nlsk like '2620%' and
                    (k.nazn like '%_отац_я%') and sk_zb_ <> 86
                 then
                     sk_zb_ := 86;
                 end if;

                 if k.nlsd like '2924%' and k.nlsk like '2625%' and
                    (LOWER(k.nazn) like '%пенс%' or
                     LOWER(k.nazn) like '%пенс__%' or
                     LOWER(k.nazn) like '%допомог_%' or
                     LOWER(k.nazn) like '%дитяч%' or
                     LOWER(k.nazn) like '%пособи_%') and sk_zb_ <> 87
                 then
                     sk_zb_ := 87;
                 end if;

                 if k.nlsd like '2924%' and k.nlsk like '2625%'
                    and ( LOWER(k.nazn) like '%зарахування%допомог_ до в_дпустки%' or
                          LOWER(k.nazn) like '%зарахування в_дпускних%' or
                          LOWER(k.nazn) like '%перерах%в_дпускн_%' or
                          LOWER(k.nazn) like '%перерах%оздоровлення%' or
                          LOWER(k.nazn) like '%перер_хування л_карняних%' or
                          LOWER(k.nazn) like '%выплата больничных%' or
                          LOWER(k.nazn) like '%зароб_тна плата%' or
                          LOWER(k.nazn) like '%прем_я%' or
                          LOWER(k.nazn) like '%зарахування%зп%' or
                          LOWER(k.nazn) like '%зарплат_%' or
                          LOWER(k.nazn) like '%zarplata%' or
                          LOWER(k.nazn) like '%з/п%' or
                          LOWER(k.nazn) like '%з\п%' or
                          LOWER(k.nazn) like '%_л_мент_%' or
                          LOWER(k.nazn) like '%аванс%' or
                          LOWER(k.nazn) like '%дох_д п_дпри_мця%' or
                          LOWER(k.nazn) like '%доход предпринимателя%'
                        )
                    and sk_zb_ <> 84
                 then
                     sk_zb_ := 84;
                 end if;

                 if k.nlsd like '2909%' and k.nlsk like '2620%' and
                    (LOWER(k.nazn) like '%пенс%' or
                     LOWER(k.nazn) like '%пенс__%' or
                     LOWER(k.nazn) like '%допомог_%' or
                     LOWER(k.nazn) like '%дитяч%'  or
                     LOWER(k.nazn) like '%пособи_%') and sk_zb_ <> 87
                 then
                     sk_zb_ := 87;
                 end if;

                 if k.nlsd like '2909%' and k.nlsk like '2620%'
                    and ( LOWER(k.nazn) like '%зарахування%допомог_ до в_дпустки%' or
                          LOWER(k.nazn) like '%зарахування в_дпускних%'
                        )
                    and sk_zb_ <> 84
                 then
                     sk_zb_ := 84;
                 end if;

                 if k.nlsd like '2909%' and k.nlsk like '2620%' and
                    ( LOWER(k.nazn) like '%зарплат_%' or k.nazn like '%з/п%' or k.nazn like '%з\п%' or
                      LOWER(k.nazn) like '%_л_мент_%' or k.nazn like '%З\П%' or
                      LOWER(k.nazn) like '%аванс%'
                    ) and sk_zb_ <> 84
                 then
                     sk_zb_ := 84;
                 end if;

                 if k.nlsd like '2909%' and k.nlsk like '2620%' and
                    (k.nazn like '%_ар.плат_%' or k.nazn like '%з-п%' or k.nazn like '%З-П%' or
                     k.nazn like '%_-та%' or     -- (з-та або З-та)
                     k.nazn like '%__карнян_%' or  -- (л_карнян_)
                     k.nazn like '%_онорар_%' or   -- (гонорар)
                     k.nazn like '%_вторська винагорода%') and sk_zb_ <> 84
                 then
                     sk_zb_ := 84;
                 end if;

                 if k.nlsd like '3739%' and k.nlsk like '2620%' and
                    ( LOWER(k.nazn) like '%оплата пенс_йних ре_стр_в%'
                    ) and sk_zb_ <> 87
                 then
                     sk_zb_ := 87;
                 end if;

                 if k.nlsd like '3739%' and (k.nlsk like '2620%' or
                                             k.nlsk like '2628%' or
                                             k.nlsk like '2630%' or
                                             k.nlsk like '2635%' or
                                             k.nlsk like '2638%') and
                    (LOWER(k.nazn) like '%_ереведення залишку%') and sk_zb_ <> 0
                 then
                     sk_zb_ := 0;
                 end if;

                 if k.nlsd like '2625%' and k.nlsk like '2924%' and
                    (LOWER(k.nazn) like '%_еренесення залишку%' or
                     LOWER(k.nazn) like '%_ереведення залишку%') and
                    sk_zb_ <> 0
                 then
                     sk_zb_ := 0;
                 end if;

                 if k.nlsd like '2924%' and k.nlsk like '2625%' and
                    (LOWER(k.nazn) like '%процент%' or
                     LOWER(k.nazn) like '%внесение нал%' or
                     LOWER(k.nazn) like '%другие платежи%' or
                     LOWER(k.nazn) like '%відрядження%' or
                     LOWER(k.nazn) like '%_нш_ платеж_%' ) and sk_zb_ <> 88
                 then
                     sk_zb_ := 88;
                 end if;

                 if k.nlsd like '2909%' and k.nlsk like '2620%' and
                    (LOWER(k.nazn) like '%процент%') and sk_zb_ <> 88
                 then
                     sk_zb_ := 88;
                 end if;

                 -- для компенсации
                 if k.nlsd like '2924%' and k.nlsk like '2625%' and
                    LOWER(k.nazn) like '%w%' and sk_zb_ <> 88
                 then
                     sk_zb_ := 88;
                 end if;

                 if k.nlsd like '2924%' and k.nlsk like '2625%'
                    and (LOWER(k.nazn) like '%внесен_е налич%' or
                         LOWER(k.nazn) like '%_еренесення залишку%' or
                         LOWER(k.nazn) like '%_ереведення залишку%')
                    and sk_zb_ <> 0
                 then
                     sk_zb_ := 0;
                 end if;

                 -- обнуляем позабаланс. символ для проводок Дт 262 Кт 263
                 if ( (k.nlsd like '2924%' and k.nlsk like '2625%') or
                      (k.nlsd like '2625%' and k.nlsk like '2924%')
                    )
                    and (k.tt like 'PK%' OR k.tt like 'W43%')
                    and sk_zb_ <> 0
                 then
                    BEGIN
                       select 0
                          into sk_zb_
                       from oper o
                       where o.ref = k.ref
                         and (o.nlsa like '262%' or o.nlsa like '263%')
                         and (o.nlsb like '262%' or o.nlsb like '263%');
                    EXCEPTION WHEN NO_DATA_FOUND THEN
                       null;
                    END;
                 end if;

                 -- для Луцька
                 if mfo_ = 303398 and k.nlsd like '2620%' and k.nlsk like '6110%' and
                    LOWER(k.nazn) like '%ком_с_я%' and sk_zb_ <> 95
                 then
                     sk_zb_ := 95;
                 end if;

                 if mfo_ = 322669 and k.nlsd like '2620%' and k.nlsk like '3739%'
                 then
                     BEGIN
                        select ob22
                           into ob22_
                        from specparam_int
                        where acc=k.accd;
                     EXCEPTION WHEN NO_DATA_FOUND THEN
                        ob22_ := '00';
                     END;
                     if ob22_ <> '07' then
                        sk_zb_ := 0;
                     end if;
                 end if;

                 update otcn_f13_zbsk o set o.ko = ko_ --o.sk_zb = sk_zb_
                 where o.ref = k.ref
                   and o.stmt = k.stmt;

                 IF SQL%ROWCOUNT = 0
                 THEN
                    insert into otcn_f13_zbsk
                      (fdat, ref, tt, accd, nlsd, kv, acck, nlsk, s, sq, nazn, isp,
                       sk_zb, ko, tobo, kf, stmt )
                    VALUES
                      (k.fdat, k.ref, k.tt, k.accd, k.nlsd, k.kv, k.acck,
                       k.nlsk, k.s, k.sq, k.nazn, isp_, sk_zb_, ko_, tobo_, k.kf, k.stmt);
                 END IF;
              else
                 if comm_ = '*' then
                     delete
                     from otcn_f13_zbsk
                     where  ref = k.ref
                        and stmt = k.stmt;
                 END IF;
              end if;
           end if;

        end loop;

        -- новый блок наполнения символа 97
        insert into otcn_f13_zbsk
           (fdat, ref, tt, accd, nlsd, kv, acck, nlsk, s, sq, nazn, isp,
            sk_zb, ko, tobo, stmt )
           SELECT /*+ leading(a) */
                  o.fdat,
                  o.ref,
                  o.tt,
                  (case when o.dk = 0 then o.acc else o1.acc end) accd,
                  (case when o.dk = 0 then a.nls else a1.nls end) nlsd,
                  a.kv,
                  (case when o.dk = 1 then o.acc else o1.acc end) acck,
                  (case when o.dk = 1 then a.nls else a1.nls end) nlsk,
                  o.s, o.sq,
                  p.nazn,
                  p.userid isp,
                  97,
                  ko_b,
                  tobo_b,
                  o.stmt
             FROM opldok o,
                  accounts a,
                  opldok o1,
                  accounts a1,
                  oper p,
                  cust_ptkc c
             WHERE    o.fdat = any (select fdat from fdat where fdat BETWEEN datb_ AND date_)
                  AND o.acc = a.acc
                  AND a.kv = 980
                  AND REGEXP_LIKE (a.NLS, '^(2909)|(1911)')
                  AND (a.nbs = '2909' and a.ob22 = '43' or a.nbs = '1911' and a.ob22 = '01')
                  AND a.ob22 = '43'
                  AND o.dk = 0
                  AND o.REF = o1.REF
                  AND o.stmt = o1.stmt
                  AND o.dk <> o1.dk
                  AND o1.acc = a1.acc
                  and o.ref = p.ref
                  and REGEXP_LIKE (p.nlsb, '^(26(00|50|54))|(2606)|(1811)|(1911)') 
                  and p.vob not in (96, 99)
                  and p.sos = 5
                  and a.rnk = c.rnk
                  and (o.ref, o.stmt) not in (select ref, stmt
                                              from otcn_f13_zbsk
                                              where sk_zb = 97
                                                and fdat BETWEEN datb_ AND date_);

        for k in (select fdat from fdat where fdat between dat1_ and date_)
        loop
            merge into otcn_f13_zbsk a
            using (select z.recid, z.ref, z.stmt
                      from otcn_f13_zbsk z, oper p
                             where z.fdat = k.fdat
                              and z.sk_zb <> 0
                              and z.ref = p.ref
                              and p.sos = 5 and
                              p.sk > 0 and p.sk < 75 ) b
            on (a.ref = b.ref and
                 a.recid = b.recid and
                 a.stmt = b.stmt)
             WHEN MATCHED THEN
                    UPDATE SET sk_zb = 0
             WHEN NOT MATCHED THEN
                    INSERT (a.RECID)
                    values (b.RECID) ;
        end loop;
    end if;

   logger.info ('P_POPF13: End for '||to_char(datb_,'dd.mm.yyyy')||' '||
        to_char(date_,'dd.mm.yyyy')||' mode = '||to_char(nmode_));

   commit;
END;
/
show err;

PROMPT *** Create  grants  P_POP_F13ZB ***
grant EXECUTE                                                                on P_POP_F13ZB     to BARS_ACCESS_DEFROLE;
grant EXECUTE                                                                on P_POP_F13ZB     to START1;
grant EXECUTE                                                                on P_POP_F13ZB     to WR_ALL_RIGHTS;



PROMPT ===================================================================================== 
PROMPT *** End *** ========== Scripts /Sql/BARS/Procedure/P_POP_F13ZB.sql =========*** End *
PROMPT ===================================================================================== 
