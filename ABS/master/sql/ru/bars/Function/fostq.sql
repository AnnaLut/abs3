
 
 PROMPT ===================================================================================== 
 PROMPT *** Run *** ========== Scripts /Sql/BARS/function/fostq.sql =========*** Run *** ====
 PROMPT ===================================================================================== 
 
  CREATE OR REPLACE FUNCTION BARS.FOSTQ (acc_ INTEGER, fdat_ DATE) RETURN DECIMAL IS
   nn_     DECIMAL;
   kv_     accounts.kv%type;
   daos_   date;
   dazs_   date;
BEGIN
 BEGIN

  select ostq into nn_ from snap_balances where acc=acc_ and fdat=fdat_;

 EXCEPTION WHEN NO_DATA_FOUND
    THEN

	select  kv, daos, dazs into kv_ , daos_, dazs_
	  from accounts
	 where acc =  acc_;

	if fdat_ between daos_ and nvl(dazs_, to_date('01-01-4000','dd-mm-yyyy')) then

			 SELECT s.ostf-s.dos+s.kos INTO nn_ from saldoa s
			  WHERE s.acc=ACC_
				AND (s.acc,s.FDAT) =
					(select acc,max(fdat) from saldoa
					 where acc=ACC_ and fdat between daos_ and FDAT_ group by acc)
				and fdat between daos_ and FDAT_			 ;

					if 	(kv_ = 980 or nn_ = 0)
					              then nn_ :=  nn_;
								  else nn_ := gl.p_icurval(kv_, nn_,  fdat_);
					end if;

		else nn_ := 0;
	end if;

 END;

 return nn_;

END FOSTQ;
/
 show err;
 
PROMPT *** Create  grants  FOSTQ ***
grant EXECUTE                                                                on FOSTQ           to ABS_ADMIN;
grant EXECUTE                                                                on FOSTQ           to BARSUPL;
grant EXECUTE                                                                on FOSTQ           to BARS_ACCESS_DEFROLE;
grant EXECUTE                                                                on FOSTQ           to BARS_SUP;
grant EXECUTE                                                                on FOSTQ           to RPBN001;
grant EXECUTE                                                                on FOSTQ           to RPBN002;
grant EXECUTE                                                                on FOSTQ           to UPLD;
grant EXECUTE                                                                on FOSTQ           to WR_ALL_RIGHTS;

 
 
 PROMPT ===================================================================================== 
 PROMPT *** End *** ========== Scripts /Sql/BARS/function/fostq.sql =========*** End *** ====
 PROMPT ===================================================================================== 
 