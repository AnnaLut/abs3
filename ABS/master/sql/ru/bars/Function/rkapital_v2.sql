
 
 PROMPT ===================================================================================== 
 PROMPT *** Run *** ========== Scripts /Sql/BARS/function/rkapital_v2.sql =========*** Run **
 PROMPT ===================================================================================== 
 
  CREATE OR REPLACE FUNCTION BARS.RKAPITAL_V2 (dat_ DATE,
	   	  		  		   			 kodf_ VARCHAR2 DEFAULT NULL,
									 userid_  NUMBER DEFAULT NULL,
									 type_  NUMBER DEFAULT 3  -- =1 - PK1
									 -- =2 - PK2, =3 - РК
									 ) RETURN NUMBER IS
---------------------------------------------------------------------------
--- Функція розрахунку регулятивного капіталу  ---
--- по новому (від 01.05.2005) алгоритму	       ---
--------------------------------------------------
----- Версія від 21.10.2009 (25.02.2005)	   ---
--------------------------------------------------
---  21.10.2009 - замена KL_R020 на KOD_R020
---- 19/12/2005  зміни згідно телеграми НБУ №24-622/212 від 30.11.2005 --
---- 05/01/2006  змiни згiдно постанови НБУ №493 вiд 22.12.2005 про зміни в методиці розрахунку економ. нормативів --
---- 02.02.2006  ЗМІНИ ПРИ РОЗРАХУНКУ показника "Резерви під знецінення ЦП" (береться з файлу С5)
---- 29/12/2006  зміни згідно зауваження банку СЕБ ( якщо DK > OK, то в розрахунок береться DK = OK)
---- 19/01/2007  зміни згідно листа НБУ №40-117/110 від 16/01/2007
---------------------------------------------------------------------------------------------------------------
    dat_Zm_	DATE := TO_DATE('21122005','ddmmyyyy'); -- вступають в дію зміни згідно телеграми НБУ №24-622/212 від 30.11.2005
	dat_2m_	 DATE := TO_DATE('01022006','ddmmyyyy'); -- початок змін при розрахунку резервів під знецінення ЦП (з С5 файлу, а не з 84 файлу)
	dat_2k_	 DATE := TO_DATE('01042006','ddmmyyyy'); -- початок 1-шої частини змін по розрахунку результату поточного року
	dat_2p_	 DATE := TO_DATE('01072006','ddmmyyyy'); -- початок 2-шої частини змін по розрахунку результату поточного року
	dat_3_	 DATE := TO_DATE('01012007','ddmmyyyy'); -- вступають в дію зміни згідно листа НБУ №40-117/110 від 16/01/2007

    k_		 NUMBER; -- поправочний коефіцієнт
	k_SB_	 NUMBER; -- процент від субординованого боргу

    ek4b_    NUMBER;
	ek4_     NUMBER;
	ek2_     NUMBER;
	ek1_     NUMBER;

	s5999_   NUMBER;
	sumnd1_   NUMBER; ---сума нарахованих доходiв строк отримання <=3 мiсяцiв
	sumnd2_   NUMBER; ---сума нарахованих доходiв строк отримання >3 мiсяцiв
	sumpnd_  NUMBER; ---сума прострочених нарахованих доходiв
	sumsnd_  NUMBER; ---сумнiвна заборгованiсть за нарахованими доходами
	sumrez_  NUMBER; ---сума резерву за простроч.>31 дня i сумнiв. до отримання Нд
	rez3190_ NUMBER; ---сума резерву по цінним паперам (файл #84 строка 91722)
	sump1_   NUMBER;
	sump11_  NUMBER;
	sump2_   NUMBER;
	sump3_   NUMBER;
	sum6a_   NUMBER;
	sum6p_   NUMBER;

	s5030_	 NUMBER;
	s5040_	 NUMBER;

	kf1_     VARCHAR2(2):='01';
	kf2_     VARCHAR2(2):='42';
	kf3_     VARCHAR2(2):='84';
	kf4_	 VARCHAR2(2):='C5';

	DatN_    DATE:=Dat_;

	par_     PARAMS.PAR%TYPE;
	flag_    NUMBER;

	dat2_    DATE;
	mes_     VARCHAR2(2);
	god_     VARCHAR2(4);
	count_	 NUMBER:=0;

	mfo_	 NUMBER:=F_Ourmfo();

	sql_ VARCHAR2(200);

  	datD_    DATE;        -- дата начала декады !!!
  	dc_      INTEGER;

   	fmt_ VARCHAR2(30):='999G999G999G990D99';

	OK_	 NUMBER := 0; -- основний капітал
	DK_	 NUMBER := 0; -- додатковий капітал
	V_	 NUMBER := 0; -- відвернення
	RPR_ NUMBER := 0; -- результат поточного року
	OZ_	 NUMBER := 0; -- основні засоби
	POZ_ NUMBER := 0; -- перевищення ОЗ над РК

	RK1_ NUMBER; -- регулятивний капітал, не відкоригований на ОЗ
	RK2_ NUMBER; -- регулятивний капітал, не відкоригований на ОЗ
	RK_ NUMBER; -- регулятивний капітал, не відкоригований на ОЗ

	dat_rez_	DATE; -- макс. дата, за которую есть резервы по ценным бумагаи


	PROCEDURE p_ins(p_kod_ VARCHAR2, p_val_ NUMBER) IS
	BEGIN
	   IF kodf_ IS NOT NULL AND userid_ IS NOT NULL THEN
		   INSERT INTO OTCN_LOG (kodf, userid, txt)
		   VALUES(kodf_,userid_,p_kod_||TO_CHAR(p_val_/100, fmt_));
	   END IF;
	END;
BEGIN
   flag_ := F_Get_Params('NOR_A7_F',1);

   -- поправочний коефіцієнт
   k_ := F_Get_Params('NOR_KOEF',0.4);

   k_SB_ := F_Get_Params('NOR_P_SB',1);

   IF kodf_ IS NOT NULL THEN
	   DELETE FROM OTCN_LOG
	   WHERE userid = userid_ AND
	   		 kodf = kodf_;
   END IF;

   p_ins('Дата формування : '||TO_CHAR(dat_,'dd.mm.yyyy'),NULL);

   IF flag_ = 0 THEN
	   RK_ := F_Get_Params('NORM_A7');

   	   p_ins('Регулятивний капітал (константа): ',RK_);

	   RETURN RK_;
   ELSE
   	   IF mfo_=300465 THEN
		   sql_ := 'SELECT a.sumrk '||
			  	   'FROM REGCAPITAL a '||
		      	   'WHERE a.fdat=(select max(fdat) from REGCAPITAL where fdat<=:Dat_)';

		   EXECUTE IMMEDIATE sql_ INTO RK_ USING dat_;

		   p_ins('Регулятивний капітал (із REGCAPITAL): ',RK_);

		  RETURN RK_;
	   ELSE

		   IF kodf_ IS NOT NULL THEN
			   -- перевірка того, чи сформований №01 файл за звітну дату
			   p_ins('-------- Перевірка наявності в БД файлів, що використовуються при розрахунку ------',NULL);

			   count_ := F_Perevirka(kodf_, kf1_, dat_, userid_);
			   count_ := count_ + F_Perevirka(kodf_, kf4_, dat_, userid_);

			   IF count_ = 0 THEN
			   	  p_ins('Всі файли сформовано.',NULL);
			   END IF;
		   END IF;

		   p_ins(' --------------------------------- РОЗРАХУНОК --------------------------------- ',NULL);

		   DatN_ := Calc_Pdat(dat_)-1; -- попередня дата формування файлу 42

		   SELECT MAX(w.datf)
			 INTO datN_
			 FROM TMP_NBU w
			 WHERE w.kodf=kf2_ AND w.datf <= datN_;
		   ---------------------------------------------------------------
			-- начало декады
			dc_:=TO_NUMBER(LTRIM(TO_CHAR(dat_,'DD'),'0'));

			IF dc_ < 10 THEN
			   datD_:=LAST_DAY(ADD_MONTHS(dat_, -1));
			ELSIF dc_ < 20 THEN
			   datD_:=TO_DATE('10'||TO_CHAR(dat_,'mmyyyy'),'ddmmyyyy');
			ELSE
			   datD_:=TO_DATE('20'||TO_CHAR(dat_,'mmyyyy'),'ddmmyyyy');
			END IF;

			 SELECT MAX(w.datf)
			 INTO datD_
			 FROM TMP_NBU w
			 WHERE w.kodf=kf1_ AND w.datf <= datD_;
			--------------------------------------------------------------------------------
			------------------------ ОСНОВНИЙ КАПІТАЛ ---------------------
			--------------------------------------------------------------------------------
			if Dat_ < dat_3_ then -- 01/01/2007
			   BEGIN
			      SELECT SUM(DECODE(SUBSTR(s.kodp,1,2),'20',TO_NUMBER(s.znap),0)),
			             SUM(DECODE(SUBSTR(s.kodp,1,2),'10',TO_NUMBER(s.znap),0))
			      INTO sump1_, sump11_
			      FROM v_banks_report s, EK3_OK a
			      WHERE s.datf=Dat_ AND
				  		s.kodf=kf1_ AND
			            SUBSTR(s.kodp,1,2) IN ('20','10')  AND
						SUBSTR(s.kodp,3,4)=a.nbs;
			   EXCEPTION WHEN NO_DATA_FOUND THEN
			      sump1_:=0 ;
			      sump11_:=0 ;
			   END ;
			else
			   BEGIN -- з ОК вилучається група 504
			      SELECT SUM(DECODE(SUBSTR(s.kodp,1,2),'20',TO_NUMBER(s.znap),0)),
			             SUM(DECODE(SUBSTR(s.kodp,1,2),'10',TO_NUMBER(s.znap),0))
			      INTO sump1_, sump11_
			      FROM v_banks_report s, EK3_OK a
			      WHERE s.datf=Dat_ AND
				  		s.kodf=kf1_ AND
			            SUBSTR(s.kodp,1,2) IN ('20','10')  AND
						SUBSTR(s.kodp,3,4)=a.nbs and
						a.nbs not like '504%';
			   EXCEPTION WHEN NO_DATA_FOUND THEN
			      sump1_:=0 ;
			      sump11_:=0 ;
			   END ;
			end if;

		   OK_ := NVL(sump1_, 0) - NVL(sump11_,0);

		   -- протокол
	   	   p_ins('Основний капітал: ', OK_);

		   ------------------------------------------------------------------------------------
		   ------------------------ ДОДАТКОВИЙ КАПІТАЛ ---------------------
		   ------------------------------------------------------------------------------------
		   BEGIN
		      SELECT SUM(TO_NUMBER(znap))
		      INTO sump2_
		      FROM  v_banks_report
		      WHERE datf=Dat_ AND
			  		kodf=kf1_ AND
		            SUBSTR(kodp,2,5) IN ('01591','01593','02401');
					-- +1593 згідно листа НБУ N40-117/35 11.01.2005
		   EXCEPTION WHEN NO_DATA_FOUND THEN
		      sump2_:=0 ;
		   END;

		   DK_ := NVL(sump2_, 0);

		   IF kodf_ IS NOT NULL THEN
			   -- протокол
			   INSERT INTO OTCN_LOG (kodf, userid, txt)
			   SELECT kodf_,userid_,'ДК (БС '||nbs||'): '||TO_CHAR(val/100, fmt_)
			   FROM (SELECT SUBSTR(kodp,3,4) nbs, SUM(TO_NUMBER(znap)) val
		       		FROM  v_banks_report
		       		WHERE datf=Dat_ AND
			  		 	  kodf=kf1_ AND
		             	  SUBSTR(kodp,2,5) IN ('01591','01593','02401')
			   		GROUP BY SUBSTR(kodp,3,4));
		   END IF;

		   -- результат переоцінки основних засобів
		   BEGIN
		      SELECT SUM(TO_NUMBER(znap))
		      INTO ek2_
		      FROM   v_banks_report
		      WHERE  kodf=kf4_ AND
		             SUBSTR(kodp,2,5)='51001' AND
		             datf=Dat_;
		   EXCEPTION WHEN NO_DATA_FOUND THEN
		      ek2_:=0 ;
		   END ;

	   	   p_ins('ДК (БС 5100 r013=1): ', ek2_);

		   DK_:=DK_+NVL(ek2_,0);

		   -- резерв під стандартну заборгованість
		   BEGIN
		      SELECT SUM(TO_NUMBER(znap))
		      INTO ek2_
		      FROM   v_banks_report
		      WHERE  kodf=kf4_                AND
		             SUBSTR(kodp,2,5)='36901'    AND
		             datf=Dat_;
		   EXCEPTION WHEN NO_DATA_FOUND THEN
		      ek2_:=0 ;
		   END ;

	   	   p_ins('ДК (БС 3690 r013=1): ', ek2_);

		   DK_:=DK_+NVL(ek2_,0) ;

		   -- субординований борг
		   SELECT SUM(TO_NUMBER(s.znap))
		   INTO  ek4_
		   FROM  v_banks_report s
		   WHERE s.datf=DatD_ AND
		   		 s.kodf=kf1_ AND
		   		 SUBSTR(s.kodp,2,5)='03660';

		   ek4_ := NVL(ek4_,0)*k_SB_;

		   -- субординований борг не повинен перевищувати 50% основного капіталу
		   IF ek4_>OK_*0.5 THEN
		      ek4_:=ROUND(OK_*0.5,0) ;
		   END IF;

		   DK_:=DK_+ek4_;

 		  IF dat_ >= dat_Zm_ THEN	-- з 21.12.2005
			  -- нерозподілений прибуток минулих років, що очікує затврдження
			   SELECT SUM(TO_NUMBER(s.znap))
			   INTO  s5030_
			   FROM  v_banks_report s
			   WHERE s.datf=Dat_ AND
			   		 		 s.kodf=kf1_ AND
			   				 SUBSTR(s.kodp,2,5)='05030';

	   		  p_ins('Нерозподілений прибуток минулих років (5030): ', NVL(	s5030_, 0));

	 		  IF dat_ < dat_2p_ THEN -- в 1 півріччі 5030 включається в основний капітал, а в 2 півріччі - в додатковий
			  	    NULL;
			  ELSE
			  	 	OK_:=OK_ - NVL(	s5030_, 0);

			  	 	DK_:=DK_ + NVL(	s5030_, 0);
			  END IF;

			  if Dat_ < dat_3_ then  -- з 01/01/2007 ДК вилучається пасивна частина 504 групи
				-- прибуток звітного року, що очікує затврдження
				SELECT SUM(decode(SUBSTR(s.kodp,6,1),0,1,1,-1,0)*TO_NUMBER(s.znap))
				INTO  s5040_
				FROM  v_banks_report s
				WHERE s.datf=Dat_ AND
					  s.kodf=kf1_ AND
					  SUBSTR(s.kodp,2,4)='0504';

				OK_:=OK_ - NVL(	s5040_, 0);

				p_ins('Прибуток звітного року, що очікує затвердження (5040): ', NVL(s5040_, 0));

				DK_:=DK_ + NVL(s5040_, 0);
			  end if;
		   END IF;
			-----------------------------------------------------------------------------------------------------
			-------------------- РЕЗУЛЬТАТ ПОТОЧНОГО РОКУ -----------------------------
			-----------------------------------------------------------------------------------------------------
		   -- нараховані доходи, срок отримання яких не визначений або передбачений > 3 місяців
		   SELECT SUM(TO_NUMBER(znap))
		   INTO sumnd2_
		   FROM   v_banks_report s
		   WHERE s.datf=Dat_ AND
		   		 s.kodf=kf4_ AND
				 --SUBSTR(s.kodp,2,4) IN (SELECT r020 FROM KL_R020 WHERE f_c5='1' AND LOWER(txt) LIKE '%нарах%доход%') AND
                substr(s.kodp,2,4) in (select r020
                                        from kl_r020
                                        where r020 in (select r020 from kod_r020 where a010='C5') and
                                              lower(txt) like '%нарах%доход%') and
				 ((SUBSTR(s.kodp,2,4) IN ('1518','1528') AND
	               SUBSTR(s.kodp,6,1) IN ('3','4')) OR
				  (SUBSTR(s.kodp,2,4) NOT IN ('1518','1528') AND
				   SUBSTR(s.kodp,6,1)='2'));

		   RPR_ := NVL(sumnd2_,0);

	 	   IF dat_ >= dat_2k_ THEN -- з 2 кварталу 2006 року
				   -- нараховані доходи, срок отримання до 3 місяців
				   SELECT SUM(TO_NUMBER(znap))
				   INTO sumnd1_
				   FROM   v_banks_report s
				   WHERE s.datf=Dat_ AND
				   		 s.kodf=kf4_ AND
						 SUBSTR(s.kodp,2,4) IN (SELECT r020 FROM KL_R020 WHERE r020 in (select r020 from kod_r020 where a010='C5') AND LOWER(txt) LIKE '%нарах%доход%') AND
						 ((SUBSTR(s.kodp,2,4) IN ('1518','1528') AND
			               SUBSTR(s.kodp,6,1) IN ('1','2')) OR
						  (SUBSTR(s.kodp,2,4) NOT IN ('1518','1528') AND
						   SUBSTR(s.kodp,6,1)='1'));

				   IF dat_ < dat_2p_ THEN -- з 2 кварталу включається 1/2 частина Нд/1, а з 3 кварталу - повністю
					   RPR_ := RPR_ + 0.5 * NVL(sumnd1_,0);
				   ELSE
				   	   RPR_ := RPR_ + NVL(sumnd1_,0);
				   END IF;
		   END IF;

		   -- прострочені нараховані доходи
		   SELECT SUM(TO_NUMBER(s.znap))
		   INTO sumpnd_
		   FROM   v_banks_report s
		   WHERE  s.datf=Dat_ AND
		   		  s.kodf=kf1_ AND
		   		  --SUBSTR(s.kodp,1,6) IN ('101419','101429','101509','101519','101529','102029','102039', '102069','102079','102109','102119','102209','102219','102229','103119','103219','103579');
				  SUBSTR(s.kodp,1,2) = '10' AND
				  SUBSTR(s.kodp,3,4) IN (SELECT r020
				  					 				  FROM KL_R020
													  WHERE prem='КБ ' AND
	  												  			    pr IS NULL AND
																	LOWER(txt) LIKE '%простр%нарах%доход%');

		   RPR_ :=  RPR_ + NVL(sumpnd_,0);

		   -- сумнівна заборгованість за нарахованими доходами
		   SELECT SUM(TO_NUMBER(s.znap))
		   INTO sumsnd_
		   FROM   v_banks_report s
		   WHERE  s.datf=Dat_ AND
		   		  s.kodf=kf1_ AND
		   		  SUBSTR(s.kodp,2,5) IN ('01780','02480','03589');

		   RPR_ :=  RPR_ + NVL(sumsnd_,0);

		   -- фактично сформована сума резерву за просроченими понад 31 день та сумнівними НД
		   SELECT SUM(TO_NUMBER(s.znap))
		   INTO sumrez_
		   FROM   v_banks_report s
		   WHERE  s.datf=Dat_ AND
		   		  s.kodf=kf1_ AND
		   		  SUBSTR(s.kodp,1,6) IN ('201492','201493','201790','202490','203191','203291','203599');

		   RPR_ :=  RPR_ - NVL(sumrez_,0);

		   -- прибуток/збиток поточного року
		   BEGIN
		      SELECT SUM(DECODE(SUBSTR(kodp,1,2),'10',TO_NUMBER(znap),0)),
		             SUM(DECODE(SUBSTR(kodp,1,2),'20',TO_NUMBER(znap),0))
		      INTO sum6a_, sum6p_
		      FROM   v_banks_report
		      WHERE  datf=Dat_ AND
		             kodf=kf1_ AND
					 SUBSTR(kodp,1,3) IN ('106','107','206','207');
		   EXCEPTION WHEN NO_DATA_FOUND THEN
		      sum6p_:=0 ;
		      sum6a_:=0 ;
		   END ;

		   s5999_ := NVL(sum6p_,0)-NVL(sum6a_,0);

		   -- результат поточного року
		   RPR_ :=  s5999_ - ROUND(RPR_*k_,0);

		   if Dat_ >= dat_3_ then  -- з 01/01/2007 в РПР включається 504 група
				-- прибуток звітного року, що очікує затврдження
				SELECT SUM(decode(SUBSTR(s.kodp,6,1),0,1,1,-1,0)*TO_NUMBER(s.znap))
				INTO  s5040_
				FROM  v_banks_report s
				WHERE s.datf=Dat_ AND
					  s.kodf=kf1_ AND
					  SUBSTR(s.kodp,2,4)='0504';

				p_ins('Прибуто/збиток звітного року, що очікує затвердження (5040/5041): ', NVL(s5040_, 0));

				RPR_ := RPR_ + NVL(s5040_, 0);
		   end if;

		   IF RPR_ > 0 THEN
		      DK_:=DK_+RPR_;
		   ELSE
		      OK_:=OK_-ABS(RPR_);
		   END IF ;

		   -- розмір додаткового капіталу не може бути більше ніж 100 відсотків основного капіталу
		   -- (інстукція 368 II розділ п.1.6)
		   IF DK_ > OK_ THEN
		   	  p_ins('Розрахований додатковий капітал: ', DK_);
		      DK_:=OK_;
		   END IF;

			---------------------------------------------------------------------------
			------------------------ ВІДВЕРНЕННЯ -------------------------------
			---------------------------------------------------------------------------
		   BEGIN
		      SELECT SUM(TO_NUMBER(s.znap))
		      INTO sump3_
		      FROM   v_banks_report s, EK2_V a
		      WHERE  s.datf=Dat_ AND
		             s.kodf=kf1_  AND
		             SUBSTR(s.kodp,2,1)='0' AND
			  		 SUBSTR(s.kodp,3,4)=a.nbs;
		   EXCEPTION WHEN NO_DATA_FOUND THEN
		      sump3_:=0 ;
		   END ;

		   V_ := NVL(sump3_,0);

		   -- додаток 1 до розрахунку відвернення
		   BEGIN
		   	  --  по файлу С5
		      SELECT SUM(DECODE(SUBSTR(kodp,1,1), '1', -1, 1)*TO_NUMBER(znap))
		      INTO   ek1_
		      FROM   v_banks_report
		      WHERE  kodf=kf4_                AND
		             SUBSTR(kodp,2,5) IN ('30073','31073','30032','30052','31032','31052',
					 				  	  '30072','31072','15242','32121')    AND
		             datf=Dat_;
		   EXCEPTION WHEN NO_DATA_FOUND THEN
		      ek1_:=0 ;
		   END ;

		   V_:=NVL(V_,0) + (-1)*NVL(EK1_,0);

		   -- додаток 2 до розрахунку відвернення

		   IF dat_ < dat_2m_ THEN
			   --- резерв по ценным бумагам б/с 3190 (показатель в #84 91722)  до 13 числа
			   --- месяца выбирается из файла #84 за месяц минус 2 от даты формирования
			   --- после 13 числа за предыдущий месяц
	           mes_:=TO_CHAR(Dat_,'MM');
	           god_:=TO_CHAR(Dat_,'YYYY');

		       IF TO_NUMBER(TO_CHAR(Dat_,'dd'))<=11 THEN -- изменено 17.05.2005 -- измененено 13.10.2005 на 11
			   	  IF TO_CHAR(Dat_,'MM')='01' THEN
			         mes_:='12';
			         god_:=TO_CHAR(TO_NUMBER(TO_CHAR(Dat_,'YYYY'))-1);

		          	 dat2_:=TO_DATE('01'||LPAD(TO_CHAR(TO_NUMBER(mes_)),2,'0')||god_,'ddmmyyyy');
				  ELSE
				  	 dat2_:=TO_DATE('01'||LPAD(TO_CHAR(TO_NUMBER(mes_)-1),2,'0')||god_,'ddmmyyyy');
				  END IF;
		       ELSE
		          dat2_:=TO_DATE('01'||mes_||god_,'ddmmyyyy');
		       END IF;

		       BEGIN
			      SELECT datf, SUM(TO_NUMBER(znap))
			      INTO dat_rez_, rez3190_
			      FROM   v_banks_report
			      WHERE  kodf=kf3_                 AND
			             SUBSTR(kodp,1,5)='91722'  AND
			             datf=(SELECT MAX(datf)
						 	   FROM v_banks_report
		                       WHERE kodf=kf3_ AND
							   		 datf<=Dat2_)
				  GROUP BY datf;
			   EXCEPTION WHEN NO_DATA_FOUND THEN
			      rez3190_:=0;
				  dat_rez_:=NULL;
			   END ;
		   ELSE
		   	    --- резерв по ценным бумагам б/с 3190 получаем из #C5
		       BEGIN
			      SELECT SUM(DECODE(SUBSTR(kodp,1,1), '1', -1, 1)*TO_NUMBER(znap))
			      INTO rez3190_
			      FROM   v_banks_report
		          WHERE  kodf=kf4_                AND
		             	 		SUBSTR(kodp,2,5) IN ('31903','31904','31906')  AND
		             			datf=Dat_;

				  dat_rez_:=Dat_;
			   EXCEPTION WHEN NO_DATA_FOUND THEN
			      rez3190_:=0;
				  dat_rez_:=NULL;
			   END ;
		   END IF;

		   V_:=V_-NVL(rez3190_,0);

		   -- додаток 3 до розрахунку відвернення
		   BEGIN
		   	  --  по файлу 42
		      SELECT SUM(TO_NUMBER(znap))
		      INTO   ek2_
		      FROM   v_banks_report
		      WHERE  kodf=kf2_                AND
		             SUBSTR(kodp,1,2) IN ('43','50')    AND
		             datf=Dat_;
		   EXCEPTION WHEN NO_DATA_FOUND THEN
		      ek2_:=0;
		   END ;

		   V_:=V_+NVL(ek2_,0);

	       ---------------------------------------------------------------------------
		   ---------------------- Регулятивний капітал -------------------------------
		   ---------------------------------------------------------------------------
		   RK1_:=OK_+DK_-V_;

		   -- перевищення нормативів Н7 та Н9
		   BEGIN
		   	  --  по файлу 42 за попередню дату
		      SELECT NVL(SUM(TO_NUMBER(znap)), 0)
		      INTO   ek2_
		      FROM   v_banks_report
		      WHERE  kodf=kf2_                AND
		             SUBSTR(kodp,1,2) IN ('41','42')    AND
		             datf=DatN_;
		   EXCEPTION WHEN NO_DATA_FOUND THEN
		      ek2_:=0;
		   END ;

		   RK2_ := RK1_ - NVL(ek2_,0);

		   -- основні засоби
		   BEGIN
		      SELECT SUM(DECODE(SUBSTR(kodp,1,1),'1',-1,1)*TO_NUMBER(znap))
		      INTO OZ_
		      FROM   v_banks_report
		      WHERE  datf=Dat_ AND
		             kodf=kf1_ AND
					 SUBSTR(kodp,2,5) IN ('04400','04409','04430','04431','04500','04509','04530');
		   EXCEPTION WHEN NO_DATA_FOUND THEN
		      OZ_:=0 ;
		   END ;

		   -- перевищення ОЗ над РК
		   OZ_:=ABS(OZ_);

		   IF OZ_ > RK2_ THEN
		  	  POZ_ := OZ_ - RK2_;
		   ELSE
		   	  POZ_ := 0;
		   END IF;

		   -- Регулятивний капітал
		   RK_ := RK2_ - POZ_;

		   IF RK1_ <= 0 THEN
		      RK_:=1000000000 ;
		   END IF ;

		   IF RK2_ <= 0 THEN
		      RK_:=1000000000 ;
		   END IF ;

		   IF RK_ <= 0 THEN
		      RK_:=1000000000 ;
		   END IF ;
	   END IF;
   END IF;

   IF kodf_ IS NOT NULL AND mfo_<>300465 AND flag_ = 1 THEN

	   p_ins('Субординований борг ('||TO_CHAR(k_SB_*100)||'%): ', ek4_);

	   p_ins('Додатковий капітал в розрахунку : ', DK_);

	   p_ins('Відвернення: ', V_);

	   p_ins('Результат поточного року (5999): ', s5999_);

	   IF dat_ >= dat_2k_ THEN
	   	  p_ins('Нараховані доходи, срок отримання передбачений до 3 місяців (Нд/1): ', sumnd1_);
	   	  p_ins('0.5 * Нд/1: ', 0.5 * sumnd1_);
	   ELSIF dat_ >= dat_2p_ THEN
	   	  p_ins('Нараховані доходи, срок отримання передбачений до 3 місяців: ', sumnd1_);
	   END IF;

	   p_ins('Нарах. доходи, срок отримання яких не визначений або > 3 місяців (Нд/2): ', sumnd2_);

	   p_ins('Просрочені нараховані доходи: ', sumpnd_);

	   p_ins('Сумнівна заборгованість за нарахованими доходами: ', sumsnd_);

	   p_ins('Фактично сформована сума резерву за просроченими понад 31 день та сумнівними НД: ', sumrez_);

	   p_ins('Прибуток/збиток поточного року (Рпр) (поправочний коефіцієнт = '||TO_CHAR(k_,'0.0')||'): ', RPR_);

	   p_ins('резерв по ценным бумагам б/с 3190 (за '''||TO_CHAR(dat_rez_,'dd.mm.yyyy')||'''): ', rez3190_);

	   p_ins(' ----------------------------------------------------------------------- ',NULL);

	   p_ins('Регулятивний капітал (РК1): ',RK1_);

	   p_ins(' ----------------------------------------------------------------------- ',NULL);

	   p_ins('Перевищення нормативів Н7 та Н9: ',NVL(ek2_,0));

	   p_ins('Регулятивний капітал (РК2 не відкоригований на суму перевищення ОЗ): ',RK2_);

	   p_ins(' ----------------------------------------------------------------------- ',NULL);

	   p_ins('Основні засоби: ', OZ_);

	   p_ins('Розмір перевищення ОЗ над РК2: ', POZ_);

	   p_ins('Регулятивний капітал: ',RK_);

-- 	   p_ins(' --------------------------------- НОРМАТИВИ --------------------------------- ',NULL);
--
-- 	   p_ins('Максимальний ризик на 1 контрагента (25% від РК1): ',RK1_ * 0.25);
--
-- 	   p_ins('Розмір "великих" кредитів (10% від РК1): ',RK1_ * 0.1);
--
-- 	   --p_ins('Максимальна заборгованість позичальника-інсайдера (5% від РК): ',RK_ * 0.05);
--
-- 	   p_ins('Заборгованість за коштами, що інвестуються  (15% від РК1): ',RK1_ * 0.15);
   END IF;

   IF type_ = 1 THEN
	   RETURN RK1_;
   ELSIF type_ = 2 THEN
	   RETURN RK2_;
   ELSE
	   RETURN RK_;
   END IF;
END Rkapital_V2;
/
 show err;
 
PROMPT *** Create  grants  RKAPITAL_V2 ***
grant EXECUTE                                                                on RKAPITAL_V2     to WR_ALL_RIGHTS;

 
 
 PROMPT ===================================================================================== 
 PROMPT *** End *** ========== Scripts /Sql/BARS/function/rkapital_v2.sql =========*** End **
 PROMPT ===================================================================================== 
 