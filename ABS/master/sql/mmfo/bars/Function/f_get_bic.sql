
 
 PROMPT ===================================================================================== 
 PROMPT *** Run *** ========== Scripts /Sql/BARS/function/f_get_bic.sql =========*** Run *** 
 PROMPT ===================================================================================== 
 
  CREATE OR REPLACE FUNCTION BARS.F_GET_BIC (a_buf_ IN OPERW.value%TYPE) RETURN BOPBANK.REGNUM%TYPE IS
    REF_ NUMBER;
	buf_ OPERW.value%TYPE;
	buf2_ VARCHAR2(11):='';
	bic_ VARCHAR2(11):='';
	num_ BOPBANK.REGNUM%TYPE:=NULL;
	pos_ NUMBER:=0;
BEGIN
	buf_ := Trim(a_buf_);

	IF SUBSTR(buf_,1,1)='/' THEN
	    pos_ := INSTR(buf_ ,CHR(13)||CHR(10));

		IF pos_ = 0 THEN
		   RETURN NULL;
		ELSE
		   buf_ := SUBSTR(buf_, pos_ + 2);
		END IF;
	 END IF;

	pos_ := INSTR(buf_ ,CHR(13)||CHR(10));

	IF pos_ > 0 THEN
	   	buf_ := SUBSTR(buf_, 1, pos_ - 1);
	END IF;

	buf_ := Trim(buf_);

	IF LENGTH(buf_) IN (8, 11) THEN
	    buf2_ := Trim(REPLACE(TRANSLATE(SUBSTR(buf_, 1, 6), '#ABCDEFGHIJKLMNOPQRSTUVWXYZ', '!' || LPAD('#', 26, '#')), '#', '' ));

		IF LENGTH(buf2_) > 0 THEN
		    RETURN NULL;
		END IF;

	    buf2_ := Trim(REPLACE(TRANSLATE(SUBSTR(buf_, 7),'#0123456789ABCDEFGHIJKLMNOPQRSTUVWXYZ', '!' || LPAD('#', 36, '#')), '#', '' ));

		IF LENGTH(buf2_) > 0 THEN
		    RETURN NULL;
		END IF;

		bic_ := SUBSTR(buf_, 1, 11);

	ELSE
		RETURN NULL;
	END IF;

	RETURN bic_;
EXCEPTION
		 WHEN OTHERS THEN
		 	  RAISE_APPLICATION_ERROR(-20001, 'Error in F_Get_Bic: '||SQLERRM) ;
END;
 
/
 show err;
 
PROMPT *** Create  grants  F_GET_BIC ***
grant EXECUTE                                                                on F_GET_BIC       to WR_ALL_RIGHTS;

 
 
 PROMPT ===================================================================================== 
 PROMPT *** End *** ========== Scripts /Sql/BARS/function/f_get_bic.sql =========*** End *** 
 PROMPT ===================================================================================== 
 