
 
 PROMPT ===================================================================================== 
 PROMPT *** Run *** ========== Scripts /Sql/BARS/function/getnewacc.sql =========*** Run *** 
 PROMPT ===================================================================================== 
 
  CREATE OR REPLACE FUNCTION BARS.GETNEWACC (p_mfo varchar2, p_acc number) RETURN number
IS
BEGIN
  if p_acc is null then
    return null;
  else
    if p_mfo <> mgr_utl.get_kf()
    then
        raise_application_error(-20000, '�������� ��� ������ �������');
    end if;
    return mgr_utl.rukey(p_acc);
  end if;
END;
/
 show err;
 
 
 
 PROMPT ===================================================================================== 
 PROMPT *** End *** ========== Scripts /Sql/BARS/function/getnewacc.sql =========*** End *** 
 PROMPT ===================================================================================== 
 