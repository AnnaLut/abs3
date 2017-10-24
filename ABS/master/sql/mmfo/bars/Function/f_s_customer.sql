
 
 PROMPT ===================================================================================== 
 PROMPT *** Run *** ========== Scripts /Sql/BARS/function/f_s_customer.sql =========*** Run *
 PROMPT ===================================================================================== 
 
  CREATE OR REPLACE FUNCTION BARS.F_S_CUSTOMER ( sMode VARCHAR2 )
RETURN NUMBER
IS
	nLastRnk NUMBER;
	nCurrRnk NUMBER;
	CURSOR  Customers IS
		SELECT rnk FROM customer ORDER BY rnk;

BEGIN
	nLastRnk := 0;
	OPEN Customers;
	LOOP
		FETCH Customers INTO nCurrRnk;
		EXIT WHEN Customers%NOTFOUND;
		IF nCurrRnk-nLastRnk > 1 THEN
			EXIT;
		ELSE
			nLastRnk := nCurrRnk;
		END IF;
	END LOOP;
	CLOSE Customers;
	IF UPPER( sMode ) = 'NEXT' THEN
	   nLastRnk := nLastRnk + 1;
	END IF;

	RETURN nLastRnk;
END f_s_customer;

 
/
 show err;
 
PROMPT *** Create  grants  F_S_CUSTOMER ***
grant EXECUTE                                                                on F_S_CUSTOMER    to ABS_ADMIN;
grant EXECUTE                                                                on F_S_CUSTOMER    to BARS_ACCESS_DEFROLE;
grant EXECUTE                                                                on F_S_CUSTOMER    to START1;
grant EXECUTE                                                                on F_S_CUSTOMER    to WR_ALL_RIGHTS;

 
 
 PROMPT ===================================================================================== 
 PROMPT *** End *** ========== Scripts /Sql/BARS/function/f_s_customer.sql =========*** End *
 PROMPT ===================================================================================== 
 