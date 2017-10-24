
 
 PROMPT ===================================================================================== 
 PROMPT *** Run *** ========== Scripts /Sql/BARS/function/vbit.sql =========*** Run *** =====
 PROMPT ===================================================================================== 
 
  CREATE OR REPLACE FUNCTION BARS.VBIT (n number, bit smallint) RETURN number
IS
	ncur NUMBER;
    cnt  SMALLINT;
BEGIN
	cnt  := 1;
    ncur := n;
    WHILE cnt < bit
    LOOP
    	ncur := ncur/2-MOD(ncur,2)/2;
        cnt  := cnt + 1;
    END LOOP;
    RETURN MOD(ncur,2);
END;
/
 show err;
 
 
 
 PROMPT ===================================================================================== 
 PROMPT *** End *** ========== Scripts /Sql/BARS/function/vbit.sql =========*** End *** =====
 PROMPT ===================================================================================== 
 