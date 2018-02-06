create or replace package EBK_DUP_REQUEST_UTL
is

  procedure request_duplicate_mass
  ( p_batchId          in     varchar2,
    p_kf               in     varchar2,
    p_rnk              in     number,
    p_duplicate_ebk    in     t_duplicate_ebk );

  procedure request_gcif_mass
  ( p_batchId          in     varchar2,
    p_kf               in     varchar2,
    p_rnk              in     number,
    p_gcif             in     varchar2,
    p_slave_client_ebk in     t_slave_client_ebk );

  procedure request_del_gcif
  ( p_gcif             in     varchar2 );

end EBK_DUP_REQUEST_UTL;
/

show err

create or replace package body EBK_DUP_REQUEST_UTL
is
  --
  -- constants
  --
  g_body_version  constant   varchar2(64)  := 'version 1.06  2018.01.19';
  g_cust_tp       constant   ebkc_gcif.cust_type%type := 'I';

  --
  --
  --
  procedure request_duplicate_mass
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
    
    insert
      into TMP_EBK_DUP_CLIENT
         ( KF, RNK, DUP_KF, DUP_RNK )
    select p_kf, l_rnk, dup.kf
$if EBK_PARAMS.CUT_RNK $then
         , EBKC_WFORMS_UTL.GET_RNK(dup.rnk,dup.kf)
$else
         , dup.rnk
$end
      from table (p_duplicate_ebk) dup
     where not exists ( select null 
                          from TMP_EBK_DUP_CLIENT 
                         where KF  = p_kf
                           and RNK = l_rnk
                           and DUP_KF  = dup.KF
$if EBK_PARAMS.CUT_RNK $then
                           and DUP_RNK = EBKC_WFORMS_UTL.GET_RNK(dup.RNK,dup.KF)
$else
                           and DUP_RNK = dup.RNK
$end
                      );
      
    commit;
    
  end request_duplicate_mass;
  
  --
  --
  --
  procedure REQUEST_GCIF_MASS
  ( p_batchId          in     varchar2,
    p_kf               in     varchar2,
    p_rnk              in     number,
    p_gcif             in     varchar2,
    p_slave_client_ebk in     t_slave_client_ebk
  ) is
    title          constant   varchar2(64) := $$PLSQL_UNIT||'.REQUEST_GCIF_MASS';
    l_sys_dt                  ebkc_gcif.insert_date%type := sysdate;
    l_rnk                     ebkc_gcif.rnk%type;
  begin

    bars_audit.trace( '%s: Entry with ( p_kf=%s, p_rnk=%s, p_gcif=%s ).', title, p_kf, to_char(p_rnk), p_gcif );

    case
    when ( p_kf is null )
    then raise_application_error( -20666,'Value for parameter [p_kf] must be specified!', true );
    when ( p_rnk is null )
    then raise_application_error( -20666,'Value for parameter [p_rnk] must be specified!', true );
    when ( p_gcif is null )
    then raise_application_error( -20666,'Value for parameter [p_gcif] must be specified!', true );
    else null;
    end case;

$if EBK_PARAMS.CUT_RNK $then
    bc.set_policy_group('WHOLE');
    l_rnk := EBKC_WFORMS_UTL.GET_RNK(p_rnk,p_kf);
$else
    l_rnk := p_rnk;
$end
    
    -- перед загрузкой мастер-записи с GCIF-ом и подчиненных записей, 
    -- необходимо очистить старую загрузку подчиненных карточек по этой же мастер карточке

    delete EBKC_SLAVE
     where GCIF = p_gcif
        or GCIF in ( select GCIF
                       from EBKC_GCIF
                      where RNK = l_rnk
--                      and CUST_TYPE = g_cust_tp 
                   );

    delete EBKC_GCIF
     where RNK = l_rnk
        or ( KF = p_kf and GCIF = p_gcif );

    -- записиваем присланную актуальную структуру
    insert 
      into EBKC_GCIF
         ( KF, RNK, GCIF, CUST_TYPE, INSERT_DATE )
    values
         ( p_kf, l_rnk, p_gcif, g_cust_tp, l_sys_dt );

    if ( p_slave_client_ebk.count > 0 )
    then

      insert 
        into EBKC_SLAVE
           ( GCIF, SLAVE_KF, SLAVE_RNK, CUST_TYPE )
      select p_gcif
           , sce.KF
  $if EBK_PARAMS.CUT_RNK $then
           , EBKC_WFORMS_UTL.GET_RNK( sce.RNK, sce.KF )
  $else
           , sce.RNK
  $end
           , g_cust_tp
        from table( p_slave_client_ebk ) sce
       where not exists ( select 0 
                            from EBKC_SLAVE
                           where GCIF      = p_gcif
                             and SLAVE_KF  = sce.KF
  $if EBK_PARAMS.CUT_RNK $then
                             and SLAVE_RNK = EBKC_WFORMS_UTL.GET_RNK(sce.RNK,sce.KF)
  $else
                             and SLAVE_RNK = sce.RNK
  $end
--                           and CUST_TYPE = g_cust_tp
                        );

    end if;

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
      bars_audit.error( title || ': p_batch='||p_batchid||', p_kf='||p_kf||', p_rnk='||to_char(p_rnk)||', p_gcif='||p_gcif );
      bars_audit.error( title || ': ' || dbms_utility.format_error_stack() || chr(10) || dbms_utility.format_error_backtrace() );
      raise_application_error( -20666, title || ': ' || SQLERRM, true );
  end REQUEST_GCIF_MASS;

  --
  --
  --
  procedure REQUEST_DEL_GCIF
  ( /*p_kf in varchar2,
    p_rnk in number,*/
    p_gcif in varchar2
  ) is
  begin
    
    -- возможно нужны будут проверки к какому rnk принадлежал gcif
    -- по идеи раз присвоенній gcif к конкретной карточке не может быть переведен к другой карточке
    
    -- удаляем подчиненные картки к глоб. идент.
    delete EBKC_SLAVE
     where GCIF = p_gcif;
   
    -- удаляем запись о глоб. идент.
    delete EBKC_GCIF
     where GCIF = p_gcif;
    
    commit;
    
  exception
    when others then
      rollback;
      raise_application_error( -20666, 'EBK_DUP_REQUEST_UTL.REQUEST_DEL_GCIF: '||sqlerrm, true );
  end request_del_gcif;



begin
  null;
end EBK_DUP_REQUEST_UTL;
/

show err

grant execute on EBK_DUP_REQUEST_UTL to BARS_ACCESS_DEFROLE;
