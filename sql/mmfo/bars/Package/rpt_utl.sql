create or replace package RPT_UTL
is
  --
  -- constants
  --
  g_header_version   constant varchar2(64) := 'version 1.00 23.08.2017';

  --
  -- types
  --
  type r_balances_type is record ( rpt_dt    date
                                 , acg_tp    varchar2(32)  -- Accounting type code
                                 , acg_nm    varchar2(32)  -- Accounting type name
                                 , kl        varchar2(1)   -- Class code
                                 , kl_nm     varchar2(128) -- Class name
                                 , razd      varchar2(2)   -- Section code
                                 , razd_nm   varchar2(128) -- Section name
                                 , gr        varchar2(3)   -- Group code
                                 , gr_nm     varchar2(128) -- Group name
                                 , r020      varchar2(4)   -- NBS
                                 , r020_mn   varchar2(128) -- NBS name
                                 , r030      varchar2(3)   -- Currency code
                                 , r030_nm   varchar2(32)  -- Currency name
                                 , tvr_db    number(24)    -- Debit  turnover
                                 , tvr_cr    number(24)    -- Credit turnover
                                 , bal_db    number(24)    -- Debit  balance
                                 , bal_cr    number(24)    -- Credit balance
                                 );

  type t_balances_type is table of r_balances_type;

  --
  -- functions
  --
  function header_version
     return varchar2;

  function body_version
     return varchar2;

  function GET_BALANCES
  ( p_rpt_dt  date
  ) return t_balances_type
  pipelined;

end RPT_UTL;
/

show errors;

--------------------------------------------------------------------------------

create or replace package body RPT_UTL
is
  --
  -- constants
  --
  g_body_version   constant varchar2(64) := 'version 1.00 23.08.2017';
  
  --
  -- functions
  --
  function header_version
    return varchar2
  is
  begin
    return 'Package ' || $$PLSQL_UNIT || ' header '||g_header_version;
  end header_version;

  function body_version
    return varchar2
  is
  begin
    return 'Package ' || $$PLSQL_UNIT || ' body '||g_body_version;
  end body_version;
  
  --
  --
  --
  function GET_BALANCES
  ( p_rpt_dt   date
  ) return t_balances_type
  pipelined
  is
    title   constant   varchar2(60) := $$PLSQL_UNIT||'.GET_BALANCES';
    t_bals             t_balances_type;
    l_bal_dt           date;
    l_snp_dt           date;
  begin
    
    bars_audit.trace( '%s: Entry with ( p_rpt_dt=%s ).', title, to_char(p_rpt_dt,'dd/mm/yyyy') );
    
    if ( p_rpt_dt Is Null )
    then
      l_bal_dt := GL.GBD();
    else
      l_bal_dt := p_rpt_dt;
    end if;
    
    select max(FDAT)
      into l_bal_dt
      from FDAT
     where FDAT <= l_bal_dt;
    
    if ( l_bal_dt = GL.GBD() )
    then -- getting balances directly from the table ACCOUNTS
      
      select l_bal_dt as RPT_DT
           , ps.ACG_TP,     ps.ACG_NM
           , ps.NBS_K,      ps.NAME_K
           , ps.NBS_R,      ps.NAME_R
           , ps.NBS_G,      ps.NAME_G
           , bl.NBS,        ps.NAME
           , null as R030,  null as R030_NM
           , bl.DOS_UAH,    bl.KOS_UAH
           , bl.BAL_DB_UAH, bl.BAL_CR_UAH
        bulk collect
        into t_bals
        from ( select t.NBS
                    , sum( t.DOS_UAH ) as DOS_UAH
                    , sum( t.KOS_UAH ) as KOS_UAH
                    , sum( decode( sign(t.BAL_UAH),-1, -t.BAL_UAH, 0 ) ) as BAL_DB_UAH
                    , sum( decode( sign(t.BAL_UAH), 1,  t.BAL_UAH, 0 ) ) as BAL_CR_UAH
                 from ( select a.NBS
                             , round( nvl(a.OSTC,0) * r.RATE ) as BAL_UAH
                             , round( nvl(s.DOS,0)  * r.RATE ) as DOS_UAH
                             , round( nvl(s.KOS,0)  * r.RATE ) as KOS_UAH
                          from ACCOUNTS a
                          left
                          join SALDOA s
                            on ( s.ACC = a.ACC and s.FDAT = l_bal_dt )
                          join ( select KV
                                      , ( RATE_O/BSUM ) as RATE
                                   from CUR_RATES$BASE
                                  where ( BRANCH, VDATE, KV ) in ( select BRANCH, max(VDATE), KV
                                                                     from CUR_RATES$BASE
                                                                    where VDATE <= l_bal_dt
                                                                      and BRANCH = sys_context('bars_context','user_branch')
                                                                    group by BRANCH, KV )
                               ) r
                            on ( r.KV = a.KV )
                         where a.DAOS <= l_bal_dt
                           and a.DAZS Is Null
                           and a.NBS not like '8%'
                           and a.BRANCH like sys_context('bars_context','user_branch_mask')
                      ) t
                group by t.NBS
             ) bl
        left outer 
        join ( select t4.NBS,   t4.NAME
                    , t4.NBS_G, t3.NAME_G
                    , t4.NBS_R, t2.NAME_R
                    , t4.NBS_K, t1.NAME_K
                    , case
                      when t4.NBS_K = '9'
                      then 9
                      else 7
                      end as ACG_TP
                    , case
                      when t4.NBS_K = '9'
                      then 'Позабалансовий облiк'
                      else 'Балансовий облiк'
                      end as ACG_NM
                 from ( select NBS
                             , SubStr(NBS,1,3) as NBS_G
                             , SubStr(NBS,1,2) as NBS_R
                             , SubStr(NBS,1,1) as NBS_K
                             , SubStr(NAME,1,90) as NAME
                          from PS
                         where regexp_like( NBS, '^\d{4}' )
                           and D_CLOSE is null
                      ) t4
                 join ( select SubStr(NBS, 1, 3) as NBS_G
                             , SubStr(NAME,1,90) as NAME_G
                          from PS
                         where regexp_like( NBS, '^\d{3} ' )
                      ) t3
                   on ( t3.NBS_G = t4.NBS_G )
                 join ( select SubStr(NBS, 1, 2) as NBS_R
                             , SubStr(NAME,1,90) as NAME_R
                          from PS
                         where regexp_like( NBS, '^\d{2}  ' )
                      ) t2
                   on ( t2.NBS_R = t4.NBS_R )
                 join ( select SubStr(NBS, 1, 1) as NBS_K
                             , SubStr(NAME,1,90) as NAME_K
                          from PS
                         where regexp_like( NBS, '^\d{1}   ' )
                      ) t1
                   on ( t1.NBS_K = t4.NBS_K )
             ) ps
          on ( ps.NBS = bl.NBS )
       where bl.DOS_UAH    > 0
          or bl.KOS_UAH    > 0
          or bl.BAL_DB_UAH > 0
          or bl.BAL_CR_UAH > 0;

    else -- getting balances from SNAP_BALANCES and SALDOA

      l_snp_dt := DAT_NEXT_U( l_bal_dt, -1 );

      select l_bal_dt as RPT_DT
           , ps.ACG_TP,     ps.ACG_NM
           , ps.NBS_K,      ps.NAME_K
           , ps.NBS_R,      ps.NAME_R
           , ps.NBS_G,      ps.NAME_G
           , bl.NBS,        ps.NAME
           , null as R030,  null as R030_NM
           , bl.DOS_UAH,    bl.KOS_UAH
           , bl.BAL_DB_UAH, bl.BAL_CR_UAH
        bulk collect
        into t_bals
        from ( select t.NBS
                    , sum( t.DOS_UAH ) as DOS_UAH
                    , sum( t.KOS_UAH ) as KOS_UAH
                    , sum( decode( sign(t.BAL_UAH),-1, -t.BAL_UAH, 0 ) ) as BAL_DB_UAH
                    , sum( decode( sign(t.BAL_UAH), 1,  t.BAL_UAH, 0 ) ) as BAL_CR_UAH
                 from ( select a.NBS
                             , round( ( nvl(b.OST,0) - nvl(s.DOS,0) + nvl(s.KOS,0) ) * r.RATE ) as BAL_UAH
                             , round( nvl(s.DOS,0) * r.RATE ) as DOS_UAH
                             , round( nvl(s.KOS,0) * r.RATE ) as KOS_UAH
                          from ACCOUNTS a
                          left 
                          join SNAP_BALANCES b
                            on ( b.KF = a.KF and b.ACC = a.ACC and b.FDAT = l_snp_dt )
                          left
                          join SALDOA s
                            on ( s.ACC = a.ACC and s.FDAT = l_bal_dt )
                          join ( select KV
                                      , ( RATE_O/BSUM ) as RATE
                                   from CUR_RATES$BASE
                                  where ( BRANCH, VDATE, KV ) in ( select BRANCH, max(VDATE), KV
                                                                     from CUR_RATES$BASE
                                                                    where VDATE <= l_bal_dt
                                                                      and BRANCH = sys_context('bars_context','user_branch')
                                                                    group by BRANCH, KV )
                               ) r
                            on ( r.KV = a.KV )
                         where a.DAOS <= l_bal_dt
                           and a.DAZS Is Null
                           and a.NBS not like '8%'
                           and a.BRANCH like sys_context('bars_context','user_branch_mask')
                     ) t
                group by t.NBS
             ) bl
        left outer 
        join ( select t4.NBS,   t4.NAME
                    , t4.NBS_G, t3.NAME_G
                    , t4.NBS_R, t2.NAME_R
                    , t4.NBS_K, t1.NAME_K
                    , case
                      when t4.NBS_K = '9'
                      then 9
                      else 7
                      end as ACG_TP
                    , case
                      when t4.NBS_K = '9'
                      then 'Позабалансовий облiк'
                      else 'Балансовий облiк'
                      end as ACG_NM
                 from ( select NBS
                             , SubStr(NBS,1,3) as NBS_G
                             , SubStr(NBS,1,2) as NBS_R
                             , SubStr(NBS,1,1) as NBS_K
                             , SubStr(NAME,1,90) as NAME
                          from PS
                         where regexp_like( NBS, '^\d{4}' )
                           and D_CLOSE is null
                      ) t4
                 join ( select SubStr(NBS, 1, 3) as NBS_G
                             , SubStr(NAME,1,90) as NAME_G
                          from PS
                         where regexp_like( NBS, '^\d{3} ' )
                      ) t3
                   on ( t3.NBS_G = t4.NBS_G )
                 join ( select SubStr(NBS, 1, 2) as NBS_R
                             , SubStr(NAME,1,90) as NAME_R
                          from PS
                         where regexp_like( NBS, '^\d{2}  ' )
                      ) t2
                   on ( t2.NBS_R = t4.NBS_R )
                 join ( select SubStr(NBS, 1, 1) as NBS_K
                             , SubStr(NAME,1,90) as NAME_K
                          from PS
                         where regexp_like( NBS, '^\d{1}   ' )
                      ) t1
                   on ( t1.NBS_K = t4.NBS_K )
             ) ps
          on ( ps.NBS = bl.NBS )
       where bl.DOS_UAH    > 0
          or bl.KOS_UAH    > 0
          or bl.BAL_DB_UAH > 0
          or bl.BAL_CR_UAH > 0;

    end if;

    for r in t_bals.first .. t_bals.last
    loop
      pipe row ( t_bals(r) );
    end loop;
    
    t_bals.delete();
    
    bars_audit.trace( '%s: Exit.', title );
    
    RETURN;
     
  end GET_BALANCES;



begin
  null;
end RPT_UTL;
/

show errors;
