create or replace procedure p_f51_NN( Dat_    DATE,
                                      sheme_  varchar2 default 'G',
                                      tipost_ varchar2 default 'S') IS
/*%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
% DESCRIPTION :    Процедура формирования @51 внутршнiй файл Ощадбанку
% COPYRIGHT   :    Copyright UNITY-BARS Limited, 2009.  All Rights Reserved.
% VERSION     :    26.01.2018 (13/01/2016, 12/01/2016, 29/01/2015)
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
параметры: Dat_ - отчетная дата
           sheme_ - схема формирования
           tipost_ - тип остатков 6 и 7 классов
                     'S'-с учетом проводок перекрытия на 5040(5041)
                     'R'- без учета проводок перекрытия на 5040(5041)
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
13/01/2016 - исключаем проводки перекрытия корректирующих за декабрь
07/09/2012 - доработки по переносу переоценки из 02 файла
24.07.2012 - заменил вызов функции F_POP_OTCN на F_POP_OTCN_OLD т.к.
             не изменялись остатки в месячных SNAP с 13.07.2012
07/12/2011 - доработки по переносу переоценки из 02 файла
04/11/2011 - перенос по OTCN_ARCH_PEREOC
05.04.2011 - убрал ORDER BY в курсоре BASEL
18.03.2010 - добавил и схему "C" для формирования кода подразделения
07.10.2009 - для OB22 добавил условие TRIM(ob22)
11.09.2009 - добавила дополнительный блок из 02 файла, кот. был вставлен
             специально для Сбербанка
08.09.2009 - не враховувались коригуючi проводки
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%*/
kodf_    varchar2(2):='51';
typ_     number;
acc_     Number;
nbs_     Varchar2(4);
kv_      SMALLINT;
nls_     Varchar2(15);
mfo_     Varchar2(12);
nbuc1_   Varchar2(20);
nbuc_    Varchar2(20);
data_    Date;
Ostn_    DECIMAL(24);
Ostq_    DECIMAL(24);
dk_      Varchar2(2);
kodp_    Varchar2(11);
znap_    Varchar2(30);
userid_  Number;
dig_     number;
b_       Varchar2(30);
tips_    Varchar2(3);
sql_acc_ varchar2(2000);
ret_     number;
ob22_    Varchar2(2);
Dos96_   DECIMAL(24);
Dosq96_  DECIMAL(24);
Kos96_   DECIMAL(24);
Kosq96_  DECIMAL(24);
Dos99_   DECIMAL(24);
Dosq99_  DECIMAL(24);
Kos99_   DECIMAL(24);
Kosq99_  DECIMAL(24);
Doszg_   DECIMAL(24);
Koszg_   DECIMAL(24);
Dos96zg_ DECIMAL(24);
Kos96zg_ DECIMAL(24);
pr_      NUMBER;
comm_    rnbu_trace.comm%TYPE;
k041_    varchar2(1);
pacc_    number;
d_sum_   number;
k_sum_   number;

  CURSOR SALDO IS
  SELECT a.acc, a.nls, a.kv, a.nbs, s.fdat,  NVL(s.ost,0), NVL(s.ostq,0),
         a.tip, NVL(a.ob22,'00'),
         s.dos96, s.dosq96, s.kos96, s.kosq96,
         s.dos99, s.dosq99, s.kos99, s.kosq99,
         s.doszg, s.koszg, s.dos96zg, s.kos96zg,
         substr(F_K041(c.country),1,1) K041,
         lag(s.acc, 1) over (partition by substr(s.nls,1,4),s.kv order by s.acc) p_acc
    FROM otcn_saldo s, otcn_acc a, customer c
   WHERE s.acc = a.acc
     and s.rnk = c.rnk;
------------------------------------------------------------------
  CURSOR BaseL IS
    SELECT kodp, nbuc, SUM(znap)
    FROM rnbu_trace
    WHERE to_number(znap) <> 0
    GROUP BY kodp, nbuc;
-----------------------------------------------------------------------------
  procedure p_ins( p_dat_ date, p_tp_ varchar2, p_nls_ varchar2, p_nbs_ varchar2,
            p_ob22_ varchar2, p_kv_ smallint,
            p_znap_ varchar2 )
  IS
    kod_ varchar2(11);
  begin
    
    if length(trim(p_tp_)) = 1 
    then
      IF p_kv_ = 980 THEN
        kod_ := '0';
      ELSE
        kod_ := '1';
      END IF;
    end if;

    kod_:= p_tp_ || kod_ || p_nbs_ || p_ob22_ || lpad(p_kv_,3,'0') ;

    INSERT INTO rnbu_trace
           ( nls, kv, odate, kodp, znap, nbuc, comm, acc )
    VALUES ( p_nls_, p_kv_, p_dat_, kod_, p_znap_, nbuc_, comm_, acc_);
    
  end P_INS;
-----------------------------------------------------------------------------
BEGIN
  bars_audit.info( $$PLSQL_UNIT||': BEGIN' );
  -------------------------------------------------------------------
  userid_ := user_id;

  EXECUTE IMMEDIATE 'TRUNCATE TABLE RNBU_TRACE';
  -------------------------------------------------------------------
  mfo_ := F_OURMFO();

  ------------------------------------------------------------------------
  -- определение начальных параметров (код области или МФО или подразделение)
  P_PROC_SET( kodf_,sheme_,nbuc1_,typ_ );

  -- используем классификатор SB_R020
  sql_acc_ := q'[select R020 from SB_R020 where F_21='1' and lnnvl( D_CLOSE <= to_date('%rptdt','dd.mm.yyyy') )]';
  sql_acc_ := replace( sql_acc_, '%rptdt', to_char(Dat_,'dd.mm.yyyy') );

  ret_ := F_POP_OTCN( Dat_, 3, sql_acc_ );

  -- формирование протокола в табл. RBNU_TRACE
  OPEN SALDO;
  LOOP
    FETCH SALDO
     INTO acc_, nls_, kv_, nbs_, data_, Ostn_, Ostq_,
          tips_, ob22_, Dos96_, Dosq96_, Kos96_, Kosq96_,
          Dos99_, Dosq99_, Kos99_, Kosq99_,
          Doszg_, Koszg_, Dos96zg_, Kos96zg_ , k041_, pacc_;
    
    EXIT WHEN SALDO%NOTFOUND;

    if sheme_  in ('C','G') and (tips_<>'T00' and tips_<>'T0D') and typ_>0 then
      nbuc_ := nvl(nvl(F_Codobl_Tobo_new(acc_, dat_, typ_), F_Codobl_Tobo(acc_,typ_)), nbuc1_);
    else
      nbuc_ := nbuc1_;
    end if;

    -- обороты по перекрытию 6,7 классов на 5040,5041
    IF to_char(Dat_,'MM')='12' and (nls_ like '6%' or nls_ like '7%' or nls_ like '504%' or nls_ like '390%') THEN
      SELECT NVL(SUM(decode(dk,0,1,0)*s),0),
             NVL(SUM(decode(dk,1,1,0)*s),0)
        INTO d_sum_, k_sum_
        FROM opldok
       WHERE fdat  between Dat_  AND Dat_+29 AND
             acc  = acc_   AND
            (tt like 'ZG8%'  or tt like 'ZG9%');

      Dos96_:=Dos96_-d_sum_;
      Kos96_:=Kos96_-k_sum_;
      
    END IF;

    Ostn_ := Ostn_ - Dos96_  + Kos96_;
    Ostq_ := Ostq_ - Dosq96_ + Kosq96_;

    IF Ostn_ <> 0 THEN
      dk_ := IIF_N(Ostn_,0,'1','2','2');
      p_ins(data_, dk_, nls_, nbs_, ob22_, kv_, TO_CHAR(ABS(Ostn_)));
    END IF;

    IF Ostq_ <> 0 THEN
      dk_ := IIF_N(Ostq_,0,'1','2','2') || '0';

      p_ins(data_, dk_, nls_, nbs_, ob22_, kv_, TO_CHAR(ABS(Ostq_)));
    END IF;

  END LOOP;
  
  CLOSE SALDO;
  
  ---------------------------------------------------------------------
  -- 04.04.2008
  -- по просьбе ОПЕРУ СБ для счетов тех.переоценки изменяем код валюты на 978
  -- при отсутствии номинала для данной валюты с 01.03.2008
  --IF mfo_=322498 and Dat_ >= to_date('01032006','ddmmyyyy') then
  IF mfo_ IN ('300465','333368') and Dat_ >= to_date('01032008','ddmmyyyy')
  then
    for k in (select nls, kv, kodp
                from rnbu_trace
               where nls LIKE '3800_000000000%'
                 and kv not in (643, 840, 978) )
    loop

      IF substr(k.kodp,1,2) in ('10','20') THEN
         select count(*)
           into pr_
           from rnbu_trace
          where substr(kodp,1,2) = substr(k.kodp,1,1) || '1'
            and substr(kodp,3,8) = substr(k.kodp,3,8);

         IF pr_=0 then
            kodp_ := substr(k.kodp,1,6) || '978' || substr(k.kodp,-1) ;
            update rnbu_trace set kodp = kodp_
            where nls = k.nls
              and kv = k.kv;
         END IF;
      END IF;

    end loop;

  end if;
  ----------------------------------------------------------------------------
  -- при отсутствии номинала для данной валюты с 01.03.2008
  IF mfo_ in ('333368') and Dat_ >= to_date('01032008','ddmmyyyy') then

   kodp_ := null;

   for k in (select nls, kv, kodp
             from rnbu_trace
             where nls LIKE '9910_001%'
               and kv != 980
             order by nls, kv, substr(kodp,1,2))
   loop

      IF substr(k.kodp,1,2) in ('10','20') THEN
         select count(*)
            into pr_
         from rnbu_trace
         where substr(kodp,1,2) = substr(k.kodp,1,1)||'1'
           and substr(kodp,3,8) = substr(k.kodp,3,8);

         IF pr_ = 0 then

            select count(*)
               into pr_
            from rnbu_trace
            where substr(kodp,1,2) = substr(k.kodp,1,1) || '1'
              and substr(kodp,3,4) = '9900'
              and substr(kodp,7,3) = k.kv;

            if pr_ <> 0 then
               kodp_ := substr(k.kodp,1,2) || '9900' || k.kv || substr(k.kodp,-1) ;
               nls_ := k.nls;
               kv_  := k.kv;
               update rnbu_trace set kodp = kodp_
               where nls = k.nls
                 and kv = k.kv
                 and substr(kodp,1,2) = substr(k.kodp,1,2);
            else
               select count(*)
                  into pr_
               from rnbu_trace
               where substr(kodp,1,2) = substr(k.kodp,1,1) || '1'
                 and substr(kodp,3,4) = '9900'
                 and substr(kodp,7,3) = '978';

               if pr_ = 0 then
                  select count(*)
                     into pr_
                  from rnbu_trace
                  where substr(kodp,1,2) = substr(k.kodp,1,1) || '1'
                    and substr(kodp,3,4) = '9900'
                    and substr(kodp,7,3) = '840';

                  if pr_ <> 0 then
                     kodp_ := substr(k.kodp,1,2) || '9900' || '840' || substr(k.kodp,-1) ;
                     nls_ := k.nls;
                     kv_  := k.kv;
                     update rnbu_trace set kodp = kodp_
                     where nls = k.nls
                       and kv = k.kv
                       and substr(kodp,1,2) = substr(k.kodp,1,2);
                  end if;
               else
                  kodp_:= substr(k.kodp,1,2) || '9900' || '978' || substr(k.kodp,-1) ;
                  nls_ := k.nls;
                  kv_  := k.kv;
                  update rnbu_trace set kodp = kodp_
                  where nls = k.nls
                    and kv = k.kv
                    and substr(kodp,1,2) = substr(k.kodp,1,2);
               end if;
            end if;
         ELSE
            kodp_ := null;
         END IF;
      END IF;

      if kodp_ is not null and substr(k.kodp,1,2) in ('50','60') and
         k.nls = nls_ and k.kv = kv_ then

         select count(*)
            into pr_
         from rnbu_trace
         where substr(kodp,1,2) = substr(k.kodp,1,1) || '1'
           and substr(kodp,3,8) = substr(k.kodp,3,8);

         IF pr_ = 0 then
            update rnbu_trace set kodp = substr(k.kodp,1,2) || substr(kodp_,3,8)
            where nls = k.nls
              and kv = k.kv
              and substr(kodp,1,2) = substr(k.kodp,1,2);
         END IF;
      end if;

    end loop;

  END IF;

  for k in (select a.*,
    (select recid from rnbu_trace r where r.kodp = substr(a.kodp,1,1)||'0'||substr(a.kodp,2) and nbuc = a.nbuc) recid,
    (select max(nbuc) from rnbu_trace r where r.kodp = substr(a.kodp,1,1)||'1'||substr(a.kodp,2)) new_nbuc
            from (
            select substr(kodp,1,1)||substr(kodp,3) kodp, nbuc
            from rnbu_trace
            where kodp not like '%980'
            group by substr(kodp,1,1)||substr(kodp,3), nbuc
            having count(*) = 1) a)
  loop
    if k.new_nbuc is not null then
        update rnbu_trace
        set nbuc = k.new_nbuc
        where recid = k.recid;
    else
        select max(kodp), max(nbuc)
        into kodp_, nbuc_
        from rnbu_trace
        where kodp like substr(k.kodp,1,1)||'1'||substr(k.kodp,2,4)||'__'||substr(k.kodp,8);

        if kodp_ is not null and nbuc_ is not null then
            kodp_ := substr(kodp_,1,1)||'0'||substr(kodp_,3);

            update rnbu_trace
            set nbuc = nbuc_,
                kodp = kodp_
            where recid = k.recid;
        end if;
    end if;
  end loop;
  ---------------------------------------------------
  DELETE FROM tmp_nbu WHERE kodf = kodf_ AND datf = Dat_;
  ---------------------------------------------------
  --- формирование файла в табл. TMP_NBU
  OPEN BaseL;
  LOOP
    FETCH BaseL INTO  kodp_, nbuc_, znap_;
    
    EXIT WHEN BaseL%NOTFOUND;
    
    if substr(kodp_,9,3) = '980' or substr(kodp_,2,1) <> '1' then
       b_ := znap_;
    else
       dig_ := f_ret_dig(to_number(substr(kodp_,9,3)));
       b_ := TO_CHAR(ROUND(TO_NUMBER(znap_)/dig_,0));
    end if;

    INSERT INTO tmp_nbu
         (kodf, datf, kodp, znap, nbuc)
    VALUES
         (kodf_, Dat_, kodp_, b_, nbuc_);

  END LOOP;
  
  CLOSE BaseL;

  OTC_DEL_ARCH( kodf_, dat_, 0);
  
  OTC_SAVE_ARCH( kodf_, dat_, 0);
  
  commit;
  
  bars_audit.info( $$PLSQL_UNIT||': END' );
  
END p_f51_NN;
/

show errors;
