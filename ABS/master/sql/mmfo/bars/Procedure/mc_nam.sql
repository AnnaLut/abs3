

PROMPT ===================================================================================== 
PROMPT *** Run *** ========== Scripts /Sql/BARS/Procedure/MC_NAM.sql =========*** Run *** ==
PROMPT ===================================================================================== 


PROMPT *** Create  procedure MC_NAM ***

  CREATE OR REPLACE PROCEDURE BARS.MC_NAM (
	mfo_	VARCHAR2,		-- ���, �� ������� ������ ������������� ����� MC
	sab_	CHAR,
	AutoReceipting_	  SMALLINT	-- ������� ������������
										-- 1- ����� ��������� ���������, 0 - ���������
	) IS

ern               CONSTANT POSITIVE := 101;
erm               VARCHAR2(256);   -- ������������ ����� 2048
err               EXCEPTION;

dat_			DATE;
dat_b_			DATE;
mc_date_		DATE;
mc_num_			SMALLINT;
koda_			SMALLINT;
otm_			SMALLINT;
n_				SMALLINT;
sea_			CHAR(1);	-- 1-�� ���� ������ ���������������� ������
									-- (���������� �����)
fn_				CHAR(12);
fn2_			CHAR(12);
dat2_			DATE;
datk_			DATE;

year_ 			CHAR(4);
ownMD32		    CHAR(2);		  -- M����+���� � 36-������ �������

CURSOR zag IS
 SELECT fn, dat
 FROM zag_mc
    WHERE (sab=sab_) -- �����! �� ����������, � ������� ��������� SAB
		  AND (  dat2 IS NULL OR -- ���� ����� �� ���-��� �� �����������
				-- ��� ������ �������
				TRUNC(dat2) <= TRUNC(dat_b_)
			  )
		  AND (otm=3 OR otm=0 OR otm IS NULL)
			-- � ���� ������������ ����������� ��� < ����������
		  AND ( dat_fm IS NULL OR
				TRUNC(dat_fm)<=TRUNC(dat_b_)
			  );
CURSOR zag_update IS
  SELECT n, fn2, dat2, otm
  FROM zag_mc
  WHERE fn=fn_ and TRUNC(dat)=TRUNC(dat_)
  FOR UPDATE OF fn2, dat2, otm, datk NOWAIT;

BEGIN
  dbms_output.put_line('---------------------------------');
  dbms_output.put_line('Start mc_nam('||mfo_||', '||sab_||', '||AutoReceipting_||')');

  dat_b_ := TO_DATE (TO_CHAR(gl.bDATE,'MM-DD-YYYY')||' '||
                  TO_CHAR(SYSDATE,'HH24:MI'),'MM-DD-YYYY HH24:MI');
  dbms_output.put_line('dat_b_='||dat_b_);
  year_ := SUBSTR(TO_CHAR(gl.bDATE,'YYYY'),4,1);
  dbms_output.put_line('gl.bDATE='||TO_CHAR(gl.bDATE,'YYYY'));
  dbms_output.put_line('year_='||year_);

  mc_date_ := NULL;
  mc_num_ := NULL;
  n_ := NULL;
  sea_ := NULL;
  fn_ := NULL;
  dat_ := NULL;
  otm_ := NULL;
  fn2_ := NULL;
  dat2_ := NULL;
  datk_ := NULL;
  -- M����+���� � 36-������ �������
  ownMD32 := sep.h2_rrp(TO_NUMBER(TO_CHAR(gl.bDATE,'MM')))||
        	   sep.h2_rrp(TO_NUMBER(TO_CHAR(gl.bDATE,'DD')));

-- ���� � mc_count ��� ���������� ��� ����� ����� �� ������ ����,
-- ������������ ������ �� ����������� ����
SELECT mc_date, mc_num INTO mc_date_, mc_num_
FROM mc_count WHERE mfo=mfo_;

IF mc_date_ IS NULL OR NOT(mc_date_=TRUNC(dat_b_)) THEN
   UPDATE mc_count SET mc_date=TRUNC(dat_b_),
   		  		   	   mc_num=0
   WHERE mfo=mfo_;
   mc_date_	:= TRUNC(dat_b_);
   mc_num_	:= 0;
END IF;


-- ����� ������ �� ���������� ������ MC
OPEN zag;
LOOP
<<FETCH_zag>>
  FETCH zag INTO fn_, dat_;
  IF sea_ IS NOT NULL THEN
	COMMIT;
	dbms_output.put_line('COMMIT complete');
  END IF;
  EXIT WHEN zag%NOTFOUND;
  dbms_output.put_line('Process: fn='||fn_||', dat='||dat_);
  -- ��������� ������ �� update ������
  OPEN zag_update;
  FETCH zag_update INTO n_, fn2_, dat2_, otm_;
    datk_ := NULL;
    -- ����������� �������
	mc_num_ := mc_num_ + 1;
	UPDATE mc_count SET mc_date=mc_date_,
		   				mc_num=mc_num_
	WHERE mfo=mfo_;
	-- ������� ������
	IF (otm_ IS NULL) OR (otm_=0) THEN -- ��� ����� ��� �� �����������
		-- ��������� ��� � ���������� ���� ��� ���������� (dat2)
		sea_  := SUBSTR(year_,1,1);
		fn2_  := SUBSTR(fn_,1,3)||SUBSTR(sab_,2,3)||ownMD32||'.'||sea_||
					sep.h2_rrp(trunc(mc_num_/36))||sep.h2_rrp(mod(mc_num_,36));
		dat2_ := dat_b_;
		otm_  := 1;
		dbms_output.put_line('Set name: '||fn2_||', date='||dat2_);
	ELSIF otm_=3 THEN -- ���� ����� ������������
		sea_  := SUBSTR(year_,1,1);
		-- ���� �� ������� ���������� ����� �� ������ 7 ����
		IF TRUNC(dat_b_)-7<=TRUNC(dat2_) AND TRUNC(dat2_)<=TRUNC(dat_b_)
			-- � ��������� ������������
			AND AutoReceipting_=0
			THEN
			-- ������ ������������� ���� � ��� ��(!!) ������ � �����
			otm_ := 1;
			dbms_output.put_line('Reassembling file : '||fn2_||', date='||dat2_);
		ELSE -- ���� ���������� �������������
			-- ������� ������������ otm=9
			otm_  := 9;
			datk_ := dat_b_;
			dbms_output.put_line('Autoreceipting file : '||fn2_||', date='||dat2_);
		END IF;
	END IF;
	-- �������� ������ ���������
	UPDATE zag_mc SET fn2=fn2_, dat2=dat2_, otm=otm_, datk=datk_
    WHERE CURRENT OF zag_update;
  CLOSE zag_update;
END LOOP;
CLOSE zag;
  dbms_output.put_line('Finish mc_nam()');
  dbms_output.put_line('---------------------------------');
EXCEPTION
  WHEN err THEN
     raise_application_error(-(20000+ern),'\'||erm,TRUE);
  WHEN OTHERS THEN
     raise_application_error(-(20000+ern),
     dbms_utility.format_error_stack()||chr(10)||dbms_utility.format_error_backtrace(),TRUE);
END mc_nam; -- end of procedure mc_nam()
/
show err;



PROMPT ===================================================================================== 
PROMPT *** End *** ========== Scripts /Sql/BARS/Procedure/MC_NAM.sql =========*** End *** ==
PROMPT ===================================================================================== 
