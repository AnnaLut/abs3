create or replace package EBK_REQUEST_UTL
is
  --
  -- constants
  --
  g_header_version      constant varchar2(64) := 'version 1.08  2017.12.01';

  g_correct_quality     constant char(1) := 'C';
  g_non_correct_quality constant char(1) := 'N';
  g_non_warning_quality constant char(1) := 'W';
  
  function get_group_id
  ( p_rnk  in number
  , p_kf   in varchar2
  ) return number;
  
  -- *******************
  -- * Не используется *
  -- *******************
  -- procedure request_updatecard
  -- ( p_batchId in varchar2,
  --   p_kf in varchar2,
  --   p_rnk in number,
  --   p_anls_quality in number,
  --   p_defaultGroupQuality in number,
  --   p_attr_quality in varchar2,
  --   p_attr_name in varchar2,
  --   p_attr_value in varchar2,
  --   p_attr_recommendVal in varchar2,
  --   p_attr_descr in varchar2
  -- );
  
  -- *******************
  -- * не используется *
  -- *******************
  -- procedure request_updatecard_mass_old
  -- ( p_batchId in varchar2,
  --   p_kf in varchar2,
  --   p_rnk in number,
  --   p_anls_quality in number,
  --   p_defaultGroupQuality in number,
  --   p_tab_attr  t_rec_ebk
  -- );
  
  procedure REQUEST_UPDATECARD_MASS
  ( p_batchId             in varchar2,
    p_kf                  in varchar2,
    p_rnk                 in number,
    p_anls_quality        in number,
    p_defaultGroupQuality in number,
    p_tab_attr    t_rec_ebk,
    p_rec_qlt_grp t_rec_qlt_grp
  );

  -- *******************
  -- * Не используется *
  -- *******************
  -- procedure request_clientAnls_Err
  -- ( p_batchId in varchar2,
  --   p_kf in varchar2,
  --   p_rec_cl_anls_err in t_rec_cl_anls_err
  -- );

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

end EBK_REQUEST_UTL;
/

show err

----------------------------------------------------------------------------------------------------

create or replace package body EBK_REQUEST_UTL
is
  
  --
  -- constants
  --
  g_body_version  constant varchar2(64) := 'version 1.10  2018.03.03';
  g_cust_tp       constant varchar2(1)  := 'I'; -- ebkc_gcif.cust_type
  g_tms_fmt       constant varchar2(32) := 'DD.MM.YYYY HH24:MI:SSxFF TZH:TZM';

  --
  --
  --
  l_mod_tms                timestamp with time zone;

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
  
  --************************************************
  --!!! Не используется
  --************************************************
  procedure request_updatecard(p_batchId in varchar2,
                               p_kf in varchar2,
                               p_rnk in number,
                               p_anls_quality in number,
                               p_defaultGroupQuality in number,
                               p_attr_quality in varchar2,
                               p_attr_name in varchar2,
                               p_attr_value in varchar2,
                               p_attr_recommendVal in varchar2,
                               p_attr_descr in varchar2) is
  begin

    -- не храним предыдущие рекомендации по конкретному kf, rnk, новый пакет стирает старые рекомендации по физ. лицу  
    delete EBKC_REQ_UPDATECARD -- tmp_ebk_req_updatecard
     where KF        = p_kf
       and RNK       = p_rnk
       and CUST_TYPE = g_cust_tp
       and batchId  != p_batchId;

    if sql%rowcount > 0 
    then
      delete EBKC_REQ_UPDCARD_ATTR -- tmp_ebk_req_updcard_attr 
       where KF        = p_kf
         and RNK       = p_rnk
         and CUST_TYPE = g_cust_tp;
    end if;

    -- сохраняем только ощибки и предупреждения
    if p_attr_quality <> g_correct_quality
    then

      insert 
        into EBKC_REQ_UPDATECARD -- tmp_ebk_req_updatecard
           ( BATCHID, KF , RNK, QUALITY, DEFAULTGROUPQUALITY, GROUP_ID, CUST_TYPE )
      select p_batchId, p_kf, p_rnk,  p_anls_quality, p_defaultGroupQuality
           , get_group_id(p_rnk,p_kf) as group_id, g_cust_tp
        from DUAL 
       where not exists ( select null 
                            from EBKC_REQ_UPDATECARD -- tmp_ebk_req_updatecard 
                           where BATCHID   = p_batchId
                             and KF        = p_kf
                             and RNK       = p_rnk
                             and CUST_TYPE = g_cust_tp
                         );

      insert 
        into EBKC_REQ_UPDCARD_ATTR -- tmp_ebk_req_updcard_attr
          ( KF, RNK, QUALITY, NAME, VALUE, RECOMMENDVALUE, DESCR, CUST_TYPE )
      select p_kf, p_rnk, p_attr_quality, p_attr_name, p_attr_value, p_attr_recommendVal, p_attr_descr, g_cust_tp
        from DUAL 
       where not exists ( select null
                            from EBKC_REQ_UPDCARD_ATTR -- tmp_ebk_req_updcard_attr
                           where KF        = p_kf
                             and RNK       = p_rnk
                             and CUST_TYPE = g_cust_tp
                             and NAME      = p_attr_name
                         );
    end if;
    commit;
  exception
     when others then rollback; raise;
  end request_updatecard;
  
  -- ******************************************************************************
  -- !!! не используется
  -- ******************************************************************************
  procedure request_updatecard_mass_old(p_batchId in varchar2,
                               p_kf in varchar2,
                               p_rnk in number,
                               p_anls_quality in number,
                               p_defaultGroupQuality in number,
                               p_tab_attr  t_rec_ebk) is
  begin
    -- не храним предыдущие рекомендации по конкретному kf, rnk, новый пакет стирает старые рекомендации по физ. лицу  
    delete 
      from EBKC_REQ_UPDATECARD -- tmp_ebk_req_updatecard
     where kf = p_kf
       and rnk = p_rnk  
       and batchId <> p_batchId;
    
    if sql%rowcount > 0
    then
      delete EBKC_REQ_UPDCARD_ATTR -- tmp_ebk_req_updcard_attr 
       where kf  = p_kf
         and rnk = p_rnk;
    end if;
    -- сохраняем только ощибки и предупреждения   
    -- только одна рекомендация может быть у реквизита 
        insert into EBKC_REQ_UPDCARD_ATTR -- tmp_ebk_req_updcard_attr
        ( kf, rnk, quality, name, value, recommendValue, descr)
                                    select p_kf, p_rnk, ms.quality, ms.name, ms.value, ms.recommendvalue, ms.descr
                                    from table(p_tab_attr) ms
                                    where ms.quality <> 'C'
                                      and not exists ( select null 
                                                         from EBKC_REQ_UPDCARD_ATTR -- tmp_ebk_req_updcard_attr
                                                        where kf = p_kf
                                                          and rnk = p_rnk
                                                          and name = ms.name
                                                     );
       -- создаем мастер запись если заполнился выше детаил 
       if sql%rowcount > 0 then   
           
        insert into EBKC_REQ_UPDATECARD -- tmp_ebk_req_updatecard
        ( batchId, kf , rnk, quality, defaultGroupQuality, group_id )
                                   select p_batchId, p_kf, p_rnk,  p_anls_quality, p_defaultGroupQuality
                                          ,get_group_id(p_rnk,p_kf) as group_id
                                     from dual where not exists (select null 
                                                                   from EBKC_REQ_UPDATECARD -- tmp_ebk_req_updatecard 
                                                                  where batchId  = p_batchId 
                                                                    and kf = p_kf 
                                                                    and rnk = p_rnk 
                                                                );
        end if;
    commit;
   exception 
     when others then rollback; raise;
  end request_updatecard_mass_old;
  
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

    bars_audit.trace( '%s: Exit.', title );

  exception
    when others then
      rollback;
      bars_audit.error( title || ': p_batch='||p_batchid||', p_kf='||p_kf||', p_rnk='||to_char(p_rnk) );
      bars_audit.error( title || ': ' || dbms_utility.format_error_stack() || chr(10) || dbms_utility.format_error_backtrace() );
      raise_application_error( -20666, title || ': ' || SQLERRM, true );
  end request_updatecard_mass;

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
      into l_mod_tms
      from EBKC_REQ_UPDATECARD -- TMP_EBK_REQ_UPDATECARD
     where KF  = p_kf
       and RNK = l_rnk;

    bars_audit.trace( '%s: ( l_rnk=%s, l_mod_tms=%s ).', title, to_char(l_rnk), to_char(l_mod_tms,g_tms_fmt) );

    if ( ( l_mod_tms Is Null ) or ( l_mod_tms < p_mod_tms ) )
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
      null;
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
      select MOD_TMS
        into l_mod_tms
        from EBKC_GCIF
       where RNK = l_rnk;
    exception
      when NO_DATA_FOUND then
        l_mod_tms := null;
    end;

    bars_audit.trace( '%s: ( l_rnk=%s, l_mod_tms=%s ).', title, to_char(l_rnk), to_char(l_mod_tms,g_tms_fmt) );

    if ( ( l_mod_tms Is Null ) or ( l_mod_tms < p_mod_tms ) )
    then

      -- перед загрузкой мастер-записи с GCIF-ом и подчиненных записей, 
      -- необходимо очистить старую загрузку подчиненных карточек по этой же мастер карточке,
      -- т.к. могли быть добавлены или уделены некоторые и записиваем присланную актуальную структуру

      delete EBKC_GCIF
       where RNK = l_rnk
          or ( KF = p_kf and GCIF = p_gcif );

      insert 
        into EBKC_GCIF
           ( KF, RNK, GCIF, CUST_TYPE, INSERT_DATE, MOD_TMS )
      values
          ( p_kf, l_rnk, p_gcif, p_cust_tp, l_sys_dt, p_mod_tms );

--      if ( p_slave_client_ebk.count > 0 )
--      then

--        merge
--         into EBKC_GCIF t1
--        using ( select p_gcif as GCIF
--                     , KF as SLAVE_KF
--$if EBK_PARAMS.CUT_RNK $then
--                     , EBKC_WFORMS_UTL.GET_RNK( RNK, KF ) as SLAVE_RNK
--$else
--                     , RNK as SLAVE_RNK
--$end
--                     , p_cust_tp as CUST_TYPE
--                  from table( p_slave_client_ebk )
--              ) t2
--           on ( t1.GCIF      = t2.GCIF      and
--                t1.SLAVE_KF  = t2.SLAVE_KF  and
--                t1.SLAVE_RNK = t2.SLAVE_RNK and
--                t1.CUST_TYPE = t2.CUST_TYPE )
--         when not matched
--         then insert ( GCIF, SLAVE_KF, SLAVE_RNK, CUST_TYPE )
--              values ( t2.GCIF, t2.SLAVE_KF, t2.SLAVE_RNK, t2.CUST_TYPE );

--      end if;

      commit;

    else -- отримали застарілу інформацію від ЄБК
      null;
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

  --*******************************************************************************
  --
  --
  procedure request_clientAnls_Err
  ( p_batchId         in varchar2,
    p_kf              in varchar2,
    p_rec_cl_anls_err in t_rec_cl_anls_err
  ) is
    l_insert_date        date := sysdate;
  begin 
    
    insert
      into EBK_CLIENT_ANALYSIS_ERRORS
         ( BATCHID, KF, RNK, CODE, MSG, INSERT_DATE ) 
    select p_batchId, p_kf, err.rnk, err.code, err.msg, l_insert_date
     from table(p_rec_cl_anls_err) err;
    
    commit;
    
  end request_clientAnls_Err;

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
    function f_get_param_webconfig
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
    end f_get_param_webconfig;
    ---
  begin

    bars_audit.trace( '%s.: Entry with ( p_pnk=%s ).', title, to_char(p_rnk) );

    l_url     := f_get_param_webconfig('EBK.Url'); -- branch_attribute_utl.get_value( 'ABSBARS_WEB_IP_ADRESS' );
    l_ahr_val := f_get_param_webconfig('EBK.UserPassword');
    l_ahr_val := 'Basic ' || utl_raw.cast_to_varchar2(utl_encode.base64_encode(utl_raw.cast_to_raw('wbarsebk:'||l_ahr_val)));

    bars_audit.trace( '%s: ( l_url=%s, l_ahr_val=%s ).', title, l_url, l_ahr_val );

    -- SSL соединение выполняем через wallet
    if ( instr(lower(l_url), 'https://') > 0 )
    then
      l_wallet_path := f_get_param_webconfig('EBK.WalletDir');
      l_wallet_pwd  := f_get_param_webconfig('EBK.WalletPass');
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
        wsm_mgr.add_parameter( p_name => 'rnk',      p_value => to_char(x.rnk) );
        wsm_mgr.add_parameter( p_name => 'custtype', p_value => x.CUSTTYPE );
  
        wsm_mgr.execute_request(l_response);
  
      exception
        when others then
          bars_audit.error( title ||': '|| sqlerrm );
      end;
  
    end loop;
  
    bars_audit.trace( '%s: Exit.', title );
  
  end SYNC_CUST_CARD;



begin
  null;
end ebk_request_utl;
/

show err

grant execute on ebk_request_utl to bars_access_defrole;
