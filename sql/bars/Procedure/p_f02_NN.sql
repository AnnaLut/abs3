

PROMPT ===================================================================================== 
PROMPT *** Run *** ========== Scripts /Sql/BARS/Procedure/P_F02_NN.sql =========*** Run *** 
PROMPT ===================================================================================== 


PROMPT *** Create  procedure P_F02_NN ***

CREATE OR REPLACE PROCEDURE BARS.P_F02_NN (Dat_ DATE,
                                      sheme_ varchar2 default 'G')  IS
/*%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
% DESCRIPTION :    Процедура формирование файла #02 для КБ
% COPYRIGHT   :    Copyright UNITY-BARS Limited, 1999.All Rights Reserved.
% VERSION     :    06/02/2018 (01/02/2018)
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
параметры: Dat_ - отчетная дата
           sheme_ - схема формирования

05.02.2016 изменения для успешного контроля с предыдущим периодом
08.07.2015 после перехода на DRAPS(ы) не будем добавлять коректирующие
           проводки по родительским счетам (они уже добавлены)
05.03.2015 не вычитались годовые корректирующие проводки выполненные в
           следующем за отчетным месяцем для эквивалентов
           (для номиналов вычитались)
02.01.2014 внесены некоторые изменения выполненные в ГОУ при внедрении
18.11.2013 добавлен блок для добавления корректирующих проводок прошлого
           и текущего месяцев для родительских счетов из дочерних т.к.
           в табл. ACCM_AGG_MONBAL эти коректирующие только по дочерним
13.09.2013 для поля PREM табл. KOD_R020 добавил функцию TRIM
           т.к. после импорта DBF файла KOD_R020 поле PREM без пробела
04.02.2012 вычитаем годовые корректирующие сделанные в следующем за
           отчетным месяце
01.02.2012 для первых 6 месяцев будем выбирать дополнительно годовые
           корректирующие обороты и по ним формировать показатели
           добален вызов процедуры P_OTC_VE9 (вешалки для внебалансовых)
27.07.2009 в курсоре SALDO пока оставил таблицу OTCN_ACC до выполнения
           расширения таблицы OTCN_SALDO (добавление поля "TIP")
24.07.2009 в курсоре SALDO убрал таблицу OTCN_ACC т.к. поле "TIP" внесено
           в табл. OTCN_SALDO
20.07.2009 для 9910 изменил блок заполнения показателя
12.07.2009 для 3800_000000000 изменяем код валюты только для остатков
02.06.2009 добавил для Ровно СБ по счетам 9910_001% будем брать только
           остатки эквивалент ("10","20") т.к. в файле #01.
           для Ровно СБ для счетов тех.переоценки и кодов валют не 643,840,
           978 при отсутствии номинала изменяем код валюты на 978 т.к.
           для этой валюты всегда есть номинал (как в ОПЕРРУ СБ).
01.04.2009 не изменяем код валюты для счетов тех.переоценки бал.счетов
           и внебалансовых счетов
04.04.2008 ОПЕРУ СБ для счетов тех.переоценки и кодов валют не 643,840,
           978 при отсутствии номинала изменяем код валюты на 978 т.к.
           для этой валюты всегда есть номинал.
           Если есть эквивалент и нет номинала возникает ошибка при
           внутреннем контроле(пр-мма Сбербанка) и тогда выполняется
           ручная корректировка файла.
07.03.2008 для банка Киев вызывается процедура проверки P_CH_FILE01
04.02.2008 так как НБУ не поддерживает заполнение поля F_01 в классифи-
           каторе KL_R020, а перечень бал.счетов включаемых в файл
           имеется в KOD_R020, то будем использовать KOD_R020 вместо
           KL_R020
03.10.2006 для бал.счета 3929 добавил вычитание корректирующих проводок
           из оборотов за месяц (ранее не предполагались кор.проводки по
           данному бал.счету)
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%*/
kodf_    varchar2(2):='02';
rnk_     number;
typ_      number;
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
sk_      Number;
kodp_    Varchar2(10);
znap_    Varchar2(30);
Kv_      SMALLINT;
Kv1_     SMALLINT;
--Vob_     SMALLINT;
Nbs_     Varchar2(4);
nls_     Varchar2(15);
mfo_     number;
mfou_    NUMBER;
data_    Date;
p_dat    Date;
p_kodf   Varchar2(2):='02';
k041_    Char(1);
dk_      varchar2(2);
prem_    Char(3);
userid_  Number;
nbuc1_   Varchar2(12);
nbuc_    Varchar2(12);
b_       Varchar2(30);
tips_    Varchar2(3);
flag_    number;
sql_acc_ clob:='';
sql_doda_ clob:='';
ff_      number;
ret_     number;
pr_      NUMBER;
dati_    number;
dats_    Date;
d_sum_   DECIMAL(24);
k_sum_   DECIMAL(24);
l_acc_type    varchar2(3);
d_kor_   number;
k_kor_   number;
-------------------------------------------------------------------------------
CURSOR Saldo IS
   SELECT s.rnk, s.acc, s.nls, s.kv, s.fdat, s.nbs, s.ost, s.ostq,
          s.dos, s.dosq, s.kos, s.kosq,
          s.dos96p, s.dosq96p, s.kos96p, s.kosq96p,
          s.dos96, s.dosq96, s.kos96, s.kosq96,
          s.dos99, s.dosq99, s.kos99, s.kosq99,
          s.doszg, s.koszg, s.dos96zg, s.kos96zg,
          a.tip, nvl(l.k041,'1')
   FROM  otcn_saldo s, otcn_acc a, customer cc, kl_k040 l
   WHERE a.acc=s.acc    and
         a.rnk=cc.rnk   and
         NVL(lpad(to_char(cc.country),3,'0'),'804')=l.k040(+) ;

---------------------------------------------------------------------------
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

   INSERT INTO rnbu_trace
            (nls, kv, odate, kodp, znap, nbuc, acc)
   VALUES  (p_nls_, p_kv_, p_dat_, kod_, p_znap_, p_nbuc_, p_acc_);
end;
-------------------------------------------------------------------------------
BEGIN
-------------------------------------------------------------------
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

p_dat := Dat_;

-- определение кода области для выбранного файла и схемы
p_proc_set(kodf_,sheme_,nbuc1_,typ_);

--- удаление информации из табл. otcn_acc, otcn_saldo
--- наполнение счетов (в том числе счетов тех.переоценки) и
--- их остатков (номиналы+эквиваленты)+обороты+корректирующие обороты
--- все эти действия выполняются в функции F_POP_OTCN

-- вместо классификатора KL_R020 будем использовать KOD_R020
sql_acc_ := 'select r020 from kod_r020 where trim(prem)=''КБ'' and a010=''02'' and '||
            '(d_close is null or d_close > to_date('''||to_char(dat_, 'ddmmyyyy')||''',''ddmmyyyy'')) ';

if to_char(Dat_,'MM') in ('01','02','03','04','05','06') then
   ret_ := f_pop_otcn(Dat_, 4, sql_acc_, null, 1);
else
   ret_ := f_pop_otcn(Dat_, 3, sql_acc_);
end if;

Dat1_ := TRUNC(Dat_,'MM'); -- початок попереднього м_сяця

BEGIN
   SELECT TO_DATE(val,'DDMMYYYY')
      INTO dats_
   FROM params WHERE par='DATRAPS';
EXCEPTION
   WHEN NO_DATA_FOUND
   THEN
      dats_ := null;
END;

----------------------------------------------------------------------------
-- блок для наполнения корректирующих проводок
-- прошлого и текущего отчетных месяцев
-- по родительским счетам из дочерних
IF dats_ is null
THEN
   for tt in (select /*+ leading(k)  */
                      a.accc accc, a.acc acc, a.nls, a.kv,
                      s.crdos, s.crdosq, s.crkos, s.crkosq,
                      s.cudos, s.cudosq, s.cukos, s.cukosq
               from kod_r020 k, accounts a, agg_monbals s
               where a.accc is not null
                 and a.acc = s.acc
                 and s.fdat = dat1_
                 and a.nls like k.r020 || '%'
                 and a010 = '02'
                 and trim(prem)='КБ'
             )
    loop
        if tt.cudos+tt.cudosq+tt.cukos+tt.cukosq+tt.crdos+tt.crdosq+tt.crkos+tt.crkosq<>0 then
            update otcn_saldo set dos96p = dos96p + tt.cudos,
                                  dosq96p = dosq96p + decode(tt.kv, 980, 0, tt.CUdosq),
                                  kos96p = kos96p + tt.cukos,
                                  kosq96p = kosq96p + decode(tt.kv, 980, 0, tt.CUkosq),
                                  dos96  = dos96 + tt.crdos,
                                  dosq96 = dosq96 + decode(tt.kv, 980, 0, tt.CRdosq),
                                  kos96  = kos96 + tt.crkos,
                                  kosq96 = kosq96 + decode(tt.kv, 980, 0, tt.CRkosq)
            where acc = tt.accc;
        end if;

        -- коригуючі за минулий місяць добавляємо по "родительским" рахункам
        IF to_char(dats_,'MM') = to_char(Dat_,'MM') then
            if tt.cudos+tt.cudosq+tt.cukos+tt.cukosq<>0 then
                update otcn_saldo set dos96p = dos96p + tt.cudos,
                                      dosq96p = dosq96p + decode(tt.kv, 980, 0, tt.CUdosq),
                                      kos96p = kos96p + tt.cukos,
                                      kosq96p = kosq96p + decode(tt.kv, 980, 0, tt.CUkosq)
                where acc = tt.accc;
             end if;
        end if;
    end loop;
END IF;

----------------------------------------------------------------------------
OPEN Saldo;
   LOOP
   FETCH Saldo INTO rnk_, acc_, nls_, kv_, data_, Nbs_, Ostn_, Ostq_,
                    Dos_, Dosq_, Kos_, Kosq_,
                    Dos96p_, Dosq96p_, Kos96p_, Kosq96p_,
                    Dos96_, Dosq96_, Kos96_, Kosq96_,
                    Dos99_, Dosq99_, Kos99_, Kosq99_,
                    Doszg_, Koszg_, Dos96zg_, Kos96zg_,
                    tips_, k041_;
   EXIT WHEN Saldo%NOTFOUND;

   if typ_ > 0 then
      nbuc_ := nvl(f_codobl_tobo(acc_,typ_),nbuc1_);
   else
      nbuc_ := nbuc1_;
   end if;

   --- обороты по перекрытию 6,7 классов на 5040,5041
   IF to_char(Dat_,'MM')='12' and (nls_ like '6%' or nls_ like '7%' or nls_ like '504%') THEN
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
   IF to_char(Dat_,'MM')='01' and (nls_ like '6%' or nls_ like '7%' or nls_ like '390%' or nls_ like '504%') THEN
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

   IF substr(nls_,1,4)='3929' AND Kv_=980 then
      IF Dos_=Kos_ THEN
         Dos_:=0;
         Kos_:=0;
      END IF;

      IF Dos_ > Kos_ THEN
         Dos_:=Dos_-Kos_ ;
         Kos_:=0;
      END IF;

      IF Dos_ < Kos_ THEN
         Kos_:=Kos_-Dos_ ;
         Dos_:=0;
      END IF;

      IF Dosq_=Kosq_ THEN
         Dosq_:=0;
         Kosq_:=0;
      END IF;

      IF Dosq_ > Kosq_ THEN
         Dosq_:=Dosq_-Kosq_ ;
         Kosq_:=0;
      END IF;

      IF Dosq_ < Kosq_ THEN
         Kosq_:=Kosq_-Dosq_ ;
         Dosq_:=0;
      END IF;
   END IF;

-- начало ** вставил 28.09.2005
   IF Dos_ < 0 THEN
      Kos_:=Kos_+ABS(Dos_);
      Dos_ := 0;
   END IF;

   IF Kos_ < 0 THEN
      Dos_:=Dos_+ABS(Kos_);
      Kos_ := 0;
   END IF;
-- окончание **

   IF Dosq_ < 0 THEN
      Kosq_:=Kosq_+ABS(Dosq_);
      Dosq_ := 0;
   END IF;

   IF Kosq_ < 0 THEN
      Dosq_:=Dosq_+ABS(Kosq_);
      Kosq_ := 0;
   END IF;

   IF Dos_ > 0 THEN
      p_ins(data_, '5', nls_, nbs_, kv_, k041_, TO_CHAR(Dos_), acc_, nbuc_);
   END IF;

   IF Dosq_ > 0  THEN
      p_ins(data_, '50', nls_, nbs_, kv_ , k041_, TO_CHAR(Dosq_), acc_, nbuc_);
   END IF;

   IF Kos_ > 0 THEN
      p_ins(data_, '6', nls_, nbs_, kv_, k041_, TO_CHAR(Kos_), acc_, nbuc_);
   END IF;

   IF Kosq_ > 0 THEN
      p_ins(data_, '60', nls_, nbs_, kv_ , k041_, TO_CHAR(Kosq_), acc_, nbuc_);
   END IF;

   IF Dos96_ > 0  THEN
      p_ins(data_, '7', nls_, nbs_, kv_, k041_, TO_CHAR(Dos96_), acc_, nbuc_);
   END IF;

   IF Dosq96_ > 0 THEN
      p_ins(data_, '70', nls_, nbs_, kv_, k041_, TO_CHAR(Dosq96_), acc_, nbuc_);
   END IF;

   IF Kos96_ > 0 THEN
      p_ins(data_, '8', nls_, nbs_, kv_, k041_, TO_CHAR(Kos96_), acc_, nbuc_);
   END IF;

   IF Kosq96_ > 0 THEN
      p_ins(data_, '80', nls_, nbs_, kv_, k041_, TO_CHAR(Kosq96_), acc_, nbuc_);
   END IF;

   IF Dos99_ > 0 THEN
      p_ins(data_, '9', nls_, nbs_, kv_, k041_, TO_CHAR(Dos99_), acc_, nbuc_);
   END IF;

   IF Dosq99_ > 0 THEN
      p_ins(data_, '90', nls_, nbs_, kv_, k041_, TO_CHAR(Dosq99_), acc_, nbuc_);
   END IF;

   IF Kos99_ > 0 THEN
      p_ins(data_, '0', nls_, nbs_, kv_, k041_, TO_CHAR(Kos99_), acc_, nbuc_);
   END IF;

   IF Kosq99_ > 0 THEN
      p_ins(data_, '00', nls_, nbs_, kv_, k041_, TO_CHAR(Kosq99_), acc_, nbuc_);
   END IF;

   Ostn_:=Ostn_-Dos96_+Kos96_;
   Ostq_:=Ostq_-Dosq96_+Kosq96_;

   IF Ostn_<>0 THEN
      dk_:=IIF_N(Ostn_,0,'1','2','2');
      p_ins(data_, dk_, nls_, nbs_, kv_, k041_, TO_CHAR(ABS(Ostn_)), acc_, nbuc_);
   END IF;

   IF Ostq_<>0 THEN
      dk_:=IIF_N(Ostq_,0,'1','2','2')||'0';
      p_ins(data_, dk_ , nls_, nbs_, kv_ , k041_, TO_CHAR(ABS(Ostq_)), acc_, nbuc_);
   END IF;

END LOOP;
CLOSE Saldo;

-- готовый отчет в таблицу.
DELETE FROM TMP_NBU WHERE kodf=kodf_ AND datf= dat_;

INSERT INTO TMP_NBU (kodf, datf, kodp, nbuc, znap)
select kodf_, dat_, kodp, nbuc, SUM(znap)
from RNBU_TRACE
GROUP BY kodp, nbuc;
------------------------------------------------------------------
END p_f02_NN;
/
show err;

PROMPT *** Create  grants  P_F02_NN ***
grant EXECUTE                                                                on P_F02_NN        to WR_ALL_RIGHTS;



PROMPT ===================================================================================== 
PROMPT *** End *** ========== Scripts /Sql/BARS/Procedure/P_F02_NN.sql =========*** End *** 
PROMPT ===================================================================================== 

