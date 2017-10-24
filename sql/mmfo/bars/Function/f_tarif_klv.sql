
 
 PROMPT ===================================================================================== 
 PROMPT *** Run *** ========== Scripts /Sql/BARS/function/f_tarif_klv.sql =========*** Run **
 PROMPT ===================================================================================== 
 
  CREATE OR REPLACE FUNCTION BARS.F_TARIF_KLV 
   (p_kod NUMBER,
    p_ref NUMBER,
    p_kv  NUMBER,
    p_nls VARCHAR2,
    p_s   NUMBER
   )
RETURN NUMBER
IS
  l_type   CHAR(3);
  l_kvk    NUMBER;
  l_term   CHAR(1);
  l_tarif  NUMBER;
  l_sum    NUMBER;
  l_sq     NUMBER;
  ern      CONSTANT POSITIVE       := 825 ;
  err      EXCEPTION;
  erm      VARCHAR2(80);
BEGIN

  -- тип комиссии
  BEGIN
    SELECT substr(value,1,3)
      INTO l_type
      FROM operw
     WHERE ref = p_ref AND tag = 'KLVZA';
  EXCEPTION WHEN NO_DATA_FOUND THEN
    erm := '9700- '|| 'Відсутній вид затрат! '; RAISE err;
  END;

  -- валюта комиссии
  IF l_type = 'BEN' THEN
     l_kvk := p_kv;
  ELSE
     BEGIN
       SELECT to_number(substr(w.value,1,3))
         INTO l_kvk
         FROM operw w, tabval t
        WHERE w.ref = p_ref
          AND w.tag = 'KLVKV'
          AND t.kv = to_number(substr(w.value,1,3));
     EXCEPTION
       WHEN NO_DATA_FOUND THEN
         erm := '9701- '|| 'Відсутня валюта комісії!';
         RAISE err;
     END;
  END IF;

  BEGIN
    SELECT substr(w.value,1,1)
      INTO l_term
      FROM operw w
     WHERE w.ref = p_ref
       AND w.tag = '72   ';
  EXCEPTION
    WHEN NO_DATA_FOUND THEN
      erm := '9701- '|| 'Відсутня строковість переказу!';
      RAISE err;
  END;

  IF l_term NOT IN ('0','1','2') THEN
     erm := '9701- '|| 'Невірно вказана строковість переказу!';
     RAISE err;
  END IF;

  IF l_type = 'BEN' THEN
     IF    l_term = '0' THEN l_tarif := 67;
     ELSIF l_term = '1' THEN l_tarif := 66;
     ELSE                    l_tarif := 65;
     END IF;
  ELSIF l_type = 'OUR' THEN
     IF    l_term = '0' THEN l_tarif := 64;
     ELSIF l_term = '1' THEN l_tarif := 63;
     ELSE                    l_tarif := 60;
     END IF;
  ELSIF l_type = 'SHA' THEN
     IF    l_term = '0' THEN l_tarif := 63;
     ELSIF l_term = '1' THEN l_tarif := 60;
     ELSE                    l_tarif := 62;
     END IF;
  ELSE
     RETURN 0;
  END IF;

  IF    l_type = 'BEN' AND p_kod = 0  THEN
        SELECT f_tarif(l_tarif, p_kv, p_nls, p_s) INTO l_sum FROM dual;
  ELSIF l_type IN ('OUR','SHA') AND p_kod = 0 AND p_kv = l_kvk AND l_kvk <>980 THEN
        SELECT f_tarif(l_tarif, p_kv, p_nls, p_s) INTO l_sum FROM dual;
  ELSIF l_type IN ('SHA','OUR') AND p_kod = 1 AND p_kv <>l_kvk AND l_kvk = 980 THEN
        SELECT f_tarif(l_tarif, 980, p_nls, p_s) INTO l_sum FROM dual;
  ELSIF p_kod = 2 AND l_kvk <> 980 THEN
        l_sum := gl.p_icurval(p_kv,p_s,bankdate);
        SELECT f_tarif(l_tarif, 980, p_nls, l_sum) INTO l_sum FROM dual;
  ELSE
     RETURN 0;
  END IF;

  RETURN l_sum;

EXCEPTION
 WHEN err    THEN raise_application_error(-(20000+ern),'\'||erm,TRUE);
 WHEN OTHERS THEN raise_application_error(-(20000+ern),SQLERRM,TRUE);

END f_tarif_klv;
 
/
 show err;
 
PROMPT *** Create  grants  F_TARIF_KLV ***
grant EXECUTE                                                                on F_TARIF_KLV     to WR_ALL_RIGHTS;

 
 
 PROMPT ===================================================================================== 
 PROMPT *** End *** ========== Scripts /Sql/BARS/function/f_tarif_klv.sql =========*** End **
 PROMPT ===================================================================================== 
 