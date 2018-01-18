

PROMPT ===================================================================================== 
PROMPT *** Run *** ========== Scripts /Sql/BARS/Procedure/P_F67SB.sql =========*** Run *** =
PROMPT ===================================================================================== 


PROMPT *** Create  procedure P_F67SB ***

  CREATE OR REPLACE PROCEDURE BARS.P_F67SB (Dat_ DATE,
                                          tp_ in number default 0,
                                          sheme_ VARCHAR2 DEFAULT 'C')  
IS
/*%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
% FILE NAME   : otcn.sql
% DESCRIPTION : ќтчетность —берЅанка: формирование файлов
% COPYRIGHT   : Copyright UNITY-BARS Limited, 2001.  All Rights Reserved.
% VERSION     : 18/01/2018 (13/11/2017)
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
% 18.01.2018 - при выдбор≥ бал.рахунк≥в ≥з SB_R020 додано перев≥рку на
%              дату закритт€ бал. рахунку (поле D_CLOSE)
%              параметр OB22 будем выбирать из ACCOUNTS вместо SPECPARAM_INT
% 13/11/2017 - удалил ненужные строки и изменил некоторые блоки формировани€ 
% 16/02/2016 - дл€ декабр€ мес€ца будут включатьс€ годовые корректирующие
%              обороты
% 12/01/2016 - вычитаем корректирующие обороты по перекрытию 6,7 классов 
%              на 5040,5041
% 26/01/2012 - добавила еще один параметр вызова, т.к. файл используетс€
% дл€ ежедневной сверки @67 и @87, то там не подходит формирование по мес€чным
% оборотам и нужно формировать по-старому (по SALDO). ƒл€ этого tp_ = 1
% 15/01/2012 - формирование файла будет выполн€тьс€ по SNAP таблице
% 30/04/2011 - добавил†tobo в протокол
% 19/04/2011 - добавила в протокол асс счета
% 01/03/2011 - в поле комментарий вносим код TOBO и название счета
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%*/
kodf_    varchar2(2) := '67';
nbs_     Varchar2(4);
kv_      SMALLINT;
acc_     Number;
acc1_    Number;
acc2_    Number;
nls_     Varchar2(15);
s0000_   Varchar2(15);
s0009_   Varchar2(15);
Ostn_    DECIMAL(24);
Ostq_    DECIMAL(24);
Dos96_   DECIMAL(24);
Kos96_   DECIMAL(24);
Dosq96_  DECIMAL(24);
Kosq96_  DECIMAL(24);
Dos99_   DECIMAL(24);
Kos99_   DECIMAL(24);
Dosq99_  DECIMAL(24);
Kosq99_  DECIMAL(24);
data_    Date;
dat1_    Date;
dat2_    Date;
Dosnk_   DECIMAL(24);
Dosek_   DECIMAL(24);
Kosnk_   DECIMAL(24);
Kosek_   DECIMAL(24);
zz_      Varchar2(2);
sn_      DECIMAL(24);
se_      DECIMAL(24);
dk_      Char(1);
kodp_    Varchar2(10);
znap_    Varchar2(30);
f67_     SMALLINT;
f67k_    Number;
userid_  Number;
sql_acc_ varchar2(2000):='';
sql_doda_ varchar2(200):='';
ret_     number;
tobo_    accounts.tobo%TYPE;
nms_     accounts.nms%TYPE;
comm_    rnbu_trace.comm%TYPE;
typ_     Number; 
nbuc1_   VARCHAR2(12);
nbuc_    VARCHAR2(12);
d_sum_   DECIMAL(24);
k_sum_   DECIMAL(24);

--ќстатки номиналы (грн.+валюта)
CURSOR SALDO IS
   SELECT a.acc, a.nls, a.kv, a.nbs, s.fdat, NVL(trim(a.ob22),'00'),
          s.ost, s.ostq, s.dos96, s.kos96, s.dosq96, s.kosq96, 
          s.dos99, s.kos99, s.dosq99, s.kosq99, a.tobo, a.nms
   FROM  otcn_saldo s, otcn_acc a
   WHERE s.acc=a.acc;
-----------------------------------------------------------------------
BEGIN
-------------------------------------------------------------------
userid_ := user_id;
EXECUTE IMMEDIATE 'TRUNCATE TABLE RNBU_TRACE';
-------------------------------------------------------------------
Dat1_ := TRUNC(Dat_,'MM'); -- початок звiтного мiс€ц€
Dat2_ := TRUNC(Dat_ + 28);

-- определение начальных параметров
P_Proc_Set_Int(kodf_, sheme_, nbuc1_, typ_);
---------------------  орректирующие проводки ---------------------
-- используем классификатор SB_R020
sql_acc_ := 'select r020 from sb_r020 where f_67=''1'' and ' || 
            '(d_close is null or d_close > to_date('''||to_char(dat_, 'ddmmyyyy')||''',''ddmmyyyy'')) ';

-- если процедура вызываетс€ из отчетности, то формируем по данным из SNAP
if tp_ = 0 then
   if to_char(Dat_,'MM') = '12' then
      ret_ := f_pop_otcn(Dat_, 4, sql_acc_, null, 1);
   else
      ret_ := f_pop_otcn(Dat_, 2, sql_acc_);
   end if;
else -- иначе - это печатный отчет дл€ ежедевной сверки @67 и @87,
     -- поэтому формирует по-старому (по SALDO)
   ret_ := f_pop_otcn_old(Dat_, 2, sql_acc_);
end if;
-------------------------------------------------------------------
OPEN SALDO;
   LOOP
      FETCH SALDO INTO acc_, nls_, kv_, nbs_, data_, zz_, Ostn_, Ostq_,
                       Dos96_, Kos96_, Dosq96_, Kosq96_, 
                       Dos99_, Kos99_, Dosq99_, Kosq99_,
                       tobo_, nms_;
      EXIT WHEN SALDO%NOTFOUND;

      comm_ := '';
      comm_ := substr(comm_ || tobo_ || '  ' || nms_, 1, 200);

      IF typ_ > 0 
      THEN
         nbuc_ := NVL(F_Codobl_Tobo(acc_,typ_),nbuc1_);
      ELSE
         nbuc_ := nbuc1_;
      END IF;

      --- обороты по перекрытию 6,7 классов на 5040,5041
      IF to_char(Dat_,'MM')='12' and 
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

      if nbs_ in ('5040','5041') 
      then
         Ostn_ := Ostn_-Dos96_+Kos96_;
      end if;

      if nbs_ not in ('5040','5041') 
      then
         Ostn_ := Ostn_ - Dos96_ + Kos96_ - Dos99_ + Kos99_;
      end if;

      Ostq_ := Ostq_ - Dosq96_ + Kosq96_ - Dosq99_ + Kosq99_;

      IF kv_ <> 980 
      THEN
         se_ := Ostq_;
      ELSE
         se_ := Ostn_;
      END IF;

      IF se_ <> 0 
      THEN
         dk_ := IIF_N(se_,0,'1','2','2');
         kodp_ := dk_ || nbs_ || zz_ ;
         znap_ := TO_CHAR(ABS(se_)) ;
         INSERT INTO rnbu_trace (nls, kv, odate, kodp, znap, acc, comm, tobo, nbuc) VALUES
                                (nls_, kv_, data_, kodp_,znap_, acc_, comm_, tobo_, nbuc_) ;
      END IF;

   END LOOP;
CLOSE SALDO;
---------------------------------------------------------------------
---------------------------------------------------
DELETE FROM tmp_irep WHERE kodf = '67' AND datf = Dat_;
---------------------------------------------------
INSERT INTO tmp_irep (kodf, datf, kodp, znap, nbuc)
select '67', Dat_, kodp, SUM (znap), nbuc
FROM rnbu_trace
GROUP BY kodp, nbuc;

commit;
------------------------------------------------------------------
END p_f67sb;
/
show err;

PROMPT *** Create  grants  P_F67SB ***
grant EXECUTE                                                                on P_F67SB         to BARS_ACCESS_DEFROLE;
grant EXECUTE                                                                on P_F67SB         to NALOG;
grant EXECUTE                                                                on P_F67SB         to RPBN001;
grant EXECUTE                                                                on P_F67SB         to RPBN002;
grant EXECUTE                                                                on P_F67SB         to WR_ALL_RIGHTS;



PROMPT ===================================================================================== 
PROMPT *** End *** ========== Scripts /Sql/BARS/Procedure/P_F67SB.sql =========*** End *** =
PROMPT ===================================================================================== 
