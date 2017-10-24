
 
 PROMPT ===================================================================================== 
 PROMPT *** Run *** ========== Scripts /Sql/BARS/function/f_get_params.sql =========*** Run *
 PROMPT ===================================================================================== 
 
  CREATE OR REPLACE FUNCTION BARS.F_GET_PARAMS (par_ IN VARCHAR2, default_ IN NUMBER:=NULL) RETURN NUMBER IS
	   val_ params.val%TYPE;
	   ret_ NUMBER;
BEGIN
   BEGIN
	   SELECT val
	   INTO val_
	   FROM params
	   WHERE LOWER(par)=LOWER(par_);

	   ret_ := TO_NUMBER(val_);
   EXCEPTION
   		WHEN NO_DATA_FOUND THEN
			 IF default_ IS NOT NULL THEN
			 	ret_ := default_;
			 ELSE
				RAISE_APPLICATION_ERROR(-20001,'³������ �������� '''||par_||''' � �������� "������������� ���������"');
			 END IF;
		WHEN OTHERS THEN
			 IF SQLCODE=-6502 THEN
		         RAISE_APPLICATION_ERROR(-20002,'�������: �� ������� �������� ('||val_||') � ��� "��������" ��������� '||par_);
		     ELSE
		         RAISE_APPLICATION_ERROR(-20003,'�������: '||SQLERRM);
			 END IF;
   END;

   RETURN ret_;
END;
 
/
 show err;
 
PROMPT *** Create  grants  F_GET_PARAMS ***
grant EXECUTE                                                                on F_GET_PARAMS    to WR_ALL_RIGHTS;

 
 
 PROMPT ===================================================================================== 
 PROMPT *** End *** ========== Scripts /Sql/BARS/function/f_get_params.sql =========*** End *
 PROMPT ===================================================================================== 
 