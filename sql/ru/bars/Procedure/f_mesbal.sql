

PROMPT ===================================================================================== 
PROMPT *** Run *** ========== Scripts /Sql/BARS/Procedure/F_MESBAL.sql =========*** Run *** 
PROMPT ===================================================================================== 


PROMPT *** Create  procedure F_MESBAL ***

  CREATE OR REPLACE PROCEDURE BARS.F_MESBAL (Dat_B DATE, Dat_N DATE,
                                      mod_ NUMBER DEFAULT 0)  IS
/*%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
% DESCRIPTION :	Процедура формирования вх.остатков, оборотов исх.остатков
% COPYRIGHT   :	Copyright UNITY-BARS Limited, 1999.All Rights Reserved.
% VERSION     : 17.09.2008 (21.02.2008,16.03.2007,04.04.2006)
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
параметры: Dat_B - начальная дата периода
           Dat_N - конечная дата периода
           mod_  - 0-наполнение OTCN_SALDO,
                   1-корректировка полей Оборотов и Остатков в случае
                   отрицательных значений по одному из полей как в файле #02
Будет использоваться для формирования сальдовки или баланса за период
(месяц,квартал,год) с учетом корректирующих проводок
вх.остатки -- обороты -- исх.остатки
17.09.2008 заменил условие отбора бал.счетов вместо кл-ра KL_R020 будет
           кл-р KOD_R020
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%*/
rnk_     number;
typ_ 	 number;
tips_    Varchar2(3);
data_    date;
acc_     Number;
datn_    date;
dat3_    date;
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
Dosnk_   DECIMAL(24);
Kosnk_   DECIMAL(24);
Ostn_    DECIMAL(24);
Ostq_    DECIMAL(24);
kodp_    Varchar2(10);
znap_    Varchar2(30);
Kv_      SMALLINT;
Nbs_     Varchar2(4);
nls_     Varchar2(15);
userid_  Number;
flag_    number;
sql_acc_ varchar2(2000):='';
sql_doda_ varchar2(200):='';
ff_      number;
ret_	 number;
mfo_     number;
mfou_    number;
-------------------------------------------------------------------------------
CURSOR Saldo IS
   SELECT a.rnk, a.acc, a.nls, a.kv, s.fdat, a.nbs, s.ost, s.ostq,
          s.dos, s.dosq, s.kos, s.kosq,
          s.dos96p, s.dosq96p, s.kos96p, s.kosq96p,
          s.dos96, s.dosq96, s.kos96, s.kosq96,
          s.dos99, s.dosq99, s.kos99, s.kosq99,
          s.doszg, s.koszg, s.dos96zg, s.kos96zg,
          a.tip
   FROM  otcn_saldo s, otcn_acc a
   WHERE a.acc=s.acc ;

BEGIN
-------------------------------------------------------------------
--- удаление информации из табл. otcn_saldo
--- наполнение счетов (в том числе счетов тех.переоценки) и
--- их остатков (номиналы+эквиваленты)+обороты+корректирующие обороты
---DELETE FROM SALDO_OTCN WHERE odate=Dat_;
--EXECUTE IMMEDIATE 'TRUNCATE TABLE OTCN_SALDO';

mfo_ := F_Ourmfo ();

-- МФО "родителя"
BEGIN
   SELECT mfou INTO mfou_
   FROM BANKS
   WHERE mfo = mfo_;
EXCEPTION WHEN NO_DATA_FOUND THEN
   mfou_ := mfo_;
END;

--sql_acc_ := 'select r020 from kl_r020 where prem=''КБ '' and f_01=''1''';
-- 04.02.2008 вместо классификатора KL_R020 будем использовать KOD_R020
sql_acc_ := 'select r020 from kod_r020 where prem=''КБ '' and a010=''01'' ';

ret_ := f_pop_otcn(Dat_N, 5, sql_acc_, Dat_B);

----------------------------------------------------------------------------
IF mod_ in (0,1) THEN
-- для отражения развернутых остатков по 6 и 7 классам в конце года
-- вычитаем обороты по перекрытию 6,7 классов на 5040,5041
   IF to_char(Dat_N,'MM')='12' THEN
      update otcn_saldo set dos=Dos-NVL(Doszg,0),
                            kos=Kos-NVL(Koszg,0),
                            ost=Ost+NVL(Doszg,0)-NVL(Koszg,0)
      where Doszg+Koszg<>0 and
           (substr(nls,1,1) in ('6','7') or substr(nls,1,4) in ('5040','5041'));
   END IF;
END IF;

-- корректировка полей остатков и оборотов в OTCN_SALDO как в файле #02
if mod_=1 then

   update otcn_saldo set dos=Dos-NVL(Dos96p,0),
                         dosq=Dosq-NVL(Dosq96p,0),
                         kos=Kos-NVL(Kos96p,0),
                         kosq=Kosq-NVL(Kosq96p,0)
   where NVL(Dos96p,0)+NVL(Kos96p,0)+NVL(Dosq96p,0)+NVL(Kosq96p,0)<>0 ;

-- !!!!!! убрал из курсора этот блок 16.03.2007 !!!!!!
-----------------------------------------------------------------------------
-- убрал из курсора SALDO и заменил на UPDATE
   update otcn_saldo set Kos=Kos+ABS(Dos), Dos=0 where Dos < 0;
--   IF Dos_ < 0 THEN
--      Kos_:=Kos_+ABS(Dos_);
--      Dos_:=0;
--   END IF;

-- убрал из курсора и заменил на UPDATE
   update otcn_saldo set Dos=Dos+ABS(Kos), Kos=0 where Kos < 0;
--   IF Kos_ < 0 THEN
--      Dos_:=Dos_+ABS(Kos_);
--      Kos_:=0;
--   END IF;
-- окончание **

-- убрал из курсора и заменил на UPDATE
   update otcn_saldo set Kosq=Kosq+ABS(Dosq), Dosq=0 where Dosq < 0;
--   IF Dosq_ < 0 THEN
--      Kosq_:=Kosq_+ABS(Dosq_);
--      Dosq_:=0;
--   END IF;

-- убрал из курсора и заменил на UPDATE
   update otcn_saldo set Dosq=Dosq+ABS(Kosq), Kosq=0 where Kosq < 0;
--   IF Kosq_ < 0 THEN
--      Dosq_:=Dosq_+ABS(Kosq_);
--      Kosq_:=0;
--   END IF;

--   update otcn_saldo set dos=Dos_,kos=Kos_,dosq=Dosq_,kosq=Kosq_
--   where acc=acc_;
-----------------------------------------------------------------------------
-- !!!!!! убрал из курсора SALDO этот блок 16.03.2007 !!!!!!

OPEN Saldo;
   LOOP
   FETCH Saldo INTO rnk_, acc_, nls_, kv_, data_, Nbs_, Ostn_, Ostq_,
                    Dos_, Dosq_, Kos_, Kosq_,
                    Dos96p_, Dosq96p_, Kos96p_, Kosq96p_,
                    Dos96_, Dosq96_, Kos96_, Kosq96_,
                    Dos99_, Dosq99_, Kos99_, Kosq99_,
                    Doszg_, Koszg_, Dos96zg_, Kos96zg_,
                    tips_;
   EXIT WHEN Saldo%NOTFOUND;

--- корректирующие проводки и корректирующие проводки перекрытия счетов
--- 6,7 классов и 5040,5041
--- (начало года 6,7 классы с нуля,  5040(5041) разница 6 и 7 классов)
   IF (substr(nls_,1,1) in ('6','7') OR substr(nls_,1,4) in ('5040','5041'))
      and to_char(Dat_B,'MM')='01' THEN
      BEGIN
         SELECT SUM(DECODE(dk, 0, s, 0)),
                SUM(DECODE(dk, 1, s, 0))
         INTO  Dosnk_, Kosnk_
         FROM  kor_prov
         WHERE acc=acc_          AND
               vob in (196,199)  AND
               fdat >= Dat_B     AND
               fdat <= Dat_B+28  AND
               sos=5
         GROUP BY acc ;
      EXCEPTION WHEN NO_DATA_FOUND THEN
         Dosnk_ :=0 ;
         Kosnk_ :=0 ;
      END ;

      IF Dosnk_+Kosnk_ <> 0 THEN
         update otcn_saldo set dos=Dos-Dosnk_, kos=Kos-Kosnk_
         where acc=acc_;
         update otcn_saldo set dos96p=Dos96p+Dosnk_, kos96p=Kos96p+Kosnk_
         where acc=acc_;
      END IF;

   END IF;
-----------------------------------------------------------------------------
--- годовые корректирующие проводки кроме оборотов по перекрытию 6,7 классов на 5040,5041
   IF to_char(Dat_N,'MM')='12' THEN
      BEGIN
         SELECT SUM(DECODE(dk, 0, s, 0)),
                SUM(DECODE(dk, 1, s, 0))
         INTO  Dosnk_, Kosnk_
         FROM  kor_prov
         WHERE acc=acc_        AND
               fdat >= Dat_N   AND
               fdat <= Dat3_   AND
               sos=5
         GROUP BY acc ;
      EXCEPTION WHEN NO_DATA_FOUND THEN
         Dosnk_ :=0 ;
         Kosnk_ :=0 ;
      END ;

      IF kv_=980 then
         Dos99_:=Dos99_+NVL(Dosnk_,0);
         Kos99_:=Kos99_+NVL(Kosnk_,0);
         Dosq99_:=0;
         Kosq99_:=0;
--         Ostn_:=Ostn_-NVL(Dosnk_,0)+NVL(Kosnk_,0);
      ELSE
         Dos99_:=Dos99_+NVL(Dosnk_,0);
         Kos99_:=Kos99_+NVL(Kosnk_,0);
         Dosq99_:=Dosq99_+NVL(GL.P_ICURVAL(kv_, Dosnk_, Dat_N),0);
         Kosq99_:=Kosq99_+NVL(GL.P_ICURVAL(kv_, Kosnk_, Dat_N),0);
--         Ostq_:=Ostq_-NVL(GL.P_ICURVAL(kv_, Dosnk_, Dat_N),0)
--                     +NVL(GL.P_ICURVAL(kv_, Kosnk_, Dat_N),0);
      END IF;

      IF Dosnk_+Kosnk_<>0 THEN
         update otcn_saldo set dos99=Dos99_, dosq99=Dosq99_, kos99=Kos99_,
                               kosq99=Kosq99_  --ost=Ostn_,ostq=Ostq_
         where acc=acc_;
      END IF;

   END IF;

----   Dos_:=Dos_-Dos96p_-Dos99_;
----   Dosq_:=Dosq_-Dosq96p_-Dosq99_;
----   Kos_:=Kos_-Kos96p_-Kos99_;
----   Kosq_:=Kosq_-Kosq96p_-Kosq99_;
--   Dos_:=Dos_-Dos96p_;
--   Dosq_:=Dosq_-Dosq96p_;
--   Kos_:=Kos_-Kos96p_;
--   Kosq_:=Kosq_-Kosq96p_;

   IF (substr(nls_,1,4)='3929' AND Kv_=980) or (tips_='ASG' and 300120 NOT IN (mfo_, mfou_)) THEN
      if mfo_ = 322498 then
        -- Будет с 01.11.2005
         IF substr(nls_,1,4)='3929' AND Kv_=980 THEN
            SELECT SUM(iif_n(dos-kos,0,0,0,dos-kos)),
                   SUM(iif_n(kos-dos,0,0,0,kos-dos))
            INTO Dos_, Kos_
            from sal
            where acc=acc_ and substr(nls,1,4)='3929' and
                  kv=980 and dos+kos<>0 and
                  fdat between Dat_B and Dat_N;
            update otcn_saldo set dos=Dos_,kos=Kos_
            where acc=acc_;
         END IF;
      else
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
         update otcn_saldo set dos=Dos_,kos=Kos_,dosq=Dosq_,kosq=Kosq_
         where acc=acc_;
      END IF;
   END IF;

-- начало ** вставил 28.09.2005
--   IF Dos_ < 0 THEN
--      Kos_:=Kos_+ABS(Dos_);
--      Dos_:=0;
--   END IF;

--   IF Kos_ < 0 THEN
--      Dos_:=Dos_+ABS(Kos_);
--      Kos_:=0;
--   END IF;
-- окончание **

--   IF Dosq_ < 0 THEN
--      Kosq_:=Kosq_+ABS(Dosq_);
--      Dosq_:=0;
--   END IF;

--   IF Kosq_ < 0 THEN
--      Dosq_:=Dosq_+ABS(Kosq_);
--     Kosq_:=0;
--  END IF;

--   update otcn_saldo set dos=Dos_,kos=Kos_,dosq=Dosq_,kosq=Kosq_
--   where acc=acc_;

END LOOP;
CLOSE Saldo;

end if;
---------------------------------------------------
END f_mesbal;
/
show err;

PROMPT *** Create  grants  F_MESBAL ***
grant EXECUTE                                                                on F_MESBAL        to BARS_ACCESS_DEFROLE;
grant EXECUTE                                                                on F_MESBAL        to RPBN001;
grant EXECUTE                                                                on F_MESBAL        to RPBN002;
grant EXECUTE                                                                on F_MESBAL        to START1;
grant EXECUTE                                                                on F_MESBAL        to WR_ALL_RIGHTS;



PROMPT ===================================================================================== 
PROMPT *** End *** ========== Scripts /Sql/BARS/Procedure/F_MESBAL.sql =========*** End *** 
PROMPT ===================================================================================== 
