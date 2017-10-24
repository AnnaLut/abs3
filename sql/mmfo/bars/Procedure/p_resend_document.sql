

PROMPT ===================================================================================== 
PROMPT *** Run *** ========== Scripts /Sql/BARS/Procedure/P_RESEND_DOCUMENT.sql =========***
PROMPT ===================================================================================== 


PROMPT *** Create  procedure P_RESEND_DOCUMENT ***

  CREATE OR REPLACE PROCEDURE BARS.P_RESEND_DOCUMENT (p_ref in number) is
begin
  bc.go(300465);
  delete from bars.sos_track where ref=p_ref and old_sos=1 and new_sos=5;
  insert into bars.sos_track(ref, old_sos, new_sos, userid, sos_tracker, change_time) values (p_ref, 1, 5, 2009401, 3, sysdate);
  commit;
end;
/
show err;



PROMPT ===================================================================================== 
PROMPT *** End *** ========== Scripts /Sql/BARS/Procedure/P_RESEND_DOCUMENT.sql =========***
PROMPT ===================================================================================== 
