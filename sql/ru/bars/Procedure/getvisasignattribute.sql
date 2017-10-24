

PROMPT ===================================================================================== 
PROMPT *** Run *** ========== Scripts /Sql/BARS/Procedure/GETVISASIGNATTRIBUTE.sql =========
PROMPT ===================================================================================== 


PROMPT *** Create  procedure GETVISASIGNATTRIBUTE ***

  CREATE OR REPLACE PROCEDURE BARS.GETVISASIGNATTRIBUTE 

-- ‘ункци€ дл€ работы с внутренней подписью на визировании...

-- nRef	   	   	  - референс документа
-- sFMode 		  - режим работы функции ['CUR','NEW',''LVL]
-- nVisaLevel	  - уровень визы на документе
-- sSignType 	  - тип Ё÷ѕ ['NBU','UKR',''... etc.]
-- bBuffer		  -	подписываемый буффер данных
-- nBufLen		  - размер буфера
-- bSign		  - Ё÷ѕ
-- nSignLen		  -	размер Ё÷ѕ

	   (nRetVal	IN OUT NUMBER,
	    nRef    IN    NUMBER,
	    sFMode  IN    VARCHAR2, nVisaLevel IN NUMERIC,
		sSignType   IN VARCHAR2,
	    bBuffer IN OUT VARCHAR2, nBufLen  IN OUT NUMERIC,
		sKeyId  IN OUT VARCHAR2,
	    bSign   IN OUT VARCHAR2, nSignLen IN OUT NUMERIC)
IS

-- 0   - SUCCESS
-- 1   - NO DOCUMENT FOUND
-- 2   - UNKNOWN WORK MODE
-- 3   - UNKNOWN SIGN TYPE
-- 99  - Miscelaneous errors

       Buffer VARCHAR2(4098);
	   nMaxV  NUMBER;
	   i      NUMBER;
	   cVisa  VARCHAR2(512);
	   cKey	  VARCHAR2(6);
	   cSqnc  NUMBER;
	   CURSOR Visas IS
	   		  SELECT sqnc, keyid, sign FROM oper_visa WHERE ref=nRef AND NVL(passive,0)=0
			  ORDER BY sqnc;
BEGIN
     Buffer   := '';
	 cVisa    := '';
	 cKey	  := '';

	 nBufLen  := 0;
	 nSignLen := 0;
	 sKeyId   := '';
	 nRetVal  := 0;

	 IF sFMode <> 'CUR' AND sFMode <> 'NEW' AND sFMode <> 'LVL' THEN
	     nRetVal := 2;
	 	 RETURN;
	 END IF;

	 IF sSignType <> 'NBU' AND sSignType <> 'UKR' AND sSignType <> 'UNI' AND sSignType <> 'VEG' THEN
	     nRetVal := 3;
	 	 RETURN;
	 END IF;

	 BEGIN
	 	 SELECT id_o, sign INTO sKeyId, Buffer FROM oper WHERE ref = nRef;
	 EXCEPTION WHEN NO_DATA_FOUND THEN
	     nRetVal := 1;
 	 	 RETURN;
	 END;
	 -- не нашли Ё÷ѕ в oper ==> ищем в arc_rrp
	 IF Buffer IS NULL THEN
	   BEGIN
		 SELECT id_o, sign INTO sKeyId, Buffer FROM arc_rrp WHERE ref = nRef;
       EXCEPTION WHEN NO_DATA_FOUND THEN
		 -- не нашли и в arc_rrp ==> выбрасываем ошибку
		 nRetVal := 1;
 	 	 RETURN;
	   END;
	 END IF;

	 IF sFMode = 'LVL' THEN
	 	 IF nVisaLevel = 0 THEN
		     bSign    := Buffer;
			 nSignLen := length(Buffer)/2;
	 	     nRetVal  := 0;
		     RETURN;
		 ELSE
		     OPEN Visas;
			 Buffer := substr(Buffer, 33, 128);
		 	 FOR i IN 1..nVisaLevel LOOP
			 	 FETCH Visas INTO cSqnc, cKey, cVisa;
				 EXIT WHEN Visas%NOTFOUND;
				 IF i < nVisaLevel THEN
				 	 Buffer := Buffer || TO_HEX(cKey);
					 IF sSignType = 'UNI' THEN
					     Buffer := Buffer || substr(cVisa, 33, 128);
					 ELSE
					     Buffer := Buffer || cVisa;
					 END IF;
				 END IF;
			 END LOOP;
			 CLOSE Visas;
			 IF i < nVisaLevel THEN
			 	 nRetVal  := 99;
			     RETURN;
			 ELSE
				 nSignLen := length(cVisa)/2;
	 		     bSign    := cVisa;
				 nBufLen  := length(Buffer)/2;
				 bBuffer  := Buffer;
				 sKeyId   := cKey;
				 nRetVal  := 0;
				 RETURN;
			 END IF;
		 END IF;
	 ELSE
		 BEGIN
		 	 SELECT max(sqnc) INTO nMaxV FROM oper_visa WHERE ref = nRef AND NVL(passive,0)=0;
		 EXCEPTION WHEN NO_DATA_FOUND THEN
		 	 nMaxV := 0;
		 END;

		 IF nMaxV > 0 THEN
		     IF sFMode = 'CUR' THEN
			 	BEGIN
			 	    SELECT sign, keyid INTO bSign, cKey FROM oper_visa WHERE ref= nRef AND sqnc = nMaxV;
				EXCEPTION WHEN NO_DATA_FOUND THEN
					nRetVal  := 99;
				    RETURN;
				END;
				nSignLen := length(bSign)/2;
			 END IF;
			 OPEN Visas;
			 Buffer := substr(Buffer, 33, 128);
			 LOOP
			 	 FETCH Visas INTO cSqnc, cKey, cVisa;
				 EXIT WHEN Visas%NOTFOUND;
				 IF sFMode <> 'CUR' OR cSqnc <> nMaxV THEN
				 	 Buffer := Buffer || TO_HEX(cKey);
					 IF sSignType = 'UNI' THEN
					     Buffer := Buffer || substr( cVisa, 33, 128);
					 ELSE
					     Buffer := Buffer || cVisa;
					 END IF;
				 END IF;
				 sKeyId := cKey;
			 END LOOP;
			 CLOSE Visas;
			 bBuffer := Buffer;
			 nBufLen := length(Buffer)/2;
		 ELSE
		     IF sFMode = 'CUR' THEN
				 nSignLen := length(Buffer)/2;
			     bSign    := Buffer;
			 ELSIF sFMode = 'NEW' THEN
	 			 bBuffer := substr(Buffer, 33, 128);
			 	 nBufLen := length(bBuffer)/2;
				 sKeyId  := '';
			 END IF;
		 END IF;
		 nRetVal  := 0;
		 RETURN;
	 END IF;

END GetVisaSignAttribute;
/
show err;

PROMPT *** Create  grants  GETVISASIGNATTRIBUTE ***
grant EXECUTE                                                                on GETVISASIGNATTRIBUTE to ABS_ADMIN;
grant EXECUTE                                                                on GETVISASIGNATTRIBUTE to BARS_ACCESS_DEFROLE;
grant EXECUTE                                                                on GETVISASIGNATTRIBUTE to START1;
grant EXECUTE                                                                on GETVISASIGNATTRIBUTE to WR_ALL_RIGHTS;



PROMPT ===================================================================================== 
PROMPT *** End *** ========== Scripts /Sql/BARS/Procedure/GETVISASIGNATTRIBUTE.sql =========
PROMPT ===================================================================================== 
