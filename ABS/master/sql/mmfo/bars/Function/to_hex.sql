
 
 PROMPT ===================================================================================== 
 PROMPT *** Run *** ========== Scripts /Sql/BARS/function/to_hex.sql =========*** Run *** ===
 PROMPT ===================================================================================== 
 
  CREATE OR REPLACE FUNCTION BARS.TO_HEX (Src VARCHAR2)
RETURN VARCHAR2
IS
    n       NUMBER;
	c		NUMBER;
	i		NUMBER;
	Dst	  	VARCHAR2(8000);
BEGIN
	IF Src IS NULL THEN
	    RETURN NULL;
    END IF;

	n := Length(Src);
	IF n = 0 THEN
	    RETURN '';
    END IF;

	Dst := '';
	FOR i IN 1..n LOOP
		c := Ascii(Substr(Src, i, 1));
		Dst := Dst || F16x(Trunc(c/16,0)) || F16x(MOD(c, 16));
	END LOOP;
	RETURN Dst;
END TO_HEX;
 
/
 show err;
 
PROMPT *** Create  grants  TO_HEX ***
grant EXECUTE                                                                on TO_HEX          to ABS_ADMIN;
grant EXECUTE                                                                on TO_HEX          to BARS_ACCESS_DEFROLE;
grant EXECUTE                                                                on TO_HEX          to WR_ALL_RIGHTS;

 
 
 PROMPT ===================================================================================== 
 PROMPT *** End *** ========== Scripts /Sql/BARS/function/to_hex.sql =========*** End *** ===
 PROMPT ===================================================================================== 
 