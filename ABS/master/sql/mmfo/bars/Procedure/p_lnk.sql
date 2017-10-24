

PROMPT ===================================================================================== 
PROMPT *** Run *** ========== Scripts /Sql/BARS/Procedure/P_LNK.sql =========*** Run *** ===
PROMPT ===================================================================================== 


PROMPT *** Create  procedure P_LNK ***

  CREATE OR REPLACE PROCEDURE BARS.P_LNK ( ref_    INTEGER,
                  tt_    CHAR,
                  datV_  DATE,
                  dk_    NUMBER,
                  nlsa_  VARCHAR2,
                  kvA_   SMALLINT,
                  sa_    DECIMAL,
                  nlsb_  VARCHAR2,
                  kvb_   SMALLINT,
                  sb_    DECIMAL ) IS

flv_  SMALLINT;

kv_   SMALLINT;
nlsm_ VARCHAR2(15);
kvk_  SMALLINT;
nlsk_ VARCHAR2(15);
ss_   DECIMAL(24);

ern				CONSTANT POSITIVE := 063;
erm				VARCHAR2(80);
err				EXCEPTION;

BEGIN

   BEGIN
    SELECT flv, kv, nlsm, kvk, nlsk
      INTO flv_,kv_,nlsm_,kvk_,nlsk_
      FROM tts WHERE tt=tt_;
   EXCEPTION
      WHEN NO_DATA_FOUND THEN
         erm := 'No '||tt_||' operation defined';
         RAISE err;
   END;

   kv_  := NVL(kv_, kva_);
   kvk_ := NVL(kvk_,kvb_);

   IF nlsm_ IS NULL THEN
      nlsm_ := nlsa_;
   ELSE
      nlsm_ := sb_acc(nlsm_,nlsa_);
   END IF;

   IF nlsk_ IS NULL THEN
      nlsk_ := nlsb_;
   ELSE
      nlsk_ := sb_acc(nlsk_,nlsb_);
   END IF;

   IF flv_=1 THEN
      ss_ := sb_;
   ELSE
      ss_ := sa_;
     kvk_ := kv_;
   END IF;

/* ************************************************************** */

     gl.payv(1,ref_,datv_,tt_,dk_,kv_,nlsm_,sa_,kvk_,nlsk_,ss_);

/* ************************************************************** */

EXCEPTION
	WHEN err
        THEN
            raise_application_error(-(20000+ern),'\'||erm,TRUE);

	WHEN OTHERS
        THEN
	    raise_application_error(-(20000+ern),SQLERRM,TRUE);

END;
/
show err;



PROMPT ===================================================================================== 
PROMPT *** End *** ========== Scripts /Sql/BARS/Procedure/P_LNK.sql =========*** End *** ===
PROMPT ===================================================================================== 
