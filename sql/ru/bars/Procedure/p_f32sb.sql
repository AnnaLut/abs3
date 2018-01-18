

PROMPT ===================================================================================== 
PROMPT *** Run *** ========== Scripts /Sql/BARS/Procedure/P_F32SB.sql =========*** Run *** =
PROMPT ===================================================================================== 


PROMPT *** Create  procedure P_F32SB ***

  CREATE OR REPLACE PROCEDURE BARS.P_F32SB (Dat_ DATE, sheme_ VARCHAR2 DEFAULT 'C' )  IS
/*%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
% FILE NAME   :    otcn.sql
% DESCRIPTION :    Отчетность СберБанка: формирование файлов
% COPYRIGHT   :    Copyright UNITY-BARS Limited, 2001.  All Rights Reserved.
% VERSION     :    18/01/2018 (13/05/2017)
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
% 18.01.2018 - при выдборі бал.рахунків із SB_R020 додано перевірку на
%              дату закриття бал. рахунку (поле D_CLOSE)
% 08,02.2016 - вместо поля MFO из SPECPARAM_INT будем использовать поле
%              MFO из таблицы CUSTBANK
% 13.01.2016 - убрал мусор
% 13.01.2014 - исключаем проводки перекрытия корректирующих за декабрь
% 13.05.2011 - для Донецка(335106) будем формировать показатели если код
%              территории отличный от кода терр-рии обл-ти (RCUKRU kodt)
% 30.04.2011 - добавил acc,tobo в протокол
% 28.02.2011 - в поле комментарий вносим код TOBO и название счета
% 02.12.2009 - убрал во всех курсорах заполнение OB22 в таблице
%              SPECPARAM_INT
% 28.10.2009 - (23.02.2009,29.02.2008)
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%*/
kodf_    varchar2(2) := '32';
acc_     Number;
nbs_     Varchar2(4);
kv_      SMALLINT;
nls_     Varchar2(15);
s0000_   Varchar2(15);
s0009_   Varchar2(15);
data_    Date;
dat1_    Date;
dat2_    Date;
rnk_     Number;
Dose_    DECIMAL(24);
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
se_      DECIMAL(24);
Ostn_    DECIMAL(24);
Ostq_    DECIMAL(24);
zz_      Varchar2(2);
mfo_     Varchar2(12);
mfo_fa_  Varchar2(6);
sn_      DECIMAL(24);
dk_      Char(1);
kodp_    Varchar2(17);
znap_    Varchar2(30);
f33_     SMALLINT;
userid_  Number;
sql_acc_ varchar2(2000):='';
sql_doda_ varchar2(200):='';
ret_     number;
tobo_    accounts.tobo%TYPE;
nms_     accounts.nms%TYPE;
comm_    rnbu_trace.comm%TYPE;
kodt_    varchar2(6);
pr_      number;
typ_     Number;
nbuc1_   VARCHAR2(12);
nbuc_    VARCHAR2(12);
d_sum_   DECIMAL(24);
k_sum_   DECIMAL(24);

CURSOR Saldo IS
   SELECT s.rnk, s.acc, s.nls, s.kv, s.fdat, s.nbs, s.ost, s.ostq,
          s.dos, s.dosq, s.kos, s.kosq,
          s.dos96p, s.dosq96p, s.kos96p, s.kosq96p,
          s.dos96, s.dosq96, s.kos96, s.kosq96,
          s.dos99, s.dosq99, s.kos99, s.kosq99,
          s.doszg, s.koszg, s.dos96zg, s.kos96zg,
          a.tobo, a.nms, NVL(trim(a.ob22),'00'),
          nvl(trim(sp.mfo), nvl(trim(cb.mfo),'000000'))
    FROM  otcn_saldo s, accounts a, specparam_int sp, custbank cb
    WHERE s.acc = a.acc
      and a.rnk = cb.rnk(+)
      and s.acc = sp.acc(+);

BEGIN
-------------------------------------------------------------------
userid_ := user_id;
EXECUTE IMMEDIATE 'TRUNCATE TABLE RNBU_TRACE';
-------------------------------------------------------------------
Dat1_ := TRUNC(Dat_, 'MM');
Dat2_ := TRUNC(Dat_ + 28);

-- свой МФО
mfo_ := F_Ourmfo ();

select kodt
   into kodt_
from rcukru
where mfo = mfo_;

-- определение начальных параметров
P_Proc_Set_Int(kodf_, sheme_, nbuc1_, typ_);

-- используем классификатор SB_R020
sql_acc_ := 'select r020 from sb_r020 where f_33=''1'' and ' || 
            '(d_close is null or d_close > to_date('''||to_char(dat_, 'ddmmyyyy')||''',''ddmmyyyy'')) ';

ret_ := f_pop_otcn(Dat_, 3, sql_acc_);
-----------------------------------------------------------------------------------------
OPEN Saldo;
   LOOP
   FETCH Saldo INTO rnk_, acc_, nls_, kv_, data_, Nbs_, Ostn_, Ostq_,
                    Dos_, Dosq_, Kos_, Kosq_,
                    Dos96p_, Dosq96p_, Kos96p_, Kosq96p_,
                    Dos96_, Dosq96_, Kos96_, Kosq96_,
                    Dos99_, Dosq99_, Kos99_, Kosq99_,
                    Doszg_, Koszg_, Dos96zg_, Kos96zg_,
                    tobo_, nms_, zz_, mfo_fa_;
   EXIT WHEN Saldo%NOTFOUND;

   comm_ := '';

   IF typ_ > 0 THEN
      nbuc_ := NVL(F_Codobl_Tobo(acc_,typ_),nbuc1_);
   ELSE
      nbuc_ := nbuc1_;
   END IF;

   sn_ := 0;
   se_ := 0;

   -- добавив 13.01.2014
   --- обороты по перекрытию 6,7 классов на 5040,5041
   IF to_char(Dat_,'MM') = '12' and
      (nls_ like '6%' or nls_ like '7%' or nls_ like '504%' or nls_ like '390%')
   THEN
      SELECT NVL(SUM(decode(dk,0,1,0)*s),0),
             NVL(SUM(decode(dk,1,1,0)*s),0)
          INTO d_sum_, k_sum_
      FROM opldok
      WHERE fdat  between Dat_  AND Dat_+29 AND
            acc  = acc_   AND
            (tt like 'ZG8%'  or tt like 'ZG9%');

      Dos96_ := Dos96_-d_sum_;
      Kos96_ := Kos96_-k_sum_;
   END IF;

   if kv_ = 980 then
      se_ := Ostn_ - Dos96_ + Kos96_;
   else
      sn_ := Ostn_ - Dos96_ + Kos96_;
      se_ := Ostq_ - Dosq96_ + Kosq96_;
   end if;

   IF to_char(Dat_,'MM') = '12' and kv_ = 980 then
      BEGIN
         SELECT NVL(SUM(p.s*decode(p.dk,0,-1,1,1,0)),0)
            INTO Dose_
         FROM oper o, opldok p
         WHERE o.ref  = p.ref  AND
               p.fdat = dat_   AND
               o.sos  = 5      AND
               p.acc  = acc_   AND
               o.tt  like  'ZG%' ;
      EXCEPTION WHEN NO_DATA_FOUND THEN
         Dose_ := 0;
      END;
      se_ := se_ - Dose_;
   END IF;

   comm_ := substr(comm_ || tobo_ || '  ' || nms_, 1, 200);
   pr_ := 0;

   -- для Донецка будем формировать только для отделений с кодом территории отличной от обласной
   if mfo_ = 335106 then
      BEGIN
         select 1
            into pr_
         from rcukru
         where mfo = to_number(mfo_fa_)
           and glmfo = 300465
           and mfo != mfo_
           and kodt like trim(kodt_) || '%';
      EXCEPTION WHEN NO_DATA_FOUND THEN
         pr_ := 0;
      END;
   end if;

   IF pr_ = 0 and se_ <> 0 THEN
      dk_ := IIF_N(se_,0,'1','2','2');
      
      kodp_ := dk_ || '0' || nbs_ || zz_ || mfo_fa_ || lpad(kv_,3,'0');
      znap_ := TO_CHAR(ABS(se_)) ;
      
      INSERT INTO rnbu_trace (nls, kv, odate, kodp, znap, acc, comm, tobo, nbuc, rnk) VALUES
                             (nls_, kv_, data_, kodp_,znap_, acc_, comm_, tobo_, nbuc_, rnk_) ;
   END IF ;

   IF pr_ = 0 and sn_ <> 0 THEN
      dk_ := IIF_N(sn_,0,'1','2','2');
      
      kodp_ := dk_ || '1' || nbs_ || zz_ || mfo_fa_ || lpad(kv_,3,'0');
      znap_ := TO_CHAR(ABS(sn_)) ;
      
      INSERT INTO rnbu_trace (nls, kv, odate, kodp, znap, acc, comm, tobo, nbuc, rnk) VALUES
                             (nls_, kv_, data_, kodp_,znap_, acc_, comm_, tobo_, nbuc_, rnk_) ;
   END IF ;

END LOOP;
CLOSE SALDO;
---------------------------------------------------
DELETE FROM tmp_irep WHERE kodf = '32' AND datf = Dat_;
---------------------------------------------------
INSERT INTO tmp_irep (kodf, datf, kodp, znap, nbuc)
select '32', Dat_, kodp, SUM (znap), nbuc
FROM rnbu_trace
GROUP BY kodp, nbuc;
------------------------------------------------------------------
END p_f32sb;
/
show err;

PROMPT *** Create  grants  P_F32SB ***
grant EXECUTE                                                                on P_F32SB         to BARS_ACCESS_DEFROLE;
grant EXECUTE                                                                on P_F32SB         to RPBN002;
grant EXECUTE                                                                on P_F32SB         to WR_ALL_RIGHTS;



PROMPT ===================================================================================== 
PROMPT *** End *** ========== Scripts /Sql/BARS/Procedure/P_F32SB.sql =========*** End *** =
PROMPT ===================================================================================== 
