
 
 PROMPT ===================================================================================== 
 PROMPT *** Run *** ========== Scripts /Sql/BARS/function/get_dat_first_turn.sql =========***
 PROMPT ===================================================================================== 
 
  CREATE OR REPLACE FUNCTION BARS.GET_DAT_FIRST_TURN (p_acc number)
return date
is
 p_dat date;
begin
  begin
    select min(fdat)
      into p_dat
      from saldoa
     where acc = p_acc
       and (dos<>0 or kos<>0);
  EXCEPTION WHEN NO_DATA_FOUND THEN p_dat := null;
  end;
return p_dat;
end;
/
 show err;
 
PROMPT *** Create  grants  GET_DAT_FIRST_TURN ***
grant EXECUTE                                                                on GET_DAT_FIRST_TURN to BARS_DM;

 
 
 PROMPT ===================================================================================== 
 PROMPT *** End *** ========== Scripts /Sql/BARS/function/get_dat_first_turn.sql =========***
 PROMPT ===================================================================================== 
 