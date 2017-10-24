

PROMPT ===================================================================================== 
PROMPT *** Run *** ========== Scripts /Sql/BARS/Procedure/NEXTHOLIDAYBANKDAYOPEN.sql =======
PROMPT ===================================================================================== 


PROMPT *** Create  procedure NEXTHOLIDAYBANKDAYOPEN ***

  CREATE OR REPLACE PROCEDURE BARS.NEXTHOLIDAYBANKDAYOPEN (dat_ DATE)
IS
BEGIN
   INSERT INTO fdat (fdat)
   SELECT holiday
   from holiday
   where kv=980 and
         holiday not in (select fdat
                         from fdat) and
         holiday>dat_ and
         holiday<(select min(dat_+num)
                  from conductor
                  where num<10 and dat_+num not in (SELECT holiday
                                                    from holiday
                                                    where kv=980 and
                                                          holiday>dat_));
   commit;
END;
/
show err;



PROMPT ===================================================================================== 
PROMPT *** End *** ========== Scripts /Sql/BARS/Procedure/NEXTHOLIDAYBANKDAYOPEN.sql =======
PROMPT ===================================================================================== 
