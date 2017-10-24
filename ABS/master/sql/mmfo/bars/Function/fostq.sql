
 
 PROMPT ===================================================================================== 
 PROMPT *** Run *** ========== Scripts /Sql/BARS/function/fostq.sql =========*** Run *** ====
 PROMPT ===================================================================================== 
 
  CREATE OR REPLACE FUNCTION BARS.FOSTQ (acc_ INTEGER, fdat_ DATE) RETURN DECIMAL IS
   nn_     DECIMAL;
   kv_     accounts.kv%type;
   daos_   date;
   dazs_   date;
-- 24/12/2016 Serednii Serhii
--      - врахував ситуацію, коли при реанімації рахунку DAOS:=дата_реанімації
--          а остання згадка про рахунок у SALDOA - до нового DAOS
--      - збільшив інформативність повідомлення при помилці NO_DATA_FOUND при вибірці із SALDOA
BEGIN
 BEGIN

  select ostq into nn_ from snap_balances where acc=acc_ and fdat=fdat_;

 EXCEPTION WHEN NO_DATA_FOUND
    THEN

    select  kv, daos, dazs into kv_ , daos_, dazs_
      from accounts
     where acc =  acc_;

    if fdat_ between daos_ and nvl(dazs_, to_date('01-01-4000','dd-mm-yyyy')) then

        begin
            SELECT s.ostf-s.dos+s.kos INTO nn_
                from saldoa s
                WHERE s.acc=ACC_
                    AND (s.acc,s.FDAT) =
                        (select acc,max(fdat) from saldoa
                         where acc=ACC_ and fdat between daos_ and FDAT_ group by acc)
                    and fdat between daos_ and FDAT_;
        exception
            when no_data_found then
                begin
                    SELECT s.ostf-s.dos+s.kos INTO nn_
                        from saldoa s
                        WHERE s.acc=ACC_
                            AND (s.acc,s.FDAT) =
                                (select acc,max(fdat) from saldoa
                                 where acc=ACC_ and fdat <= FDAT_ group by acc);
                exception
                    when no_data_found then
                        null;
						--raise_application_error(-20000,'(no_data_found) - ACC_='||to_char(acc_)
                        --    ||', FDAT_='||to_char(fdat_,'dd/mm/yyyy')||', daos_='||to_char(daos_,'dd/mm/yyyy'));
                    when others then raise;
                end;
            when others then raise;
        end;

    nn_ := gl.p_icurval(kv_, nn_,  fdat_);
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
grant EXECUTE                                                                on FOSTQ           to RPBN001;
grant EXECUTE                                                                on FOSTQ           to RPBN002;
grant EXECUTE                                                                on FOSTQ           to UPLD;
grant EXECUTE                                                                on FOSTQ           to WR_ALL_RIGHTS;

 
 
 PROMPT ===================================================================================== 
 PROMPT *** End *** ========== Scripts /Sql/BARS/function/fostq.sql =========*** End *** ====
 PROMPT ===================================================================================== 
 