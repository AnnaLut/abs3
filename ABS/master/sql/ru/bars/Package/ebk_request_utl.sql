create or replace package EBK_REQUEST_UTL
is
  --
  -- constants
  --
  g_header_version      constant varchar2(64) := 'version 1.03  2016.08.23';

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
  
  procedure request_updatecard_mass
  ( p_batchId             in varchar2,
    p_kf                  in varchar2,
    p_rnk                 in number,
    p_anls_quality        in number,
    p_defaultGroupQuality in number,
    p_tab_attr    t_rec_ebk,
    p_rec_qlt_grp t_rec_qlt_grp
  );
  
  procedure request_clientAnls_Err
  ( p_batchId in varchar2,
    p_kf in varchar2,
    p_rec_cl_anls_err in t_rec_cl_anls_err
  );



end ebk_request_utl;
/

show err

create or replace package body EBK_REQUEST_UTL
is
    
  --
  -- constants
  --
  g_body_version  constant varchar2(64)  := 'version 1.03  2016.08.23';
  
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
   --не храним предыдущие рекомендации по конкретному kf, rnk, новый пакет стирает старые рекомендации по физ. лицу  
   --null;
    delete 
    from tmp_ebk_req_updatecard
    where kf = p_kf
      and rnk = p_rnk  
      and batchId <> p_batchId;
      if sql%rowcount > 0 then
         delete from  tmp_ebk_req_updcard_attr 
         where kf = p_kf
           and rnk = p_rnk;
      end if;
    -- сохраняем только ощибки и предупреждения   
    if p_attr_quality <> g_correct_quality then 
        insert into tmp_ebk_req_updatecard( batchId, kf , rnk, quality, defaultGroupQuality, group_id )
                                   select p_batchId, p_kf, p_rnk,  p_anls_quality, p_defaultGroupQuality
                                          ,get_group_id(p_rnk,p_kf) as group_id
                                     from dual where not exists (select null from tmp_ebk_req_updatecard 
                                                                 where batchId  = p_batchId 
                                                                   and kf = p_kf 
                                                                   and rnk = p_rnk 
                                                                );
        insert into tmp_ebk_req_updcard_attr( kf, rnk, quality, name, value, recommendValue, descr)
                                    select p_kf, p_rnk, p_attr_quality, p_attr_name, p_attr_value, p_attr_recommendVal, p_attr_descr
                                    from dual where not exists ( select null from tmp_ebk_req_updcard_attr
                                                                 where kf = p_kf
                                                                   and rnk = p_rnk
                                                                   and name = p_attr_name
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
      from tmp_ebk_req_updatecard
     where kf = p_kf
       and rnk = p_rnk  
       and batchId <> p_batchId;
    
    if sql%rowcount > 0 then
         delete from  tmp_ebk_req_updcard_attr 
         where kf = p_kf
           and rnk = p_rnk;
    end if;
    -- сохраняем только ощибки и предупреждения   
    -- только одна рекомендация может быть у реквизита 
        insert into tmp_ebk_req_updcard_attr( kf, rnk, quality, name, value, recommendValue, descr)
                                    select p_kf, p_rnk, ms.quality, ms.name, ms.value, ms.recommendvalue, ms.descr
                                    from table(p_tab_attr) ms
                                    where ms.quality <> 'C'
                                      and not exists ( select null from tmp_ebk_req_updcard_attr
                                                        where kf = p_kf
                                                          and rnk = p_rnk
                                                          and name = ms.name
                                                     );
       -- создаем мастер запись если заполнился выше детаил 
       if sql%rowcount > 0 then   
           
        insert into tmp_ebk_req_updatecard( batchId, kf , rnk, quality, defaultGroupQuality, group_id )
                                   select p_batchId, p_kf, p_rnk,  p_anls_quality, p_defaultGroupQuality
                                          ,get_group_id(p_rnk,p_kf) as group_id
                                     from dual where not exists (select null from tmp_ebk_req_updatecard 
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
  procedure request_updatecard_mass
  ( p_batchId             in varchar2,
    p_kf                  in varchar2,
    p_rnk                 in number,
    p_anls_quality        in number,
    p_defaultGroupQuality in number,
    p_tab_attr            in t_rec_ebk,
    p_rec_qlt_grp         in t_rec_qlt_grp
  ) is
    l_rnk              customer.rnk%type;
  begin
    
$if EBK_PARAMS.CUT_RNK $then
    l_rnk := EBKC_WFORMS_UTL.GET_RNK(p_rnk,p_kf);
$else
    l_rnk := p_rnk;
$end
    
    -- не храним предыдущие рекомендации по конкретному kf, rnk, 
    -- новый пакет рекомендаций стирает старые рекомендации по физ. лицу
    delete 
      from tmp_ebk_req_updcard_attr 
     where kf = p_kf
       and rnk = l_rnk
       and name in ( select name 
                       from table(p_tab_attr) b
                      where b.quality = 'C' 
                         or b.name is not null );
    
    if sql%rowcount > 0 
    then
      delete 
        from tmp_ebk_req_updatecard u
       where u.kf = p_kf
         and u.rnk = l_rnk
         and not exists ( select 1
                            from tmp_ebk_req_updcard_attr a
                           where a.kf = u.kf
                             and a.rnk = u.rnk );
    end if;
      
    -- сохраняем только ощибки и предупреждения   
    -- только одна рекомендация может быть у реквизита 
    insert
      into TMP_EBK_REQ_UPDCARD_ATTR
         ( KF, RNK, QUALITY, NAME, VALUE, RECOMMENDVALUE, DESCR)
    select p_kf, l_rnk, ms.quality, ms.name, ms.value, ms.recommendvalue, ms.descr
      from table(p_tab_attr) ms
     where ( ms.recommendvalue is not null or ms.descr is not null)
       and not exists ( select null from tmp_ebk_req_updcard_attr
                         where kf = p_kf
                           and rnk = l_rnk
                           and name = ms.name )
       and exists     ( select null -- не грузим рекомендации по которым не прописаны действия в EBK_CARD_ATTRIBUTES.ACTION
                          from ebk_card_attributes 
                         where name = ms.name
                           and action is not null);
    
    -- создаем мастер запись если заполнился выше детаил 
    if sql%rowcount > 0 
    then
      
      insert
        into TMP_EBK_REQ_UPDATECARD
           ( BATCHID, KF , RNK, QUALITY, DEFAULTGROUPQUALITY, GROUP_ID )
      select p_batchId, p_kf, l_rnk,  p_anls_quality, p_defaultGroupQuality
           , get_group_id(l_rnk,p_kf) as group_id
        from dual where not exists ( select null from tmp_ebk_req_updatecard 
                                      where kf = p_kf 
                                        and rnk = l_rnk );
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
      into ebk_quality_groups
    select s_ebk_quality_groups.nextval, g.name 
      from table(p_rec_qlt_grp) g
     where not exists ( select 1 
                          from ebk_quality_groups qg
                         where qg.qg_name = g.name );
    
    commit;
   
  exception 
    when others then
      rollback;
      raise;
  end request_updatecard_mass;
  
  --*******************************************************************************
  --
  --
  procedure request_clientAnls_Err
  ( p_batchId         in varchar2,
    p_kf              in varchar2,
    p_rec_cl_anls_err in t_rec_cl_anls_err
  ) is
    l_insert_date date default sysdate;
  begin 
    
    insert
      into EBK_CLIENT_ANALYSIS_ERRORS
         ( BATCHID, KF, RNK, CODE, MSG, INSERT_DATE ) 
    select p_batchId, p_kf, err.rnk, err.code, err.msg, l_insert_date
     from table(p_rec_cl_anls_err) err;
    
    commit;
    
  end request_clientAnls_Err;  



end EBK_REQUEST_UTL;
/

show err

grant execute on EBK_REQUEST_UTL to BARS_ACCESS_DEFROLE;
