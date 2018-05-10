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
  g_body_version  constant   varchar2(64)  := 'version 1.07  2018.04.23';
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
--  EBKC_PACK.REQUEST_INDIVIDUAL_DUP_MASS( p_batchId, p_kf, p_rnk, p_duplicate_ebk );
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
    
  end REQUEST_DUPLICATE_MASS;
  
  --
  -- REQUEST_GCIF_MASS
  --
  procedure REQUEST_GCIF_MASS
  ( p_batchId          in     varchar2,
    p_kf               in     varchar2,
    p_rnk              in     number,
    p_gcif             in     varchar2,
    p_slave_client_ebk in     t_slave_client_ebk
  ) is
  begin
    EBKC_PACK.REQUEST_INDIVIDUAL_GCIF_MASS( p_batchId, p_kf, p_rnk, p_gcif, p_slave_client_ebk );
  end REQUEST_GCIF_MASS;

  --
  -- REQUEST_DEL_GCIF
  --
  procedure REQUEST_DEL_GCIF
  ( p_gcif in varchar2
  ) is
  begin
    EBK_REQUEST_UTL.REQUEST_DEL_GCIF( p_gcif );
  end REQUEST_DEL_GCIF;



begin
  null;
end EBK_DUP_REQUEST_UTL;
/

show err

grant execute on EBK_DUP_REQUEST_UTL to BARS_ACCESS_DEFROLE;
