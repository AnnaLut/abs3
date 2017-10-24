

PROMPT ===================================================================================== 
PROMPT *** Run *** ========== Scripts /Sql/BARS/Procedure/P_SPECPARAM_DEF.sql =========*** R
PROMPT ===================================================================================== 


PROMPT *** Create  procedure P_SPECPARAM_DEF ***

  CREATE OR REPLACE PROCEDURE BARS.P_SPECPARAM_DEF (dat_ in date) is
/*%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
% DESCRIPTION :   Процедура заполнения параметров r011, s180, s181
% COPYRIGHT   :   Copyright UNITY-BARS Limited, 1999.  All Rights Reserved.
% VERSION     :   06.01.2010 (19.01.2007)
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%*/
	S180_   VARCHAR2(1);
	S181_   VARCHAR2(1);
	r011_	VARCHAR2(1);

	S181_r011   VARCHAR2(1);

	r012_	VARCHAR2(1);
	def_r011_ VARCHAR2(1);
	def_s181_  VARCHAR2(1);
	mfo_     VARCHAR2(12);
	mfou_     VARCHAR2(12);
	redag_	  boolean;

	CURSOR SCHETA(acc_ in number) IS
	   SELECT NVL(k.r011,'0'), nvl(k.s181, '0')
	   FROM accounts a, accounts b, kl_r011 k
	   WHERE a.nbs=k.r020     AND
		 	 a.kv=b.kv        AND
	         SUBSTR(a.nls,6,9)=SUBSTR(b.nls,6,9) AND
	         b.nbs=k.r020r011 AND
		 	 k.prem='КБ '     AND
		 	 a.acc=acc_       AND
		 	 k.d_close IS NULL;
begin
	mfo_:=F_Ourmfo();

	-- МФО "родителя"
	BEGIN
	   SELECT mfou
	     INTO mfou_
	     FROM BANKS
	    WHERE mfo = mfo_;
	EXCEPTION
	   WHEN NO_DATA_FOUND
	   THEN
	      mfou_ := mfo_;
	END;

	 for i in (SELECT  a.acc, a.nbs,
					   NVL(Trim(s.r011),'0') r011,
					   DECODE(nvl(Trim(s.s180),'0'), '0', DECODE(SUBSTR(a.nbs,1,1),'1', Fs180mbk(a.acc), Fs180(a.acc)), s180) s180,
					   NVL(trim(s.s181),'0') s181,
					   nvl(s.acc, '0') acc1_
				  FROM accounts a, kod_r020 k, specparam s
				 WHERE a.dazs IS NULL AND
				 	   a.nls like k.r020||'%' and
					   k.a010 = '06' AND
					   k.d_close IS NULL and
					   a.acc=s.acc(+))
	loop
	    redag_ := false;

	    r011_:=i.r011;
	    s180_:=i.s180;
	    s181_:=i.s181;

		OPEN SCHETA(i.acc);
		LOOP
			FETCH Scheta INTO r011_, s181_r011;
			EXIT WHEN Scheta%NOTFOUND;

			 -- пока только для Петрокоммерца
			IF 300120 IN (mfo_, mfou_)  --AND i.nbs IN ('2067', '2068', '2069', '2638')
			THEN
			   s181_ := s181_r011;
			end if;
		END LOOP;
		CLOSE Scheta;

	    BEGIN
	      SELECT DECODE(r012,NULL,'0', ' '  ,'0',r012),
	                    DECODE(S240,NULL,'0', ' '  ,'0',S240)
	      INTO def_r011_, def_s181_
	      FROM kl_f3_29
	      WHERE kf='14' AND r020=i.nbs;

	      IF NVL(Trim(r011_),'0')='0' THEN
	         r011_:=NVL(def_r011_, r011_);
	      END IF;

	      IF NVL(Trim(s181_),'0')='0' THEN
	         s181_:=NVL(def_s181_, s181_);
	      END IF;
	   	EXCEPTION
	      WHEN NO_DATA_FOUND THEN NULL;
	    END;

	    IF s181_ NOT IN ('1','2') THEN
	      IF s180_='9' THEN
	         s181_:='2' ;
	      ELSE
	         s181_:='1' ;
	      END IF ;
	     END IF;

		 IF i.acc1_=0  THEN
			INSERT INTO specparam (acc, r011, s180, s181)
			VALUES (i.acc, r011_, s180_, s181_);
		  ELSE
		  	 if i.r011<>r011_ or i.s180<>s180_ or i.s181<>s181_ then
				UPDATE specparam
				SET r011=r011_,
					s180=s180_,
					s181=s181_
				WHERE acc=i.acc ;
			  end if;
		  END IF;
	end loop;
end;
/
show err;



PROMPT ===================================================================================== 
PROMPT *** End *** ========== Scripts /Sql/BARS/Procedure/P_SPECPARAM_DEF.sql =========*** E
PROMPT ===================================================================================== 
