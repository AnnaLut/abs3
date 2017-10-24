

PROMPT ===================================================================================== 
PROMPT *** Run *** ========== Scripts /Sql/BARS/Procedure/P_REKW_1PB.sql =========*** Run **
PROMPT ===================================================================================== 


PROMPT *** Create  procedure P_REKW_1PB ***

  CREATE OR REPLACE PROCEDURE BARS.P_REKW_1PB (ref_	IN NUMBER, nos_acc_ IN NUMBER) IS
/*====================================================================
   Процедура P_rekw_1pb - Дополнение доп.реквизитов на подборе КС.для формы 1ПБ
   Версия - 29/05/2006
   Параметры:  ref_ - идентификатор документа (тип NOS)
   			   		   nos_acc_ - идентификатор КС
====================================================================*/
	ret_ NUMBER;
	bic_ VARCHAR2(11);
	d_rec_ OPER.d_rec%TYPE;
	num_   BOPBANK.REGNUM%TYPE;
	tag_ OPERW.tag%TYPE:=NULL;
	value_ OPERW.value%TYPE;
	pos_	NUMBER;

	FUNCTION f_ins_rekw(str_ VARCHAR2, maska_ VARCHAR2, tag_	VARCHAR2) RETURN NUMBER IS
		buf_	OPER.D_REC%TYPE;
		pos_	NUMBER;
		val_	  OPER.D_REC%TYPE := NULL;
	BEGIN
	   IF maska_ IS NOT NULL THEN
		   pos_ := INSTR(str_, maska_);

		   IF pos_ > 0 THEN
		   	   buf_ := Trim(SUBSTR(str_ , pos_+LENGTH(Trim(maska_))));

			   pos_ := INSTR(buf_, '#');

			   IF pos_ > 0 THEN
			   	   val_ := Trim(SUBSTR(buf_ , 1, pos_-1));

			   END IF;
		   END IF;
	   ELSE
	   	   val_ := Trim(str_);
	   END IF;

	   IF val_ IS NOT NULL THEN
	   	  INSERT INTO OPERW (REF, tag, value)
		  VALUES (ref_, tag_, val_);
	   END IF;

		RETURN 0;
	EXCEPTION
	     WHEN OTHERS THEN
		 	 IF SQLCODE=-1 THEN
			 	RETURN -1;
			 ELSE
	         	 RAISE_APPLICATION_ERROR(-20001, 'Ошибка при вставке доп. реквизита ' || tag_ || ': ' || SQLERRM);
		     END IF;
	END;

BEGIN
	 BEGIN
		-- код страны и банка
		SELECT d_rec
		INTO d_rec_
		FROM OPER
		WHERE REF=ref_;
	EXCEPTION
		 WHEN NO_DATA_FOUND THEN
		 	  d_rec_ := NULL;
    END;

	IF Trim(d_rec_)  IS NOT NULL THEN
		-- определяем тип документа
		pos_ := INSTR(UPPER(d_rec_), '#FMT');

		IF pos_ > 0 THEN
		   IF trim(SUBSTR(d_rec_, pos_+4, 4)) = '103' THEN
		   	  	 tag_ := '57A';
		   ELSIF trim(SUBSTR(d_rec_, pos_+4, 4)) = '202' THEN
		   	  	 tag_ := '58D';
		    ELSE
				 tag_ := NULL;
		    END IF;
		END IF;

	-- обрабатываем код страны
	    ret_ := f_ins_rekw(d_rec_, '#nО', 'KOD_G');

	-- обрабатываем назначение платежа
	    ret_ := f_ins_rekw(d_rec_, '#N', 'KOD_N');
	END IF;

	IF 	tag_ IS NOT NULL THEN
	 	-- обрабатываем код банка
		BEGIN
			SELECT value
			INTO value_
			FROM OPERW
			WHERE REF=ref_ AND
				  		  tag LIKE tag_;

			 bic_ := F_Get_Bic(value_);

	 		 SELECT regnum
			 INTO num_
			 FROM BOPBANK b
			 WHERE SUBSTR(b.BIC, 1, 8)=SUBSTR(bic_, 1, 8);
		EXCEPTION
			 WHEN NO_DATA_FOUND THEN
			 	  num_ := NULL;
		END;

		IF Trim(num_) IS NOT NULL THEN
		    ret_ := f_ins_rekw(num_, NULL, 'KOD_B');
	    END IF;
	END IF;
END;
 
/
show err;

PROMPT *** Create  grants  P_REKW_1PB ***
grant EXECUTE                                                                on P_REKW_1PB      to WR_ALL_RIGHTS;



PROMPT ===================================================================================== 
PROMPT *** End *** ========== Scripts /Sql/BARS/Procedure/P_REKW_1PB.sql =========*** End **
PROMPT ===================================================================================== 
