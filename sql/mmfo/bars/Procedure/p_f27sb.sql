CREATE OR REPLACE PROCEDURE BARS.P_F27SB (Dat_ DATE, sheme_ VARCHAR2 DEFAULT 'C')  IS
/*%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
% DESCRIPTION :	Процедура формирование файла @27 для КБ
% COPYRIGHT   :	Copyright UNITY-BARS Limited, 2009.All Rights Reserved.
% VERSION     : 01/02/2019 (28/01/2019)
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
параметры: Dat_ - отчетная дата
           sheme_ - схема формирования
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
23.01.2018 - в курсоре SALDO изменены условия для отбора (аналогично как
             для файла #02)
19.01.2018 - в курсоре SALDO вместо union all оставил только   union
             (не включались все бал.счета)
18.01.2018 - при выдбор_ бал.рахунк_в _з SB_R020 додано перев_рку на
             дату закриття бал. рахунку (поле D_CLOSE)
             параметр OB22 будем выбирать из ACCOUNTS вместо SPECPARAM_INT
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%*/
kodf_    varchar2(2):='27';
rnk_     number;
typ_ 	 number;
acc_     Number;
dat1_    Date;
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
Nbs_     Varchar2(4);
nls_     Varchar2(15);
mfo_     number;
mfou_    NUMBER;
data_    Date;
k041_    Char(1);
dk_      varchar2(2);
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

l_date_transform    date;
l_acc_type          varchar2(3);

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
     and NVL(lpad(to_char(cc.country),3,'0'),'804')=l.k040(+) 
     and (l_date_transform = to_date('01011900', 'ddmmyyyy') or
          l_date_transform <> to_date('01011900', 'ddmmyyyy') and 
          (a.dat_alt is null OR
           a.dat_alt is not null and a.nls not like '262%' OR
           a.dat_alt is not null and a.nls like '262%' and (a.daos >= a.dat_alt or a.dat_alt <> l_date_transform)));

CURSOR Saldo_kor IS
   SELECT s.rnk, s.acc, d.acc_num nls, s.kv, s.fdat, substr(d.acc_num, 1, 4) nbs,
          (case when d.acc_type = 'OLD' then 0 else s.ost end) ost,
          (case when d.acc_type = 'OLD' then 0 else s.ostq end) ostq,
          --
          (case when d.acc_type = 'OLD' then d.dos_repm  else s.dos + d.dos_repm end) dos,
          (case when d.kv = 980 then 0 else (case when d.acc_type = 'OLD' then d.dosq_repm  else s.dosq + d.dosq_repm end) end) dosq,
          (case when d.acc_type = 'OLD' then d.kos_repm  else s.kos + d.kos_repm end) kos,
          (case when d.kv = 980 then 0 else (case when d.acc_type = 'OLD' then d.kosq_repm  else s.kosq + d.kosq_repm end) end) kosq,
          --
          s.dos96p,
          s.dosq96p,
          s.kos96p,
          s.kosq96p,
          (case when d.acc_type = 'OLD' then 0 else s.dos96 end) dos96,
          (case when d.acc_type = 'OLD' then 0 else s.dosq96 end) dosq96,
          (case when d.acc_type = 'OLD' then 0 else s.kos96 end) kos96,
          (case when d.acc_type = 'OLD' then 0 else s.kosq96 end) kosq96,
          (case when d.acc_type = 'OLD' then 0 else s.dos99 end) dos99,
          (case when d.acc_type = 'OLD' then 0 else s.dosq99 end) dosq99,
          (case when d.acc_type = 'OLD' then 0 else s.kos99 end) kos99,
          (case when d.acc_type = 'OLD' then 0 else s.kosq99 end) kosq99,
          (case when d.acc_type = 'OLD' then 0 else s.doszg end) doszg,
          (case when d.acc_type = 'OLD' then 0 else s.koszg end) koszg,
          (case when d.acc_type = 'OLD' then 0 else s.dos96zg end) dos96zg,
          (case when d.acc_type = 'OLD' then 0 else s.kos96zg end) kos96zg,
          nvl(l.k041,'1'), a.tobo, a.nms, NVL(trim(d.acc_ob22),'00'),
          d.acc_type
   FROM  otcn_saldo s, otcn_acc a, nbur_kor_balances d, customer cc, kl_k040 l 
   WHERE a.acc=s.acc    and
         a.rnk=cc.rnk   and
         NVL(lpad(to_char(cc.country),3,'0'),'804')=l.k040(+)  and
         d.report_date = l_date_transform and 
         s.acc = d.acc_id;
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
-- определение кода области для выбранного файла и схемы
p_proc_set_int(kodf_,sheme_,nbuc1_,typ_);

--- удаление информации из табл. otcn_acc, otcn_saldo
--- наполнение счетов (в том числе счетов тех.переоценки) и
--- их остатков (номиналы+эквиваленты)+обороты+корректирующие обороты
--- все эти действия выполняются в функции F_POP_OTCN

-- используем классификатор SB_R020
sql_acc_ := 'select r020 from sb_r020 where f_27=''1'' and ' ||
            '(d_close is null or d_close > to_date('''||to_char(dat_, 'ddmmyyyy')||''',''ddmmyyyy'')) ';

if to_char(Dat_,'MM') in ('12','01','02','03','04','05','06') then
   ret_ := f_pop_otcn(Dat_, 4, sql_acc_, null, 1);
else
   ret_ := f_pop_otcn(Dat_, 3, sql_acc_);
end if;

Dat1_ := TRUNC(Dat_,'MM'); -- початок попереднього м_сяця

-- дата трансформації рахунків (2625 в 2620)
begin
  select nvl(max(bal.report_date), to_date('01011900', 'ddmmyyyy'))
  into l_date_transform
  from nbur_kor_balances bal
  where bal.report_date between trunc(Dat_, 'mm') and Dat_;
exception
  when others then
        l_date_transform := to_date('01011900', 'ddmmyyyy'); -- Загоням дату трансформации ниже текущих отчетов
end;

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

if l_date_transform <> to_date('01011900', 'ddmmyyyy') then
    OPEN Saldo_kor;
       LOOP
       FETCH Saldo_kor INTO rnk_, acc_, nls_, kv_, data_, Nbs_, Ostn_, Ostq_,
                        Dos_, Dosq_, Kos_, Kosq_,
                        Dos96p_, Dosq96p_, Kos96p_, Kosq96p_,
                        Dos96_, Dosq96_, Kos96_, Kosq96_,
                        Dos99_, Dosq99_, Kos99_, Kosq99_,
                        Doszg_, Koszg_, Dos96zg_, Kos96zg_,
                        k041_, tobo_, nms_, ob22_, l_acc_type;
       EXIT WHEN Saldo_kor%NOTFOUND;

       comm_ := '';

       IF typ_ > 0
       THEN
          nbuc_ := NVL(F_Codobl_Tobo(acc_,typ_),nbuc1_);
       ELSE
          nbuc_ := nbuc1_;
       END IF;
       
       if l_acc_type  = 'NEW' then
           Dos_  := Dos_ - Dos96p_ - Dos99_;
           Dosq_ := Dosq_ - Dosq96p_ - Dosq99_;
           Kos_  := Kos_ - Kos96p_ - Kos99_;
           Kosq_ := Kosq_ - Kosq96p_ - Kosq99_;

           declare
             dosn_kor number;
             kosn_kor number;
             dosq_kor number;
             kosq_kor number;
           begin
              SELECT nvl(DOS_REPM, 0) - nvl(DOS_REPD, 0),
                     nvl(DOSQ_REPM, 0) - nvl(DOSQ_REPD, 0),
                     nvl(KOS_REPM, 0) - nvl(KOS_REPD, 0),
                     nvl(KOSQ_REPM, 0) - nvl(KOSQ_REPD, 0)
                 INTO dosn_kor, dosq_kor, kosn_kor, kosq_kor
              FROM nbur_kor_balances
              WHERE report_date = l_date_transform AND
                    acc_id  = acc_   AND
                    acc_type = 'OLD';

              Dos_ := Dos_ - (dosn_kor - Dos96p_);
              Kos_ := Kos_ - (kosn_kor - Kos96p_);

              if kv_ <> 980 then
                 Dosq_ := Dosq_ - (dosq_kor - Dosq96p_);
                 Kosq_ := Kosq_ - (kosq_kor - Kosq96p_);
              end if;
           exception
                when no_data_found then
                    null;
           end;
       end if;
       
       if l_acc_type  = 'OLD' then
          Dos_ := Dos_ - Dos96p_;
          Kos_ := Kos_ - Kos96p_;

          if kv_ <> 980 then
             Dosq_ := Dosq_ - Dosq96p_;
             Kosq_ := Kosq_ - Kosq96p_;
          end if;
       end if;
       
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
    CLOSE Saldo_kor;
end if;
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
