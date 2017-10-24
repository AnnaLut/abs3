
 
 PROMPT ===================================================================================== 
 PROMPT *** Run *** ========== Scripts /Sql/BARS/function/f_getlastoperday.sql =========*** R
 PROMPT ===================================================================================== 
 
  CREATE OR REPLACE FUNCTION BARS.F_GETLASTOPERDAY return date is
  res date;
begin
    res := current_date;
    BEGIN
        SELECT FDAT INTO res FROM (
            SELECT FDAT, RANK() OVER (ORDER BY FDAT DESC) NPP FROM FDAT
        ) WHERE NPP <= 1;
        EXCEPTION WHEN NO_DATA_FOUND THEN RETURN current_date;
    END;
    RETURN RES;    
end f_GetLastOperDay; 
/
 show err;
 
PROMPT *** Create  grants  F_GETLASTOPERDAY ***
grant EXECUTE                                                                on F_GETLASTOPERDAY to WR_ALL_RIGHTS;

 
 
 PROMPT ===================================================================================== 
 PROMPT *** End *** ========== Scripts /Sql/BARS/function/f_getlastoperday.sql =========*** E
 PROMPT ===================================================================================== 
 