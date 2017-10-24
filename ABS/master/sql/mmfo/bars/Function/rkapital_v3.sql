
 
 PROMPT ===================================================================================== 
 PROMPT *** Run *** ========== Scripts /Sql/BARS/function/rkapital_v3.sql =========*** Run **
 PROMPT ===================================================================================== 
 
  CREATE OR REPLACE FUNCTION BARS.RKAPITAL_V3 (dat_ DATE,
                                        kodf_ VARCHAR2 DEFAULT NULL,
                                        userid_  NUMBER DEFAULT NULL,
                                        type_  NUMBER DEFAULT 3  -- =1 - PK1, всі інші - РК
					 ) RETURN NUMBER IS
---------------------------------------------------------------
----- Версія від 25.04.2008 (24.04.2008)	   				    ---
---------------------------------------------------------------
-- отчетная дата 04.05.2007 добавляются разрезы по R013 для 3003, 3005, 3007
-- 3003(2,3,5), 3005(2,3,5), 3007(2,4,6)
-- отчетная дата 08.01.2008 для СБ (субординованого боргу) добавляются
-- бал.счет 3661
-- для В-вiдвернення c 08.01.2008 добавляются бал.счет 1514 и разрезы по R013
-- для 1515, 1516 1515(5), 1516(5)
-- 16.04.2008 для нарах.в?дсотк?в добавлено бал.рах 2238 и R013='9'
-- для нарах.в?дсотк?в добавлено бал.рах 3018,3118,3218 и R013 in ('6','8')
-- 24.04.2008 для розрахунку показника "Вс? ?нш? нарахован? доходи(ДОВ?ДКОВО)"
--            не включались вс? рахунки нарах.доход?в для розрахунку загальної
--            суми (зам?сть k.txt було txt стр?чка 325)

        k_	 NUMBER; -- поправочний коефіцієнт
        k_SB_	 NUMBER; -- процент від субординованого боргу

        ek4b_    NUMBER;
        ek4_     NUMBER;
        ek2_     NUMBER;
        ek1_     NUMBER;

	s5999_   NUMBER;
	sumnd_  NUMBER; ---сума нарахованих доходiв строк отримання <=3 мiсяцiв
	sumnd1_  NUMBER; ---сума нарахованих доходiв строк отримання <=3 мiсяцiв
	sumnd2_  NUMBER; ---сума нарахованих доходiв строк отримання >3 мiсяцiв
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

	sql_ 	 VARCHAR2(200);

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
	RK2_ NUMBER; -- регулятивний капітал, відкоригований на ОЗ
	RK_  NUMBER; -- регулятивний капітал

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
   --k_ := F_Get_Params('NOR_KOEF', 0.4);
   k_ := 1;

   k_SB_ := F_Get_Params('NOR_P_SB',0);

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
		   BEGIN -- з ОК вилучається група 504
		      SELECT SUM(DECODE(SUBSTR(s.kodp,1,2),'20',TO_NUMBER(s.znap),0)),
		             SUM(DECODE(SUBSTR(s.kodp,1,2),'10',TO_NUMBER(s.znap),0))
		      INTO sump1_, sump11_
		      FROM v_banks_report s, EK3_OK a
		      WHERE s.datf=Dat_ AND
			  		s.kodf=kf1_ AND
		            SUBSTR(s.kodp,1,2) IN ('20','10')  AND
					SUBSTR(s.kodp,3,4)=a.nbs and
					(a.nbs not like '504%' and a.nbs <> '5030');
		   EXCEPTION WHEN NO_DATA_FOUND THEN
		      sump1_:=0 ;
		      sump11_:=0 ;
		   END ;

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
           if k_SB_=0 then
               select sum(gl.p_icurval(s.kv, ost, DatD_) * nvl(k.pr, 1))
               into ek4_
               from sal s, otcn_kap_sb k
               where s.fdat=DatD_ AND
                     s.nbs in ('3660','3661') and
                     s.acc=k.acc(+);

               ek4_ := NVL(ek4_,0);
           else
    		   SELECT SUM(TO_NUMBER(s.znap))
    		   INTO  ek4_
    		   FROM  v_banks_report s
    		   WHERE s.datf=DatD_ AND
	   		 s.kodf=kf1_ AND
	   		 SUBSTR(s.kodp,2,5) in ('03660','03661');

    		   ek4_ := NVL(ek4_,0)*k_SB_;
           end if;

		   -- субординований борг не повинен перевищувати 50% основного капіталу
		   IF ek4_>OK_*0.5 THEN
		      ek4_:=ROUND(OK_*0.5,0) ;
		   END IF;

		   DK_:=DK_+ek4_;

		  -- нерозподілений прибуток минулих років, що очікує затврдження
		   SELECT SUM(TO_NUMBER(s.znap))
		   INTO  s5030_
		   FROM  v_banks_report s
		   WHERE s.datf=Dat_ AND
		   		 s.kodf=kf1_ AND
		   		 SUBSTR(s.kodp,2,5)='05030';

   		   p_ins('Нерозподілений прибуток минулих років (5030): ', NVL(	s5030_, 0));

  	 	   DK_:=DK_ + NVL(s5030_, 0);

			-----------------------------------------------------------------------------------------------------
			-------------------- РЕЗУЛЬТАТ ПОТОЧНОГО РОКУ -----------------------------
			-----------------------------------------------------------------------------------------------------
		   -- нараховані доходи, що неотримані понад 30 днів з дати нарахування
		   SELECT SUM(TO_NUMBER(znap))
		   INTO sumnd2_
		   FROM   v_banks_report s
		   WHERE s.datf=Dat_ AND
	   		 s.kodf=kf4_ AND
			 SUBSTR(s.kodp,1,5) IN (SELECT '1'||k.r020
			                        FROM KL_R020 k
                                                WHERE LOWER(k.txt) LIKE '%нарах%доход%' AND
                                                k.r020 in (select r020
                                                           from kod_r020
                                                           where prem='КБ '
                                                             and a010='C5')) AND
				 (--(SUBSTR(s.kodp,2,4) IN ('1408','1418','1428') AND
	              --SUBSTR(s.kodp,6,1) IN ('3','9')) OR
				  (SUBSTR(s.kodp,2,4) IN ('1518','1528') AND
                                   SUBSTR(s.kodp,6,1) IN ('7','8')) OR
				  (SUBSTR(s.kodp,2,4) NOT IN ('1408','1418','1428','1518','1528') AND
				   SUBSTR(s.kodp,6,1)='4') OR
                                  (SUBSTR(s.kodp,2,4) IN ('2238') AND
                                   SUBSTR(s.kodp,6,1) IN ('9')) OR
                                  (SUBSTR(s.kodp,2,4) IN ('3018','3118','3218') AND
                                   SUBSTR(s.kodp,6,1) IN ('6','8')) );

		   RPR_ := NVL(sumnd2_,0);

		   -------------------------  ЛИШЕ ДОВІДКОВО --------------------------------------
		   -- всі нараховані доходи
		   SELECT SUM(TO_NUMBER(znap))
		   INTO sumnd_
		   FROM   v_banks_report s
		   WHERE s.datf=Dat_ AND
	   		 s.kodf=kf4_ AND
			 SUBSTR(s.kodp,1,5) IN (SELECT '1'||k.r020
			                        FROM KL_R020 k
			                        WHERE LOWER(k.txt) LIKE '%нарах%доход%'
			                          and k.r020 in (select r020
			                                         from kod_r020
			                                         where prem='КБ '
			                                           and a010='C5'));

		   sumnd1_ := NVL(sumnd_,0) - NVL(sumnd2_,0);
		   -------------------------  ЛИШЕ ДОВІДКОВО --------------------------------------

		   -- прострочені нараховані доходи
		   SELECT SUM(TO_NUMBER(s.znap))
		   INTO sumpnd_
		   FROM   v_banks_report s
		   WHERE  s.datf=Dat_ AND
		   		  s.kodf=kf1_ AND
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

		   -- прибуток звітного року, що очікує затврдження
		   SELECT SUM(decode(SUBSTR(s.kodp,6,1),0,1,1,-1,0)*TO_NUMBER(s.znap))
		   INTO  s5040_
		   FROM  v_banks_report s
		   WHERE s.datf=Dat_ AND
				  s.kodf=kf1_ AND
				  SUBSTR(s.kodp,2,4)='0504';

		   p_ins('Прибуто/збиток звітного року, що очікує затвердження (5040/5041): ', NVL(s5040_, 0));

		   RPR_ := RPR_ + NVL(s5040_, 0);

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
                      -- c 03.05.2007 добавляются разрезы по R013 для 3003, 3005, 3007
                      -- 3003(2,3,5), 3005(2,3,5), 3007(2,4,6)
                      -- c 08.01.2008 добавляются разрезы по R013 для 1515, 1516
                      -- 1515(5), 1516(5)

		      SELECT SUM(DECODE(SUBSTR(kodp,1,1), '1', -1, 1)*TO_NUMBER(znap))
		      INTO   ek1_
		      FROM   v_banks_report
		      WHERE  kodf=kf4_                AND
		             SUBSTR(kodp,2,5) IN ('15155','15165',
		                                  '30074','31073','30032','30052','31032','31052',
	 				  	  '30072','31072','15242','32121',
	 				  	  '30076','30033','30035','30053','30055') AND
		             datf=Dat_;
		   EXCEPTION WHEN NO_DATA_FOUND THEN
		      ek1_:=0 ;
		   END ;

		   V_:=NVL(V_,0) + (-1)*NVL(EK1_,0);

		   -- додаток 2 до розрахунку відвернення

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

		   -- Регулятивний капітал
		   RK_ := RK1_ - NVL(ek2_,0);

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

	   p_ins('Нараховані доходи, що неотримані понад 30 днів з дати нарахування (Нд/2): ', sumnd2_);

	   p_ins('Всі інші нараховані доходи (ДОВІДКОВО): ', sumnd1_);

	   p_ins('Просрочені нараховані доходи: ', sumpnd_);

	   p_ins('Сумнівна заборгованість за нарахованими доходами: ', sumsnd_);

	   p_ins('Фактично сформована сума резерву за просроченими понад 31 день та сумнівними НД: ', sumrez_);

	   p_ins('Прибуток/збиток поточного року (Рпр) (поправочний коефіцієнт = '||TO_CHAR(k_,'0.0')||'): ', RPR_);

	   p_ins('резерв по цінним паперам б/с 3190 (за '''||TO_CHAR(dat_rez_,'dd.mm.yyyy')||'''): ', rez3190_);

	   p_ins(' ----------------------------------------------------------------------- ',NULL);

	   p_ins('Регулятивний капітал (РК1): ',RK1_);

	   p_ins(' ----------------------------------------------------------------------- ',NULL);

	   p_ins('Перевищення нормативів Н7 та Н9: ',NVL(ek2_,0));

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
   ELSE
	   RETURN RK_;
   END IF;
END Rkapital_V3;
 
/
 show err;
 
 
 
 PROMPT ===================================================================================== 
 PROMPT *** End *** ========== Scripts /Sql/BARS/function/rkapital_v3.sql =========*** End **
 PROMPT ===================================================================================== 
 