

PROMPT ===================================================================================== 
PROMPT *** Run *** ========== Scripts /Sql/BARS/Procedure/P_F28SB.sql =========*** Run *** =
PROMPT ===================================================================================== 


PROMPT *** Create  procedure P_F28SB ***

  CREATE OR REPLACE PROCEDURE BARS.P_F28SB (Dat_ DATE, sheme_ VARCHAR2 DEFAULT 'C' )  IS
/*%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
% FILE NAME   : otcn.sql
% DESCRIPTION : ќтчетность ЌЅ”: формирование файлов
% COPYRIGHT   : Copyright UNITY-BARS Limited, 2001.  All Rights Reserved.
% VERSION     : 19/01/2018 (18/01/2018, 13/11/2017) 
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
19.01.2018 - параметр OB22 будем выбирать из ACCOUNTS вместо SPECPARAM_INT
             (не изменил в предыдущей версии)
18.01.2018 - при выдбор≥ бал.рахунк≥в ≥з SB_R020 додано перев≥рку на
             дату закритт€ бал. рахунку (поле D_CLOSE)
             параметр OB22 будем выбирать из ACCOUNTS вместо SPECPARAM_INT
13.11.2017 - удалил ненужные строки и изменил некоторые блоки формировани€ 
16.02.2016 - дл€ декабр€ мес€ца будут включатьс€ годовые корректирующие
             обороты
26.05.2012 - формируем в разрезе кодов территорий
10.08.2011 - исправление ошибки
09.08.2011 - помен€ла f_pop_otcn на f_pop_otcn_snp 
30.04.2011 - добавил†acc,tobo в протокол
28.02.2011 - в поле комментарий вносим код TOBO и название счета
06.05.2010 - отключил блок заполнени€ спецпараметра OB22 
08.11.2007 - “.к. дл€ счетов начисленных процентов 2628,2638 выполн€ютс€ 
             корректирующие проводки, то выполн€ем корректирову остатка
             и при нулевом значении на конец мес€ца  
             (в предыдущей версии кор.проводки добавл€лись только при
              ненулевом остатке на счете)
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%*/
kodf_    varchar2(2):='28';
acc_     Number;
acc1_    Number;
acc2_    Number;
nbs_     Varchar2(4);
kv_      SMALLINT;
nls_     Varchar2(15);
rnk_     Number;
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
s0000_   Varchar2(15);
s0009_   Varchar2(15);
data_    Date;
dat1_    Date;
dat2_    Date;
zz_      Varchar2(2);
sn_      DECIMAL(24);
dk_      Char(1);
kk_      Varchar2(9);
kodp_    Varchar2(11);
znap_    Varchar2(30);
f28_     SMALLINT;
f28k_    Number;
userid_  Number;
sql_acc_ varchar2(2000):='';
sql_doda_ varchar2(200):='';
ret_	 number;
tobo_    accounts.tobo%TYPE;
nms_     accounts.nms%TYPE;
comm_    rnbu_trace.comm%TYPE;
typ_     Number; 
nbuc1_   VARCHAR2(12);
nbuc_    VARCHAR2(12);
d_sum_   number;
k_sum_   number;

CURSOR Saldo IS
   SELECT s.rnk, s.acc, s.nls, s.kv, s.fdat, s.nbs, s.ost, s.ostq,
          s.dos, s.dosq, s.kos, s.kosq,
          s.dos96p, s.dosq96p, s.kos96p, s.kosq96p,
          s.dos96, s.dosq96, s.kos96, s.kosq96,
          s.dos99, s.dosq99, s.kos99, s.kosq99,
          s.doszg, s.koszg, s.dos96zg, s.kos96zg,
          a.tobo, a.nms, NVL(trim(a.ob22),'00')  
    FROM  otcn_saldo s, otcn_acc a
    WHERE s.acc = a.acc;
-----------------------------------------------------------------------
BEGIN

-------------------------------------------------------------------
userid_ := user_id;
EXECUTE IMMEDIATE 'TRUNCATE TABLE RNBU_TRACE';
-------------------------------------------------------------------
Dat1_ := TRUNC(Dat_, 'MM');
Dat2_ := TRUNC(Dat_ + 28);

-- определение начальных параметров
P_Proc_Set_Int(kodf_,sheme_,nbuc1_,typ_);

-- используем классификатор SB_R020 
sql_acc_ := 'select r020 from sb_r020 where f_28=''1''  and ' || 
            '(d_close is null or d_close > to_date('''||to_char(dat_, 'ddmmyyyy')||''',''ddmmyyyy'')) ';

logger.info ('P_F28SB: Begin ');

if to_char(Dat_,'MM') = '12' then
   ret_ := f_pop_otcn(Dat_, 4, sql_acc_, null, 1);
else
   ret_ := f_pop_otcn(Dat_, 3, sql_acc_);
end if;
----------------------------------------------------------------------------
OPEN Saldo;
   LOOP
   FETCH Saldo INTO rnk_, acc_, nls_, kv_, data_, Nbs_, Ostn_, Ostq_,
                    Dos_, Dosq_, Kos_, Kosq_,
                    Dos96p_, Dosq96p_, Kos96p_, Kosq96p_,
                    Dos96_, Dosq96_, Kos96_, Kosq96_,
                    Dos99_, Dosq99_, Kos99_, Kosq99_,
                    Doszg_, Koszg_, Dos96zg_, Kos96zg_, 
                    tobo_, nms_, zz_;
   EXIT WHEN Saldo%NOTFOUND;

   comm_ := '';

   IF typ_ > 0 
   THEN
      nbuc_ := NVL(F_Codobl_Tobo(acc_,typ_),nbuc1_);
   ELSE
      nbuc_ := nbuc1_;
   END IF;

   sn_ := 0;
   se_ := 0;

   -- добавив 16.02.2016
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

      IF Dos96_ <> 0 
      then 
         Dos96_ := Dos96_ - d_sum_;
      END IF;
      IF Kos96_ <> 0 THEN
         Kos96_ := Kos96_ - k_sum_;
      END IF;
   END IF;

   if nbs_ not in ('3902','3903','5040','5041') and nbs_ not like '6%' and nbs_ not like '7%' 
   then
      Ostn_ := Ostn_-Dos96_+Kos96_-Dos99_+Kos99_;
   else
      Ostn_ := Ostn_-Dos96_+Kos96_-Dos99_+Kos99_-Dos96zg_+Kos96zg_-Dos99zg_+Kos99zg_-Doszg_+Koszg_;
   end if;

   Ostq_ := Ostq_ - Dosq96_ + Kosq96_ - Dosq99_ + Kosq99_;

   if kv_ = 980 
   then
      se_ := Ostn_;
   else
      sn_ := Ostn_;
      se_ := Ostq_;
   end if;

   comm_ := substr(comm_ || tobo_ || '  ' || nms_, 1, 200);

   IF se_ <> 0 
   THEN 
      dk_ := IIF_N(se_,0,'1','2','2') ;
      kk_ := nbs_ || zz_ || LPAD(to_char(kv_),3,'0') ;
      kodp_ := dk_ || '0' || kk_ ;
      znap_ := TO_CHAR(ABS(se_)) ;
      INSERT INTO rnbu_trace (nls, kv, odate, kodp, znap, acc, comm, tobo, nbuc) VALUES
                             (nls_, kv_, data_, kodp_,znap_, acc_, comm_, tobo_, nbuc_) ;
   END IF;

   IF sn_ <> 0 
   THEN 
      dk_ := IIF_N(sn_,0,'1','2','2') ;
      kk_ := nbs_ || zz_ || LPAD(to_char(kv_),3,'0') ;
      kodp_ := dk_ || '1' || kk_ ;
      znap_ := TO_CHAR(ABS(sn_)) ;
      INSERT INTO rnbu_trace (nls, kv, odate, kodp, znap, acc, comm, tobo, nbuc) VALUES
                             (nls_, kv_, data_, kodp_,znap_, acc_, comm_, tobo_, nbuc_) ;
   END IF;

END LOOP;
CLOSE Saldo;
---------------------------------------------------
DELETE FROM tmp_irep WHERE kodf = kodf_ AND datf = Dat_;
---------------------------------------------------
INSERT INTO tmp_irep (kodf, datf, kodp, znap, nbuc)
select '28', Dat_, KODP, SUM(znap), nbuc
from  RNBU_TRACE   
GROUP BY kodp, nbuc;

logger.info ('P_F28SB: End ');

exception
    when others then 
        logger.info ('P_F28SB: Error '||sqlerrm);
------------------------------------------------------------------
END p_f28sb;
/
show err;

PROMPT *** Create  grants  P_F28SB ***
grant EXECUTE                                                                on P_F28SB         to BARS_ACCESS_DEFROLE;
grant EXECUTE                                                                on P_F28SB         to RPBN002;
grant EXECUTE                                                                on P_F28SB         to WR_ALL_RIGHTS;



PROMPT ===================================================================================== 
PROMPT *** End *** ========== Scripts /Sql/BARS/Procedure/P_F28SB.sql =========*** End *** =
PROMPT ===================================================================================== 
