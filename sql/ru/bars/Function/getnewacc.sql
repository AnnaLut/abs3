CREATE OR REPLACE FUNCTION BARS.GetNewACC(p_mfo varchar2, p_acc number) RETURN number 
IS
BEGIN
  if p_acc is null then
    return null;
  else
    if p_mfo <> mgr_utl.get_kf()
    then
        raise_application_error(-20000, 'Значение МФО задано неверно');
    end if;    
    return mgr_utl.rukey(p_acc);
  end if;  
END;
/
