

PROMPT ===================================================================================== 
PROMPT *** Run *** ========== Scripts /Sql/BARS/Procedure/P_F81_NN.sql =========*** Run *** 
PROMPT ===================================================================================== 


PROMPT *** Create  procedure P_F81_NN ***

  CREATE OR REPLACE PROCEDURE BARS.P_F81_NN (Dat_ DATE,
                                      sheme_ varchar2 default 'G')  IS
/*%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
% DESCRIPTION :    Процедура формирование файла #81 для КБ
% COPYRIGHT   :    Copyright UNITY-BARS Limited, 1999.All Rights Reserved.
% VERSION     :   10/04/2018 (27/03/2018)
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
параметры: Dat_ - отчетная дата
           sheme_ - схема формирования
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
09.02.2016 - код группы стран (параметр K041) выбираем из истории 
             изменения параметра кода страны COUNTRY в CUSTOMERW
             (было сделано Вирко для Запорожья)
31.01.2016 - после перехода на новые DRAPSы 
             исключаем проводки перекрытия корректирующих за декабрь
01/04/2015 - из месячных корректирующих проводок (Dos96_, Kos96_)
             вычитаем корректирующие за год выполненные в январе
21.03.2014 - добавлен блок для наполнения корректирующих проводок
             прошлого и текущего отчетных месяцев по родительским счетам
             из дочерних (счета для ЦБ)
19.03.2014 - изменил условие для формирования файла в разрезе кодов
             территорий (только typ_ > 0)
06.02.2012 - в курсоре SALDO добавляются счета открытые после отчетной
             даты
02.02.2012 - изменено формирование показателей в связи с переоценкой в
             в Сбербанке материальных активов и добавлением годовых
             коректирующих проводок 3521,3621, 4 класс, 5100 и др.счетам
             перекрытие годовых коректирующих 3902(3903) на 5040(5041).
             Для всех бал.счетов кроме 5040,5041,6 и 7 кл. вычитаем
             годовые обороты перекрытия.
01.02.2012 - добавил формирование некоторых показателей как в файле #25
30.01.2012 - для остатка по счету вычитаем обороты перекрытия т.к.
             отчетная дата это послений рабочий день года
15.01.2012 - вместо функции F_POP_OTCN будем использовать F_POP_OTCN
             т.к. функция F_POP_OTCN испльзует накопление из SNAP таблицы
             в которой нет оборотов перекрытия 6,7 классов на 5040(5041)
08.02.2010 - вместо кл-ра KL_R020 будем использовать кл-р KOD_R020
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%*/
kodf_    varchar2(2):='81';
rnk_     number;
typ_      number;
acc_     Number;
pacc_    Number;
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
sk_      Number;
kodp_    Varchar2(10);
znap_    Varchar2(30);
comm_    Varchar2(300);
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
korr504_ number := 0;
add_     number := 0;
d_sum_   number;
k_sum_   number;
-------------------------------------------------------------------------------
CURSOR Saldo IS
   SELECT a.rnk, a.acc, a.nls, a.kv, s.fdat, a.nbs, s.ost, s.ostq,
          s.dos, s.dosq, s.kos, s.kosq,
          s.dos96p, s.dosq96p, s.kos96p, s.kosq96p,
          s.dos96, s.dosq96, s.kos96, s.kosq96,
          s.dos99, s.dosq99, s.kos99, s.kosq99,
          s.doszg, s.koszg, s.dos96zg, s.kos96zg, s.dos99zg, s.kos99zg,
          a.tip, nvl(l.k041,'1'),
          lag(s.acc, 1) over (partition by substr(s.nls,1,4),s.kv order by s.acc) pacc
   FROM  otcn_saldo s, otcn_acc a, customer cc, kl_k040 l
   WHERE a.acc=s.acc    and
         a.rnk=cc.rnk   and
         NVL(lpad(to_char(cc.country),3,'0'),'804')=l.k040(+)
   UNION
   SELECT s.rnk, s.acc, s.nls, s.kv, s.daos, s.nbs, 0, 0,
          0, 0, 0, 0,
          0, 0, 0, 0,
          0, 0, 0, 0,
          0, 0, 0, 0,
          0, 0, 0, 0, 0, 0,
          s.tip, nvl(l.k041,'1'),
          lag(s.acc, 1) over (partition by substr(s.nls,1,4),s.kv order by s.acc) pacc
   FROM   accounts s, customer cc, kl_k040 l, kod_r020 k
   WHERE  s.nbs=k.r020
     and  trim(k.prem)='КБ'
     and  k.a010 = '02'
     and  s.acc not in (select c.acc
                       from saldoa c
                       where c.fdat <= Dat_ )
     and  s.acc in (select acc from kor_prov)
     and  s.rnk = cc.rnk
     and  NVL(lpad(to_char(cc.country),3,'0'),'804')=l.k040(+);
---------------------------------------------------------------------------
CURSOR BaseL IS
    SELECT kodp, nbuc, SUM (znap)
    FROM rnbu_trace
    GROUP BY kodp,nbuc;
---------------------------------------------------------------------------
-------------------------------------------------------------------------------
procedure p_ins(p_dat_ date, p_tp_ varchar2, p_nls_ varchar2,p_nbs_ varchar2,
          p_kv_ smallint, p_k041_ varchar2, p_znap_ varchar2,
                p_comm_ varchar2 default '')
IS
   kod_ varchar2(10);

begin
   if length(trim(p_tp_)) = 1 then
      IF p_kv_=980 THEN
         kod_ := '0' ;
      ELSE
         kod_ := '1' ;
      END IF ;
   else
      kod_ := '';
   end if;

   kod_:= p_tp_ || kod_ || p_nbs_ || lpad(p_kv_,3,'0') || p_k041_ ;

   INSERT INTO rnbu_trace
            (nls, kv, odate, kodp, znap, nbuc, comm, acc, rnk)
   VALUES  (p_nls_, p_kv_, p_dat_, kod_, p_znap_, nbuc_, p_comm_, acc_, rnk_);
end;
-------------------------------------------------------------------------------
BEGIN
-------------------------------------------------------------------
userid_ := user_id;
EXECUTE IMMEDIATE 'TRUNCATE TABLE RNBU_TRACE';
-------------------------------------------------------------------
-- определение кода МФО или кода области для выбранного файла и схемы
p_proc_set(kodf_,sheme_,nbuc1_,typ_);

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
                    Dos99zg_, Kos99zg_, tips_, k041_, pacc_;
   EXIT WHEN Saldo%NOTFOUND;

   if typ_ > 0 then  
      nbuc_ := nvl(f_codobl_tobo(acc_,typ_),nbuc1_);
   else
      nbuc_ := nbuc1_;
   end if;

   --- после перехода на новые DRAPSы
   --- обороты по перекрытию 6,7 классов на 5040,5041
   IF to_char(Dat_,'MM')='12' and (nls_ like '6%' or nls_ like '7%' or nls_ like '390%' or nls_ like '504%') THEN
      if nls_ like '504%' or nls_ like '390%' then
         Dos96_ := 0;
         Kos96_ := 0; 
      else
         SELECT NVL(SUM(decode(o.dk,0,1,0)*o.s),0),
                    NVL(SUM(decode(o.dk,1,1,0)*o.s),0)
           INTO d_sum_, k_sum_
           FROM opldok o, oper p
          WHERE o.fdat = any(select fdat from fdat where fdat between Dat_  AND  Dat_+31)
            AND o.acc  = acc_
            AND (o.tt like 'ZG8%'  or o.tt like 'ZG9%')
            and o.ref = p.ref
            and p.sos = 5
            and p.vob = 96;
        
         if Dos96_ >0 then
            Dos96_ := Dos96_ - d_sum_;
         end if;

         if Kos96_ >0 then
            Kos96_ := Kos96_ - k_sum_;
         end if;
      end if;
   END IF;

   --- корректирующие обороты за год по перекрытию 6,7 классов на 5040,5041
   IF Dos99zg_ > 0 THEN
      p_ins(data_, '9', nls_, nbs_, kv_, k041_, TO_CHAR(Dos99zg_));
   END IF;

   IF Kos99zg_ > 0 THEN
      p_ins(data_, '0', nls_, nbs_, kv_, k041_, TO_CHAR(Kos99zg_));
   END IF;

   if nbs_ not in ('3902','3903','5040','5041') and nbs_ not like '6%' and nbs_ not like '7%' then
      Ostn_ := Ostn_-Dos96_+Kos96_-Dos99_+Kos99_;
   else
      if nbs_ not in ('5040','5041') then
         Ostn_ := Ostn_-Dos96_+Kos96_-Dos99_+Kos99_-Dos96zg_+Kos96zg_-Dos99zg_+Kos99zg_-Doszg_+Koszg_;
      end if;
      
      if nbs_ in ('5040','5041') then   
         Ostn_ := Ostn_-Dos99_+Kos99_-Dos96zg_+Kos96zg_-Dos99zg_+Kos99zg_-Doszg_+Koszg_;
      end if;   
   end if;

   -- згортання коригувань по в_дкоригованих коригуючих проводках
   if Ostn_ <> 0 and substr(nls_,1,1) in ('6','7') and Dos96zg_ +  Kos96zg_ > 0 then
      korr504_ := korr504_ + Ostn_;

      if Ostn_ < 0 then
         Kos96zg_ := Kos96zg_ + abs(Ostn_);
      end if;

      if Ostn_ > 0 then
         Dos96zg_ := Dos96zg_ + abs(Ostn_);
      end if;

      Ostn_ := 0;
   end if;

   IF Ostn_ <> 0 THEN
      dk_ := IIF_N(Ostn_,0,'1','2','2');
      p_ins(data_, dk_, nls_, nbs_, kv_, k041_, TO_CHAR(ABS(Ostn_)));
   END IF;

   Ostq_:=Ostq_-Dosq96_+Kosq96_-Dosq99_+Kosq99_;

   IF Ostq_ <> 0 THEN
      dk_ := IIF_N(Ostq_,0,'1','2','2')||'0';
      Ostq_ := Abs(Ostq_);
      p_ins(data_, dk_ , nls_, nbs_, kv_ , k041_, TO_CHAR(ABS(Ostq_)), comm_);
   END IF;

END LOOP;
CLOSE Saldo;
-------------------------------------------------------
DELETE FROM tmp_nbu where kodf = kodf_ and datf = dat_;
-------------------------------------------------------
kv1_:=0;
dig_:=100;

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
------------------------------------------------------------------
END p_f81_NN;
/
show err;

PROMPT *** Create  grants  P_F81_NN ***
grant EXECUTE                                                                on P_F81_NN        to BARS_ACCESS_DEFROLE;



PROMPT ===================================================================================== 
PROMPT *** End *** ========== Scripts /Sql/BARS/Procedure/P_F81_NN.sql =========*** End *** 
PROMPT ===================================================================================== 
