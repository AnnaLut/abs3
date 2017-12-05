

PROMPT ===================================================================================== 
PROMPT *** Run *** ========== Scripts /Sql/BARS/Procedure/P_F39_NN.sql =========*** Run *** 
PROMPT ===================================================================================== 


PROMPT *** Create  procedure P_F39_NN ***

  CREATE OR REPLACE PROCEDURE BARS.P_F39_NN (Dat_ DATE, sheme_ varchar2 default 'G')  IS
/*%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
% DESCRIPTION :	Процедура формирование файла #39 для КБ (универсальная)
% COPYRIGHT   :	Copyright UNITY-BARS Limited, 1999.All Rights Reserved.
% VERSION     : 06/11/2017 (01/06/2016, 24/09/2015)
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
    параметры: Dat_ - отчетная дата
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
Изменеиия:
             Версия только для мульти МФО (Сбербанк области) !!!
06/11/2017   удалил блоки для закрытых МФО
01/06/2016   добавил условие and o2.fdat = o.fdat в курсорах 
             OPERVAL, OPER959
24/09/2015   дополнительно выбираем проводки для 3800 и OB22 = '03'
             (замечание Киевгорода)
14/10/2014   исключаем проводки для NLSA like '390%' or NLSB like '390%'
             (было включено в какой-то версии и не включено в текущей)
             закоментарил "*+parallel(o) parallel(v)*" в ГОУ висело
12/01/2012   не выбираем проводки для 3800 OB22='10' и Кт 1001(1002)
             назначение платежа "передан"  (замечание Луганска)
22/12/2011   доработка для Надр: если курс не введен, то берем его из
             официального курса и подправила вывод счета в протокол 
             (при выкупе центов неправильно отображался счет)
17/11/2011   выбираем проводки для 3800 и OB22 in ('10','11','12')
             (в Луганске включались проводки с OB22='20' в OPER 
              Дт 3907(980) --> Кт 1001(840) передана валюта)
27/10/2011   оптимизация запросов 
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%*/
kodf_    varchar2(2):='39';
fmt_     varchar2(20):='999990D0000';
--mn_      number:=100; -- для валютообменных операций в кассе, если курс в OPERW за единицу валюты
dl_      number:=100; -- для металлов
DatP_	 date; -- дата начала выходных дней, кот. предшествуют заданой дате
buf_	 number;

count_   number;
flag_    number;
typ_     number;
kv_      number;
kv1_     number;
ref_     number;
ref1_    number;
nls_     varchar2(15);
nlsd_    varchar2(15);
nlsk_    varchar2(15);
nls1_    varchar2(15);
nlsb_    varchar2(15);
mfo_     Varchar2(12);
mfoa_    Varchar2(12);
mfob_    Varchar2(12);
mfou_    Number;
data_    date;
datd_    date;
kol_     number;
dig_     number;
bsu_     number;
sum_     number;
sum1_    number;
sum0_    number;
sun1_    number;
sun0_    number;
kodp_    varchar2(10);
kodp1_   varchar2(10);
znap_    varchar2(30);
VVV      varchar2(3) ;
ddd39_   varchar2(3) ;
d39_     varchar2(200) ;
kurs_    varchar2(200) ;
kurs1_   Number(9,4);
tag_     varchar2(5) ;
a_       varchar2(20);
b_       varchar2(20);
userid_  number;
nbuc1_   varchar2(12);
nbuc_    varchar2(12);
acc_     number;
accd_    number;
acck_    number;
pr_      number;
rate_o_  number;
div_     number;
comm_    varchar2(200);
branch_  varchar2(30);

-- в банке "Киев" из СБОНа приходят проводки Дт 1002 Кт 3800 выкуп центов и
-- поэтому должно быть условие decode(p.tt,o.tt,decode(p.kv2,a.kv,p.s,p.s2)
-- которое убрал 22.12.2006 тестируя процедуру в УПБ
-- возвратил 27.03.2007
--Валютообменные операции по кассе
CURSOR OPERVAL IS
select b.ref, b.acc, b.nls, b.kv, b.fdat, b.kurs, b.datd, b.branch,
   sum(b.ds), sum(b.ks),
   sum(b.pds2) dsq, sum(b.pks2) ksq
from
(select   --/*+parallel(o) parallel(v)*/ 
         a.acc, p.tt ptt, o.tt ott, 
         a.nls, a.kv, o.fdat, p.ref,
	     translate(w.value,',','.') kurs, p.datd, p.branch,
         decode (o2.dk, 0, o.s, 0) ds,
         decode (o2.dk, 1, o.s, 0) ks,
         decode(o2.dk,0,decode(p.tt,o.tt,decode(p.kv2,a.kv,p.s,p.s2),
         f_d3801(p.ref,o.tt,v.ACC3801,o2.dk,v.ACC_RRD,v.ACC_RRR)),0) pds2,
         decode(o2.dk,1,decode(p.tt,o.tt,decode(p.kv2,a.kv,p.s,p.s2),
         f_d3801(p.ref,o.tt,v.ACC3801,o2.dk,v.ACC_RRD,v.ACC_RRR)),0) pks2
from opldok o, vp_list v, opldok o2, accounts a, oper p, operw w
where o.fdat = Dat_     
      and o2.fdat = o.fdat  
      and o.tt not in ('BAK')
      and o.sos = 5
      and o.acc = v.ACC3800
      and o.ref = o2.ref
      and o.dk != o2.dk
      and o.tt = o2.tt
      and o.stmt = o2.stmt
      and o2.acc = a.acc
      and a.nls like '100%'
      and a.kv = kv_ and ((p.kv != 980 and p.kv2=980) or
                          (p.kv=980 and p.kv2 != 980) or
                          (p.kv = p.kv2))
      and o.ref = p.ref
      and p.sos = 5
      and p.nlsa not like '390%' and p.nlsb not like '390%'
      and ((o2.tt = p.tt and NOT exists (select 1
                  from operw z
                  where p.ref = z.ref and
                        z.tag in ('D#73','73'||o2.tt) and
                        substr(z.value,1,3) in ('220','221','222','223','270',
                                                '321','322','325','323','370')))
           OR
           (o2.tt != p.tt and NOT exists (select 1
                  from operw z
                  where p.ref = z.ref and
                        z.tag = '73'||o2.tt and
                        substr(z.value,1,3) in ('220','221','222','223','270',
                                                '321','322','325','323','370'))))
      and p.ref = w.ref(+)
      and w.tag(+) LIKE 'KURS%'
union
select  --/*+parallel(o) parallel(v)*/ 
     a.acc, p.tt ptt, o.tt ott, 
     a.nls, 
     a.kv, o.fdat, p.ref,
	 null kurs, p.datd, p.branch,
         decode (o2.dk, 0, o.s, 0) ds,
         decode (o2.dk, 1, o.s, 0) ks,
         decode(o2.dk,0,f_d3801(p.ref,o.tt,v.ACC3801,o2.dk,v.ACC_RRD,v.ACC_RRR),0) pds2,
         decode(o2.dk,1,f_d3801(p.ref,o.tt,v.ACC3801,o2.dk,v.ACC_RRD,v.ACC_RRR),0) pks2
from opldok o, vp_list v, opldok o2, accounts a, oper p, operw w
where o.fdat = Dat_     
      and o2.fdat = o.fdat
      and o.tt not in ('BAK')
      and o.sos = 5
      and o.acc = v.ACC3800
      and o.ref = o2.ref
      and o.dk != o2.dk
      and o.tt = o2.tt
      and o.stmt = o2.stmt
      and o2.acc = a.acc
      and a.nls like '100%'
      and a.kv = kv_ and ((p.kv != p.kv2 and p.kv != 980 and p.kv2 != 980))
      and o.ref = p.ref
      and p.sos = 5
      and p.nlsa not like '390%' and p.nlsb not like '390%'
      and ((o2.tt = p.tt and NOT exists (select 1
                  from operw z
                  where p.ref=z.ref and
                        z.tag in ('D#73','73'||o2.tt) and
                        substr(z.value,1,3) in ('220','221','222','223','270',
                                                '321','322','325','323','370')))
           OR
           (o2.tt != p.tt and NOT exists (select 1
                  from operw z
                  where p.ref=z.ref and
                        z.tag = '73'||o2.tt and
                        substr(z.value,1,3) in ('220','221','222','223','270',
                                                '321','322','325','323','370'))))
      and p.ref = w.ref(+)
      and w.tag(+) LIKE 'KURS%') b
where b.pds2 != 0 or b.pks2 != 0
group by b.ref, b.acc, b.nls, b.kv, b.fdat, b.kurs, b.datd, b.branch;

-- покупка/продажа металлов
CURSOR OPER959 IS
select b.acc, b.nls, b.kv, b.fdat,
   sum(b.ds), sum(b.ks),
   sum(b.pds2) dsq, sum(b.pks2) ksq
from
(select   /*+parallel(o) parallel(v)*/ 
     a.acc, p.tt ptt, o.tt ott, p.nlsa nls, a.kv, o.fdat,
     decode (o2.dk, 0, o.s, 0) ds,
     decode (o2.dk, 1, o.s, 0) ks,
	 decode(o2.dk,0,f_d3801(p.ref,o.tt,v.ACC3801,o2.dk,v.ACC6204,v.ACC6204),0) pds2,
	 decode(o2.dk,1,f_d3801(p.ref,o.tt,v.ACC3801,o2.dk,v.ACC6204,v.ACC6204),0) pks2
from opldok o, vp_list v, opldok o2, accounts a, oper p
where o.fdat = Dat_   
      and o2.fdat = o.fdat
      and o.tt not in ('BAK')
      and o.sos = 5
      and o.acc = v.ACC3800
      and o.ref = o2.ref
      and o.dk != o2.dk
      and o.tt = o2.tt
      and o.stmt = o2.stmt
      and o2.acc = a.acc
      and a.nls like '110%'
      and a.kv = kv_ and ((p.kv != 980 and p.kv2=980) or (p.kv=980 and p.kv != 980) or (p.kv=p.kv2))
      and o.ref = p.ref
      and p.sos = 5) b
where b.pds2 != 0 or b.pks2 != 0
group by b.acc, b.nls, b.kv, b.fdat;

-- покупка/продажа безналичной валюты
CURSOR OPL_DOK IS
   SELECT a.acc, a.nls, a.kv, a1.acc, a1.nls, o.ref, o.mfoa, o.mfob,
          c.fdat, k.tag, k.value, translate(p.value,',','.'), sum(c.s)
   FROM accounts a, accounts a1, opldok c, opldok c1, oper o, operw k, operw p
   WHERE a.kv != 980                AND
         a.acc =c.acc               AND
         a.nls not like '8%'        AND
         c.fdat = dat_              AND
         c.dk = 0                   AND
         c.sos = 5                  AND
         a1.acc = c1.acc            AND
         c1.dk = 1-c.dk             AND
         c.stmt = c1.stmt           AND
         c.tt not in ('FX3','FX4','NOS') AND
         c.ref = k.ref              AND
         c.ref = o.ref              AND
         o.sos = 5                  AND
         (k.tag = 'D#39' AND substr(k.value,1,3) in ('112','122'))  AND
         c.ref = p.ref              AND
         p.tag LIKE 'KURS%'         AND
         SUBSTR(LOWER(TRIM(o.nazn)),1,4) != 'конв'
GROUP BY a.acc, a.nls, a.kv, a1.acc, a1.nls, o.ref, o.mfoa, o.mfob,
         c.fdat, k.tag, k.value, translate(p.value,',','.')
ORDER BY 1, 2, 3, 9, 10;

CURSOR tval IS
    SELECT  t.kv, POWER(10,t.dig), r.bsum, r.rate_o
    FROM tabval t, cur_rates r   -- cur_rates$base
    WHERE t.kv = r.kv              AND
          t.kv != 980              AND
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
   GROUP BY nbuc, kodp
   ORDER BY nbuc, kodp;

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
commit;

EXECUTE IMMEDIATE 'ALTER SESSION ENABLE PARALLEL DML';
EXECUTE IMMEDIATE 'alter session set NLS_NUMERIC_CHARACTERS = ''.,'' ';
-------------------------------------------------------------------
logger.info ('P_F39_NN: Begin for datf = '||to_char(dat_, 'dd/mm/yyyy'));
-------------------------------------------------------------------
userid_ := user_id;

EXECUTE IMMEDIATE 'TRUNCATE TABLE RNBU_TRACE';
-------------------------------------------------------------------
mfo_ := F_OURMFO();

-- МФО "родителя"
   BEGIN
      SELECT NVL(trim(mfou), mfo_)
        INTO mfou_
      FROM BANKS
      WHERE mfo = mfo_;
   EXCEPTION
      WHEN NO_DATA_FOUND
      THEN
         mfou_ := mfo_;
   END;

p_proc_set(kodf_,sheme_,nbuc1_,typ_);
Datp_ := calc_pdat(dat_);

--
OPEN tval;
LOOP
   FETCH tval INTO kv_, dig_, bsu_, rate_o_;
   EXIT WHEN tval%NOTFOUND;

   VVV:=lpad(kv_,3,'0');

-- покупка/продажа наличной валюты (валютообменные операции по кассе)
   OPEN OPERVAL;
   LOOP
      FETCH operval INTO ref_, acc_, nls_, kv1_, data_, kurs_,
                         datd_, branch_, sum1_, sum0_, sun1_, sun0_;
      EXIT WHEN operval%NOTFOUND ;

      comm_ := '';
      flag_ := 0;

      select count(*)
         into count_
      from holiday
      where holiday = datd_
        and kv = 980;

      begin
         select count(*)
            into flag_
         from provodki_otc
         where ref=ref_
           and fdat=dat_
           and ((nlsd like '3800%' and exists (select 1 from specparam_int sp
                                               where sp.acc=accd 
                                                 and sp.ob22 not in ('03','10','11','12'))) or 
                (nlsk like '3800%' and exists (select 1 from specparam_int sp1
                                               where sp1.acc=acck 
                                                 and sp1.ob22 not in ('03','10','11','12'))));
      exception when others then
         flag_ := 0;
      end;

      if flag_ = 0 
      then
         begin
            select count(*)
               into flag_
            from provodki_otc
            where ref=ref_
              and fdat=dat_
              and ((nlsd like '3800%' and exists (select 1 from specparam_int sp
                                                  where sp.acc=accd 
                                                    and sp.ob22 in ('10'))
                    and LOWER(trim(nazn)) like '%передан%') or 
                   (nlsk like '3800%' and exists (select 1 from specparam_int sp1
                                                  where sp1.acc=acck 
                                                    and sp1.ob22 not in ('10'))
                    and LOWER(trim(nazn)) like '%передан%'));
         exception when others then
            flag_ := 0;
         end;
      end if; 
   
      if flag_ = 0
      then
         -- определяем базовую сумму введенных курсов
         if kurs_ is not null 
         then
            begin
               buf_ := to_number(kurs_);
            exception when others then
               if sqlcode=-6502 then
                  raise_application_error(-20001,'Помилка: введений курс містить не числове значення (ref='||ref_||', kurs='''||kurs_||''')');
               else
                  raise_application_error(-20002,'Помилка: '||sqlerrm);
               end if;
            end;

            div_ := f_div( kurs_ , rate_o_ / bsu_);
         end if;

         -- определяем код области
         if typ_>0 
         then
            nbuc_ := nvl(f_codobl_tobo(acc_,typ_),nbuc1_);
         else
            nbuc_ := nbuc1_;
         end if;

         IF (dat_ < to_date('01082008','ddmmyyyy') and kv_ != 0) OR
            (dat_ >= to_date('01082008','ddmmyyyy') and kv_ not in (959,961,962,964))
         THEN

            -- покупка наличной валюты
            IF sum1_>0 AND sun1_>0 
            THEN
               -- объем
               a_:='1210' || VVV;
               b_:=TO_CHAR(sum1_);

               INSERT INTO rnbu_trace (nls, kv, odate, kodp, znap, nbuc, ref, comm) VALUES
                                      (nls_, kv_, datd_, a_, b_, nbuc_, ref_, comm_);

               -- курс
               a_:='4210' || VVV;
               if kurs_ is null     -- розрахований курс
               then 
                  if mfou_ = 300465 and mfou_ != mfo_  
                  then
                     if count_ = 0 
                     then
                        BEGIN
                           select rate_b
                              into kurs1_
                           from cur_rates$base
                           where vdate in (select max(r.vdate)
                                           from cur_rates$base r
                                           where r.vdate <= decode(mfo_,351823,datd_-1,datd_))
                             and kv=kv1_
                             and branch=branch_;
                        EXCEPTION WHEN NO_DATA_FOUND THEN
                           null;
                        END;
                     else
                        BEGIN
                           select rate_b
                              into kurs1_
                           from cur_rates$base
                           where vdate in (select min(r.vdate)
                                           from cur_rates$base r
                                           where r.vdate > decode(mfo_,351823,datd_-1,datd_))
                             and kv=kv1_
                             and branch=branch_;
                        EXCEPTION WHEN NO_DATA_FOUND THEN
                           null;
                        END;
                     end if;
                     b_:=ltrim(TO_CHAR(kurs1_,fmt_));
                     comm_ := comm_||' курс вибраний iз таблицi курсiв '||b_;
                  else
                     b_:=LTRIM(TO_CHAR(ROUND(sun1_*bsu_/sum1_,4),fmt_));
                     comm_ := comm_ || ' курс розрахований ' || b_;
                  end if;
               else -- введений курс
                  b_:=ltrim(TO_CHAR(to_number(kurs_)*bsu_/div_,fmt_));
                  comm_ := comm_ || ' курс введений в док-тi ' || b_;
               end if;

               INSERT INTO rnbu_trace (nls, kv, odate, kodp, znap, nbuc, ref, comm) VALUES
                                      (nls_, kv_, datd_, a_, b_, nbuc_, ref_, comm_);
              
               -- объем**курс
               a_:='3210' || VVV;
               b_:=TO_CHAR(sum1_*b_);

               INSERT INTO rnbu_trace (nls, kv, odate, kodp, znap, nbuc, ref) VALUES
                                      (nls_, kv_, datd_, a_, b_, nbuc_, ref_);
            END IF;

            -- продажа наличной валюты
            IF sum0_>0 AND sun0_>0 
            THEN
               -- объем
               a_:='1220' || VVV;
               b_:=TO_CHAR(sum0_);

               INSERT INTO rnbu_trace (nls, kv, odate, kodp, znap, nbuc, ref, comm) VALUES
                                      (nls_, kv_, datd_, a_, b_, nbuc_, ref_, comm_);

               -- курс
               a_:='4220' || VVV ;

               if kurs_ is null 
               then

                  if mfou_ = 300465 and mfou_ != mfo_  
                  then
                     if count_ = 0 
                     then
                        BEGIN
                           select rate_s
                              into kurs1_
                           from cur_rates$base
                           where vdate in (select max(r.vdate)
                                           from cur_rates$base r
                                           where r.vdate <= decode(mfo_,351823,datd_-1,datd_))
                             and kv=kv1_
                             and branch=branch_;
                        EXCEPTION WHEN NO_DATA_FOUND THEN
                           null;
                        END;
                     else
                        BEGIN
                           select rate_s
                              into kurs1_
                           from cur_rates$base
                           where vdate in (select min(r.vdate)
                                           from cur_rates$base r
                                           where r.vdate > decode(mfo_,351823,datd_-1,datd_))
                             and kv=kv1_
                             and branch=branch_;
                        EXCEPTION WHEN NO_DATA_FOUND THEN
                           null;
                        END;
                     end if;

                     b_:=ltrim(TO_CHAR(kurs1_,fmt_));
                     comm_ := comm_||' курс вибраний iз таблицi курсiв '||b_;
                  else
                     b_:=LTRIM(TO_CHAR(ROUND(sun0_*bsu_/sum0_,4),fmt_));
                     comm_ := comm_ || ' курс розрахований ' || b_;
                  end if;
               else
                  b_:=ltrim(TO_CHAR(to_number(kurs_)*bsu_/div_,fmt_));
                  comm_ := comm_ || ' курс введений в док-тi ' || b_;
               end if;

               INSERT INTO rnbu_trace (nls, kv, odate, kodp, znap, nbuc, ref, comm) VALUES
                                      (nls_, kv_, datd_, a_, b_, nbuc_, ref_, comm_);

               -- объем**курс
               a_:='3220' || VVV;
               b_:=TO_CHAR(sum0_*b_);

               INSERT INTO rnbu_trace (nls, kv, odate, kodp, znap, nbuc, ref) VALUES
                                      (nls_, kv_, datd_, a_, b_, nbuc_, ref_);
            END IF;
         END IF;
      end if;
   END LOOP;
   CLOSE operval;

   if dat_ < to_date('01082008','ddmmyyyy') 
   THEN
      -- Покупка/продажа металлов
      -- отменено формирование с 01.08.2008
      OPEN OPER959;
      LOOP
         FETCH oper959 INTO acc_, nls_, kv1_, data_, sum1_, sum0_, sun1_, sun0_;
         EXIT WHEN oper959%NOTFOUND ;

         -- определяем код области
         if typ_>0 
         then
            nbuc_ := nvl(f_codobl_tobo(acc_,typ_),nbuc1_);
         else
            nbuc_ := nbuc1_;
         end if;

         -- покупка
         IF sum1_>0 AND sun1_>0 
         THEN
            -- объем
            a_:='1210' || VVV ;
            b_:=TO_CHAR(sum1_) ;

            INSERT INTO rnbu_trace (nls, kv, odate, kodp, znap,nbuc) VALUES
                                   (nls_, kv_, data_, a_, b_, nbuc_) ;

            -- курс
            a_:='4210' || VVV ;
            b_:=LTRIM(TO_CHAR(ROUND(sun1_*bsu_/sum1_,5)*dig_/dl_,fmt_));

            INSERT INTO rnbu_trace (nls, kv, odate, kodp, znap, nbuc) VALUES
                                   (nls_, kv_, data_, a_, b_, nbuc_) ;

            -- объем**курс
            a_:='3210' || VVV;
            b_:=TO_CHAR(sum1_*b_);

            INSERT INTO rnbu_trace (nls, kv, odate, kodp, znap,nbuc) VALUES
                                   (nls_, kv_, data_, a_, b_, nbuc_);
         END IF;

         -- продажа
         IF sum0_>0 AND sun0_>0 
         THEN
            -- объем
            a_:='1220' || VVV ;
            b_:=TO_CHAR(sum0_) ;

            INSERT INTO rnbu_trace (nls, kv, odate, kodp, znap, nbuc) VALUES
                                   (nls_, kv_, data_, a_, b_, nbuc_) ;

            -- курс
            a_:='4220' || VVV ;
            b_:=LTRIM(TO_CHAR(ROUND(sun0_*bsu_/sum0_,5)*dig_/dl_,fmt_)) ;

            INSERT INTO rnbu_trace (nls, kv, odate, kodp, znap, nbuc) VALUES
                                   (nls_, kv_, data_, a_, b_, nbuc_) ;

            -- объем**курс
            a_:='3220' || VVV;
            b_:=TO_CHAR(sum0_*b_);

            INSERT INTO rnbu_trace (nls, kv, odate, kodp, znap,nbuc) VALUES
                                   (nls_, kv_, data_, a_, b_, nbuc_);
         END IF;
      END LOOP;
      CLOSE oper959;
   end if;
END LOOP;
CLOSE tval;
------------------------------------------------------
-- межбанк  только до 01.01.2010
if dat_ < to_date('01012010','ddmmyyyy') 
then
   OPEN OPL_DOK;
   LOOP
      FETCH OPL_DOK INTO accd_, nls_, kv_, acck_, nlsk_, ref_, mfoa_, mfob_,
                         data_, tag_, d39_, kurs_, sum1_ ;
      EXIT WHEN OPL_DOK%NOTFOUND;

      IF (dat_ < to_date('01082008','ddmmyyyy') and kv_ != 0) OR
         (dat_ >= to_date('01082008','ddmmyyyy') and kv_ not in (959,961,962,964))
      THEN

         kol_:=0;
         IF mfoa_ != mfob_ 
         THEN
            SELECT count(*) INTO kol_ FROM v_branch
            WHERE mfob_=mfo and mfo != mfou;
         END IF;

         select nlsb into nlsb_ from oper where ref=ref_;

         IF SUM1_ != 0 and (substr(nlsb_,1,4)='2600' or not ((d39_='112' and
                          '3901' in (substr(nls_,1,4), substr(nlsk_,1,4)) and
                           mfoa_=mfob_) or
                         (d39_='122' and kol_ != 0))) 
         then

            VVV:=lpad(kv_,3,'0');

            IF substr(tag_,1,4)='D#39' 
            THEN
               -- покупка или продажа?
               IF substr(nls_,1,4)='3800' and d39_='112' 
               THEN
                  d39_:='122';
               END IF;

               IF d39_='112' 
               THEN
                  nls1_:=nlsk_;
                  acc_:=acck_;
               ELSE
                  nls1_:=nls_;
                  acc_:=accd_;
               END IF;

               -- определяем код области
               if typ_>0 
               then
                  nbuc_ := nvl(f_codobl_tobo(acc_,typ_),nbuc1_);
               else
                  nbuc_ := nbuc1_;
               end if;

               ddd39_:= substr(d39_,1,3);
               ref1_:=ref_ ;

               -- объем
               kodp_:= '1' || ddd39_ || VVV ;
               znap_:= TO_CHAR(SUM1_) ;

               INSERT INTO rnbu_trace (nls, kv, odate, kodp, znap, nbuc) VALUES
                                      (nls1_, kv_, data_, kodp_,znap_,nbuc_);

               -- официальный курс по данной валюте
               begin
                  SELECT  r.bsum, r.rate_o
                     into bsu_, rate_o_
                  FROM cur_rates r
                  WHERE r.kv = kv_               AND
                        r.vdate IN (SELECT max(rr.vdate) FROM cur_rates rr
                                    WHERE rr.kv=kv_ and rr.vdate<=dat_);
               exception
                  when no_data_found then
                  rate_o_ :=  kurs_;
                  bsu_ := 1;
               end;

               if kurs_='1' 
               then
                  kurs_ := rate_o_;
               end if;
               -- курс
               kodp_:= '4' || ddd39_ || VVV ;

               begin
                  buf_ := to_number(kurs_);
               exception
                  when others then
                  if sqlcode=-6502 then
                     raise_application_error(-20003,'Помилка: введений курс містить не числове значення (acc='||acc_||', kurs='''||kurs_||''')');
                  else
                     raise_application_error(-20004,'Помилка: '||sqlerrm);
                  end if;
               end;

               div_ := f_div( kurs_ , rate_o_ / bsu_);

               znap_:= ltrim(TO_CHAR(to_number(kurs_)*bsu_/div_,fmt_));

               INSERT INTO rnbu_trace (nls, kv, odate, kodp, znap, nbuc) VALUES
                                      (nls1_, kv_, data_, kodp_, znap_, nbuc_);

               -- объем**курс
               kodp_:='3' || ddd39_ || VVV;
               znap_:=TO_CHAR(sum1_*to_number(znap_));

               INSERT INTO rnbu_trace (nls, kv, odate, kodp, znap,nbuc) VALUES
                                      (nls1_, kv_, data_, kodp_, znap_, nbuc_);
            end if;
         END IF;
      END IF;
   END LOOP;
   CLOSE OPL_DOK;
end if;
---------------------------------------------------
DELETE FROM tmp_nbu where kodf=kodf_ and datf=dat_;
---------------------------------------------------
OPEN basel;
   LOOP
      FETCH basel
      INTO nbuc_, kodp_, sum0_, sum1_;
      EXIT WHEN basel%NOTFOUND;

      IF sum0_ != 0 
      then
         -- сумма
         kv_:=to_number(substr(kodp_,5,3));

         dig_:=f_ret_dig(kv_);

         b_ := TO_CHAR(ROUND(to_number(sum0_)/dig_,0));

         INSERT INTO tmp_nbu
              (kodf, datf, kodp, znap, nbuc)
         VALUES
              (kodf_, Dat_, kodp_, b_, nbuc_) ;

         -- курс
         b_ := LTRIM(TO_CHAR(ROUND(sum1_/sum0_,4),fmt_));

         INSERT INTO tmp_nbu
              (kodf, datf, kodp, znap, nbuc)
         VALUES
              (kodf_, Dat_, '4'||substr(kodp_,2,6), b_, nbuc_) ;
      end if;

   END LOOP;
CLOSE basel;

DELETE FROM OTCN_TRACE_39
         WHERE datf= dat_ AND isp = userid_ ;

insert into OTCN_TRACE_39(DATF, USERID, NLS, KV, ODATE, KODP, ZNAP, NBUC, ISP, RNK, ACC, REF, COMM, ND, MDATE, TOBO)
select dat_, USERID_, NLS, KV, ODATE, KODP, ZNAP, NBUC, ISP, RNK, ACC, REF, COMM, ND, MDATE, TOBO
from rnbu_trace;

DELETE FROM RNBU_TRACE
WHERE userid = userid_ AND
    kodp like '3%';

----------------------------------------
logger.info ('P_F39_NN: End for datf = '||to_char(dat_, 'dd/mm/yyyy'));
END p_f39_NN;
/
show err;

PROMPT *** Create  grants  P_F39_NN ***
grant EXECUTE                                                                on P_F39_NN        to WR_ALL_RIGHTS;



PROMPT ===================================================================================== 
PROMPT *** End *** ========== Scripts /Sql/BARS/Procedure/P_F39_NN.sql =========*** End *** 
PROMPT ===================================================================================== 
