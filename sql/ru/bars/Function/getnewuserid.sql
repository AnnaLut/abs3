CREATE OR REPLACE FUNCTION BARS.GetNewUserid(p_mfo varchar2, p_userid number) RETURN number 
IS  
BEGIN
  if p_userid is null then
    return null;
  else
    if p_mfo <> mgr_utl.get_kf()
    then
        raise_application_error(-20000, 'Значение МФО задано неверно');
    end if;    
    return mgr_utl.ruuser(p_userid);
  end if;  
END;
/
