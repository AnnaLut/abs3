

PROMPT ===================================================================================== 
PROMPT *** Run *** ========== Scripts /Sql/BARS/Procedure/P_F20.sql =========*** Run *** ===
PROMPT ===================================================================================== 


PROMPT *** Create  procedure P_F20 ***

  CREATE OR REPLACE PROCEDURE BARS.P_F20 (Dat_ DATE, sheme_ varchar2 default 'G' )  IS
/*%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
% DESCRIPTION :    Процедура формирование файла #20 для КБ
% COPYRIGHT   :    Copyright UNITY-BARS Limited, 1999.All Rights Reserved.
%
% VERSION     :     v.17.001      01.12.2017
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
    параметры: Dat_ - отчетная дата

   Структура показателя    DDDDDDDD

 1     DDDDDDDD          список показателей по stru_20

%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%/%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
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
kodf_    Varchar2(2) := '20';
acc_      Number;
nbs_      varchar2(4);
nls_      varchar2(15);
data_     date;
mdate_    date;
kv_       SMALLINT;
t020_     Varchar2(1);
rez_      NUMBER;
r1410_980_ Number := 0;
r1420_980_ Number := 0;
r1410_840_ Number := 0;
r1420_840_ Number := 0;
r031_     VARCHAR2(1);
sn_       DECIMAL(24);
se_       DECIMAL(24);
kodp_     varchar2(10);
znap_     varchar2(30);
r011_     varchar2(1);
r013_     varchar2(1);
d020_     Varchar2(2);
r016_     Varchar2(2);
s180_     Varchar2(1);
s181_     Varchar2(1);
kod_ddd   number;
kod_r013  number;
ddd_      char(10);
userid_   Number;
mfo_      NUMBER;
mfou_     NUMBER;
typ_     number;
nbuc_    varchar2(12);
nbuc1_   varchar2(12);

-------------------------------------------------------------------
CURSOR SALDO IS
   SELECT a.acc, a.nls, a.kv, dat_, a.nbs, a.mdate, 2-mod(c.codcagent,2),
          decode(a.kv,980,'1','2'), nvl(cc.r011,'9'), nvl(cc.r013,'9'),
          TRIM(cc.s180), nvl(cc.r016,'00'),
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

   if dat_<=to_date('30092013','ddmmyyyy') then
      select trim(val)
         into r1410_980_
      from params
      where PAR like '1410_980%';

      select trim(val)
         into r1420_980_
      from params
      where PAR like '1420_980%';

      select trim(val)
         into r1410_840_
      from params
      where PAR like '1410_840%';

      select trim(val)
         into r1420_840_
      from params
      where PAR like '1420_840%';

      INSERT INTO rnbu_trace (nls, kv, odate, kodp, znap, comm) VALUES
                             ('75114101', 980, dat_, '75114101', r1410_980_,
                              'сума резерву цільових ОВДП на продаж 1410(980)');
      INSERT INTO rnbu_trace (nls, kv, odate, kodp, znap, comm) VALUES
                             ('76114201', 980, dat_, '76114201', r1420_980_,
                              'сума резерву цільових ОВДП до погашення 1420(980)');
      INSERT INTO rnbu_trace (nls, kv, odate, kodp, znap, comm) VALUES
                             ('75314103', 840, dat_, '75314103', r1410_840_,
                              'сума резерву цільових ОВДП на продаж 1410(840)');
   end if;

OPEN SALDO;
LOOP
   FETCH SALDO INTO acc_, nls_, kv_, data_, nbs_, mdate_, rez_, r031_,
                    r011_, r013_, s180_, r016_, se_ ;
   EXIT WHEN SALDO%NOTFOUND;

   IF typ_>0 THEN
      nbuc_ := NVL(F_Codobl_Tobo(acc_,typ_),nbuc1_);
   ELSE
      nbuc_ := nbuc1_;
   END IF;

   if (substr(nbs_,1,2) in ('14','31') and substr(nbs_,4,1) not in ('6','7') and r016_ in ('10','90','99')) OR
      (substr(nbs_,1,2) in ('14','31') and substr(nbs_,4,1) in ('6','7') and r016_ in ('10','90')) OR
      (substr(nbs_,1,2) not in ('14','31')) then

      if se_ < 0 then
         t020_ := '1';
      else
         t020_ := '2';
      end if;

      if s180_ is null then
         s180_ := FS180(acc_, substr(nbs_,1,1), dat_);
      end if;

      if s180_ in ('C','D','E','F','G','H') then
         s181_ := '2';
      else
         s181_ := '1';
      end if;

      IF ((nbs_='2600' and r031_ in ('1','2') and r013_='1' and se_>0 ) OR
          (nbs_='2604' and r031_ in ('1','2') and r013_='2')            OR
          (nbs_='2600' and r031_='2' and r013_<>'1' and se_>0 )         OR
--          (nbs_ in ('1001','1200') and r013_ in ('1','9'))              OR
          (nbs_ in ('2909','3739') and r031_='2')                       OR
--          (nbs_ in ('2700','2701') and rez_=2 )                         OR
          (nbs_ not in ('1001','1200','2600','2604','2909','3739')) )
      THEN

         if nbs_ in ('1406','1407','1416','1417','1426','1427','3016','3017',
                     '3116','3117','3216','3217') and r013_ <>'1' then
            r013_ := '1';  --r011_;
         end if;

         if nbs_ in ('1410','1420') and r013_ <> '1'
         then
            r013_ :='9';
         end if;

         BEGIN
            SELECT ddd
               INTO ddd_
            FROM kl_f20
            WHERE kf='20'
              and r020=nbs_
              and t020=t020_
              and k030 in ('X', to_char(rez_))
              and r031 in ('X', r031_)
              and s181 in ('X', s181_)
              and r013 in ('X', r013_)
              and rownum = 1 ;
         EXCEPTION WHEN NO_DATA_FOUND THEN
            ddd_:='99900000';
         END ;

         kod_ddd := to_number(substr(trim(ddd_),1,3));
         kod_r013:= to_number(substr(trim(ddd_),8,1));

         -- 14/05/2012 30/05/2012 добавил коды 801-820
         -- за 31/12/2014 не будут формироваться отдельные показатели в рос.рублях
         -- коды 392,393,901,902,903,904 ........
         if dat_ <= to_date('30122014','ddmmyyyy')
            and kv_ = 643
            and kod_ddd in (192,193,801,802,803,804,805,806,807,808,809,810,
                                    811,812,813,814,815,816,817,818,819,820 )
            and rez_ = 2
         then
            if kod_ddd in (192,193) then
               kod_ddd := kod_ddd + 200;
               ddd_ := to_char(kod_ddd) || substr(ddd_,4);
            else
               kod_ddd := kod_ddd + 100;
               ddd_ := to_char(kod_ddd) || substr(ddd_,4);
            end if;
         end if;

         if kod_ddd in (754) and kv_ = 840
         then
            kod_r013 := '4';
            ddd_ := to_char(kod_ddd) || substr(ddd_,4,4) || to_char(kod_r013);
         end if;

         if kod_ddd in (753,754,763,764) and kv_ = 978
         then
            kod_ddd := kod_ddd + 2;
            kod_r013 := kod_r013 + 2;
            ddd_ := to_char(kod_ddd) || substr(ddd_,4,4) || to_char(kod_r013);
         end if;

         if dat_<=to_date('30092013','ddmmyyyy') then
            if kod_ddd in (751,761) and kv_ = 980
            then
               kod_ddd := kod_ddd + 1;
               kod_r013 := kod_r013 + 1;
               ddd_ := to_char(kod_ddd) || substr(ddd_,4,4) || to_char(kod_r013);
            end if;

            if kod_ddd in (752,762) and kv_ = 980 and r013_='2'
            then
               kod_ddd := kod_ddd + 5;
               kod_r013 := kod_r013 + 5;
               ddd_ := to_char(kod_ddd) || substr(ddd_,4,4) || to_char(kod_r013);
            end if;

            if kod_ddd in (757,767)
            then
               ddd_ := to_char(kod_ddd) || substr(ddd_,4,4) || '7';
            end if;
         end if;

         if kod_ddd in (837,838,839,847) and r016_='10'
         then
            kod_ddd := kod_ddd - 6;
            ddd_ := to_char(kod_ddd) || substr(ddd_,4,4) || to_char(kod_r013);
         end if;

         if kod_ddd in (283,284) and r016_='20'
         then
            kod_r013 := kod_r013 - 4;
            ddd_ := to_char(kod_ddd) || substr(ddd_,4,4) || to_char(kod_r013);
         end if;

         if kod_ddd < 721 OR kod_ddd > 738 OR
            (kod_ddd >=721 and kod_ddd <=738 and
            mdate_ <= to_date('31122008','ddmmyyyy') and
            ((substr(nbs_,4,1) in ('6','7') and r011_='1') OR
              substr(nbs_,4,1)='0') ) then

            if (mfou_ in (300205) and ddd_ != '99900000') OR mfou_ not in (300205) then
               kodp_:= trim(ddd_) ;
               znap_:= TO_CHAR(ABS(se_)) ;
               INSERT INTO rnbu_trace (nls, kv, odate, kodp, znap, comm, nbuc) VALUES
                                      (nls_, kv_, data_, kodp_, znap_,
                                       't020='||t020_||' k030='||rez_||' r031='||r031_||
                                       ' s181='||s181_||' r013='||r013_, nbuc_ ) ;
            end if;

         end if;

         --if (ddd_ like '752%' OR ddd_ like '762%') then
         --   kodp_:= substr(ddd_,1,3) || substr(ddd_,4,4) || '7';
         --   znap_:= TO_CHAR(0-ABS(se_)) ;
         --   INSERT INTO rnbu_trace (nls, kv, odate, kodp, znap, comm) VALUES
         --                             (nls_, kv_, data_, kodp_, znap_,
         --                              't020='||t020_||' k030='||rez_||' r031='||r031_||
         --                              ' s181='||s181_||' r013='||r013_) ;
         --end if;

      END IF;

   end if;

END LOOP;

CLOSE SALDO;

-- для кодов 752, 762, 754
if dat_<=to_date('30092013','ddmmyyyy') then
   INSERT INTO rnbu_trace (nls, kv, odate, kodp, znap, comm) VALUES
                          ('75114102', 980, dat_, '75214102', -r1410_980_,
                           'сума резерву цільових ОВДП на продаж 1410(980)');
   INSERT INTO rnbu_trace (nls, kv, odate, kodp, znap, comm) VALUES
                          ('76114202', 980, dat_, '76214202', -r1420_980_,
                           'сума резерву цільових ОВДП до погашення 1420(980)');
   INSERT INTO rnbu_trace (nls, kv, odate, kodp, znap, comm) VALUES
                          ('75314103', 840, dat_, '75414104', -r1410_840_,
                           'сума резерву цільових ОВДП на продаж 1410(840)');

   -- для кодов 757, 767
   --INSERT INTO rnbu_trace (nls, kv, odate, kodp, znap, comm) VALUES
   --                       ('75114101', 980, dat_, '75714107', -r1410_980_,
   --                        'сума резерву цільових ОВДП на продаж 1410(980)');
   --INSERT INTO rnbu_trace (nls, kv, odate, kodp, znap, comm) VALUES
   --                       ('76114201', 980, dat_, '76714207', -r1420_980_,
   --                        'сума резерву цільових ОВДП до погашення 1420(980)');

   --INSERT INTO rnbu_trace (nls, kv, odate, kodp, znap, comm) VALUES
   --                       ('75314103', 840, dat_, '75414104', -r1410_840_,
   --                        'сума резерву цільових ОВДП на продаж 1410(840)')

   -- для кодов 417, 418
   INSERT INTO rnbu_trace (nls, kv, odate, kodp, znap, comm) VALUES
                          ('7511410+7611420', 980, dat_, '41714001', to_char(r1410_980_+r1420_980_),
                           'фiксована сума резерву ц_льових ОВДП 1410(980)+1420(980)');
   INSERT INTO rnbu_trace (nls, kv, odate, kodp, znap, comm) VALUES
                          ('7531410+7631420', 840, dat_, '41814001', to_char(r1410_840_+r1420_840_),
                           'фiксована сума резерву ц_льових ОВДП 1410(840)+1420(840)');
end if;

-- с 31.12.2014 коды  821-877 не должны формироваться
if dat_ >= to_date('31122014','ddmmyyyy')
then
   delete from rnbu_trace
   where substr(kodp,1,3) in ( '821','822','823','824','825','826','827','831',
                               '832','833','834','835','836','837','841','842',
                               '843','844','845','846','847','851','852','853',
                               '854','855','856','857','861','862','863','864',
                               '865','866','867','871','872','873','874','875',
                               '876','877'
                             );
end if;

--        с 01.12.2017 в файле остаются только нижеперечисленные коды
if dat_ >= to_date('01122017','ddmmyyyy')  then

   delete from rnbu_trace
   where substr(kodp,1,3) not in
         ( '058','059','158','159',         -- 2601
           '092','093','192','193',         -- 2700, 2701
           '717','817','719','819'          -- 2707, 2706
                             );
end if;
---------------------------------------------------
DELETE FROM tmp_nbu where kodf='20' and datf= dat_;
---------------------------------------------------
OPEN BaseL;
LOOP
   FETCH BaseL INTO  kodp_, nbuc_, znap_;
   EXIT WHEN BaseL%NOTFOUND;
   IF znap_<>0 THEN
   INSERT INTO tmp_nbu
        (kodf, datf, kodp, znap, nbuc)
   VALUES
        ('20', Dat_, kodp_, znap_, nbuc_);
   END IF;
END LOOP;
CLOSE BaseL;
----------------------------------------
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
