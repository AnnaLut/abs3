

PROMPT ===================================================================================== 
PROMPT *** Run *** ========== Scripts /Sql/BARS/Procedure/P_F22SB.sql =========*** Run *** =
PROMPT ===================================================================================== 


PROMPT *** Create  procedure P_F22SB ***

  CREATE OR REPLACE PROCEDURE BARS.P_F22SB (Dat_ DATE, sheme_ VARCHAR2 DEFAULT 'C')  IS
/*%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
% DESCRIPTION :	Процедура формирование файла @22 для Сбербанк
% COPYRIGHT   :	Copyright UNITY-BARS Limited, 2009.All Rights Reserved.
% VERSION     : 18/01/2018 (17/02/2016, 13/01/2016)
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
параметры: Dat_ - отчетная дата
           sheme_ - схема формирования
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
18.01.2018 при выдборі бал.рахунків із SB_R020 додано перевірку на
           дату закриття бал. рахунку (поле D_CLOSE)
           параметр OB22 будем выбирать из ACCOUNTS вместо SPECPARAM_INT
17/02/2016 для декабря месяца будут включаться годовые корректирующие
           обороты
13/01/2016 убрал мусор
           исключаем проводки перекрытия корректирующих за декабрь
03/07/2014 внес изменения выполненные для Донецка т.к. версия в эталоне
           не соответствовала последним изменениям выполненным для Сумм
13/09/2013 заменил over (partition by sign(s.ost), на
           over (partition by sign(s.ost-s.dos96+s.kos96),
           т.к. сумма коректировки (9900,9910) из поля SKOR табл.
           OTCN_ARCH_PEREOC формировалась по нескольким счетам
05/09/2013 для 9900, 9910 коректируем остатки из OTCN_ARCH_PEREOC только
           если сумма меньше 100 (проявилось в РУ Полтавы)
05/06/2013 поправила копійки для 9910
13/09/2012 формируем в разрезе кодов территорий
05/09/2012 перенос по OTCN_ARCH_PEREOC (доработка)
04/02/2012 добавлены годовые корректирующие проводки
06/12/2011 доработки по переносу переоценки из 02 файла
04/11/2011 исправление ошибки
05.10.2011 перенос по OTCN_ARCH_PEREOC
27.09.2011 поменял f_pop_otcn_snp на f_pop_otcn т.к. f_pop_otcn вызывает
           f_pop_otcn_snp
10/08/2011 поменяла f_pop_otcn на f_pop_otcn_snp
30.04.2011 добавил acc,tobo в протокол
01.03.2011 в поле комментарий вносим код TOBO и название счета
10.07.2009 убрал ORDER BY для табл. RNBU_TRACE
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%*/
kodf_    varchar2(2):='22';
rnk_     number;
typ_ 	 number;
acc_     Number;
dat1_    Date;
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
kodp_    Varchar2(12);
znap_    Varchar2(30);
Kv_      SMALLINT;
Nbs_     Varchar2(4);
nls_     Varchar2(15);
data_    Date;
dk_      varchar2(2);
userid_  Number;
sql_acc_ varchar2(2000):='';
sql_doda_ varchar2(200):='';
ff_      number;
ret_	 number;
pr_      NUMBER;
ob22_    Varchar2(2);
tobo_    accounts.tobo%TYPE;
nms_     accounts.nms%TYPE;
comm_    rnbu_trace.comm%TYPE;
mfo_     number;
chet_    number := 0;
k041_    varchar2(1);
add_     number;
pacc_    number;
nbuc1_   VARCHAR2(12);
nbuc_    VARCHAR2(12);
d_sum_   number;
k_sum_   number;
-------------------------------------------------------------------------------
CURSOR Saldo IS
   SELECT s.rnk, s.acc, s.nls, s.kv, s.fdat, s.nbs, s.ost, s.ostq,
          s.dos, s.dosq, s.kos, s.kosq,
          s.dos96p, s.dosq96p, s.kos96p, s.kosq96p,
          s.dos96, s.dosq96, s.kos96, s.kosq96,
          s.dos99, s.dosq99, s.kos99, s.kosq99,
          s.doszg, s.koszg, s.dos96zg, s.kos96zg,
          a.tobo, a.nms, NVL(trim(a.ob22),'00'),
          substr(F_K041 (c.country),1,1) K041,
          lag(s.acc, 1) over (partition by sign(s.ost-s.dos96+s.kos96), substr(s.nls,1,4),s.kv, substr(F_K041 (c.country),1,1) order by s.acc) pacc
    FROM  otcn_saldo s, otcn_acc a, customer c
    WHERE s.acc = a.acc
      and s.rnk = c.rnk
      and (s.ost - s.dos96 + s.kos96 - s.dos99 + s.kos99 <> 0 or
           s.ostq - s.dosq96 + s.kosq96 - s.dosq99 + kosq99 <> 0);
-------------------------------------------------------------------------------
procedure p_ins(p_dat_ date, p_tp_ varchar2, p_acc_ number, p_nls_ varchar2,
                p_nbs_ varchar2, p_ob22_ varchar2, p_kv_ smallint,
  		p_znap_ varchar2, p_comm_ varchar2, p_tobo_ varchar2, p_nbuc_ varchar2) IS
                kod_ varchar2(7);

begin
   kod_:= p_tp_ || p_nbs_ || p_ob22_ ;

   INSERT INTO rnbu_trace
            (nls, kv, odate, kodp, znap, acc, comm, tobo, nbuc)
   VALUES  (p_nls_, p_kv_, p_dat_, kod_, p_znap_, p_acc_, p_comm_, p_tobo_, p_nbuc_);
end;
-------------------------------------------------------------------------------
BEGIN
-------------------------------------------------------------------
commit;

EXECUTE IMMEDIATE 'ALTER SESSION ENABLE PARALLEL DML';
-------------------------------------------------------------------
logger.info ('P_F22SB: Begin ');
-------------------------------------------------------------------
userid_ := user_id;

mfo_:=F_OURMFO();

EXECUTE IMMEDIATE 'TRUNCATE TABLE RNBU_TRACE';
-------------------------------------------------------------------
-- используем классификатор SB_R020
sql_acc_ := 'select r020 from sb_r020 where f_22=''1'' and ' || 
            '(d_close is null or d_close > to_date('''||to_char(dat_, 'ddmmyyyy')||''',''ddmmyyyy'')) ';

if to_char(Dat_,'MM') = '12' then
   ret_ := f_pop_otcn(Dat_, 4, sql_acc_, null, 1);
else
   ret_ := f_pop_otcn(Dat_, 3, sql_acc_);
end if;

Dat1_ := TRUNC(Dat_,'MM'); -- початок попереднього м_сяця

-- определение начальных параметров
P_Proc_Set_Int(kodf_,sheme_,nbuc1_,typ_);
----------------------------------------------------------------------------
OPEN Saldo;
   LOOP
   FETCH Saldo INTO rnk_, acc_, nls_, kv_, data_, Nbs_, Ostn_, Ostq_,
                    Dos_, Dosq_, Kos_, Kosq_,
                    Dos96p_, Dosq96p_, Kos96p_, Kosq96p_,
                    Dos96_, Dosq96_, Kos96_, Kosq96_,
                    Dos99_, Dosq99_, Kos99_, Kosq99_,
                    Doszg_, Koszg_, Dos96zg_, Kos96zg_,
                    tobo_, nms_, ob22_, k041_, pacc_;
   EXIT WHEN Saldo%NOTFOUND;

   IF typ_ > 0 THEN
      nbuc_ := NVL(F_Codobl_Tobo(acc_,typ_),nbuc1_);
   ELSE
      nbuc_ := nbuc1_;
   END IF;

   comm_ := '';

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

      IF Dos96_ <> 0 then
         Dos96_ := Dos96_ - d_sum_;
      END IF;
      IF Kos96_ <> 0 THEN
         Kos96_ := Kos96_ - k_sum_;
      END IF;
   END IF;

   if nbs_ not in ('3902','3903','5040','5041') and nbs_ not like '6%' and nbs_ not like '7%' then
      Ostn_ := Ostn_-Dos96_+Kos96_-Dos99_+Kos99_;
   else
      Ostn_ := Ostn_-Dos96_+Kos96_-Dos99_+Kos99_-Dos96zg_+Kos96zg_-Dos99zg_+Kos99zg_-Doszg_+Koszg_;
   end if;

   Ostq_ := Ostq_ - Dosq96_ + Kosq96_ - Dosq99_ + Kosq99_;

   if kv_ = 980 then
      se_ := Ostn_;
   else
      se_ := Ostq_;
   end if;

   IF se_ <> 0 THEN
      comm_ := substr(comm_ || tobo_ || '  ' || nms_, 1, 200);
      dk_ := IIF_N(se_,0,'1','2','2');
      se_ := ABS(se_);
      p_ins(data_, dk_, acc_, nls_, nbs_, ob22_, kv_, TO_CHAR(se_), comm_, tobo_, nbuc_);
   END IF;

END LOOP;
CLOSE Saldo;
---------------------------------------------------------------------------
---------------------------------------------------
DELETE FROM tmp_irep where kodf = kodf_ and datf = dat_;
---------------------------------------------------
INSERT INTO tmp_irep (kodf, datf, kodp, nbuc, znap)
select kodf_, Dat_, KODP, nbuc, SUM(znap)
from  RNBU_TRACE
GROUP BY kodp, nbuc
having SUM (znap) <> 0 ;
commit;

-------------------------------------------------------------------
logger.info ('P_F22SB: End ');

------------------------------------------------------------------
END p_f22sb;
/
show err;

PROMPT *** Create  grants  P_F22SB ***
grant EXECUTE                                                                on P_F22SB         to BARS_ACCESS_DEFROLE;
grant EXECUTE                                                                on P_F22SB         to RPBN002;
grant EXECUTE                                                                on P_F22SB         to WR_ALL_RIGHTS;



PROMPT ===================================================================================== 
PROMPT *** End *** ========== Scripts /Sql/BARS/Procedure/P_F22SB.sql =========*** End *** =
PROMPT ===================================================================================== 
