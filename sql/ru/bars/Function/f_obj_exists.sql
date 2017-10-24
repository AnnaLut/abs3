
 
 PROMPT ===================================================================================== 
 PROMPT *** Run *** ========== Scripts /Sql/BARS/function/f_obj_exists.sql =========*** Run *
 PROMPT ===================================================================================== 
 
  CREATE OR REPLACE FUNCTION BARS.F_OBJ_EXISTS (owner_ IN VARCHAR2, name_ IN VARCHAR2,
	   	  		  		   					   type_ IN VARCHAR2)
RETURN NUMBER IS
	   exists_	 NUMBER;
BEGIN
	    SELECT 1
	    INTO exists_
		FROM all_objects
		WHERE  owner = UPPER(owner_) AND
					  object_name=UPPER(name_) AND
					  object_type=UPPER(type_);

		RETURN 1;
EXCEPTION
		 WHEN NO_DATA_FOUND THEN
		 	  RETURN 0;
END;
/
 show err;
 
 
 
 PROMPT ===================================================================================== 
 PROMPT *** End *** ========== Scripts /Sql/BARS/function/f_obj_exists.sql =========*** End *
 PROMPT ===================================================================================== 
 