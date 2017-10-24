

PROMPT ===================================================================================== 
PROMPT *** Run *** ========== Scripts /Sql/BARS/Procedure/DYNTT.sql =========*** Run *** ===
PROMPT ===================================================================================== 


PROMPT *** Create  procedure DYNTT ***

  CREATE OR REPLACE PROCEDURE BARS.DYNTT (flg_ NUMBER, ref_ NUMBER, vdat_ DATE,
      dk_ NUMBER,kva_ NUMBER,nlsa_ VARCHAR2,sa_ NUMBER,
                 kvb_ NUMBER,nlsb_ VARCHAR2,sb_ NUMBER) IS

dk0_ INT;

BEGIN
   FOR c0 IN (SELECT tt FROM tts_dyn d,accounts a
               WHERE a.tip=d.tip AND a.nls=nlsb_ AND a.kv=kvb_)
   LOOP

      PAYTT( flg_,ref_,vdat_,c0.tt,dk_,kva_,nlsa_,sa_,kvb_,nlsb_,sb_);

      FOR c1 IN (SELECT t.tt,a.dk FROM tts t, ttsap a
                  WHERE a.ttap=t.tt and a.tt=c0.tt )
      LOOP
         IF c1.dk=1 THEN dk0_:=1-dk_; ELSE dk0_:=dk_; END IF;
         PAYTT( flg_,ref_,vdat_,c1.tt,dk0_,kva_,nlsa_,sa_,kvb_,nlsb_,sb_);
      END LOOP;

   END LOOP;
END;
 
/
show err;

PROMPT *** Create  grants  DYNTT ***
grant EXECUTE                                                                on DYNTT           to BARS014;
grant EXECUTE                                                                on DYNTT           to BARS_ACCESS_DEFROLE;
grant EXECUTE                                                                on DYNTT           to PYOD001;
grant EXECUTE                                                                on DYNTT           to WR_ALL_RIGHTS;



PROMPT ===================================================================================== 
PROMPT *** End *** ========== Scripts /Sql/BARS/Procedure/DYNTT.sql =========*** End *** ===
PROMPT ===================================================================================== 
