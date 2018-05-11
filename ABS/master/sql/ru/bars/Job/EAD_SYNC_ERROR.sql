
PROMPT *** Create scheduled job EAD_SYNC_ERROR ***

begin
      dbms_scheduler.create_job(job_name            => 'BARS.EAD_SYNC_ERROR',
                                job_type            => 'PLSQL_BLOCK',
                                job_action          => '
begin
      FOR cur IN (select *
  from (SELECT sq.id,
               sq.crt_date,
               sq.type_id,
               sq.status_id,
               sq.err_count,
               sq.kf
          FROM ead_sync_queue sq
         WHERE sq.status_id =''ERROR''
           and sq.crt_date >= to_date (''09/05/2018'',''dd/mm/yyyy'') 
            and crt_date > sysdate - interval ''15'' day 
         order by id asc)
 where ROWNUM < 4000) LOOP
          ead_pack.msg_process(cur.id,''F'');
          commit work;
      end loop;
    end;',
                                start_date          => to_timestamp_tz('01-05-2018 Europe/Kiev', 'dd-mm-yyyy tzr'),
                                repeat_interval     => 'Freq=MINUTELY;Interval=5',
                                end_date            => to_date(null),
                                job_class           => 'DEFAULT_JOB_CLASS',
                                enabled             => false,
                                auto_drop           => false,
                                comments            => 'Джоб для повторной обработки ошибочных записей');

  dbms_scheduler.enable('BARS.EAD_SYNC_ERROR');
EXCEPTION
	WHEN OTHERS THEN
   if  sqlcode=-27477  then null; else raise; end if;
end;  
/
