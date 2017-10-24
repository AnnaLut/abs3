

PROMPT ===================================================================================== 
PROMPT *** Run *** ========== Scripts /Sql/BARS/Procedure/GETXRATETOBO.sql =========*** Run 
PROMPT ===================================================================================== 


PROMPT *** Create  procedure GETXRATETOBO ***

  CREATE OR REPLACE PROCEDURE BARS.GETXRATETOBO 
( rat_o OUT NUMBER,     -- xrato
  rat_b OUT NUMBER,     -- xratb
  rat_s OUT NUMBER,     -- xrats
  kv1_      NUMBER,     -- cur1
  kv2_      NUMBER,     -- cur2
  dat_      DATE DEFAULT NULL ) IS

--процедура переопределения кросс-курсов пок-прод валют

-----------------------------------------------------------

tobo_     varchar2(30);
rdat_     DATE;
DatTmp_   DATE;
   ern    CONSTANT POSITIVE := 103;
   erm    VARCHAR2(80);
   err    EXCEPTION;
BEGIN
  GL.x_rat ( rat_o, rat_b, rat_s,  kv1_, kv2_, dat_ );
  IF kv1_ in (840, 978, 643) and kv2_=gl.baseval THEN
    BEGIN
      tobo_ := tobopack.getTOBO;
    EXCEPTION WHEN OTHERS THEN
      erm := '9001 - Невозможно получить код ТОБО';  RAISE err;
    END;
    IF tobo_ is not null and tobo_ <> '0' THEN
      IF dat_ IS NULL THEN
        rdat_ := gl.bDATE;
      ELSE
        rdat_ := dat_;
      END IF;
      BEGIN
        SELECT MAX(vdate)
        INTO   DatTmp_
        FROM   cur_rates$base
        WHERE  branch=tobo_ AND kv=kv1_ AND vdate <= rdat_ ;

        SELECT RATE_B/BSUM,  RATE_S/BSUM
        INTO   rat_b      ,  rat_s
        FROM   cur_rates$base
        WHERE  branch=tobo_ AND kv=kv1_ AND vdate = DatTmp_ ;
      EXCEPTION WHEN NO_DATA_FOUND THEN
        GL.x_rat ( rat_o, rat_b, rat_s,  kv1_, kv2_, rdat_ );
      END;
    END IF;
  END IF;

  RETURN;

EXCEPTION
   WHEN err THEN
      raise_application_error(-(20000+ern),'\' ||erm,TRUE);
   WHEN OTHERS THEN
      raise_application_error(-(20000+ern),SQLERRM,TRUE);
END GetXRateTobo;
 
/
show err;

PROMPT *** Create  grants  GETXRATETOBO ***
grant EXECUTE                                                                on GETXRATETOBO    to BARS_ACCESS_DEFROLE;
grant EXECUTE                                                                on GETXRATETOBO    to START1;
grant EXECUTE                                                                on GETXRATETOBO    to WR_ALL_RIGHTS;
grant EXECUTE                                                                on GETXRATETOBO    to WR_DOC_INPUT;



PROMPT ===================================================================================== 
PROMPT *** End *** ========== Scripts /Sql/BARS/Procedure/GETXRATETOBO.sql =========*** End 
PROMPT ===================================================================================== 
