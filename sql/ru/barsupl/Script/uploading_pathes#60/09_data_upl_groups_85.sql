-- ***************************************************************************
set verify off
--set define on
-- sgroup_id идентификаторы группы выгрузки
-- sautojob  идентификаторы автоджоба
-- sjobdesc  описание автоджоба
-- параметры автоджоба берутся из ежедневной выгрузки "DAILY_UPLOAD"
--define sgroup_id = 85
--define sautojob  = 'UPDATE_TABLE_CHECK'
--define sjobdesc  = 'Перевірка корректності данних історичних таблиць'
begin
   dbms_output.put_line(to_char(sysdate(), 'dd.mm.yyyy hh24:mi:ss') ||': Process for GROUP_ID: 85');
   dbms_output.put_line(':   GROUP # UPDATE_TABLE_CHECK  Перевірка корректності данних історичних таблиць');
end;
/
-- ***************************************************************************
-- ETL-21571  ANL - ТРИГГЕРА
-- ETL-23209  UPL - создать новые группы для возможности проверки и синхронизации данных в update-таблицах
-- ***************************************************************************

-- ***********************
-- UPL_GROUPS, UPL_AUTOJOBS, UPL_AUTOJOB_PARAM_VALUES
-- ***********************
declare
  l_job_name        varchar(30);
  l_group_id        varchar(10);
  l_job_desc        varchar(200);
  l_region_prefix   varchar2(3);
  l_is_mmfo         number;
  l_sql             varchar2(500);
begin
  l_job_desc := 'Перевірка корректності данних історичних таблиць';
  l_group_id := 85;

  --UPL_GROUPS
  delete from barsupl.upl_groups WHERE group_id = l_group_id;
  insert into barsupl.upl_groups(group_id, descript)    values(l_group_id,'Перевірка корректності данних історичних таблиць');

  for l_kf in (select kf from bars.mv_kf)
  loop
      dbms_output.put_line(to_char(sysdate(), 'dd.mm.yyyy hh24:mi:ss') ||': Process for UPL_GROUPS.GROUP_ID: 85');
      bars.bc.go(l_kf.kf);
      bars_upload.init_params(p_force => 1);
      l_is_mmfo  := barsupl.bars_upload_utl.is_mmfo;

      l_region_prefix := barsupl.bars_upload.get_param('REGION_PRFX');
      l_job_name := 'UPDATE_TABLE_CHECK';
      if l_is_mmfo > 1 then l_job_name := l_job_name || '_' || l_region_prefix; end if;
      dbms_output.put_line( 'REGION_CODE=' || l_region_prefix || ';  JOB_NAME=' || l_job_name );

      --UPL_AUTOJOBS
      if l_is_mmfo > 1 then
         l_sql := 'delete from upl_autojobs where job_name = ''' || l_job_name || ''' and kf = ''' || l_kf.kf || '''';
      else
         l_sql := 'delete from upl_autojobs where job_name = ''' || l_job_name || '''';
      end if;
      --dbms_output.put_line( 'l_sql=' || l_sql );
      execute immediate l_sql;

      if l_is_mmfo > 1 then
         l_sql := 'insert into upl_autojobs(job_name, descript, is_active, kf ) values(''' || l_job_name || ''', ''' || l_job_desc || ''', 1, ''' || l_kf.kf || ''')';
      else
         l_sql := 'insert into upl_autojobs(job_name, descript, is_active ) values(''' || l_job_name || ''', ''' || l_job_desc || ''', 1 )';
      end if;
      --dbms_output.put_line( 'l_sql=' || l_sql );
      execute immediate l_sql;

      --UPL_AUTOJOB_PARAM_VALUES
      -- настройки берутся из выгрузки DAILY_UPLOAD
      if l_is_mmfo > 1 then
         l_sql := 'delete from upl_autojob_param_values where job_name = ''' || l_job_name || ''' and kf = ''' || l_kf.kf || '''';
      else
         l_sql := 'delete from upl_autojob_param_values where job_name = ''' || l_job_name || '''';
      end if;
      --dbms_output.put_line( 'l_sql=' || l_sql );
      execute immediate l_sql;

      if l_is_mmfo > 1 then
         l_sql := '
      insert into upl_autojob_param_values (job_name, param, value, kf)
      select ''' || l_job_name || ''' as job_name, param,
             case when upper(param) = ''GROUPID'' then ''' || l_group_id || '''
                  when upper(param) = ''WHEN_DAYLIST'' then null
                  else value
             end as value,
             ''' || l_kf.kf || ''' as kf
        from upl_autojob_param_values
       where job_name = ''DAILY_UPLOAD_' || l_region_prefix || ''' and kf = ''' || l_kf.kf || '''';
      else
         l_sql := '
      insert into upl_autojob_param_values (job_name, param, value)
      select ''' || l_job_name || ''' as job_name, param,
             case when upper(param) = ''GROUPID'' then ''' || l_group_id || '''
                  when upper(param) = ''WHEN_DAYLIST'' then null
                  else value
             end as value
        from upl_autojob_param_values
       where job_name = ''DAILY_UPLOAD''';
      end if;
      --dbms_output.put_line( 'l_sql=' || l_sql );
      execute immediate l_sql;

      --создать задания на выгрузку
      --bars_upload_usr.recreate_interface_job(l_job_name);
      --bars_upload_usr.disable_interface_job(l_job_name);

  end loop;

exception
  when OTHERS then
    ROLLBACK;
    RAISE;
end;
/

select * from barsupl.upl_groups WHERE group_id = 85;

select * from barsupl.upl_autojobs WHERE job_name like 'UPDATE_TABLE_CHECK%' order by job_name;

select * from barsupl.upl_autojob_param_values WHERE job_name like 'UPDATE_TABLE_CHECK%' order by job_name;



