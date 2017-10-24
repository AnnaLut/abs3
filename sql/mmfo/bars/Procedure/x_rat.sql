

PROMPT ===================================================================================== 
PROMPT *** Run *** ========== Scripts /Sql/BARS/Procedure/X_RAT.sql =========*** Run *** ===
PROMPT ===================================================================================== 


PROMPT *** Create  procedure X_RAT ***

  CREATE OR REPLACE PROCEDURE BARS.X_RAT ( rat_o OUT NUMBER,     -- xrato
                  rat_b OUT NUMBER,     -- xratb
                  rat_s OUT NUMBER,     -- xrats
                   kv1_ NUMBER,         -- cur1
                   kv2_ NUMBER,         -- cur2
                   dat_ DATE DEFAULT NULL ) IS
rdat_     DATE;
i         SMALLINT;
kv_       SMALLINT;
rato_    DECIMAL(9,4);
ratb_    DECIMAL(9,4);
rats_    DECIMAL(9,4);
rat1_o   DECIMAL(9,4);
rat1_b   DECIMAL(9,4);
rat1_s   DECIMAL(9,4);
rat2_o   DECIMAL(9,4);
rat2_b   DECIMAL(9,4);
rat2_s   DECIMAL(9,4);
bsum_     DECIMAL;
bsum1_    DECIMAL;
bsum2_    DECIMAL;
ern         CONSTANT POSITIVE := 223;  -- Cannot obtain rate
err         EXCEPTION;
erm         VARCHAR2(80);
BEGIN
   IF dat_ IS NULL THEN
      rdat_ := gl.bDATE;
   ELSE
      rdat_ := dat_;
   END IF;
   FOR i IN 1 .. 2 LOOP
      IF i=1 THEN
         kv_ := kv1_;
      ELSE
         kv_ := kv2_;
      END IF;
      BEGIN
         SELECT bsum,rate_o,rate_b,rate_s
           INTO bsum_,rato_, ratb_, rats_
           FROM cur_rates WHERE kv=kv_ AND vdate =
        (SELECT MAX(vdate) FROM cur_rates WHERE kv=kv_ AND vdate <= rdat_);
      EXCEPTION
         WHEN NO_DATA_FOUND THEN
              erm := '8032 - No rate was set for curency #'||TO_CHAR(kv_);
              RAISE err;
      END;
   IF deb.debug THEN
      deb.trace(ern,'kv',kv_);
      deb.trace(ern,'rat',rato_);
   END IF;
      IF i=1 THEN
         rat1_o := rato_;
         IF ratb_ IS NULL THEN
            rat1_b := rato_;
         ELSE
            rat1_b := ratb_;
         END IF;
         IF rats_ IS NULL THEN
            rat1_s := rato_;
         ELSE
            rat1_s := rats_;
         END IF;
         bsum1_ := bsum_;
      ELSE
         rat2_o := rato_;
         IF ratb_ IS NULL THEN
            rat2_b := rato_;
         ELSE
            rat2_b := ratb_;
         END IF;
         IF rats_ IS NULL THEN
            rat2_s := rato_;
         ELSE
            rat2_s := rats_;
         END IF;
         bsum2_ := bsum_;
      END IF;
   END LOOP;
   rat_o := bsum2_*rat1_o/rat2_o/bsum1_;
   rat_b := bsum2_*rat1_b/rat2_s/bsum1_;
   rat_s := bsum2_*rat1_s/rat2_b/bsum1_;
   RETURN;
EXCEPTION
	WHEN err
        THEN
            raise_application_error(-(20000+ern),'\'||erm,TRUE);
	WHEN OTHERS
        THEN
	    raise_application_error(-(20000+ern),SQLERRM,TRUE);
END x_rat;
/
show err;



PROMPT ===================================================================================== 
PROMPT *** End *** ========== Scripts /Sql/BARS/Procedure/X_RAT.sql =========*** End *** ===
PROMPT ===================================================================================== 
