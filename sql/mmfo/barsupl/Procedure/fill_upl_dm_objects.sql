PROMPT ===================================================================================== 
PROMPT *** Run *** ===== Scripts /Sql/BARSUPL/Procedure/fill_upl_dm_objects.sql =====*** Run 
PROMPT ===================================================================================== 

create or replace procedure barsupl.fill_upl_dm_objects (p_bank_date in date default null, p_clear_data in varchar2 default 'N')
as
/* ѕроцедура наполнени€ временной витрины выгружаемых объектов
   ¬итрина наполн€етс€ один раз дл€ сессии выгрузки и используетс€ до коца процесса
   ѕри выгрузке первого файла в сесии необходимо безусловно очистить витрину.
   ¬ витрину попадают только открытые на p_bank_date договора либо закрытые в эту дату

   ѕримеры: 
      -- очистить и заполнить заново
         barsupl.fill_upl_dm_objects (p_bank_date => to_date('01/01/2019', 'dd/mm/yyyy'), p_clear_data = 'Y')
      -- только очистить
         barsupl.fill_upl_dm_objects (p_bank_date => null, p_clear_data = 'Y')
      -- если витрина пуста€ - заполнить, если заполнена€ - ничего не далаем
         barsupl.fill_upl_dm_objects (p_bank_date => to_date('01/01/2019', 'dd/mm/yyyy'), p_clear_data = 'N')
      -- запустить просто чтобы ничего не делать :-)
         barsupl.fill_upl_dm_objects (p_bank_date => null, p_clear_data = 'N')
*/

  l_dm_code       barsupl.tmp_upl_dm_status.dm_code%type := 'UPL_DM_OBJECTS';
  l_dm_is_filled  number := 0;
  l_rows_cnt      number := 0;
  e_dm_is_filled  exception;
begin
  -- дл€ первого файла выполн€ть очистку данных и статуса витрины
  if p_clear_data = 'Y' then
     --delete from barsupl.tmp_upl_dm_objects;
     execute immediate 'truncate table barsupl.tmp_upl_dm_objects';
     delete from barsupl.tmp_upl_dm_status where dm_code = l_dm_code;
  end if;

  -- только очистка витрины
  if p_bank_date is null then
     raise e_dm_is_filled;
  end if;

  -- дл€ всех последующих провер€ть заполненность витрины
  -- и заполн€ть при необходимости
  select count(*)
    into l_dm_is_filled
    from barsupl.tmp_upl_dm_status
   where dm_code = l_dm_code
     and bank_date = p_bank_date
     and decode(kf, bars.gl.kf, 1, 0) = 1;

  -- если витрина заполнена - уходим
  if l_dm_is_filled > 0 then
     raise e_dm_is_filled;
  end if;

  insert /*+ append */
    into barsupl.tmp_upl_dm_objects
        (type_id, type, object_id, kf, type_code, state_id, deal_number, customer_id, product_id, start_date, expiry_date, close_date, branch_id, curator_id)
  with  dt as ( select /*+ materialize */ bars.gl.kf from dual )
  select ol.type_id,
         o.object_type_id as type,
         o.id  as object_id,
         coalesce(dt.kf, SUBSTR(d.branch_id, 2,6)) as kf,
         ol.type_code,
         o.state_id,
         d.deal_number,
         d.customer_id,
         d.product_id,
         d.start_date,
         d.expiry_date,
         d.close_date,
         d.branch_id,
         d.curator_id
    from dt,
         bars.object_type ot
    join barsupl.upl_object_lists ol on (ol.type_code = ot.type_code)
    join bars.object o on (o.object_type_id = ot.id)
    join bars.deal d   on (d.id = o.id)
   where (dt.kf = SUBSTR(d.branch_id, 2,6) or dt.kf is null)
     and lnnvl(d.close_date < p_bank_date) --(d.close_date is null or d.close_date >= p_bank_date)
     and d.start_date <= p_bank_date;

  l_rows_cnt := sql%rowcount;

  insert into barsupl.tmp_upl_dm_status (dm_code, kf, rows_cnt, bank_date, fill_date, sid)
  values (l_dm_code, bars.gl.kf, l_rows_cnt, p_bank_date, sysdate(), sys_context('USERENV','SESSIONID'));

  commit;

  dbms_stats.gather_table_stats(ownname     => 'BARSUPL',
                                tabname     => 'TMP_UPL_DM_OBJECTS',
                                cascade     => TRUE);

exception
  when e_dm_is_filled then null;
  when others then raise;
end;
/

PROMPT ===================================================================================== 
PROMPT *** End *** ===== Scripts /Sql/BARSUPL/Procedure/fill_upl_dm_objects.sql =====*** End 
PROMPT ===================================================================================== 
