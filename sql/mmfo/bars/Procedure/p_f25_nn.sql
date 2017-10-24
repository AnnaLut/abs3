

PROMPT ===================================================================================== 
PROMPT *** Run *** ========== Scripts /Sql/BARS/Procedure/P_F25_NN.sql =========*** Run *** 
PROMPT ===================================================================================== 


PROMPT *** Create  procedure P_F25_NN ***

  CREATE OR REPLACE PROCEDURE BARS.P_F25_NN (Dat_ DATE,
                                      sheme_ varchar2 default 'G')  IS
/*%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
% DESCRIPTION :    Процедура формирование файла #25 для КБ
% COPYRIGHT   :    Copyright UNITY-BARS Limited, 1999.All Rights Reserved.
% VERSION     : 19.01.2017  (20/01/2016, 13/01/2016, 17/01/2014)
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
параметры: Dat_ - отчетная дата
           sheme_ - схема формирования
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
19.01.2017 проводки перекрытия исключаются из корректирующих оборотов,
           если эти обороты больше нуля
20.01.2016 добавлено заполнение поля ACC в RNBU_TRACE
13.01.2016 убрал мусор 
17.01.2014 исключаем проводки перекрытия корректирующих за декабрь
17.01.2012 вместо функции F_POP_OTCN_N будем использовать F_POP_OTCN
           т.к. функция F_POP_OTCN добавили накопление полей по
           перекрытию 6,7 классов на 5040(5041) и кореектирующих
           за грудень 6,7 классов на 5040(5041)
15.01.2012 вместо функции F_POP_OTCN будем использовать F_POP_OTCN_N
           т.к. функция F_POP_OTCN испoльзует накопление из SNAP таблицы
           в которой нет оборотов перекрытия 6,7 классов на 5040(5041)
11.01.2011 для переменной userid_ используем функцию USER_ID
19.01.2010 так как НБУ не поддерживает заполнение поля F_01 в классифи-
           каторе KL_R020, а перечень бал.счетов включаемых в файл
           имеется в KOD_R020, то будем использовать KOD_R020 вместо
           KL_R020
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%*/
kodf_    varchar2(2):='25';
rnk_     number;
typ_      number;
acc_     Number;
dat1_    Date;
dat2_    Date;
datn_    date;
dig_     Number;
Dos_     DECIMAL(24);
Dosq_    DECIMAL(24);
Kos_     DECIMAL(24);
Kosq_    DECIMAL(24);
Dos96p_  DECIMAL(24);
Dosq96p_ DECIMAL(24);
Kos96p_  DECIMAL(24);
Kosq96p_ DECIMAL(24);
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
Dos99zg_ DECIMAL(24);
Kos99zg_ DECIMAL(24);
Ostn_    DECIMAL(24);
Ostq_    DECIMAL(24);
kodp_    Varchar2(10);
znap_    Varchar2(30);
Kv_      SMALLINT;
Kv1_     SMALLINT;
Vob_     SMALLINT;
Nbs_     Varchar2(4);
nls_     Varchar2(15);
mfo_     Varchar2(12);
mfou_    NUMBER;
data_    Date;
k041_    Char(1);
dk_      varchar2(2);
nbu_     SMALLINT;
prem_    Char(3);
userid_  Number;
nbuc1_   Varchar2(12);
nbuc_    Varchar2(12);
b_       Varchar2(30);
tips_    Varchar2(3);
flag_    number;
sql_acc_ varchar2(2000):='';
sql_doda_ varchar2(200):='';
ff_      number;
ret_     number;
d_sum_   DECIMAL(24);
k_sum_   DECIMAL(24);
-------------------------------------------------------------------------------
CURSOR Saldo IS
   SELECT a.rnk, a.acc, a.nls, a.kv, s.fdat, a.nbs, s.ost, s.ostq,
          s.dos, s.dosq, s.kos, s.kosq,
          s.dos96p, s.dosq96p, s.kos96p, s.kosq96p,
          s.dos96, s.dosq96, s.kos96, s.kosq96,
          s.dos99, s.dosq99, s.kos99, s.kosq99,
          s.doszg, s.koszg, s.dos96zg, s.kos96zg, s.dos99zg, s.kos99zg,
          a.tip, nvl(l.k041,'1')
   FROM  otcn_saldo s, otcn_acc a, customer cc, KL_K040 L
   WHERE a.acc=s.acc    and
         a.rnk=cc.rnk   and
         NVL(LPAD(TO_CHAR(CC.COUNTRY),3,'0'),'804')=L.K040(+);
---------------------------------------------------------------------------
CURSOR BaseL IS
    SELECT kodp, nbuc, SUM (znap)
    FROM rnbu_trace
    WHERE userid=userid_
    GROUP BY kodp,nbuc;
---------------------------------------------------------------------------
-------------------------------------------------------------------------------
procedure p_ins(p_dat_ date, p_tp_ varchar2, p_nls_ varchar2,p_nbs_ varchar2,
          p_kv_ smallint, p_k041_ varchar2, p_znap_ varchar2, p_acc_ number, p_nbuc_ varchar2) IS
                kod_ varchar2(10);

begin
   if length(trim(p_tp_))=1 then
      IF p_kv_=980 THEN
         kod_:='0' ;
      ELSE
         kod_:='1' ;
      END IF ;
   else
      kod_:= '';
   end if;

   kod_:= p_tp_ || kod_ || p_nbs_ || lpad(p_kv_,3,'0') || p_k041_ ;

   if length(trim(p_tp_)) > 1 then
      flag_ := f_is_est(p_nls_, p_kv_);
      IF flag_ = 1 AND mfo_ <> 315568 and mfou_ <> 300465 THEN
         kod_:= p_tp_ || p_nbs_ || '980' || p_k041_ ;
      END IF;
   end if;

   INSERT INTO rnbu_trace
            (nls, kv, odate, kodp, znap, acc, nbuc)
   VALUES  (p_nls_, p_kv_, p_dat_, kod_, p_znap_, p_acc_, p_nbuc_);
end;
-------------------------------------------------------------------------------
BEGIN
-------------------------------------------------------------------
commit;

EXECUTE IMMEDIATE 'ALTER SESSION ENABLE PARALLEL DML';
-------------------------------------------------------------------
logger.info ('P_F25_NN: Begin ');

userid_ := user_id;
EXECUTE IMMEDIATE 'TRUNCATE TABLE RNBU_TRACE';
-------------------------------------------------------------------
-- свой МФО
mfo_ := F_Ourmfo ();

-- МФО "родителя"
BEGIN
   SELECT mfou
     INTO mfou_
     FROM BANKS
    WHERE mfo = mfo_;
EXCEPTION
   WHEN NO_DATA_FOUND
   THEN
   mfou_ := mfo_;
END;

-- определение кода МФО или кода области для выбранного файла и схемы
p_proc_set(kodf_,sheme_,nbuc1_,typ_);

--- удаление информации из табл. otcn_acc, otcn_saldo
--- наполнение счетов (в том числе счетов тех.переоценки) и
--- их остатков (номиналы+эквиваленты)+обороты+корректирующие обороты
--- все эти действия выполняются в функции F_POP_OTCN

sql_acc_ := 'select r020 from kod_r020 where trim(prem)=''КБ'' and a010=''02''';
ret_ := f_pop_otcn(Dat_, 4, sql_acc_, null, 1);
----------------------------------------------------------------------------
OPEN Saldo;
   LOOP
   FETCH Saldo INTO rnk_, acc_, nls_, kv_, data_, Nbs_, Ostn_, Ostq_,
                    Dos_, Dosq_, Kos_, Kosq_,
                    Dos96p_, Dosq96p_, Kos96p_, Kosq96p_,
                    Dos96_, Dosq96_, Kos96_, Kosq96_,
                    Dos99_, Dosq99_, Kos99_, Kosq99_,
                    Doszg_, Koszg_, Dos96zg_, Kos96zg_,
                    Dos99zg_, Kos99zg_, tips_, k041_;
   EXIT WHEN Saldo%NOTFOUND;

   if typ_ > 0 then
      nbuc_ := nvl(f_codobl_tobo(acc_,typ_),nbuc1_);
   else
      nbuc_ := nbuc1_;
   end if;

--- обороты по перекрытию 6,7 классов на 5040,5041
   IF Doszg_ > 0 THEN
      p_ins(data_, '5', nls_, nbs_, kv_, k041_, TO_CHAR(Doszg_), acc_, nbuc_);
   END IF;

   IF Koszg_ > 0 THEN
      p_ins(data_, '6', nls_, nbs_, kv_, k041_, TO_CHAR(Koszg_), acc_, nbuc_);
   END IF;


--- корректирующие обороты за год по перекрытию 6,7 классов на 5040,5041
   IF Dos99zg_ > 0 THEN
      p_ins(data_, '9', nls_, nbs_, kv_, k041_, TO_CHAR(Dos99zg_), acc_, nbuc_);
   END IF;

   IF Kos99zg_ > 0 THEN
      p_ins(data_, '0', nls_, nbs_, kv_, k041_, TO_CHAR(Kos99zg_), acc_, nbuc_);
   END IF;

   -- добавив 15.01.2014
   --- обороты по перекрытию 6,7 классов на 5040,5041
   IF to_char(Dat_,'MM') = '12' and 
      (nls_ like '6%' or nls_ like '7%' or nls_ like '504%' or nls_ like '390%') THEN

         SELECT NVL(SUM(decode(dk,0,1,0)*s),0),
                    NVL(SUM(decode(dk,1,1,0)*s),0)
           INTO d_sum_, k_sum_
           FROM opldok 
          WHERE fdat  between Dat_  AND  Dat_+29
            AND acc  = acc_   
            AND (tt like 'ZG8%'  or tt like 'ZG9%');

         if Dos96_ >0 then 
            Dos96_ := Dos96_ - d_sum_;
         end if;
         if Kos96_ >0 then 
            Kos96_ := Kos96_ - k_sum_;
         end if;
   END IF;

   Ostn_ := Ostn_ - Dos96_ + Kos96_ - Dos99_ + Kos99_ - Dos96zg_ + Kos96zg_ - Dos99zg_ + Kos99zg_ - Doszg_ + Koszg_;

   -- згортання коригувань по відкоригованих коригуючих проводках
   if Ostn_ <> 0 and substr(nls_,1,1) in ('6','7') and Dos96zg_ +  Kos96zg_ > 0 
   then
      if Ostn_ < 0 then
         Kos96zg_ := Kos96zg_ + abs(Ostn_);
      end if;

      if Ostn_ > 0 then
         Dos96zg_ := Dos96zg_ + abs(Ostn_);
      end if;

      Ostn_ := 0;
   end if;

--- корректирующие обороты за месяц по перекрытию 6,7 классов на 5040,5041
   IF Dos96zg_ > 0 THEN
      p_ins(data_, '7', nls_, nbs_, kv_, k041_, TO_CHAR(Dos96zg_), acc_, nbuc_);
   END IF;

   IF Kos96zg_ > 0 THEN
      p_ins(data_, '8', nls_, nbs_, kv_, k041_, TO_CHAR(Kos96zg_), acc_, nbuc_);
   END IF;

   IF Ostn_ <> 0 THEN
      dk_ := IIF_N(Ostn_,0,'1','2','2');
      p_ins(data_, dk_, nls_, nbs_, kv_, k041_, TO_CHAR(ABS(Ostn_)), acc_, nbuc_);
   END IF;

   Ostq_ := Ostq_-Dosq96_+Kosq96_-Dosq99_+Kosq99_;

   IF Ostq_ <> 0 THEN
      dk_ := IIF_N(Ostq_,0,'1','2','2') || '0';
      p_ins(data_, dk_ , nls_, nbs_, kv_ , k041_, TO_CHAR(ABS(Ostq_)), acc_, nbuc_);
   END IF;

END LOOP;
CLOSE Saldo;
---------------------------------------------------
DELETE FROM tmp_nbu where kodf=kodf_ and datf=dat_;
---------------------------------------------------
kv1_ := 0;
dig_ := 100;

OPEN BaseL;
LOOP
   FETCH BaseL INTO  kodp_, nbuc_, znap_;
   EXIT WHEN BaseL%NOTFOUND;

   if substr(kodp_,7,3) = '980' or substr(kodp_,2,1) <> '1' then
      b_ := znap_;
   else
      IF kv1_ <> to_number(substr(kodp_,7,3)) THEN
         dig_ := f_ret_dig(to_number(substr(kodp_,7,3)));

         kv1_ := to_number(substr(kodp_,7,3));
      END IF;

      b_ := TO_CHAR(ROUND(TO_NUMBER(znap_)/dig_,0));
   end if;

   INSERT INTO tmp_nbu
      (kodf, datf, kodp,  znap, nbuc)
   VALUES
      (kodf_, Dat_, kodp_, b_, nbuc_);
END LOOP;
CLOSE BaseL;

logger.info ('P_F25_NN: End ');
------------------------------------------------------------------
END p_f25_NN;
/
show err;

PROMPT *** Create  grants  P_F25_NN ***
grant EXECUTE                                                                on P_F25_NN        to WR_ALL_RIGHTS;



PROMPT ===================================================================================== 
PROMPT *** End *** ========== Scripts /Sql/BARS/Procedure/P_F25_NN.sql =========*** End *** 
PROMPT ===================================================================================== 
