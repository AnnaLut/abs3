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

----------------------------------------------------------------------------------------------------

create or replace package body EBK_DUP_REQUEST_UTL
is
    
  --
  -- constants
  --
  g_body_version  constant   varchar2(64)  := 'version 1.05  2017.06.13';
  g_cust_tp       constant   ebkc_gcif.cust_type%type := 'I';
  
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
  ( p_batchId          in varchar2,
    p_kf               in varchar2,
    p_rnk              in number,
    p_gcif             in varchar2,
    p_slave_client_ebk in t_slave_client_ebk
  ) is
    l_sys_dt              ebkc_gcif.insert_date%type := sysdate;
    l_rnk                 ebkc_gcif.rnk%type;
  begin
    
$if EBK_PARAMS.CUT_RNK $then
    bc.set_policy_group('WHOLE');
    l_rnk := EBKC_WFORMS_UTL.GET_RNK(p_rnk,p_kf);
$else
    l_rnk := p_rnk;
$end
    
    -- перед загрузкой мастер-записи с GCIF-ом и подчиненных записей, 
    -- необходимо очистить старую загрузку подчиненных карточек по этой же мастер карточке,
    -- т.к. могли быть добавлены или уделены некоторые 
    
    delete EBKC_SLAVE
     where CUST_TYPE = g_cust_tp
       and ( GCIF    = p_gcif
          or GCIF in ( select GCIF
                         from EBKC_GCIF
                        where KF        = p_kf
                          and RNK       = l_rnk 
                          and CUST_TYPE = g_cust_tp )
           );
    
    delete EBKC_GCIF
     where CUST_TYPE = g_cust_tp
       and ( ( kf = p_kf and rnk = l_rnk ) or ( GCIF = p_gcif ) );
        
     -- записиваем присланную актуальную структуру
    insert 
      into EBKC_GCIF
         ( KF, RNK, GCIF, CUST_TYPE, INSERT_DATE )
    values ( p_kf, l_rnk, p_gcif, g_cust_tp, l_sys_dt );
    
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
                           and CUST_TYPE = g_cust_tp
                      );
    commit;

$if EBK_PARAMS.CUT_RNK $then
    bc.set_context;
$end
    
  exception 
    when others then
      rollback;
$if EBK_PARAMS.CUT_RNK $then
      bc.set_context;
$end
      raise;
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
     where GCIF = p_gcif
       and CUST_TYPE = g_cust_tp;
   
    -- удаляем запись о глоб. идент.
    delete EBKC_GCIF
     where GCIF      = p_gcif
       and CUST_TYPE = g_cust_tp;
    
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
