

PROMPT ===================================================================================== 
PROMPT *** Run *** ========== Scripts /Sql/BARS/Procedure/EAD_TYPE_PROCESS.sql =========*** 
PROMPT ===================================================================================== 


PROMPT *** Create  procedure EAD_TYPE_PROCESS ***

  CREATE OR REPLACE PROCEDURE BARS.EAD_TYPE_PROCESS ( p_type_id IN ead_types.id%TYPE, p_kf in ead_sync_queue.kf%type )
IS
  l_t_row   bars.ead_types%ROWTYPE;
  l_s_row   bars.ead_sync_sessions%ROWTYPE;
  l_rows    NUMBER;    --ограничение кол-ва строк обработки за один запуск
  l_status_id bars.ead_sync_queue.status_id%type;
BEGIN
  --sec_aud_temp_write ('EAD: type_process');

  -- параметры
  SELECT * INTO l_t_row FROM bars.ead_types t WHERE t.id = p_type_id;
  BEGIN
    SELECT * INTO l_s_row FROM bars.ead_sync_sessions s  WHERE s.type_id = p_type_id;
  EXCEPTION 
    WHEN NO_DATA_FOUND THEN bars.bars_audit.info ( 'type_process: не найдено ключа=' || p_type_id );  
  END;
  -- дата/время старта
  l_s_row.sync_start := SYSDATE;
  --кол-во строк за один пробег
  BEGIN
   SELECT NVL (val, 1000) INTO l_rows FROM bars.PARAMS$GLOBAL WHERE par = 'EAD_ROWS';
  EXCEPTION 
    WHEN NO_DATA_FOUND THEN l_rows := 1000; 
  END;

  -- обработка каждого запроса по отдельности
  FOR cur IN ( select y.* from 
               ( SELECT sq.id, sq.crt_date, sq.type_id, sq.status_id, sq.err_count, sq.kf, 
                        sq.crt_date+l_t_row.msg_retry_interval*nvl(sq.err_count, 0)*(nvl(sq.err_count, 0)+1)/(2*60*24) as trans_date --дата|час повторної передачі, зростає у арифметичній прогресії
                   FROM bars.ead_sync_queue sq
                  WHERE sq.type_id = p_type_id AND sq.status_id IN ('NEW', 'ERROR') AND nvl(sq.err_count, 0) < 30
                        -- and regexp_like(sq.err_text, 'rnk \d+ not found', 'i')
                        and sq.kf=p_kf AND sq.crt_date > ADD_MONTHS(SYSDATE,  -2)
                  order by status_id desc, trans_date asc, id asc ) y                  
                where ROWNUM < NVL (l_rows, 1000) and y.trans_date<=l_s_row.sync_start  )
  LOOP
   select status_id into l_status_id FROM bars.ead_sync_queue where id=cur.id;
   IF l_status_id in ('NEW', 'ERROR') 
    THEN
       bars.ead_pack.msg_process (cur.id, cur.kf); COMMIT;
    END IF;     
  END LOOP;

  -- дата/время финиша
  l_s_row.sync_end := SYSDATE;

  -- сохраняем
  UPDATE bars.ead_sync_sessions s SET s.sync_start = l_s_row.sync_start, s.sync_end = l_s_row.sync_end  WHERE s.type_id = p_type_id; COMMIT;

END ead_type_process;
/
show err;



PROMPT ===================================================================================== 
PROMPT *** End *** ========== Scripts /Sql/BARS/Procedure/EAD_TYPE_PROCESS.sql =========*** 
PROMPT ===================================================================================== 
