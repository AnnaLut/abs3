

PROMPT ===================================================================================== 
PROMPT *** Run *** ========== Scripts /Sql/BARS/Procedure/IN_PRKRB.sql =========*** Run *** 
PROMPT ===================================================================================== 


PROMPT *** Create  procedure IN_PRKRB ***

  CREATE OR REPLACE PROCEDURE BARS.IN_PRKRB (
 flag_  NUMBER,
 idg_   NUMBER,
 tt_    VARCHAR2,
 vob_   NUMBER,
 nlsa_  VARCHAR2,
 kva_   NUMBER,
 nlsb_  VARCHAR2,
 kvb_   NUMBER,
 mfob_  VARCHAR2,
 okpob_ VARCHAR2,
 koef_  NUMBER,
 namb_  VARCHAR2,
 nazn_  VARCHAR2,
 idr_   NUMBER) IS

-- (C) BARS. Load Perekr_b


ern         CONSTANT POSITIVE := 308;
err         EXCEPTION;
erm         VARCHAR2(80);

acc_      NUMBER;
ids_      NUMBER;

BEGIN

IF deb.debug THEN
   deb.trace( ern, 'module/0', 'in_prkrb');
END IF;

BEGIN
   SELECT acc INTO acc_ FROM accounts WHERE nls=trim(nlsa_) AND kv=kva_;
EXCEPTION
   WHEN NO_DATA_FOUND THEN
---   raise_application_error(-(20000+ern),'\'||nlsa_,TRUE);
   RETURN;
END;

ids_ := NULL;
BEGIN
   SELECT  ids INTO ids_ FROM specparam WHERE acc=acc_;
EXCEPTION
   WHEN NO_DATA_FOUND THEN
      INSERT INTO specparam(acc) VALUES(acc_);
END;

ids_ := NVL(ids_,TO_NUMBER(TRIM(nlsa_)));

BEGIN
   SELECT ids INTO ids_ FROM perekr_s WHERE ids=ids_;
EXCEPTION
   WHEN NO_DATA_FOUND THEN
      INSERT INTO perekr_s(ids,name) VALUES(ids_,'Schema acc'||nlsa_);
END;

UPDATE specparam SET idg=idg_,ids=ids_ WHERE acc=acc_;

IF flag_=0 THEN
   DELETE FROM perekr_b WHERE ids=ids_;
END IF;

INSERT INTO perekr_b (IDS,TT,MFOB,NLSB,POLU,NAZN,KV,OKPO,IDR,KOEF,VOB)
    VALUES (ids_,TRIM(tt_),TRIM(mfob_),TRIM(nlsb_),TRIM(namb_),TRIM(nazn_),
            kvb_,TRIM(okpob_),idr_,koef_,vob_);

EXCEPTION
   WHEN err
        THEN
            raise_application_error(-(20000+ern),'\'||erm,TRUE);

   WHEN OTHERS
        THEN
	    raise_application_error(-(20000+ern),SQLERRM,TRUE);
END in_prkrb;
 
/
show err;

PROMPT *** Create  grants  IN_PRKRB ***
grant EXECUTE                                                                on IN_PRKRB        to BARS015;
grant EXECUTE                                                                on IN_PRKRB        to BARS_ACCESS_DEFROLE;
grant EXECUTE                                                                on IN_PRKRB        to WR_ALL_RIGHTS;



PROMPT ===================================================================================== 
PROMPT *** End *** ========== Scripts /Sql/BARS/Procedure/IN_PRKRB.sql =========*** End *** 
PROMPT ===================================================================================== 
