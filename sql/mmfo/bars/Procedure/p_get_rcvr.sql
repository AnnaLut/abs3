

PROMPT ===================================================================================== 
PROMPT *** Run *** ========== Scripts /Sql/BARS/Procedure/P_GET_RCVR.sql =========*** Run **
PROMPT ===================================================================================== 


PROMPT *** Create  procedure P_GET_RCVR ***

  CREATE OR REPLACE PROCEDURE BARS.P_GET_RCVR (swref_ IN NUMBER, okpo_ IN OUT VARCHAR2, mfo_ IN OUT VARCHAR2,
nls_ IN OUT VARCHAR2, kv_ IN OUT INTEGER, nazv_ IN OUT VARCHAR2, sum_ IN OUT NUMBER,
datv_	IN OUT DATE, val_ IN OUT NUMBER ) IS
/* =================================================================================
   ��������� ����������� ������������� �����, ��� ���������� (���, ����� ����� ���������� � �.�.) �
   ���������� � ������� �� ���. ���������� SWIFT-���������
   =================================================================================
   VERSION  10.06.2006
   =================================================================================
   ���������:
   		��. ref_  -- ���. SWIFT ���������
   	  	���. okpo_  -- �����. ����� �������������
				mfo_  -- ��� ����������� �������������
				nls_  -- ����� ����� ���������� (��� ���������� ����)
				kv_ -- ��� ������
				nazv_ -- �������� ����������
				sum_ -- ����� �������
				datv_ -- ���� �������������
				val_ -- ������� ���������� �������� � ����������� ������ (0 - �� �����, 1 - �����)
   =================================================================================
*/
   buf_ OPERW.value%TYPE;
   rec_	OPER.D_REC%TYPE;
   pos_	NUMBER;
   num_	VARCHAR2(30):='';
   tag_	 VARCHAR2(4);
   bic_	 VARCHAR2(14);
   knls_ VARCHAR2(20);
   bnls_ VARCHAR2(20);
   bnazv_ ALEGRO.NAMEUKRB%TYPE;
   bokpo_ ALEGRO.ZKPO%TYPE:=NULL;
   bmfo_ ALEGRO.MFO%TYPE:=NULL;
   ret_	 NUMBER;
   sumk_ NUMBER:=0;
BEGIN
	 -- ���������� ��� ���������
	 BEGIN
	    SELECT Trim(mt)
		INTO rec_
		FROM SW_JOURNAL
		WHERE swref=swref_;

		IF rec_ IN ('102','103','2') THEN
		   	tag_ := '59%';
		ELSE
		 	tag_ := '58%';
		END IF;
	EXCEPTION
		 WHEN NO_DATA_FOUND THEN
			 	tag_ := '59%';
	END;

	-- ������������ ���� SWIFT-��
    FOR i IN (SELECT tag, opt, value FROM SW_OPERW WHERE swref=swref_ AND tag LIKE tag_) LOOP
		-- ���� �������� �����
		IF SUBSTR(i.value,1,1)='/' THEN
		    buf_ := SUBSTR(i.value,2);

		    pos_ := INSTR(buf_ ,' ');

			IF pos_ > 0 THEN
			   buf_ := SUBSTR(buf_, 1, pos_ - 1);
			END IF;

		    pos_ := INSTR(buf_ ,CHR(13)||CHR(10));

			IF pos_ > 0 THEN
			   buf_ := SUBSTR(buf_, 1, pos_ - 1);
			END IF;

			pos_ := INSTR(buf_, '(');

			IF pos_ > 0 THEN
			   buf_ := SUBSTR(buf_, 1, pos_ - 1);
			END IF;

			buf_ := Trim(buf_);

			-- ���� �������� ����� ����� ����� ������ 14 ��������, �� ��������
			if length(buf_) > 14 then
			   buf_ := substr(buf_, 1, 14);
			end if;

			knls_ := Trim(buf_);
		END IF;

		-- ���������� � ������������� �����
		pos_ := INSTR(i.value, '(');

		IF pos_ > 0 THEN
		 -- ���������� ����� ��������
		   buf_ := SUBSTR(i.value, pos_+1);

		   pos_ := INSTR(buf_, ')');

		   IF pos_ > 0 THEN
			  num_ := Trim(SUBSTR(buf_ , 1, pos_ - 1));
		   ELSE
			  num_ := Trim(buf_);
		   END IF;

		   -- �� ������ �������� ���������� ���. ���������
		   BEGIN
				SELECT mfo, AccountMVPS, ZKPO, NAMEUKRB, val
				INTO bmfo_, bnls_, bokpo_, bnazv_, val_
				FROM ALEGRO
				WHERE trim(num)= num_;
		   EXCEPTION
				WHEN NO_DATA_FOUND THEN
						 NULL;
		   END;
		ELSE -- ���� �� ������ ��� ��������, �� ���������� BIC
		   IF i.opt IS NOT NULL AND i.opt='A' THEN
			   bic_ := trim(F_Get_Bic(i.value));

			   IF bic_ IS NOT NULL THEN
				   -- �� BIC ����� ���������� ��� � ���. ���������
				   BEGIN
						SELECT mfo, AccountMVPS, ZKPO, NAMEUKRB, val
						INTO bmfo_, bnls_, bokpo_, bnazv_, val_
						FROM ALEGRO
						WHERE trim(REGBICCODE) = bic_ AND
									 ROWNUM=1;
				   EXCEPTION
							WHEN NO_DATA_FOUND THEN
								 NULL;
				   END;
			   END IF;
			END IF;
		END IF;

		-- �������� ����������
		IF NVL(i.opt,'D')='D' THEN
			pos_ := INSTR(i.value, '/');

			-- ���� ���� ����� ����� ����������, �� �������� ���������� ��� � �������� ����������
			IF pos_ > 0 THEN
			    buf_ := SUBSTR(i.value, pos_+1);

				pos_ := INSTR(buf_ ,CHR(13)||CHR(10));

				IF pos_ > 0 THEN
					buf_ := SUBSTR(buf_, pos_+2);

					pos_ := INSTR(buf_ ,CHR(13)||CHR(10));

					IF pos_ > 0 THEN
						buf_ := SUBSTR(buf_, 1, pos_ - 1);
					END IF;

					nazv_ := Trim(buf_);
				ELSE
					pos_ := INSTR(buf_, ' ');

					IF pos_ > 0 THEN
						buf_ := SUBSTR(buf_, pos_+1);
					END IF;

					nazv_ := SUBSTR(Trim(buf_), 1, 70);
				END IF;
			ELSE --���� ��� ������ ����� ����������, �� ��� ��������� ��������� �� �����
-- 				pos_ := INSTR(i.value ,CHR(13)||CHR(10));
--
-- 				-- ��� ���� ������
-- 				IF pos_ > 0 THEN
-- 					buf_ := SUBSTR(i.value, 1, pos_ - 1);
-- 				ELSE
-- 					buf_ := i.value;
-- 				END IF;
--
-- 				nazv_ := Trim(buf_);
				NULL;
			END IF;
		END IF;

		-- ���� ���� ����������� �� �����, �� ����� ���������� ����
		IF Trim(knls_) IS NOT NULL THEN
		   nls_ := knls_;
		ELSIF Trim(bnls_) IS NOT NULL THEN
		   nls_ := bnls_;
		END IF;

		IF Trim(bnazv_) IS NOT NULL THEN
		   nazv_ := bnazv_;
		END IF;

		IF Trim(bmfo_) IS NOT NULL THEN
		   mfo_ := bmfo_;
		END IF;

		IF Trim(bokpo_) IS NOT NULL THEN
		   okpo_ := bokpo_;
		END IF;

		-- ���������� � �������
		ret_ := F_Get_Rekvp(swref_, sum_, sumk_, kv_, datv_);

		RETURN;
	END LOOP;
END;
/
show err;

PROMPT *** Create  grants  P_GET_RCVR ***
grant EXECUTE                                                                on P_GET_RCVR      to BARS013;
grant EXECUTE                                                                on P_GET_RCVR      to BARS_ACCESS_DEFROLE;



PROMPT ===================================================================================== 
PROMPT *** End *** ========== Scripts /Sql/BARS/Procedure/P_GET_RCVR.sql =========*** End **
PROMPT ===================================================================================== 
