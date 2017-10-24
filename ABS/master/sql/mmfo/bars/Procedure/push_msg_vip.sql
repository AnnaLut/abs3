CREATE OR REPLACE PROCEDURE BARS.push_msg_vip
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