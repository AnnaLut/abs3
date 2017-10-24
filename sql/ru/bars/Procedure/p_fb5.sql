

PROMPT ===================================================================================== 
PROMPT *** Run *** ========== Scripts /Sql/BARS/Procedure/P_FB5.sql =========*** Run *** ===
PROMPT ===================================================================================== 


PROMPT *** Create  procedure P_FB5 ***

  CREATE OR REPLACE PROCEDURE BARS.P_FB5 (Dat_ DATE )  IS
/*%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
% DESCRIPTION :	Процедура формирования файла #B5 для КБ
% COPYRIGHT   :	Copyright UNITY-BARS Limited, 1999.All Rights Reserved.
% VERSION     : 12.07.2011 (06.04.11,03.03.11,11.02.11,25.01.11,20.01.11,
%             :             19.01.11,22.04.10,16.04.10,15.04.10,14.04.10)
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
параметры: Dat_ - отчетная дата

12.07.2011 для бал.сч.3599 опеределяем OB22 и если OB22 08,09,10
           то формируем код "DDD"=116 (замечание СБ Ровно)
06.04.2011 для mfou_=300465 и бал.счета 2548 анализируем параметр OB22
           (если OB22=02 то в показатель поточнi (220811X,220821X)
            все остальные OB22 в показатель 220810Х,220820Х)
03.03.2011 для mfou_<>300465 и бал.счета 2658 анализируем параметр R011
           (если R011=1,4,7 то на вимогу, если R011=5,6 то депозит)
11.02.2011 вместо выражения TRIM(SED) будем использовать NVL(trim(sed),'00')
           т.к. для бал.счетов 3578,3579 формировались показатели для ЮЛ
           вместо ФЛ.
25.01.2011 для бал.сч.1819 опеределяем OB22 и если OB22 не 02,04
           то формируем код "DDD"=108 (замечание СБ Харькова)
20.01.2011 к ЮЛ (kod_11_ := '11' или kod_11_='21') в 208 показатель
           "кошти на вимогу ЮО" добавил бал.сч. 2643 (замечание СБ Харьков)
19.01.2011 для бал.счетов 3578,3579 добавил проверку sed_ != '91'
           (пiдприємцi).
           Из ФЛ исключаем предпринимателей и включаем их ЮЛ.
22.04.2010 внесен новый комментарий  !!!
           для mfou_=300465 внесен весь перечень бал.счетов по которым
           определяем параметр OB22 и формируем коды не соответсвующие кодам
           в кл-ре (1518,1519,1526,1527,1528,1529,1890,1919,2658,3578,3579,
           3590,5100)
16.04.2010 для mfou_=300465 по бал.счетам  1919
           коды не соответсвующие кодам в кл-ре формируются по OB22
15.04.2010 для mfou_=300465 по бал.счетам  1518,1519,1526,1527,1528,1529
           коды не соответсвующие кодам в кл-ре формируются по OB22
14.04.2010 для mfou_=300465 по бал.счетам  3578,3579,5100 коды в том числе
           или другие коды не соответсвующие кодам в кл-ре формируются по OB22
13.04.2010 для подсчета кол-ва счетов по  маске '100' из SAL вместо условия
           fdat<=dat3_ будет fdat=dat3_
21.01.2010 к ЮЛ (kod_11_ := '11' или kod_11_='21') в 208 показатель
           "кошти на вимогу ЮО" добавил счет 2565 (замечание ОБ Ровно)
           для бал.рах. 5100 код 506 загальний залишок, а код 514 в т.ч.
           R011='1'
           для бал.рах. 5101 код 506 загальний залишок, а код 512 в т.ч.
14.10.2009 к ЮЛ (kod_11_ := '11' или kod_11_='21') в 208 показатель
           "кошти на вимогу ЮО" добавил счета 2560,2568 (замечание ОБ Луцьк)
08.10.2009 исправила ошибку, внесенную в последних двух версиях: при
           разбивке 3578,3579 на ЮЛ и ФЛ ошибочно всех остальных относили
           к ЮЛ (kod_11_ := '11') + в 208 показатель "кошти на вимогу ЮО"
           добавила счета 2650, 2655
30.09.2009 для бал.счетов 3578,3579 выполняем разбивку на ЮЛ и ФЛ по
           условию CODCAGENT in (5,6) ФЛ иначе ЮЛ
25.07.2009 для кодов 112012 или 112022 (в т.ч. ФО) добавлен бал.счет 2627
           (нарахованi доходи за кредитами овердрафт ФО)
           замечание Петрокоммерц
16.07.2009 не будем изменять код '101' для R020=1500 и KV<>980 и клиент
           нерезидент на код '103', а нужно добавить в кл-р строку с
           R020='1500' R114='1' или R114='2' и указать код '103' и по
           необходимым счетам установить спецпараметр R114.
           Отменено такое изменение кода со '101' на '103' т.к. не все
           банки согласны с таким изменением (например Петрокоммерц)
15.07.2009 показатели 2208111 и 2209111 будем формировать не по условию
           S180='1', а по перечню бал.счетов
12.07.2009 для R020=1500 и KV<>980 и клиент нерезидент то DDD='103'.
10.07.2009 убрал ORDER BY для табл. RNBU_TRACE
09.07.2009 не формируем предыдущий отчетный год если нет записей в SALDOA
           за последний рабочий день предыдущего года
27.06.2009 при заполненном спецпараметре R114 в табл.SPECPARAM и отсутствии
           строки с заполненным значением поля R114 в кл-ре KOD_R020_B5
           будем изменять значение спецпараметра на "0"(ноль)
           и находить соответствующий код в кл-ре.
19.06.2009 для кода 507 будем формировать код 509 если отчетный месяц 12
14.04.2009 для кода 120 будем определять код в т.ч. (11-ЮЛ, 12-ФЛ) по
           кодам бал.счетов
13.04.2009 для бал.рах. 5100 код 506 загальний залишок, а код 514 в т.ч.
           R011='1'
26.03.2009 новая структура показателя (добавлен код R034 1-для 980,
           2 - не 980)
20.01.2009 для б/с 3409 не будет разделения по параметру R013 для текущего
           года. Данный бал.счет будет формироваться в коде 111.
17.10.2006 для б/с 3409 будет разделение по параметру R013 как для текущего
           года так и для прошлого. Если параметр отсутсвует, то устанавли-
           ваем R013='9'.
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%*/
kodf_    varchar2(2):='B5';
acc_     Number;
acc1_    Number;
dk_      Varchar2(1);
nbs_     Varchar2(4);
nls_     Varchar2(15);
r011_    Varchar2(1);
r012_    Varchar2(1);
r013_    Varchar2(1);
ob22_    Varchar2(2);
kod_11_  Varchar2(2);
dd_      Varchar2(2);
r034_    Varchar2(1);
Dat1_    Date;
Dat2_    Date;
Dat3_    Date;
Dat4_    Date;
data_    Date;
kv_      SMALLINT;
Ostn_    DECIMAL(24);
Ostq_    DECIMAL(24);
Dos96_   DECIMAL(24);
Kos96_   DECIMAL(24);
Dosq96_  DECIMAL(24);
Kosq96_  DECIMAL(24);
Dos99_   DECIMAL(24);
Dosq99_  DECIMAL(24);
Kos99_   DECIMAL(24);
Kosq99_  DECIMAL(24);
Doszg_   DECIMAL(24);
Koszg_   DECIMAL(24);
Dos96zg_ DECIMAL(24);
Kos96zg_ DECIMAL(24);
Dos99zg_ DECIMAL(24);
Kos99zg_ DECIMAL(24);
sn_      DECIMAL(24);
se_      DECIMAL(24);
kodp_    Varchar2(7);
kodp1_   Varchar2(7);
znap_    Varchar2(30);
ddd_     Varchar2(3);
txt1_    Varchar2(3);
flag_    number;
userid_  Number;
sql_acc_ varchar2(2000):='';
sql_doda_ varchar2(200):='';
ff_      number;
ret_	 number;
r114_    Varchar2(1);
cnt_     number;
rez_     number;
s180_	 varchar2(1);
rnk_     number;
custtype_ varchar2(1);
k072_     varchar2(1);
sed_      varchar2(4);
kolz_pg_  number;
mfo_      NUMBER;
mfou_     NUMBER;

--- остатки счетов+месячные корректирующие обороты+
--- обороты перекрытия(6,7 класс на 5040(5041))+корр.обороты перекрытия
CURSOR SALDOOG IS
   SELECT s.acc, s.nls, s.kv, s.fdat, s.nbs, s.ost, s.ostq,
          s.dos96, s.dosq96, s.kos96, s.kosq96,
          s.doszg, s.koszg, s.dos96zg, s.kos96zg, s.dos99zg, s.kos99zg,
          nvl(p.R114,'0'), nvl(trim(p.r011),'0'), nvl(trim(p.r013),'0'), s.rnk,
          c.CODCAGENT, nvl(trim(p.s180), fs180(s.acc,substr(s.nls, 1, 1), dat_)),
          c.custtype, nvl(trim(k.k072),'0'), NVL(trim(c.sed),'00'), NVL(trim(sp.ob22),'00')
   FROM  otcn_saldo s, specparam p, customer c, kl_k070 k, specparam_int sp
   WHERE s.rnk=c.rnk
     and s.acc=p.acc(+)
     and c.ise=k.k070(+)
     and s.acc=sp.acc(+)
   order by s.nls;

CURSOR SALDOPG IS
   SELECT s.acc, s.nls, s.kv, s.fdat, s.nbs, s.ost, s.ostq,
          s.dos96, s.dosq96, s.kos96, s.kosq96,
          s.dos99, s.dosq99, s.kos99, s.kosq99,
          s.doszg, s.koszg, s.dos96zg, s.kos96zg, s.dos99zg, s.kos99zg,
          nvl(p.R114,'0'), nvl(trim(p.r011),'0'), nvl(trim(p.r013),'0'), s.rnk,
	  c.CODCAGENT, nvl(trim(p.s180), fs180(s.acc,substr(s.nls, 1, 1), dat_)),
          c.custtype, nvl(trim(k.k072),'0'), NVL(trim(c.sed),'00'), NVL(trim(sp.ob22),'00')
   FROM  otcn_saldo s, specparam p, customer c, kl_k070 k, specparam_int sp
   WHERE s.rnk=c.rnk
     and s.acc=p.acc(+)
     and c.ise=k.k070(+)
     and s.acc=sp.acc(+)
   order by s.nls;

CURSOR BaseL IS
   SELECT kodp, SUM(znap)
   FROM rnbu_trace
   WHERE userid=userid_
   GROUP BY kodp;
--   ORDER BY kodp;

BEGIN
-------------------------------------------------------------------
SELECT id INTO userid_ FROM staff WHERE upper(logname)=upper(USER);
EXECUTE IMMEDIATE 'TRUNCATE TABLE RNBU_TRACE';
-------------------------------------------------------------------
-- свой МФО
mfo_ := F_Ourmfo ();

-- МФО "родителя"
BEGIN
   SELECT NVL(trim(mfou), mfo_)
      INTO mfou_
   FROM BANKS
   WHERE mfo = mfo_;
EXCEPTION WHEN NO_DATA_FOUND THEN
   mfou_ := mfo_;
END;

data_:=to_date('31' || '12' ||
               to_char(to_number(to_char(Dat_,'YYYY'))-1),'DDMMYYYY');

SELECT max(Fdat) INTO Dat3_ FROM FDAT WHERE fdat<=data_;

Dat4_:=TRUNC(Dat3_ + 28);

-- кол-во счетов в SAL за прошлый год
kolz_pg_ :=0;

SELECT count(*) INTO kolz_pg_
FROM sal
WHERE fdat = Dat3_
  and nbs LIKE '100%'
  and (ost <> 0 OR dos+kos<>0);

sql_acc_ := 'select distinct r020 from kod_r020_B5';
ret_ := f_pop_otcn(Dat_, 3, sql_acc_);
-------------------------------------------------------------------
--- остатки отчетного года
OPEN SALDOOG;
LOOP
   FETCH SALDOOG INTO acc_, nls_, kv_, data_, nbs_, Ostn_, Ostq_,
                      Dos96_, Dosq96_, Kos96_, Kosq96_,
                      Doszg_, Koszg_, Dos96zg_, Kos96zg_, Dos99zg_, Kos99zg_,
                      r114_, r011_, r013_, rnk_, rez_, s180_,
                      custtype_, k072_, sed_, ob22_;
   EXIT WHEN SALDOOG%NOTFOUND;

   kod_11_:='00';
   ddd_ := null;

   IF kv_ <> 980 THEN
      r034_ := '2';
      se_:=Ostq_-Dosq96_+Kosq96_;
   ELSE
      r034_ := '1';
      se_:=Ostn_-Dos96_+Kos96_;
   END IF;

   ---для балансовых счетов 6 и 7 классов вычитаем проводки перекрытия
   if to_char(Dat_,'MM')='12' and
         (substr(nbs_,1,1) in ('6','7') or nbs_ in ('5040','5041')) then
      se_:=se_+Doszg_-Koszg_; -- обороты перекрытия тип "ZG%"
--      se_:=se_+Dos96zg_-Kos96zg_; -- мес.корр. обороты перекрытия тип "ZG%"
--      se_:=se_+Dos99zg_-Kos99zg_; -- год.корр. обороты перекрытия тип "ZG%"
   end if;

   ---для балансовых счетов 5040,5041 вычитаем проводки перекрытия
--   if to_char(Dat_,'MM')='12' and nbs_ in ('5040','5041') then
----      se_:=se_+Doszg_-Koszg_; -- обороты перекрытия тип "ZG%"
--      se_:=se_-Dos96zg_+Kos96zg_; -- мес.корр. обороты перекрытия тип "ZG%"
--      se_:=se_-Dos99zg_+Kos99zg_; -- год.корр. обороты перекрытия тип "ZG%"
--   end if;

   IF se_ <> 0  THEN
      dk_:=IIF_N(se_,0,'1','2','2');

--      IF nbs_ IN ('1500','1508','1509','1510','1582') and dk_ = '1' and r114_ = '0' THEN
--         IF MOD(rez_,2) = '1' then
--            ddd_ := '101';
--         else
--            ddd_ := '103';
--         end if;
--      END IF;

--      IF nbs_ IN ('1512', '1515', '1516', '1517', '1518', '1519', '1581',
--                  '1522', '1525', '1526', '1527', '1528', '1529') and r114_ = '0' THEN
--         IF s180_ between '0' and '6' then
--            ddd_ := '101';
--         else
--            ddd_ := '103';
--         end if;
--      end if;

      if ddd_ is null then
         BEGIN
--            if r114_ = '0' then
--               SELECT count(*)
--                  INTO cnt_
--               FROM kod_r020_B5
--               WHERE r020=nbs_
--                 and t020=dk_
--                 and (pr_a is not null or r114<>'0');

--               if cnt_ > 0 then
--                  r114_ := '1';
--               end if;
--            end if;

            if r114_ <> '0' then
               SELECT count(*)
                  INTO cnt_
               FROM kod_r020_B5
               WHERE r020=nbs_
                 and t020=dk_
                 and r114=r114_;

               if cnt_ = 0 then
                  r114_ := '0';
               end if;
            end if;

            if r114_ <> '0' then
               SELECT NVL(ddd,'000')
                  INTO ddd_
               FROM kod_r020_B5
               WHERE r020=nbs_
                 and t020=dk_
                 and r114=r114_;
            else
               SELECT NVL(ddd,'000')
                  INTO ddd_
               FROM kod_r020_B5
               WHERE r020=nbs_
                 and t020=dk_;
            end if;
         EXCEPTION WHEN NO_DATA_FOUND THEN
            ddd_:='000';
         WHEN TOO_MANY_ROWS THEN
            if r114_ <> '0' then
               SELECT NVL(ddd,'000')
                  INTO ddd_
               FROM kod_r020_B5
               WHERE r020=nbs_
                 and t020=dk_
                 and r114=r114_
                 and rownum=1;
            else
               SELECT NVL(ddd,'000')
                  INTO ddd_
               FROM kod_r020_B5
               WHERE r020=nbs_
                 and t020=dk_
                 and rownum=1;
            end if;
         END;
      end if;

--      IF nbs_='1500' and kv_!=980 and MOD(rez_,2)= 0 THEN
--         ddd_:='103';
--      END IF;

      IF nbs_='3190' THEN
         --BEGIN
         --   SELECT NVL(r013,'0') INTO r013_ FROM specparam
         --   WHERE acc=acc_;
         --EXCEPTION WHEN NO_DATA_FOUND THEN
         --   r013_:='0';
         --END ;
         IF r013_='6' THEN
            ddd_:='127';
         END IF;
      END IF;

      if mfou_ = 300465 then
         IF nbs_ in ('1518','1519','1526','1527','1528','1529','1819',
                     '1890','1919','3578','3579','3590','3599') THEN
            --BEGIN
            --   SELECT NVL(ob22,'00')
            --      INTO ob22_
            --   FROM specparam_int
            --   WHERE acc=acc_;
            --EXCEPTION WHEN NO_DATA_FOUND THEN
            --   ob22_:='00';
            --END ;
            IF nbs_='1518' and ob22_ not in ('02','08') THEN
               ddd_:='101';
            END IF;
            IF nbs_='1519' and ob22_ not in ('04','05','06') THEN
               ddd_:='101';
            END IF;
            IF nbs_='1526' and ob22_ = '08' THEN
               ddd_:='101';
            END IF;
            IF nbs_='1527' and ob22_ not in ('02','04','05','07') THEN
               ddd_:='101';
            END IF;
            IF nbs_='1528' and ob22_ in ('06','07') THEN
               ddd_:='101';
            END IF;
            IF nbs_='1529' and ob22_ not in ('01','02','03','04','05','06',
                                             '07','08') THEN
               ddd_:='101';
            END IF;
            IF nbs_='1819' and ob22_ not in ('02','04') THEN
               ddd_:='108';
            END IF;
            IF nbs_='1890' and ob22_ not in ('01','02') THEN
               ddd_:='109';
            END IF;
            IF nbs_='1919' and ob22_ = '02' THEN
               ddd_:='207';
            END IF;
            IF nbs_='3578' and ob22_ not in ('19','20','21','22') THEN
               ddd_:='108';
            END IF;
            IF nbs_='3579' and ob22_ not in ('47','48','49','50','51','52') THEN
               ddd_:='108';
            END IF;
            IF nbs_='3590' and ob22_ not in ('01','02') THEN
               ddd_:='109';
            END IF;
            IF nbs_='3599' and ob22_ in ('08','09') THEN
               ddd_:='116';
            END IF;
         END IF;
      end if;

--      IF nbs_='5100' THEN
--         BEGIN
--            SELECT NVL(r011,'0') INTO r011_ FROM specparam
--            WHERE acc=acc_;
--         EXCEPTION WHEN NO_DATA_FOUND THEN
--            r011_:='0';
--         END ;
--         IF r011_='1' THEN
--            ddd_:='514';
--         END IF;
--      END IF;

      if ddd_ in ('512') then   ---('512','514')
         kod_11_ := '11';
      else
         kod_11_ := '10';
      end if;

      --if ddd_='507' and to_char(dat_,'MM')='12' then
      --   ddd_ := '509';
      --end if;

      if Dat_ >= to_date('31032009','ddmmyyyy') then
         kodp_:= dk_ || RTRIM(ddd_) || kod_11_ || r034_;
      else
         kodp_:= dk_ || RTRIM(ddd_) || kod_11_ ;
      end if;

      znap_:= TO_CHAR(ABS(se_));

      INSERT INTO rnbu_trace (nls, kv, odate, kodp, znap) VALUES
                             (nls_, kv_, data_, kodp_, znap_);


      IF ddd_='120' THEN
--         if custtype_ = 2 and k072_ not in ('L', 'N') then
--            kod_11_ := '11';
--         else
--            kod_11_ := '12';
--         end if;
         -- в старом варианте файла #B5 в код 121 кредиты ФЛ
         -- вкдлючались эти бал.счета
         if nbs_ like '22%' OR
            nbs_ in ('2620','2625','2627') or
            (nbs_ in ('3578','3579') and rez_ in (5,6) and sed_ != '91')
         then
            kod_11_ := '12';
         else
            kod_11_ := '11';
         end if;

         if Dat_ >= to_date('31032009','ddmmyyyy') then
            kodp_:= dk_ || RTRIM(ddd_) || kod_11_ || r034_;
         else
            kodp_:= dk_ || RTRIM(ddd_) || kod_11_ ;
         end if;

         znap_:= TO_CHAR(ABS(se_));

         INSERT INTO rnbu_trace (nls, kv, odate, kodp, znap) VALUES
                                (nls_, kv_, data_, kodp_, znap_);
      END IF;

--      IF ddd_ in ('208','209') THEN
--         if s180_ = '1' then
--            kod_11_ := '11';

--            if Dat_ >= to_date('31032009','ddmmyyyy') then
--                kodp_:= dk_ || RTRIM(ddd_) || kod_11_ || r034_;
--            else
--                kodp_:= dk_ || RTRIM(ddd_) || kod_11_ ;
--            end if;

--            znap_:= TO_CHAR(ABS(se_));

--            INSERT INTO rnbu_trace (nls, kv, odate, kodp, znap) VALUES
--                                    (nls_, kv_, data_, kodp_, znap_);
--         end if;
--      END IF;

      IF ddd_='208' and nbs_ in ('2520','2523','2526','2528',
                                 '2530','2531','2538',
                                 '2541','2542','2544','2545','2548',
                                 '2553','2555','2558',
                                 '2560','2561','2562','2565','2568',
                                 '2571',
                                 '2600','2601','2602','2603','2604','2605','2606','2608',
                                 '2643','2650','2655','2658') THEN

         kod_11_ := '11';


         IF mfou_ = 300465 and nbs_ = '2548' and ob22_ != '02' THEN
            kod_11_ := '10';
         END IF;

         IF mfou_ = 300465 and nbs_ = '2658' and ob22_ not in ('01','04','21','24','25',
                                                               '26','27','28','29','30')
         THEN
            --BEGIN
            --   SELECT NVL(ob22,'00')
            --      INTO ob22_
            --   FROM specparam_int
            --   WHERE acc=acc_;
            --EXCEPTION WHEN NO_DATA_FOUND THEN
            --   ob22_:='00';
            --END ;
            --IF ob22_ not in ('01','04','21','24','25','26','27','28','29') THEN
            --   kod_11_ := '10';
            --END IF;
            kod_11_ := '10';
         END IF;

         if mfou_ != 300465 and nbs_ = '2658' then
            if r011_ in ('5','6') THEN
               KOD_11_ := '10';
            END IF;
         end if;

         if Dat_ >= to_date('31032009','ddmmyyyy') then
            kodp_:= dk_ || RTRIM(ddd_) || kod_11_ || r034_;
         else
            kodp_:= dk_ || RTRIM(ddd_) || kod_11_ ;
         end if;

         if kod_11_ = '11' then
            znap_:= TO_CHAR(ABS(se_));

            INSERT INTO rnbu_trace (nls, kv, odate, kodp, znap) VALUES
                                    (nls_, kv_, data_, kodp_, znap_);
         end if;
      END IF;

      IF ddd_='209' and nbs_ in ('2620','2622','2625','2628') THEN

         kod_11_ := '11';

         if Dat_ >= to_date('31032009','ddmmyyyy') then
            kodp_:= dk_ || RTRIM(ddd_) || kod_11_ || r034_;
         else
            kodp_:= dk_ || RTRIM(ddd_) || kod_11_ ;
         end if;

         znap_:= TO_CHAR(ABS(se_));

            INSERT INTO rnbu_trace (nls, kv, odate, kodp, znap) VALUES
                                    (nls_, kv_, data_, kodp_, znap_);
      END IF;

      IF nbs_='5100' THEN
         --BEGIN
         --   SELECT NVL(r011,'0') INTO r011_ FROM specparam
         --   WHERE acc=acc_;
         --EXCEPTION WHEN NO_DATA_FOUND THEN
         --   r011_:='0';
         --END ;
         IF r011_='1' and mfou_ != 300465 THEN
            ddd_:='514';
         END IF;

         if mfou_ = 300465 then
            BEGIN
               SELECT NVL(ob22,'00')
                  INTO ob22_
               FROM specparam_int
               WHERE acc=acc_;
            EXCEPTION WHEN NO_DATA_FOUND THEN
               ob22_:='00';
            END ;
            IF ob22_ in ('02','03','13','14','15','16') THEN
               ddd_:='514';
            END IF;
         end if;

         IF ddd_='514' then
            kod_11_ := '11';
            if Dat_ >= to_date('31032009','ddmmyyyy') then
                kodp_:= dk_ || RTRIM(ddd_) || kod_11_ || r034_;
            else
                kodp_:= dk_ || RTRIM(ddd_) || kod_11_ ;
            end if;

            znap_:= TO_CHAR(ABS(se_));

            INSERT INTO rnbu_trace (nls, kv, odate, kodp, znap) VALUES
                                    (nls_, kv_, data_, kodp_, znap_);

         END IF;
      END IF;

      IF nbs_='5101' THEN
         ddd_:='512';
         kod_11_ := '11';
         if Dat_ >= to_date('31032009','ddmmyyyy') then
             kodp_:= dk_ || RTRIM(ddd_) || kod_11_ || r034_;
         else
             kodp_:= dk_ || RTRIM(ddd_) || kod_11_ ;
         end if;

         znap_:= TO_CHAR(ABS(se_));

         INSERT INTO rnbu_trace (nls, kv, odate, kodp, znap) VALUES
                                (nls_, kv_, data_, kodp_, znap_);

      END IF;
   END IF;
END LOOP;
CLOSE SALDOOG;
-------------------------------------------------------------------------
IF to_number(to_char(Dat3_,'YYYY'))=to_number(to_char(Dat_,'YYYY'))-1
   and  kolz_pg_ <> 0 then

-- предыдущий год

--DELETE FROM kor_prov ;
--EXECUTE IMMEDIATE 'TRUNCATE TABLE kor_prov';
--INSERT INTO KOR_PROV (REF,  DK,  ACC , S,  FDAT , VDAT, SOS,  VOB)
--SELECT o.ref, o.dk, o.acc, o.s, o.fdat, p.vdat, o.sos, p.vob
--FROM opldok o, ref_kor p     --- oper p
--WHERE ((o.fdat>Dat3_    AND
--      o.fdat<=Dat4_    AND
--      p.vob=96)        OR
--      (o.fdat>Dat3_    AND
--      o.fdat<=Dat_     AND
--      p.vob=99))        AND
--      o.ref=p.ref      AND
--      o.sos=5 ;

dbms_output.put_line('dat3_: '||to_char(Dat3_, 'ddmmyyyy'));

-- учитываем годовые корректирующие проводки (12.04.2006)
ret_ := f_pop_otcn(Dat3_, 4, sql_acc_);

--- остатки последнего рабочего дня предыдущего года
OPEN SALDOPG;
LOOP
   FETCH SALDOPG INTO acc_, nls_, kv_, data_, nbs_, Ostn_, Ostq_,
                      Dos96_, Dosq96_, Kos96_, Kosq96_,
                      Dos99_, Dosq99_, Kos99_, Kosq99_,
                      Doszg_, Koszg_, Dos96zg_, Kos96zg_, Dos99zg_, Kos99zg_ ,
                      r114_, r011_, r013_, rnk_, rez_, s180_, custtype_, k072_, sed_, ob22_;
   EXIT WHEN SALDOPG%NOTFOUND;

   kod_11_:='00';
   ddd_ := null;

   IF kv_ <> 980 THEN
      r034_ := '2';
      se_:=Ostq_-Dosq96_+Kosq96_-Dosq99_+Kosq99_;
   ELSE
      r034_ := '1';
      se_:=Ostn_-Dos96_+Kos96_-Dos99_+Kos99_;
   END IF;

   if substr(nbs_,1,1) in ('6','7') or nbs_ in ('5040','5041') then
      se_:=se_+Doszg_-Koszg_;     -- обороты перекрытия тип "ZG%"
   end if;

   IF se_ <> 0  THEN
      dk_:=IIF_N(se_,0,'1','2','2');

--      IF nbs_ IN ('1500','1508','1509','1510','1582') and dk_ = '1' and r114_ = '0' THEN
--         IF MOD(rez_,2) = '1' then
--            ddd_ := '101';
--         else
--            ddd_ := '103';
--         end if;
--      end if;

--      IF nbs_ IN ('1512', '1515', '1516', '1517', '1518', '1519', '1581',
--                  '1522', '1525', '1526', '1527', '1528', '1529') and r114_ = '0' THEN
--         IF s180_ between '0' and '6' then
--            ddd_ := '101';
--         else
--            ddd_ := '103';
--         end if;
--      end if;

      if ddd_ is null then
         BEGIN
--            if r114_ = '0' then
--               SELECT count(*)
--                  INTO cnt_
--               FROM kod_r020_B5
--               WHERE r020=nbs_
--                 and t020=dk_
--                 and (pr_a is not null or r114<>'0');

--               if cnt_ > 0 then
--                  r114_ := '1';
--               end if;
--            end if;

            if r114_ <> '0' then
               SELECT count(*)
                  INTO cnt_
               FROM kod_r020_B5
               WHERE r020=nbs_
                 and t020=dk_
                 and r114=r114_;

               if cnt_ = 0 then
                  r114_ := '0';
               end if;
            end if;

            if r114_ <> '0' then
               SELECT NVL(ddd,'000')
                  INTO ddd_
               FROM kod_r020_B5
               WHERE r020=nbs_
                 and t020=dk_
                 and r114=r114_;
            else
               SELECT NVL(ddd,'000')
                  INTO ddd_
               FROM kod_r020_B5
               WHERE r020=nbs_
                 and t020=dk_;
            end if;
         EXCEPTION WHEN NO_DATA_FOUND THEN
            ddd_:='000';
	 WHEN TOO_MANY_ROWS THEN
            if r114_ <> '0' then
               SELECT NVL(ddd,'000')
                  INTO ddd_
               FROM kod_r020_B5
               WHERE r020=nbs_
                 and t020=dk_
                 and r114=r114_
                 and rownum=1;
            else
               SELECT NVL(ddd,'000')
                  INTO ddd_
               FROM kod_r020_B5
               WHERE r020=nbs_
                 and t020=dk_
                 and rownum=1;
            end if;
         END;
      end if;

--      IF nbs_='1500' and kv_!=980 and MOD(rez_,2) = 0 THEN
--         ddd_:='103';
--      END IF;

      IF nbs_='3190' THEN
         --BEGIN
         --   SELECT NVL(r013,'0') INTO r013_ FROM specparam
         --   WHERE acc=acc_;
         --EXCEPTION WHEN NO_DATA_FOUND THEN
         --   r013_:='0';
         --END ;
         IF r013_='6' THEN
            ddd_:='127';
         END IF;
      END IF;

      if mfou_ = 300465 then
         IF nbs_ in ('1518','1519','1526','1527','1528','1529','1819',
                     '1890','1919','3578','3579','3590','3599') THEN
            BEGIN
               SELECT NVL(ob22,'00')
                  INTO ob22_
               FROM specparam_int
               WHERE acc=acc_;
            EXCEPTION WHEN NO_DATA_FOUND THEN
               ob22_:='00';
            END ;
            IF nbs_='1518' and ob22_ not in ('02','08') THEN
               ddd_:='101';
            END IF;
            IF nbs_='1519' and ob22_ not in ('04','05','06') THEN
               ddd_:='101';
            END IF;
            IF nbs_='1526' and ob22_ = '08' THEN
               ddd_:='101';
            END IF;
            IF nbs_='1527' and ob22_ not in ('02','04','05','07') THEN
               ddd_:='101';
            END IF;
            IF nbs_='1528' and ob22_ in ('06','07') THEN
               ddd_:='101';
            END IF;
            IF nbs_='1529' and ob22_ not in ('01','02','03','04','05','06',
                                             '07','08') THEN
               ddd_:='101';
            END IF;
            IF nbs_='1819' and ob22_ not in ('02','04') THEN
               ddd_:='108';
            END IF;
            IF nbs_='1890' and ob22_ not in ('01','02') THEN
               ddd_:='109';
            END IF;
            IF nbs_='1919' and ob22_ = '02' THEN
               ddd_:='207';
            END IF;
            IF nbs_='3578' and ob22_ not in ('19','20','21','22') THEN
               ddd_:='108';
            END IF;
            IF nbs_='3579' and ob22_ not in ('47','48','49','50','51','52') THEN
               ddd_:='108';
            END IF;
            IF nbs_='3590' and ob22_ not in ('01','02') THEN
               ddd_:='109';
            END IF;
            IF nbs_='3599' and ob22_ in ('08','09') THEN
               ddd_:='116';
            END IF;
         END IF;
      end if;

--      IF nbs_='5100' THEN
--         BEGIN
--            SELECT NVL(r011,'0') INTO r011_ FROM specparam
--            WHERE acc=acc_;
--         EXCEPTION WHEN NO_DATA_FOUND THEN
--            r011_:='0';
--         END ;
--         IF r011_='1' THEN
--            ddd_:='514';
--         END IF;
--      END IF;

      if ddd_ in ('512') then   ---('512','514')
         kod_11_ := '21';
      else
         kod_11_ := '20';
      end if;

      --if ddd_='507' and to_char(dat3_,'MM')='12' then
      --   ddd_ := '509';
      --end if;

      if Dat_ >= to_date('31032009','ddmmyyyy') then
         kodp_:= dk_ || RTRIM(ddd_) || kod_11_ || r034_;
      else
         kodp_:= dk_ || RTRIM(ddd_) || kod_11_ ;
      end if;

      znap_:= TO_CHAR(ABS(se_));

      INSERT INTO rnbu_trace (nls, kv, odate, kodp, znap) VALUES
                             (nls_, kv_, data_, kodp_, znap_);


      IF ddd_='120' THEN
--         if custtype_ = 2 and k072_ not in ('L', 'N') then
--            kod_11_ := '21';
--         else
--            kod_11_ := '22';
--         end if;

         -- в старом варианте файла #B5 в код 121 кредиты ФЛ
         -- вкдлючались эти бал.счета
         if nbs_ like '22%' OR
            nbs_ in ('2620','2625','2627') or
            (nbs_ in ('3578','3579') and rez_ in (5,6) and sed_ != '91')
         then
            kod_11_ := '22';
         else
            kod_11_ := '21';
         end if;

         if Dat_ >= to_date('31032009','ddmmyyyy') then
            kodp_:= dk_ || RTRIM(ddd_) || kod_11_ || r034_;
         else
            kodp_:= dk_ || RTRIM(ddd_) || kod_11_ ;
         end if;

         znap_:= TO_CHAR(ABS(se_));

         INSERT INTO rnbu_trace (nls, kv, odate, kodp, znap) VALUES
                                (nls_, kv_, data_, kodp_, znap_);
      END IF;

--      IF ddd_ in ('208','209') THEN
--         if s180_ = '1' then
--            kod_11_ := '21';

--            if Dat_ >= to_date('31032009','ddmmyyyy') then
--                kodp_:= dk_ || RTRIM(ddd_) || kod_11_ || r034_;
--            else
--                kodp_:= dk_ || RTRIM(ddd_) || kod_11_ ;
--            end if;

--            znap_:= TO_CHAR(ABS(se_));

--            INSERT INTO rnbu_trace (nls, kv, odate, kodp, znap) VALUES
--                                    (nls_, kv_, data_, kodp_, znap_);
--         end if;
--      END IF;

      IF ddd_='208' and nbs_ in ('2520','2523','2526','2528',
                                 '2530','2531','2538',
                                 '2541','2542','2544','2545','2548',
                                 '2553','2555','2558',
                                 '2560','2561','2562','2565','2568',
                                 '2571',
                                 '2600','2601','2602','2603','2604','2605','2606','2608',
                                 '2643','2650','2655','2658') THEN

         kod_11_ := '21';

         IF mfou_ = 300465 and nbs_ = '2548' and ob22_ != '02' THEN
            kod_11_ := '20';
         END IF;

         IF mfou_ = 300465 and nbs_ = '2658' and ob22_ not in ('01','04','21','24','25',
                                                               '26','27','28','29','30')
         THEN
            --BEGIN
            --   SELECT NVL(ob22,'00')
            --      INTO ob22_
            --   FROM specparam_int
            --   WHERE acc=acc_;
            --EXCEPTION WHEN NO_DATA_FOUND THEN
            --   ob22_:='00';
            --END ;
            --IF ob22_ not in ('01','04','21','24','25','26','27','28','29') THEN
            --   kod_11_ := '20';
            --END IF;
            kod_11_ := '20';
         END IF;

         if mfou_ != 300465 and nbs_ = '2658' then
            if r011_ in ('5','6') THEN
               KOD_11_ := '20';
            END IF;
         end if;

         if Dat_ >= to_date('31032009','ddmmyyyy') then
            kodp_:= dk_ || RTRIM(ddd_) || kod_11_ || r034_;
         else
            kodp_:= dk_ || RTRIM(ddd_) || kod_11_ ;
         end if;

         if kod_11_ = '21' then
            znap_:= TO_CHAR(ABS(se_));

            INSERT INTO rnbu_trace (nls, kv, odate, kodp, znap) VALUES
                                    (nls_, kv_, data_, kodp_, znap_);
         end if;
      END IF;

      IF ddd_='209' and nbs_ in ('2620','2622','2625','2628') THEN

         kod_11_ := '21';

         if Dat_ >= to_date('31032009','ddmmyyyy') then
            kodp_:= dk_ || RTRIM(ddd_) || kod_11_ || r034_;
         else
            kodp_:= dk_ || RTRIM(ddd_) || kod_11_ ;
         end if;

         znap_:= TO_CHAR(ABS(se_));

            INSERT INTO rnbu_trace (nls, kv, odate, kodp, znap) VALUES
                                    (nls_, kv_, data_, kodp_, znap_);
      END IF;

      IF nbs_='5100' THEN
         --BEGIN
         --   SELECT NVL(r011,'0') INTO r011_ FROM specparam
         --   WHERE acc=acc_;
         --EXCEPTION WHEN NO_DATA_FOUND THEN
         --   r011_:='0';
         --END ;
         IF r011_='1' and mfou_ != 300465 THEN
            ddd_:='514';
         END IF;

         if mfou_ = 300465 then
            BEGIN
               SELECT NVL(ob22,'00')
                  INTO ob22_
               FROM specparam_int
               WHERE acc=acc_;
            EXCEPTION WHEN NO_DATA_FOUND THEN
               ob22_:='00';
            END ;
            IF ob22_ in ('02','03','13','14','15','16') THEN
               ddd_:='514';
            END IF;
         end if;

         IF ddd_='514' then
            kod_11_ := '21';
            if Dat_ >= to_date('31032009','ddmmyyyy') then
                kodp_:= dk_ || RTRIM(ddd_) || kod_11_ || r034_;
            else
                kodp_:= dk_ || RTRIM(ddd_) || kod_11_ ;
            end if;

            znap_:= TO_CHAR(ABS(se_));

            INSERT INTO rnbu_trace (nls, kv, odate, kodp, znap) VALUES
                                    (nls_, kv_, data_, kodp_, znap_);

         END IF;
      END IF;

      IF nbs_='5101' THEN
         ddd_:='512';
         kod_11_ := '21';
         if Dat_ >= to_date('31032009','ddmmyyyy') then
             kodp_:= dk_ || RTRIM(ddd_) || kod_11_ || r034_;
         else
             kodp_:= dk_ || RTRIM(ddd_) || kod_11_ ;
         end if;

         znap_:= TO_CHAR(ABS(se_));

         INSERT INTO rnbu_trace (nls, kv, odate, kodp, znap) VALUES
                                (nls_, kv_, data_, kodp_, znap_);

      END IF;
   END IF;

END LOOP;
CLOSE SALDOPG;
END IF;
-----------------------------------------------------------------------------
DELETE FROM tmp_nbu where kodf=kodf_ and datf= dat_;
---------------------------------------------------
OPEN BaseL;
LOOP
   FETCH BaseL INTO  kodp_, znap_;
   EXIT WHEN BaseL%NOTFOUND;
   INSERT INTO tmp_nbu
        (kodf, datf, kodp, znap)
   VALUES
        (kodf_, Dat_, kodp_, znap_);
END LOOP;
CLOSE BaseL;
----------------------------------------
END p_fB5;
/
show err;

PROMPT *** Create  grants  P_FB5 ***
grant EXECUTE                                                                on P_FB5           to BARS_ACCESS_DEFROLE;
grant EXECUTE                                                                on P_FB5           to RPBN002;
grant EXECUTE                                                                on P_FB5           to WR_ALL_RIGHTS;



PROMPT ===================================================================================== 
PROMPT *** End *** ========== Scripts /Sql/BARS/Procedure/P_FB5.sql =========*** End *** ===
PROMPT ===================================================================================== 
