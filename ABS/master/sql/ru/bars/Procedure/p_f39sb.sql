

PROMPT ===================================================================================== 
PROMPT *** Run *** ========== Scripts /Sql/BARS/Procedure/P_F39SB.sql =========*** Run *** =
PROMPT ===================================================================================== 


PROMPT *** Create  procedure P_F39SB ***

CREATE OR REPLACE PROCEDURE BARS.P_F39SB (Dat_ DATE, sheme_ VARCHAR2 DEFAULT 'C')  IS
/*%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
% DESCRIPTION :	Процедура формирование файла @39 для Ощадного Банку
% COPYRIGHT   :	Copyright UNITY-BARS Limited, 1999.All Rights Reserved.
% VERSION     : 14/11/2017 (18/12/2012, 30/11/2012)
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
    параметры: Dat_ - отчетная дата
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
Изменеиия:

14.11.2017 - удалил ненужные строки  
18.12.2012 - для инвестиционных монет формируем коды 610-купiвля,620-продаж
             (type_=4 (набiр) и поле cena_nomi в BANK_METALS не пустое)
30.11.2012 - для инвестиционных монет формируем коды 610-купiвля,620-продаж
             (type_=2 и поле cena_nomi в BANK_METALS не пустое)
13.09.2012 - формируем в разрезе кодов территорий
30.12.2010 - в случае нечислового значения курса выдаем N референса
16/12/2010 - дуже великі суми, тому не вистачало в форматі знаків - розширила формат
16.12.2010 - не будут включаться документы вида NLSA like '1101%'
             NLSB like '3903%' или NLSA like '3903%'
             NLSB like '1101%' (замечание Крым СБ)
09.12.2010 - не будут включаться документы вида NLSA like '1101%'
             NLSB like '3902%' или NLSA like '3902%'
             NLSB like '1101%' (замечание обл.упр-ния Ровно СБ)
18.12.2009 - не будут включаться документы вида NLSA like '1101%'
             NLSB like '3906%','3907%' или NLSA like '3906%','3907%'
             NLSB like '1101%' (замечание обл.упр-ния Житомир СБ)
24.07.2009 - в условии убираем проверку на последний символ лиц.счета
             3800______ значения "2" т.к. данный счет должен использоваться
             только для покупки/продажи монет, но он также используется и
             для покупки/продажи слитков
11.06.2009 - если номинал и эквивалент равны не включаем в файл
22.04.2009 - для определения вида металла монета или слиток будем
             использовать табл. BANK_METALS
21.04.2009 - исключаем лиц.счет 110169160199 из отбора проводок
02.04.2009 - для значения суммы металла 8 (2.5 грамма) округляем до 1 знака
             для всех остальных значений суммы металла округляем до целых
19.03.2009 - для Ровно ОБ будем рассчитывать курс
17.11.2008 - добавлено условие " AND tag='D#44' " для табл. OPERW
10.11.2008 - выполняется замена кодов "DDD" в зависимости от доп.параметра
             D#44 (310 или 320 для D#44=11-18, 410 или 420 для D#44=21-28,
             510 или 520 для D#44=31-38 (ранее были коды 210 или 220)
23.06.2008 - Новая процедура формирования файла @39

%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%*/
kodf_    varchar2(2):='39';
fmt_     varchar2(20):='999999999990D0000';
--mn_      number:=100; -- для валютообменных операций в кассе, если курс в OPERW за единицу валюты
dl_      number:=1;  --100; -- для металлов
DatP_	 date; -- дата начала выходных дней, кот. предшествуют заданой дате
buf_	 number;
datd_    Date;
branch_  varchar2(30);
typ_     number;
kv_      number;
kv1_     number;
ref_     number;
ref1_    number;
nls_     varchar2(15);
nlsk_    varchar2(15);
nls1_    varchar2(15);
nlsb_    varchar2(15);
nls3800_ varchar2(15);
mfo_     Varchar2(12);
mfoa_    Varchar2(12);
mfob_    Varchar2(12);
data_    date;
kol_     number;
dig_     number;
bsu_     number;
sum_     number;
sum1_    number;
sum0_    number;
sun1_    number;
sun0_    number;
sum_eqv_ number;
kodp_    varchar2(10);
kodp1_   varchar2(10);
znap_    varchar2(30);
VVV      varchar2(3) ;
ddd_     varchar2(3) ;
ddd39_   varchar2(3) ;
d39_     varchar2(200) ;
kurs_    varchar2(200) ;
kurs1_   Number(9,4);
tag_     varchar2(5) ;
a_       varchar2(200);
b_       varchar2(200);
userid_  number;
userid1_ number;
nbuc1_   varchar2(12);
nbuc_    varchar2(12);
acc_     number;
acc3800_ number;
accd_    number;
acck_    number;
pr_      number;
rate_o_  number;
div_     number;
d#44_    varchar2(2);
comm_    Varchar2(200);
cena_nomi_ number;

-- в банке "Киев" из СБОНа приходят проводки Дт 1002 Кт 3800 выкуп центов и
-- поэтому должно быть условие decode(p.tt,o.tt,decode(p.kv2,a.kv,p.s,p.s2)
-- которое убрал 22.12.2006 тестируя процедуру в УПБ
-- возвратил 27.03.2007
--Покупка/продажа металлов
CURSOR OPER959 IS
select b.ref, b.acc3800, b.acc, b.nls, b.kv, b.fdat, b.kurs, b.datd,
       b.branch, b.userid,
       sum(b.ds), sum(b.ks),
       sum(b.pds2) dsq, sum(b.pks2) ksq
from
(select  o.acc acc3800, a.acc, a.isp, p.tt ptt, o.tt ott, p.nlsa nls, a.kv,
         o.fdat, p.ref,
	 translate(w.value,',','.') kurs, p.datd, p.branch, p.userid,
         decode (o2.dk, 0, o.s, 0) ds,
         decode (o2.dk, 1, o.s, 0) ks,
         decode(o2.dk,0,decode(p.tt,o.tt,decode(p.kv2,a.kv,p.s,p.s2),
         f_d3801(p.ref,o.tt,v.ACC3801,o2.dk,v.ACC_RRD,v.ACC_RRR)),0) pds2,
         decode(o2.dk,1,decode(p.tt,o.tt,decode(p.kv2,a.kv,p.s,p.s2),
         f_d3801(p.ref,o.tt,v.ACC3801,o2.dk,v.ACC_RRD,v.ACC_RRR)),0) pks2
from opldok o, vp_list v, opldok o2, accounts a, oper p, operw w
where o.fdat = Dat_     --o.fdat between Datp_ and dat_
      and o.sos=5
      and o.acc=v.ACC3800
      and o.ref=o2.ref
      AND o.fdat = o2.fdat
      AND o.dk <> o2.dk
      AND o.tt = o2.tt
      AND o.stmt = o2.stmt
      and o2.acc=a.acc
      and substr(a.nls,1,3)='110' and a.nls<>'110169160199'
      and a.kv=kv_ and ((p.kv<>980 and p.kv2=980) or (p.kv=980 and p.kv2<>980) or (p.kv=p.kv2))
      and o.ref=p.ref
      and o.ref not in (select p1.ref
                        from oper p1
                        where p1.ref=p.ref
                          and ((p1.nlsa like '1101%'  and
                                (p1.nlsb like '3902%' or p1.nlsb like '3903%' or
                                 p1.nlsb like '3906%' or p1.nlsb like '3907%')) OR
                               ((p1.nlsa like '3902%' or p1.nlsa like '3903%' or
                                 p1.nlsa like '3906%' or p1.nlsa like '3907%') and
                                 p1.nlsb like '1101%')) )
      and p.ref=w.ref(+)
      and w.tag(+) LIKE '%KURS%' ) b
where b.pds2<>0 or b.pks2<>0
group by b.ref, b.acc3800, b.acc, b.nls, b.kv, b.fdat, b.kurs,
         b.datd, b.branch, b.userid;

CURSOR tval IS
    SELECT  t.kv, POWER(10,t.dig), r.bsum, r.rate_o
    FROM tabval t, cur_rates r
    WHERE t.kv=r.kv                 AND
          t.kv in (959,961,962,964) AND
          r.vdate IN (SELECT max(rr.vdate) FROM cur_rates rr
                      WHERE rr.kv=r.kv and rr.vdate<=dat_);

CURSOR Basel IS
   SELECT nbuc, kodp, SUM(TO_NUMBER (znap)),
          SUM (TO_NUMBER (znap_pr))
   FROM (SELECT a.nbuc NBUC, a.kodp KODP,
                a.znap ZNAP, '0' ZNAP_PR
         FROM RNBU_TRACE a
         WHERE SUBSTR (a.kodp, 1, 1) = '1'
         UNION ALL
         SELECT a.nbuc NBUC, '1'||substr(a.kodp,2,6) KODP,
                '0' ZNAP, a.znap ZNAP_PR
         FROM RNBU_TRACE a
         WHERE SUBSTR (a.kodp, 1, 1) = '3')
   GROUP BY nbuc, kodp;

-----------------------------------------------------------------------
function f_div(p_kurs_ in number, p_rate_ in number) return number is
         dv_ number;
    begin
       dv_ := round(p_kurs_ / p_rate_,0);

       if dv_ < 5 then
          dv_ := 1;
       elsif dv_ > 5 and dv_ < 50 then
          dv_ := 10;
       elsif dv_ between 50 and 150 then
          dv_ := 100;
       else
          dv_ := 1000;
       end if;

       return dv_;
    end;
BEGIN
-------------------------------------------------------------------
userid_ := user_id;

DELETE FROM RNBU_TRACE WHERE userid = userid_;
-------------------------------------------------------------------
mfo_ := F_OURMFO();

p_proc_set(kodf_,sheme_,nbuc1_,typ_);
Datp_ := calc_pdat(dat_);

--
OPEN tval;
LOOP
   FETCH tval INTO kv_, dig_, bsu_, rate_o_;
   EXIT WHEN tval%NOTFOUND;

   VVV:=lpad(kv_,3,'0');

-- Покупка/продажа металлов
OPEN OPER959;
LOOP
   FETCH oper959 INTO ref_, acc3800_, acc_, nls_, kv1_, data_, kurs_,
                      datd_, branch_, userid1_, sum1_, sum0_, sun1_, sun0_;
   EXIT WHEN oper959%NOTFOUND ;

      BEGIN
         SELECT nls
            into nls3800_
         FROM accounts
         WHERE acc = acc3800_;
      EXCEPTION WHEN NO_DATA_FOUND THEN
         null;
      END;

      comm_ := '';

-- определяем базовую сумму введенных курсов
      if kurs_ is not null 
      then
         begin
            buf_ := to_number(kurs_);
         exception when others then
            if sqlcode=-6502 then
               raise_application_error(-20001,'Помилка: введений курс м_стить не числове значення (ref='||ref_||', kurs='''||kurs_||''')');
            else
               raise_application_error(-20002,'Помилка: (ref=' || ref_ || ', kurs= ' || kurs_ || sqlerrm);
            end if;
         end;

         div_ := f_div( kurs_ , rate_o_ / bsu_);
      end if;

-- покупка
   IF sum1_>0 AND sun1_>0 AND sum1_ <> sun1_ 
   THEN
      -- определяем код области
      if typ_ > 0 
      then
         nbuc_ := nvl(f_codobl_tobo(acc_,typ_),nbuc1_);
      else
         nbuc_ := nbuc1_;
      end if;


      if dat_ < to_date('10112008','ddmmyyyy') 
      then
         ddd_:='210';
      else
         BEGIN
            SELECT substr(trim(value),1,2)
               INTO d#44_
            FROM operw
            WHERE ref = ref_ AND tag = 'D#44';
         EXCEPTION WHEN NO_DATA_FOUND THEN
            BEGIN
               SELECT to_char(b.type_), NVL(b.cena_nomi,0)
                  INTO d#44_, cena_nomi_
               FROM bank_metals b, operw w
               WHERE w.ref = ref_
                 AND w.tag = 'BM__C'
                 AND b.kod = trim(w.value);
            EXCEPTION WHEN NO_DATA_FOUND THEN
                 d#44_ := '14';
            END;
         END;

         if substr(d#44_,1,1) = '2' or d#44_ = '2' 
         then  
            ddd_ := '410';
         elsif substr(d#44_,1,1)='3' then
            ddd_ := '510';
         elsif substr(d#44_,1,1)='4' then
            if cena_nomi_ <> 0 then
               ddd_ := '610';
            else
               ddd_ := '410';
            end if;
         else
            ddd_ := '310';
         end if;
      end if;

      -- объем
      a_ := '1' || ddd_ || VVV ;
      b_ := TO_CHAR(sum1_) ;

      INSERT INTO rnbu_trace (nls, kv, odate, kodp, znap, ref, comm, nbuc) VALUES
                             (nls_, kv_, datd_, a_, b_, ref_, comm_, nbuc_) ;

      -- курс
      a_ := '4' || ddd_ || VVV ;
      if kurs_ is null then -- розрахований курс
         if mfo_=333368 then
            BEGIN
               SELECT NVL(sum(p.s*100),0)
                  into sum_eqv_
               from provodki p, vp_list v
               where p.fdat = Dat_
                 and p.isp = userid1_
                 and p.kv = 980
                 and v.acc3800 = acc3800_
                 and p.acck = v.acc3801;
            EXCEPTION WHEN NO_DATA_FOUND THEN
               BEGIN
                  select rate_o
                     into kurs1_
                  from cur_rates$base
                  where vdate = datd_
                    and kv = kv1_
                    and branch = branch_;
               EXCEPTION WHEN NO_DATA_FOUND THEN
                  null;
               END;
            END;
            if sum_eqv_ <> 0 
            then
               if sum1_ = 8 then
                  kol_ := 1;
               else
                  kol_ := 0;
               end if;

               b_ := ltrim(TO_CHAR((sum_eqv_/(round(sum1_*31.1/100,kol_))*31.1034807/100),fmt_));
               comm_ := comm_||' курс розрахований '||b_||
                        ' сума екв. = '||to_char(sum_eqv_/100,'999999999999D00');
            else
               b_ := ltrim(TO_CHAR(kurs1_,fmt_));
               comm_ := comm_||' курс вибраний iз таблицi курсiв '||b_;
            end if;
         else
            b_ := LTRIM(TO_CHAR(ROUND(sun1_*bsu_/sum1_,5)*dig_/dl_,fmt_));
            comm_ := comm_ || ' курс розрахований ' || b_;
         end if;
      else -- введений курс
         b_ := ltrim(TO_CHAR(to_number(kurs_)*bsu_/dl_,fmt_));
         comm_ := comm_ || ' курс введений в док-тi ' || b_;
      end if;

--      b_:=LTRIM(TO_CHAR(ROUND(sun1_*bsu_/sum1_,5)*dig_/dl_,fmt_));

      INSERT INTO rnbu_trace (nls, kv, odate, kodp, znap, ref, comm, nbuc) VALUES
               		     (nls_, kv_, datd_, a_, b_, ref_, comm_, nbuc_) ;

      -- объем**курс
      a_ := '3' || ddd_ || VVV;
      b_ := TO_CHAR(sum1_*b_);

      INSERT INTO rnbu_trace (nls, kv, odate, kodp, znap, ref, comm, nbuc) VALUES
                             (nls_, kv_, datd_, a_, b_, ref_, comm_, nbuc_);
   END IF;

-- продажа
   IF sum0_>0 AND sun0_>0 AND sum0_ <> sun0_ 
   THEN
      -- определяем код области
      if typ_>0 
      then
         nbuc_ := nvl(f_codobl_tobo(acc_,typ_),nbuc1_);
      else
         nbuc_ := nbuc1_;
      end if;

      if dat_ < to_date('10112008','ddmmyyyy') 
      then
         ddd_ := '220';
      else
         BEGIN
            SELECT substr(trim(value),1,2)
               INTO d#44_
            FROM operw
            WHERE ref = ref_ AND tag = 'D#44';
         EXCEPTION WHEN NO_DATA_FOUND THEN
            BEGIN
               SELECT to_char(b.type_), NVL(b.cena_nomi,0)
                  INTO d#44_, cena_nomi_
               FROM bank_metals b, operw w
               WHERE w.ref = ref_
                 AND w.tag = 'BM__C'
                 AND b.kod = trim(w.value);
            EXCEPTION WHEN NO_DATA_FOUND THEN
               d#44_ := '17';
            END;
         END;

         if substr(d#44_,1,1) = '2' or d#44_ = '2' 
         then  
            ddd_ := '420';
         elsif substr(d#44_,1,1) = '3' then
            ddd_:='520';
         elsif substr(d#44_,1,1) = '4' then
            if cena_nomi_ <> 0 then
               ddd_ := '620';
            else
               ddd_ := '420';
            end if;
         else
            ddd_ := '320';
         end if;
      end if;

      -- объем
      a_ := '1' || ddd_ || VVV ;
      b_ := TO_CHAR(sum0_) ;

      INSERT INTO rnbu_trace (nls, kv, odate, kodp, znap, ref, comm, nbuc) VALUES
                      	     (nls_, kv_, datd_, a_, b_, ref_, comm_, nbuc_) ;

      -- курс
      a_ := '4' || ddd_ || VVV ;
      if kurs_ is null 
      then
         if mfo_=333368 
         then
            BEGIN
               SELECT NVL(sum(p.s*100),0)
                  into sum_eqv_
               from provodki p, vp_list v
               where p.fdat = Dat_
                 and p.isp = userid1_
                 and p.kv = 980
                 and v.acc3800 = acc3800_
                 and p.acck = v.acc3801;
            EXCEPTION WHEN NO_DATA_FOUND THEN
               BEGIN
                  select rate_o
                     into kurs1_
                  from cur_rates$base
                  where vdate = datd_
                    and kv = kv1_
                    and branch = branch_;
               EXCEPTION WHEN NO_DATA_FOUND THEN
                  null;
               END;
            END;
            if sum_eqv_ <> 0 
            then
               if sum0_ = 8 then
                  kol_ := 1;
               else
                  kol_ := 0;
               end if;

               b_ := ltrim(TO_CHAR((sum_eqv_/(round(sum0_*31.1/100,kol_))*31.1034807/100),fmt_));
               comm_ := comm_||' курс розрахований '||b_||
                        ' сума екв. = '||to_char(sum_eqv_/100,'999999999999D00') ;
            else
               b_ := ltrim(TO_CHAR(kurs1_,fmt_));
               comm_ := comm_||' курс вибраний iз таблицi курсiв '||b_;
            end if;
         else
            b_ := LTRIM(TO_CHAR(ROUND(sun0_*bsu_/sum0_,5)*dig_/dl_,fmt_)) ;
            comm_ := comm_ || ' курс розрахований ' || b_;
         end if;
      else
         b_ := ltrim(TO_CHAR(to_number(kurs_)*bsu_/dl_,fmt_));
         comm_ := comm_ || ' курс введений в док-тi ' || b_;
      end if;

--      b_:=LTRIM(TO_CHAR(ROUND(sun0_*bsu_/sum0_,5)*dig_/dl_,fmt_)) ;

      INSERT INTO rnbu_trace (nls, kv, odate, kodp, znap, ref, comm, nbuc) VALUES
                             (nls_, kv_, datd_, a_, b_, ref_, comm_, nbuc_) ;

      -- объем**курс
      a_ := '3' || ddd_ || VVV;
      b_ := TO_CHAR(sum0_*b_);

      INSERT INTO rnbu_trace (nls, kv, odate, kodp, znap, ref, comm, nbuc) VALUES
                             (nls_, kv_, datd_, a_, b_, ref_, comm_, nbuc_);
   END IF;
END LOOP;
CLOSE oper959;
END LOOP;
CLOSE tval;
----------------------------------------------------
DELETE FROM tmp_irep where kodf=kodf_ and datf=dat_;
----------------------------------------------------
OPEN basel;
   LOOP
      FETCH basel
      INTO nbuc_, kodp_, sum0_, sum1_;
      EXIT WHEN basel%NOTFOUND;

      IF sum0_<>0 then

         -- сумма
         kv_:=to_number(substr(kodp_,5,3));

         dig_:=f_ret_dig(kv_);

         b_ := TO_CHAR(ROUND(to_number(sum0_)/dig_,0));

         INSERT INTO tmp_irep
              (kodf, datf, kodp, nbuc, znap)
         VALUES
              (kodf_, Dat_, kodp_, nbuc_, b_) ;

         -- курс
         b_ := LTRIM(TO_CHAR(ROUND(sum1_/sum0_,4),fmt_));

         INSERT INTO tmp_irep
              (kodf, datf, kodp, nbuc, znap)
         VALUES
              (kodf_, Dat_, '4'||substr(kodp_,2,6), nbuc_, b_) ;
      end if;

   END LOOP;
CLOSE basel;

   DELETE FROM RNBU_TRACE
      WHERE userid = userid_ AND
            kodp like '3%';

----------------------------------------
END p_f39sb;
/
show err;

PROMPT *** Create  grants  P_F39SB ***
grant EXECUTE                                                                on P_F39SB         to BARS_ACCESS_DEFROLE;
grant EXECUTE                                                                on P_F39SB         to RPBN002;
grant EXECUTE                                                                on P_F39SB         to WR_ALL_RIGHTS;



PROMPT ===================================================================================== 
PROMPT *** End *** ========== Scripts /Sql/BARS/Procedure/P_F39SB.sql =========*** End *** =
PROMPT ===================================================================================== 
