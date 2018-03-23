

PROMPT ===================================================================================== 
PROMPT *** Run *** ========== Scripts /Sql/BARS/Procedure/P_F20.sql =========*** Run *** ===
PROMPT ===================================================================================== 


PROMPT *** Create  procedure P_F20 ***

  CREATE OR REPLACE PROCEDURE BARS.P_F20 (Dat_ DATE, sheme_ varchar2 default 'G' )  IS
/*%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
% DESCRIPTION :    Процедура формирование файла #20 для КБ
% COPYRIGHT   :    Copyright UNITY-BARS Limited, 1999.All Rights Reserved.
%
% VERSION     :     v.17.002      20.12.2017
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
    параметры: Dat_ - отчетная дата

   Структура показателя    DDDDDDDD

 1     DDDDDDDD          список показателей по stru_20

%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%/%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%

20.12.2017 новый список показателей, замена разбивки с R013 на R011
01.12.2017 сокращен список значений DDDDDDDD
11.01.2016 в курсоре SALDO убрал таблицу(view) CUST_ACC
31.12.2014 за 31.12.2014 не будут формироваться отдельные показатели
           в рос.рублях (код валюты 643)
           с 31.12.2014 коды 821-877 не будут формироваться
26.09.2014 для бал.счетов 1416,1417 добавлены строки 83814171,83914171
           в кл-р KL_F20 и затем при R016 in ('10','90')
           они включаются в файл с показателями 83214171, 83314161
17.06.2014 формируем в разрезе кодов территорий
26.11.2013 Добавлена обработка параметра R016
05.11.2012 добавлено формирование кодов "41714001", "41814001"
31.10.2012 изменил формирование новых показателей 751-757, 761-767
           в кл-ре KL_F20 изменил параметр S181='X' для 1410,1420
           и добавил в для 1410 строку для инвалюты
04.07.2012 с 02.07.2012 введены новые показатели 751-757, 761-767
30.05.2012 с 01.04.2012 выделены показатели для валюты 643 и поэтому для
           показателей с кодом DDD in (192,193) и валюта 643 формируем
           коды DDD (392,393) и для кодов 801-820 и валюта 643 формируем
           коды DDD (901-920)
15.09.2010 для УПБ(mfou_=300205) ?не формируем показатель 99900000"
18.05.2010 для Сбербанка (mfou_=300465) не формируем показатель "99900000"
22.10.2008 добавлена обработка новых кодов 721-738 ЦБ проверка даты
           погашения остатка
26.06.2008 в 115 строке заменил условие k030 in ('X', rez_) на
           k030 in ('X', to_char(rez_)) (k030- символ, rez_ - число)
           (не выполнялось формирование в Сбербанке)
05.01.2008 используется отдельный классификатор KL_F20  вместо KL_F3_29
24.11.2007 добавлены коды 092, 192 (б/с 2700,2701,2706,2707 нерезиденты
           и R013='2')
27.02.2007 для бал.счета 2600 добавлена обработка значений параметра
          R013  '5','6','7' (ранее было '1','2','9')
10.05.2006 добавлено формирование новых кодов 031,032,041,042,043,044,
046,047,048,049,050,051,131,132,141,142,143,144,146,146,148,149,150,151
нужен новый вариант кл-ра для #20 скрипт KL_F20.sql
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%*/

kodf_     Varchar2(2) := '20';
kodp_     varchar2(10);
znap_     varchar2(30);

acc_      Number;
nbs_      varchar2(4);
nls_      varchar2(15);
data_     date;
mdate_    date;
kv_       SMALLINT;
t020_     Varchar2(1);
rez_      NUMBER;

r031_     VARCHAR2(1);
se_       DECIMAL(24);
r011_     varchar2(1);
r013_     varchar2(1);

ddd_      varchar2(8);
userid_   Number;
mfo_      NUMBER;
mfou_     NUMBER;
typ_      number;
nbuc_     varchar2(12);
nbuc1_    varchar2(12);

-------------------------------------------------------------------
CURSOR SALDO IS
   SELECT a.acc, a.nls, a.kv, dat_, a.nbs, a.mdate, 2-mod(c.codcagent,2),
          decode(a.kv,980,'1','2'), nvl(cc.r011,'9'), nvl(cc.r013,'9'),
          fostq(a.acc, Dat_)
   FROM accounts a,
        customer c, specparam cc
   WHERE a.nbs in (select distinct r020 from kl_f20 where kf='20')
     AND a.acc=cc.acc(+)
     AND c.rnk=a.rnk ;

CURSOR BaseL IS
   SELECT kodp, nbuc, SUM (ABS(znap))
   FROM rnbu_trace
   WHERE userid=userid_
   GROUP BY kodp, nbuc;

BEGIN
-------------------------------------------------------------------
userid_ := user_id;
logger.info ('P_F20: Begin for datf = '||to_char(dat_, 'dd/mm/yyyy'));
EXECUTE IMMEDIATE 'TRUNCATE TABLE RNBU_TRACE';
-------------------------------------------------------------------
   mfo_ := f_ourmfo ();

-- МФО "родителя"
   BEGIN
      SELECT mfou
         INTO mfou_
      FROM banks
      WHERE mfo = mfo_;
   EXCEPTION
      WHEN NO_DATA_FOUND
      THEN
         mfou_ := mfo_;
   END;

   -- определение начальных параметров (код области или МФО или подразделение)
   P_Proc_Set(kodf_,sheme_,nbuc1_,typ_);
   nbuc_ := nbuc1_;

   OPEN SALDO;
   LOOP
      FETCH SALDO INTO acc_, nls_, kv_, data_, nbs_, mdate_, rez_, r031_,
                       r011_, r013_, se_ ;
      EXIT WHEN SALDO%NOTFOUND;
   
      IF typ_ >0 THEN
         nbuc_ := NVL(F_Codobl_Tobo(acc_,typ_),nbuc1_);
      ELSE
         nbuc_ := nbuc1_;
      END IF;
   
      if se_ < 0 then
         t020_ := '1';
      else
         t020_ := '2';
      end if;

      IF  (nbs_='2601' and r011_ in ('4','5')     and se_>0 )  OR
          (nbs_='2701' and r011_ in ('1','2','3') and se_>0 )  OR
          (nbs_='2706' and r011_ in ('1','2','3') )
      THEN

         BEGIN
            SELECT ddd    into ddd_
            FROM kl_f20
            WHERE kf ='20'
              and r020 = nbs_
              and t020 = t020_
              and k030 = 'X'
              and r031 in ('X', r031_)
              and s181 = 'X'
              and r013 in ('X', r011_)
              and rownum = 1 ;
         EXCEPTION WHEN NO_DATA_FOUND THEN
            ddd_ :='99900000';
         END ;

         if ddd_ != '99900000'  then

             kodp_ := trim(ddd_) ;
             znap_ := to_char(ABS(se_)) ;

             INSERT INTO rnbu_trace
                       ( nls, kv, odate, kodp, znap, nbuc, comm)
                VALUES ( nls_, kv_, data_, kodp_, znap_, nbuc_,
                         't020='||t020_||' r031='||r031_||' r011='||r011_ ) ;
         end if;

      END IF;

   END LOOP;

CLOSE SALDO;

---------------------------------------------------
DELETE FROM tmp_nbu where kodf='20' and datf= dat_;
---------------------------------------------------
OPEN BaseL;
LOOP
   FETCH BaseL INTO  kodp_, nbuc_, znap_;
   EXIT WHEN BaseL%NOTFOUND;

   IF znap_<>0 THEN
      INSERT INTO tmp_nbu
                ( kodf, datf, kodp, znap, nbuc)
         VALUES ( kodf_, Dat_, kodp_, znap_, nbuc_);
   END IF;

END LOOP;
CLOSE BaseL;
----------------------------------------
   logger.info ('P_F20: END ');
END p_f20;
/
show err;

PROMPT *** Create  grants  P_F20 ***
grant EXECUTE                                                                on P_F20           to BARS_ACCESS_DEFROLE;
grant EXECUTE                                                                on P_F20           to RPBN002;
grant EXECUTE                                                                on P_F20           to WR_ALL_RIGHTS;



PROMPT ===================================================================================== 
PROMPT *** End *** ========== Scripts /Sql/BARS/Procedure/P_F20.sql =========*** End *** ===
PROMPT ===================================================================================== 
