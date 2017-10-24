

PROMPT ===================================================================================== 
PROMPT *** Run *** ========== Scripts /Sql/BARS/Procedure/MAINTAINUSERPROXY.sql =========***
PROMPT ===================================================================================== 


PROMPT *** Create  procedure MAINTAINUSERPROXY ***

  CREATE OR REPLACE PROCEDURE BARS.MAINTAINUSERPROXY (act int,uname varchar2,uproxy varchar2) is
/*
  процедура разрешает/запрещает работу пользователя uname через proxy
  act=1 - разрешить, act=0 - запретить
*/
 erm  VARCHAR2 (80);
 ern  CONSTANT POSITIVE := 001;
 err  EXCEPTION;
 cnt  int;
begin
  if act not in (0,1) then
    erm := '1 - недопустимое значение параметра act(0/1)';
    raise err;
  end if;
  select count(*) into cnt from proxy_users
  where client=uname and proxy=uproxy;
  if act=0 and cnt>0 then  -- забрать права
    execute immediate 'alter user '||uname||' revoke connect through '||uproxy;
  elsif act=1 and cnt=0 then -- выдать права
    execute immediate 'alter user '||uname||' grant connect through '||uproxy;
  end if;
exception when err then
      raise_application_error(-(20000+ern),'\'||erm,TRUE);
end;
 
/
show err;

PROMPT *** Create  grants  MAINTAINUSERPROXY ***
grant EXECUTE                                                                on MAINTAINUSERPROXY to ABS_ADMIN;
grant EXECUTE                                                                on MAINTAINUSERPROXY to BARS_ACCESS_DEFROLE;
grant EXECUTE                                                                on MAINTAINUSERPROXY to WR_ALL_RIGHTS;



PROMPT ===================================================================================== 
PROMPT *** End *** ========== Scripts /Sql/BARS/Procedure/MAINTAINUSERPROXY.sql =========***
PROMPT ===================================================================================== 
