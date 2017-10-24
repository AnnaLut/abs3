

PROMPT ===================================================================================== 
PROMPT *** Run *** ========== Scripts /Sql/BARS/Procedure/SETUSERCASHEX.sql =========*** Run
PROMPT ===================================================================================== 


PROMPT *** Create  procedure SETUSERCASHEX ***

  CREATE OR REPLACE PROCEDURE BARS.SETUSERCASHEX (p_id in number, p_nls in varchar2) is
begin
  update cash_user set nls=p_nls where id=p_id;
  if sql%rowcount=0 then
    insert into cash_user(id,nls) values(p_id,p_nls);
  end if;
end;
/
show err;



PROMPT ===================================================================================== 
PROMPT *** End *** ========== Scripts /Sql/BARS/Procedure/SETUSERCASHEX.sql =========*** End
PROMPT ===================================================================================== 
