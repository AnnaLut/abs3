
 
 PROMPT ===================================================================================== 
 PROMPT *** Run *** ========== Scripts /Sql/BARS/function/p_ncurval.sql =========*** Run *** 
 PROMPT ===================================================================================== 
 
  CREATE OR REPLACE FUNCTION BARS.P_NCURVAL (
iCur		NUMBER,
iSum		NUMBER,
dDesiredDate	DATE,
iType           NUMBER	DEFAULT 0,
iDefaultValue	NUMBER	DEFAULT 1,
iUseFuture	NUMBER	DEFAULT 0,
iCheck4Errors	NUMBER	DEFAULT 0 )

RETURN NUMBER IS         -- ToBeDone: Value, Date, Status

iDig     NUMBER;
iDigMain NUMBER;
str1  	 CHAR(6);
fVal  	 NUMBER;
dDate 	 DATE;

CURSOR c0 IS
   SELECT DISTINCT vdate,
                   rate_o/bsum
   FROM  cur_rates
   WHERE vdate = ( SELECT MAX (vdate)
                   FROM cur_rates
                   WHERE vdate <= dDesiredDate AND kv = iCur )
     AND kv = iCur
   UNION
   SELECT DISTINCT vdate,
                   rate_o/bsum
   FROM  cur_rates
   WHERE vdate = ( SELECT MIN (vdate)
                   FROM cur_rates
                   WHERE vdate > dDesiredDate AND kv = iCur )
     AND kv=iCur;

BEGIN
   -- Verifying parameters
   IF iCheck4Errors = 1 THEN
      IF (iCur <= 0) THEN
         RETURN -2;    		-- Curr <=0
      END IF;
   END IF;
   IF iCur = gl.baseval THEN
      RETURN iSum;
   END IF;
   IF iCheck4Errors = 1 THEN
      IF iSum < 0 THEN
         RETURN -1;         	-- Sum <0
      END IF;
   END IF;

   IF iSum = 0 THEN
      RETURN 0;          -- Sum =0
   END IF;

   IF iType = 0 THEN
      str1:='rate_o';
   ELSIF iType = 1 THEN
      str1:='rate_b';
   ELSIF iType = 2 THEN
      str1:='rate_s';
   ELSE
      RETURN -4;
   END IF;

   -- Get Digs for currencies
   BEGIN
      SELECT DISTINCT dig  INTO iDig  FROM tabval  WHERE kv = iCur;
   EXCEPTION
      WHEN NO_DATA_FOUND THEN iDig := NULL;
   END;
   BEGIN
      SELECT DISTINCT dig  INTO iDigMain  FROM tabval  WHERE kv = gl.baseval;
   EXCEPTION
      WHEN NO_DATA_FOUND THEN iDigMain := NULL;
   END;

   IF iCheck4Errors = 1 THEN
      IF iDig IS NULL THEN
         RETURN -2;
      END IF;
      IF iDigMain IS NULL THEN
         RETURN -3;
      END IF;
   ELSE
      IF iDig IS NULL THEN
         iDig:=2;
      END IF;
      IF iDigMain IS NULL THEN
         iDigMain:=2;
      END IF;
   END IF;

   OPEN c0;
   LOOP
      FETCH c0 INTO dDate, fVal;
      EXIT WHEN c0%NOTFOUND;

      IF (dDate <= dDesiredDate) OR (iUseFuture=1) THEN
         fVal := ROUND(iSum/(fVal*POWER(10,(iDigMain-iDig))),0);
         IF (fVal =  0) AND (iSum <> 0) THEN
            RETURN SIGN(iSum);
         ELSE
            RETURN fVal;
         END IF;
      END IF;
   END LOOP;

   fVal := iDefaultValue * ROUND(iSum/POWER(10,(iDigMain-iDig)),0);
   RETURN fVal;

END p_Ncurval;
/
 show err;
 
PROMPT *** Create  grants  P_NCURVAL ***
grant EXECUTE                                                                on P_NCURVAL       to ABS_ADMIN;
grant EXECUTE                                                                on P_NCURVAL       to BARS_ACCESS_DEFROLE;
grant EXECUTE                                                                on P_NCURVAL       to RPBN001;
grant EXECUTE                                                                on P_NCURVAL       to WR_ALL_RIGHTS;

 
 
 PROMPT ===================================================================================== 
 PROMPT *** End *** ========== Scripts /Sql/BARS/function/p_ncurval.sql =========*** End *** 
 PROMPT ===================================================================================== 
 