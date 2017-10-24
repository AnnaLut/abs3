

PROMPT ===================================================================================== 
PROMPT *** Run *** ========== Scripts /Sql/BARS/Procedure/PVP1.sql =========*** Run *** ====
PROMPT ===================================================================================== 


PROMPT *** Create  procedure PVP1 ***

  CREATE OR REPLACE PROCEDURE BARS.PVP1 ( kv_ NUMBER DEFAULT NULL, dat_ date) IS
n1_    VARCHAR(14);   -- sch EKV VAL POZ
n2_    VARCHAR(14);   -- sch PER VAL POZ
s2_    DECIMAL(16,0); -- VAL POZ tek  kurs
s3_    DECIMAL(16,0); -- na sch EKV VAL POZ
ref_   integer;
dk_    integer;
dk1_   integer;
s0_    decimal(16,0);
CURSOR c0 IS
SELECT decode( a.tip, 'VVP', t.s9281, t.s3801 ),
       decode( a.tip, 'VVP', t.s9282, t.s3802 ),
       SUM( fostn(a.acc,dat_,dat_) )
FROM accounts a, tabval t
WHERE a.tip in ('VP ','VVP', 'VP')
  AND a.kv=t.kv
  AND (a.kv=kv_ or kv_ is NULL)
GROUP BY decode( a.tip, 'VVP', t.s9281, t.s3801 ),
         decode( a.tip, 'VVP', t.s9282, t.s3802 )
ORDER BY 1, 2;
ern         CONSTANT POSITIVE := 205;
err         EXCEPTION;
erm         VARCHAR2(80);
BEGIN
IF deb.debug THEN
   deb.trace( ern, 'module/0', 'pvp');
   deb.trace( ern, 'Currency code', kv_ );
END IF;
OPEN c0;
LOOP <<MET>>
     FETCH c0 INTO n1_,n2_,s2_;
     EXIT WHEN c0%NOTFOUND;
     IF deb.debug THEN
        deb.trace( ern, 'N1 Eqv Curr Pos', n1_);
        deb.trace( ern, 'N2 Pereoc Curr Pos', n2_);
        deb.trace( ern, 'S2', s2_);
     END IF;
     IF n1_ is NULL  OR  n2_ IS NULL THEN
        GOTO MET; -- ne zapolnen TABVAL
     END IF;
     BEGIN
        SELECT fost(acc,dat_)
        INTO s3_
        FROM accounts
        WHERE nls = n1_
          AND kv  = gl.baseval;
     EXCEPTION
        WHEN NO_DATA_FOUND THEN
            s3_ := 0;
     END;
     IF deb.debug THEN
        deb.trace( ern, 'S3/0', s3_);
     END IF;
     s3_ := s2_ + s3_;
     IF deb.debug THEN
        deb.trace( ern, 'S3/1', s3_);
     END IF;
     IF s3_ = 0 THEN  -- est ravenstvo
        GOTO MET;
     END IF;
     IF s3_ >0 THEN
        dk_ := 0;
     ELSE
        s3_ := -s3_;
        dk_ :=1;
     END IF;
     gl.ref (ref_);
     s0_  := 0;
     dk1_ := 1 - dk_;
     INSERT INTO oper (ref,   tt, pdat, vdat)
            VALUES    (ref_,'PVP',dat_, dat_);
     gl.pay ( 0,
           ref_,
           dat_,
           'PVP',
           gl.baseval,
           dk_,
           n1_,
           s3_,
           s0_,
           'PEREOCENKA');
     gl.pay ( 1,
           ref_,
           dat_,
           'PVP',
           gl.baseval,
           dk1_,
           n2_,
           s3_,
           s0_,
           'PEREOCENKA');
   END LOOP;
EXCEPTION
	WHEN err
        THEN
            raise_application_error(-(20000+ern),'\'||erm,TRUE);
	WHEN OTHERS
        THEN
	    raise_application_error(-(20000+ern),SQLERRM,TRUE);
END pvp1;
/
show err;



PROMPT ===================================================================================== 
PROMPT *** End *** ========== Scripts /Sql/BARS/Procedure/PVP1.sql =========*** End *** ====
PROMPT ===================================================================================== 
