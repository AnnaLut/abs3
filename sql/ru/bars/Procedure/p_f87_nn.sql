

PROMPT ===================================================================================== 
PROMPT *** Run *** ========== Scripts /Sql/BARS/Procedure/P_F87_NN.sql =========*** Run *** 
PROMPT ===================================================================================== 


PROMPT *** Create  procedure P_F87_NN ***

  CREATE OR REPLACE PROCEDURE BARS.P_F87_NN (Dat_ DATE)  IS
/*%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
% DESCRIPTION :	ѕроцедура формирование файла @87 дл€  Ѕ
% COPYRIGHT   :	Copyright UNITY-BARS Limited, 2009.All Rights Reserved.
% VERSION     : 30.04.2011 (09.03.11,19.01.11,18.05.10,26.01.10)
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
параметры: Dat_ - отчетна€ дата
           sheme_ - схема формировани€
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
*/
acc_     Number;
acc1_    Number;
acc2_    Number;
accc_    Number;
accc6_   Number;
acc6_    Number;
acc8_    Number;
kol8_    Number;
kol6_7   Number;
sum6_7   Number;
Dosn6_7  Number;
Kosn6_7  Number;
dat1_    Date;
dat2_    Date;
Dose_    DECIMAL(24);
Kose_    DECIMAL(24);
Dosn_    DECIMAL(24);
Kosn_    DECIMAL(24);
Dosn6_   DECIMAL(24);
Kosn6_   DECIMAL(24);
Dosn8_   DECIMAL(24);
Kosn8_   DECIMAL(24);
Dosnk_   DECIMAL(24);
Kosnk_   DECIMAL(24);
Dosnkp_  DECIMAL(24);
Kosnkp_  DECIMAL(24);
se_      DECIMAL(24);
sn_      DECIMAL(24);
Ostn_    DECIMAL(24);
Ostn6_   DECIMAL(24);
Ostn8_   DECIMAL(24);
Oste_    DECIMAL(24);
kodp_    Varchar2(11);
znap_    Varchar2(30);
Kv_      SMALLINT;
Kv6_     SMALLINT;
Kv8_     SMALLINT;
Vob_     SMALLINT;
Nbs_     Varchar2(4);
Nbs1_    Varchar2(4);
Nbs8_    Varchar2(4);
Nbs6_    Varchar2(4);
nls_     Varchar2(15);
nls6_    Varchar2(15);
nls8_    Varchar2(15);
data_    Date;
data1_   Date;
data6_   Date;
data8_   Date;
zz_      Varchar2(2);
pp_      Varchar2(4);
r020_fa_ Varchar2(4);
dk_      Char(1);
f87_     Number;
f87k_    Number;
userid_  Number;
tobo_    accounts.tobo%TYPE;
nms_     accounts.nms%TYPE;
comm_    rnbu_trace.comm%TYPE;

CURSOR SCHETA IS
    SELECT a.acc
    FROM accounts a
    WHERE a.nbs LIKE '8%' AND a.nbs not in ('8605','8625','8999')
    and (exists (select 1 from v_ob22nu_n where accn=a.acc)
        or exists (select 1 from v_ob22nu80 where accn=a.acc));


---ќстатки на отчетную дату грн.
CURSOR SaldoASeekOstf IS
   SELECT  a.acc, a.nls, a.kv, a.fdat, a.nbs, a.ostf-a.dos+a.kos,
           a.tobo, a.nms
---         GL.P_ICURVAL(a.kv, a.ostf-a.dos+a.kos, Dat_)
   FROM  (SELECT s.acc, s.nls, s.kv, aa.fdat, s.nbs, aa.ostf,
         aa.dos, aa.kos, s.tobo, s.nms
         FROM saldoa aa, accounts s
         WHERE aa.acc=s.acc     AND
              (s.acc,aa.fdat) in
               (select c.acc,max(c.fdat)
                from saldoa c
                where c.fdat <= Dat_
                group by c.acc)) a   ---sb_p085 k
   WHERE a.kv=980
     and a.nbs LIKE '8%'
     and a.nbs not in ('8605','8625','8999')
     and (exists (select 1 from v_ob22nu_n where accn=a.acc)
        or exists (select 1 from v_ob22nu80 where accn=a.acc));   ---k.r020

---ќбороты грн.
CURSOR SaldoASeekOs IS
   SELECT  a.acc, a.nls, a.kv, a.nbs, SUM(s.dos), SUM(s.kos), a.tobo, a.nms
   FROM saldoa s, accounts a    --- sb_p085 k
   WHERE s.fdat >= Dat1_
     and s.fdat <= Dat_
     and a.acc=s.acc
     and a.kv=980
     and a.nbs LIKE '8%'
     and a.nbs not in ('8605','8625','8999')
     and (exists (select 1 from v_ob22nu_n where accn=a.acc)
        or exists (select 1 from v_ob22nu80 where accn=a.acc))
   GROUP BY a.acc, a.nls, a.kv, a.nbs, a.tobo, a.nms ;

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
--CURSOR Saldo6_7 IS
--   SELECT a.acc, a.accc, a.nls, a.kv, a.nbs
--   FROM accounts a
--   WHERE a.accc=accc_  AND
--         a.kv=980 ;

CURSOR Saldo6_7 IS
   SELECT a.acc, a.accc, a.nls, a.kv, a.nbs
   FROM accounts a, v_ob22nu_n v
   WHERE a.acc = v.acc
     AND v.accn=acc_
     AND a.kv=980 ;


---ќбороты (по  6,7  классам)
---CURSOR OBOROTY6_7 IS
---   SELECT a.acc, a.accc, a.nls, a.kv, a.nbs, SUM(s.dos), SUM(s.kos)
---   FROM saldoa s, accounts a
---   WHERE a.accc=accc_                  AND
---         s.fdat >= Dat1_               AND
---         s.fdat <= Dat_                AND
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
--Dat1_ := TRUNC(Dat_ - TO_NUMBER(TO_CHAR(Dat_,'DD')));
Dat1_ := TRUNC(Dat_,'MM');

--IF to_char(Dat_,'MM')='01' THEN
--   Dat1_:=to_date('01' || '01' || to_char(Dat_,'YYYY'),'DDMMYYYY');
--END IF;

--IF to_char(Dat_,'MM')='01' THEN
   -- временно дл€ проверки
   --Dat1_:=to_date('30122007','DDMMYYYY'); -- было до 27.01.2009
--   Dat1_:=to_date('31122008','DDMMYYYY'); -- заменил до 30.01.2009
--   Dat1_:=to_date('01' || '01' || to_char(Dat_,'YYYY'),'DDMMYYYY');
--END IF;

Dat2_ := TRUNC(Dat_ + 28);
-------------------------------------------------------------------
---корректирующие проводки
DELETE FROM ref_kor ;
IF to_char(Dat_,'MM')='12' THEN
   INSERT INTO ref_kor (REF, VOB, VDAT)
   SELECT ref, vob, vdat
   FROM oper
   WHERE vdat>=Dat1_-3 and vdat<=Dat2_ and
         vob in (96,99) and not
         ((substr(nlsa,1,1) in ('6','7') and substr(nlsb,1,4) in ('5040','5041')) OR
          (substr(nlsa,1,4) in ('5040','5041') and substr(nlsb,1,1) in ('6','7'))) ;
ELSE
   INSERT INTO ref_kor (REF, VOB, VDAT)
   SELECT ref, vob, vdat
   FROM oper
   WHERE vdat>=Dat1_-3 and vdat<=Dat2_ and
         vob in (96,99) ;
END IF ;

DELETE FROM kor_prov ;
INSERT INTO KOR_PROV (REF,  DK,  ACC , S,  FDAT , VDAT, SOS,  VOB)
SELECT o.ref, o.dk, o.acc, o.s, o.fdat, p.vdat, o.sos, p.vob
FROM opldok o, ref_kor p     --- oper p
WHERE o.fdat>Dat1_     AND
      o.fdat<=Dat2_    AND
      o.ref=p.ref      AND
      o.sos=5 ;

SELECT count(*) into f87k_
FROM tmp_irep
WHERE kodf='87' and datf=Dat_ ;

-- ќстатки грн. --
OPEN SaldoASeekOstf;
LOOP
   FETCH SaldoASeekOstf INTO acc_, nls_, kv_, data_, Nbs_, Ostn8_, tobo_, nms_ ;
   EXIT WHEN SaldoASeekOstf%NOTFOUND;

   SELECT count(*) INTO f87_ FROM sb_p0853 WHERE r020=nbs_ ;
--   SELECT count(*) INTO f87_ FROM sb_p085d3 WHERE r020=nbs_ ;
---   f87_:=1 ;

   IF f87_ >0 and Ostn8_<>0 THEN
      comm_ := '';
---занесение кодов спецпараметров по новым счетам
      -- убрал 18.05.2010
      /*IF f87k_>=0 THEN
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
      */

      BEGIN
         SELECT NVL(p080,'0000'), NVL(r020_fa,'0000'),  NVL(ob22,'00')
            INTO pp_, r020_fa_, zz_
         FROM specparam_int
         WHERE acc=acc_ ;
      EXCEPTION WHEN NO_DATA_FOUND THEN
         pp_:='0000' ;
         r020_fa_ := '0000';
         zz_ := '00';
      END ;

--      BEGIN
--         SELECT count(*) INTO kol8_
--         FROM accounts
--         WHERE accc=acc_ and substr(nbs,1,1)='8' and accc is not NULL ;
--      EXCEPTION WHEN NO_DATA_FOUND THEN
--         kol8_:=0 ;
--      END ;

-- имеютс€ дочерние счета активно-пассивиные, а остаток необ-мо иметь один
-- поэтому берем остаток родительского счета (12.09.2005)
--      if nbs_='8100' and pp_='0002' then
--         kol8_:=0;
--      end if;

         BEGIN
            SELECT d.acc, SUM(DECODE(d.dk, 0, d.s, 0)),
                          SUM(DECODE(d.dk, 1, d.s, 0))
            INTO acc1_, Dosnk_, Kosnk_
            FROM  kor_prov d
            WHERE d.acc=acc_  AND
                  d.fdat > Dat_                AND
                  d.fdat <= Dat2_              AND
                  d.vob = 96
            GROUP BY d.acc ;
         EXCEPTION WHEN NO_DATA_FOUND THEN
            Dosnk_ :=0 ;
            Kosnk_ :=0 ;
         END ;
         Ostn8_:=Ostn8_-Dosnk_+Kosnk_;

--         BEGIN
--            SELECT count(*) INTO kol6_7
--            FROM accounts
--            WHERE accc=accc_ and substr(nbs,1,1) in ('6','7') and accc is not NULL ;
--         EXCEPTION WHEN NO_DATA_FOUND THEN
--            kol6_7 := 0 ;
--         END ;

--         BEGIN
--           SELECT count(*) INTO kol6_7
--           FROM  v_ob22nu_n
--           WHERE accn=acc_ and substr(nbs,1,1) in ('2','3','6','7') and acc is not NULL ;
--         EXCEPTION WHEN NO_DATA_FOUND THEN
--            kol6_7 := 0 ;
--         END ;

         dk_:=IIF_N(Ostn8_,0,'1','2','2');

         kol6_7 := 0;

         comm_ := substr(comm_ || tobo_ || '  ' || nms_, 1, 200);

         IF kol6_7=0 THEN
            IF pp_ not in ('0000','FFFF') and Ostn8_ <> 0 THEN
               kodp_:=dk_ || pp_ || r020_fa_ || zz_;  --'000000' ;  --- nbs1_='0000',zz_='00'
               znap_:=TO_CHAR(ABS(Ostn8_));
               INSERT INTO rnbu_trace         -- ќстатки в номинале валюты
                       (nls, kv, odate, kodp, znap, acc, comm, tobo)
               VALUES  (nls_, kv_, data_, kodp_, znap_, acc_, comm_, tobo_) ;
            END IF ;
         END IF ;

--         sum6_7:=0 ;

--         IF kol6_7 > 0 THEN
--            OPEN Saldo6_7;
--            LOOP
--            FETCH Saldo6_7 INTO acc6_, accc6_, nls6_, kv6_, Nbs6_ ;
--            EXIT WHEN Saldo6_7%NOTFOUND;

--               BEGIN
--                  SELECT b.ostf-b.dos+b.kos INTO Ostn6_
--                  FROM accounts a, saldoa b
--                  WHERE a.acc=acc6_     AND
--                        a.acc=b.acc     AND
--                        (b.acc,b.fdat) =
--                        (select c.acc,max(c.fdat)
--                         from saldoa c
--                         where b.acc=c.acc and c.fdat <= Dat_
--                         group by c.acc) ;
--               EXCEPTION WHEN NO_DATA_FOUND THEN
--                  Ostn6_:=0;
--               END;

--               BEGIN
--                  SELECT NVL(ob22,'00') INTO zz_
--                  FROM specparam_int
--                  WHERE acc=acc6_ ;
--               EXCEPTION WHEN NO_DATA_FOUND THEN
--                  zz_ := '00' ;
--               END ;

--               f87k_:=0;
--               SELECT count(*) INTO f87k_ FROM SB_P0853
--               WHERE R020=Nbs8_ and p080=pp_ and
--                     R020_FA=Nbs6_ and ob22=zz_ and
--                     (d_close is null or d_close > Dat_);


--               IF f87k_=0 THEN
--                  Nbs6_:='0000';
--                  zz_:='00';
--               END IF ;

--               BEGIN
--                  SELECT d.acc,
--                         SUM(DECODE(d.dk, 0, d.s, 0)),
--                         SUM(DECODE(d.dk, 1, d.s, 0))
--                     INTO acc1_, Dosnk_, Kosnk_
--                  FROM  kor_prov d
--                  WHERE d.acc=acc6_
--                    AND d.fdat > Dat_
--                    AND d.fdat <= Dat2_
--                    AND d.vob = 96
--                  GROUP BY d.acc ;
--               EXCEPTION WHEN NO_DATA_FOUND THEN
--                  Dosnk_ :=0 ;
--                  Kosnk_ :=0 ;
--               END ;

--               Ostn6_:=Ostn6_-Dosnk_+Kosnk_;

--               BEGIN
--                  SELECT NVL(SUM(p.s*decode(p.dk,0,-1,1,1,0)),0) INTO Dose_
--                  FROM oper o, opldok p
--                  WHERE o.ref  = p.ref
--                    AND p.fdat = dat_
--                    AND o.sos  = 5
--                    AND p.acc  = acc6_
--                    AND o.tt  like  'ZG%' ;
--               EXCEPTION WHEN NO_DATA_FOUND THEN
--                  Dose_:=0;
--               END;

--               Ostn6_:=Ostn6_-Dose_ ;
--               sum6_7:=sum6_7+Ostn6_ ;

--               IF Ostn6_ <> 0 THEN
----                  dk_:=IIF_N(Ostn6_,0,'2','1','1');
--                  kodp_:=dk_ || pp_ || nbs6_ || zz_ ;

--                  znap_:=TO_CHAR(ABS(Ostn6_));

--                  IF (pp_='0002' or pp_='0009') and (nbs_='8000' or nbs_='8010')
--                  THEN
--                     kodp_:=dk_ || pp_ || '000000' ;
--                  END IF ;

--                  INSERT INTO rnbu_trace         -- ќстатки в номинале валюты
--                          (nls, kv, odate, kodp, znap)
--                  VALUES  (nls6_, kv_, data_, kodp_, znap_) ;
--               END IF ;
--           END LOOP;
--            CLOSE Saldo6_7;

--            IF ABS(Ostn8_)-ABS(sum6_7)<>0 THEN
--               IF Ostn8_=0 THEN
--                  dk_:=IIF_N(sum6_7,0,'2','1','1');
--               ELSE
--                  dk_:=IIF_N(Ostn8_,0,'1','2','2');
----                  dk_:=IIF_N((Ostn8_-sum6_7),0,'1','2','2');
--               END IF ;
--               kodp_:=dk_ || pp_ || '000000' ;   --- nbs1_='0000',zz_='00'
--               znap_:=TO_CHAR(Ostn8_-sum6_7);
--               INSERT INTO rnbu_trace         -- ќстатки в номинале валюты
--                       (nls, kv, odate, kodp, znap)
--               VALUES  (nls_, kv_, data_, kodp_, znap_) ;
--            END IF ;
--         END IF ;
--         END LOOP;
--         CLOSE Saldo8;
--      END IF ;
   END IF;
END LOOP;
CLOSE SaldoASeekOstf;
--------------------------------------------------------------------
-- ќбороты текущие грн. --
OPEN SaldoASeekOs;
LOOP
   FETCH SaldoASeekOs INTO acc_, nls_, kv_, Nbs_, Dosn8_, Kosn8_, tobo_, nms_ ;
   EXIT WHEN SaldoASeekOs%NOTFOUND;

   SELECT count(*) INTO f87_ FROM sb_p0853 WHERE r020=nbs_ ;
--   SELECT count(*) INTO f87_ FROM sb_p085d3 WHERE r020=nbs_ ;

   IF f87_>0 THEN    ---and (Dosn_ > 0 OR Kosn_ > 0) THEN
      comm_ := '';

      BEGIN
         SELECT NVL(p080,'0000'), NVL(r020_fa,'0000'), NVL(ob22,'00')
            INTO pp_, r020_fa_, zz_
         FROM specparam_int
         WHERE acc=acc_ ;
      EXCEPTION WHEN NO_DATA_FOUND THEN
         pp_ := '0000' ;
         r020_fa_ := '0000';
         zz_ := '00';
      END ;

--      BEGIN
--         SELECT count(*) INTO kol8_
--         FROM accounts
--         WHERE accc=acc_ and substr(nbs,1,1)='8' and accc is not NULL ;
--      EXCEPTION WHEN NO_DATA_FOUND THEN
--         kol8_ := 0 ;
--      END ;

         --- корректирующие проводки отчетного мес€ца
         BEGIN
            SELECT d.acc,
                   SUM(DECODE(d.dk, 0, d.s, 0)),
                   SUM(DECODE(d.dk, 1, d.s, 0))
            INTO acc1_, Dosnk_, Kosnk_
            FROM  kor_prov d
            WHERE d.acc=acc_
              AND d.fdat > Dat_
              AND d.fdat <= Dat2_
              AND d.vob = 96
            GROUP BY d.acc ;
         EXCEPTION WHEN NO_DATA_FOUND THEN
            Dosnk_ :=0 ;
            Kosnk_ :=0 ;
         END ;
         Dosn8_:=Dosn8_+Dosnk_;
         Kosn8_:=Kosn8_+Kosnk_;

--         BEGIN
--            SELECT count(*) INTO kol6_7
--            FROM accounts
--            WHERE accc=accc_ and substr(nbs,1,1) in ('6','7') and accc is not NULL ;
--         EXCEPTION WHEN NO_DATA_FOUND THEN
--            kol6_7 := 0 ;
--         END ;

--         BEGIN
--           SELECT count(*) INTO kol6_7
--           FROM  v_ob22nu_n
--           WHERE accn=acc_ and substr(nbs,1,1) in ('2','3','6','7') and acc is not NULL ;
--         EXCEPTION WHEN NO_DATA_FOUND THEN
--            kol6_7 := 0 ;
--         END ;

         kol6_7 := 0;
         comm_ := substr(comm_ || tobo_ || '  ' || nms_, 1, 200);

         IF kol6_7=0 THEN
            IF pp_ not in ('0000','FFFF') and Kosn8_ > 0 THEN
               kodp_:='6' || pp_ || r020_fa_ || zz_;  --'000000' ;   --- nbs1_='0000',zz_='00'
               znap_:=TO_CHAR(Kosn8_) ;
               INSERT INTO rnbu_trace     -- ƒт. обороты в номинале валюты (грн.+вал.)
                       (nls, kv, odate, kodp, znap, acc, comm, tobo)
               VALUES  (nls_, kv_, dat_, kodp_, znap_, acc_, comm_, tobo_) ;
            END IF;

            IF pp_ not in ('0000','FFFF') and Dosn8_ > 0 THEN
               kodp_:='5' || pp_ || r020_fa_ || zz_;  --'000000' ;   --- nbs1_='0000',zz_='00'
               znap_:=TO_CHAR(Dosn8_);
               INSERT INTO rnbu_trace     --  р. обороты в номинале валюты (грн.+вал.)
                       (nls, kv, odate, kodp, znap, acc, comm, tobo)
               VALUES  (nls_, kv_, dat_, kodp_, znap_, acc_, comm_, tobo_) ;
            END IF;
         END IF;

--         Dosn6_7:=0 ;
--         Kosn6_7:=0 ;


--         IF kol6_7 > 0 THEN
--            OPEN Saldo6_7;
--            LOOP
--            FETCH Saldo6_7 INTO acc6_, accc6_, nls6_, kv6_, Nbs6_ ; --- Dosn6_, Kosn6_ ;
--            EXIT WHEN Saldo6_7%NOTFOUND;

--            BEGIN
--               SELECT SUM(Dos), SUM(Kos) INTO Dosn6_, Kosn6_
--               FROM saldoa
--               WHERE acc=acc6_ and fdat>Dat1_ and fdat<=Dat_
--               GROUP BY acc ;
--            EXCEPTION WHEN NO_DATA_FOUND THEN
--               Dosn6_:=0 ;
--               Kosn6_:=0 ;
--            END ;

--            BEGIN
--               SELECT NVL(ob22,'00') INTO zz_
--               FROM specparam_int
--               WHERE acc=acc6_ ;
--            EXCEPTION WHEN NO_DATA_FOUND THEN
--               zz_ := '00' ;
--            END ;

--            f87k_:=0;
--            SELECT count(*) INTO f87k_ FROM SB_P0853
--            WHERE R020=Nbs8_ and p080=pp_ and
--                  R020_FA=Nbs6_ and ob22=zz_ and d_close is null ;

--            IF f87k_=0 THEN
--               Nbs6_:='0000';
--               zz_:='00';
--            END IF ;

--- корректирующие проводки предыдущего мес€ца
--            BEGIN
--               SELECT d.acc,
--                      SUM(DECODE(d.dk, 0, d.s, 0)),
--                      SUM(DECODE(d.dk, 1, d.s, 0))
--               INTO acc1_, Dosnkp_, Kosnkp_
--               FROM  kor_prov d, oper p
--               WHERE d.acc=acc6_                  AND
--                     d.fdat > Dat1_               AND
--                     d.fdat <= Dat_               AND
--                     d.vob = 96                   AND
--                     d.ref=p.ref                  AND
--                     p.tt not LIKE 'ZG%'
--               GROUP BY d.acc ;
--            EXCEPTION WHEN NO_DATA_FOUND THEN
--               Dosnkp_ :=0 ;
--               Kosnkp_ :=0 ;
--            END ;


--- корректирующие проводки отчетного мес€ца
--            BEGIN
--               SELECT d.acc,
--                      SUM(DECODE(d.dk, 0, d.s, 0)),
--                      SUM(DECODE(d.dk, 1, d.s, 0))
--               INTO acc1_, Dosnk_, Kosnk_
--               FROM  kor_prov d
--               WHERE d.acc=acc6_                  AND
--                     d.fdat > Dat_                AND
--                     d.fdat <= Dat2_              AND
--                     d.vob = 96
--               GROUP BY d.acc ;
--            EXCEPTION WHEN NO_DATA_FOUND THEN
--               Dosnk_ :=0 ;
--               Kosnk_ :=0 ;
--            END ;

--            Dosn6_:=Dosn6_+Dosnk_+Kosnkp_;   -- -Dosnkp_;      --+Kosnkp_;
--            Kosn6_:=Kosn6_+Kosnk_+Dosnkp_;   -- -Kosnkp_;      --+Dosnkp_;

--            BEGIN
--               SELECT op.acc, op.fdat, NVL(SUM(decode(op.dk,0,1,0)*op.s),0),
--                      NVL(SUM(decode(op.dk,1,1,0)*op.s),0)
--                 INTO acc2_, data1_, Dose_, Kose_
--               FROM   oper o, opldok op
--               WHERE op.fdat=Dat_    AND
--                     op.acc=acc6_    AND
--                     o.sos = 5       AND
--                     o.ref = op.ref  AND
--                     o.tt  LIKE  'ZG%'
--               GROUP BY op.acc, op.fdat ;
--            EXCEPTION WHEN NO_DATA_FOUND THEN
--               Dose_:=0;
--               Kose_:=0;
--            END;

--            Dosn6_:=Dosn6_-Dose_ ;
--            Kosn6_:=Kosn6_-Kose_ ;

--            Dosn6_7:=Dosn6_7+Dosn6_ ;
--            Kosn6_7:=Kosn6_7+Kosn6_ ;

--            IF Dosn6_ > 0 THEN
---               kodp_:='6' || pp_ || nbs6_ || zz_ ;
--               IF (pp_='0002' or pp_='0009') and (nbs_='8000' or nbs_='8010') THEN
--                  kodp_:='6' || pp_ || '000000' ;
--               ELSE
--                  kodp_:='6' || pp_ || nbs6_ || zz_ ;
--               END IF ;

--               znap_:=TO_CHAR(Dosn6_) ;
--               INSERT INTO rnbu_trace     -- ƒт. обороты в номинале валюты (грн.+вал.)
--                       (nls, kv, odate, kodp, znap)
--               VALUES  (nls6_, kv_, dat_, kodp_, znap_) ;
--            END IF;

--            IF Kosn6_ > 0 THEN
--               IF (pp_='0002' or pp_='0009') and (nbs_='8000' or nbs_='8010') THEN
--                  kodp_:='5' || pp_ || '000000' ;
--               ELSE
--                  kodp_:='5' || pp_ || nbs6_ || zz_  ;
--               END IF ;

--               znap_:=TO_CHAR(Kosn6_);
--               INSERT INTO rnbu_trace     --  р. обороты в номинале валюты (грн.+вал.)
--                       (nls, kv, odate, kodp, znap)
--               VALUES  (nls6_, kv_, dat_, kodp_, znap_) ;
--            END IF;
--            END LOOP;
--            CLOSE Saldo6_7;

--            IF Dosn8_-Kosn6_7>0 THEN  --Dosn6_7>0 THEN
--               kodp_:='5' || pp_ || r020_fa_ || zz_;  --'000000' ;   --- nbs1_='0000',zz_='00'
--               znap_:=TO_CHAR(Dosn8_-Dosn6_7);
--               INSERT INTO rnbu_trace     --  р. обороты в номинале валюты (грн.+вал.)
--                       (nls, kv, odate, kodp, znap)
--               VALUES  (nls_, kv_, dat_, kodp_, znap_) ;
--            END IF ;
--            IF Kosn8_-Dosn6_7>0 THEN    --Kosn6_7>0 THEN
--               kodp_:='6' || pp_ || r020_fa_ || zz_;  --'000000' ;   --- nbs1_='0000',zz_='00'
--               znap_:=TO_CHAR(Kosn8_-Kosn6_7);
--               INSERT INTO rnbu_trace     --  р. обороты в номинале валюты (грн.+вал.)
--                       (nls, kv, odate, kodp, znap)
--               VALUES  (nls_, kv_, dat_, kodp_, znap_) ;
--            END IF ;
--         END IF;
--         END LOOP;
--         CLOSE OBOROTY8;
--      END IF ;
   END IF;
END LOOP;
CLOSE SaldoASeekOs;
-------------------------------------------------------------------------
---------------------------------------------------
DELETE FROM tmp_nbu where kodf='87' and datf= dat_;
---------------------------------------------------
OPEN BaseL;
LOOP
   FETCH BaseL INTO  kodp_, znap_;
   EXIT WHEN BaseL%NOTFOUND;
   INSERT INTO tmp_nbu
        (kodf, datf, kodp, znap)
   VALUES
        ('87', Dat_, kodp_, znap_);
END LOOP;
CLOSE BaseL;
------------------------------------------------------------------
END p_f87_nn;
/
show err;

PROMPT *** Create  grants  P_F87_NN ***
grant EXECUTE                                                                on P_F87_NN        to BARS_ACCESS_DEFROLE;
grant EXECUTE                                                                on P_F87_NN        to RPBN002;



PROMPT ===================================================================================== 
PROMPT *** End *** ========== Scripts /Sql/BARS/Procedure/P_F87_NN.sql =========*** End *** 
PROMPT ===================================================================================== 
