

PROMPT ===================================================================================== 
PROMPT *** Run *** ========== Scripts /Sql/BARS/Procedure/PREVHOLIDAYBANKDAYCLOSE.sql ======
PROMPT ===================================================================================== 


PROMPT *** Create  procedure PREVHOLIDAYBANKDAYCLOSE ***

  CREATE OR REPLACE PROCEDURE BARS.PREVHOLIDAYBANKDAYCLOSE (dat_ DATE)
IS
BEGIN
   UPDATE fdat
   SET stat=9
   WHERE (stat<>9 or stat is null) and
         fdat in (SELECT holiday
                  from holiday
                  where kv=980 and
                        holiday<bankdate and
                        holiday>bankdate-10);
commit;
END;
/
show err;



PROMPT ===================================================================================== 
PROMPT *** End *** ========== Scripts /Sql/BARS/Procedure/PREVHOLIDAYBANKDAYCLOSE.sql ======
PROMPT ===================================================================================== 
