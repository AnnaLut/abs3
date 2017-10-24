
 
 PROMPT ===================================================================================== 
 PROMPT *** Run *** ========== Scripts /Sql/BARS/function/rkapital_v2.sql =========*** Run **
 PROMPT ===================================================================================== 
 
  CREATE OR REPLACE FUNCTION BARS.RKAPITAL_V2 (dat_ DATE,
	   	  		  		   			 kodf_ VARCHAR2 DEFAULT NULL,
									 userid_  NUMBER DEFAULT NULL,
									 type_  NUMBER DEFAULT 3  -- =1 - PK1
									 -- =2 - PK2, =3 - ��
									 ) RETURN NUMBER IS
---------------------------------------------------------------------------
--- ������� ���������� ������������� �������  ---
--- �� ������ (�� 01.05.2005) ���������	       ---
--------------------------------------------------
----- ����� �� 21.10.2009 (25.02.2005)	   ---
--------------------------------------------------
---  21.10.2009 - ������ KL_R020 �� KOD_R020
---- 19/12/2005  ���� ����� ��������� ��� �24-622/212 �� 30.11.2005 --
---- 05/01/2006  ��i�� ��i��� ��������� ��� �493 �i� 22.12.2005 ��� ���� � �������� ���������� ������. ��������� --
---- 02.02.2006  �̲�� ��� ���������� ��������� "������� �� ���������� ��" (�������� � ����� �5)
---- 29/12/2006  ���� ����� ���������� ����� ��� ( ���� DK > OK, �� � ���������� �������� DK = OK)
---- 19/01/2007  ���� ����� ����� ��� �40-117/110 �� 16/01/2007
---------------------------------------------------------------------------------------------------------------
    dat_Zm_	DATE := TO_DATE('21122005','ddmmyyyy'); -- ��������� � �� ���� ����� ��������� ��� �24-622/212 �� 30.11.2005
	dat_2m_	 DATE := TO_DATE('01022006','ddmmyyyy'); -- ������� ��� ��� ���������� ������� �� ���������� �� (� �5 �����, � �� � 84 �����)
	dat_2k_	 DATE := TO_DATE('01042006','ddmmyyyy'); -- ������� 1-�� ������� ��� �� ���������� ���������� ��������� ����
	dat_2p_	 DATE := TO_DATE('01072006','ddmmyyyy'); -- ������� 2-�� ������� ��� �� ���������� ���������� ��������� ����
	dat_3_	 DATE := TO_DATE('01012007','ddmmyyyy'); -- ��������� � �� ���� ����� ����� ��� �40-117/110 �� 16/01/2007

    k_		 NUMBER; -- ����������� ����������
	k_SB_	 NUMBER; -- ������� �� ��������������� �����

    ek4b_    NUMBER;
	ek4_     NUMBER;
	ek2_     NUMBER;
	ek1_     NUMBER;

	s5999_   NUMBER;
	sumnd1_   NUMBER; ---���� ����������� �����i� ����� ��������� <=3 �i���i�
	sumnd2_   NUMBER; ---���� ����������� �����i� ����� ��������� >3 �i���i�
	sumpnd_  NUMBER; ---���� ������������ ����������� �����i�
	sumsnd_  NUMBER; ---����i��� ����������i��� �� ������������ ��������
	sumrez_  NUMBER; ---���� ������� �� ��������.>31 ��� i ����i�. �� ��������� ��
	rez3190_ NUMBER; ---���� ������� �� ������ ������� (���� #84 ������ 91722)
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

  	datD_    DATE;        -- ���� ������ ������ !!!
  	dc_      INTEGER;

   	fmt_ VARCHAR2(30):='999G999G999G990D99';

	OK_	 NUMBER := 0; -- �������� ������
	DK_	 NUMBER := 0; -- ���������� ������
	V_	 NUMBER := 0; -- ����������
	RPR_ NUMBER := 0; -- ��������� ��������� ����
	OZ_	 NUMBER := 0; -- ������ ������
	POZ_ NUMBER := 0; -- ����������� �� ��� ��

	RK1_ NUMBER; -- ������������ ������, �� ������������� �� ��
	RK2_ NUMBER; -- ������������ ������, �� ������������� �� ��
	RK_ NUMBER; -- ������������ ������, �� ������������� �� ��

	dat_rez_	DATE; -- ����. ����, �� ������� ���� ������� �� ������ �������


	PROCEDURE p_ins(p_kod_ VARCHAR2, p_val_ NUMBER) IS
	BEGIN
	   IF kodf_ IS NOT NULL AND userid_ IS NOT NULL THEN
		   INSERT INTO OTCN_LOG (kodf, userid, txt)
		   VALUES(kodf_,userid_,p_kod_||TO_CHAR(p_val_/100, fmt_));
	   END IF;
	END;
BEGIN
   flag_ := F_Get_Params('NOR_A7_F',1);

   -- ����������� ����������
   k_ := F_Get_Params('NOR_KOEF',0.4);

   k_SB_ := F_Get_Params('NOR_P_SB',1);

   IF kodf_ IS NOT NULL THEN
	   DELETE FROM OTCN_LOG
	   WHERE userid = userid_ AND
	   		 kodf = kodf_;
   END IF;

   p_ins('���� ���������� : '||TO_CHAR(dat_,'dd.mm.yyyy'),NULL);

   IF flag_ = 0 THEN
	   RK_ := F_Get_Params('NORM_A7');

   	   p_ins('������������ ������ (���������): ',RK_);

	   RETURN RK_;
   ELSE
   	   IF mfo_=300465 THEN
		   sql_ := 'SELECT a.sumrk '||
			  	   'FROM REGCAPITAL a '||
		      	   'WHERE a.fdat=(select max(fdat) from REGCAPITAL where fdat<=:Dat_)';

		   EXECUTE IMMEDIATE sql_ INTO RK_ USING dat_;

		   p_ins('������������ ������ (�� REGCAPITAL): ',RK_);

		  RETURN RK_;
	   ELSE

		   IF kodf_ IS NOT NULL THEN
			   -- �������� ����, �� ����������� �01 ���� �� ����� ����
			   p_ins('-------- �������� �������� � �� �����, �� ���������������� ��� ���������� ------',NULL);

			   count_ := F_Perevirka(kodf_, kf1_, dat_, userid_);
			   count_ := count_ + F_Perevirka(kodf_, kf4_, dat_, userid_);

			   IF count_ = 0 THEN
			   	  p_ins('�� ����� ����������.',NULL);
			   END IF;
		   END IF;

		   p_ins(' --------------------------------- ���������� --------------------------------- ',NULL);

		   DatN_ := Calc_Pdat(dat_)-1; -- ��������� ���� ���������� ����� 42

		   SELECT MAX(w.datf)
			 INTO datN_
			 FROM TMP_NBU w
			 WHERE w.kodf=kf2_ AND w.datf <= datN_;
		   ---------------------------------------------------------------
			-- ������ ������
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
			------------------------ �������� ��ϲ��� ---------------------
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
			   BEGIN -- � �� ���������� ����� 504
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

		   -- ��������
	   	   p_ins('�������� ������: ', OK_);

		   ------------------------------------------------------------------------------------
		   ------------------------ ���������� ��ϲ��� ---------------------
		   ------------------------------------------------------------------------------------
		   BEGIN
		      SELECT SUM(TO_NUMBER(znap))
		      INTO sump2_
		      FROM  v_banks_report
		      WHERE datf=Dat_ AND
			  		kodf=kf1_ AND
		            SUBSTR(kodp,2,5) IN ('01591','01593','02401');
					-- +1593 ����� ����� ��� N40-117/35 11.01.2005
		   EXCEPTION WHEN NO_DATA_FOUND THEN
		      sump2_:=0 ;
		   END;

		   DK_ := NVL(sump2_, 0);

		   IF kodf_ IS NOT NULL THEN
			   -- ��������
			   INSERT INTO OTCN_LOG (kodf, userid, txt)
			   SELECT kodf_,userid_,'�� (�� '||nbs||'): '||TO_CHAR(val/100, fmt_)
			   FROM (SELECT SUBSTR(kodp,3,4) nbs, SUM(TO_NUMBER(znap)) val
		       		FROM  v_banks_report
		       		WHERE datf=Dat_ AND
			  		 	  kodf=kf1_ AND
		             	  SUBSTR(kodp,2,5) IN ('01591','01593','02401')
			   		GROUP BY SUBSTR(kodp,3,4));
		   END IF;

		   -- ��������� ���������� �������� ������
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

	   	   p_ins('�� (�� 5100 r013=1): ', ek2_);

		   DK_:=DK_+NVL(ek2_,0);

		   -- ������ �� ���������� �������������
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

	   	   p_ins('�� (�� 3690 r013=1): ', ek2_);

		   DK_:=DK_+NVL(ek2_,0) ;

		   -- �������������� ����
		   SELECT SUM(TO_NUMBER(s.znap))
		   INTO  ek4_
		   FROM  v_banks_report s
		   WHERE s.datf=DatD_ AND
		   		 s.kodf=kf1_ AND
		   		 SUBSTR(s.kodp,2,5)='03660';

		   ek4_ := NVL(ek4_,0)*k_SB_;

		   -- �������������� ���� �� ������� ������������ 50% ��������� �������
		   IF ek4_>OK_*0.5 THEN
		      ek4_:=ROUND(OK_*0.5,0) ;
		   END IF;

		   DK_:=DK_+ek4_;

 		  IF dat_ >= dat_Zm_ THEN	-- � 21.12.2005
			  -- ������������� �������� ������� ����, �� ����� �����������
			   SELECT SUM(TO_NUMBER(s.znap))
			   INTO  s5030_
			   FROM  v_banks_report s
			   WHERE s.datf=Dat_ AND
			   		 		 s.kodf=kf1_ AND
			   				 SUBSTR(s.kodp,2,5)='05030';

	   		  p_ins('������������� �������� ������� ���� (5030): ', NVL(	s5030_, 0));

	 		  IF dat_ < dat_2p_ THEN -- � 1 ������ 5030 ���������� � �������� ������, � � 2 ������ - � ����������
			  	    NULL;
			  ELSE
			  	 	OK_:=OK_ - NVL(	s5030_, 0);

			  	 	DK_:=DK_ + NVL(	s5030_, 0);
			  END IF;

			  if Dat_ < dat_3_ then  -- � 01/01/2007 �� ���������� ������� ������� 504 �����
				-- �������� ������� ����, �� ����� �����������
				SELECT SUM(decode(SUBSTR(s.kodp,6,1),0,1,1,-1,0)*TO_NUMBER(s.znap))
				INTO  s5040_
				FROM  v_banks_report s
				WHERE s.datf=Dat_ AND
					  s.kodf=kf1_ AND
					  SUBSTR(s.kodp,2,4)='0504';

				OK_:=OK_ - NVL(	s5040_, 0);

				p_ins('�������� ������� ����, �� ����� ������������ (5040): ', NVL(s5040_, 0));

				DK_:=DK_ + NVL(s5040_, 0);
			  end if;
		   END IF;
			-----------------------------------------------------------------------------------------------------
			-------------------- ��������� ��������� ���� -----------------------------
			-----------------------------------------------------------------------------------------------------
		   -- ��������� ������, ���� ��������� ���� �� ���������� ��� ������������ > 3 ������
		   SELECT SUM(TO_NUMBER(znap))
		   INTO sumnd2_
		   FROM   v_banks_report s
		   WHERE s.datf=Dat_ AND
		   		 s.kodf=kf4_ AND
				 --SUBSTR(s.kodp,2,4) IN (SELECT r020 FROM KL_R020 WHERE f_c5='1' AND LOWER(txt) LIKE '%�����%�����%') AND
                substr(s.kodp,2,4) in (select r020
                                        from kl_r020
                                        where r020 in (select r020 from kod_r020 where a010='C5') and
                                              lower(txt) like '%�����%�����%') and
				 ((SUBSTR(s.kodp,2,4) IN ('1518','1528') AND
	               SUBSTR(s.kodp,6,1) IN ('3','4')) OR
				  (SUBSTR(s.kodp,2,4) NOT IN ('1518','1528') AND
				   SUBSTR(s.kodp,6,1)='2'));

		   RPR_ := NVL(sumnd2_,0);

	 	   IF dat_ >= dat_2k_ THEN -- � 2 �������� 2006 ����
				   -- ��������� ������, ���� ��������� �� 3 ������
				   SELECT SUM(TO_NUMBER(znap))
				   INTO sumnd1_
				   FROM   v_banks_report s
				   WHERE s.datf=Dat_ AND
				   		 s.kodf=kf4_ AND
						 SUBSTR(s.kodp,2,4) IN (SELECT r020 FROM KL_R020 WHERE r020 in (select r020 from kod_r020 where a010='C5') AND LOWER(txt) LIKE '%�����%�����%') AND
						 ((SUBSTR(s.kodp,2,4) IN ('1518','1528') AND
			               SUBSTR(s.kodp,6,1) IN ('1','2')) OR
						  (SUBSTR(s.kodp,2,4) NOT IN ('1518','1528') AND
						   SUBSTR(s.kodp,6,1)='1'));

				   IF dat_ < dat_2p_ THEN -- � 2 �������� ���������� 1/2 ������� ��/1, � � 3 �������� - �������
					   RPR_ := RPR_ + 0.5 * NVL(sumnd1_,0);
				   ELSE
				   	   RPR_ := RPR_ + NVL(sumnd1_,0);
				   END IF;
		   END IF;

		   -- ���������� ��������� ������
		   SELECT SUM(TO_NUMBER(s.znap))
		   INTO sumpnd_
		   FROM   v_banks_report s
		   WHERE  s.datf=Dat_ AND
		   		  s.kodf=kf1_ AND
		   		  --SUBSTR(s.kodp,1,6) IN ('101419','101429','101509','101519','101529','102029','102039', '102069','102079','102109','102119','102209','102219','102229','103119','103219','103579');
				  SUBSTR(s.kodp,1,2) = '10' AND
				  SUBSTR(s.kodp,3,4) IN (SELECT r020
				  					 				  FROM KL_R020
													  WHERE prem='�� ' AND
	  												  			    pr IS NULL AND
																	LOWER(txt) LIKE '%������%�����%�����%');

		   RPR_ :=  RPR_ + NVL(sumpnd_,0);

		   -- ������� ������������� �� ������������ ��������
		   SELECT SUM(TO_NUMBER(s.znap))
		   INTO sumsnd_
		   FROM   v_banks_report s
		   WHERE  s.datf=Dat_ AND
		   		  s.kodf=kf1_ AND
		   		  SUBSTR(s.kodp,2,5) IN ('01780','02480','03589');

		   RPR_ :=  RPR_ + NVL(sumsnd_,0);

		   -- �������� ���������� ���� ������� �� ������������ ����� 31 ���� �� ��������� ��
		   SELECT SUM(TO_NUMBER(s.znap))
		   INTO sumrez_
		   FROM   v_banks_report s
		   WHERE  s.datf=Dat_ AND
		   		  s.kodf=kf1_ AND
		   		  SUBSTR(s.kodp,1,6) IN ('201492','201493','201790','202490','203191','203291','203599');

		   RPR_ :=  RPR_ - NVL(sumrez_,0);

		   -- ��������/������ ��������� ����
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

		   -- ��������� ��������� ����
		   RPR_ :=  s5999_ - ROUND(RPR_*k_,0);

		   if Dat_ >= dat_3_ then  -- � 01/01/2007 � ��� ���������� 504 �����
				-- �������� ������� ����, �� ����� �����������
				SELECT SUM(decode(SUBSTR(s.kodp,6,1),0,1,1,-1,0)*TO_NUMBER(s.znap))
				INTO  s5040_
				FROM  v_banks_report s
				WHERE s.datf=Dat_ AND
					  s.kodf=kf1_ AND
					  SUBSTR(s.kodp,2,4)='0504';

				p_ins('�������/������ ������� ����, �� ����� ������������ (5040/5041): ', NVL(s5040_, 0));

				RPR_ := RPR_ + NVL(s5040_, 0);
		   end if;

		   IF RPR_ > 0 THEN
		      DK_:=DK_+RPR_;
		   ELSE
		      OK_:=OK_-ABS(RPR_);
		   END IF ;

		   -- ����� ����������� ������� �� ���� ���� ����� �� 100 ������� ��������� �������
		   -- (��������� 368 II ����� �.1.6)
		   IF DK_ > OK_ THEN
		   	  p_ins('������������ ���������� ������: ', DK_);
		      DK_:=OK_;
		   END IF;

			---------------------------------------------------------------------------
			------------------------ ²��������� -------------------------------
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

		   -- ������� 1 �� ���������� ����������
		   BEGIN
		   	  --  �� ����� �5
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

		   -- ������� 2 �� ���������� ����������

		   IF dat_ < dat_2m_ THEN
			   --- ������ �� ������ ������� �/� 3190 (���������� � #84 91722)  �� 13 �����
			   --- ������ ���������� �� ����� #84 �� ����� ����� 2 �� ���� ������������
			   --- ����� 13 ����� �� ���������� �����
	           mes_:=TO_CHAR(Dat_,'MM');
	           god_:=TO_CHAR(Dat_,'YYYY');

		       IF TO_NUMBER(TO_CHAR(Dat_,'dd'))<=11 THEN -- �������� 17.05.2005 -- ���������� 13.10.2005 �� 11
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
		   	    --- ������ �� ������ ������� �/� 3190 �������� �� #C5
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

		   -- ������� 3 �� ���������� ����������
		   BEGIN
		   	  --  �� ����� 42
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
		   ---------------------- ������������ ������ -------------------------------
		   ---------------------------------------------------------------------------
		   RK1_:=OK_+DK_-V_;

		   -- ����������� ��������� �7 �� �9
		   BEGIN
		   	  --  �� ����� 42 �� ��������� ����
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

		   -- ������ ������
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

		   -- ����������� �� ��� ��
		   OZ_:=ABS(OZ_);

		   IF OZ_ > RK2_ THEN
		  	  POZ_ := OZ_ - RK2_;
		   ELSE
		   	  POZ_ := 0;
		   END IF;

		   -- ������������ ������
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

	   p_ins('�������������� ���� ('||TO_CHAR(k_SB_*100)||'%): ', ek4_);

	   p_ins('���������� ������ � ���������� : ', DK_);

	   p_ins('³���������: ', V_);

	   p_ins('��������� ��������� ���� (5999): ', s5999_);

	   IF dat_ >= dat_2k_ THEN
	   	  p_ins('��������� ������, ���� ��������� ������������ �� 3 ������ (��/1): ', sumnd1_);
	   	  p_ins('0.5 * ��/1: ', 0.5 * sumnd1_);
	   ELSIF dat_ >= dat_2p_ THEN
	   	  p_ins('��������� ������, ���� ��������� ������������ �� 3 ������: ', sumnd1_);
	   END IF;

	   p_ins('�����. ������, ���� ��������� ���� �� ���������� ��� > 3 ������ (��/2): ', sumnd2_);

	   p_ins('��������� ��������� ������: ', sumpnd_);

	   p_ins('������� ������������� �� ������������ ��������: ', sumsnd_);

	   p_ins('�������� ���������� ���� ������� �� ������������ ����� 31 ���� �� ��������� ��: ', sumrez_);

	   p_ins('��������/������ ��������� ���� (���) (����������� ���������� = '||TO_CHAR(k_,'0.0')||'): ', RPR_);

	   p_ins('������ �� ������ ������� �/� 3190 (�� '''||TO_CHAR(dat_rez_,'dd.mm.yyyy')||'''): ', rez3190_);

	   p_ins(' ----------------------------------------------------------------------- ',NULL);

	   p_ins('������������ ������ (��1): ',RK1_);

	   p_ins(' ----------------------------------------------------------------------- ',NULL);

	   p_ins('����������� ��������� �7 �� �9: ',NVL(ek2_,0));

	   p_ins('������������ ������ (��2 �� ������������� �� ���� ����������� ��): ',RK2_);

	   p_ins(' ----------------------------------------------------------------------- ',NULL);

	   p_ins('������ ������: ', OZ_);

	   p_ins('����� ����������� �� ��� ��2: ', POZ_);

	   p_ins('������������ ������: ',RK_);

-- 	   p_ins(' --------------------------------- ��������� --------------------------------- ',NULL);
--
-- 	   p_ins('������������ ����� �� 1 ����������� (25% �� ��1): ',RK1_ * 0.25);
--
-- 	   p_ins('����� "�������" ������� (10% �� ��1): ',RK1_ * 0.1);
--
-- 	   --p_ins('����������� ������������� ������������-��������� (5% �� ��): ',RK_ * 0.05);
--
-- 	   p_ins('������������� �� �������, �� ������������  (15% �� ��1): ',RK1_ * 0.15);
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
 