

PROMPT ===================================================================================== 
PROMPT *** Run *** ========== Scripts /Sql/BARS/Procedure/P_F37SB.sql =========*** Run *** =
PROMPT ===================================================================================== 


PROMPT *** Create  procedure P_F37SB ***

CREATE OR REPLACE PROCEDURE BARS.P_F37SB (Dat_ DATE, sheme_ VARCHAR2 DEFAULT 'C' ) IS
/*%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
% FILE NAME   : Процедура формирования файла @37 для СБ
% DESCRIPTION : Отчетность СберБанка: формирование файлов
% COPYRIGHT   : Copyright UNITY-BARS Limited, 2001.  All Rights Reserved.
% VERSION     : 02/02/2018 (26/12/2017, 19/12/2017)
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
% 02/02/2018 для определения кодов 10 или 20 анализировался остаток в
%            в номинале (Ostn_) вместо эквивалента (Oste_)
%            (если номинал 0 а эквивалент не 0 возникает перебежка) 
% 26/12/2017 для SB_R020 изменено условие для поля D_CLOSE
% 02/02/2016 все показатели будем формировать из таблицы OTCN_SALDO
%            наполненной из ACCM_SNAP_BALANCES
% 06/01/2016 исключаем дату 0101GGGG для оборотов
% 04/06/2013 в курсоре SALDOBQ данные будем выбирать из OTCN_SALDO,
%            OTCN_ACC вместо SALDOA, ACCOUNTS
% 03/06/2013 в курсоре BASEL добавил условие ZNAP <> 0
% 26/01/2013 добавил вызов процедуры P_OTC_VE9
% 26/05/2012 формируем в разрезе кодов территорий
% 23/08/2011 підправила початкову дату для оборотів, щоб включались обороти
%            якщо банківський день був відкритий на вихідних (міграція АСВО)
% 30.04.2011 добавил acc,tobo в протокол
% 28.02.2011 в поле комментарий вносим код TOBO и название счета
% 21.12.2010 для курсора SaldoBQ добавил условие s.kv != 980 т.к.
%            в Херсоне в SALDOB присутствуют лиц.счета с кодом валюты
%            980 (бал.счет 9809 лиц. 98097012700006)
% 27.04.2010 т.к.выполняли миграцию АСВ 24.04.2010 то утановили дату
%            для переменной Dat1_=to_date('24042010','ddmmyyyy')
% 28.12.2009 для 420 строки добавлено условие "ROWNUM=1"
% 04.12.2009 вместо переменной mfo_ используем переменную mfou_ для
%            спецобработки счетов вида 3800_000000000
% 23.11.2009 убрал блок для заполнения спецпараметра OB22
% 16.06.2009 для Ровно СБ для счетов тех.переоценки и кодов валют не
%            643,826,840,978 изменяем код валюты на 978 только для валют
%            для которых есть эквивалент и нет номинала (не учитываем
%            значение кода OB22)
% 10.06.2009 для SALDOA C убрано условие s.acc=c.acc
% 31.05.2009 для Ровно СБ для счетов тех.переоценки и кодов валют не
%            643,826,840,978 изменяем код валюты на 978 т.к. для этих
%            валют есть эквивалент и нет номинала (ошибка при внутреннем
%            контроле)
% 19.05.2009 для формирования показателей по оборотам для отчетной даты
%            18.05.2009 добавляем дату 17.05.2009 т.к. миграция выпол-
%            нялась 17.05.2009
% 05.03.2009 убрал деление на 10 для металлов т.к. перевели до 2 знаков
%            специфика системы Сбербанка
% 04.04.2008 добавил еще условие для данной замены substr(kodp,1,2)=
%            substr(k.kodp,1,2) (выбираем код остатка или оборотов).
%            Замечания СБ.
% 05.03.2008 ОПЕРУ СБ для счетов тех.переоценки и кодов валют не 643,840,
%            978 изменяем код валюты на 978 т.к. для этих валют есть
%            эквивалент и нет номинала (ошибка при внутреннем контроле)
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%*/
kodf_  varchar2(2) := '37';
acc_    Number;
acc1_   Number;
acc2_   Number;
pr_     Number;
pr_pp   Number;
dat1_   Date;
dat2_   Date;
datN_   Date;
Dosn_   DECIMAL(24);
Dose_   DECIMAL(24);
Kosn_   DECIMAL(24);
Kose_   DECIMAL(24);
se_     DECIMAL(24);
sn_     DECIMAL(24);
Ostn_   DECIMAL(24);
Oste_   DECIMAL(24);
kodp_   varchar2(11);
kodp_ost varchar2(11);
znap_   varchar2(30);
Kv_     SMALLINT;
Nbs_    varchar2(4);
nls_    varchar2(15);
s0000_  varchar2(15);
s0009_  varchar2(15);
s3800_  varchar2(15);
data_   date;
datp_   date;
zz_     Varchar2(2);
ob22_   Varchar2(2);
dk_     char(1);
f37_    Number;
userid_ Number;
mfo_    Number;
mfou_   Number;
tobo_   accounts.tobo%TYPE;
nms_    accounts.nms%TYPE;
comm_   rnbu_trace.comm%TYPE;
typ_       Number;
nbuc1_   VARCHAR2(12);
nbuc_    VARCHAR2(12);

sql_acc_ clob;
ret_     number;

datz_        date := Dat_Next_U(dat_, 1);

---Остатки на отчетную дату (грн. + валюта)
CURSOR SaldoASeekOstf IS
   SELECT s.acc, s.nls, s.kv, aa.fdat, s.nbs, NVL(trim(s.ob22),'00'),
          aa.ost, aa.ostq,
          aa.dos, aa.kos,
          aa.dosq, aa.kosq,
          s.tobo, s.nms
   FROM otcn_acc s, otcn_saldo aa
   WHERE aa.acc=s.acc
     and (aa.ost + aa.ostq <> 0 or
          aa.dos + aa.kos <> 0  or
          aa.dosq + aa.kosq <> 0)
     and nvl(dat_alt, dat_ - 1) <> dat_
        union all
   SELECT s.acc, aa.acc_num nls, s.kv, dat_ fdat,
          substr(aa.acc_num, 1, 4) nbs,
          NVL(trim(aa.acc_ob22),'00'),
          aa.ost_rep ost, aa.ostq_rep ostq,
          aa.dos_repd dos, aa.kos_repd kos,
          aa.dosq_repd dosq, aa.kosq_repd kosq,
          s.tobo, s.nms
   FROM otcn_acc s, nbur_kor_balances aa
   WHERE aa.report_date = dat_
     and aa.acc_id=s.acc
     and (aa.ost_rep + aa.ostq_rep <> 0 or
          aa.dos_repd + aa.kos_repd <> 0  or
          aa.dosq_repd + aa.kosq_repd <> 0)
     and nvl(dat_alt, dat_ - 1) = dat_;

CURSOR BaseL IS
    SELECT kodp, nbuc, SUM (znap)
    FROM rnbu_trace
    WHERE znap <> 0
    GROUP BY kodp, nbuc;

BEGIN
-------------------------------------------------------------------
userid_ := user_id;
EXECUTE IMMEDIATE 'TRUNCATE TABLE RNBU_TRACE';
-------------------------------------------------------------------
mfo_:=gl.aMFO;
if mfo_ is null then
    mfo_ := f_ourmfo_g;
end if;

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

Dat1_ := TRUNC(Dat_, 'MM');
Dat2_ := TRUNC(Dat_ + 28);

if Dat_=to_date('26042010','ddmmyyyy') then
   Dat1_ := to_date('24042010','ddmmyyyy');
end if;

datp_ := Calc_Pdat (dat_);

-- предыдущая рабочая дата
Dat1_ := datp_ - 1;

-- предыд. банковский день + 1 день (для оборотов)???
datn_  := dat_next_u(dat_, -1) + 1;

-- исключаем 0101GGGG
if to_char(datn_,'DDMM') = '0101'
then
   datn_  := datn_ + 1 ;
end if;

-- определение начальных параметров
P_Proc_Set_Int(kodf_,sheme_,nbuc1_,typ_);

sql_acc_ := 'select r020 from sb_r020 where f_37=''1'' and '||
    'd_open <= to_date('''||to_char(datz_, 'ddmmyyyy')||''', ''ddmmyyyy'') and '||
    '(d_close is null or d_close >= to_date('''||to_char(datz_, 'ddmmyyyy')||''', ''ddmmyyyy'')) ';

ret_ := f_pop_otcn(Dat_, 1, sql_acc_);

----------------------------------------------------------------------------
-- Остатки (грн. + валюта номиналы) --
OPEN SaldoASeekOstf;
LOOP
   FETCH SaldoASeekOstf INTO acc_, nls_, kv_, data_, Nbs_, zz_, Ostn_, Oste_,
                             Dosn_, Kosn_, Dose_, Kose_, tobo_, nms_;
   EXIT WHEN SaldoASeekOstf%NOTFOUND;

   comm_ := '';
   comm_ := substr(comm_ || tobo_ || '  ' || nms_, 1, 200);

   IF typ_>0 THEN
      nbuc_ := NVL(F_Codobl_Tobo(acc_,typ_),nbuc1_);
   ELSE
      nbuc_ := nbuc1_;
   END IF;

   IF Ostn_<>0 THEN
      dk_:=IIF_N(Ostn_,0,'1','2','2');
      IF Kv_=980 THEN
         kodp_:=dk_ || '0' ;
      ELSE
         kodp_:=dk_ || '1' ;
      END IF ;

      kodp_:=kodp_ || Nbs_ || zz_ || lpad(Kv_,3,'0') ;
      znap_:=TO_CHAR(ABS(Ostn_));

      INSERT INTO rnbu_trace         -- Остатки в номинале валюты
              (nls, kv, odate, kodp, znap, acc, comm, tobo, nbuc)
      VALUES  (nls_, kv_, data_, kodp_, znap_, acc_, comm_, tobo_, nbuc_) ;
   END IF;

   IF Oste_<>0 and kv_ <> '980' THEN
      dk_:=IIF_N(Oste_,0,'1','2','2');
      kodp_:=dk_ || '0' ;

      kodp_:=kodp_ || Nbs_ || zz_ || lpad(Kv_,3,'0') ;
      znap_:=TO_CHAR(ABS(Oste_));

      INSERT INTO rnbu_trace         -- Остатки в эквиваленте валюты
              (nls, kv, odate, kodp, znap, acc, comm, tobo, nbuc)
      VALUES  (nls_, kv_, data_, kodp_, znap_, acc_, comm_, tobo_, nbuc_) ;
   END IF;

   IF Dosn_ > 0 THEN
      IF Kv_=980 THEN
         kodp_:='50' || Nbs_ || zz_ || lpad(Kv_,3,'0') ;
      ELSE
         kodp_:='51' || Nbs_ || zz_ || lpad(Kv_,3,'0') ;
      END IF ;
      znap_:=TO_CHAR(Dosn_);
      INSERT INTO rnbu_trace     -- Дб. обороты в номинале валюты (грн.+вал.)
              (nls, kv, odate, kodp, znap, acc, comm, tobo, nbuc)
      VALUES  (nls_, kv_, dat_, kodp_, znap_, acc_, comm_, tobo_, nbuc_) ;
   END IF;

   IF Kosn_ > 0 THEN
      IF Kv_=980 THEN
         kodp_:='60' || Nbs_ || zz_ || lpad(Kv_,3,'0') ;
      ELSE
         kodp_:='61' || Nbs_ || zz_ || lpad(Kv_,3,'0') ;
      END IF ;
      znap_:=TO_CHAR(Kosn_) ;
      INSERT INTO rnbu_trace     -- Кр. обороты в номинале валюты (грн.+вал.)
              (nls, kv, odate, kodp, znap, acc, comm, tobo, nbuc)
      VALUES  (nls_, kv_, dat_, kodp_, znap_, acc_, comm_, tobo_, nbuc_) ;
   END IF;

   IF Dose_ > 0 and kv_ <> '980'  THEN
      kodp_:='50' || Nbs_ || zz_ || lpad(Kv_,3,'0') ;
      znap_:=TO_CHAR(Dose_);
      INSERT INTO rnbu_trace     -- Дб. обороты в эквиваленте валюты
              (nls, kv, odate, kodp, znap, acc, comm, tobo, nbuc)
      VALUES  (nls_, kv_, dat_, kodp_, znap_, acc_, comm_, tobo_, nbuc_) ;
   END IF;

   IF Kose_ > 0 and kv_ <> '980' THEN
      kodp_:='60' || Nbs_ || zz_ || lpad(Kv_,3,'0') ;
      znap_:=TO_CHAR(Kose_) ;
      INSERT INTO rnbu_trace     -- Кр. обороты в эквиваленте валюты
              (nls, kv, odate, kodp, znap, acc, comm, tobo, nbuc)
      VALUES  (nls_, kv_, dat_, kodp_, znap_, acc_, comm_, tobo_, nbuc_) ;
   END IF;

END LOOP;
CLOSE SaldoASeekOstf;
--------------------------------------------------------------------
-- по просьбе ОПЕРУ СБ для счетов тех.переоценки изменяем код валюты на 978
-- при отсутствии номинала для данной валюты с 01.03.2008
IF Dat_ >= to_date('01032008','ddmmyyyy')  and
         mfou_ in (300465) then
   kodp_ost := null;
   for k in (select nls, kv, kodp
             from rnbu_trace
             where nls LIKE '3800_000000000%'
               and kv not in (643, 826, 840, 978)
             order by nls, kv, substr(kodp,1,2) )
   loop

       ob22_ := substr(k.kodp,7,2);

       if substr(k.kodp,1,2) in ('10','20','50','60') then
          select count(*)
             into pr_
          from rnbu_trace
          where substr(kodp,1,2)=substr(k.kodp,1,1)||'1'
            and substr(kodp,3,9)=substr(k.kodp,3,9);

          if pr_ = 0 then
             select count(*)
                into pr_
             from rnbu_trace
             where nls <> k.nls
               and substr(kodp,1,2)=substr(k.kodp,1,1)||'1'
               and substr(kodp,3,4)=substr(k.kodp,3,4)
    --           and substr(kodp,7,2)=ob22_
               and substr(kodp,9,3)=substr(k.kodp,9,3);

             if pr_ <> 0 then
                BEGIN
                   select substr(kodp,7,2)
                      into ob22_
                   from rnbu_trace
                   where nls <> k.nls
                     and substr(kodp,1,2)=substr(k.kodp,1,2)
                     and substr(kodp,3,4)=substr(k.kodp,3,4)
                     and substr(kodp,9,3)=substr(k.kodp,9,3)
                     and to_number(znap) = (select max(to_number(a.znap))
                                               from rnbu_trace a
                                               where substr(a.kodp,1,2)=substr(k.kodp,1,2)
                                                 and substr(a.kodp,3,4)=substr(k.kodp,3,4)
                                                 and substr(a.kodp,9,3)=substr(k.kodp,9,3))
                     and ROWNUM=1;

                   kodp_ost := substr(k.kodp,1,6) || ob22_ ||substr(k.kodp,9,3);
                   nls_ := k.nls;
                   kv_  := k.kv;
                   update rnbu_trace set kodp=kodp_ost
                   where nls=k.nls
                     and kv=k.kv
                     and substr(kodp,1,2)=substr(k.kodp,1,2);
                EXCEPTION WHEN NO_DATA_FOUND THEN
                   ob22_:= substr(k.kodp,7,2);
                END ;
             end if;

             if pr_ = 0 then
                select count(*)
                   into pr_
                from rnbu_trace
                where nls <> k.nls
                  and substr(kodp,1,2)=substr(k.kodp,1,1)||'1'
                  and substr(kodp,3,4)=substr(k.kodp,3,4)
                  and substr(kodp,7,2)=ob22_
                  and substr(kodp,9,3)='978';

                if pr_ <> 0 then
                   kodp_ost := substr(k.kodp,1,6) || ob22_ || '978' ;
                   nls_ := k.nls;
                   kv_  := k.kv;
                   update rnbu_trace set kodp=kodp_ost
                   where nls=k.nls
                     and kv=k.kv
                     and substr(kodp,1,2)=substr(k.kodp,1,2);
                else
                   BEGIN
                      select substr(kodp,7,2)
                         into ob22_
                      from rnbu_trace
                      where nls <> k.nls
                        and substr(kodp,1,2)=substr(k.kodp,1,2)
                        and substr(kodp,3,4)=substr(k.kodp,3,4)
                        and substr(kodp,9,3)='978'
                        and to_number(znap) = (select max(to_number(a.znap))
                                               from rnbu_trace a
                                               where substr(a.kodp,1,2)=substr(k.kodp,1,2)
                                                 and substr(a.kodp,3,4)=substr(k.kodp,3,4)
                                                 and substr(a.kodp,9,3)='978' );

                      kodp_ost := substr(k.kodp,1,6) || ob22_ || '978';
                      nls_ := k.nls;
                      kv_  := k.kv;
                      update rnbu_trace set kodp=kodp_ost
                      where nls=k.nls
                        and kv=k.kv
                        and substr(kodp,1,2)=substr(k.kodp,1,2);
                   EXCEPTION WHEN NO_DATA_FOUND THEN
                      ob22_:= substr(k.kodp,7,2);
                   END ;
                end if;
             end if;
          else
             kodp_ost := null;
          end if;
       end if;
   end loop;

END IF;

-- Манипуляции с вешалками
--if (mfou_ = 300465 and mfo_ <> mfou_)  or mfou_ in (380764) then
--   P_OTC_VE9 (dat_, kodf_);
--end if;
---------------------------------------------------
DELETE FROM tmp_irep where kodf='37' and datf= dat_;
---------------------------------------------------
OPEN BaseL;
LOOP
   FETCH BaseL INTO  kodp_, nbuc_, znap_;
   EXIT WHEN BaseL%NOTFOUND;

  INSERT INTO tmp_irep
        (kodf, datf, kodp, znap, nbuc)
   VALUES
        ('37', Dat_, kodp_, znap_, nbuc_);
END LOOP;
CLOSE BaseL;
------------------------------------------------------------------
END p_f37sb;
/
show err;

PROMPT *** Create  grants  P_F37SB ***
grant EXECUTE                                                                on P_F37SB         to BARS_ACCESS_DEFROLE;
grant EXECUTE                                                                on P_F37SB         to RPBN002;
grant EXECUTE                                                                on P_F37SB         to WR_ALL_RIGHTS;



PROMPT ===================================================================================== 
PROMPT *** End *** ========== Scripts /Sql/BARS/Procedure/P_F37SB.sql =========*** End *** =
PROMPT ===================================================================================== 
