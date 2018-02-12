

PROMPT ===================================================================================== 
PROMPT *** Run *** ========== Scripts /Sql/BARS/Procedure/EAD_SYNC_DBO.sql =========*** Run 
PROMPT ===================================================================================== 


PROMPT *** Create  procedure EAD_SYNC_DBO ***

  CREATE OR REPLACE PROCEDURE BARS.EAD_SYNC_DBO (p_rnk in number)
is
 l_type_id  varchar2(10);
 l_sync_queue_id number;
 l_kf varchar2(6);
 l_errormessage varchar2(500);
begin
  bc.go(sys_context('bars_context','user_branch'));
  begin
  select kf
    into l_kf
    from customer
   where rnk = p_rnk;
  exception when no_data_found then l_errormessage := 'Не знайдено KF для клієнта з РНК = ' || to_char(p_rnk);  bars_audit.error(l_errormessage);
   raise_application_error ( -20001, l_errormessage, false);
   return;
  end;
  l_sync_queue_id := ead_pack.msg_create('UAGR', 'DBO;'||to_char(p_rnk), p_rnk, l_kf);
  bars_audit.info('sync_queue_id:' || to_char(l_sync_queue_id));
end;
/
show err;

PROMPT *** Create  grants  EAD_SYNC_DBO ***
grant EXECUTE                                                                on EAD_SYNC_DBO    to BARS_ACCESS_DEFROLE;



PROMPT ===================================================================================== 
PROMPT *** End *** ========== Scripts /Sql/BARS/Procedure/EAD_SYNC_DBO.sql =========*** End 
PROMPT ===================================================================================== 
