

PROMPT ===================================================================================== 
PROMPT *** Run *** ========== Scripts /Sql/BARS/Procedure/P_STREAMS_HEARTBEAT.sql =========*
PROMPT ===================================================================================== 


PROMPT *** Create  procedure P_STREAMS_HEARTBEAT ***

  CREATE OR REPLACE PROCEDURE BARS.P_STREAMS_HEARTBEAT 
is
--
-- Процедура реализует "сердцебиение" для потоков синхронизации Oracle Streams
-- путем установки текущей временной метки в таблице streams_heartbeat
--
begin
    update streams_heartbeat
       set heartbeat_time = sysdate
     where global_name = (select global_name
                            from global_name
                         );
    if sql%rowcount=0
    then
        insert
          into streams_heartbeat(global_name, heartbeat_time)
        select global_name, sysdate
          from global_name;
    end if;
    --
end p_streams_heartbeat;
/
show err;



PROMPT ===================================================================================== 
PROMPT *** End *** ========== Scripts /Sql/BARS/Procedure/P_STREAMS_HEARTBEAT.sql =========*
PROMPT ===================================================================================== 
