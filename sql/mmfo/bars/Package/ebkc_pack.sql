
 
 PROMPT ===================================================================================== 
 PROMPT *** Run *** ========== Scripts /Sql/BARS/package/ebkc_pack.sql =========*** Run *** =
 PROMPT ===================================================================================== 
 
  CREATE OR REPLACE PACKAGE BARS.EBKC_PACK 
is

  g_header_version constant varchar2(64) := 'version 1.00 31/04/2016';

  -- ���� �볺���, �� ���������������� � ��� ����
  LEGAL_PERSON      constant varchar2(1) := 'L';   -- ��.�����
  PRIVATE_ENT       constant varchar2(1) := 'P';   -- ���

  -- header_version - ���������� ������ ��������� ������
  function header_version return varchar2;
  -- body_version - ���������� ������ ���� ������
  function body_version return varchar2;

  procedure save_into_hist(p_rnk in number);

  procedure clear_queue_rnk(p_rnk in number);

  function get_custtype(p_rnk in number) return varchar2;

  procedure sendcard_save_event(p_rnk in number);

  function get_wparam(p_key in varchar2) return varchar2;

  function get_group_id(p_rnk in number,
                      p_kf in varchar2) return number ;

  function get_last_modifc_date(p_rnk in number) return date;

  procedure send_request(
      p_action     in varchar2,
      p_session_id in integer,
      p_parameters in varchar2_list,
      p_values     in varchar2_list);

  procedure request_legal_dup_mass(p_batchId in varchar2,
                   p_kf in varchar2,
                   p_rnk in number,
                   p_duplicate_ebk in t_duplicate_ebk);

  procedure request_private_dup_mass(p_batchId in varchar2,
                   p_kf in varchar2,
                   p_rnk in number,
                   p_duplicate_ebk in t_duplicate_ebk);

  procedure request_legal_gcif_mass(p_batchId in varchar2,
                            p_kf in varchar2,
                            p_rnk in number,
                            p_gcif in varchar2,
                            p_slave_client_ebk in t_slave_client_ebk);

  procedure request_private_gcif_mass(p_batchId in varchar2,
                            p_kf in varchar2,
                            p_rnk in number,
                            p_gcif in varchar2,
                            p_slave_client_ebk in t_slave_client_ebk);

  procedure request_legal_updatecard_mass(p_batchId in varchar2,
                             p_kf in varchar2,
                             p_rnk in number,
                             p_anls_quality in number,
                             p_defaultGroupQuality in number,
                             p_tab_attr  t_rec_ebk,
                             p_rec_qlt_grp t_rec_qlt_grp);

  procedure request_private_updcard_mass(p_batchId in varchar2,
                             p_kf in varchar2,
                             p_rnk in number,
                             p_anls_quality in number,
                             p_defaultGroupQuality in number,
                             p_tab_attr  t_rec_ebk,
                             p_rec_qlt_grp t_rec_qlt_grp);

  procedure create_group_duplicate;

end EBKC_PACK;
/
CREATE OR REPLACE PACKAGE BODY BARS.EBKC_PACK 
is

  -- ����� ������
  g_body_version constant varchar2(64) := 'version 1.01 15/02/2017';
  g_dbgcode constant varchar2(20)      := 'ebkc_pack';

  -- header_version - ���������� ������ ��������� ������
  function header_version return varchar2 is
  begin
    return 'Package header ' || g_dbgcode || ' ' || g_header_version || '.';
  end header_version;

  -- body_version - ���������� ������ ���� ������
  function body_version return varchar2 is
  begin
    return 'Package body '   || g_dbgcode || ' ' || g_body_version || '.';
  end body_version;

  --
  --
  --
  function is_legal_pers
  ( p_rnk  in     number
  ) return boolean
  is
    -- l_legal       boolean := false;
    -- cursor c_legal
    -- is
    -- select null
    --   from customer
    --   where rnk = p_rnk
    --     and custtype = 2;
    -- r_legal c_legal%ROWTYPE;
  begin
    -- OPEN c_legal;
    -- FETCH c_legal INTO r_legal;
    -- l_legal := c_legal%FOUND;
    -- CLOSE c_legal;
    for x in ( select 0
                 from customer
                where rnk = p_rnk
                  and custtype = 2 )
    loop
     return true;
    end loop;

    return false;

  end is_legal_pers;

  --
  --
  --
  function is_private_ent( p_rnk in number
  ) return boolean
  is
  begin
    for x in ( select 0
                 from customer
                where rnk = p_rnk
                  and custtype = 3
                  and sed = '91  ' )
    loop
      return true;
    end loop;

    return false;

  end is_private_ent;

  function get_custtype(p_rnk in number) return varchar2 is
  l_ret varchar2(1);
  begin
    if    is_legal_pers(p_rnk)  then l_ret := LEGAL_PERSON;
    elsif is_private_ent(p_rnk) then l_ret := PRIVATE_ENT;
    end if;
    return l_ret;
  end get_custtype;

  procedure save_into_hist(p_rnk in number) is
  begin
    insert into ebkc_sendcards_hist(rnk) values(p_rnk);
  end;

  procedure clear_queue_rnk(p_rnk in number) is
  begin
    delete from ebkc_queue_updatecard where rnk = p_rnk and status = 0;
  end;

  -- !!! ��� ��� ����� person_update, ��� �� corps_update
  function get_last_modifc_date(p_rnk in number) return date
  is
  begin
    for x in ( select greatest( ( select trunc(max(cu.chgdate))
                                    from bars.customer_update cu
                                   where rnk = p_rnk )
                              , ( select trunc(max(cwu.chgdate))
                                    from bars.customerw_update cwu
                                   where rnk = p_rnk )
                              , ( select trunc(max(pu.chgdate))
                                    from bars.corps_update pu
                                   where rnk = p_rnk )
                              , ( select trunc(max(pu.chgdate))
                                    from bars.person_update pu
                                   where rnk = p_rnk )
                              ) as last_modifc_date from dual )
    loop
      return x.last_modifc_date;
    end loop;

  end get_last_modifc_date;

  procedure sendcard_save_event(p_rnk in number) is
  begin
    save_into_hist(p_rnk);
    clear_queue_rnk(p_rnk);
  end;

  function get_wparam(p_key in varchar2) return varchar2
  is
      l_value varchar2(4000 byte);
  begin
      select t.val
        into l_value
        from web_barsconfig t
       where t.key = p_key;

       return l_value;
  exception
      when no_data_found then
           return null;
  end;

  procedure send_request
  ( p_action     in varchar2,
    p_session_id in integer,
    p_parameters in varchar2_list,
    p_values     in varchar2_list
  ) is
    l_url               varchar2(4000 byte);
    l_walett_path       varchar2(4000 byte);
    l_walett_pass       varchar2(4000 byte);
    l_bars_login        varchar2(50 char);
    l_authorization_val varchar2(4000 byte);
    l_response          wsm_mgr.t_response;
    l integer;
  begin
      l_url := get_wparam('BARS_WS_URL');
      l_walett_path := get_wparam('BARS_WS_WALLET_PATH');
      l_walett_pass := get_wparam('BARS_WS_WALLET_PASS');
      l_bars_login := get_wparam('BARS_WS_LOGIN');

      if (l_bars_login is not null) then
          l_authorization_val := 'Basic ' || utl_raw.cast_to_varchar2(
                                      utl_encode.base64_encode(
                                          utl_raw.cast_to_raw(
                                              l_bars_login || ':' || get_wparam('BARS_WS_PASS'))));
      end if;

      if (substr(l_url, length(l_url)) <> '/') then
          l_url := l_url || '/';
      end if;

      bars.wsm_mgr.prepare_request(p_url          => l_url,
                                   p_action       => p_action || '?sessionid=' || p_session_id,
                                   p_http_method  => bars.wsm_mgr.G_HTTP_POST,
                                   p_content_type => bars.wsm_mgr.G_CT_JSON,
                                   p_wallet_path  => l_walett_path,
                                   p_wallet_pwd   => l_walett_pass);

      if (l_authorization_val is not null) then
          bars.wsm_mgr.add_header(p_name  => 'Authorization',
                                  p_value => l_authorization_val);
      end if;

      if (p_parameters is not null and p_parameters is not empty) then
          l := p_parameters.first;
          while (l is not null) loop
              bars.wsm_mgr.add_parameter(p_name  => p_parameters(l), p_value => p_values(l));

              l := p_parameters.next(l);
          end loop;
      end if;

    bars.wsm_mgr.execute_request(l_response);

  end;

  --
  -- !!! ������ ���������� ����� � ��������� �� ����
  --
  function get_group_id
  ( p_rnk in number,
    p_kf  in varchar2
  ) return number
  is
    l_group_id number;
  begin
    select 1  -- ��� �� � ��� ���� �����
      into l_group_id
      from dual;

   return l_group_id;
  end get_group_id;

  --
  -- �������� �� ��,��� ������� �� �����
  --
  procedure request_dup_mass
  ( p_batchId in varchar2,
    p_kf in varchar2,
    p_rnk in number,
    p_custtype in varchar2,
    p_duplicate_ebk in t_duplicate_ebk
  ) is
    l_rnk               customer.rnk%type;
  begin

$if EBK_PARAMS.CUT_RNK $then
    l_rnk := EBKC_WFORMS_UTL.GET_RNK(p_rnk,p_kf);
$else
    l_rnk := p_rnk;
$end

    bars_audit.info('save received dublicate for rnk='||l_rnk);

    insert
      into ebkc_duplicate
         ( KF, RNK, DUP_KF, DUP_RNK, CUST_TYPE )
    select p_kf, l_rnk, dup.kf, dup.rnk, p_custtype
      from table (p_duplicate_ebk) dup
     where not exists ( select null
                          from ebkc_duplicate
                         where kf  = p_kf
                           and rnk = l_rnk
                           and dup_kf = dup.kf
                           and rnk = dup.rnk );
  end request_dup_mass;

  --
  -- �������� �� ��, ������� �� �����
  --
  procedure request_legal_dup_mass(p_batchId in varchar2,
                     p_kf in varchar2,
                     p_rnk in number,
                     p_duplicate_ebk in t_duplicate_ebk) is
  begin
    request_dup_mass (p_batchId, p_kf, p_rnk, 'L', p_duplicate_ebk);
  end request_legal_dup_mass;

  --
  -- �������� �� ���, ������� �� �����
  --
  procedure request_private_dup_mass(p_batchId in varchar2,
                     p_kf in varchar2,
                     p_rnk in number,
                     p_duplicate_ebk in t_duplicate_ebk) is
  begin
    request_dup_mass (p_batchId, p_kf, p_rnk, 'P', p_duplicate_ebk);
  end request_private_dup_mass;

  --
  -- gcif �� ��,��� ������� �� �����
  --
  procedure request_gcif_mass
  ( p_batchId          in     varchar2,
    p_kf               in     varchar2,
    p_rnk              in     number,
    p_gcif             in     varchar2,
    p_custtype         in     varchar2,
    p_slave_client_ebk in     t_slave_client_ebk
  ) is
    l_sysdate                 date;
    l_rnk                     customer.rnk%type;
  begin

    l_sysdate := sysdate;

$if EBK_PARAMS.CUT_RNK $then
    l_rnk := EBKC_WFORMS_UTL.GET_RNK(p_rnk,p_kf);
$else
    l_rnk := p_rnk;
$end

    -- ����� ��������� ������-������  � GCIF - �� � ����������� �������,
    -- ���������� �������� ������ �������� ����������� �������� �� ���� �� ������ ��������,
    -- �.�. ����� ���� ��������� ��� ������� ���������

    delete from ebkc_slave
    where gcif = p_gcif
       or gcif = (select gcif from ebkc_gcif where kf = p_kf and rnk = l_rnk) ;

    delete from ebkc_gcif
     where (kf = p_kf and rnk = l_rnk)
        or (gcif = p_gcif);

    -- ���������� ���������� ���������� ���������
   insert into ebkc_gcif(kf, rnk, gcif, insert_date, cust_type)
   values (p_kf, l_rnk, p_gcif, l_sysdate, p_custtype);

   insert
     into ebkc_slave
        ( gcif, slave_kf, slave_rnk, cust_type )
   select p_gcif, sce.kf, sce.rnk, p_custtype
    from table (p_slave_client_ebk) sce
   where not exists ( select null from ebkc_slave
                       where gcif = p_gcif
                         and slave_kf = sce.kf
                         and slave_rnk = sce.rnk
                         and cust_type = p_custtype );
    commit;

  exception
    when others then
      rollback;
      raise;
  end request_gcif_mass;

  --
  --
  --
  procedure request_legal_gcif_mass(p_batchId in varchar2,
                              p_kf in varchar2,
                              p_rnk in number,
                              p_gcif in varchar2,
                              p_slave_client_ebk in t_slave_client_ebk) is
  begin
    request_gcif_mass(p_batchId, p_kf, p_rnk, p_gcif, 'L', p_slave_client_ebk);
  end request_legal_gcif_mass;

  --
  --
  --
  procedure request_private_gcif_mass(p_batchId in varchar2,
                              p_kf in varchar2,
                              p_rnk in number,
                              p_gcif in varchar2,
                              p_slave_client_ebk in t_slave_client_ebk) is
  begin
    request_gcif_mass(p_batchId, p_kf, p_rnk, p_gcif, 'P', p_slave_client_ebk);
  end request_private_gcif_mass;

  --
  --
  --
  procedure request_updatecard_mass
  ( p_batchId             in     varchar2,
    p_kf                  in     varchar2,
    p_rnk                 in     number,
    p_anls_quality        in     number,
    p_defaultGroupQuality in     number,
    p_custtype            in     varchar2,
    p_tab_attr            in     t_rec_ebk,
    p_rec_qlt_grp         in     t_rec_qlt_grp
  ) is
    l_rnk               customer.rnk%type;
  begin

$if EBK_PARAMS.CUT_RNK $then
    l_rnk := EBKC_WFORMS_UTL.GET_RNK(p_rnk,p_kf);
$else
    l_rnk := p_rnk;
$end

    -- �� ������ ���������� ������������ �� ����������� kf, rnk,
    -- ����� ����� ������������ ������� ������ ������������ ��
    bars_audit.info('process recommendation for rnk='||l_rnk);

    --�������� ������������ ����� ������������
    delete from ebkc_req_updcard_attr
     where kf = p_kf
       and rnk = l_rnk
       and cust_type = p_custtype
       and name in (select name
                      from table(p_tab_attr) b
                     where b.quality = 'C'
                        or b.name is not null);

    if sql%rowcount > 0 then
       delete
         from ebkc_req_updatecard u
        where u.kf = p_kf
          and u.rnk = l_rnk
          and not exists (select 1
                            from ebkc_req_updcard_attr a
                           where a.kf = u.kf
                             and a.rnk = u.rnk);
    end if;

    -- ��������� ������ ������ � ��������������
    -- ������ ���� ������������ ����� ���� � ���������
        insert into ebkc_req_updcard_attr( kf, rnk, quality, name, value, recommendValue, descr, cust_type)
                                    select p_kf, l_rnk, ms.quality, ms.name, ms.value, ms.recommendvalue, ms.descr, p_custtype
                                    from table(p_tab_attr) ms
                                    where --ms.quality <> 'C'
                                      (ms.recommendvalue is not null or ms.descr is not null)
                                      and not exists ( select null from ebkc_req_updcard_attr
                                                        where kf = p_kf
                                                          and rnk = l_rnk
                                                          and name = ms.name
                                                     )
                                      -- !!! ��� ����� - �������� ���!
                                      --and exists -- �� ������ ������������ �� ������� �� ��������� ��������  � EBKC_CARD_ATTRIBUTES.ACTION
                                      --        ( select null from ebkc_card_attributes where name = ms.name and action is not null and cust_type = p_custtype)
                                              ;
       -- ������� ������ ������ ���� ���������� ���� ������
       if sql%rowcount > 0 then

        insert into ebkc_req_updatecard( batchId, kf , rnk, quality, defaultGroupQuality, group_id )
                                   select p_batchId, p_kf, l_rnk,  p_anls_quality, p_defaultGroupQuality
                                          ,get_group_id(l_rnk,p_kf) as group_id
                                     from dual where not exists (select null from ebkc_req_updatecard
                                                                  where kf = p_kf
                                                                    and rnk = l_rnk
                                                                );
        end if;
    -- ������� ����� ����������� �������� ��������
    delete from ebkc_qualityattr_groups
     where kf = p_kf and rnk = l_rnk;
    -- ��������� �������� �������� �������� � ����� ������, �.�. ����� ����������� � ������������
    -- �������� �������� �� ���� ��������, �� �������� ������ ��� �� ��������� ����������� ,
    -- � ����� ����������� ����-�� �������
    insert into ebkc_qualityattr_groups( batchid ,kf ,rnk , name , quality, cust_type )
     select p_batchId, p_kf, l_rnk , 'card', p_anls_quality, p_custtype  from dual
     union all
     select p_batchId, p_kf, l_rnk, 'default', p_defaultGroupQuality, p_custtype  from dual
     union all
     select p_batchId, p_kf ,l_rnk ,gr.name, gr.quality, p_custtype from table(p_rec_qlt_grp) gr
     where gr.name is not null;

    --��������� �������-���������� �����
    insert into  ebkc_quality_groups
    select s_ebk_quality_groups.nextval, g.name, p_custtype
      from table(p_rec_qlt_grp) g
     where not exists (select 1
                         from ebkc_quality_groups qg
                        where qg.qg_name = g.name and cust_type= p_custtype);

    --commit;
   exception
     when others then rollback; raise;
  end request_updatecard_mass;

  --
  --
  --
  procedure request_legal_updatecard_mass
  ( p_batchId in varchar2,
    p_kf in varchar2,
    p_rnk in number,
    p_anls_quality in number,
    p_defaultGroupQuality in number,
    p_tab_attr  t_rec_ebk,
    p_rec_qlt_grp t_rec_qlt_grp
  ) is
  begin
    request_updatecard_mass(p_batchId, p_kf, p_rnk, p_anls_quality, p_defaultGroupQuality,  'L', p_tab_attr,p_rec_qlt_grp);
  end request_legal_updatecard_mass;

  --
  --
  --
  procedure request_private_updcard_mass
  ( p_batchId in varchar2,
    p_kf in varchar2,
    p_rnk in number,
    p_anls_quality in number,
    p_defaultGroupQuality in number,
    p_tab_attr  t_rec_ebk,
    p_rec_qlt_grp t_rec_qlt_grp
  ) is
  begin
    request_updatecard_mass(p_batchId, p_kf, p_rnk, p_anls_quality, p_defaultGroupQuality,  'P', p_tab_attr,p_rec_qlt_grp);
  end request_private_updcard_mass;

  --
  -- run from JOB
  --
  procedure create_group_duplicate
  is
    l_trace  varchar2(500) := g_dbgcode || 'create_group_duplicate: ';
    l_kf varchar2(6);
    l_cycle integer;
    l_lock VARCHAR2(30);
    l_status NUMBER;
    ---
    procedure create_group_duplicate_kf
    is
    begin

      bars_audit.info(l_trace||' Entry with KF='||l_kf);

      for r in ( select distinct rnk
                   from ebkc_duplicate
                  where kf = l_kf
                     or kf = dup_kf
                  order by rnk )
      loop

        dbms_application_info.set_client_info(l_trace|| ' set MC for rnk=' || r.rnk);

        -- ������������� �������� ��������
        -- ����� �� ������� �����c���� - �������,���� ��������� �����������, �������� ������ �������
        for x in ( select rnk, dup_rnk,  product_id, last_modifc_date, quality
                        , row_number() over (partition by rnk order by product_id asc, last_modifc_date desc nulls last ,quality desc) as master_queue
                        from ( select d.rnk, d.dup_rnk
                                      , ebkc_pack.get_group_id(d.dup_rnk, l_kf)   as product_id
                                      , ebkc_pack.get_last_modifc_date(d.dup_rnk) as last_modifc_date
                                      , nvl( (select max(quality)
                                                from EBKC_QUALITYATTR_GROUPS
                                               where kf = l_kf
                                                 and rnk = d.dup_rnk
                                                 and name = 'card'), 0 ) as quality
                               from ( select distinct rnk, dup_rnk
                                        from ebkc_duplicate
                                       where rnk=r.rnk
                                         and kf = l_kf
                                       union
                                      select distinct rnk, rnk as dup_rnk
                                        from ebkc_duplicate
                                       where rnk=r.rnk
                                         and kf = l_kf
                                    ) d
                             )
                    )
        loop

            bars_audit.trace(l_trace||'set master card for rnk = %s, dup_rnk = %s, last_modifc_date=%s, quality=%s, master_card=%s',
                               to_char(x.rnk), to_char(x.dup_rnk), to_char(x.last_modifc_date), to_char(x.quality), to_char(x.master_queue));
            if x.master_queue = 1
            then -- ��� ���� �������� ��������
               update ebkc_duplicate
               set rnk = x.dup_rnk
               where rnk = x.rnk;

               update ebkc_duplicate
               set dup_rnk = x.rnk
               where rnk = x.dup_rnk and dup_rnk = x.dup_rnk;
            end if;
          end loop;
      end loop;

      bars_audit.info(l_trace||' Exit.');

    end create_group_duplicate_kf;
    ---
  begin

    bars_audit.info(l_trace||' Start');

    l_kf := sys_context('bars_context','user_mfo');

    -- ������ ���� ������� ����� ���� �������
    dbms_lock.allocate_unique('LegalDuplicateGroups', l_lock);
    l_status := dbms_lock.request(l_lock, dbms_lock.x_mode,180,true);

    bars_audit.trace('dbms_lock status for LegalDuplicateGroups = %s', to_char(l_status));

    if l_status = 0
    THEN
      -- ��������� ������� � ������������ ����������� �� ����� �������� �����
      -- ����� �������� ����� ������� �� ������ ����������� � �������� ����� � ����������� �������
      lock table ebkc_duplicate in exclusive mode;

      -- -- ������� �������� �� ����� ��
      -- delete from ebkc_duplicate where kf <> l_kf or kf<> dup_kf;

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

      -- ��������� �������� ������������
      insert into ebkc_duplicate_groups (m_rnk, d_rnk, cust_type, kf)
      select distinct rnk, dup_rnk, cust_type, kf
        from ebkc_duplicate
       where rnk <> dup_rnk
         and not exists (select null from ebkc_duplicate_groups where m_rnk = rnk and d_rnk = dup_rnk );

      --������� �� ������������
      delete from ebkc_duplicate;

      --������� �� �������� ��������
      delete from ebkc_duplicate_groups e
       where exists ( select null from customer where rnk = e.d_rnk and date_off is not null);

     commit; --��������, ������������ ebkc_duplicate �� ����������

   end if;
   l_status := dbms_lock.release(l_lock);
   bars_audit.info(l_trace||' finished');
   exception
     when others then
       rollback;
       raise;
  end create_group_duplicate;



begin
  null;
end EBKC_PACK;
/
 show err;
 
PROMPT *** Create  grants  EBKC_PACK ***
grant EXECUTE                                                                on EBKC_PACK       to BARS_ACCESS_DEFROLE;

 
 
 PROMPT ===================================================================================== 
 PROMPT *** End *** ========== Scripts /Sql/BARS/package/ebkc_pack.sql =========*** End *** =
 PROMPT ===================================================================================== 
 