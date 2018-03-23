

PROMPT ===================================================================================== 
PROMPT *** Run *** ========== Scripts /Sql/BARS/Procedure/P_F27SB.sql =========*** Run *** =
PROMPT ===================================================================================== 


PROMPT *** Create  procedure P_F27SB ***

CREATE OR REPLACE PROCEDURE BARS.P_F27SB (Dat_ DATE, sheme_ VARCHAR2 DEFAULT 'C')  IS
/*%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
% DESCRIPTION :	ѕроцедура формирование файла @27 дл€  Ѕ
% COPYRIGHT   :	Copyright UNITY-BARS Limited, 2009.All Rights Reserved.
% VERSION     :07/02/2018 (23/01/2018)
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
параметры: Dat_ - отчетна€ дата
           sheme_ - схема формировани€
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
23.01.2018 - в курсоре SALDO изменены услови€ дл€ отбора (аналогично как
             дл€ файла #02)
19.01.2018 - в курсоре SALDO вместо union all оставил только   union
             (не включались все бал.счета)
18.01.2018 - при выдбор≥ бал.рахунк≥в ≥з SB_R020 додано перев≥рку на
             дату закритт€ бал. рахунку (поле D_CLOSE)
             параметр OB22 будем выбирать из ACCOUNTS вместо SPECPARAM_INT
05.12.2017 - добавлен блок дл€ формировани€ виртуальных оборотов дл€ бал.
             счетов перехода на новый план счетов
13.11.2017 - удалил ненужные строки и изменил некоторые блоки формировани€
18.02.2016 - дл€ файла за последний рабочий день года
             из оборотов за мес€ц коды 50,51,60,61 не будут вычитатьс€
             годовые корретирующие обороты
17.02.2016 - дл€ декабр€ мес€ца будут включатьс€ годовые корректирующие
             обороты
08.02.2016 изменени€ дл€ успешного формировани€ кодов показателей 50, 51,
           60, 61, 90, 91, 00, 01
26.05.2012 формируем в разрезе кодов территорий
07.09.2011 помен€ла f_pop_otcn на f_pop_otcn_snp
30.04.2011 добавил†acc,tobo в протокол
01.03.2011 в поле комментарий вносим код TOBO и название счета
10.07.2009 убрал ORDER BY дл€ табл. RNBU_TRACE
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%*/
kodf_    varchar2(2):='27';
rnk_     number;
typ_ 	 number;
acc_     Number;
dat1_    Date;
--dat2_    Date;
--datn_    date;
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
kodp_    Varchar2(12);
znap_    Varchar2(30);
Kv_      SMALLINT;
Kv1_     SMALLINT;
--Vob_     SMALLINT;
Nbs_     Varchar2(4);
nls_     Varchar2(15);
mfo_     number;
mfou_    NUMBER;
data_    Date;
k041_    Char(1);
dk_      varchar2(2);
--nbu_     SMALLINT;
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
ret_	 number;
pr_      NUMBER;
ob22_    Varchar2(2);
tobo_    accounts.tobo%TYPE;
nms_     accounts.nms%TYPE;
comm_    rnbu_trace.comm%TYPE;
sk_      number;
d_sum_   number;
k_sum_   number;
d_kor_   number;
k_kor_   number;
-------------------------------------------------------------------------------
CURSOR Saldo IS
   SELECT s.rnk, s.acc, s.nls, s.kv, s.fdat, s.nbs,
          s.ost, s.ostq,
          s.dos, s.dosq,
          s.kos, s.kosq,
          s.dos96p, s.dosq96p,
          s.kos96p, s.kosq96p,
          s.dos96, s.dosq96, s.kos96, s.kosq96,
          s.dos99, s.dosq99, s.kos99, s.kosq99,
          s.doszg, s.koszg, s.dos96zg, s.kos96zg,
          nvl(l.k041,'1'), a.tobo, a.nms, NVL(trim(a.ob22),'00')
   FROM  otcn_saldo s, otcn_acc a, customer cc, kl_k040 l
   WHERE s.acc=a.acc
     and s.rnk=cc.rnk
     and NVL(lpad(to_char(cc.country),3,'0'),'804')=l.k040(+);
-------------------------------------------------------------------------------
procedure p_ins(p_dat_ date, p_tp_ varchar2, p_acc_ number, p_nls_ varchar2,
                p_nbs_ varchar2, p_ob22_ varchar2, p_kv_ smallint, p_k041_ varchar2,
  		p_znap_ varchar2, p_comm_ varchar2, p_tobo_ varchar2, p_nbuc_ varchar2) IS
                kod_ varchar2(12);

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

   kod_:= p_tp_ || kod_ || p_nbs_ || p_ob22_ || lpad(p_kv_,3,'0') || p_k041_ ;

   INSERT INTO rnbu_trace
            (nls, kv, odate, kodp, znap, acc, comm, tobo, nbuc)
   VALUES  (p_nls_, p_kv_, p_dat_, kod_, p_znap_, p_acc_, p_comm_, p_tobo_, p_nbuc_);
end;
-------------------------------------------------------------------------------
BEGIN
-------------------------------------------------------------------
userid_ := user_id;
EXECUTE IMMEDIATE 'TRUNCATE TABLE RNBU_TRACE';
-------------------------------------------------------------------
-- определение кода области дл€ выбранного файла и схемы
p_proc_set_int(kodf_,sheme_,nbuc1_,typ_);

--- удаление информации из табл. otcn_acc, otcn_saldo
--- наполнение счетов (в том числе счетов тех.переоценки) и
--- их остатков (номиналы+эквиваленты)+обороты+корректирующие обороты
--- все эти действи€ выполн€ютс€ в функции F_POP_OTCN

-- используем классификатор SB_R020
sql_acc_ := 'select r020 from sb_r020 where f_27=''1'' and ' ||
            '(d_close is null or d_close > to_date('''||to_char(dat_, 'ddmmyyyy')||''',''ddmmyyyy'')) ';

if to_char(Dat_,'MM') in ('12','01','02','03','04','05','06') then
   ret_ := f_pop_otcn(Dat_, 4, sql_acc_, null, 1);
else
   ret_ := f_pop_otcn(Dat_, 3, sql_acc_);
end if;

Dat1_ := TRUNC(Dat_,'MM'); -- початок попереднього м_с€ц€
----------------------------------------------------------------------------
OPEN Saldo;
   LOOP
   FETCH Saldo INTO rnk_, acc_, nls_, kv_, data_, Nbs_, Ostn_, Ostq_,
                    Dos_, Dosq_, Kos_, Kosq_,
                    Dos96p_, Dosq96p_, Kos96p_, Kosq96p_,
                    Dos96_, Dosq96_, Kos96_, Kosq96_,
                    Dos99_, Dosq99_, Kos99_, Kosq99_,
                    Doszg_, Koszg_, Dos96zg_, Kos96zg_,
                    k041_, tobo_, nms_, ob22_;
   EXIT WHEN Saldo%NOTFOUND;

   comm_ := '';

   IF typ_ > 0
   THEN
      nbuc_ := NVL(F_Codobl_Tobo(acc_,typ_),nbuc1_);
   ELSE
      nbuc_ := nbuc1_;
   END IF;

   --- обороты по перекрытию 6,7 классов на 5040,5041
   IF to_char(Dat_,'MM')='12' and (nls_ like '6%' or nls_ like '7%' or nls_ like '390%' or nls_ like '504%') THEN
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

   IF Dos99_ > 0 THEN
      BEGIN
        select NVL(sum(s),0)
           into sk_
        from kor_prov
        where vob=99
          and dk=0
          and acc=acc_
          and fdat between Dat_+1 and Dat_+28;
      EXCEPTION WHEN NO_DATA_FOUND THEN
         sk_ := 0;
      END;

      Dos99_ := Dos99_ - sk_;
   END IF;

   IF Kos99_ > 0 THEN
      BEGIN
        select NVL(sum(s),0)
           into sk_
        from kor_prov
        where vob=99
          and dk=1
          and acc=acc_
          and fdat between Dat_+1 and Dat_+28;
      EXCEPTION WHEN NO_DATA_FOUND THEN
         sk_ := 0;
      END;

      Kos99_ := Kos99_ - sk_;
   END IF;

   IF Dosq99_ > 0 THEN
      BEGIN
        select NVL(sum(gl.p_icurval(kv_, s, vdat)), 0)
           into sk_
        from kor_prov
        where vob=99
          and dk=0
          and acc=acc_
          and fdat between Dat_+1 and Dat_+28;
      EXCEPTION WHEN NO_DATA_FOUND THEN
         sk_ := 0;
      END;

      Dosq99_ := Dosq99_ - sk_;
   END IF;

   IF Kosq99_ > 0 THEN
      BEGIN
        select NVL( sum(gl.p_icurval(kv_, s, vdat)), 0)
           into sk_
        from kor_prov
        where vob=99
          and dk=1
          and acc=acc_
          and fdat between Dat_+1 and Dat_+28;
      EXCEPTION WHEN NO_DATA_FOUND THEN
         sk_ := 0;
      END;

      Kosq99_ := Kosq99_ - sk_;
   END IF;

   --- обороты по перекрытию 6,7 классов на 5040,5041
   IF to_char(Dat_,'MM')='01' and (nls_ like '6%' or nls_ like '7%' or nls_ like '504%') THEN
       SELECT NVL(SUM(decode(dk,0,1,0)*s),0),
              NVL(SUM(decode(dk,1,1,0)*s),0)
         INTO d_sum_, k_sum_
         FROM opldok
         WHERE fdat  = trunc(Dat_, 'mm') AND
               acc  = acc_   AND
               (tt like 'ZG1%' OR tt like 'ZG2%');

      Dos_ := Dos_ - d_sum_;
      Kos_ := Kos_ - k_sum_;

      SELECT NVL(SUM(decode(o.dk,0,1,0)*o.s),0),
                NVL(SUM(decode(o.dk,1,1,0)*o.s),0)
       INTO d_sum_, k_sum_
       FROM opldok o, oper p
      WHERE o.fdat = any(select fdat from fdat where fdat between trunc(Dat_, 'mm')  AND  Dat_)
        AND o.acc  = acc_
        AND (o.tt like 'ZG8%'  or o.tt like 'ZG9%')
        and o.ref = p.ref
        --and p.vdat = dat_
        and p.sos = 5
        and p.vob = 96;

       SELECT NVL(SUM(decode(k.dk,0,1,0)*k.s),0),
              NVL(SUM(decode(k.dk,1,1,0)*k.s),0)
       INTO d_kor_, k_kor_
          FROM kor_prov k, oper p
         WHERE k.fdat  = any(select fdat from fdat where fdat between trunc(Dat_, 'mm')  AND  Dat_) and
               k.acc  = acc_ AND
               k.vob = 96 and
               k.ref = p.ref and
               p.tt not like 'ZG%';

      if Dos_ >0 then
         Dos_ := Dos_ - d_sum_;
      end if;

      if nls_ like '504%' 
      then
         Dos96p_ := 0;
      end if;

      if Dos96p_ >= d_sum_ and d_kor_ <> Dos96p_
      then
         Dos96p_ := Dos96p_ - d_sum_;
      end if;
      
      if Kos_ >0 then
         Kos_ := Kos_ - k_sum_;
      end if;

      if nls_ like '504%'
      then
         Kos96p_ := 0;
      end if;

      if Kos96p_ >= k_sum_ and k_kor_ <> Kos96p_
      then
         Kos96p_ := Kos96p_ - k_sum_;
      end if;   
   END IF;

   Dos_  := Dos_ - Dos96p_ - Dos99_;
   Dosq_ := Dosq_ - Dosq96p_ - Dosq99_;
   Kos_  := Kos_ - Kos96p_ - Kos99_;
   Kosq_ := Kosq_ - Kosq96p_ - Kosq99_;

-- начало ** вставил 28.09.2005
   IF Dos_ < 0 THEN
      Kos_ := Kos_ + ABS(Dos_);
      Dos_ := 0;
   END IF;

   IF Kos_ < 0 THEN
      Dos_ := Dos_ + ABS(Kos_);
      Kos_ := 0;
   END IF;
-- окончание **

   IF Dosq_ < 0 THEN
      Kosq_ := Kosq_ + ABS(Dosq_);
      Dosq_ := 0;
   END IF;

   IF Kosq_ < 0 THEN
      Dosq_ := Dosq_ + ABS(Kosq_);
      Kosq_ := 0;
   END IF;

   comm_ := substr(comm_ || tobo_ || '  ' || nms_, 1, 200);
   IF Dos_ > 0 THEN
      p_ins(data_, '5', acc_, nls_, nbs_, ob22_, kv_, k041_, TO_CHAR(Dos_), comm_, tobo_, nbuc_);
   END IF;

   IF Dosq_ > 0 THEN
      p_ins(data_, '50', acc_, nls_, nbs_, ob22_, kv_ , k041_, TO_CHAR(Dosq_), comm_, tobo_,nbuc_);
   END IF;

   IF Kos_ > 0 THEN
      p_ins(data_, '6', acc_, nls_, nbs_, ob22_, kv_, k041_, TO_CHAR(Kos_), comm_, tobo_, nbuc_);
   END IF;

   IF Kosq_ > 0 THEN
      p_ins(data_, '60', acc_, nls_, nbs_, ob22_, kv_ , k041_, TO_CHAR(Kosq_), comm_, tobo_, nbuc_);
   END IF;

   IF Dos96_ > 0 THEN
      p_ins(data_, '7', acc_, nls_, nbs_, ob22_, kv_, k041_, TO_CHAR(Dos96_), comm_, tobo_, nbuc_);
   END IF;

   IF Dosq96_ > 0 THEN
      p_ins(data_, '70', acc_, nls_, nbs_, ob22_, kv_, k041_, TO_CHAR(Dosq96_), comm_, tobo_, nbuc_);
   END IF;

   IF Kos96_ > 0 THEN
      p_ins(data_, '8', acc_, nls_, nbs_, ob22_, kv_, k041_, TO_CHAR(Kos96_), comm_, tobo_, nbuc_);
   END IF;

   IF Kosq96_ > 0 THEN
      p_ins(data_, '80', acc_, nls_, nbs_, ob22_, kv_, k041_, TO_CHAR(Kosq96_), comm_, tobo_, nbuc_);
   END IF;

   IF Dos99_ > 0 THEN
      p_ins(data_, '9', acc_, nls_, nbs_, ob22_, kv_, k041_, TO_CHAR(Dos99_), comm_, tobo_, nbuc_);
   END IF;

   IF Dosq99_ > 0 THEN
      p_ins(data_, '90', acc_, nls_, nbs_, ob22_, kv_, k041_, TO_CHAR(Dosq99_), comm_, tobo_, nbuc_);
   END IF;

   IF Kos99_ > 0 THEN
      p_ins(data_, '0', acc_, nls_, nbs_, ob22_, kv_, k041_, TO_CHAR(Kos99_), comm_, tobo_, nbuc_);
   END IF;

   IF Kosq99_ > 0 THEN
      p_ins(data_, '00', acc_, nls_, nbs_, ob22_, kv_, k041_, TO_CHAR(Kosq99_), comm_, tobo_, nbuc_);
   END IF;

   Ostn_:=Ostn_-Dos96_+Kos96_;
   Ostq_:=Ostq_-Dosq96_+Kosq96_;

   IF Ostn_<>0 THEN
      dk_:=IIF_N(Ostn_,0,'1','2','2');
      p_ins(data_, dk_, acc_, nls_, nbs_, ob22_, kv_, k041_, TO_CHAR(ABS(Ostn_)), comm_, tobo_, nbuc_);
   END IF;

   IF Ostq_<>0 THEN
      dk_:=IIF_N(Ostq_,0,'1','2','2')||'0';
      p_ins(data_, dk_ , acc_, nls_, nbs_, ob22_, kv_ , k041_, TO_CHAR(ABS(Ostq_)), comm_, tobo_, nbuc_);
   END IF;

END LOOP;
CLOSE Saldo;
---------------------------------------------------------------------------
DELETE FROM tmp_irep where kodf=kodf_ and datf=dat_;
---------------------------------------------------
INSERT INTO tmp_irep (kodf, datf, kodp, znap, nbuc)
select '27', Dat_, kodp, SUM (znap), nbuc
FROM rnbu_trace
GROUP BY kodp, nbuc;
------------------------------------------------------------------
END p_f27sb;
/
show err;

PROMPT *** Create  grants  P_F27SB ***
grant EXECUTE                                                                on P_F27SB         to BARS_ACCESS_DEFROLE;
grant EXECUTE                                                                on P_F27SB         to RPBN002;
grant EXECUTE                                                                on P_F27SB         to WR_ALL_RIGHTS;



PROMPT ===================================================================================== 
PROMPT *** End *** ========== Scripts /Sql/BARS/Procedure/P_F27SB.sql =========*** End *** =
PROMPT ===================================================================================== 
