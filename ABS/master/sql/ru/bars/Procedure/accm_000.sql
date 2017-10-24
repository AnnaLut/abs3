

PROMPT ===================================================================================== 
PROMPT *** Run *** ========== Scripts /Sql/BARS/Procedure/ACCM_000.sql =========*** Run *** 
PROMPT ===================================================================================== 


PROMPT *** Create  procedure ACCM_000 ***

  CREATE OR REPLACE PROCEDURE BARS.ACCM_000 ( p_mode int, p_Dat31 date) IS

   l_dummy number;

   l_dat01 date := p_dat31 + 1   ; --------------------------- 01.01.2010
   l_datDD date := trunc(sysdate); --------------------------- 12.03.2011
   l_datYY date := add_months(trunc(sysdate,'year'), 12) ;  -- 01.01.2012

/*  Начальная накатка снапов
    Пример.  При внедрении в 2011 году
    p_dat0 = 31-12-2009
    Храним историю оборотов, начиная с 01-01-2010
    Все начальные остатки (до этих оборотов) выносим на 31-12-2009
*/
begin

   -- Вставляем в календарь первую дату
   begin
     insert into accm_calendar(caldt_id, caldt_date) values (1, l_dat01);
   exception  when DUP_VAL_ON_INDEX then null;
   end;

   -- Создаем записи в календаре по текущую дату
   bars_accm_calendar.create_calendar( l_datDD );
   commit;

   -- Вставляем в очередь все открытые банковские дни
   for c in (select distinct fdat from saldoa where dos+kos >0 )
   loop
      bars_accm_sync.enqueue_fdat(c.fdat);
   end loop;
   commit;

   -- Обрабатываем очередь
  bars_accm_calendar.sync_calendar;
  commit;

  --Создаем секции в таблице ACCM_SNAP_BALANCES
  for c in (select caldt_id, caldt_date  from accm_calendar
            where caldt_date between l_Dat01  and l_DatYY
            order by caldt_date    )
  loop
     select count(*) into l_dummy   from user_tab_partitions
     where table_name = 'ACCM_SNAP_BALANCES'
       and partition_name = 'P' || to_char(c.caldt_id);

     if (l_dummy = 0) then
         begin
            execute immediate
             'alter table accm_snap_balances add partition p' ||
              to_char(c.caldt_id) ||
             ' values less than (' || to_char(c.caldt_id+1) || ')';
         exception  when others then
            -- ORA-14760: ADD PARTITION is not permitted on Interval partitioned objects
            if sqlcode = -14760 then   null;  else      raise;     end if;
         end;
     end if;

  end loop;

  -- Создаем секци в таблице  ACCM_AGG_MOBALS
  for c in (select caldt_id, caldt_date from accm_calendar
            where caldt_date between l_Dat01  and l_DatYY
              and caldt_date = trunc(caldt_date, 'mon')
            order by caldt_date )
  loop
     select count(*) into l_dummy  from user_tab_partitions
     where table_name = 'ACCM_AGG_MONBALS'
       and partition_name = 'P' || to_char(c.caldt_id);

     if (l_dummy = 0) then
        begin
           execute immediate
           'alter table accm_agg_monbals add partition p' ||
           to_char(c.caldt_id) ||
           ' values less than (' || to_char(c.caldt_id+1) || ')';
        exception  when others then
           -- ORA-14760: ADD PARTITION is not permitted on Interval partitioned objects
           if sqlcode = -14760 then   null;  else      raise;     end if;
        end;
     end if;

  end loop;

  --  Создаем секции в таблице ACCM_LIST_CORRDOCS
  for c in (select caldt_id, caldt_date  from accm_calendar
            where caldt_date between l_Dat01  and l_DatYY
            order by caldt_date )
  loop
     select count(*) into l_dummy from user_tab_partitions
     where table_name = 'ACCM_LIST_CORRDOCS'
       and partition_name = 'P' || to_char(c.caldt_id);

     if (l_dummy = 0) then
        begin
           execute immediate
           'alter table accm_list_corrdocs add partition p' ||
           to_char(c.caldt_id) ||
           ' values less than (' || to_char(c.caldt_id+1) || ')';
        exception  when others then
           -- ORA-14760: ADD PARTITION is not permitted on Interval partitioned objects
           if sqlcode = -14760 then   null;  else      raise;     end if;
        end;
     end if;

  end loop;

  -- Накапливаем дневные снимки
  for c in (select caldt_date  from accm_calendar
             where caldt_date >= l_Dat01
               and caldt_date <= l_datDD
               and caldt_date = bankdt_date
            order by  caldt_date )
  loop
     dbms_application_info.set_client_info('ACCM_SNAP_BALANCE: ' ||
          to_char(c.caldt_date, 'dd.mm.yyyy'));
     tuda;
     begin
        bars_accm_sync.sync_snap('BALANCE', c.caldt_date, 0);
        commit;
     exception  when others then
        -- ORA-00001: unique constraint (BARS.PK_ACCMSNAPBALS) violated
        if sqlcode = -00001 then   null;  else      raise;     end if;
     end;
  end loop;
  dbms_application_info.set_client_info('');

/*
  -- Накапливаем очередь корректирующих документов
  -- Начальное накопление корректирующих документов  (после установки триггера)
  for c in (select ref from oper where vob in (96,99) and vdat >= p_Dat0 )
  loop
     bars_accm_sync.enqueue_corrdoc(c.ref);
  end loop;
  commit;

  -- Накапливаем корректирующие проводки
  bars_accm_list.add_corrdocs;
  commit;
*/

  -- Создаем агрегаты месячных оборотов
  for k in (select caldt_date  from accm_calendar
             where caldt_date >= l_Dat01
               and caldt_date <= l_datDD
               and to_char(caldt_date,'dd') ='01'
             order by  caldt_date )
  loop

/* Типы синхронизации
   SYNCMODE_FULL        constant t_accmsyncmode := 0; -- полная,
   SYNCMODE_INCR        constant t_accmsyncmode := 1; -- ДоСинхронизация (из очереди)
procedure sync_agg(
                  p_objname  in  t_accmobjname,
                  p_aggdate  in  t_accmsnapdate,
                  p_aggmode  in  t_accmsyncmode default SYNCMODE_INCR);
*/
    bars_accm_sync.sync_agg('MONBAL', k.caldt_date, 0);

    commit;
  end loop;
  suda;

end accm_000;
/
show err;



PROMPT ===================================================================================== 
PROMPT *** End *** ========== Scripts /Sql/BARS/Procedure/ACCM_000.sql =========*** End *** 
PROMPT ===================================================================================== 
