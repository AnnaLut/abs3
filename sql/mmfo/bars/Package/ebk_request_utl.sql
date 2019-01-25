create or replace package EBK_REQUEST_UTL
is
  --
  -- constants
  --
  g_header_version      constant varchar2(64) := 'version 1.10  2018.07.25';

  g_correct_quality     constant char(1) := 'C';
  g_non_correct_quality constant char(1) := 'N';
  g_non_warning_quality constant char(1) := 'W';
  
  function get_group_id
  ( p_rnk  in number
  , p_kf   in varchar2
  ) return number;

  procedure REQUEST_UPDATECARD_MASS
  ( p_batchId             in varchar2,
    p_kf                  in varchar2,
    p_rnk                 in number,
    p_anls_quality        in number,
    p_defaultGroupQuality in number,
    p_tab_attr    t_rec_ebk,
    p_rec_qlt_grp t_rec_qlt_grp
  );

  procedure REQUEST_UPDATECARD_MASS
  ( p_batchId             in varchar2
  , p_mod_tms             in timestamp with time zone -- modificationTimestamp
  , p_kf                  in varchar2
  , p_rnk                 in number
  , p_cust_tp             in varchar2
  , p_anls_quality        in number
  , p_defaultGroupQuality in number
  , p_tab_attr            in t_rec_ebk
  );

  procedure REQUEST_DUPLICATE_MASS
  ( p_batchId          in     varchar2
  , p_kf               in     varchar2
  , p_rnk              in     number
  , p_duplicate_ebk    in     t_duplicate_ebk
  );

  procedure REQUEST_GCIF_MASS
  ( p_batchId          in     varchar2
  , p_mod_tms          in     timestamp with time zone -- modificationTimestamp
  , p_kf               in     varchar2
  , p_rnk              in     number
  , p_cust_tp          in     varchar2
  , p_gcif             in     varchar2
  , p_slave_client_ebk in     t_slave_client_ebk
  );

  procedure REQUEST_DEL_GCIF
  ( p_gcif             in     varchar2
  );

  procedure SYNC_CUST_CARD
  ( p_rnk              in     customer.rnk%type
  );

  --
  -- Запуск завдання по коду філіалу (МФО)
  --
  procedure RUN_TASK_BY_KF
  ( p_start_id         in     number
  , p_end_id           in     number
  , p_pcd_nm           in     varchar2
  );

  --
  --
  --
  procedure SYNC_CUST_CARDS;

  procedure SYNC_CARDS
  ( p_start_id         in     number
  , p_end_id           in     number
  , p_kf               in     varchar2
  );

  --
  -- Виклик WEB сервісу надсилання даних до ЄБК
  --
  procedure SEND_CUST_CARDS;

end EBK_REQUEST_UTL;
/

show err

----------------------------------------------------------------------------------------------------

create or replace package body EBK_REQUEST_UTL
is
  
  --
  -- constants
  --
  g_body_version  constant varchar2(64) := 'version 1.15  2018.08.22';
  g_cust_tp       constant varchar2(1)  := 'I'; -- ebkc_gcif.cust_type
  g_tms_fmt       constant varchar2(32) := 'DD.MM.YYYY HH24:MI:SSxFF TZH:TZM';

  --
  --
  --
  l_ebk_mod_tms            timestamp with time zone;
  l_abs_mod_tms            timestamp with time zone;
  l_dop                    pls_integer;

  --
  --
  --
  e_task_not_found       exception;
  pragma exception_init( e_task_not_found, -29498 );

  --
  -- GET_GROUP_ID
  --
  function get_group_id
  ( p_rnk  in number
  , p_kf   in varchar2
  ) return number
  is
    l_group_id number;
  begin
    select case when exists (select null from w4_acc w, accounts a  where w.acc_pk = a.acc and a.dazs is null  and a.rnk = p_rnk and a.kf = p_kf) then 1 --bank_card
                when exists (select null from cc_deal cc where cc.rnk = p_rnk and cc.kf = p_kf and cc.sos not in (0,2,14,15) ) then 2 --credit
                when exists (select null from dpt_deposit dd where dd.rnk = p_rnk and dd.kf=p_kf) then 3 --deposit  
                when exists (select null from accounts ac where ac.rnk = p_rnk and ac.kf = p_kf and ac.dazs is null and nbs='2620') then 4 --current_account
                else 5 end ----other
      into l_group_id
      from dual;
    return l_group_id;
  end get_group_id;


  --
  --
  --
  procedure REQUEST_UPDATECARD_MASS
  ( p_batchId             in varchar2,
    p_kf                  in varchar2,
    p_rnk                 in number,
    p_anls_quality        in number,
    p_defaultGroupQuality in number,
    p_tab_attr            in t_rec_ebk,
    p_rec_qlt_grp         in t_rec_qlt_grp
  ) is
    title      constant   varchar2(64) := $$PLSQL_UNIT||'.REQUEST_UPDATECARD_MASS';
    l_rnk                 ebkc_req_updatecard.rnk%type;
  begin

    bars_audit.trace( '%s: Entry with ( p_kf=%s, p_rnk=%s, p_anls_quality=%s ).'
                    , title, p_kf, to_char(p_rnk), to_char(p_anls_quality), to_char(p_defaultGroupQuality) );

    case
    when ( p_kf is null )
    then raise_application_error( -20666,'Value for parameter [p_kf] must be specified!', true );
    when ( p_rnk is null )
    then raise_application_error( -20666,'Value for parameter [p_rnk] must be specified!', true );
    else null;
    end case;

$if EBK_PARAMS.CUT_RNK $then
    l_rnk := EBKC_WFORMS_UTL.GET_RNK(p_rnk,p_kf);

    BC.SET_POLICY_GROUP('WHOLE');
$else
    l_rnk := p_rnk;
$end

    -- не храним предыдущие рекомендации по конкретному kf, rnk, 
    -- новый пакет рекомендаций стирает старые рекомендации по физ. лицу
    delete EBKC_REQ_UPDCARD_ATTR -- tmp_ebk_req_updcard_attr 
     where KF        = p_kf
       and RNK       = l_rnk
       and CUST_TYPE = g_cust_tp
       and name in ( select name 
                       from table(p_tab_attr) b
                      where b.quality = 'C' 
                         or b.name is not null );
    
    if sql%rowcount > 0 
    then
      delete EBKC_REQ_UPDATECARD u -- tmp_ebk_req_updatecard
       where u.kf        = p_kf
         and u.rnk       = l_rnk
         and u.CUST_TYPE = g_cust_tp
         and not exists ( select 1
                            from EBKC_REQ_UPDCARD_ATTR a -- tmp_ebk_req_updcard_attr
                           where a.KF        = u.KF
                             and a.RNK       = u.RNK
                             and a.CUST_TYPE = u.CUST_TYPE
                        );
    end if;
      
    -- сохраняем только ощибки и предупреждения   
    -- только одна рекомендация может быть у реквизита 
    insert
      into EBKC_REQ_UPDCARD_ATTR -- TMP_EBK_REQ_UPDCARD_ATTR
         ( KF, RNK, QUALITY, NAME, VALUE, RECOMMENDVALUE, DESCR, CUST_TYPE )
    select p_kf, l_rnk, ms.quality, ms.name, ms.value, ms.recommendvalue, ms.descr, g_cust_tp
      from table(p_tab_attr) ms
     where ( ms.recommendvalue is not null or ms.descr is not null)
       and not exists ( select null 
                          from EBKC_REQ_UPDCARD_ATTR -- tmp_ebk_req_updcard_attr
                         where KF        = p_kf
                           and RNK       = l_rnk
                           and CUST_TYPE = g_cust_tp
                           and NAME      = ms.name )
       and exists     ( select null -- не грузим рекомендации по которым не прописаны действия в EBK_CARD_ATTRIBUTES.ACTION
                          from EBK_CARD_ATTRIBUTES
                         where name = ms.name
                           and action is not null);
    
    -- создаем мастер запись если заполнился выше детаил 
    if sql%rowcount > 0 
    then
      
      insert
        into EBKC_REQ_UPDATECARD
           ( BATCHID, KF , RNK, QUALITY, DEFAULTGROUPQUALITY, GROUP_ID, CUST_TYPE )
      select p_batchId, p_kf, l_rnk,  p_anls_quality, p_defaultGroupQuality
           , get_group_id(l_rnk,p_kf) as group_id
           , g_cust_tp
        from dual
       where not exists ( select null
                            from EBKC_REQ_UPDATECARD 
                           where KF        = p_kf
                             and RNK       = l_rnk
                             and CUST_TYPE = g_cust_tp
                        );
    end if;
    
    -- удаляем ранее загруженные проценты качества
    delete EBK_QUALITYATTR_GOURPS 
     where kf  = p_kf
       and rnk = l_rnk;
    
    -- сохраняем отдельно проценты качества в любом случае, т.к. далее понадобятся в дедубликации 
    -- качества приходят по всей карточке, по основной группе или по умолчанию обязательно ,
    -- а также динамически созд-ым группам 
    insert
      into EBK_QUALITYATTR_GOURPS
         ( BATCHID, KF, RNK, NAME, QUALITY )
    select p_batchId, p_kf, l_rnk, 'card',    p_anls_quality
      from dual
     union all
    select p_batchId, p_kf, l_rnk, 'default', p_defaultGroupQuality
      from dual
     union all
    select p_batchId, p_kf ,l_rnk ,gr.name, gr.quality
      from table(p_rec_qlt_grp) gr
     where gr.name is not null;
    
    -- Заполняем таблицу-справочник групп
    insert 
      into EBK_QUALITY_GROUPS
    select s_ebk_quality_groups.nextval, g.name 
      from table(p_rec_qlt_grp) g
     where not exists ( select 1 
                          from ebk_quality_groups qg
                         where qg.qg_name = g.name );

    commit;

$if EBK_PARAMS.CUT_RNK $then
    bc.set_context;
$end

    bars_audit.trace( '%s: Exit.', title );

  exception
    when others then
      rollback;
$if EBK_PARAMS.CUT_RNK $then
      bc.set_context;
$end
      bars_audit.error( title || ': p_batch='||p_batchid||', p_kf='||p_kf||', p_rnk='||to_char(p_rnk) );
      bars_audit.error( title || ': ' || dbms_utility.format_error_stack() || dbms_utility.format_error_backtrace() );
      raise_application_error( -20666, title || ': ' || SQLERRM, true );
  end REQUEST_UPDATECARD_MASS;

  --
  -- REQUEST_UPDATECARD_MASS
  --
  procedure REQUEST_UPDATECARD_MASS
  ( p_batchId             in     varchar2
  , p_mod_tms             in     TIMESTAMP WITH TIME ZONE -- modificationTimestamp
  , p_kf                  in     varchar2
  , p_rnk                 in     number
  , p_cust_tp             in     varchar2
  , p_anls_quality        in     number
  , p_defaultGroupQuality in     number
  , p_tab_attr            in     t_rec_ebk
  ) is
    title           constant     varchar2(64) := $$PLSQL_UNIT||'.REQUEST_UPDATECARD_MASS';
    l_rnk                        customer.rnk%type;
  begin

    bars_audit.trace( '%s: Entry with ( p_kf=%s, p_rnk=%s, p_mod_tms=%s, p_cust_tp=%s, p_tab_attr.count=%s ).', title
                    , p_kf, to_char(p_rnk), to_char(p_mod_tms,g_tms_fmt), p_cust_tp, to_char(p_tab_attr.count) );

    case
    when ( p_kf is null )
    then raise_application_error( -20666,'Value for parameter [p_kf] must be specified!', true );
    when ( p_rnk is null )
    then raise_application_error( -20666,'Value for parameter [p_rnk] must be specified!', true );
    when ( p_mod_tms is null )
    then raise_application_error( -20666,'Value for parameter [p_mod_tms] must be specified!', true );
    when ( p_cust_tp is null )
    then raise_application_error( -20666,'Value for parameter [p_cust_tp] must be specified!', true );
    else null;
    end case;

$if EBK_PARAMS.CUT_RNK $then
    l_rnk := EBKC_WFORMS_UTL.GET_RNK(p_rnk,p_kf);

    BC.SET_POLICY_GROUP('WHOLE');
$else
    l_rnk := p_rnk;
$end

    -- validate p_mod_tms
    select max(MOD_TMS)
      into l_ebk_mod_tms
      from EBKC_REQ_UPDATECARD -- TMP_EBK_REQ_UPDATECARD
     where KF  = p_kf
       and RNK = l_rnk;

    bars_audit.trace( '%s: ( l_rnk=%s, l_ebk_mod_tms=%s ).', title, to_char(l_rnk), to_char(l_ebk_mod_tms,g_tms_fmt) );

    if ( ( l_ebk_mod_tms Is Null ) or ( l_ebk_mod_tms < p_mod_tms ) )
    then

      -- не храним предыдущие рекомендации по конкретному KF, RNK, 
      -- новый пакет рекомендаций стирает старые рекомендации
      delete EBKC_REQ_UPDCARD_ATTR -- TMP_EBK_REQ_UPDCARD_ATTR
       where KF        = p_kf
         and RNK       = l_rnk
         and CUST_TYPE = p_cust_tp
         and NAME in ( select NAME
                         from table(p_tab_attr) b
                        where b.quality = 'C'
                           or b.name is not null );

      if ( sql%rowcount > 0 )
      then
        delete EBKC_REQ_UPDATECARD u -- TMP_EBK_REQ_UPDATECARD
         where u.kf  = p_kf
           and u.rnk = l_rnk
           and not exists ( select 1
                              from EBKC_REQ_UPDCARD_ATTR a -- TMP_EBK_REQ_UPDCARD_ATTR
                             where a.KF  = u.kf
                               and a.RNK = u.rnk );
      end if;

      merge
       into EBKC_REQ_UPDATECARD r -- TMP_EBK_REQ_UPDATECARD
      using DUAL
         on ( r.KF = p_kf and r.RNK = l_rnk )
       when matched 
       then update
               set r.BATCHID  = p_batchId
                 , r.MOD_TMS  = p_mod_tms
                 , r.QUALITY  = p_anls_quality
                 , r.GROUP_ID = GET_GROUP_ID(l_rnk,p_kf)
       when NOT MATCHED
       then insert ( BATCHID, KF, RNK, MOD_TMS, QUALITY, DEFAULTGROUPQUALITY, GROUP_ID )
            values ( p_batchId, p_kf, l_rnk, p_mod_tms, p_anls_quality, p_defaultGroupQuality, GET_GROUP_ID(l_rnk,p_kf) );

      if ( p_tab_attr.count > 0 )
      then

        insert
          into EBKC_REQ_UPDCARD_ATTR -- TMP_EBK_REQ_UPDCARD_ATTR
             ( KF, RNK, QUALITY, NAME, VALUE, RECOMMENDVALUE, DESCR, CUST_TYPE )
        select p_kf, l_rnk, ms.quality, ms.name, ms.value, ms.recommendvalue, ms.descr, p_cust_tp
          from table(p_tab_attr) ms
         where ( ms.recommendvalue is not null or ms.descr is not null)
           and not exists ( select null
                              from EBKC_REQ_UPDCARD_ATTR -- TMP_EBK_REQ_UPDCARD_ATTR
                             where kf = p_kf
                               and rnk = l_rnk
                               and name = ms.name )
           and exists     ( select null -- не грузим рекомендации по которым не прописаны действия в EBK_CARD_ATTRIBUTES.ACTION
                              from EBKC_CARD_ATTRIBUTES
                             where name = ms.name
                               and action is not null );

      end if;

      -- удаляем ранее загруженные проценты качества
      delete EBKC_QUALITYATTR_GROUPS -- EBK_QUALITYATTR_GOURPS
       where kf  = p_kf
         and rnk = l_rnk;

      -- сохраняем отдельно проценты качества в любом случае, т.к. далее понадобятся в дедубликации 
      -- качества приходят по всей карточке, по основной группе или по умолчанию обязательно ,
      -- а также динамически созд-ым группам 
      insert
        into EBKC_QUALITYATTR_GROUPS -- EBK_QUALITYATTR_GOURPS
           ( BATCHID, KF, RNK, NAME, QUALITY, CUST_TYPE )
      select p_batchId, p_kf, l_rnk, 'card',    p_anls_quality, p_cust_tp
        from dual
       union all
      select p_batchId, p_kf, l_rnk, 'default', p_defaultGroupQuality, p_cust_tp
        from dual;

      commit;

    else -- отримали застарілу інформацію від ЄБК
      bars_audit.error( title||': отримали застарілу інформацію від ЄБК ( p_kf='||p_kf||', p_rnk='||to_char(l_rnk)
                             ||', p_ebk_mod_tms='||to_char(p_mod_tms,    'yyyy/mm/dd hh24:mi:ssxff tzh:tzm')
                             ||', l_ebk_mod_tms='||to_char(l_ebk_mod_tms,'yyyy/mm/dd hh24:mi:ssxff tzh:tzm') );
    end if;

$if EBK_PARAMS.CUT_RNK $then
    bc.set_context;
$end

    bars_audit.trace( '%s: Exit.', title );

  exception
    when others then
      rollback;
$if EBK_PARAMS.CUT_RNK $then
      bc.set_context;
$end
      bars_audit.error( title || ': p_batch='||p_batchid||', p_kf='||p_kf||', p_rnk='||to_char(p_rnk) );
      bars_audit.error( title || ': ' || dbms_utility.format_error_stack() || chr(10) || dbms_utility.format_error_backtrace() );
      raise_application_error( -20666, title || ': ' || SQLERRM, true );
  end REQUEST_UPDATECARD_MASS;

  --
  -- REQUEST_DUPLICATE_MASS
  --
  procedure REQUEST_DUPLICATE_MASS
  ( p_batchId       in varchar2,
    p_kf            in varchar2,
    p_rnk           in number,
    p_duplicate_ebk in t_duplicate_ebk
  ) is
    l_rnk              customer.rnk%type;
  begin

$if EBK_PARAMS.CUT_RNK $then
    l_rnk := EBKC_WFORMS_UTL.GET_RNK(p_rnk,p_kf);
$else
    l_rnk := p_rnk;
$end

    merge
     into EBKC_DUPLICATE t1 -- TMP_EBK_DUP_CLIENT
    using ( select p_kf  as KF
                 , l_rnk as RNK
                 , KF as DUP_KF
$if EBK_PARAMS.CUT_RNK $then
                 , EBKC_WFORMS_UTL.GET_RNK( RNK, KF ) as DUP_RNK
$else
                 , RNK as DUP_RNK
$end
                 , g_cust_tp as CUST_TYPE
              from table( p_duplicate_ebk )
          ) t2
       on ( t1.KF        = t2.KF      and
            t1.RNK       = t2.RNK     and
            t1.DUP_KF    = t2.DUP_KF  and
            t1.DUP_RNK   = t2.DUP_RNK and
            t1.CUST_TYPE = t2.CUST_TYPE )
    when not matched
    then insert ( KF, RNK, DUP_KF, DUP_RNK, CUST_TYPE )
         values ( t2.KF, t2.RNK, t2.DUP_KF, t2.DUP_RNK, t2.CUST_TYPE );

    commit;

  end REQUEST_DUPLICATE_MASS;

  --
  -- REQUEST_GCIF_MASS
  --
  procedure REQUEST_GCIF_MASS
  ( p_batchId          in     varchar2
  , p_mod_tms          in     TIMESTAMP WITH TIME ZONE -- modificationTimestamp
--, p_abs_mod_tms      in     TIMESTAMP WITH TIME ZONE -- lastChangeDt
  , p_kf               in     varchar2
  , p_rnk              in     number
  , p_cust_tp          in     varchar2
  , p_gcif             in     varchar2
  , p_slave_client_ebk in     t_slave_client_ebk
  ) is
    title      constant   varchar2(64) := $$PLSQL_UNIT||'.REQUEST_GCIF_MASS';
    l_sys_dt              ebkc_gcif.insert_date%type := sysdate;
    l_rnk                 ebkc_gcif.rnk%type;
  begin

    bars_audit.trace( '%s: Entry with ( p_kf=%s, p_rnk=%s, p_cust_tp=%s, p_gcif=%s, p_mod_tms=%s, p_slave_client.count=%s ).'
                    , title, p_kf, to_char(p_rnk), p_cust_tp, p_gcif, to_char(p_mod_tms,g_tms_fmt), to_char(p_slave_client_ebk.count) );

    case
    when ( p_kf is null )
    then raise_application_error( -20666,'Value for parameter [p_kf] must be specified!', true );
    when ( p_rnk is null )
    then raise_application_error( -20666,'Value for parameter [p_rnk] must be specified!', true );
    when ( p_gcif is null )
    then raise_application_error( -20666,'Value for parameter [p_gcif] must be specified!', true );
    when ( p_mod_tms is null )
    then raise_application_error( -20666,'Value for parameter [p_mod_tms] must be specified!', true );
    when ( p_cust_tp is null )
    then raise_application_error( -20666,'Value for parameter [p_cust_tp] must be specified!', true );
    else null;
    end case;

$if EBK_PARAMS.CUT_RNK $then
    l_rnk := EBKC_WFORMS_UTL.GET_RNK(p_rnk,p_kf);

    BC.SET_POLICY_GROUP('WHOLE');
$else
    l_rnk := p_rnk;
$end

    -- validate p_mod_tms
    begin
      select g.EBK_MOD_TMS, g.ABS_MOD_TMS
        into l_ebk_mod_tms, l_abs_mod_tms
        from EBKC_GCIF g
       where g.RNK = l_rnk;
    exception
      when NO_DATA_FOUND then
        l_ebk_mod_tms := null;
        l_abs_mod_tms := null;
    end;

    bars_audit.trace( '%s: ( l_rnk=%s, l_ebk_mod_tms=%s ).', title, to_char(l_rnk), to_char(l_ebk_mod_tms,g_tms_fmt) );

    if ( ( l_ebk_mod_tms Is Null ) or ( l_ebk_mod_tms < p_mod_tms ) )
    then

      -- перед загрузкой мастер-записи с GCIF-ом и подчиненных записей, 
      -- необходимо очистить старую загрузку подчиненных карточек по этой же мастер карточке,
      -- т.к. могли быть добавлены или уделены некоторые и записиваем присланную актуальную структуру

      delete EBKC_GCIF
       where RNK = l_rnk
          or ( KF = p_kf and GCIF = p_gcif );

      insert
        into EBKC_GCIF
           ( KF, RNK, GCIF, CUST_TYPE, INSERT_DATE, EBK_MOD_TMS )
      values
          ( p_kf, l_rnk, p_gcif, p_cust_tp, l_sys_dt, p_mod_tms );

      if ( p_slave_client_ebk.count > 0 )
      then

        begin

          merge
           into EBKC_GCIF t1
          using ( select KF
$if EBK_PARAMS.CUT_RNK $then
                       , EBKC_WFORMS_UTL.GET_RNK( RNK, KF ) as RNK
$else
                       , RNK
$end
                    from table( p_slave_client_ebk )
                ) t2
             on ( t1.RNK = t2.RNK )
           when matched
           then update
                   set GCIF        = p_gcif
                     , KF          = t2.KF
                     , CUST_TYPE   = p_cust_tp
                     , INSERT_DATE = l_sys_dt
                     , EBK_MOD_TMS = p_mod_tms
           when not matched
           then insert ( KF, RNK, GCIF, CUST_TYPE, INSERT_DATE, EBK_MOD_TMS )
                values ( t2.KF, t2.RNK, p_gcif, p_cust_tp, l_sys_dt, p_mod_tms );

        exception
          when OTHERS
          then bars_audit.error( title||': '||dbms_utility.format_error_stack() );
        end;

      end if;

      commit;

    else -- отримали застарілу інформацію від ЄБК
      bars_audit.error( title||': отримали застарілу інформацію від ЄБК ( p_kf='||p_kf||', p_rnk='||to_char(l_rnk)
                             ||', p_ebk_mod_tms='||to_char(p_mod_tms,    'yyyy/mm/dd hh24:mi:ssxff tzh:tzm')
                             ||', l_ebk_mod_tms='||to_char(l_ebk_mod_tms,'yyyy/mm/dd hh24:mi:ssxff tzh:tzm') );
    end if;

    if ( ( l_abs_mod_tms Is Null ) or ( l_abs_mod_tms > p_mod_tms ) )
    then -- Якщо «Дата модифікації в АБС» більша ніж «Дата модифікації в ЄБК»
      -- надсилаємо таку картку в ЄБК (через пакетний інтерфейс)
      EBKC_WFORMS_UTL.ADD_RNK_QUEUE( l_rnk, p_cust_tp, p_kf );
    end if;

$if EBK_PARAMS.CUT_RNK $then
    bc.set_context;
$end

    bars_audit.trace( '%s: Exit.', title );

  exception
    when others then
      rollback;
$if EBK_PARAMS.CUT_RNK $then
      bc.set_context;
$end
      bars_audit.error( title || ': p_batch='||p_batchid||', p_kf='||p_kf||', p_rnk='||to_char(p_rnk)||', p_gcif='||p_gcif );
      bars_audit.error( title || ': ' || dbms_utility.format_error_stack() || chr(10) || dbms_utility.format_error_backtrace() );
      raise_application_error( -20666, title || ': ' || SQLERRM, true );
  end REQUEST_GCIF_MASS;

  --
  -- REQUEST_DEL_GCIF
  --
  procedure REQUEST_DEL_GCIF
  ( p_gcif   in   varchar2
  ) is
  begin

    -- возможно нужны будут проверки к какому rnk принадлежал gcif
    -- по идеи раз присвоенній gcif к конкретной карточке не может быть переведен к другой карточке

    -- удаляем запись о глоб. идент.
    delete EBKC_GCIF
     where GCIF = p_gcif;

    commit;

  exception 
    when others then
      rollback;
      raise_application_error( -20666, $$PLSQL_UNIT||'.REQUEST_DEL_GCIF: '||sqlerrm, true );
  end REQUEST_DEL_GCIF;

  --
  -- SYNC_CUST_CARD
  --
  procedure SYNC_CUST_CARD
  ( p_rnk              in     customer.rnk%type
  ) is
    /**
    <b>SYNC_CUST_CARD</b> - Виклик WEB сервісу синхронізації даних клієнта з ЄБК
    %param
  
    %version  2.1
    %date     2017.12.01
    %modifier BAA
    %usage
    */
    title          constant   varchar2(64) := $$PLSQL_UNIT||'.SYNC_CUST_CARD';
    g_actn_nm      constant   varchar2(32) := 'SyncCard';

    l_url                     varchar2(128);
    l_ahr_val                 varchar2(128);
    l_wallet_path             varchar2(128);
    l_wallet_pwd              varchar2(128);
    l_response                wsm_mgr.t_response;
  
    --
    -- Возвращает параметр из web_config
    --
    function get_param_webconfig
    ( par    varchar2
    ) return web_barsconfig.val%type
    is
      l_res web_barsconfig.val%type;
    begin
      select val into l_res from web_barsconfig where key = par;
      return trim(l_res);
    exception
      when no_data_found then
        raise_application_error( -20000, 'Не найден KEY=' || par || ' в таблице web_barsconfig!' );
    end get_param_webconfig;
    ---
  begin

    bars_audit.trace( '%s.: Entry with ( p_pnk=%s ).', title, to_char(p_rnk) );

    l_url     := get_param_webconfig('EBK.Url'); -- branch_attribute_utl.get_value( 'ABSBARS_WEB_IP_ADRESS' );
    l_ahr_val := get_param_webconfig('EBK.UserPassword');
    l_ahr_val := 'Basic ' || utl_raw.cast_to_varchar2(utl_encode.base64_encode(utl_raw.cast_to_raw('wbarsebk:'||l_ahr_val)));

    bars_audit.trace( '%s: ( l_url=%s, l_ahr_val=%s ).', title, l_url, l_ahr_val );

    -- SSL соединение выполняем через wallet
    if ( instr(lower(l_url), 'https://') > 0 )
    then
      l_wallet_path := get_param_webconfig('EBK.WalletDir');
      l_wallet_pwd  := get_param_webconfig('EBK.WalletPass');
      utl_http.set_wallet( l_wallet_path, l_wallet_pwd );
    end if;
  
    for x in ( select KF, RNK
                    , case
                      when ( c.CUSTTYPE = 2 ) then 'corp'
                      when ( c.CUSTTYPE = 3 and c.K050 = '910' ) then 'personspd'
                      else 'person'
                      end as CUSTTYPE
                 from CUSTOMER c
                where c.RNK = p_rnk
             )
    loop

      bars_audit.trace( '%s: RNK=%s,', title, to_char(x.rnk) );

      begin

        wsm_mgr.prepare_request
        ( p_url          => l_url,
          p_action       => g_actn_nm,
          p_http_method  => wsm_mgr.g_http_get,
          p_content_type => wsm_mgr.g_ct_json,
          p_wallet_path  => l_wallet_path,
          p_wallet_pwd   => l_wallet_pwd );

        wsm_mgr.add_header( p_name => 'Authorization', p_value => l_ahr_val );

        wsm_mgr.add_parameter( p_name => 'kf',       p_value => x.kf );
        wsm_mgr.add_parameter( p_name => 'rnk',      p_value => to_char( EBK_WFORMS_UTL.CUT_RNK( x.RNK ) ) );
        wsm_mgr.add_parameter( p_name => 'custtype', p_value => x.CUSTTYPE );

        wsm_mgr.execute_request(l_response);

      exception
        when others then
          bars_audit.error( title ||': '|| sqlerrm );
      end;

    end loop;

    bars_audit.trace( '%s: Exit.', title );

  end SYNC_CUST_CARD;

  --
  --
  --
  procedure RUN_TASK_BY_KF
  ( p_start_id         in     number
  , p_end_id           in     number
  , p_pcd_nm           in     varchar2
  ) is
  /**
  <b>RUN_TASK_BY_KF</b> - Запуск завдання по коду філіалу (МФО)
  %param p_start_id - Ід. РУ
  %param p_end_id   - Ід. РУ
  %param p_pcd_nm   - Назва процедури

  %version 1.0
  %usage   Виконання завдань в паралельному режимі (по діапазону МФО)
  */
    title            constant varchar2(64) := $$PLSQL_UNIT||'.RUN_TASK_BY_KF';
    
    -- COBUMMFO-9690 Begin
    l_module         varchar2(64);
    l_action         varchar2(64);
    -- COBUMMFO-9690 End
  begin

    bars_audit.trace( '%s: Entry with ( p_start_id=%s, p_end_id=%s, p_pcd_nm=%s ).'
                    , title, to_char(p_start_id), to_char(p_end_id), p_pcd_nm );

    if ( p_pcd_nm Is Null )
    then
      null;
    else

      dbms_application_info.read_module(l_module, l_action); -- COBUMMFO-9690

      dbms_application_info.set_action( title );

      for c in ( select f.KF
                   from MV_KF f
                   join REGIONS r
                     on ( r.KF = f.KF )
                  where r.ID between p_start_id and p_end_id )
      loop

        dbms_application_info.set_client_info( 'KF='||c.KF );

        BARS_CONTEXT.SUBST_MFO( c.KF );

        case p_pcd_nm
        when 'SEND_CUST_CARDS'
        then
          SEND_CUST_CARDS();
        when 'SYNC_CUST_CARDS'
        then
          SYNC_CUST_CARDS();
        else
          execute immediate 'begin '||p_pcd_nm||'; end;';
        end case;

      end loop;

      BARS_CONTEXT.SET_CONTEXT();

      dbms_application_info.set_client_info( null );
      dbms_application_info.set_action( l_action /*null -- COBUMMFO-9690*/ );

    end if;

    bars_audit.trace( '%s: Exit.', title );

  end RUN_TASK_BY_KF;

  --
  --
  --
  procedure SYNC_CARDS
  ( p_start_id         in     number
  , p_end_id           in     number
  , p_kf               in     varchar2
  ) is
    /**
    <b>SYNC_CARDS</b> - Виклик WEB сервісу синхронізації даних клієнта з ЄБК
    %param
  
    %version  1.0
    %date     2018.06.20
    %modifier BAA
    %usage
    */
    title            constant varchar2(64) := $$PLSQL_UNIT||'.SYNC_CARDS';

    l_url                     varchar2(128);
    l_ahr_val                 varchar2(128);
    l_wallet_path             varchar2(128);
    l_wallet_pwd              varchar2(128);
    l_response                wsm_mgr.t_response;
    l_rec_id                  ebk_sync_log.id%type;
    l_err_msg                 ebk_sync_log.err_msg%type;

    -- COBUMMFO-9690 Begin
    l_module         varchar2(64);
    l_action         varchar2(64);
    -- COBUMMFO-9690 End

    function get_param_webconfig
    ( par    varchar2
    ) return web_barsconfig.val%type
    is
      l_res web_barsconfig.val%type;
    begin
      select val into l_res from web_barsconfig where key = par;
      return trim(l_res);
    exception
      when no_data_found then
        raise_application_error( -20000, 'Не найден KEY=' || par || ' в таблице web_barsconfig!' );
    end get_param_webconfig;

  begin

    bars_audit.trace( '%s: Entry with ( p_start_id=%s, p_end_id=%s, p_kf=%s ).'
                    , title, to_char(p_start_id), to_char(p_end_id), p_kf );

    BARS_CONTEXT.SUBST_MFO( p_kf );

    l_url     := get_param_webconfig('EBK.Url'); -- branch_attribute_utl.get_value( 'ABSBARS_WEB_IP_ADRESS' );
    l_ahr_val := get_param_webconfig('EBK.UserPassword');
    l_ahr_val := 'Basic ' || utl_raw.cast_to_varchar2(utl_encode.base64_encode(utl_raw.cast_to_raw('wbarsebk:'||l_ahr_val)));

    bars_audit.trace( '%s: ( l_url=%s, l_ahr_val=%s ).', title, l_url, l_ahr_val );

    -- SSL соединение выполняем через wallet
    if ( instr(lower(l_url), 'https://') > 0 )
    then
      l_wallet_path := get_param_webconfig('EBK.WalletDir');
      l_wallet_pwd  := get_param_webconfig('EBK.WalletPass');
      utl_http.set_wallet( l_wallet_path, l_wallet_pwd );
      bars_audit.trace( '%s: ( l_wallet_path=%s, l_wallet_pwd=%s ).', title, l_wallet_path, l_wallet_pwd );
    end if;

    dbms_application_info.read_module(l_module, l_action); -- COBUMMFO-9690

    dbms_application_info.set_action( title );

    for c in ( select KF, CUST_ID, CUST_TP
                 from V_EBK_SYNC_Q
                where CUST_ID between p_start_id and p_end_id )
    loop

      dbms_application_info.set_client_info( 'CUST_ID='||to_char(c.CUST_ID) );

      insert
        into EBK_SYNC_LOG
           ( CUST_ID, CUST_TP, SYNC_ST, STRT_TM, ID )
      values
           ( c.CUST_ID, c.CUST_TP, 0, systimestamp, S_EBK_SYNC_LOG.NEXTVAL )
      return ID
        into l_rec_id;

      begin

        wsm_mgr.prepare_request
        ( p_url          => l_url,
          p_action       => 'SyncCard',
          p_http_method  => wsm_mgr.g_http_get,
          p_content_type => wsm_mgr.g_ct_json,
          p_wallet_path  => l_wallet_path,
          p_wallet_pwd   => l_wallet_pwd );

        wsm_mgr.add_header( p_name => 'Authorization', p_value => l_ahr_val );

        wsm_mgr.add_parameter( p_name => 'kf',       p_value => c.KF );
        wsm_mgr.add_parameter( p_name => 'rnk',      p_value => to_char( EBK_WFORMS_UTL.CUT_RNK( c.CUST_ID ) ) );
        wsm_mgr.add_parameter( p_name => 'custtype', p_value => c.CUST_TP );

        wsm_mgr.execute_request(l_response);

        l_err_msg := trim(l_response.cdoc);

        case l_err_msg
        when '"ERROR"'
        then l_err_msg := 'Помилка зв`язку з віддаленим сервісом ЄБК';
        when '"0"'
        then l_err_msg := 'Відповідь сервісу ЄБК не містить даних клієнта.';
        else l_err_msg := null;
        end case;

      exception
        when others then
          l_err_msg := sqlerrm;
          bars_audit.error( title || ': ' || l_err_msg || dbms_utility.format_error_backtrace() );
      end;

      update EBK_SYNC_LOG
         set FNSH_TM = systimestamp
           , SYNC_ST = nvl2( l_err_msg, -1, 1 )
           , ERR_MSG = l_err_msg
       where ID = l_rec_id;

      commit;

    end loop;

    BARS_CONTEXT.SET_CONTEXT();

    dbms_application_info.set_client_info( null );
    dbms_application_info.set_action( l_action /*null -- COBUMMFO-9690*/ );

    bars_audit.trace( '%s: Exit.', title );

  end SYNC_CARDS;


  procedure SYNC_CUST_CARDS
  is
    /**
    <b>SYNC_CUST_CARDS</b> - Виклик WEB сервісу синхронізації даних клієнта з ЄБК
    %param
  
    %version  1.0
    %date     2018.06.20
    %modifier BAA
    %usage
    */
    title       constant   varchar2(64) := $$PLSQL_UNIT||'.SYNC_CUST_CARDS';

    l_kf                   varchar2(6) := sys_context('bars_context','user_mfo');
    l_task_nm              varchar2(30);
    l_sql_stmt             varchar2(4000);

  begin

    bars_audit.trace( '%s.: Entry with ( l_kf=%s ).', title, to_char(l_kf) );

    if ( l_kf Is Null )
    then -- for all KF

      l_task_nm := 'SYNC_CUST_CARDS';

      begin
        DBMS_PARALLEL_EXECUTE.drop_task( task_name => l_task_nm );
      exception
        when e_task_not_found
        then null;
      end;

      DBMS_PARALLEL_EXECUTE.create_task( task_name => l_task_nm );

      l_sql_stmt := 'select ID, ID from REGIONS r join MV_KF f on ( f.KF = r.KF )';
--    l_sql_stmt := 'select min(ID), max(ID)'
--               || '  from ( select ID, ntile('||to_char(l_dop)||') over (order by ID) as GRP_ID'
--               || '           from REGIONS r join MV_KF f on ( f.KF = r.KF ) ) group by GRP_ID';

      DBMS_PARALLEL_EXECUTE.create_chunks_by_sql( task_name => l_task_nm
                                                , sql_stmt  => l_sql_stmt
                                                , by_rowid  => FALSE );

      l_sql_stmt := 'begin EBK_REQUEST_UTL.RUN_TASK_BY_KF( :start_id, :end_id, ''SYNC_CUST_CARDS'' ); end;';

      DBMS_PARALLEL_EXECUTE.run_task( task_name      => l_task_nm
                                    , sql_stmt       => l_sql_stmt
                                    , language_flag  => DBMS_SQL.NATIVE
                                    , parallel_level => l_dop );

      DBMS_PARALLEL_EXECUTE.drop_task( task_name => l_task_nm );

    else -- for one KF

      begin

        l_task_nm := 'SYNC_CUST_CARDS_'||l_kf;

        begin
          DBMS_PARALLEL_EXECUTE.drop_task( task_name => l_task_nm );
        exception
          when e_task_not_found
          then null;
        end;

        DBMS_PARALLEL_EXECUTE.create_task( task_name => l_task_nm );

        l_sql_stmt := 'select min(CUST_ID), max(CUST_ID) from ( select CUST_ID, ntile('||to_char(l_dop)||
                      ') over (order by CUST_ID) as GRP_ID from V_EBK_SYNC_Q ) group by GRP_ID';

        DBMS_PARALLEL_EXECUTE.create_chunks_by_sql( task_name => l_task_nm
                                                  , sql_stmt  => l_sql_stmt
                                                  , by_rowid  => FALSE );

        l_sql_stmt := 'begin EBK_REQUEST_UTL.SYNC_CARDS( :start_id, :end_id, '''||l_kf||''' ); end;';

        DBMS_PARALLEL_EXECUTE.run_task( task_name      => l_task_nm
                                      , sql_stmt       => l_sql_stmt
                                      , language_flag  => DBMS_SQL.NATIVE
                                      , parallel_level => l_dop );

        DBMS_PARALLEL_EXECUTE.drop_task( task_name => l_task_nm );

      end;

    end if;

    bars_audit.trace( '%s: Exit.', title );

  end SYNC_CUST_CARDS;

  --
  --
  --
  procedure SEND_CUST_CARDS
  is
    /**
    <b>SEND_CUST_CARDS</b> - Виклик WEB сервісу надсилання даних до ЄБК
    %param
  
    %version  1.0
    %date     2018.07.18
    %usage
    */
    title       constant   varchar2(64) := $$PLSQL_UNIT||'.SEND_CUST_CARDS';

    l_kf                   varchar2(6) := sys_context('bars_context','user_mfo');
    l_task_nm              varchar2(30);
    l_sql_stmt             varchar2(4000);
    l_lmt_dt               date := trunc(sysdate)-14;

  begin

    bars_audit.info( title||': Entry with ( l_kf='||l_kf||' ).' );

    bars_audit.info( title||': '||to_char(sql%rowcount)||' row(s) deleted.' );

    if ( l_kf Is Null )
    then -- for all KF

      -- cleaning the queue from old records
      delete EBKC_QUEUE_UPDATECARD
       where STATUS = 9
         and INSERT_DATE < l_lmt_dt;

      l_task_nm := 'SEND_CUST_CARDS';

      begin
        DBMS_PARALLEL_EXECUTE.drop_task( task_name => l_task_nm );
      exception
        when e_task_not_found
        then null;
      end;

      DBMS_PARALLEL_EXECUTE.create_task( task_name => l_task_nm );

      l_sql_stmt := 'select ID, ID from REGIONS r join MV_KF f on ( f.KF = r.KF )';

      DBMS_PARALLEL_EXECUTE.create_chunks_by_sql( task_name => l_task_nm
                                                , sql_stmt  => l_sql_stmt
                                                , by_rowid  => FALSE );

      l_sql_stmt := 'begin EBK_REQUEST_UTL.RUN_TASK_BY_KF( :start_id, :end_id, ''SEND_CUST_CARDS'' ); end;';

      DBMS_PARALLEL_EXECUTE.run_task( task_name      => l_task_nm
                                    , sql_stmt       => l_sql_stmt
                                    , language_flag  => DBMS_SQL.NATIVE
                                    , parallel_level => l_dop );

      DBMS_PARALLEL_EXECUTE.drop_task( task_name => l_task_nm );

    else -- for one KF

      -- EBK_CARD_PACAKGES_JOB
      begin
        EBK_SENDCARDPACKAGES
        ( p_action_name => 'SendCardPackages'
        , p_cardsCount  => null
        , p_packSize    => '100' );
      exception
        when OTHERS
        then bars_audit.error( title || ': ' || sqlerrm || chr(10) || dbms_utility.format_error_backtrace() );
      end;

      -- EBKC_SEND_PRIV_CARDS
      begin
        EBK_SENDCARDPACKAGES
        ( p_action_name => 'SendCardPackagesPrivateEn'
        , p_cardsCount  => null
        , p_packSize    => '100' );
      exception
        when OTHERS
        then bars_audit.error( title || ': ' || sqlerrm || chr(10) || dbms_utility.format_error_backtrace() );
      end;

      -- EBKC_SEND_LEGAL_CARDS
      begin
        EBK_SENDCARDPACKAGES
        ( p_action_name => 'SendCardPackagesLegal'
        , p_cardsCount  => null
        , p_packSize    => '100' );
      exception
        when OTHERS
        then bars_audit.error( title || ': ' || sqlerrm || chr(10) || dbms_utility.format_error_backtrace() );
      end;

    end if;

    bars_audit.trace( '%s: Exit.', title );

  end SEND_CUST_CARDS;



begin
  l_dop := 8;
end EBK_REQUEST_UTL;
/

show err

grant execute on EBK_REQUEST_UTL to BARS_ACCESS_DEFROLE;
