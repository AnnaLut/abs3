CREATE OR REPLACE procedure BARS.ead_sync_dbo (p_rnk in number)
is
 l_type_id  varchar2(10);
 l_sync_queue_id number;
begin
   bc.go(sys_context('bars_context','user_branch'));
 
  l_sync_queue_id := ead_pack.msg_create('UAGR', 'DBO;'||to_char(p_rnk), p_rnk);

  bars_audit.info('sync_queue_id:' || to_char(l_sync_queue_id));
 

end;
/

Show errors;
/

grant execute on ead_sync_dbo to bars_access_defrole;
/