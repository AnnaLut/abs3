

PROMPT ===================================================================================== 
PROMPT *** Run *** ========== Scripts /Sql/BARS/Procedure/PUSH_MSG_VIP.sql =========*** Run 
PROMPT ===================================================================================== 


PROMPT *** Create  procedure PUSH_MSG_VIP ***

  CREATE OR REPLACE PROCEDURE BARS.PUSH_MSG_VIP 
is
l_stmt clob;
l_template clob;
begin
    begin
        select template into l_template from vip_template where rownum=1;
        exception when others then
            logger.error('Не знайдено SQL для відбору VIP клієнтів');
            return;
    end;

    l_stmt:='begin
        for k in('||l_template||')
        loop
        bms.push_msg_web(k.logname, k.message);
        end loop;

    end;';

    logger.info('push_msg_vip:'||l_stmt);
  for k in (select kf from mv_kf where kf <> '324805')
    loop
    bc.go(k.kf);
    execute immediate l_stmt;
    commit;
    end loop;
end;
/
show err;

PROMPT *** Create  grants  PUSH_MSG_VIP ***
grant EXECUTE                                                                on PUSH_MSG_VIP    to BARS_ACCESS_DEFROLE;



PROMPT ===================================================================================== 
PROMPT *** End *** ========== Scripts /Sql/BARS/Procedure/PUSH_MSG_VIP.sql =========*** End 
PROMPT ===================================================================================== 
