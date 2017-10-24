

PROMPT ===================================================================================== 
PROMPT *** Run *** ========== Scripts /Sql/BARS/Procedure/P_OBJ_EXISTS.sql =========*** Run 
PROMPT ===================================================================================== 


PROMPT *** Create  procedure P_OBJ_EXISTS ***

  CREATE OR REPLACE PROCEDURE BARS.P_OBJ_EXISTS (owner_ IN VARCHAR2, name_ IN VARCHAR2,
	   	  		  		   					   type_ IN VARCHAR2, sql_	IN VARCHAR2 DEFAULT NULL)
IS
BEGIN
	    IF Trim(sql_) IS NOT NULL AND f_obj_exists(owner_,  name_, type_)=1 THEN
		   EXECUTE IMMEDIATE sql_;
		END IF;
END;
/
show err;



PROMPT ===================================================================================== 
PROMPT *** End *** ========== Scripts /Sql/BARS/Procedure/P_OBJ_EXISTS.sql =========*** End 
PROMPT ===================================================================================== 
