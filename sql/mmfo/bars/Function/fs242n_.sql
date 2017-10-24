
 
 PROMPT ===================================================================================== 
 PROMPT *** Run *** ========== Scripts /Sql/BARS/function/fs242n_.sql =========*** Run *** ==
 PROMPT ===================================================================================== 
 
  CREATE OR REPLACE FUNCTION BARS.FS242N_ (p240_ IN VARCHAR2) RETURN VARCHAR2 IS
  s242n_ VARCHAR2(1):='0';

   BEGIN
      IF (to_number(p240_)<= 0) THEN
         s242n_:='0';
      ELSIF (to_number(p240_)>0 and to_number(p240_)<6) THEN
         s242n_:='5';
      ELSIF (to_number(p240_) < 7) THEN
         s242n_:='6';
      ELSIF p240_ in ('7','8','A','B') THEN
         s242n_:='8';
      ELSIF p240_ in ('9','C','D','E','F','G','H') THEN
         s242n_:='9';
      ELSE
         s242n_:='0';
      END IF;

      RETURN s242n_;
   END;
/
 show err;
 
 
 
 PROMPT ===================================================================================== 
 PROMPT *** End *** ========== Scripts /Sql/BARS/function/fs242n_.sql =========*** End *** ==
 PROMPT ===================================================================================== 
 