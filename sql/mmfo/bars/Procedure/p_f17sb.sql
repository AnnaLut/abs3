

PROMPT ===================================================================================== 
PROMPT *** Run *** ========== Scripts /Sql/BARS/Procedure/P_F17SB.sql =========*** Run *** =
PROMPT ===================================================================================== 


PROMPT *** Create  procedure P_F17SB ***

  CREATE OR REPLACE PROCEDURE BARS.P_F17SB (Dat_ DATE) IS
/*%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
% DESCRIPTION :	Процедура формирования @17 для Ощадбанку
% COPYRIGHT   :	Copyright UNITY-BARS Limited, 2009.  All Rights Reserved.
% VERSION     : 11.05.2011 (20.04.2011,01.03.2011,25.02.2009)
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
% параметры: Dat_ - отчетная дата
% 11.05.2011 - добавил acc,tobo в протокол
% 20.04.2011 - для кода процентов '3' изменил условие на >=0 вместо <>0
% 01.03.2011 - в поле комментарий вносим код TOBO и название счета
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%*/
fmt_     varchar2(20):='999990D0000';
acc_    Number;
acc1_    Number;
acc2_    Number;
s_      Varchar2(1);
dat1_   Date;
dat2_   Date;
Dosn_   DECIMAL(24);
Dose_   DECIMAL(24);
Kosn_   DECIMAL(24);
Kose_   DECIMAL(24);
Dosnk_  DECIMAL(24);
Dosek_  DECIMAL(24);
Kosnk_  DECIMAL(24);
Kosek_  DECIMAL(24);
se_     DECIMAL(24);
sn_     DECIMAL(24);
sum1_    number;
sum0_    number;
Dosnkg_  DECIMAL(24);
Dosekg_  DECIMAL(24);
Kosnkg_  DECIMAL(24);
Kosekg_  DECIMAL(24);
Ostn_   DECIMAL(24);
Oste_   DECIMAL(24);
kodp_   varchar2(14);
kodp1_  varchar2(14);
tp_     varchar2(2);
znap_   varchar2(30);
Kv_     SMALLINT;
Vob_    SMALLINT;
Nbs_    varchar2(4);
nls_    varchar2(15);
s0000_  varchar2(15);
s0009_  varchar2(15);
data_   date;
data1_  date;
dazs_   Date;
ob22_   Varchar2(2);
k041_   char(1);
f17_    Number;
dk_     char(1);
sPCnt_   Number;
sPCnt1_  Varchar2(10);
S180_    Varchar2(1);
nbu_    SMALLINT;
prem_   char(3);
userid_ Number;
tobo_   accounts.tobo%TYPE;
nms_    accounts.nms%TYPE;
comm_   rnbu_trace.comm%TYPE;

---Остатки на отчетную дату (грн. + валюта)
CURSOR SaldoBN IS
   SELECT /* + INDEX(L XIE_K040_KL_K040) INDEX (C XPK_CUSTOMER) */
         a.acc, a.nls, a.kv, a.daos, a.dazs, a.nbs,
         NVL(a.ostf-a.dos+a.kos,0),
         DECODE(trim(p.s180), NULL, FS180(a.acc), p.s180),
         NVL(acrn.FPROC(a.acc, Dat_),0),
---         GL.P_ICURVAL(a.kv, a.ostf-a.dos+a.kos, Dat_),
         a.tobo, a.nms, NVL(trim(sp.ob22),'00')
   FROM  (SELECT s.rnk, s.acc, s.nls, s.kv, aa.fdat, s.nbs, aa.ostf,
         aa.dos, aa.kos, s.daos, s.dazs, s.tobo, s.nms
         FROM saldoa aa, accounts s
         WHERE aa.acc=s.acc
           and aa.fdat = (select max(c.fdat)
                          from saldoa c
                          where c.acc=aa.acc and c.fdat <= Dat_)) a,
         customer c, sb_r020 k, specparam p, specparam_int sp
   WHERE a.nbs=k.r020                  AND
         trim(k.f_17) is not null      AND
         c.rnk=a.rnk                   AND
         a.acc=p.acc(+)                AND
         a.acc=sp.acc(+);

---Остатки на отчетную дату (сч. тех. переоценки + эквиваленты)
CURSOR SaldoBQ IS
   SELECT  a.acc, a.nls, a.kv, a.daos, a.dazs, a.nbs, a.ostf-a.dos+a.kos,
           DECODE(trim(p.s180), NULL, FS180(a.acc), p.s180),
           acrn.FPROC(a.acc, Dat_), a.tobo, a.nms, NVL(trim(sp.ob22),'00')
   FROM  (SELECT s.rnk, s.acc, s.nls, s.kv, aa.fdat, s.nbs, aa.ostf,
                 aa.dos, aa.kos, s.daos, s.dazs, s.tobo, s.nms
         FROM saldob aa, accounts s
         WHERE aa.acc=s.acc
           and aa.fdat = (select max(c.fdat)
                          from saldob c
                          where c.acc=aa.acc and c.fdat <= Dat_)) a,
         customer c, sb_r020 k, specparam p, specparam_int sp
   WHERE a.nbs=k.r020                  AND
         trim(k.f_17) is not null      AND
         c.rnk=a.rnk                   AND
         a.acc=p.acc(+)                AND
         a.acc=sp.acc(+);

---Обороты (по грн. + по валюте номиналы)
CURSOR OBOROTYN IS
   SELECT /* + INDEX(L XIE_K040_KL_K040) INDEX (C XPK_CUSTOMER) */
          a.acc, a.nls, a.kv, a.daos, a.dazs, a.nbs,
          SUM(s.dos), SUM(s.kos),
          DECODE(trim(p.s180), NULL, FS180(a.acc), p.s180),
          acrn.FPROC(a.acc, Dat_), a.tobo, a.nms, NVL(trim(sp.ob22),'00')
   FROM saldoa s, accounts a, customer c, sb_r020 k,
        specparam p, specparam_int sp
   WHERE a.nbs=k.r020                  AND
         trim(k.f_17) is not null      AND
         s.fdat between Dat1_ AND Dat_ AND
         a.acc=s.acc                   AND
         a.rnk=c.rnk                   AND
         a.acc=p.acc(+)                AND
         a.acc=sp.acc(+)
   GROUP BY a.acc, a.nls, a.kv, a.daos, a.dazs, a.nbs,
            DECODE(trim(p.s180), NULL, FS180(a.acc), p.s180),
            acrn.FPROC(a.acc, Dat_), a.tobo, a.nms, sp.ob22;

---Обороты (по валюте эквиваленты)
CURSOR OBOROTYQ IS
   SELECT a.acc, a.nls, a.kv, a.daos, a.dazs, a.nbs,
          SUM(s.dos), SUM(s.kos),
          DECODE(trim(p.s180), NULL, FS180(a.acc), p.s180),
          acrn.FPROC(a.acc, Dat_), a.tobo, a.nms, NVL(trim(sp.ob22),'00')
   FROM saldob s, accounts a, customer c, sb_r020 k,
        specparam p, specparam_int sp
   WHERE a.nbs=k.r020                  AND
         trim(k.f_17) is not null      AND
         s.fdat between Dat1_ AND Dat_ AND
         a.acc=s.acc                   AND
         a.rnk=c.rnk                   AND
         a.acc=p.acc(+)                AND
         a.acc=sp.acc(+)
   GROUP BY a.acc, a.nls, a.kv, a.daos, a.dazs, a.nbs,
            DECODE(trim(p.s180), NULL, FS180(a.acc), p.s180),
            acrn.FPROC(a.acc, Dat_), a.tobo, a.nms, sp.ob22;

--- Корректирующие проводки для счетов отсутствующих в конце месяца ---
CURSOR SaldoAOstfk IS
   SELECT s.acc, s.nls, s.kv, s.daos, s.dazs, s.nbs,
          SUM(DECODE(a.dk, 0, a.s, 0)),
---          SUM(DECODE(a.dk, 0, GL.P_ICURVAL(s.kv, a.s, Dat_), 0)),
          SUM(DECODE(a.dk, 1, a.s, 0)),
---          SUM(DECODE(a.dk, 1, GL.P_ICURVAL(s.kv, a.s, Dat_), 0))
         s.tobo, s.nms
   FROM  kor_prov a, accounts s, customer c, sb_r020 k,
         specparam p
   WHERE s.nbs=k.r020                  AND
         trim(k.f_17) is not null      AND
         a.fdat between Dat_ AND Dat2_ AND
         a.acc=s.acc                   AND
         s.daos > Dat_                 AND
         s.rnk=c.rnk                   AND
         s.acc=p.acc(+)                AND
         a.vob=96
   GROUP BY s.acc, s.nls, s.kv, s.daos, s.dazs, s.nbs, s.tobo, s.nms ;

CURSOR BaseL IS
    SELECT a.kodp, b.kodp, SUM(TO_NUMBER(a.znap)),
           SUM(TO_NUMBER(a.znap)*TO_NUMBER(b.znap))
    FROM rnbu_trace a, rnbu_trace b
    WHERE SUBSTR(a.kodp,2,13)=SUBSTR(b.kodp,2,13) AND
          SUBSTR(a.kodp,1,1)='1'            AND
          SUBSTR(b.kodp,1,1)='3'            AND
          a.nls = b.nls                     AND
          TO_NUMBER(b.znap)>=0              AND
          a.userid = userid_                AND
          b.userid = userid_                AND
          a.recid = b.recid-1               AND
--          a.nbuc = b.nbuc	            and
	  a.ODATE = b.ODATE
    GROUP BY a.kodp, b.kodp;

CURSOR BaseL1 IS
    SELECT kodp, SUM (znap)
    FROM rnbu_trace
    WHERE substr(kodp,1,1)='2' and userid=userid_
    GROUP BY kodp;

BEGIN
-------------------------------------------------------------------
--SELECT id INTO userid_ FROM staff WHERE upper(logname)=upper(USER);
userid_ := user_id;
--DELETE FROM RNBU_TRACE WHERE userid = userid_;
EXECUTE IMMEDIATE 'TRUNCATE TABLE RNBU_TRACE';
-------------------------------------------------------------------
Dat1_ := TRUNC(Dat_, 'MM');
---Dat1_:=TO_DATE('17-11-2000','DD-MM-YYYY');
Dat2_ := TRUNC(Dat_ + 28);

--------------------- Корректирующие проводки ---------------------
---TRUNCATE TABLE kor_prov ;
DELETE FROM ref_kor ;
IF to_char(Dat_,'MM')='12' THEN
   INSERT INTO ref_kor (REF, VOB, VDAT)
   SELECT ref, vob, vdat
   FROM oper
   WHERE (vob=96 OR vob=99) and not (((substr(nlsa,1,1)='6' or substr(nlsa,1,1)='7')
          and substr(nlsb,1,4)='5040') or (substr(nlsa,1,4)='5040' and
          (substr(nlsb,1,1)='6' or substr(nlsb,1,1)='7'))) ;
ELSE
   INSERT INTO ref_kor (REF, VOB, VDAT)
   SELECT ref, vob, vdat
   FROM oper
   WHERE vob=96 OR vob=99 ;
END IF ;


DELETE FROM kor_prov ;
INSERT INTO KOR_PROV (REF,  DK,  ACC , S,  FDAT , VDAT, SOS,  VOB)
SELECT o.ref, o.dk, o.acc, o.s, o.fdat, p.vdat, o.sos, p.vob
FROM opldok o, ref_kor p     --- oper p
WHERE o.fdat>Dat1_     AND
      o.fdat<=Dat2_    AND
      o.ref=p.ref      AND
      o.sos=5 ;
---where o.ref=p.ref and p.vob>95 and o.sos=5;
-------------------------------------------------------------------
-- Остатки (грн. + валюта номиналы) --
OPEN SaldoBN;
LOOP
   FETCH SaldoBN INTO acc_, nls_, kv_, data_, dazs_, Nbs_, Ostn_,
                             s180_, sPCnt_, tobo_, nms_, ob22_; --- Oste_ ;
   EXIT WHEN SaldoBN%NOTFOUND;

   comm_ := '';

   --BEGIN
   --   SELECT NVL(ob22,'00') INTO ob22_ FROM specparam_int
   --   WHERE acc=acc_;
   --EXCEPTION WHEN NO_DATA_FOUND THEN
   --   ob22_:='00';
   --END;

   if data_ < dat1_ and dazs_ is null then
      s_:= '1';
   end if;
   if data_ >= dat1_ and data_ <= dat_ and dazs_ is null then
      s_:= '0';
   end if;
   if dazs_ is not null and dazs_ >= dat1_ and dazs_ <= dat_ then
      s_:= '3';
   end if;

--- отбор корректирующих проводок отчетного месяца
      BEGIN
         SELECT d.acc,
            SUM(DECODE(d.dk, 0, d.s, 0)),
---            SUM(DECODE(d.dk, 0, GL.P_ICURVAL(kv_, d.s, Dat_), 0)),
            SUM(DECODE(d.dk, 1, d.s, 0))
---            SUM(DECODE(d.dk, 1, GL.P_ICURVAL(kv_, d.s, Dat_), 0))
---       INTO acc1_, Dosnk_, Dosek_, Kosnk_, Kosek_
         INTO acc1_, Dosnk_, Kosnk_
         FROM  kor_prov d
         WHERE d.acc=acc_                      AND
               d.fdat between Dat_+1 AND Dat2_ AND
               d.vob = 96
         GROUP BY d.acc ;
      EXCEPTION WHEN NO_DATA_FOUND THEN
         Dosnk_ :=0 ;
---         Dosek_ :=0 ;
         Kosnk_ :=0 ;
---         Kosek_ :=0 ;
      END ;

      comm_ := substr(comm_ || tobo_ || '  ' || nms_, 1, 200);

      IF Dosnk_ > 0 THEN
         IF Kv_=980 THEN
            tp_:='70' ;
         ELSE
            tp_:='71' ;
         END IF ;
         kodp_:='1' || tp_ || Nbs_ || ob22_ ||s180_ || SUBSTR(to_char(1000+Kv_),2,3) || s_;
         znap_:=TO_CHAR(Dosnk_);
         INSERT INTO rnbu_trace         -- Дб. обороты в номинале валюты
                 (nls, kv, odate, kodp, znap, acc, comm, tobo)
         VALUES  (nls_, kv_, data_, kodp_, znap_, acc_, comm_, tobo_);

         kodp_:='3' || tp_ || Nbs_ || ob22_ || s180_ || SUBSTR(to_char(1000+Kv_),2,3) || s_;
         znap_:=TO_CHAR(sPCnt_);
         INSERT INTO rnbu_trace         -- %% ставка
                 (nls, kv, odate, kodp, znap, acc, comm, tobo)
         VALUES  (nls_, kv_, data_, kodp_, znap_, acc_, comm_, tobo_);

         kodp_:='2' || tp_ || Nbs_ || ob22_ ||s180_ || SUBSTR(to_char(1000+Kv_),2,3) || s_;
         znap_:='1';
         INSERT INTO rnbu_trace         -- К?льк?сть
                 (nls, kv, odate, kodp, znap, acc, comm, tobo)
         VALUES  (nls_, kv_, data_, kodp_, znap_, acc_, comm_, tobo_);

      END IF;

      IF Kosnk_ > 0 THEN
         IF Kv_=980 THEN
            tp_:='80' ;
         ELSE
            tp_:='81' ;
         END IF ;
         kodp_:='1' || tp_ || Nbs_ || ob22_ || s180_ || SUBSTR(to_char(1000+Kv_),2,3) || s_ ;
         znap_:=TO_CHAR(Kosnk_);
         INSERT INTO rnbu_trace         -- Кр. обороты в номинале валюты
                 (nls, kv, odate, kodp, znap, acc, comm, tobo)
         VALUES  (nls_, kv_, data_, kodp_, znap_, acc_, comm_, tobo_);

         kodp_:='3' || tp_ || Nbs_ || ob22_ || s180_ || SUBSTR(to_char(1000+Kv_),2,3) || s_ ;
         znap_:=TO_CHAR(sPCnt_);
         INSERT INTO rnbu_trace         -- %% ставка
                 (nls, kv, odate, kodp, znap, acc, comm, tobo)
         VALUES  (nls_, kv_, data_, kodp_, znap_, acc_, comm_, tobo_);

         kodp_:='2' || tp_ || Nbs_ || ob22_ || s180_ || SUBSTR(to_char(1000+Kv_),2,3) || s_ ;
         znap_:='1';
         INSERT INTO rnbu_trace         -- К?льк?сть
                 (nls, kv, odate, kodp, znap, acc, comm, tobo)
         VALUES  (nls_, kv_, data_, kodp_, znap_, acc_, comm_, tobo_);

      END IF;

      Ostn_:=Ostn_-Dosnk_+Kosnk_ ;

      IF Ostn_<>0 THEN
         dk_:=IIF_N(Ostn_,0,'1','2','2');
         IF Kv_=980 THEN
            tp_:=dk_ || '0' ;
         ELSE
            tp_:=dk_ || '1' ;
         END IF ;

         kodp_:='1' || tp_ || Nbs_ || ob22_ || s180_ || SUBSTR(to_char(1000+Kv_),2,3) || s_ ;
         znap_:=TO_CHAR(ABS(Ostn_));

         INSERT INTO rnbu_trace         -- Остатки в номинале валюты
                 (nls, kv, odate, kodp, znap, acc, comm, tobo)
         VALUES  (nls_, kv_, data_, kodp_, znap_, acc_, comm_, tobo_) ;

         kodp_:='3' || tp_ || Nbs_ || ob22_ || s180_ || SUBSTR(to_char(1000+Kv_),2,3) || s_ ;
         znap_:=TO_CHAR(sPCnt_);

         INSERT INTO rnbu_trace         -- %% ставка
                 (nls, kv, odate, kodp, znap, acc, comm, tobo)
         VALUES  (nls_, kv_, data_, kodp_, znap_, acc_, comm_, tobo_) ;

         kodp_:='2' || tp_ || Nbs_ || ob22_ || s180_ || SUBSTR(to_char(1000+Kv_),2,3) || s_ ;
         znap_:='1';

         INSERT INTO rnbu_trace         -- К?льк?сть
                 (nls, kv, odate, kodp, znap, acc, comm, tobo)
         VALUES  (nls_, kv_, data_, kodp_, znap_, acc_, comm_, tobo_) ;

      END IF;
END LOOP;
CLOSE SaldoBN;
--------------------------------------------------------------------
-- Остатки (валюта эквиваленты) --
OPEN SaldoBQ;
LOOP
    FETCH SaldoBQ INTO acc_, nls_, kv_, data_, dazs_, Nbs_, Ostn_,
                       s180_, sPCnt_, tobo_, nms_, ob22_ ; --- Oste_ ;
    EXIT WHEN SaldoBQ%NOTFOUND;

   comm_ := '';

   --BEGIN
   --   SELECT NVL(ob22,'00') INTO ob22_ FROM specparam_int
   --   WHERE acc=acc_;
   --EXCEPTION WHEN NO_DATA_FOUND THEN
   --   ob22_:='00';
   --END;

   if data_ < dat1_ and dazs_ is null then
      s_:= '1';
   end if;
   if data_ >= dat1_ and data_ <= dat_ and dazs_ is null then
      s_:= '0';
   end if;
   if dazs_ is not null and dazs_ >= dat1_ and dazs_ <= dat_ then
      s_:= '3';
   end if;

    s0000_:= '0' ;
    s0009_:= '0' ;

--- отбор корректирующих проводок отчетного месяца
    BEGIN
       SELECT d.acc,
---          SUM(DECODE(d.dk, 0, d.s, 0)),
          SUM(DECODE(d.dk, 0, GL.P_ICURVAL(kv_, d.s, Dat_), 0)),
---          SUM(DECODE(d.dk, 1, d.s, 0)),
          SUM(DECODE(d.dk, 1, GL.P_ICURVAL(kv_, d.s, Dat_), 0))
---       INTO acc1_, data1_, Dosnk_, Dosek_, Kosnk_, Kosek_
       INTO acc1_, Dosek_, Kosek_
       FROM  kor_prov d
       WHERE d.acc=acc_                      AND
             d.fdat between Dat_+1 AND Dat2_ AND
             d.vob = 96
       GROUP BY d.acc ;
    EXCEPTION WHEN NO_DATA_FOUND THEN
---       Dosnk_ :=0 ;
       Dosek_ :=0 ;
---       Kosnk_ :=0 ;
       Kosek_ :=0 ;
    END ;

    comm_ := substr(comm_ || tobo_ || '  ' || nms_, 1, 200);

    IF Dosek_ > 0 THEN
       kodp_:='1' || '70' || Nbs_ || ob22_ || s180_ || SUBSTR(to_char(1000+Kv_),2,3) || s_;
       znap_:=TO_CHAR(Dosek_);

       INSERT INTO rnbu_trace         -- Дб. обороты в экиваленте валюты
               (nls, kv, odate, kodp, znap, acc, comm, tobo)
       VALUES  (nls_, kv_, data_, kodp_, znap_, acc_, comm_, tobo_);

       kodp_:='3' || '70' || Nbs_ || ob22_ || s180_ || SUBSTR(to_char(1000+Kv_),2,3) || s_;
       znap_:=TO_CHAR(sPCnt_);

       INSERT INTO rnbu_trace         -- %% ставка
               (nls, kv, odate, kodp, znap, acc, comm, tobo)
       VALUES  (nls_, kv_, data_, kodp_, znap_, acc_, comm_, tobo_);

       kodp_:='2' || '70' || Nbs_ || ob22_ || s180_ || SUBSTR(to_char(1000+Kv_),2,3) || s_;
       znap_:='1';

       INSERT INTO rnbu_trace         -- К?льк?сть
               (nls, kv, odate, kodp, znap, acc, comm, tobo)
       VALUES  (nls_, kv_, data_, kodp_, znap_, acc_, comm_, tobo_);

    END IF;

    IF Kosek_ > 0 THEN
       kodp_:='1' || '80' || Nbs_ || ob22_ || s180_ || SUBSTR(to_char(1000+Kv_),2,3) || s_;
       znap_:=TO_CHAR(Kosek_);

       INSERT INTO rnbu_trace         -- Кр. обороты в эквиваленте валюты
               (nls, kv, odate, kodp, znap, acc, comm, tobo)
       VALUES  (nls_, kv_, data_, kodp_, znap_, acc_, comm_, tobo_) ;

       kodp_:='3' || '80' || Nbs_ || ob22_ || s180_ || SUBSTR(to_char(1000+Kv_),2,3) || s_;
       znap_:=TO_CHAR(sPCnt_);

       INSERT INTO rnbu_trace         -- %% ставка
               (nls, kv, odate, kodp, znap, acc, comm, tobo)
       VALUES  (nls_, kv_, data_, kodp_, znap_, acc_, comm_, tobo_);

       kodp_:='2' || '80' || Nbs_ || ob22_ || s180_ || SUBSTR(to_char(1000+Kv_),2,3) || s_;
       znap_:='1';

       INSERT INTO rnbu_trace         -- К?льк?сть
               (nls, kv, odate, kodp, znap, acc, comm, tobo)
       VALUES  (nls_, kv_, data_, kodp_, znap_, acc_, comm_, tobo_);

    END IF;

    Ostn_:=Ostn_-Dosek_+Kosek_ ;

    IF Ostn_<>0 THEN
       BEGIN
          SELECT s0000, s0009 INTO s0000_, s0009_
          FROM tabval WHERE kv=kv_ and (s0000=nls_ or s0009=nls_) ;
       EXCEPTION WHEN NO_DATA_FOUND THEN
          s0000_ := '0' ;
          s0009_ := '0' ;
       END ;

       dk_:=IIF_N(Ostn_,0,'1','2','2');
       IF s0000_ <> '0' or s0009_ <> '0' THEN
          kodp_:='1' || dk_ || '0' || nbs_ || ob22_ || s180_ || '980' || s_ ;
       ELSE
          kodp_:='1' || dk_ || '0' || nbs_ || ob22_ || s180_ ||
                 SUBSTR( to_char(1000+kv_),2,3) || s_ ;
       END IF ;

       znap_:=TO_CHAR(ABS(Ostn_));
       INSERT INTO rnbu_trace         -- Остатки в эквиваленте валюты
               (nls, kv, odate, kodp, znap, acc, comm, tobo)
       VALUES  (nls_, kv_, data_, kodp_, znap_, acc_, comm_, tobo_) ;

       kodp1_:='3' || substr(kodp_,2,12) || s_;
       znap_:=TO_CHAR(sPCnt_);

       INSERT INTO rnbu_trace         -- %% ставка
               (nls, kv, odate, kodp, znap, acc, comm, tobo)
       VALUES  (nls_, kv_, data_, kodp1_, znap_, acc_, comm_, tobo_);

       kodp1_:='2' || substr(kodp_,2,12) || s_;
       znap_:='1';

       INSERT INTO rnbu_trace         -- К?льк?сть
               (nls, kv, odate, kodp, znap, acc, comm, tobo)
       VALUES  (nls_, kv_, data_, kodp1_, znap_, acc_, comm_, tobo_);

    END IF;
END LOOP;
CLOSE SaldoBQ;
-----------------------------------------------------------------------------
--- Остатки сформиров. по корр.проводкам для сч. отсутств. в конце месяца ---
--OPEN SaldoAOstfk;
--   LOOP
--   FETCH SaldoAOstfk INTO acc_, nls_, kv_, data_, Nbs_, k041_, Dosn_, Kosn_ ; --- Dose_,Kose_
--   EXIT WHEN SaldoAOstfk%NOTFOUND;

--   BEGIN
--      SELECT NVL(ob22,'00') INTO ob22_ FROM specparam_int
--      WHERE acc=acc_;
--   EXCEPTION WHEN NO_DATA_FOUND THEN
--      ob22_:='00';
--   END;

--   f17_:=1;
-----   SELECT count(*) INTO f17_ FROM sb_r020 WHERE r020=nbs_ AND f_17='1' ;

--IF f17_ > 0 THEN
--   Ostn_:=Kosn_-Dosn_ ;
-----   Oste_:=Kose_-Dose_ ;
--   IF kv_ <> 980 THEN
--      Oste_ := GL.P_ICURVAL(kv_, Ostn_, Dat_) ;
--      Dose_ := GL.P_ICURVAL(kv_, Dosn_, Dat_) ;
--      Kose_ := GL.P_ICURVAL(kv_, Kosn_, Dat_) ;
--   ELSE
--      Oste_ := Ostn_ ;
--      Dose_ := Dosn_ ;
--      Kose_ := Kosn_ ;
--   END IF ;

--   IF Ostn_<>0 THEN
--      dk_:=IIF_N(Ostn_,0,'1','2','2');
--      kodp_:=dk_ || '0' || Nbs_ || ob22_ || SUBSTR(to_char(1000+Kv_),2,3) || k041_ ;
--      znap_:=TO_CHAR(ABS(Oste_));

--      INSERT INTO rnbu_trace         -- Остатки грн. + экв. валюты
--              (nls, kv, odate, kodp, znap)
--      VALUES  (nls_, kv_, data_, kodp_, znap_) ;

--      IF Kv_<>980 THEN
--         kodp_:=dk_ || '1' || Nbs_ || ob22_ || SUBSTR(to_char(1000+Kv_),2,3) || k041_ ;
--         znap_:=TO_CHAR(ABS(Ostn_));
--         INSERT INTO rnbu_trace         -- Остатки в номинале валюты
--                 (nls, kv, odate, kodp, znap)
--         VALUES  (nls_, kv_, data_, kodp_, znap_) ;
--     END IF;
--   END IF;
--   IF Dosn_<>0 THEN
--      dk_:='7';
--      kodp_:=dk_ || '0' || Nbs_ || ob22_ || SUBSTR(to_char(1000+Kv_),2,3) || k041_ ;
--      znap_:=TO_CHAR(ABS(Dose_));

--      INSERT INTO rnbu_trace         -- Дт обороты в эквиваленте валюты
--              (nls, kv, odate, kodp, znap)
--      VALUES  (nls_, kv_, data_, kodp_, znap_) ;

--      IF Kv_<>980 THEN
--         kodp_:=dk_ || '1' || Nbs_ || ob22_ || SUBSTR(to_char(1000+Kv_),2,3) || k041_ ;
--         znap_:=TO_CHAR(ABS(Dosn_));

--         INSERT INTO rnbu_trace         -- Дт обороты в номинале
--                (nls, kv, odate, kodp, znap)
--         VALUES  (nls_, kv_, data_, kodp_, znap_) ;
--      END IF;
--   END IF;

--   IF Kosn_<>0 THEN
--      dk_:='8';
--      kodp_:=dk_ || '0' || Nbs_ || ob22_ || SUBSTR(to_char(1000+Kv_),2,3) || k041_ ;
--      znap_:=TO_CHAR(ABS(Kose_));
--      INSERT INTO rnbu_trace         -- Кт обороты в эквиваленте валюты
--              (nls, kv, odate, kodp, znap)
--      VALUES  (nls_, kv_, data_, kodp_, znap_) ;

--      IF Kv_<>980 THEN
--         kodp_:=dk_ || '1' || Nbs_ || ob22_ || SUBSTR(to_char(1000+Kv_),2,3) || k041_ ;
--         znap_:=TO_CHAR(ABS(Kosn_));

--         INSERT INTO rnbu_trace         -- Кт обороты в номинале
--                 (nls, kv, odate, kodp, znap)
--         VALUES  (nls_, kv_, data_, kodp_, znap_) ;
--      END IF;
--   END IF;
--END IF;
--END LOOP;
--CLOSE SaldoAOstfk;
-----------------------------------------------------------------------------
-- Обороты текущие (грн. + вал. номиналы ) --
OPEN OBOROTYN;
LOOP
    FETCH OBOROTYN INTO acc_, nls_, kv_, data_, dazs_, Nbs_, Dosn_, Kosn_,
                            s180_, sPCnt_, tobo_, nms_, ob22_ ; --- Dose_, Kose_ ;
    EXIT WHEN OBOROTYN%NOTFOUND;

    comm_ := '';

    --BEGIN
    --  SELECT NVL(ob22,'00') INTO ob22_ FROM specparam_int
    --  WHERE acc=acc_;
    --EXCEPTION WHEN NO_DATA_FOUND THEN
    --  ob22_:='00';
    --END;

   if data_ < dat1_ and dazs_ is null then
      s_:= '1';
   end if;
   if data_ >= dat1_ and data_ <= dat_ and dazs_ is null then
      s_:= '0';
   end if;
   if dazs_ is not null and dazs_ >= dat1_ and dazs_ <= dat_ then
      s_:= '3';
   end if;

--- отбор корректирующих проводок месяца предшествующего отчетному
    BEGIN
       SELECT a.acc,
           SUM(DECODE(a.dk, 0, a.s, 0)),
---           SUM(DECODE(a.dk, 0, GL.P_ICURVAL(kv_, a.s, Dat_), 0)),
           SUM(DECODE(a.dk, 1, a.s, 0))
---           SUM(DECODE(a.dk, 1, GL.P_ICURVAL(kv_, a.s, Dat_), 0))
---       INTO acc1_, Dosnk_, Dosek_, Kosnk_, Kosek_
       INTO acc1_, Dosnk_, Kosnk_
       FROM kor_prov a
       WHERE a.acc=acc_                   AND
             a.fdat > Dat1_               AND
             a.fdat <= Dat_               AND
             a.vob=96
       GROUP BY a.acc ;
    EXCEPTION WHEN NO_DATA_FOUND THEN
       Dosnk_ :=0 ;
---       Dosek_ :=0 ;
       Kosnk_ :=0 ;
---       Kosek_ :=0 ;
    END ;

--- отбор годовых корректирующих проводок
   BEGIN
       SELECT a.acc,
           SUM(DECODE(a.dk, 0, a.s, 0)),
---           SUM(DECODE(a.dk, 0, GL.P_ICURVAL(kv_, a.s, Dat_), 0)),
           SUM(DECODE(a.dk, 1, a.s, 0))
---           SUM(DECODE(a.dk, 1, GL.P_ICURVAL(kv_, a.s, Dat_), 0))
---       INTO acc2_, Dosnkg_, Dosekg_, Kosnkg_, Kosekg_
       INTO acc2_, Dosnkg_, Kosnkg_
       FROM kor_prov a
       WHERE a.acc=acc_                   AND
             a.fdat > Dat1_               AND
             a.fdat <= Dat_               AND
             a.vob=99
       GROUP BY a.acc ;
   EXCEPTION WHEN NO_DATA_FOUND THEN
       Dosnkg_ :=0 ;
---       Dosekg_ :=0 ;
       Kosnkg_ :=0 ;
---       Kosekg_ :=0 ;
   END ;

   Dosn_ := Dosn_-Dosnk_-Dosnkg_ ;
   Kosn_ := Kosn_-Kosnk_-Kosnkg_ ;
---   Dose_ := Dose_-Dosek_-Dosekg_ ;
---   Kose_ := Kose_-Kosek_-Kosekg_ ;
   comm_ := substr(comm_ || tobo_ || '  ' || nms_, 1, 200);

--- Годовые корректирующие обороты
   IF Dosnkg_ > 0 OR Kosnkg_ > 0 THEN
      IF Dosnkg_ > 0 THEN
         IF Kv_=980 THEN
            kodp_:='1' || '90' || Nbs_ || ob22_ || s180_ ||
                   SUBSTR(to_char(1000+Kv_),2,3) || s_ ;
         ELSE
            kodp_:='1' || '91' || Nbs_ || ob22_ || s180_ ||
                   SUBSTR(to_char(1000+Kv_),2,3) || s_ ;
         END IF ;
         znap_:=TO_CHAR(Dosnkg_) ;
         INSERT INTO rnbu_trace    -- Кор.Год.Дб. обороты в номинале (грн.+вал.)
                 (nls, kv, odate, kodp, znap, acc, comm, tobo) VALUES
                 (nls_, kv_, dat_, kodp_ , znap_, acc_, comm_, tobo_);

         kodp1_:='3' || substr(kodp_,2,12) || s_ ;
         znap_:=to_char(sPCnt_) ;
         INSERT INTO rnbu_trace    -- %% ставка
                 (nls, kv, odate, kodp, znap, acc, comm, tobo) VALUES
                 (nls_, kv_, dat_, kodp1_ , znap_, acc_, comm_, tobo_);

         kodp1_:='2' || substr(kodp_,2,12) || s_ ;
         znap_:='1' ;
         INSERT INTO rnbu_trace    -- К?льк?сть
                 (nls, kv, odate, kodp, znap, acc, comm, tobo) VALUES
                 (nls_, kv_, dat_, kodp1_ , znap_, acc_, comm_, tobo_);

      END IF;

      IF Kosnkg_ > 0 THEN
         IF Kv_=980 THEN
            kodp_:='1' || '00' || Nbs_ || ob22_ || s180_ ||
                   SUBSTR(to_char(1000+Kv_),2,3) || s_;
         ELSE
            kodp_:='1' || '01' || Nbs_ || ob22_ || s180_ ||
                   SUBSTR(to_char(1000+Kv_),2,3) || s_;
         END IF ;
         znap_:=TO_CHAR(Kosnkg_);

         INSERT INTO rnbu_trace    -- Кор.Год.Кр. обороты в номинале (грн.+вал.)
                 (nls, kv, odate, kodp, znap, acc, comm, tobo) VALUES
                 (nls_, kv_, dat_, kodp_,  znap_, acc_, comm_, tobo_) ;

         kodp1_:='3' || substr(kodp_,2,12) || s_ ;
         znap_:=to_char(sPCnt_) ;
         INSERT INTO rnbu_trace    -- %% ставка
                 (nls, kv, odate, kodp, znap, acc, comm, tobo) VALUES
                 (nls_, kv_, dat_, kodp1_ , znap_, acc_, comm_, tobo_);

         kodp1_:='2' || substr(kodp_,2,12) || s_ ;
         znap_:='1' ;
         INSERT INTO rnbu_trace    -- К?льк?сть
                 (nls, kv, odate, kodp, znap, acc, comm, tobo) VALUES
                 (nls_, kv_, dat_, kodp1_ , znap_, acc_, comm_, tobo_);
      END IF;
   END IF;

   IF Dosn_ > 0 OR Kosn_ > 0 THEN
     IF SUBSTR(nls_,1,4)='3929' AND Kv_=980 THEN
         IF Dosn_=Kosn_ THEN
            Dosn_:=0;
            Kosn_:=0;
         END IF;
         IF Dosn_ > Kosn_ THEN
            Dosn_:=Dosn_-Kosn_ ;
            Kosn_:=0;
         END IF;
         IF Dosn_ < Kosn_ THEN
            Kosn_:=Kosn_-Dosn_ ;
            Dosn_:=0;
         END IF;
      END IF;
      IF Dosn_ > 0 THEN
         IF Kv_=980 THEN
            kodp_:='1' || '50' || Nbs_ || ob22_ || s180_ ||
                   SUBSTR(to_char(1000+Kv_),2,3) || s_;
         ELSE
            kodp_:='1' || '51' || Nbs_ || ob22_ || s180_ ||
                   SUBSTR(to_char(1000+Kv_),2,3) || s_;
         END IF ;
         znap_:=TO_CHAR(Dosn_);
         INSERT INTO rnbu_trace     -- Дб. обороты в номинале валюты (грн.+вал.)
                 (nls, kv, odate, kodp, znap, acc, comm, tobo)
         VALUES  (nls_, kv_, dat_, kodp_, znap_, acc_, comm_, tobo_) ;

         kodp1_:='3' || substr(kodp_,2,12) || s_ ;
         znap_:=to_char(sPCnt_) ;
         INSERT INTO rnbu_trace    -- %% ставка
                 (nls, kv, odate, kodp, znap, acc, comm, tobo) VALUES
                 (nls_, kv_, dat_, kodp1_ , znap_, acc_, comm_, tobo_);

         kodp1_:='2' || substr(kodp_,2,12) || s_ ;
         znap_:='1' ;
         INSERT INTO rnbu_trace    -- К?льк?сть
                 (nls, kv, odate, kodp, znap, acc, comm, tobo) VALUES
                 (nls_, kv_, dat_, kodp1_ , znap_, acc_, comm_, tobo_);

      END IF;

      IF Kosn_ > 0 THEN
         IF Kv_=980 THEN
            kodp_:='1' || '60' || Nbs_ || ob22_ || s180_ ||
                   SUBSTR(to_char(1000+Kv_),2,3) || s_;
         ELSE
            kodp_:='1' || '61' || Nbs_ || ob22_ || s180_ ||
                   SUBSTR(to_char(1000+Kv_),2,3) || s_;
         END IF ;
         znap_:=TO_CHAR(Kosn_) ;
         INSERT INTO rnbu_trace     -- Кр. обороты в номинале валюты (грн.+вал.)
                 (nls, kv, odate, kodp, znap, acc, comm, tobo)
         VALUES  (nls_, kv_, dat_, kodp_, znap_, acc_, comm_, tobo_) ;

         kodp1_:='3' || substr(kodp_,2,12) || s_ ;
         znap_:=to_char(sPCnt_) ;
         INSERT INTO rnbu_trace    -- %% ставка
                 (nls, kv, odate, kodp, znap, acc, comm, tobo) VALUES
                 (nls_, kv_, dat_, kodp1_ , znap_, acc_, comm_, tobo_);

         kodp1_:='2' || substr(kodp_,2,12) || s_ ;
         znap_:='1' ;
         INSERT INTO rnbu_trace    -- К?льк?сть
                 (nls, kv, odate, kodp, znap, acc, comm, tobo) VALUES
                 (nls_, kv_, dat_, kodp1_ , znap_, acc_, comm_, tobo_);

      END IF;
   END IF;
END LOOP;
CLOSE OBOROTYN;
-------------------------------------------------------------------------
---- Обороты текущие (вал. эквиваленты ) --
OPEN OBOROTYQ;
LOOP
    FETCH OBOROTYQ INTO acc_, nls_, kv_, data_, dazs_, nbs_, Dose_, Kose_,
                         s180_, sPCnt_, tobo_, nms_, ob22_;---Dosn_, Kosn_
    EXIT WHEN OBOROTYQ%NOTFOUND;

    comm_ := '';

    --BEGIN
    --   SELECT NVL(ob22,'00') INTO ob22_ FROM specparam_int
    --   WHERE acc=acc_;
    --EXCEPTION WHEN NO_DATA_FOUND THEN
    --   ob22_:='00';
    --END;

    if data_ < dat1_ and dazs_ is null then
       s_:= '1';
    end if;
    if data_ >= dat1_ and data_ <= dat_ and dazs_ is null then
       s_:= '0';
    end if;
    if dazs_ is not null and dazs_ >= dat1_ and dazs_ <= dat_ then
       s_:= '3';
    end if;

    s0000_:='0' ;
    s0009_:='0' ;

--- отбор корректирующих проводок месяца предшествующего отчетному
    BEGIN
       SELECT a.acc,
---           SUM(DECODE(a.dk, 0, a.s, 0)),
           SUM(DECODE(a.dk, 0, GL.P_ICURVAL(kv_, a.s, a.vDat), 0)),
---           SUM(DECODE(a.dk, 1, a.s, 0)),
           SUM(DECODE(a.dk, 1, GL.P_ICURVAL(kv_, a.s, a.vDat), 0))
---       INTO acc1_, Dosnk_, Dosek_, Kosnk_, Kosek_
       INTO acc1_, Dosek_, Kosek_
       FROM kor_prov a
       WHERE a.acc=acc_                   AND
             a.fdat > Dat1_               AND
             a.fdat <= Dat_               AND
             a.vob=96
       GROUP BY a.acc ;
    EXCEPTION WHEN NO_DATA_FOUND THEN
---       Dosnk_ :=0 ;
       Dosek_ :=0 ;
---       Kosnk_ :=0 ;
       Kosek_ :=0 ;
    END ;

--- отбор годовых корректирующих проводок
   BEGIN
       SELECT a.acc,
---           SUM(DECODE(a.dk, 0, a.s, 0)),
           SUM(DECODE(a.dk, 0, GL.P_ICURVAL(kv_, a.s, a.vDat), 0)),
---           SUM(DECODE(a.dk, 1, a.s, 0)),
           SUM(DECODE(a.dk, 1, GL.P_ICURVAL(kv_, a.s, a.vDat), 0))
---       INTO acc2_, Dosnkg_, Dosekg_, Kosnkg_, Kosekg_
       INTO acc2_, Dosekg_, Kosekg_
       FROM kor_prov a
       WHERE a.acc=acc_                   AND
             a.fdat > Dat1_               AND
            a.fdat <= Dat_               AND
             a.vob=99
       GROUP BY a.acc ;
   EXCEPTION WHEN NO_DATA_FOUND THEN
---       Dosnkg_ :=0 ;
       Dosekg_ :=0 ;
---       Kosnkg_ :=0 ;
       Kosekg_ :=0 ;
   END ;

---   Dosn_ := Dosn_-Dosnk_-Dosnkg_ ;
---   Kosn_ := Kosn_-Kosnk_-Kosnkg_ ;
   Dose_ := Dose_-Dosek_-Dosekg_ ;
   Kose_ := Kose_-Kosek_-Kosekg_ ;

   comm_ := substr(comm_ || tobo_ || '  ' || nms_, 1, 200);

   IF Kose_ < 0 THEN
      Dose_ := Dose_ + ABS(Kose_);
   END IF ;

   IF Dose_ < 0 THEN
      Kose_ := Kose_ + ABS(Dose_);
   END IF ;

--- Годовые корректирующие обороты
   IF Dosekg_ > 0 OR Kosekg_ > 0 THEN
      IF Dosekg_ > 0 THEN
         kodp_:='1' || '90' || Nbs_ || ob22_ || s180_ ||
                SUBSTR(to_char(1000+Kv_),2,3) || s_;
         znap_:=TO_CHAR(Dosekg_) ;

         INSERT INTO rnbu_trace         -- Корр Год. Дб. обороты в эквиваленте валюты
                 (nls, kv, odate, kodp, znap, acc, comm, tobo) VALUES
                 (nls_, kv_, dat_, kodp_, znap_, acc_, comm_, tobo_) ;

         kodp_:='3' || '90' || Nbs_ || ob22_ || s180_ ||
                SUBSTR(to_char(1000+Kv_),2,3) || s_;
         znap_:=TO_CHAR(sPCnt_) ;

         INSERT INTO rnbu_trace         -- %% ставка
                 (nls, kv, odate, kodp, znap, acc, comm, tobo) VALUES
                 (nls_, kv_, dat_, kodp_, znap_, acc_, comm_, tobo_) ;

         kodp_:='2' || '90' || Nbs_ || ob22_ || s180_ ||
                SUBSTR(to_char(1000+Kv_),2,3) || s_;
         znap_:='1' ;

         INSERT INTO rnbu_trace         -- К?льк?сть
                 (nls, kv, odate, kodp, znap, acc, comm, tobo) VALUES
                 (nls_, kv_, dat_, kodp_, znap_, acc_, comm_, tobo_) ;

      END IF;

      IF Kosekg_ > 0 THEN
         kodp_:='1' || '00' || Nbs_ || ob22_ || s180_ ||
                SUBSTR(to_char(1000+Kv_),2,3) || s_;
         znap_:=TO_CHAR(Kosekg_) ;

         INSERT INTO rnbu_trace         -- Корр Год. Кр. обороты в эквиваленте валюты
                 (nls, kv, odate, kodp, znap, acc, comm, tobo) VALUES
                 (nls_, kv_, dat_, kodp_, znap_, acc_, comm_, tobo_) ;

         kodp_:='3' || '00' || Nbs_ || ob22_ || s180_ ||
                SUBSTR(to_char(1000+Kv_),2,3) || s_;
         znap_:=TO_CHAR(sPCnt_) ;

         INSERT INTO rnbu_trace         -- %% ставка
                 (nls, kv, odate, kodp, znap, acc, comm, tobo) VALUES
                 (nls_, kv_, dat_, kodp_, znap_, acc_, comm_, tobo_) ;

         kodp_:='2' || '00' || Nbs_ || ob22_ || s180_ ||
                SUBSTR(to_char(1000+Kv_),2,3) || s_;
         znap_:='1' ;

         INSERT INTO rnbu_trace         -- К?льк?сть
                 (nls, kv, odate, kodp, znap, acc, comm, tobo) VALUES
                 (nls_, kv_, dat_, kodp_, znap_, acc_, comm_, tobo_) ;

      END IF;
   END IF;

   IF Dose_ > 0 OR Kose_ > 0 THEN
      BEGIN
         SELECT s0000, s0009 INTO s0000_, s0009_
         FROM tabval WHERE kv=kv_ and (s0000=nls_ or s0009=nls_) ;
      EXCEPTION WHEN NO_DATA_FOUND THEN
         s0000_ := '0' ;
         s0009_ := '0' ;
      END ;
      IF Dose_ > 0 THEN
         IF s0000_ <> '0' or s0009_ <> '0' THEN
            kodp_:='1' || '50' || nbs_ || ob22_ || s180_ || '980' || s_ ;
         ELSE
            kodp_:='1' || '50' || nbs_ || ob22_ || s180_ ||
                   SUBSTR(to_char(1000+kv_),2,3) || s_ ;
         END IF ;
         znap_:=TO_CHAR(Dose_) ;

         INSERT INTO rnbu_trace         -- Дб. обороты в эквиваленте
                 (nls, kv, odate, kodp, znap, acc, comm, tobo)
         VALUES  (nls_, kv_, dat_, kodp_, znap_, acc_, comm_, tobo_) ;

         kodp1_:='3' || substr(kodp_,2,12) || s_;
         znap_:=TO_CHAR(sPCnt_) ;

         INSERT INTO rnbu_trace         -- %% ставка
                 (nls, kv, odate, kodp, znap, acc, comm, tobo) VALUES
                 (nls_, kv_, dat_, kodp1_, znap_, acc_, comm_, tobo_) ;

         kodp1_:='2' || substr(kodp_,2,12) || s_;
         znap_:='1' ;

         INSERT INTO rnbu_trace         -- К?льк?сть
                 (nls, kv, odate, kodp, znap, acc, comm, tobo) VALUES
                 (nls_, kv_, dat_, kodp1_, znap_, acc_, comm_, tobo_) ;

      END IF;

      IF Kose_ > 0 THEN
         IF s0000_ <> '0' or s0009_ <> '0' THEN
            kodp_:='1' || '60' || nbs_ || ob22_ || s180_ || '980' || s_ ;
         ELSE
            kodp_:='1' || '60' || nbs_ || ob22_ || s180_ ||
                   SUBSTR(to_char(1000+kv_),2,3) || s_ ;
         END IF ;
         znap_:=TO_CHAR(Kose_) ;

         INSERT INTO rnbu_trace         -- Кр. обороты в эквиваленте
                 (nls, kv, odate, kodp, znap, acc, comm, tobo)
         VALUES  (nls_, kv_, dat_, kodp_, znap_, acc_, comm_, tobo_) ;

         kodp1_:='3' || substr(kodp_,2,12) || s_;
         znap_:=TO_CHAR(sPCnt_) ;

         INSERT INTO rnbu_trace         -- %% ставка
                 (nls, kv, odate, kodp, znap, acc, comm, tobo) VALUES
                 (nls_, kv_, dat_, kodp1_, znap_, acc_, comm_, tobo_) ;

         kodp1_:='2' || substr(kodp_,2,12) || s_;
         znap_:='1' ;

         INSERT INTO rnbu_trace         -- К?льк?сть
                 (nls, kv, odate, kodp, znap, acc, comm, tobo) VALUES
                 (nls_, kv_, dat_, kodp1_, znap_, acc_, comm_, tobo_) ;

      END IF;
   END IF;
END LOOP;
CLOSE OBOROTYQ;
---------------------------------------------------
DELETE FROM tmp_irep where kodf='17' and datf= dat_;
---------------------------------------------------
OPEN BaseL;
LOOP
   FETCH BaseL INTO  kodp_, kodp1_, sum0_, sum1_ ;
   EXIT WHEN BaseL%NOTFOUND;

   IF sum0_<>0 then
      -- сумма
      znap_ := TO_CHAR(sum0_);

      INSERT INTO tmp_irep
           (kodf, datf, kodp, znap)
      VALUES
           ('17', Dat_, kodp_, znap_) ;

      --  %% ставка
      znap_ := LTRIM(TO_CHAR(ROUND(sum1_/sum0_,4),fmt_));

      INSERT INTO tmp_irep
           (kodf, datf, kodp, znap)
      VALUES
           ('17', Dat_, kodp1_, znap_) ;
   end if;
END LOOP;
CLOSE BaseL;

OPEN BaseL1;
LOOP
   FETCH BaseL1 INTO  kodp_, znap_;
   EXIT WHEN BaseL1%NOTFOUND;
   INSERT INTO tmp_irep
        (kodf, datf, kodp, znap)
   VALUES
        ('17', Dat_, kodp_, znap_);
END LOOP;
CLOSE BaseL1;
------------------------------------------------------------------
END p_f17sb;
/
show err;

PROMPT *** Create  grants  P_F17SB ***
grant EXECUTE                                                                on P_F17SB         to BARS_ACCESS_DEFROLE;
grant EXECUTE                                                                on P_F17SB         to RPBN002;
grant EXECUTE                                                                on P_F17SB         to WR_ALL_RIGHTS;



PROMPT ===================================================================================== 
PROMPT *** End *** ========== Scripts /Sql/BARS/Procedure/P_F17SB.sql =========*** End *** =
PROMPT ===================================================================================== 
