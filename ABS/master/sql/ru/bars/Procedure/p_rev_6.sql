

PROMPT ===================================================================================== 
PROMPT *** Run *** ========== Scripts /Sql/BARS/Procedure/P_REV_6.sql =========*** Run *** =
PROMPT ===================================================================================== 


PROMPT *** Create  procedure P_REV_6 ***

  CREATE OR REPLACE PROCEDURE BARS.P_REV_6 ( kv_ NUMBER, dat_ DATE ) IS
--==== Старая процедура переоценки МИШИНА на 6204--

 dat1_ DATE  ; ost1_  NUMBER; dosq_ NUMBER ; dosd_ NUMBER; dos_ NUMBER;
 dat2_ DATE  ; ost2_  NUMBER; kosq_ NUMBER ; kosd_ NUMBER; kos_ NUMBER;
 dlta_ NUMBER; ostf_  NUMBER; nbs1_ CHAR(4); s0000_   VARCHAR2(15);
 sdls_ NUMBER; sumos_ NUMBER; nbs2_ CHAR(4); s0009_   VARCHAR2(15);
 pdat_    DATE;
 ern         CONSTANT POSITIVE := 212;
 err         EXCEPTION;
 erm         VARCHAR2(80);
BEGIN
  BEGIN
   SELECT s0000,s0009 INTO s0000_,s0009_ FROM tabval WHERE kv=kv_;
   EXCEPTION WHEN NO_DATA_FOUND THEN s0000_ := NULL; s0009_ := NULL;
  END;
  IF s0000_ IS NULL THEN
     erm := '8070 - s0000_ or s0009_ is blank ('||kv_||')';     RAISE err;
  END IF;
  dat2_ := NVL(dat_,gl.bDATE);
  FOR d IN (SELECT UNIQUE fdat FROM saldoa
             WHERE fdat>=dat2_ AND fdat<=gl.bDATE ORDER BY fdat)
  LOOP
   FOR k IN (SELECT acc,nls FROM accounts
             WHERE kv=kv_ AND (nls = s0000_ OR nls=s0009_))
   LOOP
      IF k.nls=s0000_ THEN  nbs1_ := '1000';   nbs2_ := '7999';
      ELSE                  nbs1_ := '9000';   nbs2_ := '9999';      END IF;
      sdls_ := 0;
      dosd_ := 0;
      kosd_ := 0;
      SELECT MAX(fdat) INTO dat1_ FROM saldoa WHERE fdat<d.fdat;
      dat1_ := NVL(dat1_,d.fdat);
      IF deb.debug THEN
         deb.trace( ern,'('||kv_||')-- DATE --', dat1_||'-'||d.fdat);
      END IF;
      sumos_ := 0; -- Nominal ammount total
      FOR c IN
       (SELECT a.kv, s.acc, s.fdat, s.ostf, s.dos, s.kos
          FROM accounts a, saldoa s
         WHERE a.acc <> k.acc AND a.acc=s.acc AND
         (a.acc,s.fdat) =
         (SELECT c.acc,MAX(c.fdat) FROM saldoa c
           WHERE c.acc=a.acc AND c.fdat<=d.fdat GROUP BY c.acc) AND
         a.kv=kv_ AND a.nbs>=nbs1_ AND a.nbs<=nbs2_ AND a.pos=1)
      LOOP
         IF c.fdat=d.fdat THEN ostf_:=c.ostf;  dos_:=c.dos; kos_:=c.kos;
         ELSE                  ostf_:=c.ostf-c.dos+c.kos; dos_:=0; kos_:=0;
         END IF;
         sumos_ := sumos_ + ostf_;
--deb.trace(1,'===fdat',c.fdat);
--deb.trace(2,'===ostf',ostf_);
--deb.trace(3,'===dos',dos_);
--deb.trace(3,'===kos',kos_);
         ost1_:=gl.p_icurval(c.kv, ostf_, dat1_ );
         ost2_:=gl.p_icurval(c.kv, ostf_-dos_+kos_, d.fdat );
         dosq_:=gl.p_icurval(c.kv, dos_, d.fdat );
         kosq_:=gl.p_icurval(c.kv, kos_, d.fdat );
         dlta_:=ost2_-(ost1_-dosq_+kosq_);
         IF dlta_<0 THEN dosq_:=dosq_-dlta_;  ELSE kosq_:=kosq_+dlta_;
         END IF;
         BEGIN
            SELECT MAX(fdat) INTO pdat_
              FROM saldob WHERE acc=c.acc AND fdat <=d.fdat;
         EXCEPTION WHEN NO_DATA_FOUND THEN pdat_ := NULL;
         END;
         IF pdat_<>d.fdat AND dosq_=0 AND kosq_=0 THEN GOTO MET_EOL; END IF;
         IF pdat_ = d.fdat THEN
            UPDATE saldob SET ostf=ost2_-kosq_+dosq_,dos=dosq_,kos=kosq_
            WHERE acc=c.acc AND fdat=d.fdat;
         ELSE
            INSERT INTO saldob (acc,fdat,pdat,ostf,dos,kos)
            VALUES (c.acc,d.fdat,pdat_,ost2_-kosq_+dosq_,dosq_,kosq_);
         END IF;
         kosd_:= kosd_ + dosq_;
         dosd_:= dosd_ + kosq_;
<<MET_EOL>>
         sdls_:= sdls_ - ost2_ + kosq_ - dosq_;
      END LOOP;
      IF deb.debug THEN
         deb.trace(1,'SUMVAL',sumos_);
      END IF;
      IF dosd_>kosd_ THEN dosd_:=dosd_-kosd_; kosd_:=0;
                     ELSE kosd_:=kosd_-dosd_; dosd_:=0;      END IF;
      BEGIN
         SELECT MAX(fdat) INTO pdat_
         FROM saldob WHERE acc=k.acc AND fdat <=d.fdat;
      EXCEPTION  WHEN NO_DATA_FOUND THEN pdat_ := NULL;
      END;
      IF pdat_<>d.fdat AND dosd_=0 AND kosd_=0 THEN GOTO MET_EO2;  END IF;
      IF pdat_ = d.fdat THEN
         UPDATE saldob SET ostf=sdls_,dos=dosd_,kos=kosd_
         WHERE acc=k.acc AND fdat=d.fdat;
      ELSE
         INSERT INTO saldob (acc,fdat,pdat,ostf,dos,kos)
             VALUES (k.acc,d.fdat,pdat_,sdls_,dosd_,kosd_);
      END IF;
<<MET_EO2>>
      NULL;
   END LOOP;
   COMMIT;
   IF deb.debug THEN
      deb.trace(ern,'COMPLETED '||kv_,d.fdat);
   END IF;
END LOOP;
EXCEPTION WHEN err THEN raise_application_error(-(20000+ern),'\'||erm,TRUE);
          WHEN OTHERS THEN raise_application_error(-(20000+ern),SQLERRM,TRUE);
END p_rev_6;
/
show err;

PROMPT *** Create  grants  P_REV_6 ***
grant EXECUTE                                                                on P_REV_6         to WR_ALL_RIGHTS;



PROMPT ===================================================================================== 
PROMPT *** End *** ========== Scripts /Sql/BARS/Procedure/P_REV_6.sql =========*** End *** =
PROMPT ===================================================================================== 
