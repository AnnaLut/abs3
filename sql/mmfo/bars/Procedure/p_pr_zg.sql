

PROMPT ===================================================================================== 
PROMPT *** Run *** ========== Scripts /Sql/BARS/Procedure/P_PR_ZG.sql =========*** Run *** =
PROMPT ===================================================================================== 


PROMPT *** Create  procedure P_PR_ZG ***

  CREATE OR REPLACE PROCEDURE BARS.P_PR_ZG (acc_ in number, dat_ in date,
									d_sum_ out number, k_sum_ out number,
									type_ in number default 2
									) is
/*%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
% DESCRIPTION :	Процедура выбора проводок по закрытию года
% COPYRIGHT   :	Copyright UNITY-BARS Limited, 1999.All Rights Reserved.
% VERSION     : 19.01.2005
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%*/
begin
--    BEGIN
--        SELECT --NVL(SUM(p.s*decode(p.dk,0,-1,1,1,0)),0)
-- 	   		  SUM(decode(p.dk,0,1,0)*p.s),
-- 		      SUM(decode(p.dk,1,1,0)*p.s)
-- 	   INTO d_sum_,k_sum_
--        FROM oper o, opldok p
--        WHERE o.ref  = p.ref  AND
--              p.fdat = dat_   AND
--              o.sos  = 5      AND
--              p.acc  = acc_   AND
--              o.tt  like  'ZG%' ;
--     EXCEPTION WHEN NO_DATA_FOUND THEN
--        d_sum_:=0;
-- 	   k_sum_:=0;
--     END;

	   if type_ = 1 then
-- 	      BEGIN
-- 	         SELECT SUM(p.s*decode(p.dk,0,-1,1,1,0))
-- 			 INTO d_sum_
-- 	         FROM oper o, opldok p
-- 	         WHERE o.ref  = p.ref  AND
-- 	               p.fdat = dat_   AND
-- 	               o.sos  = 5      AND
-- 	               p.acc  = acc_   AND
-- 	               o.tt  like  'ZG%' ;
-- 	      EXCEPTION WHEN NO_DATA_FOUND THEN
-- 	         d_sum_:=0;
-- 	      END;
	      BEGIN
	         SELECT NVL(SUM(s*decode(dk,0,-1,1,1,0)),0)
			 INTO d_sum_
	         FROM KOR_PROV
	         WHERE fdat = dat_   AND
	               acc  = acc_   AND
	               vob = 0 ;
	      EXCEPTION WHEN NO_DATA_FOUND THEN
	         d_sum_:=0;
	      END;
		else
-- 	      BEGIN
-- 	         SELECT SUM(decode(op.dk,0,1,0)*op.s),
-- 	               	SUM(decode(op.dk,1,1,0)*op.s)
-- 	         INTO d_sum_, k_sum_
-- 	         FROM  oper o, opldok op
-- 	         WHERE op.fdat=Dat_   AND
-- 	               op.acc=acc_    AND
-- 	               o.sos = 5      AND
-- 	               o.ref = op.ref AND
-- 	               o.tt  LIKE  'ZG%';
-- 	      EXCEPTION WHEN NO_DATA_FOUND THEN
-- 	         d_sum_:=0;
-- 	         k_sum_:=0;
-- 	      END;
	      BEGIN
	         SELECT NVL(SUM(decode(dk,0,1,0)*s),0),
	                NVL(SUM(decode(dk,1,1,0)*s),0)
	         INTO d_sum_, k_sum_
	         FROM KOR_PROV
	         WHERE fdat = dat_   AND
	               acc  = acc_   AND
	               vob = 0;
	      EXCEPTION WHEN NO_DATA_FOUND THEN
	         d_sum_:=0;
	         k_sum_:=0;
	      END;
	   end if;

	d_sum_:=nvl(d_sum_,0);
	k_sum_:=nvl(k_sum_,0);

	return;
end;
/
show err;



PROMPT ===================================================================================== 
PROMPT *** End *** ========== Scripts /Sql/BARS/Procedure/P_PR_ZG.sql =========*** End *** =
PROMPT ===================================================================================== 
