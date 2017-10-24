

PROMPT ===================================================================================== 
PROMPT *** Run *** ========== Scripts /Sql/BARS/Procedure/P_F78_NN.sql =========*** Run *** 
PROMPT ===================================================================================== 


PROMPT *** Create  procedure P_F78_NN ***

  CREATE OR REPLACE PROCEDURE BARS.P_F78_NN (Dat_ DATE, sheme_ Varchar2 DEFAULT 'G' )  IS
/*%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
% DESCRIPTION : Процедура формирования #78 для КБ
% COPYRIGHT   : Copyright UNITY-BARS Limited, 1999.  All Rights Reserved.
% VERSION     : 08/07/2016 (10/06/2016, 29/03/2016)
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
параметры: Dat_ - отчетная дата
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
08/07/2016 добавлено формирование показателя 73 если S180='0'
10/06/2016 убрал формирования кода 73 при балансировке остатков по
           счетам резерва
29/03/2016 для показателя 7310XX, 7320XX (теперішня вартість) будем
           выбирать значение поля PVQ вместо PV
15/03/2016 для показателя 7310XX, 7320XX (теперішня вартість)
           убрал расчет этого показателя как разницу Bvq - Rezq
28/01/2016 для поля REZQ добавил NVL т.к. в некоторых РУ было NULL
20/01/2016 отменяем все условия для даты 31.12.2015
           будем формировать файл как было ранее
15/01/2016 сумму резерва для даты 31.12.2015 выбираем из даты 01.12.2015
10/01/2016 сумму резерва выбираем не из поля REZQ а из поля REZQ23
11/06/2015 изменен блок выравнивания показателей резерва 3010+3020
           с файлом #02 (бал.счета 1890,2890,3590,3599)
03/03/2015 добавил условие "rownum =1" для определения max суммы
           по счетам резерва (строка 412)
24/02/2015 показатель 73 формируем как разницу между BVQ - REZQ
           будем формировать разницу округлений по счетам резерва
           и корректировать код 73 на эту разницу
05/12/2014 для показателя резерва код области будем определять по ACC
           счета резерва (поле NVL(ACC_REZ,ACC_REZN) )
           т.к. код области в #78 не совпадает с кодом области в #02
14/05/2014 для отбора счетов из NBU23_REZ добавлено условие
           "NVL(nb.acc_rez, nb.acc_rezn) is not null" только для ID not
           like 'DEB%'
05/05/2014 для отбора счетов из NBU23_REZ добавлено условие
           "NVL(nb.acc_rez, nb.acc_rezn) is not null"
           т.к. сумма резерва для группы 357 (бал.сч 3599) не совпадает
           с данными файла #02
09/10/2013 добавлено формирование показателя 7230ХХ теперішня вартість
           для неризикових
27/09/2013 до господарської дебiторської заборгованост? в?дносяться
           рахунки 3510, 3519, 3550, 3551, 3552, 3559
17/09/2013 добавлено формирование нового показателя 7130000
           "дебiторська заборгованiсть за якою формування резерву не
           вимагається"   (бал.рах. 2805,2806)
04/07/2013 добавил условие ID like 'DEB%' для отбора из NBU23_REZ
06/02/2013 для 380764 параметр S180 присваиваем определенные значения
           добавлены бал.счета 1819, 3551
02/02/2013 для 380764 параметр S180 присваиваем определенные значения
           по конкретным балансовым счетам
26/01/2012 формируем показатели только из таблицы NBU23_REZ
22/01/2013 исключил бал.счет 2805, 2806
17/01/2013 показатель 73 формируем как и 72 показатель
           для показателя 3020 будет формироваться нулевое значения s180
16/01/2013 до господарської дебiторської заборгованост? в?дносяться
           рахунки 3510, 3519, 3550, 3551
15/01/2013 изменил формирование параметра S180 для HH='20'- S180='0'.
14/01/2013 вместо S240 будем формировать S180
13/01/2013 исключил формирование нулевых значений показателей
11/01/2013 для кода DDD='312' S240 всегда формировался "0". Исправил.
10/01/2013 балансову вартiсть вибираем из таблицы NBU23_REZ т.к. остаток
           по одному счету может б?ть разбит на несколько частей сосвоей
           категорией качества
05/01/2013 новая структура показателя с 01.01.2013
19/09/2012 при PR_TOBO<>0 формируем в разрезе кодов территорий
06/09/2012 выбираем отдельно остатки в номинале и эквиваленте и отдельно
           корректирующие проводки в номинале и эквиваленте как и в #02
           и затем остатки формируем с учетом коректирующих формируем
           отдельно для валюты 980 и инвалюты
           т.к. в некоторых случаях остатки не совпадают с файлом #02
03/11/2011 добавила вивід параметру S080 в протокол формування (+ ACC)
27.02.2009 для бал.счетов 2801, 3541 формируем код 81 при R011='2'
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%*/
kodf_    VARCHAR2(2):='78';
nbuc1_   VARCHAR2(12);
nbuc_    VARCHAR2(20);
typ_     NUMBER;
sql_acc_ VARCHAR2(2000):='';
ret_     NUMBER;

acc_     NUMBER;
acc1_    NUMBER;
kold_    NUMBER;
ddd_     VARCHAR2(3);
gr_nbs_  VARCHAR2(3);
nbs_     VARCHAR2(4);
nls_     VARCHAR2(15);
nlsk_    VARCHAR2(15);
r012_    VARCHAR2(1);
s080_    VARCHAR2(1);
s180_    VARCHAR2(1);
s240_    VARCHAR2(1);
r011_    VARCHAR2(1);
hh_      VARCHAR2(2);
data_    DATE;
dat1_    DATE;
dat2_    DATE;
datp_    DATE;
datz_    DATE;
Ost_     DECIMAL(24);
Ostq_    DECIMAL(24);
sn_      DECIMAL(24);
se_      DECIMAL(24);
Bv_      DECIMAL(24);
Pv_      DECIMAL(24);
Zal_     DECIMAL(24);
kat23_   Varchar2(1);
Dosek_   DECIMAL(24);
Kosek_   DECIMAL(24);
Dosnk_   DECIMAL(24);
Kosnk_   DECIMAL(24);
cust_    SMALLINT;
Kv_      NUMBER;
kodp_    VARCHAR2(11);
kodp1_   VARCHAR2(11);
znap_    VARCHAR2(30);
f78_     SMALLINT;
gr_r_    NUMBER;
dog_     CHAR(1);
nbu_     SMALLINT;
prem_    CHAR(3);
userid_  NUMBER;
mfo_     Number;
mfou_    Number;
tobo_    accounts.tobo%TYPE;
nms_     otcn_acc.nms%TYPE;
comm_    rnbu_trace.comm%TYPE;
pvq_     Number;

CURSOR BaseL IS
    SELECT kodp, nbuc, SUM (znap)
    FROM RNBU_TRACE
    WHERE userid=userid_
    GROUP BY kodp, nbuc;

BEGIN
----------------------------------------------------------------------------------------------
userid_ := user_id;

EXECUTE IMMEDIATE 'TRUNCATE TABLE RNBU_TRACE';
----------------------------------------------------------------------------------------------
-- свой МФО
mfo_ := F_Ourmfo ();

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

Dat1_  := TRUNC(add_months(Dat_,1),'MM');

-- определение начальных параметров (код области или МФО или подразделение)
P_Proc_Set(kodf_,sheme_,nbuc1_,typ_);
----------------------------------------------------------------------------------------------
-- с 01.01.2013 новая структура показателя и новые данные для файла
-- выбираем из таблицы NBU23_REZ
if Dat_ >= to_date('29122012','ddmmyyyy') then

sql_acc_ := 'select r020 from kod_r020 where a010=''C5''
                and r020 in (''1890'',''2890'',''3590'',''3599'') ';

-- отбор остатков и корректирующих проводок
   ret_ := F_Pop_Otcn(Dat_, 2, sql_acc_);

   for k in ( SELECT nb.rnk, nb.acc, nb.nls, nb.kv, nb.nbs, nb.nd, nb.id, nb.FDAT,
                     NVL(nb.kat, NVL(p.s080,'0')) KAT23, NVL(p.r011,'1'),
                     DECODE( NVL(Trim (p.s180), '0'), '0', Fs180 (nb.acc, substr(nb.nls, 1, 1), dat_), p.s180) S180,
                     NVL(nb.BVQ*100,0) BV, NVL(nb.PVQ*100,0) PV, /*NVL(nb.BV*100,0)*(1-nb.k) PV,*/
                     NVL(nb.ZAL*100,0) ZAL, NVL(round(nb.rezq*100,0),0) rezq,
                     NVL(nb.ddd,'000') DDD,
                     NVL(nb.acc_rez, nb.acc_rezn) acc_rez,
                     DECODE(nb.nbs,'3510','20','3519','20',
                                   '3550','20','3551','20',
                                   '3552','20','3559','20',
                                   '2805','30','2806','30','10') hh
              FROM  nbu23_rez nb, SPECPARAM p
              WHERE nb.fdat = dat1_
                and nb.acc = p.acc(+)
                and (nb.ddd like '31%' or nb.id like 'DEB%' or nb.nbs like '3548%')
            )

      loop

      comm_ := 'ID= '||k.id||' RNK= '||k.rnk||' ND= '||k.nd||' DDD= '||k.ddd;

      kat23_ := k.kat23;
      s180_  := k.s180;

      if mfou_ = 380764 then
         if k.nbs in ('3510','3519','3550','3551') then
            s180_ := '0';
         elsif k.nbs in ('3548','3552','3559') then
            s180_ := '1';
         elsif k.nbs in ('1819') then
            s180_ := '2';
         elsif k.nbs in ('2809','3540') then
            s180_ := '3';
         elsif k.nbs in ('3570','3578','3579') then
            s180_ := '5';
         else
            null;
         end if;
      end if;

      if k.hh in ('20','30') then
         s180_ := '0';
      end if;

      IF k.Bv <> 0 OR k.Pv <> 0 THEN

         IF typ_>0 THEN
            nbuc_ := NVL(F_Codobl_Tobo(k.acc,typ_),nbuc1_);
         ELSE
            nbuc_ := nbuc1_;
         END IF;

         if kat23_ = '0' then
            BEGIN
               select NVL(trim(kat),'0')
                  into kat23_
               from acc_deb_23
               where acc = acc_;
            EXCEPTION WHEN NO_DATA_FOUND THEN
               NULL;
            END;
         end if;

         if k.hh = '30' then
            kat23_ := '0';
         end if;

         if k.Bv <> 0 then
            kodp_:='71' || k.hh || s180_ || kat23_ ;   -- s240_ было до 14.01.2013 изменили на s180_
            znap_:= TO_CHAR(ABS(k.Bv)) ;
            INSERT INTO RNBU_TRACE (nls, kv, odate, kodp, znap, acc, comm, nbuc, rnk, nd)
              VALUES (k.nls, k.kv, dat_, kodp_, znap_, k.acc, comm_, nbuc_, k.rnk, k.nd);
         end if;

         if k.Pv <> 0 and k.hh = '10' and s180_ not in ('0','1','2','3','4','5','6') then
            kodp_ := '72' || k.hh || s180_ || kat23_ ;   -- s240_ было до 14.01.2013 изменили на s180_
            znap_ := TO_CHAR(k.Pv);  --TO_CHAR(GL.p_ICURVAL(k.kv, ABS(k.Pv), dat_)) ;
            INSERT INTO RNBU_TRACE (nls, kv, odate, kodp, znap, acc, comm, nbuc, rnk, nd)
              VALUES (k.nls, k.kv, dat_, kodp_, znap_, k.acc, comm_, nbuc_, k.rnk, k.nd);
         end if;

         if k.Pv <> 0 and k.hh = '30' then
            kodp_:='72' || k.hh || s180_ || kat23_ ;   -- s240_ было до 14.01.2013 изменили на s180_
            znap_ := TO_CHAR(k.Pv);  --TO_CHAR(GL.p_ICURVAL(k.kv, ABS(k.Pv), dat_)) ;
            INSERT INTO RNBU_TRACE (nls, kv, odate, kodp, znap, acc, comm, nbuc, rnk, nd)
              VALUES (k.nls, k.kv, dat_, kodp_, znap_, k.acc, comm_, nbuc_, k.rnk, k.nd);
         end if;

         if ABS(k.Pv) <> 0 and k.hh = '10' and s180_ in ('0','1','2','3','4','5','6') then
            kodp_:='73' || k.hh || s180_ || kat23_ ;   -- s240_ было до 14.01.2013 изменили на s180_
            --znap_:= TO_CHAR(GL.p_ICURVAL(k.kv, ABS(k.Pv), dat_)) ;
            --znap_:= TO_CHAR(ABS(k.Bv) - ABS(k.rezq));
            -- 15/03/2016 убрал разницу ABS(k.Bv) - ABS(k.rezq)
            znap_ := TO_CHAR(k.Pv);
            INSERT INTO RNBU_TRACE (nls, kv, odate, kodp, znap, acc, comm, nbuc, rnk, nd)
              VALUES (k.nls, k.kv, dat_, kodp_, znap_, k.acc, comm_, nbuc_, k.rnk, k.nd);
         end if;

         if ABS(k.Pv) <> 0 and k.hh = '20' and s180_ = '0' then
            kodp_:='73' || k.hh || s180_ || kat23_ ;   -- s240_ было до 14.01.2013 изменили на s180_
            --znap_:= TO_CHAR(GL.p_ICURVAL(k.kv, ABS(k.Pv), dat_)) ;
            --znap_:= TO_CHAR(ABS(k.Bv) - ABS(k.rezq));
            -- 15/03/2016 убрал разницу ABS(k.Bv) - ABS(k.rezq)
            znap_ := TO_CHAR(k.Pv);
            INSERT INTO RNBU_TRACE (nls, kv, odate, kodp, znap, acc, comm, nbuc, rnk, nd)
              VALUES (k.nls, k.kv, dat_, kodp_, znap_, k.acc, comm_, nbuc_, k.rnk, k.nd);
         end if;

         -- сума резерву
         if k.rezq <> 0 then

            IF k.acc_rez is not null THEN
               nbuc_ := NVL(F_Codobl_Tobo(k.acc_rez,typ_),nbuc_);
            END IF;

            kodp_:= '30' || k.hh || s180_ || kat23_ ;   -- k.s240 было до 14.01.2013 изменили на k.s180
            znap_:= TO_CHAR(ABS(k.rezq));

            INSERT INTO rnbu_trace (nls, kv, odate, kodp, znap, acc, comm, nbuc, rnk, nd)
            VALUES (k.nls, k.kv, dat_, kodp_, znap_, k.acc, comm_, nbuc_, k.rnk, k.nd);
         end if;

      end if;

    end loop;

    -- блок для формирования разницы остатков по счетам 1890,2890,3590,3599
       for k in (select a.nbs, a.kv,
                     sum(a.Ost) Ostn, sum(a.Ostq) Ostq,
                     sum(a.Dos96) dos96, sum(a.Kos96) Kos96,
                     sum(a.Dosq96) Dosq96, sum(a.Kosq96) kosq96,
                     NVL(F_Codobl_Tobo (a.acc, typ_), nbuc1_) nbuc
              from otcn_saldo a
              where a.nbs in ('1890','2890','3590','3599')
                and (a.Ost-a.Dos96+a.Kos96 <> 0  or a.Ostq-a.Dosq96+a.Kosq96<>0)
              group by a.nbs, a.kv, NVL(F_Codobl_Tobo (a.acc, typ_), nbuc1_)
              order by 9,1,2)
       loop

       IF k.kv <> 980 THEN
          se_:=k.Ostq - k.Dosq96 + k.Kosq96;
       ELSE
          se_:=k.Ostn - k.Dos96 + k.Kos96;
       END IF;

       if k.nbs = '1890' then
          gr_nbs_ := '181';
          select NVL(sum(to_number(r.znap)),0)
             into sn_
          from rnbu_trace r
          where (r.kodp like '3010%' or r.kodp like '3020%')
            and substr(nls,1,3) = '181'
            and kv = k.kv
            and nbuc = k.nbuc;
       end if;

       if k.nbs = '2890' then
          gr_nbs_ := '280';
          select NVL(sum(to_number(r.znap)),0)
             into sn_
          from rnbu_trace r
          where (r.kodp like '3010%' or r.kodp like '3020%')
            and substr(nls,1,3) = '280'
            and kv = k.kv
            and nbuc = k.nbuc;
       end if;

       if k.nbs = '3590' then
          gr_nbs_ := '351';
          select NVL(sum(to_number(r.znap)),0)
             into sn_
          from rnbu_trace r
          where (r.kodp like '3010%' or r.kodp like '3020%')
            and substr(nls,1,3) in ('351','355')
            and kv = k.kv
            and nbuc = k.nbuc;
       end if;

       if k.nbs = '3599' then
          gr_nbs_ := '357';
          select NVL(sum(to_number(r.znap)),0)
             into sn_
          from rnbu_trace r
          where (r.kodp like '3010%' or r.kodp like '3020%')
            and substr(nls,1,3) = '357'
            and kv = k.kv
            and nbuc = k.nbuc;
       end if;

       -- формируем разницу остатков
       if se_ <> sn_ and ABS(se_ - sn_) <= 100 then
          znap_ := to_char(se_ - sn_);
          comm_ := 'Рiзниця залишкiв по бал.рах. ' || k.nbs || ' валюта = ' ||
                   lpad(to_char(k.kv),3,'0') ||
                   ' залишок по балансу = ' ||to_char(ABS(se_)) ||
                   ' сума в файлi =  ' || to_char(sn_);

          BEGIN
             select nls, kv, kodp, nbuc
                INTO nls_, kv_, kodp_, nbuc_
             from rnbu_trace
             where znap = ( select max(to_number(r1.znap))
                            from rnbu_trace r1
                            where (r1.kodp like '3010%' or r1.kodp like '3020%')
                              and substr(r1.nls,1,3) = gr_nbs_
                              and r1.kv = k.kv
                              and r1.nbuc = k.nbuc
                              and exists ( select 1 from rnbu_trace r2
                                           where r2.nls = r1.nls
                                             and r2.kv  = r1.kv
                                             and r2.kodp like '73'||substr(r1.kodp,3,4)||'%'
                                         )
                              and rownum = 1
                          )
               and (kodp like '3010%' or kodp like '3020%')
               and substr(nls,1,3) = gr_nbs_
               and kv = k.kv
               and nbuc = k.nbuc
               and rownum = 1;

             INSERT INTO rnbu_trace
               (nls, kv, odate, kodp, znap, comm, nbuc)
             VALUES
               (nls_, k.kv, dat_, kodp_, znap_, comm_, nbuc_);

             --INSERT INTO rnbu_trace
             --  (nls, kv, odate, kodp, znap, comm, nbuc)
             --VALUES
             --  (nls_, k.kv, dat_, '73'||substr(kodp_,3,4), 0-znap_, comm_, nbuc_);
          EXCEPTION WHEN NO_DATA_FOUND THEN
             null;
          END;

       end if;

       end loop;
end if;
----------------------------------------------------------------------------------------------
DELETE FROM TMP_NBU WHERE kodf = kodf_ AND datf = dat_;
---------------------------------------------------------------------------------------------
OPEN BaseL;
LOOP
   FETCH BaseL INTO  kodp_, nbuc_, znap_;
   EXIT WHEN BaseL%NOTFOUND;
   INSERT INTO TMP_NBU
        (kodf, datf, kodp, znap, nbuc)
   VALUES
        (kodf_, Dat_, kodp_, znap_, nbuc_);
END LOOP;
CLOSE BaseL;
----------------------------------------
END P_F78_Nn;
/
show err;

PROMPT *** Create  grants  P_F78_NN ***
grant EXECUTE                                                                on P_F78_NN        to WR_ALL_RIGHTS;



PROMPT ===================================================================================== 
PROMPT *** End *** ========== Scripts /Sql/BARS/Procedure/P_F78_NN.sql =========*** End *** 
PROMPT ===================================================================================== 
