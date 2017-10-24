
 
 PROMPT ===================================================================================== 
 PROMPT *** Run *** ========== Scripts /Sql/BARS/function/to_binstr.sql =========*** Run *** 
 PROMPT ===================================================================================== 
 
  CREATE OR REPLACE FUNCTION BARS.TO_BINSTR (n number) RETURN varchar2
IS
	ncur NUMBER;
    cnt  SMALLINT;
    ret  VARCHAR2(64);
BEGIN
	ncur := n;
    ret  := '';
    WHILE ncur > 0
    LOOP
        ret  := MOD(ncur,2)||ret;
    	ncur := ncur/2-MOD(ncur,2)/2;
    END LOOP;
	RETURN ret;
END;
/
 show err;
 
 
 
 PROMPT ===================================================================================== 
 PROMPT *** End *** ========== Scripts /Sql/BARS/function/to_binstr.sql =========*** End *** 
 PROMPT ===================================================================================== 
 