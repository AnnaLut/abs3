CREATE OR REPLACE FUNCTION BARS.GetNewRNK(p_mfo varchar2, p_rnk number) RETURN number 
IS
BEGIN
  if p_rnk is null then
    return null;
  else
    if p_mfo <> mgr_utl.get_kf()
    then
        raise_application_error(-20000, 'Значение МФО задано неверно');
    end if;    
    return mgr_utl.rukey(p_rnk);
  end if;  
END;
/