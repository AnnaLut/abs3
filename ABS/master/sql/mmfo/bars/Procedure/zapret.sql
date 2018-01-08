

PROMPT ===================================================================================== 
PROMPT *** Run *** ========== Scripts /Sql/BARS/Procedure/ZAPRET.sql =========*** Run *** ==
PROMPT ===================================================================================== 


PROMPT *** Create  procedure ZAPRET ***

  CREATE OR REPLACE PROCEDURE BARS.ZAPRET (ret_ OUT INT, codcagent_ int, k070_ varchar2, k080_  varchar2 ) IS
kol_   Number;
ern          CONSTANT POSITIVE := 337;    -- Trigger err code
err          EXCEPTION; erm          VARCHAR2(80);
BEGIN

/* --------Проверка ПАР по kod_7120
SELECT count(*) INTO  kol_ FROM  kl_k070 K, codcagent G,  kod_7120  D
WHERE  k070_ = K.k070 and  K.k071 = D.k071  and  codcagent_ =G.codcagent and
       G.rezid   = D.k030+0    ;
IF kol_>0 THEN erm:='7777 - ERR ! [K030]+[K070]'; RAISE err;  END IF;
----Проверка ТРИАД по kod_7181
SELECT count(*) INTO   kol_
FROM   kl_k070   K,   kl_k080   L,   codcagent G,    kod_7181 D
WHERE k070_  =K.k070   and codcagent_ = G.codcagent and k080_  =L.k080 and
      K.k071 = D.k071  and G.rezid=D.k030+0         and L.k081 =D.k081 ;
IF kol_>0 THEN erm:='7778 - ERR ! [K030]+[K070]+[K080]'; RAISE err; END IF; */

ret_ := 0;
RETURN;
EXCEPTION WHEN err THEN raise_application_error(-(20000+ern),'\'||erm,TRUE);
END zapret;
/
show err;



PROMPT ===================================================================================== 
PROMPT *** End *** ========== Scripts /Sql/BARS/Procedure/ZAPRET.sql =========*** End *** ==
PROMPT ===================================================================================== 
