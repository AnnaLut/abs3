

PROMPT ===================================================================================== 
PROMPT *** Run *** ========== Scripts /Sql/BARS/Procedure/P_F85SB.sql =========*** Run *** =
PROMPT ===================================================================================== 


PROMPT *** Create  procedure P_F85SB ***

  CREATE OR REPLACE PROCEDURE BARS.P_F85SB (Dat_ DATE )  IS
/*%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
% FILE NAME   :	otcn.sql
% DESCRIPTION :	ќтчетность —берЅанка: формирование файлов
% COPYRIGHT   :	Copyright UNITY-BARS Limited, 2001.  All Rights Reserved.
% VERSION     : 15.03.2011 (23.02.2009,23.10.2002)
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
% 15.03.2011 - в поле комментарий вносим код TOBO и название счета
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%*/
acc_    Number;
acc1_   Number;
acc2_   Number;
accc_   Number;
accc6_  Number;
acc6_   Number;
acc8_   Number;
kol8_   Number;
kol6_7  Number;
sum6_7  Number;
Dosn6_7 Number;
Kosn6_7 Number;
dat1_   Date;
dat2_   Date;
Dosn_   DECIMAL(24);
Kosn_   DECIMAL(24);
Dosn6_  DECIMAL(24);
Kosn6_  DECIMAL(24);
Dosn8_  DECIMAL(24);
Kosn8_  DECIMAL(24);
Dosnk_  DECIMAL(24);
Kosnk_  DECIMAL(24);
Dosnkp_ DECIMAL(24);
Kosnkp_ DECIMAL(24);
se_     DECIMAL(24);
sn_     DECIMAL(24);
Ostn_   DECIMAL(24);
Ostn6_  DECIMAL(24);
Ostn8_  DECIMAL(24);
Oste_   DECIMAL(24);
kodp_   Varchar2(11);
znap_   Varchar2(30);
Kv_     SMALLINT;
Kv6_    SMALLINT;
Kv8_    SMALLINT;
Vob_    SMALLINT;
Nbs_    Varchar2(4);
Nbs1_   Varchar2(4);
Nbs8_   Varchar2(4);
Nbs6_   Varchar2(4);
nls_    Varchar2(15);
nls6_   Varchar2(15);
nls8_   Varchar2(15);
data_   Date;
data6_  Date;
data8_  Date;
zz_     Varchar2(2);
pp_     Varchar2(4);
dk_     Char(1);
f85_    Number;
f85k_   Number;
userid_ Number;
tobo_   accounts.tobo%TYPE;
nms_    accounts.nms%TYPE;
comm_   rnbu_trace.comm%TYPE;
tobo6_  accounts.tobo%TYPE;
nms6_   accounts.nms%TYPE;
comm6_  rnbu_trace.comm%TYPE;

CURSOR SCHETA IS
    SELECT s.acc
    FROM accounts s
    WHERE substr(s.nbs,1,1)='8' ;

---ќстатки на отчетную дату (грн. + валюта)
CURSOR SaldoASeekOstf IS
   SELECT /* + INDEX(L XIE_K040_KL_K040) INDEX (C XPK_CUSTOMER) */
         a.acc, a.nls, a.kv, a.fdat, a.nbs, a.ostf-a.dos+a.kos,
         a.tobo, a.nms
---         GL.P_ICURVAL(a.kv, a.ostf-a.dos+a.kos, Dat_)
   FROM  (SELECT s.acc, s.nls, s.kv, aa.fdat, s.nbs, aa.ostf,
         aa.dos, aa.kos, s.tobo, s.nms
         FROM saldoa aa, accounts s
         WHERE aa.acc=s.acc
           and aa.fdat = (select max(c.fdat)
                          from saldoa c
                          where c.acc=aa.acc
                            and c.fdat <= Dat_)) a   ---sb_p085 k
   WHERE a.kv=980
     and substr(a.nbs,1,1)='8' ;    ---k.r020

---ќбороты (по грн. + по валюте номиналы)
CURSOR SaldoASeekOs IS
   SELECT /* + INDEX(L XIE_K040_KL_K040) INDEX (C XPK_CUSTOMER) */
          a.acc, a.nls, a.kv, a.nbs, a.tobo, a.nms, SUM(s.dos), SUM(s.kos)
   FROM saldoa s, accounts a    --- sb_p085 k
   WHERE s.fdat between Dat1_+1 AND Dat_
     and a.acc=s.acc
     and a.kv=980
     and substr(a.nbs,1,1)='8'
   GROUP BY a.acc, a.nls, a.kv, a.nbs, a.tobo, a.nms ;

CURSOR Saldo8 IS
   SELECT a.acc, a.accc, a.nls, a.kv, a.fdat, a.nbs, a.ostf-a.dos+a.kos,
          a.tobo, a.nms
   FROM  (SELECT s.acc, s.accc, s.nls, s.kv, aa.fdat, s.nbs, aa.ostf,
         aa.dos, aa.kos, s.tobo, s.nms
         FROM saldoa aa, accounts s
         WHERE aa.acc=s.acc     AND
               aa.fdat = (select max(c.fdat)
                          from saldoa c
                          where c.acc=aa.acc
                            and c.fdat <= Dat_)) a
   WHERE a.accc=acc_  and
         a.accc is not null ;

---CURSOR Saldo6_7 IS
---   SELECT a.acc, a.accc, a.nls, a.kv, a.fdat, a.nbs, a.ostf-a.dos+a.kos
---   FROM  (SELECT s.acc, s.accc, s.nls, s.kv, aa.fdat, s.nbs, aa.ostf,
---         aa.dos, aa.kos
---         FROM saldoa aa, accounts s
---         WHERE aa.acc=s.acc     AND
---              (s.acc,aa.fdat) =
---               (select c.acc,max(c.fdat)
---                from saldoa c
---                where s.acc=c.acc and c.fdat <= Dat_
---                group by c.acc)) a
---   WHERE a.accc=accc_  AND
---         a.kv=980 ;

---ќстатки и ќбороты (по 6,7 кл.) дл€ счетов в том числе отсут. в конце мес€ца
CURSOR Saldo6_7 IS
   SELECT a.acc, a.accc, a.nls, a.kv, a.nbs, a.tobo, a.nms
   FROM accounts a
   WHERE a.accc=accc_  AND
         a.kv=980 ;


---ќбороты (по 8 классу)
CURSOR OBOROTY8 IS
   SELECT a.acc, a.accc, a.nls, a.kv, a.nbs, a.tobo, a.nms, SUM(s.dos), SUM(s.kos)
   FROM saldoa s, accounts a
   WHERE a.accc=acc_
     and a.accc is not NULL
     and s.fdat between Dat1_+1 and Dat_
     and a.acc=s.acc
     and a.kv=980
     and substr(a.nbs,1,1)='8'
   GROUP BY a.acc, a.accc, a.nls, a.kv, a.nbs, a.tobo, a.nms ;

---ќбороты (по  6,7  классам)
---CURSOR OBOROTY6_7 IS
---   SELECT a.acc, a.accc, a.nls, a.kv, a.nbs, SUM(s.dos), SUM(s.kos)
---   FROM saldoa s, accounts a
---   WHERE a.accc=accc_                  AND
---         s.fdat > Dat1_                AND
---         s.fdat<= Dat_                 AND
---         a.acc=s.acc                   AND
---         a.kv=980                      AND
---         substr(a.nbs,1,1) in ('6','7')
---   GROUP BY a.acc, a.accc, a.nls, a.kv, a.nbs ;

---ќбороты (по  6,7  классам)
---CURSOR OBOROTY6_7 IS
---   SELECT acc, accc, nls, kv, nbs
---   FROM   accounts a
---   WHERE a.accc=accc_                    AND
---         a.kv=980 ;

CURSOR BaseL IS
    SELECT kodp, SUM (znap)
    FROM rnbu_trace
    WHERE userid=userid_
    GROUP BY kodp;

BEGIN
-------------------------------------------------------------------
--SELECT id INTO userid_ FROM staff WHERE upper(logname)=upper(USER);
userid_ := user_id;
--DELETE FROM RNBU_TRACE WHERE userid = userid_;
EXECUTE IMMEDIATE 'TRUNCATE TABLE RNBU_TRACE';
-------------------------------------------------------------------
Dat1_ := TRUNC(Dat_, 'MM');
Dat2_ := TRUNC(Dat_ + 28);
-------------------------------------------------------------------
---корректирующие проводки
DELETE FROM ref_kor ;
INSERT INTO ref_kor (REF, VOB, VDAT)
SELECT ref, vob, vdat
FROM oper
WHERE vob in (96,99) ;

DELETE FROM kor_prov ;
INSERT INTO KOR_PROV (REF,  DK,  ACC , S,  FDAT , VDAT, SOS,  VOB)
SELECT o.ref, o.dk, o.acc, o.s, o.fdat, p.vdat, o.sos, p.vob
FROM opldok o, ref_kor p     --- oper p
WHERE o.fdat between Dat1_+1 AND Dat2_
  AND o.ref=p.ref
  AND o.sos=5 ;

SELECT count(*) into f85k_
FROM tmp_irep
WHERE kodf='85' and datf=Dat_ ;

-- ќстатки (грн. + валюта номиналы) --
OPEN SaldoASeekOstf;
LOOP
   FETCH SaldoASeekOstf INTO acc_, nls_, kv_, data_, Nbs_, Ostn_, tobo_, nms_;
   EXIT WHEN SaldoASeekOstf%NOTFOUND;

   SELECT count(*) INTO f85_ FROM sb_p085d WHERE r020=nbs_ ;
---   f85_:=1 ;

   comm_ := '';
   comm_ := substr(comm_ || tobo_ || '  ' || nms_, 1, 200);
   IF f85_ >0 and Ostn_<>0 THEN
---занесение кодов спецпараметров по новым счетам
      IF f85k_>=0 THEN
       OPEN SCHETA;
       LOOP
       FETCH Scheta INTO acc1_ ;
       EXIT WHEN Scheta%NOTFOUND;
         BEGIN
            SELECT acc INTO acc2_
            FROM Specparam_int
            WHERE acc=acc_ ;
         EXCEPTION WHEN NO_DATA_FOUND THEN
            acc2_:=0 ;
         END ;
         IF acc2_=0 THEN
            insert into specparam_int (acc,p080,ob22,r020_fa) VALUES
                                      (acc_,'0000','00','0000') ;
         END IF;
       END LOOP;
       CLOSE Scheta;
      END IF ;

      BEGIN
         SELECT NVL(trim(p080),'0000') INTO pp_
         FROM specparam_int
         WHERE acc=acc_ ;
      EXCEPTION WHEN NO_DATA_FOUND THEN
         pp_:='0000' ;
      END ;

      pp_ := lpad(trim(pp_),4,'0');

      BEGIN
         SELECT count(*) INTO kol8_
         FROM accounts
         WHERE accc=acc_ and substr(nbs,1,1)='8' and accc is not NULL ;
      EXCEPTION WHEN NO_DATA_FOUND THEN
         kol8_:=0 ;
      END ;

      IF kol8_=0 THEN
         zz_:='00';
         nbs1_:='0000';
         dk_:=IIF_N(Ostn_,0,'2','1','1');
         kodp_:=dk_ || pp_ || nbs1_ || zz_ ;
         znap_:=TO_CHAR(ABS(Ostn_));
         INSERT INTO rnbu_trace         -- ќстатки в номинале валюты
                 (nls, kv, odate, kodp, znap, acc, comm, tobo)
         VALUES  (nls_, kv_, data_, kodp_, znap_, acc_, comm_, tobo_) ;
      END IF ;

      IF kol8_>0 THEN   --- св€занные счета
         OPEN Saldo8;
         LOOP
         FETCH Saldo8 INTO accc_, acc8_, nls8_, kv8_, data8_, Nbs8_, Ostn8_,
               tobo_, nms_;
         EXIT WHEN Saldo8%NOTFOUND;

         comm_ := '';
         comm_ := substr(comm_ || tobo_ || '  ' || nms_, 1, 200);
         BEGIN
            SELECT count(*) INTO kol6_7
            FROM accounts
            WHERE accc=accc_
              and substr(nbs,1,1) in ('6','7')
              and accc is not NULL ;
         EXCEPTION WHEN NO_DATA_FOUND THEN
            kol6_7 := 0 ;
         END ;

         IF kol6_7=0 THEN
            IF Ostn8_ <> 0 THEN
               dk_:=IIF_N(Ostn8_,0,'2','1','1');
               kodp_:=dk_ || pp_ || '000000' ;  --- nbs1_='0000',zz_='00'
               znap_:=TO_CHAR(ABS(Ostn8_));
               IF (Ostn_>0 and Ostn8_<0) OR (Ostn_<0 and Ostn8_>0) THEN
                  dk_:=IIF_N(Ostn_,0,'2','1','1');
                  kodp_:=dk_ || pp_ || nbs1_ || zz_ ;
                  znap_:=TO_CHAR((0-Ostn8_));
               END IF ;
               INSERT INTO rnbu_trace         -- ќстатки в номинале валюты
                       (nls, kv, odate, kodp, znap, acc, comm)
---               VALUES  (nls_, kv_, data_, kodp_, znap_, comm_) ;
               VALUES  (nls_, kv_, data_, kodp_, znap_, acc8_, comm_) ;
            END IF ;
         END IF ;

         sum6_7:=0 ;

         IF kol6_7 > 0 THEN
            OPEN Saldo6_7;
            LOOP
            FETCH Saldo6_7 INTO acc6_, accc6_, nls6_, kv6_, Nbs6_, tobo6_, nms6_;
            EXIT WHEN Saldo6_7%NOTFOUND;

            comm6_ := '';
            comm6_ := substr(comm6_ || tobo6_ || '  ' || nms6_, 1, 200);
            BEGIN
               SELECT b.ostf-b.dos+b.kos INTO Ostn6_
               FROM accounts a, saldoa b
               WHERE a.acc=acc6_     AND
                     a.acc=b.acc     AND
                     b.fdat = (select max(c.fdat)
                               from saldoa c
                               where c.acc=b.acc
                                 and c.fdat <= Dat_) ;
            EXCEPTION WHEN NO_DATA_FOUND THEN
               Ostn6_:=0;
            END;

            BEGIN
               SELECT NVL(ob22,'00') INTO zz_
               FROM specparam_int
               WHERE acc=acc6_ ;
            EXCEPTION WHEN NO_DATA_FOUND THEN
               zz_ := '00' ;
            END ;

            f85k_:=0;
            SELECT count(*) INTO f85k_
            FROM SB_P085
            WHERE R020=Nbs8_ and p080=pp_ and
                  R020_FA=Nbs6_ and ob22=zz_ and d_close is null ;


            IF f85k_=0 THEN
               Nbs6_:='0000';
               zz_:='00';
            END IF ;

            BEGIN
               SELECT d.acc, SUM(DECODE(d.dk, 0, d.s, 0)),
               SUM(DECODE(d.dk, 1, d.s, 0))
               INTO acc1_, Dosnk_, Kosnk_
               FROM  kor_prov d
               WHERE d.acc=acc6_
                 and d.fdat between Dat_+1 AND Dat2_
                 and d.vob = 96
               GROUP BY d.acc ;
            EXCEPTION WHEN NO_DATA_FOUND THEN
               Dosnk_ :=0 ;
               Kosnk_ :=0 ;
            END ;

            Ostn6_:=Ostn6_-Dosnk_+Kosnk_;
            sum6_7:=sum6_7+Ostn6_ ;

            IF Ostn6_ <> 0 THEN
               dk_:=IIF_N(Ostn6_,0,'2','1','1');
               kodp_:=dk_ || pp_ || nbs6_ || zz_ ;
               znap_:=TO_CHAR(ABS(Ostn6_));
               IF (Ostn_>0 and Ostn6_<0) OR (Ostn_<0 and Ostn6_>0) THEN
                  dk_:=IIF_N(Ostn_,0,'2','1','1');
                  kodp_:=dk_ || pp_ || nbs6_ || zz_ ;
                  znap_:=TO_CHAR((0-Ostn6_));
               END IF ;

               IF (pp_='0002' or pp_='0009') and (nbs_='8000' or nbs_='8010') THEN
                  kodp_:=dk_ || pp_ || '000000' ;
               END IF ;

               INSERT INTO rnbu_trace         -- ќстатки в номинале валюты
                       (nls, kv, odate, kodp, znap, acc, comm)
               VALUES  (nls_, kv8_, data_, kodp_, znap_, acc6_, comm_) ;
            END IF ;
            END LOOP;
            CLOSE Saldo6_7;
            IF Ostn8_-sum6_7<>0 THEN
               IF Ostn8_=0 THEN
                  dk_:=IIF_N(sum6_7,0,'2','1','1');
               ELSE
                  dk_:=IIF_N((Ostn8_-sum6_7),0,'2','1','1');
               END IF ;
               kodp_:=dk_ || pp_ || '000000' ;   --- nbs1_='0000',zz_='00'
               znap_:=TO_CHAR(ABS(Ostn8_-sum6_7));
               INSERT INTO rnbu_trace         -- ќстатки в номинале валюты
                       (nls, kv, odate, kodp, znap, acc, comm)
               VALUES  (nls8_, kv_, data_, kodp_, znap_, acc_, comm_) ;
            END IF ;
         END IF ;
         END LOOP;
         CLOSE Saldo8;
      END IF ;
   END IF;
END LOOP;
CLOSE SaldoASeekOstf;
--------------------------------------------------------------------
-- ќбороты текущие (грн. + вал. номиналы ) --
OPEN SaldoASeekOs;
LOOP
   FETCH SaldoASeekOs INTO acc_, nls_, kv_, Nbs_, tobo_, nms_, Dosn_, Kosn_;
   EXIT WHEN SaldoASeekOs%NOTFOUND;

   SELECT count(*) INTO f85_ FROM sb_p085d WHERE r020=nbs_ ;
   comm_ := '';
   comm_ := substr(comm_ || tobo_ || '  ' || nms_, 1, 200);
   IF f85_>0 THEN    ---and (Dosn_ > 0 OR Kosn_ > 0) THEN
      BEGIN
         SELECT NVL(trim(p080),'0000') INTO pp_
         FROM specparam_int
         WHERE acc=acc_ ;
      EXCEPTION WHEN NO_DATA_FOUND THEN
         pp_ := '0000' ;
      END ;

      pp_ := lpad(trim(pp_),4,'0');
      BEGIN
         SELECT count(*) INTO kol8_
         FROM accounts
         WHERE accc=acc_ and substr(nbs,1,1)='8' and accc is not NULL ;
      EXCEPTION WHEN NO_DATA_FOUND THEN
         kol8_ := 0 ;
      END ;

      IF kol8_=0 THEN
         IF Kosn_ > 0 THEN
            kodp_:='5' || pp_ || '000000' ;   --- nbs1_='0000',zz_='00'
            znap_:=TO_CHAR(Kosn_) ;
            INSERT INTO rnbu_trace     -- ƒт. обороты в номинале валюты (грн.+вал.)
                    (nls, kv, odate, kodp, znap, acc, comm, tobo)
            VALUES  (nls_, kv_, dat_, kodp_, znap_, acc_, comm_, tobo_) ;
         END IF;

         IF Dosn_ > 0 THEN
            kodp_:='6' || pp_ || '000000' ;   --- nbs1_='0000',zz_='00'
            znap_:=TO_CHAR(Dosn_);
            INSERT INTO rnbu_trace     --  р. обороты в номинале валюты (грн.+вал.)
                    (nls, kv, odate, kodp, znap, acc, comm, tobo)
            VALUES  (nls_, kv_, dat_, kodp_, znap_, acc_, comm_, tobo_) ;
         END IF;
      END IF;

      IF kol8_>0 THEN   --- св€занные счета
         OPEN OBOROTY8;
         LOOP
         FETCH OBOROTY8 INTO accc_, acc8_, nls8_, kv8_, Nbs8_, tobo6_, nms6_,
                             Dosn8_, Kosn8_;
         EXIT WHEN OBOROTY8%NOTFOUND;

         comm6_ := '';
         comm6_ := substr(comm6_ || tobo6_ || '  ' || nms6_, 1, 200);
         BEGIN
            SELECT count(*) INTO kol6_7
            FROM accounts
            WHERE accc=accc_ and substr(nbs,1,1) in ('6','7') and accc is not NULL ;
         EXCEPTION WHEN NO_DATA_FOUND THEN
            kol6_7 := 0 ;
         END ;

         IF kol6_7=0 THEN
            IF Kosn8_ > 0 THEN
               kodp_:='5' || pp_ || '000000' ;   --- nbs1_='0000',zz_='00'
               znap_:=TO_CHAR(Kosn8_) ;
               INSERT INTO rnbu_trace     -- ƒт. обороты в номинале валюты (грн.+вал.)
                       (nls, kv, odate, kodp, znap, acc, comm)
               VALUES  (nls_, kv_, dat_, kodp_, znap_, acc8_, comm6_) ;
            END IF;

            IF Dosn8_ > 0 THEN
               kodp_:='6' || pp_ || '000000' ;   --- nbs1_='0000',zz_='00'
               znap_:=TO_CHAR(Dosn8_);
               INSERT INTO rnbu_trace     --  р. обороты в номинале валюты (грн.+вал.)
                       (nls, kv, odate, kodp, znap, acc, comm)
               VALUES  (nls_, kv_, dat_, kodp_, znap_, acc8_, comm_) ;
            END IF;
         END IF;

         Dosn6_7:=0 ;
         Kosn6_7:=0 ;

         IF kol6_7 > 0 THEN
            OPEN Saldo6_7;
            LOOP
            FETCH Saldo6_7 INTO acc6_, accc6_, nls6_, kv6_, Nbs6_, tobo6_, nms6_; --- Dosn6_, Kosn6_ ;
            EXIT WHEN Saldo6_7%NOTFOUND;

            comm6_ := '';
            comm6_ := substr(comm6_ || tobo6_ || '  ' || nms6_, 1, 200);
            BEGIN
               SELECT SUM(Dos), SUM(Kos) INTO Dosn6_, Kosn6_
               FROM saldoa
               WHERE acc=acc6_ and fdat>Dat1_ and fdat<=Dat_
               GROUP BY acc ;
            EXCEPTION WHEN NO_DATA_FOUND THEN
               Dosn6_:=0 ;
               Kosn6_:=0 ;
            END ;

            BEGIN
               SELECT NVL(ob22,'00') INTO zz_
               FROM specparam_int
               WHERE acc=acc6_ ;
            EXCEPTION WHEN NO_DATA_FOUND THEN
               zz_ := '00' ;
            END ;

            f85k_:=0;
            SELECT count(*) INTO f85k_
            FROM SB_P085
            WHERE R020=Nbs8_ and p080=pp_ and
                  R020_FA=Nbs6_ and ob22=zz_ and d_close is null ;

            IF f85k_=0 THEN
               Nbs6_:='0000';
               zz_:='00';
            END IF ;

--- корректирующие проводки предыдущего мес€ца
            BEGIN
               SELECT d.acc,
                      SUM(DECODE(d.dk, 0, d.s, 0)),
                      SUM(DECODE(d.dk, 1, d.s, 0))
               INTO acc1_, Dosnkp_, Kosnkp_
               FROM  kor_prov d
               WHERE d.acc=acc6_
                 and d.fdat between Dat1_+1 AND Dat_
                 and d.vob = 96
               GROUP BY d.acc ;
            EXCEPTION WHEN NO_DATA_FOUND THEN
               Dosnkp_ :=0 ;
               Kosnkp_ :=0 ;
            END ;


--- корректирующие проводки отчетного мес€ца
            BEGIN
               SELECT d.acc,
                      SUM(DECODE(d.dk, 0, d.s, 0)),
                      SUM(DECODE(d.dk, 1, d.s, 0))
               INTO acc1_, Dosnk_, Kosnk_
               FROM  kor_prov d
               WHERE d.acc=acc6_
                 and d.fdat between Dat_+1 AND Dat2_
                 and d.vob = 96
               GROUP BY d.acc ;
            EXCEPTION WHEN NO_DATA_FOUND THEN
               Dosnk_ :=0 ;
               Kosnk_ :=0 ;
            END ;

            Dosn6_:=Dosn6_+Dosnk_+Kosnkp_;
            Kosn6_:=Kosn6_+Kosnk_+Dosnkp_;

            Dosn6_7:=Dosn6_7+Dosn6_ ;
            Kosn6_7:=Kosn6_7+Kosn6_ ;

            IF Dosn6_ > 0 THEN
---               kodp_:='6' || pp_ || nbs6_ || zz_ ;
               IF (pp_='0002' or pp_='0009') and (nbs_='8000' or nbs_='8010') THEN
                  kodp_:='6' || pp_ || '000000' ;
               ELSE
                  kodp_:='6' || pp_ || nbs6_ || zz_ ;
               END IF ;
               znap_:=TO_CHAR(Dosn6_) ;
               INSERT INTO rnbu_trace     -- ƒт. обороты в номинале валюты (грн.+вал.)
                       (nls, kv, odate, kodp, znap, acc, comm)
               VALUES  (nls_, kv_, dat_, kodp_, znap_, acc6_, comm6_) ;
            END IF;

            IF Kosn6_ > 0 THEN
               IF (pp_='0002' or pp_='0009') and (nbs_='8000' or nbs_='8010') THEN
                  kodp_:='5' || pp_ || '000000' ;
               ELSE
                  kodp_:='5' || pp_ || nbs6_ || zz_  ;
               END IF ;
               znap_:=TO_CHAR(Kosn6_);
               INSERT INTO rnbu_trace     --  р. обороты в номинале валюты (грн.+вал.)
                       (nls, kv, odate, kodp, znap, acc, comm)
               VALUES  (nls_, kv_, dat_, kodp_, znap_, acc6_, comm_) ;
            END IF;
            END LOOP;
            CLOSE Saldo6_7;

            IF Dosn8_-Dosn6_7>0 THEN
               kodp_:='6' || pp_ || '000000' ;   --- nbs1_='0000',zz_='00'
               znap_:=TO_CHAR(Dosn8_-Dosn6_7);
               INSERT INTO rnbu_trace     --  р. обороты в номинале валюты (грн.+вал.)
                       (nls, kv, odate, kodp, znap, acc, comm)
               VALUES  (nls8_, kv_, dat_, kodp_, znap_, acc_, comm_) ;
            END IF ;
            IF Kosn8_-Kosn6_7>0 THEN
               kodp_:='5' || pp_ || '000000' ;   --- nbs1_='0000',zz_='00'
               znap_:=TO_CHAR(Kosn8_-Kosn6_7);
               INSERT INTO rnbu_trace     --  р. обороты в номинале валюты (грн.+вал.)
                       (nls, kv, odate, kodp, znap, acc, comm)
               VALUES  (nls8_, kv_, dat_, kodp_, znap_, acc_, comm_) ;
            END IF ;
         END IF;
         END LOOP;
         CLOSE OBOROTY8;
      END IF ;
   END IF;
END LOOP;
CLOSE SaldoASeekOs;
-------------------------------------------------------------------------
---------------------------------------------------
DELETE FROM tmp_irep where kodf='85' and datf= dat_;
---------------------------------------------------
OPEN BaseL;
LOOP
   FETCH BaseL INTO  kodp_, znap_;
   EXIT WHEN BaseL%NOTFOUND;
   INSERT INTO tmp_irep
        (kodf, datf, kodp, znap)
   VALUES
        ('85', Dat_, kodp_, znap_);
END LOOP;
CLOSE BaseL;
------------------------------------------------------------------
END p_f85sb;
/
show err;

PROMPT *** Create  grants  P_F85SB ***
grant EXECUTE                                                                on P_F85SB         to BARS_ACCESS_DEFROLE;
grant EXECUTE                                                                on P_F85SB         to RPBN002;
grant EXECUTE                                                                on P_F85SB         to WR_ALL_RIGHTS;



PROMPT ===================================================================================== 
PROMPT *** End *** ========== Scripts /Sql/BARS/Procedure/P_F85SB.sql =========*** End *** =
PROMPT ===================================================================================== 
