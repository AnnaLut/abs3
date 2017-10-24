
 
 PROMPT ===================================================================================== 
 PROMPT *** Run *** ========== Scripts /Sql/BARS/function/f_get_rekvp.sql =========*** Run **
 PROMPT ===================================================================================== 
 
  CREATE OR REPLACE FUNCTION BARS.F_GET_REKVP (swref_ IN NUMBER,
	   sum_ IN OUT NUMBER, kom_ IN OUT NUMBER, kv_ IN OUT NUMBER, datv_ IN OUT DATE) RETURN NUMBER IS
/* =================================================================================
   Функция определения информации о платеже из доп. реквизитов SWIFT-сообщения
   =================================================================================
   VERSION  13.07.2006
   =================================================================================
   Параметры:
   		вх. ref_  -- реф. SWIFT сообщения
   	  	вых. sum_  -- сумма платежа
			    kom_ -- сумма комиссии
				kv_ -- валюта платежа
				datv_ -- дата валютирования
	Возвращает:
			   0 - все нормально
			   -1 - нет информации о платеже (отсутствуют доп реквизиты)
   =================================================================================
.*/
	 str_ VARCHAR2(1000);
	 kv1_  NUMBER;
	 kv2_  NUMBER;
	 kv3_  NUMBER;

	 f32a_sum_ NUMBER;
	 f71f_sum_ NUMBER;
	 f71g_sum_ NUMBER;

	 f32a_ SW_OPERW.value%TYPE;
	 f71a_ SW_OPERW.value%TYPE;
	 f71f_ SW_OPERW.value%TYPE;
	 f71g_ SW_OPERW.value%TYPE;
	 f50k_ SW_OPERW.value%TYPE;
   f50f_ SW_OPERW.value%TYPE;

	 FUNCTION f_swtag(a_tag_ IN SW_OPERW.tag%TYPE, a_opt_ IN SW_OPERW.opt%TYPE) RETURN SW_OPERW.value%TYPE IS
	 		  val_ SW_OPERW.value%TYPE;
			  kv_   NUMBER:=NULL;
			  sum_	NUMBER:=0;
			  kvb_   NUMBER:=NULL;
			  sumb_	NUMBER:=0;
	 BEGIN
	 	  FOR i IN (SELECT RTRIM(LTRIM(value)) val
				         FROM SW_OPERW
				         WHERE swref = swref_
					           AND tag = a_tag_
					           AND opt = a_opt_) LOOP
			   IF a_tag_ = '71' AND a_opt_ = 'F' THEN
			   	  Bars_Swift.SwiftToAmount(i.val, kv_, sum_);

				  IF kvb_ IS NULL THEN
				  	 sumb_ := sum_;
					 kvb_ := kv_;
				  ELSIF kvb_=kv_ THEN
				  	 sumb_ := sumb_ + sum_;
				  ELSE --- ???? непонятно что делать в этом случае и бывают ли такие случаи
				  	 val_ := i.val;
				   END IF;
			   ELSE
				   val_ := i.val;
			   END IF;
		   END LOOP;

		   IF sumb_ <> 0 AND kvb_ IS NOT NULL THEN
		   	  val_ := Bars_Swift.AmountToSWIFT(sumb_, kvb_, TRUE, TRUE);
		   END IF;

		   RETURN val_;
	 EXCEPTION
	        WHEN NO_DATA_FOUND THEN RETURN NULL;
	 END;

BEGIN
	 sum_ := NVL(sum_, 0);
	 --prc_ := 0;
	 kom_ := 0;

	 f32a_ := f_swtag('32',  'A');
	 f71a_ := f_swtag('71',  'A');
	 f71f_ :=  f_swtag('71',  'F');
	 f71g_ := f_swtag('71',  'G');

	 -- для Фонда Cliams Conference
	 f50k_ :=  UPPER(f_swtag('50',  'K'));
   f50f_ :=  UPPER(f_swtag('50',  'F'));
	 IF f32a_ IS NOT NULL AND f71a_ IS NOT NULL THEN
	     Bars_Swift.SwiftToAmount(SUBSTR(f32a_, 7), kv1_, f32a_sum_);

		 IF f71f_ IS NOT NULL THEN
		     Bars_Swift.SwiftToAmount(f71f_, kv2_, f71f_sum_);
		 ELSE
		 	 f71f_sum_ := 0;
		 END IF;

		 IF f71g_ IS NOT NULL THEN
		     Bars_Swift.SwiftToAmount(f71g_, kv3_, f71g_sum_);
		 ELSE
		 	 f71g_sum_ := 0;
		 END IF;

 	 	 sum_ := NVL(f32a_sum_, 0);
 		 kom_ := 0;

 	     IF INSTR(f50k_, 'CLAIMS')>0 or INSTR(f50f_, 'CLAIMS')>0 THEN
 			BEGIN
 				 SELECT NVL(tar, 0)
 				 INTO kom_
 				 FROM TARIF
 				 WHERE kod=199 AND
 				 	  kv=kv1_ ;
 			EXCEPTION
 					 WHEN NO_DATA_FOUND THEN
 					 	  kom_ := 0;
 			END;

 		 	sum_ := sum_ - kom_;
		END IF;


		 kv_ := kv1_;

		 datv_ := TO_DATE(SUBSTR(f32a_, 1, 6), 'yymmdd');

		 RETURN 0;
	ELSE
		RETURN -1;
	END IF;
END;
/
 show err;
 
 
 
 PROMPT ===================================================================================== 
 PROMPT *** End *** ========== Scripts /Sql/BARS/function/f_get_rekvp.sql =========*** End **
 PROMPT ===================================================================================== 
 