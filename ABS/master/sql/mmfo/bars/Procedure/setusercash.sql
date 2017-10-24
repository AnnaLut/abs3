

PROMPT ===================================================================================== 
PROMPT *** Run *** ========== Scripts /Sql/BARS/Procedure/SETUSERCASH.sql =========*** Run *
PROMPT ===================================================================================== 


PROMPT *** Create  procedure SETUSERCASH ***

  CREATE OR REPLACE PROCEDURE BARS.SETUSERCASH (p_nls in varchar2) is
begin
  SetUserCashEx(USER_ID,p_nls);
end;
/
show err;



PROMPT ===================================================================================== 
PROMPT *** End *** ========== Scripts /Sql/BARS/Procedure/SETUSERCASH.sql =========*** End *
PROMPT ===================================================================================== 
