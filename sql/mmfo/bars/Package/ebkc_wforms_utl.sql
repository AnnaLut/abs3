create or replace package EBKC_WFORMS_UTL 
is

  --
  -- constants
  --
  g_header_version constant varchar2(64) := 'version 1.02  2016.08.20';

  --
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

  function get_legal_quantity_for_group(p_group_id in number ) return number;

  function get_priv_quantity_for_group(p_group_id in number ) return number;

  function get_cust_quantity_for_subgr(p_group_id in number,
                                       p_subgr_id in number) return number;
  function get_subgrp( p_group_id in number
                     , p_quality  in number) return number DETERMINISTIC;

  procedure change_cust_attr (p_rnk in number,
                              p_attr_name in varchar2,
                              p_new_val in varchar2
                              );
  procedure add_rnk_queue (p_rnk in number);

  --
  function get_db_value(p_rnk in number,p_attr_name in varchar2, p_cust_type in varchar2)  return varchar2 ;

  -- на случай если бы была кнопка на случай сохранить все сделанные изменения
  procedure save_card_changes( p_kf in varchar2,
                               p_rnk in number);

  --нажатии кнопки изменить атрибут,после изменения рекомендация должна быть стерта
  procedure dell_one_recomm (p_kf in varchar2,
                             p_rnk in number,
                             p_attr_name in varchar2
                             );

  --
  procedure change_master_card(p_m_rnk in number,
                             p_new_m_rnk in number
                             );

  --
  procedure ignore_card(p_m_rnk in number,
                      p_d_rnk in number );

  --
  procedure merge_2rnk( p_rnkfrom in number,
                        p_rnkto   in number);

  --
  function get_legal_subgrp( p_group_id in number default 1,
                             p_prc_quality_id in number default null, /* Подгруппы на первой стр.,null значит Все*/
                             p_nmk in varchar2 default null,
                             p_rnk in number default null,
                             p_okpo in varchar2 default null,
                             --p_ser in varchar2 default null,
                             --p_numdoc in varchar2 default null,
                             p_quality_group in varchar2 default null, /*Card, Default*/
                             p_percent  in number default null,  /*Процент Качества*/
                             p_attr_qty in number default null, /*Кол-во атрибутов для правки*/
                             p_branch   in varchar2 default null,
                             p_rn_from  in number default 1,
                             p_rn_to    in number default 1) return t_cust_subgrp_ebk pipelined;

  --
  function get_priv_subgrp ( p_group_id in number default 1,
                             p_prc_quality_id in number default null, /* Подгруппы на первой стр.,null значит Все*/
                             p_nmk in varchar2 default null,
                             p_rnk in number default null,
                             p_okpo in varchar2 default null,
                             p_ser in varchar2 default null,
                             p_numdoc in varchar2 default null,
                             p_quality_group in varchar2 default null, /*Card, Default*/
                             p_percent  in number default null,  /*Процент Качества*/
                             p_attr_qty in number default null, /*Кол-во атрибутов для правки*/
                             p_branch   in varchar2 default null,
                             p_rn_from  in number default 1,
                             p_rn_to    in number default 1) return t_cust_subgrp_ebk pipelined;

  -- Повертаємо кількість рядків для ОЮ для  "Арм Якості"
  procedure get_legal_subgrp_count( p_group_id       in number default 1,
                                    p_prc_quality_id in number default null, /* Подгруппы на первой стр.,null значит Все*/
                                    p_nmk            in varchar2 default null,
                                    p_rnk            in number default null,
                                    p_okpo           in varchar2 default null,
                                    p_quality_group  in varchar2 default null, /*Card, Default*/
                                    p_percent        in number default null, /*Процент Качества*/
                                    p_attr_qty       in number default null, /*Кол-во атрибутов для правки*/
                                    p_branch         in varchar2 default null,
                                    p_count_row      out number);

  --
  -- Повертаємо кількість рядків для ФОП для  "Арм Якості"
  --
  procedure get_priv_subgrp_count( p_group_id       in number default 1,
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

end EBKC_WFORMS_UTL;
/

show errors;

create or replace package body EBKC_WFORMS_UTL 
is

  --
  -- constants
  --
  g_body_version  constant varchar2(64) := 'version 1.08  2018.03.14';

  --
  -- variables
  --

  --
  -- повертає версію заголовка пакета
  --
  function header_version
    return varchar2
  is
  begin
    return 'Package '||$$PLSQL_UNIT||' header '||g_header_version||'.';
  end header_version;

  --
  -- повертає версію тіла пакета
  --
  function body_version
    return varchar2
  is
  begin
    return 'Package '||$$PLSQL_UNIT||' body ' || g_body_version || '.';
  end body_version;

  --
  -- SHOW_CARD_ACCORD_QUALITY
  --
  function show_card_accord_quality
  ( p_kf             in     varchar2
  , p_rnk            in     number
  , p_quality_group  in     varchar2
  , p_percent        in     number
  ) return number
  is
    l_result number(1) := 0;
  begin

    if ( p_quality_group is null and p_percent is null )
    then -- показать все
      l_result := 1;
    else -- подходит по условию

      select case
               when EXISTS( select null
                              from EBKC_QUALITYATTR_GROUPS
                             where kf   = p_kf
                               and rnk  = p_rnk
                               and name = NVL(p_quality_group, 'card')
                               and quality <= p_percent )
               then 1
               else 0
             end
        into l_result
        from dual;

    end if;

    return l_result;

  end show_card_accord_quality;

  --
  -- SHOW_CARD_ACCORD_QUALITY2
  --
  function show_card_accord_quality2
  ( p_kf             in     varchar2
  , p_rnk            in     number
  , p_quality_group  in     varchar2
  , p_percent_from   in     number
  , p_percent_to     in     number
  ) return number
  is
    l_result number(1) := 0;
  begin

    if ( p_quality_group is null )
    then -- показать все
      l_result := 1;
    else -- подходит по условию
      select case
               when EXISTS( select null
                              from EBKC_QUALITYATTR_GROUPS
                             where kf = p_kf
                               and rnk = p_rnk
                               and name = p_quality_group
                               and quality between p_percent_from and p_percent_to )
               then 1
               else 0
             end
        into l_result
        from dual;
    end if;

    return l_result;

  end show_card_accord_quality2;

  procedure add_card_qlt_log(p_rnk in number)
  is
  begin
    insert
      into EBK_CARD_QLT_LOG
         ( RNK, DATE_UPDATED, USER_ID )
    values
         ( p_rnk, sysdate, user_id );
  end add_card_qlt_log;

  procedure del_subgr
  ( p_group_id     in     number
  , p_subgr_id     in     number
  ) is
  begin
    delete EBKC_SUB_GROUPS
     where id_grp  = p_group_id
       and id_prc_quality = p_subgr_id;
  end del_subgr;

  --
  --
  --
  procedure ADD_SUBGR
  ( p_group_id in     number
  , p_sign     in     varchar2
  , p_percent  in     integer
  ) is
    l_subgr_id        ebk_prc_quality.id%type;
  begin

    l_subgr_id := ebk_prc_quality_seq.nextval;

    insert
      into EBK_PRC_QUALITY ( ID, PRC_QLY )
    values ( l_subgr_id, p_percent );

    -- связываем субгруппу с группой
    insert
      into EBKC_SUB_GROUPS ( ID_GRP, ID_PRC_QUALITY )
    values ( p_group_id, l_subgr_id );

  exception
   when others then
     rollback;
     raise;
  end;

  --
  --
  --
  function get_cust_quantity_for_group(p_group_id in number, p_custtype in varchar2) return number
  is
  begin
     for x in ( select count(1) as qty
                  from EBKC_REQ_UPDATECARD  t
                 where t.group_id = p_group_id
                   and t.kf = gl.kf
                   and nvl(cust_type,ebkc_pack.get_custtype(t.rnk)) = p_custtype
                   and not exists (select null from customer where rnk = t.rnk and date_off is not null) )
     loop
      return x.qty;
     end loop;
  end get_cust_quantity_for_group;
 -- +
 function get_legal_quantity_for_group(p_group_id in number ) return number
 is
 begin
   return GET_CUST_QUANTITY_FOR_GROUP( p_group_id, EBKC_PACK.LEGAL_ENTITY );
 end;
 -- +
 function get_priv_quantity_for_group(p_group_id in number ) return number
 is
 begin
   return GET_CUST_QUANTITY_FOR_GROUP( p_group_id, EBKC_PACK.PRIVATE_ENT );
 end;

  function get_cust_quantity_for_subgr(p_group_id in number,
                                       p_subgr_id in number
  ) return number
  is
    l_sql ebk_prc_quality.name%type;
    l_qty number;
  begin

    for x in (select name from ebk_prc_quality where id = p_subgr_id )
    loop
      l_sql := x.name;
    end loop;

    if l_sql is not null
    then
      execute immediate 'select count(1) as qty '||
                        '  from EBKC_REQ_UPDATECARD_LEGAL  teru '||
                        ' where teru.group_id = :p_group_id '||
                        '   and kf = gl.kf '||
                        '   and not exists (select null from customer where rnk = teru.rnk and date_off is not null)'||
                        '   and teru.quality '||l_sql
         into l_qty
        using p_group_id;
    end if;

   return nvl(l_qty,0);

 end get_cust_quantity_for_subgr;

 --
 --
 --
 function GET_SUBGRP
 ( p_group_id in number
 , p_quality  in number
 ) return number
 DETERMINISTIC
 is
   l_id_prc_q number;
 begin

   bars_audit.trace( '%s.GET_SUBGRP: Entry with ( p_group_id=%s, p_quality=%s ).'
                   , $$PLSQL_UNIT, to_char(p_group_id), to_char(p_quality) );

   for x in ( select esg.id_prc_quality,
                     ( select name  from ebk_prc_quality where id = id_prc_quality ) as prc_level
                from EBKC_SUB_GROUPS esg
               where id_grp = p_group_id
               order by esg.id_prc_quality desc )
   loop

     bars_audit.trace( '%s.GET_SUBGRP: ( id_prc_quality=%s, p_quality=%s ).'
                     , $$PLSQL_UNIT, to_char(x.id_prc_quality), to_char(x.prc_level) );

     execute immediate 'select nvl(max(:id_prc_quality),0) from dual where :p_quality '||x.prc_level
                  into l_id_prc_q
                 using x.id_prc_quality, p_quality;

     bars_audit.trace( '%s.GET_SUBGRP: ( l_id_prc_q=%s ).'
                     , $$PLSQL_UNIT, to_char(l_id_prc_q) );

     if l_id_prc_q <> 0
     then
       exit;
     end if;

   end loop;

   return nvl(l_id_prc_q,0);

 end GET_SUBGRP;

  procedure change_cust_attr
  ( p_rnk       in     number,
    p_attr_name in     varchar2,
    p_new_val   in     varchar2
  ) is
    l_theCursor        integer;
    l_status           integer;
    l_action           EBKC_CARD_ATTRIBUTES.action%type;
  begin
    -- Клиент должен быть открытым
    for x in (select date_off from customer where rnk = p_rnk)
    loop
      if x.date_off is not null
      then
       raise_application_error(-20000, 'Клієнт з rnk='||p_rnk||' закритий, зміни над карткою заборонені!');
      end if;
    end loop;

    -- Определяем действие
    select action
      into l_action
      from EBKC_CARD_ATTRIBUTES
     where name = p_attr_name
       and cust_type = ebkc_pack.get_custtype(p_rnk);

   if l_action is not null
   then   -- есть действие над атрибутом

     l_theCursor := dbms_sql.open_cursor;

     dbms_sql.parse( c             => l_theCursor,
                     statement     => l_action,
                     language_flag => dbms_sql.native);

     dbms_sql.bind_variable( c     => l_theCursor,
                             name  => ':p_rnk',
                             value => p_rnk);

     dbms_sql.bind_variable( c     => l_theCursor,
                             name  => ':p_new_val',
                             value => p_new_val);

     l_status := dbms_sql.execute(l_theCursor);

     dbms_sql.close_cursor(l_theCursor);
     -- save sysdate into change_log
     add_card_qlt_log(p_rnk);

   end if;

   exception
     when no_data_found then null;
     when others then
      if DBMS_SQL.IS_OPEN (c => l_theCursor)
      then
        dbms_sql.close_cursor(l_theCursor);
      end if;
      rollback;
      raise;
  end change_cust_attr;

  procedure add_rnk_queue
  ( p_rnk in number
  ) is
  begin
    insert
      into EBKC_QUEUE_UPDATECARD
         ( RNK, CUST_TYPE )
    select p_rnk, ebkc_pack.get_custtype( p_rnk )
      from dual
     where not exists (select null from EBKC_QUEUE_UPDATECARD  where rnk = p_rnk and status = 0);
  end add_rnk_queue;

 procedure del_all_recomm(p_rnk in number, p_kf in varchar2 ) is
 begin
   delete
     from EBKC_REQ_UPDATECARD
    where kf = p_kf
     and rnk = p_rnk;

   delete from  EBKC_REQ_UPDCARD_ATTR
       where kf = p_kf
         and rnk = p_rnk;
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

 function get_db_value(p_rnk in number,p_attr_name in varchar2, p_cust_type in varchar2)  return varchar2
 is
 l_ret_val varchar2(500);
 begin
   if (p_cust_type = 'L') then
      execute immediate 'select '||p_attr_name||' from V_EBKC_LEGAL_PERSON where rnk = :p_rnk' into l_ret_val using p_rnk;
   elsif (p_cust_type = 'P') then
      execute immediate 'select '||p_attr_name||' from V_EBKC_PRIVATE_ENT where rnk = :p_rnk' into l_ret_val using p_rnk;
   end if;
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
   delete from EBKC_REQ_UPDCARD_ATTR
   where kf = p_kf
     and rnk = p_rnk
     and name = p_attr_name;
  -- возможно мы удалили последнию рекомендацию, потому очищаем мастер запись
  -- это нужно для корректоного подсчета лиц для корректировки
    delete from EBKC_REQ_UPDATECARD
    where kf = p_kf
      and rnk = p_rnk
      and not exists (select null from EBKC_REQ_UPDCARD_ATTR
                      where kf = p_kf
                        and rnk = p_rnk
                        and quality <> ebk_request_utl.g_correct_quality);

   --отправляем rnk вновь в очередь проверок
   add_rnk_queue (p_rnk) ;
  exception
   when others then
     rollback; raise;
 end dell_one_recomm;

 procedure get_subgrp_count(p_group_id       in number default 1,
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
                                 p_custtype       in varchar2,
                                 p_count_row      out number) is
 begin
   select /*+ index(c PK_CUSTOMER) index(teru INDX_TERU_U1)*/
    count(*)
     into p_count_row
     from EBKC_REQ_UPDATECARD teru, customer c,
          (select gl.kf as kf from dual) ss_kf
    where (p_rnk is null or p_rnk = c.rnk)
      and teru.kf = ss_kf.kf
      and c.rnk = teru.rnk
      and c.date_off is null
      and group_id = p_group_id
         --24.09.2015 Irina.Ivanova
         --and ebk_wforms_utl.show_card_accord_quality(ss_kf.kf, teru.rnk, p_quality_group, p_percent) = 1
      and exists (select 1
             from EBKC_QUALITYATTR_GROUPS g
            where kf = teru.kf
              and rnk = teru.rnk
              and g.name = nvl(p_quality_group, 'card')
              and g.quality <= nvl(p_percent, 1000)
              and g.cust_type = p_custtype)
      and (p_nmk is null or c.nmk like p_nmk)
      and (p_okpo is null or c.okpo = p_okpo)
      and (p_branch is null or c.branch = p_branch)
      and (p_ser || p_numdoc is null or exists
           (select 1
              from person
             where (ser = p_ser or p_ser is null)
               and (numdoc = p_numdoc or p_numdoc is null)
               and rnk = c.rnk))
      and (p_prc_quality_id is null or ebkc_wforms_utl.get_subgrp(teru.group_id, teru.quality) = p_prc_quality_id)
      and (p_attr_qty is null or
          (select count(a.name)
              from EBKC_REQ_UPDCARD_ATTR a
             where a.kf = teru.kf
               and a.rnk = teru.rnk
               and a.cust_type = p_custtype
                  --24.09.2015 Irina Ivanova
                  --and quality <> 'C'
               and (a.recommendvalue is not null or a.descr is not null)) = p_attr_qty);
 end get_subgrp_count;

  procedure get_legal_subgrp_count
  ( p_group_id       in  number default 1,
    p_prc_quality_id in  number default null, /* Подгруппы на первой стр.,null значит Все*/
    p_nmk            in  varchar2 default null,
    p_rnk            in  number default null,
    p_okpo           in  varchar2 default null,
    p_quality_group  in  varchar2 default null, /*Card, Default*/
    p_percent        in  number default null, /*Процент Качества*/
    p_attr_qty       in  number default null, /*Кол-во атрибутов для правки*/
    p_branch         in  varchar2 default null,
    p_count_row      out number
  ) is
  begin
    get_subgrp_count( p_group_id       => p_group_id,
                      p_prc_quality_id => p_prc_quality_id,
                      p_nmk            => p_nmk,
                      p_rnk            => p_rnk,
                      p_okpo           => p_okpo,
                      p_ser            => null,
                      p_numdoc         => null,
                      p_quality_group  => p_quality_group,
                      p_percent        => p_percent,
                      p_attr_qty       => p_attr_qty,
                      p_branch         => p_branch,
                      p_custtype       => EBKC_PACK.LEGAL_ENTITY,
                      p_count_row      => p_count_row );
 end get_legal_subgrp_count;

 procedure get_priv_subgrp_count(p_group_id       in number default 1,
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
         get_subgrp_count(p_group_id      => p_group_id,
                                 p_prc_quality_id => p_prc_quality_id,
                                 p_nmk            => p_nmk,
                                 p_rnk            => p_rnk,
                                 p_okpo           => p_okpo,
                                 p_ser            => p_ser,
                                 p_numdoc         => p_numdoc,
                                 p_quality_group  => p_quality_group,
                                 p_percent        => p_percent,
                                 p_attr_qty       => p_attr_qty,
                                 p_branch         => p_branch,
                                 p_custtype       => ebkc_pack.PRIVATE_ENT,
                                 p_count_row      => p_count_row);
 end get_priv_subgrp_count;
-- ???
function get_subgrp (p_group_id in number default 1,
                           p_prc_quality_id in number default null, /* Подгруппы на первой стр.,null значит Все*/
                           p_nmk in varchar2 default null,
                           p_rnk in number default null,
                           p_okpo in varchar2 default null,
                           p_ser in varchar2 default null,
                           p_numdoc in varchar2 default null,
                           p_quality_group in varchar2 default null, /*Card, Default*/
                           p_percent  in number default null,  /*Процент Качества*/
                           p_attr_qty in number default null, /*Кол-во атрибутов для правки*/
                           p_branch   in varchar2 default null,
                           p_rn_from  in number default 1,
                           p_rn_to    in number default 1) return t_cust_subgrp_ebk pipelined as
begin
  for cur in ( select cast (r.rnk as number (38)) as rnk,
                      cast (r.group_id as number(1)) as group_id,
                      cast (r.id_prc_quality as number) id_prc_quality,
                      cast (r.okpo as varchar2(14)) as okpo,
                      cast(r.nmk as varchar2(70)) as nmk,
                      cast(r.quality as number(6,2)) as quality,
                      cast(r.document as varchar2(31)) as document,
                      cast(r.birth_day as varchar2(10))as birth_day,
                      cast(r.attr_qty as number ) as  attr_qty,
                      cast(r.last_card_upd as date)as last_card_upd,
                      cast( (select s.fio
                               from staff$base s, ebk_card_qlt_log l
                              where l.rnk = r.rnk
                                and l.date_updated = r.last_card_upd
                                and s.id = l.user_id
                                and rownum = 1) as varchar2(60)) as last_user_upd,
                      r.branch
              from (select teru.rnk,
                           teru.group_id,
                           nvl(p_prc_quality_id,ebkc_wforms_utl.get_subgrp (teru.group_id,teru.quality)) as id_prc_quality,
                           teru.okpo,
                           teru.nmk,
                           teru.quality,
                          cast( (select ser || ' ' || numdoc
                              from person
                             where rnk = teru.rnk) as varchar2(31))as document,
                           cast((select to_char (bday, 'dd.mm.yyyy')
                              from person
                             where rnk = teru.rnk) as varchar2(10)) as birth_day,
                         cast( (select count (a.name)
                             from EBKC_REQ_UPDCARD_ATTR     a
                            where a.kf = teru.kf and a.rnk = teru.rnk
                              --24.09.2015 Irina Ivanova
                              --and quality <> 'C'
                              and (a.recommendvalue is not null or a.descr is not null)
                              and nvl(cust_type,ebkc_pack.get_custtype(a.rnk)) = 'L'
                              ) as number) as attr_qty,
                         cast( (select max (date_updated)
                             from ebk_card_qlt_log
                            where rnk = teru.rnk) as date )
                            as last_card_upd,
                         teru.branch
             from (select a1.* from
                             (select  a.*, rownum r__n
                                 from ( select  teru.*, c.nmk, c.okpo, c.branch
                                          from EBKC_REQ_UPDATECARD  teru, customer c, (select gl.kf as kf from dual) ss_kf
                                         where (p_rnk is null or p_rnk = c.rnk)
                                           and teru.kf = ss_kf.kf
                                           and c.rnk = teru.rnk
                                           and c.date_off is null
                                           and group_id = p_group_id
                                           --24.09.2015 Irina.Ivanova
                                           --and ebk_wforms_utl.show_card_accord_quality(ss_kf.kf, teru.rnk, p_quality_group, p_percent) = 1
                                           and exists (select 1
                                                         from EBKC_QUALITYATTR_GROUPS   g
                                                        where kf = teru.kf
                                                          and rnk = teru.rnk
                                                          and g.name = NVL(p_quality_group, 'card')
                                                          and g.quality <= nvl(p_percent, 1000)
                                                          and  nvl(cust_type,ebkc_pack.get_custtype(g.rnk)) = 'L')
                                           and (p_nmk is null or c.nmk like p_nmk)
                                           and (p_okpo is null or c.okpo = p_okpo)
                                           and (p_branch is null or c.branch = p_branch)
                                           and (p_ser||p_numdoc is null or exists    (select 1
                                                                                       from person
                                                                                       where (ser =    p_ser       or p_ser    is null)
                                                                                         and (numdoc = p_numdoc    or p_numdoc is null)
                                                                                         and rnk = c.rnk))
                                           and (p_prc_quality_id is null or ebkc_wforms_utl.get_subgrp (teru.group_id,teru.quality) = p_prc_quality_id)
                                           and (p_attr_qty  is null or   (select count (a.name) from EBKC_REQ_UPDCARD_ATTR  a
                                                                            where a.kf = teru.kf and a.rnk = teru.rnk
                                                                            --24.09.2015 Irina Ivanova
                                                                            --and quality <> 'C'
                                                                            and (a.recommendvalue is not null or a.descr is not null)
                                                                            and  nvl(a.cust_type,ebkc_pack.get_custtype(a.rnk)) = 'L'
                                                                            ) = p_attr_qty)
                                           and nvl(teru.cust_type,ebkc_pack.get_custtype(c.rnk)) = 'L'
                                           order by teru.rnk ) a
                                          ) a1
                               where a1.r__n between p_rn_from and p_rn_to) teru) r
  ) loop
    pipe row(r_cust_subgrp_ebk(cur.rnk, cur.group_id, cur.id_prc_quality, cur.okpo, cur.nmk, cur.quality, cur.document, cur.birth_day, cur.attr_qty, cur.last_card_upd, cur.last_user_upd, cur.branch));
  end loop;
  return;
end get_subgrp;

function get_legal_subgrp (p_group_id in number default 1,
                                                       p_prc_quality_id in number default null, /* Подгруппы на первой стр.,null значит Все*/
                                                       p_nmk in varchar2 default null,
                                                       p_rnk in number default null,
                                                       p_okpo in varchar2 default null,
                                                       p_quality_group in varchar2 default null, /*Card, Default*/
                                                       p_percent  in number default null,  /*Процент Качества*/
                                                       p_attr_qty in number default null, /*Кол-во атрибутов для правки*/
                                                       p_branch   in varchar2 default null,
                                                       p_rn_from  in number default 1,
                                                       p_rn_to    in number default 1) return t_cust_subgrp_ebk pipelined as
begin
  for cur in ( select cast (r.rnk as number (38)) as rnk,
                      cast (r.group_id as number(1)) as group_id,
                      cast (r.id_prc_quality as number) id_prc_quality,
                      cast (r.okpo as varchar2(14)) as okpo,
                      cast(r.nmk as varchar2(70)) as nmk,
                      cast(r.quality as number(6,2)) as quality,
                      cast(r.attr_qty as number ) as  attr_qty,
                      cast(r.last_card_upd as date)as last_card_upd,
                      cast( (select s.fio
                               from staff$base s, ebk_card_qlt_log l
                              where l.rnk = r.rnk
                                and l.date_updated = r.last_card_upd
                                and s.id = l.user_id
                                and rownum = 1) as varchar2(60)) as last_user_upd,
                      r.branch
              from (select teru.rnk,
                           teru.group_id,
                           nvl(p_prc_quality_id,ebkc_wforms_utl.get_subgrp (teru.group_id,teru.quality)) as id_prc_quality,
                           teru.okpo,
                           teru.nmk,
                           teru.quality,
                         cast( (select count (a.name)
                             from EBKC_REQ_UPDCARD_ATTR     a
                            where a.kf = teru.kf and a.rnk = teru.rnk
                              --24.09.2015 Irina Ivanova
                              --and quality <> 'C'
                              and (a.recommendvalue is not null or a.descr is not null)
                              and nvl(cust_type,ebkc_pack.get_custtype(a.rnk)) = 'L'
                              ) as number) as attr_qty,
                         cast( (select max (date_updated)
                             from ebk_card_qlt_log
                            where rnk = teru.rnk) as date )
                            as last_card_upd,
                         teru.branch
             from (select a1.* from
                             (select  a.*, rownum r__n
                                 from ( select  teru.*, c.nmk, c.okpo, c.branch
                                          from EBKC_REQ_UPDATECARD  teru
                                             , CUSTOMER c
                                             , (select gl.kf as kf from dual) ss_kf
                                         where (p_rnk is null or p_rnk = c.rnk)
                                           and teru.kf = ss_kf.kf
                                           and c.rnk = teru.rnk
                                           and c.DATE_OFF is null
                                           and group_id = p_group_id
                                           --24.09.2015 Irina.Ivanova
                                           --and ebk_wforms_utl.show_card_accord_quality(ss_kf.kf, teru.rnk, p_quality_group, p_percent) = 1
                                           and exists (select 1
                                                         from EBKC_QUALITYATTR_GROUPS   g
                                                        where kf = teru.kf
                                                          and rnk = teru.rnk
                                                          and g.name = NVL(p_quality_group, 'card')
                                                          and g.quality <= nvl(p_percent, 1000)
                                                          and  nvl(cust_type,ebkc_pack.get_custtype(g.rnk)) = 'L')
                                           and (p_nmk is null or c.nmk like p_nmk)
                                           and (p_okpo is null or c.okpo = p_okpo)
                                           and (p_branch is null or c.branch = p_branch)
                                           and (p_prc_quality_id is null or ebkc_wforms_utl.get_subgrp (teru.group_id,teru.quality) = p_prc_quality_id)
                                           and (p_attr_qty  is null or   (select count (a.name) from EBKC_REQ_UPDCARD_ATTR  a
                                                                            where a.kf = teru.kf and a.rnk = teru.rnk
                                                                            --24.09.2015 Irina Ivanova
                                                                            --and quality <> 'C'
                                                                            and (a.recommendvalue is not null or a.descr is not null)
                                                                            and  nvl(cust_type,ebkc_pack.get_custtype(a.rnk)) = 'L'
                                                                            ) = p_attr_qty)
                                           and nvl(cust_type,ebkc_pack.get_custtype(c.rnk)) = 'L'
                                           order by teru.rnk ) a
                                          ) a1
                               where a1.r__n between p_rn_from and p_rn_to) teru) r

  ) loop
    pipe row(r_cust_subgrp_ebk(cur.rnk, cur.group_id, cur.id_prc_quality, cur.okpo, cur.nmk, cur.quality, null, null, cur.attr_qty, cur.last_card_upd, cur.last_user_upd, cur.branch));
  end loop;
  return;
end get_legal_subgrp;

function get_priv_subgrp (p_group_id in number default 1,
                                                       p_prc_quality_id in number default null, /* Подгруппы на первой стр.,null значит Все*/
                                                       p_nmk in varchar2 default null,
                                                       p_rnk in number default null,
                                                       p_okpo in varchar2 default null,
                                                       p_ser in varchar2 default null,
                                                       p_numdoc in varchar2 default null,
                                                       p_quality_group in varchar2 default null, /*Card, Default*/
                                                       p_percent  in number default null,  /*Процент Качества*/
                                                       p_attr_qty in number default null, /*Кол-во атрибутов для правки*/
                                                       p_branch   in varchar2 default null,
                                                       p_rn_from  in number default 1,
                                                       p_rn_to    in number default 1) return t_cust_subgrp_ebk pipelined as
begin
  for cur in ( select cast (r.rnk as number (38)) as rnk,
                      cast (r.group_id as number(1)) as group_id,
                      cast (r.id_prc_quality as number) id_prc_quality,
                      cast (r.okpo as varchar2(14)) as okpo,
                      cast(r.nmk as varchar2(70)) as nmk,
                      cast(r.quality as number(6,2)) as quality,
                      cast(r.document as varchar2(31)) as document,
                      cast(r.birth_day as varchar2(10))as birth_day,
                      cast(r.attr_qty as number ) as  attr_qty,
                      cast(r.last_card_upd as date)as last_card_upd,
                      cast( (select s.fio
                               from staff$base s, ebk_card_qlt_log l
                              where l.rnk = r.rnk
                                and l.date_updated = r.last_card_upd
                                and s.id = l.user_id
                                and rownum = 1) as varchar2(60)) as last_user_upd,
                      r.branch
              from (select teru.rnk,
                           teru.group_id,
                           nvl(p_prc_quality_id,ebkc_wforms_utl.get_subgrp (teru.group_id,teru.quality)) as id_prc_quality,
                           teru.okpo,
                           teru.nmk,
                           teru.quality,
                          cast( (select ser || ' ' || numdoc
                              from person
                             where rnk = teru.rnk) as varchar2(31))as document,
                           cast((select to_char (bday, 'dd.mm.yyyy')
                              from person
                             where rnk = teru.rnk) as varchar2(10)) as birth_day,
                         cast( (select count (a.name)
                             from EBKC_REQ_UPDCARD_ATTR     a
                            where a.kf = teru.kf and a.rnk = teru.rnk
                              --24.09.2015 Irina Ivanova
                              --and quality <> 'C'
                              and (a.recommendvalue is not null or a.descr is not null)
                              and nvl(cust_type,ebkc_pack.get_custtype(a.rnk)) = 'P'
                              ) as number) as attr_qty,
                         cast( (select max (date_updated)
                             from ebk_card_qlt_log
                            where rnk = teru.rnk) as date )
                            as last_card_upd,
                         teru.branch
             from (select a1.* from
                             (select  a.*, rownum r__n
                                 from ( select  teru.*, c.nmk, c.okpo, c.branch
                                          from EBKC_REQ_UPDATECARD teru
                                             , CUSTOMER c
                                             , (select gl.kf as kf from dual) ss_kf
                                         where (p_rnk is null or p_rnk = c.rnk)
                                           and teru.kf = ss_kf.kf
                                           and c.rnk = teru.rnk
                                           and c.DATE_OFF is null
                                           and group_id = p_group_id
                                           --24.09.2015 Irina.Ivanova
                                           --and ebk_wforms_utl.show_card_accord_quality(ss_kf.kf, teru.rnk, p_quality_group, p_percent) = 1
                                           and exists (select 1
                                                         from EBKC_QUALITYATTR_GROUPS   g
                                                        where kf = teru.kf
                                                          and rnk = teru.rnk
                                                          and g.name = NVL(p_quality_group, 'card')
                                                          and g.quality <= nvl(p_percent, 1000)
                                                          and  nvl(cust_type,ebkc_pack.get_custtype(g.rnk)) = 'P')
                                           and (p_nmk is null or c.nmk like p_nmk)
                                           and (p_okpo is null or c.okpo = p_okpo)
                                           and (p_branch is null or c.branch = p_branch)
                                           and (p_ser||p_numdoc is null or exists    (select 1
                                                                                       from person
                                                                                       where (ser =    p_ser       or p_ser    is null)
                                                                                         and (numdoc = p_numdoc    or p_numdoc is null)
                                                                                         and rnk = c.rnk))
                                           and (p_prc_quality_id is null or ebkc_wforms_utl.get_subgrp (teru.group_id,teru.quality) = p_prc_quality_id)
                                           and (p_attr_qty  is null or   (select count (a.name) from EBKC_REQ_UPDCARD_ATTR  a
                                                                            where a.kf = teru.kf and a.rnk = teru.rnk
                                                                            --24.09.2015 Irina Ivanova
                                                                            --and quality <> 'C'
                                                                            and (a.recommendvalue is not null or a.descr is not null)
                                                                            and  nvl(cust_type,ebkc_pack.get_custtype(a.rnk)) = 'P'
                                                                            ) = p_attr_qty)
                                           and nvl(cust_type,ebkc_pack.get_custtype(c.rnk)) = 'P'
                                           order by teru.rnk ) a
                                          ) a1
                               where a1.r__n between p_rn_from and p_rn_to) teru) r

  ) loop
    pipe row(r_cust_subgrp_ebk(cur.rnk, cur.group_id, cur.id_prc_quality, cur.okpo, cur.nmk, cur.quality, cur.document, cur.birth_day, cur.attr_qty, cur.last_card_upd, cur.last_user_upd, cur.branch));
  end loop;

  return;
end get_priv_subgrp;

procedure change_master_card
( p_m_rnk          in     number
, p_new_m_rnk      in     number
) is
  l_trace  varchar2(64) := $$PLSQL_UNIT || '.change_master_card: ';
begin

  bars_audit.info(l_trace||' change master-card' || to_char(p_m_rnk) || ' to ' || to_char(p_new_m_rnk));

  -- меняем основную картку дубликатов
  -- міняємо місцями стару і нову мастер-карти
  update EBKC_DUPLICATE_GROUPS
     set m_rnk = p_new_m_rnk,
         d_rnk = m_rnk
   where m_rnk = p_m_rnk
     and d_rnk = p_new_m_rnk ;

  -- в інших карт проводимо заміну мастер-карти
  update EBKC_DUPLICATE_GROUPS
     set m_rnk = p_new_m_rnk
   where m_rnk = p_m_rnk;

end change_master_card;

  procedure ignore_card(p_m_rnk in number,
                        p_d_rnk in number ) is
  begin
   -- разрываем связь дочерней с основной
   delete EBKC_DUPLICATE_GROUPS
    where m_rnk = p_m_rnk
      and d_rnk = p_d_rnk;
  end ignore_card;

  --
  --
  --
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
    delete EBKC_DUPLICATE_GROUPS
     where m_rnk = p_rnkto
       and d_rnk = p_rnkfrom;

    bars_audit.trace( '%s.merge_2rnk: Exit.', $$PLSQL_UNIT );

  exception
    when others then
      rollback;
      raise;
  end MERGE_2RNK;

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
end EBKC_WFORMS_UTL;
/

show err;

grant EXECUTE on EBKC_WFORMS_UTL to BARS_ACCESS_DEFROLE;
