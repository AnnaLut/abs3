
 
 PROMPT ===================================================================================== 
 PROMPT *** Run *** ========== Scripts /Sql/BARS/function/getglobaloption.sql =========*** Ru
 PROMPT ===================================================================================== 
 
  CREATE OR REPLACE FUNCTION BARS.GETGLOBALOPTION (Par_ varchar2) return varchar2 IS
  Val_ params.val%type;
BEGIN
  BEGIN
    SELECT val INTO Val_ FROM params WHERE upper(par)=upper(Par_) ;
  EXCEPTION WHEN NO_DATA_FOUND THEN
    Val_ := '' ;
  END;
  RETURN Val_ ;
END GetGlobalOption;
/
 show err;
 
PROMPT *** Create  grants  GETGLOBALOPTION ***
grant EXECUTE                                                                on GETGLOBALOPTION to BARS_ACCESS_DEFROLE;
grant EXECUTE                                                                on GETGLOBALOPTION to START1;
grant EXECUTE                                                                on GETGLOBALOPTION to WCS_SYNC_USER;
grant EXECUTE                                                                on GETGLOBALOPTION to WR_ALL_RIGHTS;
grant EXECUTE                                                                on GETGLOBALOPTION to WR_CREDIT;

 
 
 PROMPT ===================================================================================== 
 PROMPT *** End *** ========== Scripts /Sql/BARS/function/getglobaloption.sql =========*** En
 PROMPT ===================================================================================== 
 