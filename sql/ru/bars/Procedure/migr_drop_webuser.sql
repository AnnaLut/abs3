

PROMPT ===================================================================================== 
PROMPT *** Run *** ========== Scripts /Sql/BARS/Procedure/MIGR_DROP_WEBUSER.sql =========***
PROMPT ===================================================================================== 


PROMPT *** Create  procedure MIGR_DROP_WEBUSER ***

  CREATE OR REPLACE PROCEDURE BARS.MIGR_DROP_WEBUSER (
    l_userid      in  number)  /* id пользователя*/
is
begin
    BARS_USERADM.DROP_USER(l_userid);
    delete from web_usermap where dbuser = (select UPPER(logname) from staff$base where id=l_userid);
    delete from staff$base where id=l_userid;
end; 
/
show err;

PROMPT *** Create  grants  MIGR_DROP_WEBUSER ***
grant EXECUTE                                                                on MIGR_DROP_WEBUSER to WR_ALL_RIGHTS;



PROMPT ===================================================================================== 
PROMPT *** End *** ========== Scripts /Sql/BARS/Procedure/MIGR_DROP_WEBUSER.sql =========***
PROMPT ===================================================================================== 
