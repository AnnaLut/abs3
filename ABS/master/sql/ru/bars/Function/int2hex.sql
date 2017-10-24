
 
 PROMPT ===================================================================================== 
 PROMPT *** Run *** ========== Scripts /Sql/BARS/function/int2hex.sql =========*** Run *** ==
 PROMPT ===================================================================================== 
 
  CREATE OR REPLACE FUNCTION BARS.INT2HEX (n PLS_INTEGER)
  RETURN VARCHAR2 IS
BEGIN
  IF n>0 THEN
    RETURN int2hex(TRUNC(n/16))||SUBSTR('0123456789ABCDEF',MOD(n,16)+1,1);
  ELSE
    RETURN NULL;
  END IF;
END int2hex;
/
 show err;
 
 
 
 PROMPT ===================================================================================== 
 PROMPT *** End *** ========== Scripts /Sql/BARS/function/int2hex.sql =========*** End *** ==
 PROMPT ===================================================================================== 
 