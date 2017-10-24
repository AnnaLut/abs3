

PROMPT ===================================================================================== 
PROMPT *** Run *** ========== Scripts /Sql/BARS/Procedure/P_F1A_NN.sql =========*** Run *** 
PROMPT ===================================================================================== 


PROMPT *** Create  procedure P_F1A_NN ***

  CREATE OR REPLACE PROCEDURE BARS.P_F1A_NN (Dat_ DATE,
                                      sheme_ varchar2 default 'G') IS
/*%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
% DESCRIPTION :	Процедура формирования файла #1A для КБ
% COPYRIGHT   :	Copyright UNITY-BARS Limited, 1999.All Rights Reserved.
% VERSION     : 05/06/2015 (10/03/2015, 15/12/2014, 13/10/2014)
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
параметры: Dat_ - отчетная дата
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
05/06/2015 - на 01.06.2015 не будут формироваться коды 41,51
10/03/2015 - для февраля месяца день месяца не всегда формировался верно
15/12/2014 - не будет формироваться прогноз за предыдущий месяц и
             прогноз (показатель 31) предоставляется на отчетный
             и следующий за ним годы
13/10/2014 - закоментарил блок удаления проводок с кодом операции %15
10/09/2014 - исключаем проводки по уплате налога на доходы по депозиту
             Дт 26_8 Кт 3800 и код операции "%15"
22/04/2014 - прогноз (показатель 31) предоставляется на отчетный
             и следующий за ним годы
03/08/2012 - на 01.08.2012 не должны формироваться показатели 410,421,422,
             430,440,450
11/10/2011 - неправильно расчитывалась последняя сумма, если мы не "попадали"
             на месяц последнего начисления процентов (в сучае не ежемесячного
             начисления)
09/06/2011 - убрада умножение и деление для кодов 41,51 и поправила алгоритм
             расчета этих показателей, а также учла некоторые нюансы
09.02.2011 - для кодов 41,51 не всегда определяся код "DDD"
08.02.2011 - для кодов 41,51 не всегда определяся код области или
             код подразделения. Для переменных NBUC, NBUC1 будет
             VARCHAR2(20) вместо VARCHAR2(12).
07.02.2011 - изменил формирование показателей 41VVVKKKZ00000 и
             51VVVKKKZ00000. В показатель 41VVVKKKZ00000 будет включаться
             вся сумма списания и 51VVVKKKZ00000 только сумма погашенная
             досрочно
01.02.2011 - добавлено формирование двух новых показателей 41VVVKKKZ00000 -
             сума фактичного погашення заборгованост? за зв?тний м?сяць
             и 51VVVKKKZ00000 - сума фактичного дострокового погашення
04.06.2010 - для просроченных депозитов и процентов формируем показатель
             "21" и не будем формировать прогноз.
             Для непросроченных депозитов и процентов формируем показатель
             "31" и будем формировать прогноз.
03.06.2010 - для просроченных депозитов дополнительно формируем показатель
             "21" и не будем формировать прогноз.
             Для счетов начисленных %% формируем код "21" вместо "31"
05.02.2010 - для табл. INT_ACCN добавил условие ID=0 and ROWNUM=1
27.01.2010 - выполняем расчет прогноза для кодов 271,272,273 ранее было
             для кода 270 (с 01.02.2010 код 270 разбивается на эти три кода)
24.11.2009 - для 2628 оставляем только те счета для которых в основном счете
             R013=''1'
19.11.2009 - для freq_=0 mdater_=mdate_ и для расчета суммы прогноза за посл.
             месяц кол-во дней уменьшаем на 1 (mdate-1)
11.11.2009 - для ЮЛ начальная дата для прогноза всегда 1-ое число нового
             месяца и конечная дата последний день месяца
             для ФЛ начальная дата это дата открытия счета и конечная дата
             это начальна дата + периодичность выплаты процентов
06.11.2009 - не обнулялись некоторые переменные
04.11.2009 - добавила обработку счета 2628
03.08.2009 - для Петрокоммерца и показателей прогноза начисленных процентов
             для клиентов банков и ЮЛ нерезидентов (CODCAGENT in (2,4)) и
             имеющих код страны  643 вычитаем 10% налога (МФО=300120)
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%*/
kodf_    varchar2(2):='1A';
k_       Number;
kol_k_   Number;
acc_     Number;
acc1_    Number;
acc_p_   Number;
id_      Number;
pr_      Number;
int_     Number;
dk_      Varchar2(2);
z_       Varchar2(1);
god_     Varchar2(4);
god1_    Varchar2(4);
mm_      Number;
mm1_     Number;
w_       Varchar2(1);
w1_      Varchar2(1);
nbs_     Varchar2(4);
nls_     Varchar2(15);
r012_    Varchar2(1);
r013_    Varchar2(1);
kod_11_  Varchar2(2);
dd_      Varchar2(2);
mdate_   Date;
mdateR_  Date;
s_       NUMBER;
s41_     NUMBER;
s51_     NUMBER;
apl_dat_ DATE;
Dat1_    Date;
Datn_    Date;
Datnp_   Date;
Datk_    Date;
Date_    Date;
data_    Date;
kv_      SMALLINT;
Ostn_    DECIMAL(24);
Ostq_    DECIMAL(24);
Dos96_   DECIMAL(24);
Kos96_   DECIMAL(24);
Dosq96_  DECIMAL(24);
Kosq96_  DECIMAL(24);
Doszg_   DECIMAL(24);
Koszg_   DECIMAL(24);
Dos96zg_ DECIMAL(24);
Kos96zg_ DECIMAL(24);
Dos99zg_ DECIMAL(24);
Kos99zg_ DECIMAL(24);
sn_      DECIMAL(24);
se_      DECIMAL(24);
se_6203  DECIMAL(24);
dos_     NUMBER;
kos_     NUMBER;
kodp_    Varchar2(14);
kodp1_   Varchar2(14);
znap_    Varchar2(30);
ddd_     Varchar(3);
flag_    number;
userid_  Number;
sql_acc_ varchar2(2000):='';
sql_doda_ varchar2(200):='';
ff_      number;
ret_	 number;
rnk_     number;
codcagent_ number;
nbuc1_   varchar2(20);
nbuc_    varchar2(20);
typ_     Number;
mfo_     Number;
mfou_    Number;
country_ Number;
comm_      Varchar2(200);
comm1_     Varchar2(200);
freq_      NUMBER;
daos_      Date;
add_       NUMBER;

--- остатки счетов+месячные корректирующие обороты+
CURSOR SALDO IS
   SELECT c.rnk, c.codcagent, c.country, a.mdate, acrn.fproc(a.acc, Dat_),
          s.acc, s.nls, s.kv, s.fdat, s.nbs, s.ost, s.ostq,
          s.dos96, s.dosq96, s.kos96, s.kosq96,
          s.doszg, s.koszg, s.dos96zg, s.kos96zg, s.dos99zg, s.kos99zg, a.daos,
          NVL(k.ddd,'000')
   FROM  otcn_saldo s, otcn_acc a, customer c, kl_f3_29 k
   WHERE a.acc=s.acc
     and a.rnk=c.rnk
     and c.codcagent in (2,4,6)
     and s.kv <> 980
     and s.nbs = k.r020
     and k.kf='1A';
BEGIN
    commit;

    EXECUTE IMMEDIATE 'ALTER SESSION ENABLE PARALLEL DML';
    -------------------------------------------------------------------
    logger.info ('P_F1A_NN: Begin for datf = '||to_char(dat_, 'dd/mm/yyyy'));
    -------------------------------------------------------------------
    userid_ := user_id;

    EXECUTE IMMEDIATE 'TRUNCATE TABLE RNBU_TRACE';

    EXECUTE IMMEDIATE 'TRUNCATE TABLE TMP_FILE03';
    -------------------------------------------------------------------
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

    Dat1_:= TRUNC(add_months(Dat_,1),'MM');
    Datnp_ := TRUNC(Dat_,'MM');

    -- определение кода МФО или кода области для выбранного файла и схемы
    p_proc_set(kodf_,sheme_,nbuc1_,typ_);

    sql_acc_ := 'select distinct r020 from kl_f3_29 where kf=''1A''';
    ret_ := f_pop_otcn(Dat_, 2, sql_acc_);

    -- удаляем записи для бал.счета 2620 с R013<>'1'
    delete
    from otcn_saldo a
    where acc in (select p.acc
                    from accounts a, specparam p
                    where a.nbs in ('2620') and
                          a.acc = p.acc  and
                          NVL(p.r013,'0') <> '1');

    -- удаляем записи для бал.счета 2628 с R013<>'1' основного счета
    delete
    from otcn_saldo a
    where a.acc in (select p.acc from accounts p where p.nbs in ('2628'))
      and a.acc not in (select n.acra
                        from accounts a1, int_accn n, specparam p
                        where a1.nbs in ('2620')
                          and n.acc = a1.acc
                          and n.acra=a.acc
                          and n.acc = p.acc(+)
                          and NVL(p.r013,'0') = '1');

    -- для Крыма не включаем счета 2620, 2628
    if mfo_ = 324805 then
       delete from otcn_saldo
       where nls like '262%';
    end if;

    -- наповнення проводок за зв_тну дату
    insert into tmp_file03
       (ACCD, TT, REF, KV, NLSD, S, SQ, FDAT, NAZN, ACCK, NLSK, ISP)
       select ACCD, TT, REF, KV, NLSD, S, SQ, FDAT, NAZN, ACCK, NLSK, ISP
       from provodki_otc p
       where p.fdat between Datnp_ and dat_
         and substr(p.NLSD,1,4) in (select r020 from kl_f3_29 where kf='1A')
       union
       select ACCD, TT, REF, KV, NLSD, S, SQ, FDAT, NAZN, ACCK, NLSK, ISP
       from provodki_otc p
       where p.fdat between Datnp_ and dat_
         and substr(p.NLSK,1,4) in (select r020 from kl_f3_29 where kf='1A');

    -- исключаем проводки по капитализации процентов
    delete from tmp_file03
    where nlsd like '___8%'
      and nlsk not like '___8%'
      and substr(nlsd,1,3) = substr(nlsk,1,3);

    -- исключаем проводки по уплате налога на доходы по депозиту
    -- 10.10.2014 закоментарил этот блок по письму Семеновой
    --delete from tmp_file03
    --where nlsd like '___8%'
    --  and nlsk like '3800%'
    --  and tt = '%15';


    -------------------------------------------------------------------
    --- остатки
    OPEN SALDO;
    LOOP
       FETCH SALDO INTO rnk_, codcagent_, country_, mdate_, pr_,
                          acc_, nls_, kv_, data_, nbs_, Ostn_, Ostq_,
                          Dos96_, Dosq96_, Kos96_, Kosq96_,
                          Doszg_, Koszg_, Dos96zg_, Kos96zg_, Dos99zg_, Kos99zg_, daos_, ddd_ ;
       EXIT WHEN SALDO%NOTFOUND;

       if mdate_ is NULL then
          --mm_ := 0;
          --god_ := 'YYYY';
          mm_  := to_number(to_char(add_months(Dat_,1),'MM'));
          god_ := to_char(add_months(Dat_,1),'YYYY');
       else
          mm_  := to_number(to_char(mdate_,'MM'));
          god_ := to_char(mdate_,'YYYY');
       end if;

       w_ := f_chr36(mm_);

       se_:=round((Ostn_-Dos96_+Kos96_)/100,0);

       IF se_ <> 0  THEN

          if typ_>0 then
             nbuc_ := nvl(f_codobl_tobo(acc_,typ_),nbuc1_);
          else
             nbuc_ := nbuc1_;
          end if;

          mdateR_ := last_day(TRUNC(add_months(Dat_,1),'MM'));  --null;
          comm_ :='';
          add_ := 1;
          freq_ := 0;
          apl_dat_ := null;

          -- определение периодичности выплаты %%
          if pr_ <> 0 OR nbs_ like '___8%' then

             if nbs_ like '___8%'  then
                acc_p_ := acc_;
             else
                BEGIN
                   select acra
                      into acc_p_
                   from int_accn
                   where acc=acc_
                     and id=1
                     and rownum=1;
                EXCEPTION WHEN NO_DATA_FOUND THEN
                   acc_p_ := null;
                END;
             end if;

             if acc_p_ is not null then

                if nbs_ like '262%' or nbs_ like '263%' then
                   BEGIN
                      -- депозиты ФЛ
                      SELECT nvl(c.FREQ, v.FREQ_K), c.DAT_BEGIN
                         INTO freq_, apl_dat_
                      FROM int_accn i, dpt_deposit c, dpt_vidd v
                      WHERE i.acra = acc_p_
                        AND i.ID = 1
                        AND i.acc = c.acc
                        AND c.vidd = v.vidd
                        AND ROWNUM = 1;

                      comm_ := comm_ || ' (ДП ФЛ)';
                   exception
                             when no_data_found then
                      freq_ := 0;
                      apl_dat_ := null;
                   END;
                end if;

                if nbs_ like '161%' or nbs_ like '261%' then
                   -- 20.11.2006 не брать инф-цию из депоз. модуля ЮЛ
                   if 300120 NOT IN (mfo_, mfou_) THEN
                      BEGIN
                         -- депозиты ЮЛ
                         SELECT nvl(c.FREQV, v.FREQ_V), c.DAT_BEGIN
                            INTO freq_, apl_dat_
                         FROM int_accn i, dpu_deal c, dpu_vidd v
                         WHERE i.acra = acc_p_
                           AND i.ID = 1
                           AND i.acc = c.acc
                           AND c.vidd = v.vidd
                           AND ROWNUM = 1;
                      exception
                               when no_data_found then
                         freq_ := 0;
                         apl_dat_ := null;
                      END;
                   end if;

                   comm_ := comm_ || ' (ДП ЮЛ)';
                end if;

                comm_ := comm_ || ' freq=' || freq_ ;
                comm_ := comm_ || ' apl_dat=' || TO_CHAR (apl_dat_, 'dd/mm/yyyy') || '''';
                comm_ := comm_ || ' daos=' || TO_CHAR (daos_, 'dd/mm/yyyy') || '''';

                IF freq_ IN (2, 5)
                THEN
                   add_ := 1;
                ELSIF freq_ = 7
                THEN
                   add_ := 3;
                ELSIF freq_ = 180
                THEN
                   add_ := 6;
                ELSIF freq_ = 360
                THEN
                   add_ := 12;
                ELSE
                   add_ := 1;
                END IF;

                IF mdate_ <= dat_
                THEN
                   mdateR_ := last_day(TRUNC(add_months(Dat_,1),'MM'));  -- добавил 24.11.2009
                   add_ := 1;
                END IF;

                comm_ := comm_ || ' add=' || TO_CHAR (add_);

                IF freq_ IS NULL or freq_=400 --  не задан или в конце срока
                THEN
                   mdateR_ := mdate_;
                ELSIF freq_ = 0 or freq_ = 1 --  не задан или ежедневно
                THEN
                   mdateR_ := last_day(TRUNC(add_months(Dat_,1),'MM'));  --dat_;
                ELSE
                   if apl_dat_ IS NOT NULL THEN -- первая дата задана
                      mdateR_ := apl_dat_;
                   else
                      mdateR_ := daos_;
                   end if;
                end if;

                if mdateR_ < dat_ and add_ <> 0 then
                   loop
                      mdateR_ := ADD_MONTHS (mdateR_, add_);

                      IF mdateR_ >= dat_ THEN
                      --IF to_char(mdateR_,'MMYYYY') > to_char(dat_,'MMYYYY') THEN
                         exit;
                      end if;
                   END LOOP;
                end if;

                comm_ :=
                        comm_ || ' mdateR_=''' || TO_CHAR (mdateR_, 'dd/mm/yyyy') || '''';

             end if;

          end if;

          if mdate_ < dat_ OR nbs_ like '___8%' then  -- закоммент. 24.11.2009
             mm_  := to_number(to_char(mdateR_,'MM'));
             god_ := to_char(mdateR_,'YYYY');
             w_ := f_chr36(mm_);
          end if;  -- закоммент. 24.11.2009

          if nbs_ like '___8%' and nbs_ != '3548' then
             z_ := '2';
          else
             z_ := '1';
          end if;

          dk_ := '11';

          if ddd_ = '270' and nbs_ like '___7%' then
             dk_ := '21';
          end if;

          if ddd_ in ('410','421','422','430','440','450') then
             z_ := '0';
          end if;

          if ddd_ in ('230','262','270','271','272','273') and pr_ <> 0 and
             nbs_ not like '___8%' and mdate_ > dat_
          then
             BEGIN
                select id
                   into id_
                from int_accn
                where acc=acc_
                  and rownum=1;
             EXCEPTION WHEN NO_DATA_FOUND THEN
                id_ := 1;
             END;

             if codcagent_ = 6 then
                if freq_ = 400 then
                   if to_char(NVL(apl_dat_, daos_),'DD') in ('29','30','31') and
                      to_char(dat_,'MM') = '02'
                   then
                      Dat1_:= last_day(dat_);
                   else
                      Dat1_:= to_date(to_char(NVL(apl_dat_, daos_),'DD')||
                                      to_char(dat_,'MMYYYY'),'ddmmyyyy');
                   end if;
                else
                   Dat1_:= add_months(mdateR_,-add_);
                end if;
                datn_ := Dat1_+1;
             else
                Dat1_:= TRUNC(add_months(Dat_,1),'MM');
                datn_ := Dat1_;
             end if;

             k_ := 0;
             kol_k_:= 24-to_number(to_char(Dat_,'MM'));

             while dat1_ <= mdate_

               loop
                  k_ := k_+add_;

                  if codcagent_ = 6 then
                     datk_ := mdateR_;
                  else
                     datk_ := last_day(datn_);
                  end if;

                  if k_ > kol_k_+add_ then
                     datk_ := ADD_MONTHS(dat1_,12);
                  end if;

                  int_ := 0;

                  if k_ > kol_k_+add_ and to_char(datk_,'YYYY') = to_char(mdate_,'YYYY') or
                     to_char(datk_,'MMYYYY') = to_char(mdate_,'MMYYYY')
                  then
                     datk_ := mdate_;
                     date_ := datk_-1;
                  else
                     if codcagent_ = 6 then
                        date_ := datk_-1;
                     else
                        date_ := datk_;
                     end if;
                  end if;

                  acrn.p_int(acc_, id_, datn_, date_, int_, null, 0);

                  if mfo_ = 300120 and codcagent_ in (2,4) and country_ = 643 then
                     int_ := ABS(ROUND(int_,0))*0.9;
                  end if;

                  god1_ :=to_char(datk_,'YYYY');

                  if k_ > kol_k_+add_ then
                     mm1_ := 0;
                  else
                     mm1_ := to_number(to_char(datk_,'MM'));
                  end if;

                  w1_ := f_chr36(mm1_);

                  kodp_:= '31' || LPAD(to_char(kv_),3,'0') || ddd_ || '2' || god1_ || w1_;
                  znap_:= TO_CHAR(ABS(round(int_/100,0)));

                  comm1_ := comm_ ||' begin = ' || to_char(datn_, 'dd.mm.yyyy')
                                  || ' end = ' || to_char(date_, 'dd.mm.yyyy');

                  INSERT INTO rnbu_trace (nls, kv, odate, kodp, znap, nbuc, rnk, comm, mdate)
                  VALUES
                                         (nls_, kv_, data_, kodp_, znap_, nbuc_, rnk_, comm1_, mdate_);

                  if codcagent_ = 6 then
                     datn_ := datk_;
                  else
                     datn_ := datk_+1;
                  end if;

                  dat1_ := datk_+1;

                  mdateR_ := ADD_MONTHS(mdateR_, add_);
               end loop;

          end if;

          if ddd_ in ('410','421','422','430','440','450') and dat_ < to_date('01072012','ddmmyyyy') OR
             ddd_ not in ('410','421','422','430','440','450')
          then
             kodp_:= dk_ || LPAD(to_char(kv_),3,'0') || ddd_ || z_ || '0000' || '0';
             znap_:= TO_CHAR(ABS(se_));

             INSERT INTO rnbu_trace (nls, kv, odate, kodp, znap, nbuc, rnk, comm, mdate)
             VALUES (nls_, kv_, data_, kodp_, znap_, nbuc_, rnk_, comm_, mdate_);

             if mdate_ <= dat_ then    --03.06.2010
                dk_ := '21';
                kodp_:= dk_ || LPAD(to_char(kv_),3,'0') || ddd_ || z_ || '0000' || '0';
             else
                dk_ := '31';
                kodp_:= dk_ || LPAD(to_char(kv_),3,'0') || ddd_ || z_ || god_ || w_;
             end if;

             znap_:= TO_CHAR(ABS(se_));

             INSERT INTO rnbu_trace (nls, kv, odate, kodp, znap, nbuc, rnk, comm, mdate)
             VALUES (nls_, kv_, data_, kodp_, znap_, nbuc_, rnk_, comm_, mdate_);
          end if;
       END IF;

       s41_ := 0;
       s51_ := 0;

       -- формирование новых кодов 41, 51 с 01.02.2011
       -- на 01.06.2015 закрыто формирование кодов 41, 51
       if Dat_ >= to_date('31012011','ddmmyyyy') and Dat_ <= to_date('30042015','ddmmyyyy')
       then
          BEGIN
             select NVL(sum(S),0)
                into s41_
             from tmp_file03
             where nlsd like nls_||'%' and kv=kv_
             group by nlsd,kv;
          EXCEPTION WHEN NO_DATA_FOUND THEN
             s41_ := 0;
          END;

          if mdate_ is not null and mdate_ <= dat_ then
             BEGIN
                select NVL(sum(S),0)
                   into s51_
                from tmp_file03
                where nlsd like nls_||'%' and kv=kv_
                  and fdat between Datnp_ and mdate_ - 1
                group by nlsd,kv;
             EXCEPTION WHEN NO_DATA_FOUND THEN
                s51_ := 0;
             END;
          --else
          --   s51_ := s41_;
          end if;

          if nbs_ like '___8%' and nbs_ != '3548' then
             z_ := '2';
          else
             z_ := '1';
          end if;

          -- в показник 41 включаеться вся сума погашення
          if s41_ != 0 then
             if typ_>0 then
                nbuc_ := nvl(f_codobl_tobo(acc_,typ_),nbuc1_);
             else
                nbuc_ := nbuc1_;
             end if;

             if ddd_ in ('410','421','422','430','440','450') and dat_ < to_date('01072012','ddmmyyyy') OR
                ddd_ not in ('410','421','422','430','440','450')
             then
                dk_ := '41';
                kodp_:= dk_ || LPAD(to_char(kv_),3,'0') || ddd_ || z_ || '0000' || '0';
                znap_:= TO_CHAR(ROUND(ABS(s41_),0));

                INSERT INTO rnbu_trace (nls, kv, odate, kodp, znap, nbuc, rnk, comm, mdate)
                VALUES (nls_, kv_, data_, kodp_, znap_, nbuc_, rnk_, comm_, mdate_);
             end if;
          end if;

          -- в показник 51 включаеться вся сума погашення достроково
          if s51_ != 0 then
             if ddd_ in ('410','421','422','430','440','450') and dat_ < to_date('01072012','ddmmyyyy') OR
                ddd_ not in ('410','421','422','430','440','450')
             then
                dk_ := '51';
                kodp_:= dk_ || LPAD(to_char(kv_),3,'0') || ddd_ || z_ || '0000' || '0';
                znap_:= TO_CHAR(ROUND(ABS(s51_),0));

                INSERT INTO rnbu_trace (nls, kv, odate, kodp, znap, nbuc, rnk, comm, mdate)
                VALUES (nls_, kv_, data_, kodp_, znap_, nbuc_, rnk_, comm_, mdate_);
             end if;
          end if;

       end if;

    END LOOP;
    CLOSE SALDO;
    ---------------------------------------------------------------------------
    -----------------------------------------------------------------------------
    DELETE FROM tmp_nbu where kodf=kodf_ and datf= dat_;
    ---------------------------------------------------
    --if mfo_ = 324805 then
    --   delete from rnbu_trace
    --   where (substr(kodp,10,5)='2014B' or substr(kodp,10,4)='2016');
    --end if;

    mm1_ := to_number(to_char(dat_,'MM'));
    w1_ := f_chr36(mm1_);
    god1_ := to_char(Dat_,'YYYY');
    -- прогноз только на текущий и последующий годы
    if dat_ > to_date('31032014','ddmmyyyy')
    then
       delete from rnbu_trace
       where substr(kodp,1,2) = '31'
         and ( substr(kodp,10,5) <= god1_ || w1_ OR
               substr(kodp,10,4) > to_char( to_number(god1_) + 1)
             );
    end if;


    INSERT INTO tmp_nbu(kodf, datf, kodp, znap, nbuc)
    SELECT kodf_, Dat_, kodp, SUM(znap), nbuc
    FROM rnbu_trace
    WHERE znap <> 0
    GROUP BY kodf_, Dat_, kodp, nbuc;
    ----------------------------------------
    logger.info ('P_F1A_NN: End for datf = '||to_char(dat_, 'dd/mm/yyyy'));
END p_f1a_nn;
/
show err;

PROMPT *** Create  grants  P_F1A_NN ***
grant EXECUTE                                                                on P_F1A_NN        to BARS_ACCESS_DEFROLE;
grant EXECUTE                                                                on P_F1A_NN        to RPBN002;



PROMPT ===================================================================================== 
PROMPT *** End *** ========== Scripts /Sql/BARS/Procedure/P_F1A_NN.sql =========*** End *** 
PROMPT ===================================================================================== 
