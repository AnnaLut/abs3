

PROMPT ===================================================================================== 
PROMPT *** Run *** ========== Scripts /Sql/BARS/Procedure/SETCUSTOMERSEAL.sql =========*** R
PROMPT ===================================================================================== 


PROMPT *** Create  procedure SETCUSTOMERSEAL ***

  CREATE OR REPLACE PROCEDURE BARS.SETCUSTOMERSEAL ( ID_ OUT INTEGER, IMG_ IN BLOB ) IS
BEGIN
	 IF ID_ is null THEN
	 	SELECT S_CUSTOMER_BIN_DATA.nextval INTO ID_ FROM dual ;
	    INSERT INTO CUSTOMER_BIN_DATA(ID, BIN_DATA)
		VALUES(ID_, IMG_);
	 ELSE
	 	 UPDATE CUSTOMER_BIN_DATA
    	 SET BIN_DATA = IMG_
		 WHERE ID = ID_;
	 END IF;
END setCustomerSeal;
/
show err;

PROMPT *** Create  grants  SETCUSTOMERSEAL ***
grant EXECUTE                                                                on SETCUSTOMERSEAL to BARS_ACCESS_DEFROLE;
grant EXECUTE                                                                on SETCUSTOMERSEAL to WR_ALL_RIGHTS;
grant EXECUTE                                                                on SETCUSTOMERSEAL to WR_CUSTREG;



PROMPT ===================================================================================== 
PROMPT *** End *** ========== Scripts /Sql/BARS/Procedure/SETCUSTOMERSEAL.sql =========*** E
PROMPT ===================================================================================== 
