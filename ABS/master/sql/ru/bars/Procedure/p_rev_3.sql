

PROMPT ===================================================================================== 
PROMPT *** Run *** ========== Scripts /Sql/BARS/Procedure/P_REV_3.sql =========*** Run *** =
PROMPT ===================================================================================== 


PROMPT *** Create  procedure P_REV_3 ***

  CREATE OR REPLACE PROCEDURE BARS.P_REV_3 ( kv_ NUMBER, dat_ DATE ) IS
--==== Промежуточная процедура переоценки Суховой на 2-вешалках 35* и 36*--

 datP_  DATE  ; ost1_  NUMBER ;  dosq_ NUMBER;  dos_ NUMBER;
 datN_  DATE  ; ost2_  NUMBER ;  kosq_ NUMBER;  kos_ NUMBER;
 pdaA_  DATE  ; nbs1_  CHAR(4);  dlta_ NUMBER;  VX_   NUMBER;
 pdaP_  DATE  ; nbs2_  CHAR(4);  ostf_ NUMBER;  IX_   NUMBER;
 pdat_  DATE  ; V_     int    ;  S6_   number;
 ACCP_  int   ; ACCA_  int    ;  ACC9_ int   ;

ern  CONSTANT POSITIVE := 212;
err  EXCEPTION;
erm  VARCHAR2(80);
-----------
BEGIN
  begin
    select NVL(a9.acc,-9), aa.acc, ap.acc  into ACC9_, ACCA_, ACCP_
    from accounts a9, accounts aa, accounts ap, tabval t
    where t.kv=a9.kv(+) and t.s0009=a9.nls(+) and t.kv=KV_   and
          t.kv=aa.kv and t.s3800=aa.nls and t.kv=ap.kv and t.s3801=ap.nls ;
  EXCEPTION  WHEN NO_DATA_FOUND THEN
    erm := '9410 - scheta techn.pereoc not open #'||kv_;   RAISE err;
  END;

datN_ := NVL(dat_,gl.bDATE);

  --обработка вешалки 6204
  begin
    select (s.ostf-s.dos+s.kos), a.acc, s.fdat
    into S6_, V_ , pdat_
    from accounts a, tabval t, saldob s
    where t.kv=KV_ and t.kv=a.kv and t.s0000=a.nls and a.acc=s.acc and
          (a.acc,s.fdat)=(select acc, max(fdat) from saldob
                          where acc=a.acc and fdat<datN_ group by acc ) ;
    if    S6_ <> 0 then
       INSERT INTO saldob (acc, fdat, pdat, ostf, dos, kos)
        VALUES (V_, datN_, pdat_, S6_, greatest(0,S6_), -least(0,S6_) );
    end if;
  EXCEPTION  WHEN NO_DATA_FOUND THEN S6_:=0;
  END;

FOR d IN (SELECT fdat FROM fdat WHERE fdat>=datN_  ORDER BY fdat)
LOOP
   FOR V_ in 1..2
   LOOP
      IF V_=1 THEN nbs1_:='1000'; nbs2_:='7999';
      ELSE         nbs1_:='9000'; nbs2_:='9999';
      END IF;
--deb.trace(1,'0', S6_)
      VX_ := -S6_;   S6_:=0;   IX_:=0 ;

      SELECT NVL(MAX(fdat),d.fdat)
      INTO datP_
      FROM saldoa
      WHERE fdat<d.fdat ;

      FOR c IN (SELECT s.acc, s.fdat, s.ostf, s.dos, s.kos, A.NLS
                FROM accounts a, saldoa s
                WHERE a.acc not in (ACCA_, ACCP_, ACC9_) AND
                      a.acc=s.acc    AND
                     (a.acc,s.fdat) =
                     (SELECT c.acc,MAX(c.fdat)
                      FROM saldoa c
                      WHERE c.acc=a.acc AND c.fdat<=d.fdat
                      GROUP BY c.acc)
                 AND a.kv=kv_ AND a.nbs>=nbs1_ AND a.nbs<=nbs2_ AND a.pos=1
                )
      LOOP

         --вх.остатов в номинале
         IF c.fdat=d.fdat THEN ostf_ := c.ostf; dos_ := c.dos; kos_ := c.kos;
         ELSE       ostf_ :=c.ostf-c.dos+c.kos; dos_ :=0;      kos_ :=0;
         END IF;

         ost1_:=gl.p_icurval(kv_, ostf_, datP_ );            --экв вх
         ost2_:=gl.p_icurval(kv_, ostf_-dos_+kos_, d.fdat ); --экв исх
         dosq_:=gl.p_icurval(kv_, dos_, d.fdat );            --экв DOS
         kosq_:=gl.p_icurval(kv_, kos_, d.fdat );            --экв KOS
         dlta_:=ost2_-(ost1_-dosq_+kosq_);          --переоценка
         IF    DLTA_ <0 THEN dosq_:=dosq_-dlta_;
         ELSif DLTA_ >0 then kosq_:=kosq_+dlta_;
         END IF;

         VX_:= VX_ - ost1_ ;  IX_:= IX_ - ost2_ ;

         IF dosq_<>0 or kosq_<> 0 THEN
            --переоценка текущего счета в saldoB
            BEGIN
               SELECT MAX(fdat) INTO pdat_ FROM saldob WHERE acc=c.acc;
            EXCEPTION WHEN NO_DATA_FOUND THEN pdat_ := NULL;
            END;
            INSERT INTO saldob (acc, fdat, pdat, ostf, dos, kos)
              VALUES (c.acc, d.fdat, pdat_, ost1_, dosq_, kosq_);
         end if;
      END LOOP;
      ------------------

      if VX_ = IX_ THEN     GOTO MET_EO2;    END IF;

      if V_ = 2      then
         SELECT MAX(fdat)INTO pdat_ FROM saldob WHERE acc=ACC9_ AND fdat<d.fdat;
         if VX_ > IX_ then
            INSERT INTO saldob (acc, fdat, pdat, ostf, dos, kos)
                 VALUES (ACC9_, d.fdat, pdat_, VX_, VX_-IX_, 0 );
         else
            INSERT INTO saldob (acc, fdat, pdat, ostf, dos, kos)
                  VALUES (ACC9_, d.fdat, pdat_, VX_, 0, IX_-VX_);
         end if;
      else
         SELECT MAX(fdat)INTO pdaP_ FROM saldob WHERE acc=ACCP_ AND fdat<d.fdat;
         SELECT MAX(fdat)INTO pdaA_ FROM saldob WHERE acc=ACCA_ AND fdat<d.fdat;
         ------------------------------------------------------|00|0-|+0|+-|
         If    VX_ >=0 and IX_<=0 then
            If VX_ > 0 then
               -- обнуление кредитового
               INSERT INTO saldob (acc, fdat, pdat, ostf, dos, kos)
                      VALUES    (ACCP_, d.fdat, pdaP_, VX_, VX_, 0);
            end if;
            If IX_ < 0 then
               -- разворачивание дебетового
               INSERT INTO saldob (acc, fdat, pdat, ostf, dos, kos)
                      VALUES     (ACCA_, d.fdat, pdaA_, 0, -IX_, 0);
            end if;
         ------------------------------------------------------|0+|-+|
         ElsIf VX_ <=0 and IX_>0 then
            If VX_ < 0 then
               -- обнуление дебетового
               INSERT INTO saldob (acc, fdat, pdat, ostf, dos, kos)
                      VALUES   (ACCA_, d.fdat, pdaA_, VX_, 0, -VX_);
            end if;
            If IX_ >0  then
               -- разворачивание кредитового
               INSERT INTO saldob (acc, fdat, pdat, ostf, dos, kos)
                      VALUES      (ACCP_, d.fdat, pdaP_, 0, 0, IX_);
            end if;
         ------------------------------------------------------|++|
         ElsIf VX_ >0 and IX_>0 then
            if    VX_>IX_ then
               -- ДЕБ  по кредитовому
               INSERT INTO saldob (acc, fdat, pdat, ostf, dos, kos)
                     VALUES (ACCP_, d.fdat, pdaP_, VX_, VX_-IX_, 0);
            Elsif VX_<IX_ then
               -- КРЕД по кредитовому
               INSERT INTO saldob (acc, fdat, pdat, ostf, dos, kos)
                     VALUES (ACCP_, d.fdat, pdaP_, VX_, 0, IX_-VX_);
            end if;
        -------------------------------------------------------|-0|--|
         ElsIf VX_< 0 and IX_<=0  then
            If    VX_ < IX_ then
               -- КРЕД по дебетовому
               INSERT INTO saldob (acc, fdat, pdat, ostf, dos, kos)
                     VALUES (ACCA_, d.fdat, pdaA_, VX_, 0, IX_-VX_);
            ElsIf VX_ > IX_ then
               -- ДЕБ  по дебетовому
               INSERT INTO saldob (acc, fdat, pdat, ostf, dos, kos)
                     VALUES (ACCA_, d.fdat, pdaA_, VX_, VX_-IX_, 0);            end if;
         end if;
         ------------------------------------------------------|
      END IF;

    <<MET_EO2>>
      NULL;
   END LOOP;
   COMMIT;
END LOOP;

EXCEPTION
   WHEN err    THEN raise_application_error(-(20000+ern),'\'||erm,TRUE);
   WHEN OTHERS THEN raise_application_error(-(20000+ern),SQLERRM,TRUE);
END p_rev_3;
/
show err;

PROMPT *** Create  grants  P_REV_3 ***
grant EXECUTE                                                                on P_REV_3         to WR_ALL_RIGHTS;



PROMPT ===================================================================================== 
PROMPT *** End *** ========== Scripts /Sql/BARS/Procedure/P_REV_3.sql =========*** End *** =
PROMPT ===================================================================================== 
