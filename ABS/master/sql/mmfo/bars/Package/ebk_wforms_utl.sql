create or replace package EBK_WFORMS_UTL
is
  
  --
  -- constants
  --
  g_header_version  constant varchar2(64)  := 'version 1.03  2016.08.19';
  
  function show_card_accord_quality( p_kf in varchar2, 
                                     p_rnk in number, 
                                     p_quality_group in varchar2, 
                                     p_percent in number) return number; 
  function show_card_accord_quality2( p_kf in varchar2, 
                                     p_rnk in number, 
                                     p_quality_group in varchar2, 
                                     p_percent_from in number,
                                     p_percent_to in number) return number; 
  procedure add_card_qlt_log(p_rnk in number);
  
  procedure del_subgr(p_group_id in number,
                      p_subgr_id in number
                     );
  procedure add_subgr(p_group_id in number,
                      p_sign in varchar2, 
                      p_percent in integer);                   
   
  function get_cust_quantity_for_group(p_group_id in number ) return number;
  
  function get_cust_quantity_for_subgr(p_group_id in number,
                                       p_subgr_id in number) return number;
  function get_cust_subgrp( p_group_id in number
                           ,p_quality in number) return number DETERMINISTIC; 
                           
  procedure change_cust_attr (p_rnk in number,
                              p_attr_name in varchar2,
                              p_new_val in varchar2
                              );
  procedure add_rnk_queue (p_rnk in number);  
  
  function get_db_value(p_rnk in number,p_attr_name in varchar2)  return varchar2;
  
  -- на случай если бы была кнопка на случай сохранить все сделанные изменения
  procedure save_card_changes( p_kf in varchar2,
                               p_rnk in number);
  
  --нажатии кнопки изменить атрибут,после изменения рекомендация должна быть стерта
  procedure dell_one_recomm (p_kf in varchar2,
                             p_rnk in number, 
                             p_attr_name in varchar2
                             );
   
  -- Возвращает колличество строк для фильтров "Арм Якості"                             
  procedure get_cust_subgrp_count( p_group_id       in number default 1, /*БПК,Кредиты,Депозиты,,, */
                                   p_prc_quality_id in number default null, /* Подгруппы на первой стр.,null значит Все*/
                                   p_nmk            in varchar2 default null,
                                   p_rnk            in number default null,
                                   p_okpo           in varchar2 default null,
                                   p_ser            in varchar2 default null,
                                   p_numdoc         in varchar2 default null,
                                   p_quality_group  in varchar2 default null, /*Card, Default*/
                                   p_percent        in number default null, /*Процент Качества*/
                                   p_attr_qty       in number default null, /*Кол-во атрибутов для правки*/
                                   p_branch         in varchar2 default null,
                                   p_count_row      out number);

  --
  -- 
  --
  function GET_RNK
  ( p_rnk  customer.rnk%type
  , p_kf   customer.kf%type default sys_context('bars_context','user_mfo')
  ) return customer.rnk%type;

  --
  -- 
  --
  function CUT_RNK
  ( p_rnk  customer.rnk%type
  ) return customer.rnk%type;


end EBK_WFORMS_UTL;
/

show err

----------------------------------------------------------------------------------------------------

create or replace package body EBK_WFORMS_UTL
is
  
  --
  -- constants
  --
  g_body_version  constant varchar2(64) := 'version 1.06  2017.11.21';
  g_cust_tp       constant varchar2(1)  := 'I';
  
  --
  -- variables
  --
  
  function show_card_accord_quality
  ( p_kf            in     varchar2,
    p_rnk           in     number,
    p_quality_group in     varchar2,
    p_percent       in     number
  ) return number
  is
  begin
    if  p_quality_group is null and p_percent is null
    then --показать все
      return 1;
    end if;
    for x in ( select null 
                 from ebk_qualityattr_gourps
                where kf = p_kf
                  and rnk = p_rnk
                  and name = NVL(p_quality_group, 'card')
                  and quality <= p_percent )
    loop
     return 1; --подходит по условию
    end loop;
    return  0;
  end show_card_accord_quality;

  function show_card_accord_quality2(p_kf in varchar2,
                                    p_rnk in number,
                                    p_quality_group in varchar2,
                                    p_percent_from in number,
                                    p_percent_to in number) return number
  is
  begin
   if  p_quality_group is null then --показать все
    return 1;
   end if;
   for x in ( select null from ebk_qualityattr_gourps
              where kf = p_kf
                and rnk = p_rnk
                and name = p_quality_group
                and quality between p_percent_from and p_percent_to )
   loop
    return 1; --подходит по условию
   end loop;
   return  0;
  end show_card_accord_quality2;

  procedure add_card_qlt_log(p_rnk in number)
  is
  begin
   insert into ebk_card_qlt_log(rnk, date_updated, user_id)
                         values(p_rnk, sysdate, user_id);
  end add_card_qlt_log;

  procedure del_subgr(p_group_id in number,
                      p_subgr_id in number
                     ) is
  begin
    delete from ebk_sub_groups
    where id_grp  = p_group_id
      and id_prc_quality = p_subgr_id;
  end del_subgr;

  procedure add_subgr(p_group_id in number,
                      p_sign in varchar2,
                      p_percent in integer) is
  l_subgr_id number;
  l_prc_descr varchar2(50);
   function get_descr(p_sign in varchar2) return varchar2
   is
   l_descr varchar2(50);
   begin
     for x in ( select case p_sign
                       when '>' then 'Заповнені більш ніж на'
                       when '<' then 'Заповнені меньше ніж на'
                       when '=' then 'Заповнені на'
                       when '>=' then 'Заповнені більше або дорівнює'
                       when '<=' then 'Заповнені меньше або дорівнює'
                       else
                         null
                       end as descr
                from dual )
     loop
       l_descr := x.descr;
     end loop;
     return l_descr;
   end get_descr;
  begin
    -- возможно завели ранее
    for x in (select id from ebk_prc_quality
               where name = p_sign||' '||p_percent)
    loop
      l_subgr_id := x.id;
    end loop;
    -- не был ранее заведен
    if l_subgr_id is null  then
      l_subgr_id := ebk_prc_quality_seq.nextval;
      l_prc_descr := get_descr(p_sign);
      insert into ebk_prc_quality (id, name, descr)
      select l_subgr_id, p_sign||' '||p_percent, l_prc_descr||' '||p_percent||'%' from dual;
    end if;
    -- связываем субгруппу с группой
    insert into ebk_sub_groups (id_grp, id_prc_quality)
    select p_group_id, l_subgr_id from dual
    where not exists (select null from  ebk_sub_groups
                      where id_grp = p_group_id
                        and id_prc_quality = l_subgr_id);
  exception
   when others then
     rollback; raise;
  end;

  function get_cust_quantity_for_group(p_group_id in number )
    return number
  is
  begin
    for x in ( select count(1) as qty 
                from EBKC_REQ_UPDATECARD t
               where t.GROUP_ID  = p_group_id
                 and t.KF        = gl.kf()
                 and t.CUST_TYPE = g_cust_tp
                 and not exists (select null from customer where rnk = t.rnk and date_off is not null) )
    loop
      return x.qty;
    end loop;
  end get_cust_quantity_for_group;

  --
  --
  --
  function get_cust_quantity_for_subgr(p_group_id in number,
                                       p_subgr_id in number
  ) return number
  is
    l_sql ebk_prc_quality.name%type;
    l_qty number;
  begin
    for x in (select name from EBK_PRC_QUALITY where id = p_subgr_id )
    loop
      l_sql := x.name;
    end loop;

    if l_sql is not null then
      execute immediate ' select count(1) as qty '||
                        '   from EBKC_REQ_UPDATECARD teru '||
                        '  where teru.group_id = :p_group_id '||
                        '   and KF = gl.kf '||
                        '   and CUST_TYPE = '''||g_cust_tp||''''||
                        '   and not exists (select null from customer where rnk = teru.rnk and date_off is not null)'||
                        '   and teru.quality '||l_sql 
         into l_qty
        using p_group_id;
    end if;

    return nvl(l_qty,0);

  end get_cust_quantity_for_subgr;

 --
 -- GET_CUST_SUBGRP
 --
 function GET_CUST_SUBGRP
 ( p_group_id in number
 , p_quality  in number
 ) return number
 DETERMINISTIC
 is
   l_id_prc_q number;
 begin
   
   bars_audit.trace( '%s.GET_CUST_SUBGRP: Entry with ( p_group_id=%s, p_quality=%s ).'
                   , $$PLSQL_UNIT, to_char(p_group_id), to_char(p_quality) );
   
   for x in ( select esg.id_prc_quality,
                     ( select name  from ebk_prc_quality where id = id_prc_quality ) as prc_level
                from EBK_SUB_GROUPS esg
               where id_grp = p_group_id
               order by esg.id_prc_quality desc )
   loop
     
     bars_audit.trace( '%s.GET_CUST_SUBGRP: ( id_prc_quality=%s, p_quality=%s ).'
                     , $$PLSQL_UNIT, to_char(x.id_prc_quality), to_char(x.prc_level) );
     
     execute immediate 'select nvl(max(:id_prc_quality),0) from dual where :p_quality '||x.prc_level
                  into l_id_prc_q 
                 using x.id_prc_quality, p_quality;

     bars_audit.trace( '%s.GET_CUST_SUBGRP: ( l_id_prc_q=%s ).'
                     , $$PLSQL_UNIT, to_char(l_id_prc_q) );
     
     if l_id_prc_q <> 0 
     then
       exit;
     end if;
     
   end loop;
   
   return nvl(l_id_prc_q,0);
   
 end GET_CUST_SUBGRP;

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
        rollback;
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
   -- save sysdate into change_log
   add_card_qlt_log(p_rnk);
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

 procedure add_rnk_queue (p_rnk in number) is
 begin
  insert into ebk_queue_updatecard (rnk)
                            select p_rnk from dual
                            where not exists (select null from ebk_queue_updatecard where rnk = p_rnk and status = 0);
 end add_rnk_queue;

 procedure del_all_recomm(p_rnk in number, p_kf in varchar2 ) is
 begin

   delete
     from EBKC_REQ_UPDATECARD
    where kf        = p_kf
      and rnk       = p_rnk
      and CUST_TYPE = g_cust_tp;

   delete EBKC_REQ_UPDCARD_ATTR
    where KF        = p_kf
      and RNK       = p_rnk
      and CUST_TYPE = g_cust_tp;

 end del_all_recomm;

 procedure save_card_changes( p_kf in varchar2,
                              p_rnk in number) is
 begin
    --при сохранении удаляем рекомендации
   del_all_recomm(p_rnk, p_kf );
   -- добавляем физ.л. в очередь на проверку очередную
   add_rnk_queue (p_rnk);
   exception
   when others then
     rollback; raise;
 end save_card_changes;

 function get_db_value(p_rnk in number,p_attr_name in varchar2)  return varchar2
 is
 l_ret_val varchar2(500);
 begin
   execute immediate 'select '||p_attr_name||' from ebk_cust_bd_info_v  where rnk = :p_rnk' into l_ret_val using p_rnk;
   return l_ret_val;
  exception
   when others then
     return null;
 end get_db_value;

  procedure dell_one_recomm (p_kf in varchar2,
                             p_rnk in number,
                             p_attr_name in varchar2
                             ) is
  begin
    -- удаляем конкретную рекомендацию
    delete EBKC_REQ_UPDCARD_ATTR
     where KF        = p_kf
       and RNK       = p_rnk
       and CUST_TYPE = g_cust_tp
       and NAME      = p_attr_name;
    -- возможно мы удалили последнию рекомендацию, потому очищаем мастер запись
    -- это нужно для корректоного подсчета лиц для корректировки
    delete EBKC_REQ_UPDATECARD
     where KF        = p_kf
       and RNK       = p_rnk
       and CUST_TYPE = g_cust_tp
       and not exists (select null 
                         from EBKC_REQ_UPDCARD_ATTR
                        where KF        = p_kf
                          and RNK       = p_rnk
                          and CUST_TYPE = g_cust_tp
                          and quality  != ebk_request_utl.g_correct_quality);

   --отправляем rnk вновь в очередь проверок
   add_rnk_queue (p_rnk) ;
  exception
   when others then
     rollback; raise;
 end dell_one_recomm;

 procedure get_cust_subgrp_count(p_group_id       in number default 1, /*БПК,Кредиты,Депозиты,,, */
                                 p_prc_quality_id in number default null, /* Подгруппы на первой стр.,null значит Все*/
                                 p_nmk            in varchar2 default null,
                                 p_rnk            in number default null,
                                 p_okpo           in varchar2 default null,
                                 p_ser            in varchar2 default null,
                                 p_numdoc         in varchar2 default null,
                                 p_quality_group  in varchar2 default null, /*Card, Default*/
                                 p_percent        in number default null, /*Процент Качества*/
                                 p_attr_qty       in number default null, /*Кол-во атрибутов для правки*/
                                 p_branch         in varchar2 default null,
                                 p_count_row      out number) is
 begin
   select /*+ index(c PK_CUSTOMER) index(teru INDX_TERU_U1)*/
    count(*)
     into p_count_row
     from EBKC_REQ_UPDATECARD teru
        , customer c
    where (p_rnk is null or p_rnk = c.rnk)
      and c.kf  = teru.kf
      and c.rnk = teru.rnk
      and c.date_off is null
      and teru.CUST_TYPE = g_cust_tp
      and teru.GROUP_ID  = p_group_id
      and exists (select 1
             from ebk_qualityattr_gourps g
            where kf = teru.kf
              and rnk = teru.rnk
              and g.name = nvl(p_quality_group, 'card')
              and g.quality <= nvl(p_percent, 1000))
      and (p_nmk is null or c.nmk like p_nmk)
      and (p_okpo is null or c.okpo = p_okpo)
      and (p_branch is null or c.branch = p_branch)
      and (p_ser || p_numdoc is null or exists
           (select 1
              from person
             where (ser = p_ser or p_ser is null)
               and (numdoc = p_numdoc or p_numdoc is null)
               and rnk = c.rnk))
      and ( p_prc_quality_id is null or
            p_prc_quality_id = EBK_WFORMS_UTL.GET_CUST_SUBGRP(teru.group_id,teru.quality)
          )
      and ( p_attr_qty is null or
            p_attr_qty = (select count(a.name)
                            from EBKC_REQ_UPDCARD_ATTR a
                           where a.kf = teru.kf
                             and a.rnk = teru.rnk
                             and a.CUST_TYPE = g_cust_tp
                             and ( a.recommendvalue is not null or
                                   a.descr is not null )
                         )
          );
  end;
  
  --
  -- 
  --
  function GET_RNK
  ( p_rnk  customer.rnk%type
  , p_kf   customer.kf%type default sys_context('bars_context','user_mfo')
  ) return customer.rnk%type
  is
    l_rnk  customer.rnk%type;
    l_ru   number(2);
  begin
$if EBK_PARAMS.CUT_RNK $then
    l_ru := case p_kf
              when '300465' then 01
              when '324805' then 02
              when '302076' then 03
              when '303398' then 04
              when '305482' then 05
              when '335106' then 06
              when '311647' then 07
              when '312356' then 08
              when '313957' then 09
              when '336503' then 10
              when '322669' then 11
              when '323475' then 12
              when '304665' then 13
              when '325796' then 14
              when '326461' then 15
              when '328845' then 16
              when '331467' then 17
              when '333368' then 18
              when '337568' then 19
              when '338545' then 20
              when '351823' then 21
              when '352457' then 22
              when '315784' then 23
              when '354507' then 24
              when '356334' then 25
              when '353553' then 26
              else 0
            end;
    l_rnk := p_rnk*100+l_ru;
$else
    l_rnk := p_rnk;
$end
    return l_rnk;
  end GET_RNK;
  
  --
  -- 
  --
  function CUT_RNK
  ( p_rnk  customer.rnk%type
  ) return customer.rnk%type
  is
    l_rnk  customer.rnk%type;
  begin
$if EBK_PARAMS.CUT_RNK $then
    l_rnk := trunc(p_rnk/100);
$else
    l_rnk := p_rnk;
$end
    return l_rnk;
  end CUT_RNK;


begin
  null;
end EBK_WFORMS_UTL;
/

show err

grant execute on EBK_WFORMS_UTL to BARS_ACCESS_DEFROLE;
