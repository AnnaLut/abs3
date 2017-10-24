

PROMPT ===================================================================================== 
PROMPT *** Run *** ========== Scripts /Sql/BARS/Procedure/NOTIFICATION.sql =========*** Run 
PROMPT ===================================================================================== 


PROMPT *** Create  procedure NOTIFICATION ***

  CREATE OR REPLACE PROCEDURE BARS.NOTIFICATION IS
  user_name  staff$base.logname%type;
begin
  for k in (select text,
                   id
            from   tmp_notification
            where  nvl(fl,0)=0)
  loop
    begin
      bms.enqueue_msg(k.text          ,
                      dbms_aq.no_delay,
                      dbms_aq.never   ,
                      k.id);
      select logname
      into   user_name
      from   staff$base
      where  id=k.id;
      bms.push_msg_web(user_name,
                       k.text);
      update tmp_notification
      set    fl=1
      where  text=k.text and
             id=k.id;
      commit;
    exception when others then
      bars_audit.error('notification error: '||sqlerrm);
    end;
  end loop;
  delete
  from   tmp_notification
  where  fl=1;
  commit;
end notification;
/
show err;



PROMPT ===================================================================================== 
PROMPT *** End *** ========== Scripts /Sql/BARS/Procedure/NOTIFICATION.sql =========*** End 
PROMPT ===================================================================================== 
