create or replace package DPU_RPT_UTIL
is
  g_header_version  constant varchar2(64)  := 'version 1.01 30.06.2016';
  
  --
  -- types
  --
  
  --
  -- Службові функції (версія пакету)
  --
  function header_version return varchar2;
  function body_version   return varchar2;
  
  --
  -- set conditions for retrieving totals 
  --
  procedure SET_TOTALS_CD
  ( p_start_dt     in     date
  , p_finish_dt    in     date
  , p_grp_kf_f     in     signtype
  , p_grp_pd_f     in     signtype
  , p_grp_nbs_f    in     signtype
  , p_grp_ccy_f    in     signtype
  , p_grp_br_f     in     signtype
  , p_grp_usr_f    in     signtype
  );
  
  --
  -- set conditions for retrieving archive
  --
  procedure SET_ARCHV_CD
  ( p_rpt_dt       in     date
  , p_sbtp         in     dpu_deal.vidd%type
  , p_branch       in     dpu_deal.branch%type
  );
  
  --
  --
  --
  function GET_START_DT
    return date;
  
  --
  --
  --
  function GET_FINISH_DT
    return date;
  
  --
  --
  --
  function GET_MASK_GRP_SET
    return number;
  
  --
  --
  --
  function GET_VIDD_CD
    return dpu_deal.vidd%type;
  
  --
  --
  --
  function GET_BRANCH_CD
    return dpu_deal.branch%type;



end DPU_RPT_UTIL;
/

show errors

----------------------------------------------------------------------------------------------------

create or replace package body DPU_RPT_UTIL
is
  
  --
  -- constants
  --
  g_body_version  constant varchar2(64)  := 'version 1.03 07.07.2017';
  
  --
  -- types
  --
  
  --
  -- variables
  --
  g_start_dt                  date;
  g_finish_dt                 date;
  g_mask_grp_set              number(3);
  
  
  -- 
  -- повертає версію заголовка пакета
  -- 
  function header_version 
     return varchar2
  is
  begin
    return 'Package DPU_RPT_UTIL header '||g_header_version||'.';

  end header_version;
  
  --
  -- повертає версію тіла пакета
  --
  function body_version
    return varchar2
  is
  begin
    return 'Package DPU_RPT_UTIL body ' || g_body_version || '.';
  end body_version;
  
  --
  -- set conditions for retrieving totals 
  --
  procedure SET_TOTALS_CD
  ( p_start_dt     in     date
  , p_finish_dt    in     date
  , p_grp_kf_f     in     signtype
  , p_grp_pd_f     in     signtype
  , p_grp_nbs_f    in     signtype
  , p_grp_ccy_f    in     signtype
  , p_grp_br_f     in     signtype
  , p_grp_usr_f    in     signtype 
  ) is
    title       constant  varchar2(60) := 'dpu_rpt_util.set_totals_cd';
    
    l_kf        signtype := case when ( p_grp_kf_f  = 1 ) then 0 else 1 end;
    l_pd        signtype := case when ( p_grp_pd_f  = 1 ) then 0 else 1 end;
    l_nbs       signtype := case when ( p_grp_nbs_f = 1 ) then 0 else 1 end;
    l_ccy       signtype := case when ( p_grp_ccy_f = 1 ) then 0 else 1 end;
    l_br        signtype := case when ( p_grp_br_f  = 1 ) then 0 else 1 end;
    l_usr       signtype := case when ( p_grp_usr_f = 1 ) then 0 else 1 end; 
  begin
    
    bars_audit.trace( '%s: Entry with ( start_dt=%s, finish_dt=%s ).'
                    , title, to_char(p_start_dt,'dd/mm/yyyy'), to_char(p_finish_dt,'dd/mm/yyyy') );
    
    g_start_dt     := p_start_dt;
    g_finish_dt    := p_finish_dt;
    
    select BIN_TO_NUM( l_usr, l_br, l_ccy, l_nbs, l_pd, l_kf )
      into g_mask_grp_set 
      from DUAL;
    
    bars_audit.trace( '%s: Exit.', title );
    
  end;
  
  --
  -- set conditions for retrieving archive
  --
  procedure SET_ARCHV_CD
  ( p_rpt_dt       in     date
  , p_sbtp         in     dpu_deal.vidd%type
  , p_branch       in     dpu_deal.branch%type
  ) is
    title       constant  varchar2(60) := 'dpu_rpt_util.set_archv_cd';
  begin
    
    bars_audit.trace( '%s: Entry with ( rpt_dt=%s, sbtp=%s, branch=%s ).'
                    , title, to_char(p_rpt_dt,'dd/mm/yyyy'), to_char(p_sbtp), p_branch );
    
    g_finish_dt := p_rpt_dt;
    
    pul.put( 'RPT_DT', to_char(p_rpt_dt,'dd/mm/yyyy') );
    
    pul.put( 'VIDD', to_char(p_sbtp) );
    
    pul.put( 'BRANCH', p_branch );
    
    bars_audit.trace( '%s: Exit.', title );
    
  end SET_ARCHV_CD;
  
  --
  --
  --
  function GET_START_DT
    return date
  is
  begin
    return g_start_dt;
  end GET_START_DT;
  
  --
  --
  --
  function GET_FINISH_DT
    return date
  is
  begin
    return case 
           when g_finish_dt is null
           then to_date(sys_context('BARS_PUL','RPT_DT'),'dd/mm/yyyy')
           else g_finish_dt
           end;
  end GET_FINISH_DT;
  
  --
  --
  --
  function GET_MASK_GRP_SET
    return number
  is
  begin
    return g_mask_grp_set;
  end GET_MASK_GRP_SET;
  
  --
  --
  --
  function GET_VIDD_CD
    return dpu_deal.vidd%type
  is
  begin
    return to_number( sys_context('BARS_PUL','VIDD') );
  end GET_VIDD_CD;
  
  --
  --
  --
  function GET_BRANCH_CD
    return dpu_deal.branch%type
  is
  begin
    return sys_context('BARS_PUL','BRANCH');
  end GET_BRANCH_CD;



BEGIN
  g_start_dt     := trunc(sysdate,'MM');
  g_finish_dt    := trunc(sysdate);
  g_mask_grp_set := 60;
end DPU_RPT_UTIL;
/

show err;
 
grant EXECUTE on DPU_RPT_UTIL to BARS_ACCESS_DEFROLE;
