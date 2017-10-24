

PROMPT ===================================================================================== 
PROMPT *** Run *** ========== Scripts /Sql/BARS/Procedure/LOCK_USER_ENTRANCE.sql =========**
PROMPT ===================================================================================== 


PROMPT *** Create  procedure LOCK_USER_ENTRANCE ***

  CREATE OR REPLACE PROCEDURE BARS.LOCK_USER_ENTRANCE (
                                p_msg in varchar2 )
as
begin
  update staff set bax=0 where id = user_id;
  bars_audit.error('Користувач  заблокований на прох_дн_й. Причина: '||p_msg);
end;
 
/
show err;

PROMPT *** Create  grants  LOCK_USER_ENTRANCE ***
grant EXECUTE                                                                on LOCK_USER_ENTRANCE to BARS_ACCESS_DEFROLE;
grant EXECUTE                                                                on LOCK_USER_ENTRANCE to TOSS;
grant EXECUTE                                                                on LOCK_USER_ENTRANCE to WR_ALL_RIGHTS;



PROMPT ===================================================================================== 
PROMPT *** End *** ========== Scripts /Sql/BARS/Procedure/LOCK_USER_ENTRANCE.sql =========**
PROMPT ===================================================================================== 
