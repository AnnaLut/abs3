create or replace package EBK_DUP_WFORM_UTL 
is

  --
  -- constants
  --

  g_header_version  constant varchar2(64)  := 'version 1.03  2016.09.21';

  --
  -- function
  --

  function get_db_value
  ( p_rnk         in     number
  , p_attr_name   in     varchar2
  , p_attr_type   in     varchar2
  ) return varchar2;

  function get_group_id
  ( p_rnk         in     number
  , p_kf          in     varchar2
  ) return number;

  function get_last_modifc_date
  ( p_rnk  in     number
  ) return date;

  --
  -- functions
  --

  procedure create_group_duplicate;

  procedure change_master_card
  ( p_m_rnk       in     number
  , p_new_m_rnk   in     number
  );

  procedure ignore_card
  ( p_m_rnk       in     number
  , p_d_rnk       in     number
  );

  procedure merge_2rnk
  ( p_rnkfrom     in     number
  , p_rnkto       in     number
  );

  procedure change_cust_attr
  ( p_rnk         in     number,
    p_attr_name   in     varchar2,
    p_new_val     in     varchar2
  );

end EBK_DUP_WFORM_UTL;
/

show errors;

CREATE OR REPLACE PACKAGE BODY EBK_DUP_WFORM_UTL
is

  --
  -- constants
  --
  g_body_version  constant varchar2(64)  := 'version 1.04  2017.03.14';

  function get_db_value(p_rnk in number,p_attr_name in varchar2, p_attr_type in varchar2)  return varchar2
  is
   l_ret_val varchar2(500);
  begin
    execute immediate 'select case :p_attr_type
                              when ''Date'' then to_char( '||p_attr_name||',''dd.mm.yyyy'')
                              else  to_char('||p_attr_name||') end  from ebk_cust_bd_info_v  where rnk = :p_rnk'
     into l_ret_val using p_attr_type, p_rnk;
    return l_ret_val;
   exception
    when others then
      return null;
  end get_db_value;

function get_group_id(p_rnk in number,
                      p_kf in varchar2) return number is
 -- p_kf is dummy parameter
 l_group_id number;
 l_tmp      number;
begin

  select
    case when exists (select 1 from w4_acc w, accounts a  where w.acc_pk = a.acc and a.dazs is null  and a.rnk = p_rnk) then 1
        else
            case when exists (select 1 from cc_deal cc where cc.rnk = p_rnk  and cc.sos not in (0,2,14,15))             then 2
            else
                case when exists (select 1 from dpt_deposit dd where dd.rnk = p_rnk)                                    then 3
                else
                    case when exists (select 1 from accounts ac where ac.rnk = p_rnk and ac.dazs is null and nbs='2620') then 4
                     else 5
                    end
                end
            end
        end as group_id
    into l_group_id
    from dual;

 return l_group_id;
end get_group_id;

function get_last_modifc_date(p_rnk in number) return date is
begin
 for x in ( select greatest (
                                ( select trunc (max(cu.chgdate))
                                    from customer_update cu
                                   where rnk = p_rnk),
                                ( select trunc ( max(cwu.chgdate) )
                                    from customerw_update cwu
                                   where rnk = p_rnk),
                                ( select trunc (max(pu.chgdate))
                                    from person_update pu
                                   where rnk = p_rnk)) as last_modifc_date from dual)
  loop
    return x.last_modifc_date;
  end loop;

end get_last_modifc_date;

/*процедура по созданию групп дубликатов включена в график работ БД*/
procedure create_group_duplicate
is
  l_trace  varchar2(64) := $$PLSQL_UNIT||'.CREATE_GROUP_DUPLICATE';
  l_kf     varchar2(6);
  l_cycle  integer;
  l_lock   VARCHAR2(30);
  l_status NUMBER;
  ---
  procedure create_group_duplicate_kf
  is
  begin
    bars_audit.info(l_trace||': Entry with KF='||l_kf);
    -- устанавливаем основную карточку
    -- выбор по правилу наивыcшего - продукт,дата последней модификации, качество картки клиента
    for r in ( select distinct rnk
                 from tmp_ebk_dup_client
                where kf = l_kf
                   or kf = dup_kf
                order by rnk)
    loop

      dbms_application_info.set_client_info(l_trace|| ' set MC for rnk=' || r.rnk);

      for x in ( select rnk, dup_rnk,  product_id, last_modifc_date, quality
                      , row_number() over (partition by rnk order by product_id asc, last_modifc_date desc nulls last ,quality desc)  as master_queue
                   from ( select d.rnk, d.dup_rnk
                                    , get_group_id(d.dup_rnk, l_kf)  as product_id
                                    , get_last_modifc_date(d.dup_rnk) as  last_modifc_date
                                    , nvl((select max(quality) from ebk_qualityattr_gourps where kf = l_kf and  rnk = d.dup_rnk  and name  = 'card' ),0 )as quality
                             from ( select distinct kf, rnk, dup_rnk
                                      from tmp_ebk_dup_client
                                     where rnk = r.rnk
                                       and kf = l_kf
                                     union
                                    select distinct kf, rnk, rnk as dup_rnk
                                      from tmp_ebk_dup_client
                                     where rnk = r.rnk
                                       and kf = l_kf
                                  ) d
                           )
                  )
        loop

          bars_audit.trace(l_trace||': set master card for rnk = %s, dup_rnk = %s, last_modifc_date=%s, quality=%s, master_card=%s',
                             to_char(x.rnk), to_char(x.dup_rnk), to_char(x.last_modifc_date), to_char(x.quality), to_char(x.master_queue));
          if x.master_queue = 1
          then -- это наша основная карточка
             update tmp_ebk_dup_client
                set rnk = x.dup_rnk
              where rnk = x.rnk;

             update tmp_ebk_dup_client
                set dup_rnk = x.rnk
              where rnk = x.dup_rnk and dup_rnk = x.dup_rnk;
          end if;
        end loop;
    end loop;

    bars_audit.info(l_trace||': Exit.');

  end create_group_duplicate_kf;
  ---
begin

  bars_audit.info(l_trace||': Start');

  l_kf := sys_context('bars_context','user_mfo');

  -- только один процесс может быть запущен
  dbms_lock.allocate_unique('DuplicateGroups', l_lock);
  l_status := dbms_lock.request(l_lock, dbms_lock.x_mode,180,true);

  bars_audit.trace( l_trace||': dbms_lock status for DuplicateGroups = %s', to_char(l_status) );

  if l_status = 0
  THEN
    -- блокируем таблицу с загруженными дубликатами на время создания групп
    -- после создания групп очищаем от данных участвующие в создании групп и освобождаем таблицу
    lock table tmp_ebk_dup_client in exclusive mode;

    if ( l_kf Is Null )
    then
      for i in ( select KF
                 from BARS.MV_KF )
      loop
        l_kf := i.KF;
        create_group_duplicate_kf;
      end loop;
    else
      create_group_duplicate_kf;
    end if;

    -- заполняем группами дедубликаций
    insert
      into EBK_DUPLICATE_GROUPS
         ( M_RNK, D_RNK, KF )
    select distinct RNK, DUP_RNK, KF
      from TMP_EBK_DUP_CLIENT
     where rnk <> dup_rnk
       and not exists ( select null
                          from EBK_DUPLICATE_GROUPS
                         where m_rnk = rnk
                           and d_rnk = dup_rnk );

    --очищаем от обработанных
    delete from tmp_ebk_dup_client;

    --очищаем от закрытых дочерних
    delete from ebk_duplicate_groups e
     where exists ( select null from customer where rnk = e.d_rnk and date_off is not null);

   commit; --фиксация, освобождение  tmp_ebk_dup_client от блокировки
 end if;
 l_status := dbms_lock.release(l_lock);
 bars_audit.info( l_trace||': finished');
 exception
   when others then
     rollback;
     raise;
end create_group_duplicate;


procedure change_master_card(p_m_rnk in number,
                             p_new_m_rnk in number
                            ) is
  l_trace  varchar2(64) := $$PLSQL_UNIT||'.CHANGE_MASTER_CARD';
begin
  if get_group_id(p_m_rnk,gl.kf ) = 1 then
    raise_application_error(-20000, 'Картка '||p_m_rnk||' має продукт БПК, відображається як основна без можливості зміни!');
  end if;

  bars_audit.info(l_trace||': change master-cars' || to_char(p_m_rnk) || ' to ' || to_char(p_new_m_rnk));
  -- меняем основную картку дубликатов
  -- міняємо місцями стару і нову мастер-карти
  update ebk_duplicate_groups
     set m_rnk = p_new_m_rnk,
         d_rnk = m_rnk
   where m_rnk = p_m_rnk
     and d_rnk = p_new_m_rnk ;

  -- в інших карт проводимо заміну мастер-карти
  update ebk_duplicate_groups
    set m_rnk = p_new_m_rnk
  where m_rnk = p_m_rnk;

  --commit;
end change_master_card;

procedure ignore_card(p_m_rnk in number,
                      p_d_rnk in number ) is
begin
 --разрываем связь дочерней с основной
 delete from ebk_duplicate_groups
 where m_rnk = p_m_rnk
   and d_rnk = p_d_rnk;
 --commit;
end ignore_card;

procedure MERGE_2RNK
( p_rnkfrom     in     number
, p_rnkto       in     number
) is
begin

  bars_audit.trace( '%s.merge_2rnk: Entry with ( p_rnkfrom=%s, p_rnkto=%s ).'
                  , $$PLSQL_UNIT, to_char(p_rnkfrom), to_char(p_rnkto) );

  -- передача данных одного клиента другому на основании стандартной процедуры
  RNK2RNK( p_rnkfrom, p_rnkto );

  -- разрываем связь дочерней с основной
  delete EBK_DUPLICATE_GROUPS
   where m_rnk = p_rnkto
     and d_rnk = p_rnkfrom;

  bars_audit.trace( '%s.merge_2rnk: Exit.', $$PLSQL_UNIT );

exception
  when OTHERS then
    rollback;
    raise;
end MERGE_2RNK;

procedure change_cust_attr (p_rnk in number,
                            p_attr_name in varchar2,
                            p_new_val in varchar2
                           )
 is
 l_theCursor integer;
 l_columnValue number default NULL;
 l_status integer;
 l_action ebk_card_attributes.action%type;
 begin
   -- Клиент должен быть открытым
   for x in (select date_off from customer where rnk = p_rnk)
   loop
       if x.date_off is not null then
        raise_application_error(-20000, 'Клиент rnk='||p_rnk||' закрыт, змінення над карткой заборонені!');
       end if;
   end loop;
   --Определяем действие
   select action into l_action
     from ebk_card_attributes where name = p_attr_name;

  if l_action is not null then   -- есть действие над атрибутом
       l_theCursor := dbms_sql.open_cursor;

       dbms_sql.parse(c => l_theCursor,
                      statement => l_action,
                      language_flag => dbms_sql.native);

       dbms_sql.bind_variable(c => l_theCursor,
                               name => ':p_rnk',
                               value => p_rnk);

       dbms_sql.bind_variable(c => l_theCursor,
                               name => ':p_new_val',
                               value => p_new_val);

       l_status := dbms_sql.execute(l_theCursor);

       dbms_sql.close_cursor(l_theCursor);
   end if;
 exception
  when no_data_found  then null;
  when others then
    if DBMS_SQL.IS_OPEN (c => l_theCursor) then
    dbms_sql.close_cursor(l_theCursor);
    end if;
    rollback;
    raise;
 end change_cust_attr;

end ebk_dup_wform_utl;
/

show errors;

grant EXECUTE on EBK_DUP_WFORM_UTL to BARS_ACCESS_DEFROLE;
