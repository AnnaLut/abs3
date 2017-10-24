
 
 PROMPT ===================================================================================== 
 PROMPT *** Run *** ========== Scripts /Sql/BARS/function/f_mvo_sabo_nazn.sql =========*** Ru
 PROMPT ===================================================================================== 
 
  CREATE OR REPLACE FUNCTION BARS.F_MVO_SABO_NAZN 
  (p_nlsd VARCHAR2,
   p_nlsk VARCHAR2,
   p_type CHAR       DEFAULT 'N')
RETURN VARCHAR2
IS
  l_nazn VARCHAR2(160);
  l_vob  NUMBER;
  l_tt   CHAR(3);
BEGIN

  IF p_nlsd IS NULL OR p_nlsk IS NULL THEN
     RETURN '';
  END IF;

  --1. 100%-ное попадание
  BEGIN
    SELECT nazn, tt, vob INTO l_nazn, l_tt, l_vob
      FROM mvo_sabo_nazn
     WHERE nlsd = p_nlsd AND nlsk = p_nlsk;
  EXCEPTION
     WHEN NO_DATA_FOUND THEN
       --2. 50%-ное попадание
       BEGIN
         SELECT nazn, tt, vob INTO l_nazn, l_tt, l_vob
           FROM mvo_sabo_nazn
          WHERE ((nlsd = p_nlsd AND nlsk = substr(p_nlsk,1,4))
             OR  (nlsk = p_nlsk AND nlsd = substr(p_nlsd,1,4)))
             AND rownum = 1;
       EXCEPTION
         WHEN NO_DATA_FOUND THEN
           --3. 25%-ное попадание
           BEGIN
             SELECT nazn, tt, vob INTO l_nazn, l_tt, l_vob
               FROM mvo_sabo_nazn
              WHERE nlsd = substr(p_nlsd,1,4)
                AND nlsk = substr(p_nlsk,1,4)
	        AND rownum = 1;
           EXCEPTION
             WHEN NO_DATA_FOUND THEN
               l_nazn := 'Консолідовані операції від МВО';
                 l_tt := null;
                l_vob := to_number(null);
           END;
       END;
  END;

  IF    p_type = 'N' THEN   RETURN l_nazn ;
  ELSIF p_type = 'V' THEN   RETURN to_char(l_vob);
  ELSIF p_type = 'T' THEN   RETURN to_char(l_tt);
  ELSE                      RETURN null;
  END IF;

END;
/
 show err;
 
PROMPT *** Create  grants  F_MVO_SABO_NAZN ***
grant EXECUTE                                                                on F_MVO_SABO_NAZN to BARS_ACCESS_DEFROLE;
grant EXECUTE                                                                on F_MVO_SABO_NAZN to MVO;

 
 
 PROMPT ===================================================================================== 
 PROMPT *** End *** ========== Scripts /Sql/BARS/function/f_mvo_sabo_nazn.sql =========*** En
 PROMPT ===================================================================================== 
 