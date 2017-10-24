
 
 PROMPT ===================================================================================== 
 PROMPT *** Run *** ========== Scripts /Sql/BARS/function/f_get_date_dos.sql =========*** Run
 PROMPT ===================================================================================== 
 
  CREATE OR REPLACE FUNCTION BARS.F_GET_DATE_DOS (p_acc INTEGER)  RETURN DATE
IS

/* Версия 04-09-2015 */

fdat_  date  ;

begin
   begin
      select fdat into fdat_  from saldoa s
      where s.acc = p_acc and fdat = (select max(fdat) from saldoa where acc=s.acc and dos<>0);
   EXCEPTION WHEN NO_DATA_FOUND THEN fdat_ := NULL;
   end;
   return(fdat_);
end;
/
 show err;
 
 
 
 PROMPT ===================================================================================== 
 PROMPT *** End *** ========== Scripts /Sql/BARS/function/f_get_date_dos.sql =========*** End
 PROMPT ===================================================================================== 
 