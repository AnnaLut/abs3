create or replace package ACCREG
is

--***************************************************************************--
-- (C) BARS. Accounts
--***************************************************************************--

g_head_version constant varchar2(64)  := 'Version 3.3  07/02/2018';
g_head_defs    constant varchar2(512) := '';

/* header_version - возвращает версию заголовка пакета */
function header_version return varchar2;

/* body_version   - возвращает версию тела пакета      */
function body_version return varchar2;

procedure SET_SPARAM_LIST
( p_name           in     sparam_list.name%type
, p_semantic       in     sparam_list.semantic%type
, p_tab_nm         in     sparam_list.tabname%type
, p_type           in     sparam_list.type%type
, p_nsi_nm         in     sparam_list.nsiname%type         default null
, p_inuse          in     sparam_list.inuse%type           default 1
, p_pk_nm          in     sparam_list.pkname%type          default null
, p_del_null       in     sparam_list.delonnull%type       default null
, p_nsi_sqlwhere   in     sparam_list.nsisqlwhere%type     default null
, p_sql_condition  in     sparam_list.sqlcondition%type    default null
, p_tag            in     sparam_list.tag%type             default null
, p_tab_col_chk    in     sparam_list.tabcolumn_check%type default null
, p_code           in     sparam_list.code%type            default 'OTHERS'
, p_hist           in     sparam_list.hist%type            default 0
, p_max_char       in     sparam_list.max_char%type        default null
);

--
-- OPEN_ACCOUNT
--
procedure OPN_ACC
( p_acc               out accounts.acc%type  -- Account id
, p_rnk            in     accounts.rnk%type  -- Customer number
, p_nbs            in     accounts.nbs%type  -- R020
, p_ob22           in     accounts.ob22%type -- OB22
, p_nls            in     accounts.nls%type  -- Account number
, p_nms            in     accounts.nms%type  -- Account name
, p_kv             in     accounts.kv%type   -- Currency code
, p_isp            in     accounts.isp%type  -- User id
, p_nlsalt         in     accounts.nlsalt%type default Null -- 
, p_pap            in     accounts.pap%type    default Null -- T020
, p_tip            in     accounts.tip%type    default 'ODB'
, p_pos            in     accounts.pos%type    default Null -- Account Characteristic
, p_vid            in     accounts.vid%type    default Null
, p_branch         in     accounts.branch%type default Null
, p_lim            in     accounts.lim%type    default Null
, p_ostx           in     accounts.ostx%type   default Null
, p_blkd           in     accounts.blkd%type   default Null
, p_blkk           in     accounts.blkk%type   default Null
, p_grp            in     accounts.GRP%type    default Null
, p_accc           in     accounts.accc%type   default Null -- Parent Account id
, p_mdate          in     accounts.mdate%type  default Null --
, p_mode           in     integer              default 77   -- Opening mode
);

--
-- CHANGE_ACCOUNT_ATTRIBUTE
--
procedure CHG_ACC_ATTR
( p_acc            in     accounts.acc%type
, p_nms            in     accounts.nms%type
, p_isp            in     accounts.isp%type
, p_nlsalt         in     accounts.nlsalt%type
, p_pap            in     accounts.pap%type
, p_tip            in     accounts.tip%type
, p_pos            in     accounts.pos%type
, p_vid            in     accounts.vid%type
, p_branch         in     accounts.branch%type
, p_lim            in     accounts.lim%type
, p_ostx           in     accounts.ostx%type
, p_blkd           in     accounts.blkd%type
, p_blkk           in     accounts.blkk%type
, p_grp            in     accounts.GRP%type
, p_mdate          in     accounts.mdate%type  default Null
);

--
--
--
procedure SetAccountAttr
( mod_              integer,            -- Opening mode : 1, 2, 3, 4, 5, 6, 9, 99, 77
  p1_               integer,            -- 1st Par      : 1-nd, 2-nd, 3-main acc, 4-mfo, 5-mfo, 6-acc
  p2_               integer,            -- 2nd Par      : 2-pawn, 4-acc
  p3_               integer,            -- 3rd Par (Grp): 2-mpawn, others-grp
  p4_        in out integer,            -- 4th Par      : 2-ndz(O)
  rnk_              accounts.rnk%type,  -- Customer number
  nls_              accounts.nls%type,  -- Account  number
  kv_               accounts.kv%type,   -- Currency code
  nms_              accounts.nms%type,  -- Account name
  tip_              accounts.tip%type,  -- Account type
  isp_              accounts.isp%type,
  accR_         out accounts.acc%type,
  nbsnull_          varchar2             default '1',
  ob22_             accounts.ob22%type,
  pap_              accounts.pap%type    default Null,
  vid_              accounts.vid%type    default Null,
  pos_              accounts.pos%type    default Null,
  sec_              number               default Null,
  seci_             accounts.seci%type   default Null,
  seco_             accounts.seco%type   default Null,
  blkd_             accounts.blkd%type   default Null,
  blkk_             accounts.blkk%type   default Null,
  lim_              accounts.lim%type    default Null,
  ostx_             varchar2             default Null, -- 'NULL' for update
  nlsalt_           accounts.nlsalt%type default Null, -- 'NULL' for update
  branch_           accounts.branch%type default Null,  --
  accc_             accounts.accc%type   default Null  -- 'NULL' for update
);

-- for sparam_list
procedure setAccountSParam (
  Acc_   number,
  Par_   varchar2,
  Val_   varchar2 );

-- for accountsw
procedure setAccountwParam (
  p_acc  accountsw.acc%type,
  p_tag  accountsw.tag%type,
  p_val  accountsw.value%type );

procedure setAccountProf (
  Acc_   number,
  Nbs_   char );

procedure setAccountAttrFromProf (
  Acc_   number,
  Nbs_   char,
  Np_    number );

procedure setAccountSParamFromProf (
  Acc_   number,
  Nbs_   char,
  Np_    number );

procedure setAccountIntFromProf (
  Acc_   number,
  Nbs_   char,
  Np_    number );

procedure setAccountTarif (
  Acc_    number,
  Kod_    number,
  Tar_    number,
  Pr_     number,
  SMin_   number,
  SMax_   number );

procedure setAccountSob (
  Acc_    number,
  Id_     number,
  Isp_    number,
  FDat_   date,
  Txt_    varchar2 );

procedure changeAccountOwner (
  Acc_    number,
  RnkA_   integer,
  RnkB_   integer );

procedure check_account (
  p_acc   in  accounts.acc%type,
  p_msg   out varchar2,
  p_check out number );

procedure closeAccount (
  p_acc         in accounts.acc%type,
  p_info       out varchar2,
  p_can_close  out number );

procedure p_acc_restore (
  p_acc  in number,
  p_daos in date default null );

--
-- Reservation of the account number
--
procedure RSRV_ACC_NUM
( p_nls      in     accounts_rsrv.nls%type                   -- Account  number
, p_kv       in     accounts_rsrv.kv%type                    -- Currency code
, p_nms      in     accounts_rsrv.nms%type                   -- Account name
, p_branch   in     accounts_rsrv.branch%type                -- 
, p_isp      in     accounts_rsrv.isp%type                   -- 
, p_vid      in     accounts_rsrv.vid%type                   -- 
, p_rnk      in     accounts_rsrv.rnk%type                   -- Customer number
, p_agrm_num in     accounts_rsrv.agrm_num%type default null -- номер договору банківського обслуговування
, p_trf_id   in     accounts_rsrv.trf_id%type   default null -- код тарифного пакету
, p_ob22     in     accounts_rsrv.ob22%type     default null -- 
, p_errmsg      out varchar2
);

--
-- Cancellation of the account number reservation
--
procedure CNCL_RSRV_ACC_NUM
( p_nls      in     accounts_rsrv.nls%type
, p_kv       in     accounts_rsrv.kv%type
);

procedure REJECT_RESERVE_ACC
( p_nls      in     accounts_rsrv.nls%type
, p_kv       in     accounts_rsrv.kv%type
, p_errmsg      out varchar2
);

procedure check_user_permissions
( p_acc      in     accounts.acc%type,
  p_nbs      in     ps.nbs%type,
  p_rez         out integer,
  p_msg         out varchar2
);

--
-- P_UNRESERVE_ACC
--
procedure P_UNRESERVE_ACC
( p_nls      in     accounts.nls%type
, p_kv       in     accounts.kv%type
, p_acc         out accounts.acc%type
);

procedure UNRSRV_ACC
( p_acc      in     accounts.acc%type
, p_kv       in     accounts.kv%type
, p_errmsg      out varchar2
);

procedure DUPLICATE_ACC
( p_acc      in out accounts.acc%type -- Existing account identifier
, p_kv       in     accounts.kv%type  -- New currency code
, p_errmsg      out varchar2          -- Error message
);

--
-- Получить умолчательное значение для спецпараметра
-- Алгоритм расчета зависит от модуля, определяется контекстом 'MODULE'; Необходимые переменные также берутся из контекста
--
function get_default_spar_value(p_acc    in accounts.acc%type,
                                p_spid in sparam_list.spid%type) return varchar2;

--
-- Проставить умолчательные значения для спецпараметров (по флагу sparam_list.def_flag = 'Y')
--
procedure set_default_sparams(p_acc in accounts.acc%type);

end accreg;
/

show err

----------------------------------------------------------------------------------------------------

create or replace package body ACCREG
is

  --***************************************************************************--
  -- (C) BARS. Accounts
  --***************************************************************************--
  g_modcode       constant varchar2(3) := 'CAC';

  g_body_version  constant varchar2(64)  := 'version 3.0  26/03/2018';
  g_body_defs     constant varchar2(512) := ''
$if ACC_PARAMS.KOD_D6
$then
    || 'KOD_D6  - с проц. проверки на допустимое сочетание БС и эк.нормативов клиента по справочнику kod_d6'
$end
;

/** header_version - возвращает версию заголовка пакета */
function header_version return varchar2 is
begin
  return 'Package ' || $$PLSQL_UNIT || ' header ' || g_head_version || chr(10) ||
         'AWK definition: ' || chr(10) || g_head_defs;
end header_version;

/** body_version - возвращает версию тела пакета */
function body_version return varchar2 is
begin
  return 'Package ' || $$PLSQL_UNIT || ' body ' || g_body_version || chr(10) ||
         'AWK definition: ' || chr(10) || g_body_defs;
end body_version;

--***************************************************************************--
-- Procedure   : SET_SPARAM_LIST
-- Description :
--***************************************************************************--
procedure SET_SPARAM_LIST
( p_name           in     sparam_list.name%type
, p_semantic       in     sparam_list.semantic%type
, p_tab_nm         in     sparam_list.tabname%type
, p_type           in     sparam_list.type%type
, p_nsi_nm         in     sparam_list.nsiname%type         default null
, p_inuse          in     sparam_list.inuse%type           default 1
, p_pk_nm          in     sparam_list.pkname%type          default null
, p_del_null       in     sparam_list.delonnull%type       default null
, p_nsi_sqlwhere   in     sparam_list.nsisqlwhere%type     default null
, p_sql_condition  in     sparam_list.sqlcondition%type    default null
, p_tag            in     sparam_list.tag%type             default null
, p_tab_col_chk    in     sparam_list.tabcolumn_check%type default null
, p_code           in     sparam_list.code%type            default 'OTHERS'
, p_hist           in     sparam_list.hist%type            default 0
, p_max_char       in     sparam_list.max_char%type        default null
) is
  r_spar_lst  sparam_list%rowtype;
begin

  if ( upper(p_tab_nm) = 'ACCOUNTSW' )
  then

    case
      when ( p_tag Is Null )
      then
        raise_application_error( -20666, q'[Value for parameter 'P_TAG' must be specified!]', true );
      when ( p_semantic Is Null )
      then
        raise_application_error( -20666, q'[Value for parameter 'P_SEMANTIC' must be specified!]', true );
      else
        null;
    end case;

    r_spar_lst.NAME      := 'VALUE';
    r_spar_lst.DELONNULL := 1;

    begin
      Insert
        into BARS.ACCOUNTS_FIELD
           ( TAG, NAME, USE_IN_ARCH )
      Values
           ( upper(p_tag), p_semantic, 0 );
    exception
      when DUP_VAL_ON_INDEX then
        null;
    --  update BARS.ACCOUNTS_FIELD
    --     set NAME = p_semantic
    --       , USE_IN_ARCH = 0
    --   where TAG = upper(p_tag);
    end;

  else

    r_spar_lst.NAME      := upper(p_name);
    r_spar_lst.DELONNULL := nvl(p_del_null,0);

  end if;

  r_spar_lst.SEMANTIC        := p_semantic;
  r_spar_lst.TABNAME         := upper(p_tab_nm);
  r_spar_lst.TYPE            := nvl(p_type,'S');
  r_spar_lst.NSINAME         := p_nsi_nm;
  r_spar_lst.INUSE           := nvl(p_inuse,1);
  r_spar_lst.PKNAME          := p_pk_nm;
  r_spar_lst.NSISQLWHERE     := p_nsi_sqlwhere;
  r_spar_lst.SQLCONDITION    := p_sql_condition;
  r_spar_lst.TAG             := upper(p_tag);
  r_spar_lst.TABCOLUMN_CHECK := p_tab_col_chk;
  r_spar_lst.CODE            := nvl(p_code,'OTHERS');
  r_spar_lst.HIST            := nvl(p_hist,0);
  r_spar_lst.MAX_CHAR        := p_max_char;
--r_spar_lst.BRANCH          := sys_context('BARS_CONTEXT','USER_BRANCH');

  select nvl(max(SPID),0) + 1
    into r_spar_lst.SPID
    from BARS.SPARAM_LIST;

  insert
    into BARS.SPARAM_LIST
  values r_spar_lst;

end SET_SPARAM_LIST;

--***************************************************************************--
-- Procedure   : setAccountAttr
-- Description : процедура регистрации счета/обновления реквизитов счета
--***************************************************************************--
procedure SetAccountAttr
( mod_              integer,            -- Opening mode : 1, 2, 3, 4, 5, 6, 9, 99, 77
  p1_               integer,            -- 1st Par      : 1-nd, 2-nd, 3-main acc, 4-mfo, 5-mfo, 6-acc
  p2_               integer,            -- 2nd Par      : 2-pawn, 4-acc
  p3_               integer,            -- 3rd Par (Grp): 2-mpawn, others-grp
  p4_        in out integer,            -- 4th Par      : 2-ndz(O)
  rnk_              accounts.rnk%type,  -- Customer number
  nls_              accounts.nls%type,  -- Account  number
  kv_               accounts.kv%type,   -- Currency code
  nms_              accounts.nms%type,  -- Account name
  tip_              accounts.tip%type,  -- Account type
  isp_              accounts.isp%type,
  accR_         out accounts.acc%type,
  nbsnull_          varchar2             default '1',
  ob22_             accounts.ob22%type,
  pap_              accounts.pap%type    default Null,
  vid_              accounts.vid%type    default Null,
  pos_              accounts.pos%type    default Null,
  sec_              number               default Null,
  seci_             accounts.seci%type   default Null,
  seco_             accounts.seco%type   default Null,
  blkd_             accounts.blkd%type   default Null,
  blkk_             accounts.blkk%type   default Null,
  lim_              accounts.lim%type    default Null,
  ostx_             varchar2             default Null, -- 'NULL' for update
  nlsalt_           accounts.nlsalt%type default Null, -- 'NULL' for update
  branch_           accounts.branch%type default Null, --
  accc_             accounts.accc%type   default Null  -- 'NULL' for update
) IS
  title    constant varchar2(64) := $$PLSQL_UNIT||'.SetAccountAttr';
  l_acc             accounts.acc%type;
  l_blkd            accounts.blkd%type;
  l_nbs             accounts.nbs%type;
  l_tip             accounts.tip%type;
begin

  bars_audit.trace( '%s: Entry with ( rnk=%s, nls=%s, kv=%s, nms=%s, ob22=%s ).'
                  , title, to_char(rnk_), nls_, to_char(kv_), nms_, ob22_ );

  l_blkd := blkd_;

  l_tip  := tip_;

  begin
    select ACC
      into l_acc
      from ACCOUNTS
     where NLS = nls_
       and KV  = kv_;
  exception
    when NO_DATA_FOUND then
$if ACC_PARAMS.SBER
$then
      l_nbs := SubStr(nls_,1,4);

      -- костилі відкриття рахунку для Ощадбанку:
      -- COBUSUPABS-5211
      if ( l_nbs = '2620' and ob22_ = '34' )
      then
        l_blkd := 2;
      end if;

      -- COBUSUPABS-6084
      if ( tip_ is null )
      then
        begin
          select TIP
            into l_tip
            from NBS_TIPS
           where NBS  = l_nbs
             and OB22 = ob22_
             and ROWNUM = 1;
        exception
          when NO_DATA_FOUND then
            begin
              select TIP
                into l_tip
                from NBS_TIPS
               where NBS = l_nbs
                 and OB22 Is Null
                 and ROWNUM = 1;
            exception
              when NO_DATA_FOUND then
                l_tip := 'ODB';
            end;
        end;
      else -- перевірка на допустимість типу рахунка
        
        null;
        
--       begin
--         select TIP
--           into l_tip
--           from NBS_TIPS
--          where NBS  = l_nbs
--            and OB22 = ob22_
--            and TIP  = tip_;
--       exception
--         when NO_DATA_FOUND then
--           begin
--             select TIP
--               into l_tip
--               from NBS_TIPS
--              where NBS  = l_nbs
--                and TIP  = tip_
--                and OB22 Is Null;
--           exception
--             when NO_DATA_FOUND then
--               bars_error.raise_nerror( g_modcode, 'GENERAL_ERROR_CODE', 'Недопустимий тип '||tip_||' для балансового рахунку '||l_nbs  );
--           end;
--       end;
        
      end if;

$end
      l_acc := null;
  end;

  OP_REG_LOCK( mod_     => mod_   , p1_      => p1_
             , p2_      => p2_    , p3_      => p3_
             , p4_      => p4_
             , rnk_     => rnk_   , p_nls_   => nls_
             , kv_      => kv_    , nms_     => nms_
             , tip_     => l_tip  , isp_     => isp_
             , accR_    => accR_  , nbsnull_ => nbsnull_
             , pap_     => pap_   , vid_     => vid_
             , pos_     => pos_   , sec_     => sec_
             , seci_    => seci_  , seco_    => seco_
             , blkd_    => l_blkd , blkk_    => blkk_
             , lim_     => lim_   , ostx_    => ostx_
             , nlsalt_  => nlsalt_, tobo_    => branch_
             , accc_    => accc_
             );

  begin
    insert
      into SPECPARAM ( ACC )
    values ( accR_ );
    bars_audit.trace( title||': inserted ' || to_char(sql%rowcount) || ' row into "SPECPARAM".' );
  exception
    when DUP_VAL_ON_INDEX then
      null;
  end;

  if ( ob22_ Is Not Null )
  then
    SetAccountSParam( accR_, 'OB22', ob22_ );
  end if;
  
$if ACC_PARAMS.MMFO
$then
  if ( BARS_DPA.DPA_NBS( l_nbs, ob22_ ) = 1 )
  then -- COBUMMFO-4028
    BARS_DPA.ACCOUNTS_TAX( p_acc  => accr_
                         , p_daos => trunc(SYSDATE)
                         , p_dazs => NULL
                         , p_kv   => kv_
                         , p_nbs  => l_nbs
                         , p_nls  => nls_
                         , p_ob22 => ob22_
                         , p_pos  => pos_
                         , p_vid  => vid_
                         , p_rnk  => rnk_
                         );
  end if;
$end
  bars_audit.trace( '%s: Exit.', title );

end SetAccountAttr;

--***************************************************************************--
-- Procedure   : OPEN_ACCOUNT
-- Description : процедура открития счета
--***************************************************************************--
procedure OPN_ACC
( p_acc               out accounts.acc%type  -- Account Id
, p_rnk            in     accounts.rnk%type  -- Customer number
, p_nbs            in     accounts.nbs%type  -- R020
, p_ob22           in     accounts.ob22%type -- OB22
, p_nls            in     accounts.nls%type  -- Account number
, p_nms            in     accounts.nms%type  -- Account name
, p_kv             in     accounts.kv%type   -- Currency code
, p_isp            in     accounts.isp%type  -- User id
, p_nlsalt         in     accounts.nlsalt%type default Null -- Alternative Account number
, p_pap            in     accounts.pap%type    default Null -- T020
, p_tip            in     accounts.tip%type    default 'ODB'
, p_pos            in     accounts.pos%type    default Null -- Account Characteristic
, p_vid            in     accounts.vid%type    default Null
, p_branch         in     accounts.branch%type default Null
, p_lim            in     accounts.lim%type    default Null
, p_ostx           in     accounts.ostx%type   default Null
, p_blkd           in     accounts.blkd%type   default Null
, p_blkk           in     accounts.blkk%type   default Null
, p_grp            in     accounts.grp%type    default Null -- Access Account Group Id
, p_accc           in     accounts.accc%type   default Null -- Parent Account id
, p_mdate          in     accounts.mdate%type  default Null --
, p_mode           in     integer              default 77   -- Opening mode
) is
  title      constant     varchar2(64) := $$PLSQL_UNIT||'.OPN_ACC';
  l_acc                   number(38);
  l_blkd                  accounts.blkd%type;
  l_nbs                   accounts.nbs%type;
  l_tip                   accounts.tip%type;
  l_opn_dt                date;
  l_cls_dt                date;
begin

  bars_audit.trace( '%s: Entry with ( rnk=%s, nls=%s, kv=%s, nms=%s, ob22=%s ).'
                  , title, to_char(p_rnk), p_nls, to_char(p_kv), p_nms, p_ob22 );

  DBMS_APPLICATION_INFO.SET_ACTION( title );

  l_blkd := p_blkd;

  l_tip  := p_tip;

  begin

    select ACC
      into l_acc
      from ACCOUNTS
     where NLS = p_nls
       and KV  = p_kv;

    raise_application_error( -20666, 'Рахунок '||p_nls||'/'||to_char(p_kv)||' уже існує (#'||to_char(l_acc)||')!', true );
--  bars_error.raise_nerror( g_modcode, 'GENERAL_ERROR_CODE', 'Недопустимий тип '||tip_||' для балансового рахунку '||l_nbs  );

    select RNK
      into l_acc
      from ACCOUNTS_RSRV
     where NLS = p_nls
       and KV  = p_kv;

    raise_application_error( -20666, 'Рахунок '||p_nls||'/'||to_char(p_kv)||' зарезервовано для клієнта #'||to_char(l_acc), true );

  exception
    when NO_DATA_FOUND then
$if ACC_PARAMS.SBER
$then
      l_nbs := SubStr(p_nls,1,4);

      -- костилі відкриття рахунку для Ощадбанку:
      -- COBUSUPABS-5211
      if ( l_nbs = '2620' and p_ob22 = '34' )
      then
        l_blkd := 2;
      end if;

      -- COBUSUPABS-6084
      if ( p_tip is null )
      then
        begin
          select TIP
            into l_tip
            from NBS_TIPS
           where NBS  = l_nbs
             and OB22 = p_ob22
             and ROWNUM = 1;
        exception
          when NO_DATA_FOUND then
            begin
              select TIP
                into l_tip
                from NBS_TIPS
               where NBS = l_nbs
                 and OB22 Is Null
                 and ROWNUM = 1;
            exception
              when NO_DATA_FOUND then
                l_tip := 'ODB';
            end;
        end;
      else -- перевірка на допустимість типу рахунка
        
        null;
        
--       begin
--         select TIP
--           into l_tip
--           from NBS_TIPS
--          where NBS  = l_nbs
--            and OB22 = ob22_
--            and TIP  = tip_;
--       exception
--         when NO_DATA_FOUND then
--           begin
--             select TIP
--               into l_tip
--               from NBS_TIPS
--              where NBS  = l_nbs
--                and TIP  = tip_
--                and OB22 Is Null;
--           exception
--             when NO_DATA_FOUND then
--               bars_error.raise_nerror( g_modcode, 'GENERAL_ERROR_CODE', 'Недопустимий тип '||tip_||' для балансового рахунку '||l_nbs  );
--           end;
--       end;
        
      end if;

$end
      l_acc := null;
  end;

  OP_REG_LOCK( mod_     => p_mode  , p1_      => null
             , p2_      => null    , p3_      => p_grp
             , p4_      => l_acc
             , rnk_     => p_rnk   , p_nls_   => p_nls
             , kv_      => p_kv    , nms_     => p_nms
             , tip_     => l_tip   , isp_     => nvl(p_isp,USER_ID())
             , accR_    => p_acc   , nbsnull_ => p_nbs
             , pap_     => p_pap   , vid_     => p_vid
             , pos_     => p_pos
             , blkd_    => l_blkd  , blkk_    => p_blkk
             , lim_     => p_lim   , ostx_    => to_char(p_ostx)
             , nlsalt_  => p_nlsalt
             , tobo_    => p_branch
             , accc_    => p_accc
             );

  begin
    insert
      into SPECPARAM ( ACC )
    values ( p_acc );
    bars_audit.trace( title||': inserted ' || to_char(sql%rowcount) || ' row into "SPECPARAM".' );
  exception
    when DUP_VAL_ON_INDEX then
      null;
  end;

  if ( p_ob22 Is Not Null )
  then
  
    if ( l_nbs Not Like '8%' )
    then
      begin

        select D_OPEN,   D_CLOSE
          into l_opn_dt, l_cls_dt
          from SB_OB22
         where R020 = l_nbs
           and OB22 = p_ob22;

        case
          when ( l_opn_dt > gl.bd )
          then raise_application_error(-20666, 'Код OB22 "'||p_ob22||'" для R020 "'||l_nbs||'" діє з '    ||to_char(l_opn_dt,'dd.MM.yyyy'), true );
          when ( l_cls_dt <= gl.bd )
          then raise_application_error(-20666, 'Код OB22 "'||p_ob22||'" для R020 "'||l_nbs||'" закрито з '||to_char(l_cls_dt,'dd.MM.yyyy'), true );
          else null;
        end case;

      exception
        when NO_DATA_FOUND then
          raise_application_error(-20666, 'Код OB22 "'||p_ob22||'" для R020 "'||l_nbs||'" відсутній в довіднику!', true );
      end;
    end if;

    SetAccountSParam( p_acc, 'OB22', p_ob22 );

  end if;

  if ( p_mdate Is Not Null )
  then
    SetAccountSParam( p_acc, 'MDATE', to_char(p_mdate,'dd/MM/yyyy') );
  end if;

$if ACC_PARAMS.MMFO
$then
  if ( BARS_DPA.DPA_NBS( p_nbs, p_ob22 ) = 1 )
  then -- COBUMMFO-4028
    BARS_DPA.ACCOUNTS_TAX( p_acc  => p_acc
                         , p_daos => trunc(SYSDATE)
                         , p_dazs => NULL
                         , p_kv   => p_kv
                         , p_nbs  => l_nbs
                         , p_nls  => p_nls
                         , p_ob22 => p_ob22
                         , p_pos  => p_pos
                         , p_vid  => p_vid
                         , p_rnk  => p_rnk
                         );
  end if;
$end
  bars_audit.trace( '%s: Exit with acc=%s.', title, to_char(p_acc) );

  DBMS_APPLICATION_INFO.SET_ACTION( null );

end OPN_ACC;

--
-- CHANGE_ACCOUNT_ATTRIBUTE
--
procedure CHG_ACC_ATTR
( p_acc            in     accounts.acc%type  -- Account id
, p_nms            in     accounts.nms%type  -- Account name
, p_isp            in     accounts.isp%type  -- User id
, p_nlsalt         in     accounts.nlsalt%type
, p_pap            in     accounts.pap%type
, p_tip            in     accounts.tip%type
, p_pos            in     accounts.pos%type
, p_vid            in     accounts.vid%type
, p_branch         in     accounts.branch%type
, p_lim            in     accounts.lim%type
, p_ostx           in     accounts.ostx%type
, p_blkd           in     accounts.blkd%type
, p_blkk           in     accounts.blkk%type
, p_grp            in     accounts.grp%type
, p_mdate          in     accounts.mdate%type  default null
) is
  title    constant varchar2(64) := $$PLSQL_UNIT||'.CHG_ACC_ATTR';
  l_acc                   number(38);
  l_rnk                   accounts.rnk%type;
  l_nls                   accounts.nls%type;
  l_kv                    accounts.kv%type;
begin

  bars_audit.trace( '%s: Entry with ( nms=%s, isp=%s, tip=%s ).'
                  , title, p_nms, to_char(p_isp), p_tip );

  begin

    select a.RNK, a.NLS, a.KV
      into l_rnk, l_nls, l_kv
      from ACCOUNTS a
     where ACC = p_acc;

  exception
    when NO_DATA_FOUND then
      raise_application_error( -20666, 'Рахунок #'||to_char(p_acc)||' не знайдено!' , true );
  end;

  OP_REG_LOCK( mod_     => 77      , p1_      => null
             , p2_      => null    , p3_      => p_grp
             , p4_      => l_acc
             , rnk_     => l_rnk   , p_nls_   => l_nls
             , kv_      => l_kv    , nms_     => p_nms
             , tip_     => p_tip   , isp_     => p_isp
             , accR_    => l_acc
             , pap_     => p_pap   , vid_     => p_vid
             , pos_     => p_pos
             , blkd_    => p_blkd  , blkk_    => p_blkk
             , lim_     => p_lim   , ostx_    => to_char(p_ostx)
             , nlsalt_  => p_nlsalt, tobo_    => p_branch
             );

  if ( p_mdate Is Not Null )
  then
    SetAccountSParam( p_acc, 'MDATE', to_char(p_mdate,'dd/MM/yyyy') );
  end if;

  bars_audit.trace( '%s: Exit.', title );

end CHG_ACC_ATTR;

--***************************************************************************--
-- Procedure   : setAccountSParam
-- Description : процедура обновления спецпараметров счета
--***************************************************************************--
procedure setAccountSParam (Acc_ number, Par_ varchar2, Val_ varchar2)
is
   l_tabname     sparam_list.tabname%type;
   l_type        sparam_list.type%type;
   l_delonnull   sparam_list.delonnull%type;
   l_count       number;
   l_stmt        varchar2(2000);
   l_title       varchar2(70) := 'accreg.setAccountSParam: ';
begin

   bars_audit.trace('%s params: Acc_=>%s, Par_=>%s, Val_=>%s',
        l_title, to_char(Acc_), Par_, Val_);

   begin

      select tabname, upper(nvl(type,'C')) type, nvl(delonnull,0)
        into l_tabname, l_type, l_delonnull
        from sparam_list
       where upper(name) = upper(Par_) ;

      bars_audit.trace('%s found Par_ %s in sparam_list',
           l_title, Par_);

   exception when no_data_found then

      l_tabname := null ;
      l_type    := null ;

   end;

   bars_audit.trace('%s l_tabname=>%s, l_type=>%s, l_delonnull=>%s',
        l_title, l_tabname, l_type, to_char(l_delonnull));

   if ( l_tabname is not null and l_type is not null ) then

      begin

         l_stmt := 'select acc from '|| l_tabname ||' where acc=:Acc_' ;

         bars_audit.trace('%s executing stmt=>%s', l_title, l_stmt);

         execute immediate l_stmt into l_count using Acc_ ;

         bars_audit.trace('%s specparam %s found for acc %s',
              l_title, Par_, to_char(Acc_));

      exception when no_data_found then

         if ( Val_ is not null ) then

            l_stmt := 'insert into ' || l_tabname || '(acc) values(:Acc_)' ;

            bars_audit.trace('%s executing stmt=>%s', l_title, l_stmt);

            execute immediate l_stmt using Acc_ ;

            bars_audit.trace('%s specparam %s for acc %s inserted',
                 l_title, Par_, to_char(Acc_));

            l_count := 1 ;

         end if;

      end;

      bars_audit.trace('%s l_count=>%s', l_title, to_char(l_count));

      if ( l_count > 0 ) then

         if ( Val_ is null and l_delonnull = 1 ) then

            l_stmt := 'delete from ' || l_tabname || ' where acc=:Acc_' ;

            bars_audit.trace('%s executing stmt=>%s', l_title, l_stmt);

            execute immediate l_stmt using Acc_ ;

            bars_audit.trace('%s specparam %s for acc %s deleted',
                 l_title, Par_, to_char(Acc_));

         else

            l_stmt := 'update ' || l_tabname || ' set '|| Par_ ||'=' ;

            if l_type = 'N' then
               l_stmt := l_stmt || 'to_number(:Val_)' ;
            elsif l_type ='D' then
               l_stmt := l_stmt || 'to_date(:Val_,''dd/MM/yyyy'')' ;
            else
               l_stmt := l_stmt || ':Val_' ;
            end if;

            l_stmt := l_stmt || ' where acc=:Acc_' ;

            bars_audit.trace('%s executing stmt=>%s', l_title, l_stmt);

            execute immediate l_stmt using Val_, Acc_ ;

            bars_audit.trace('%s specparam %s set to %s for acc %s',
                 l_title, Par_, Val_, to_char(Acc_));

         end if;

      end if;

   end if;

end setAccountSParam;

--***************************************************************************--
-- Procedure   : setAccountwParam
-- Description : процедура обновления спецпараметров счета
--***************************************************************************--
-- for accountsw
procedure setAccountwParam (
  p_acc  accountsw.acc%type,
  p_tag  accountsw.tag%type,
  p_val  accountsw.value%type )
is
   l_title       varchar2(70) := 'accreg.setAccountwParam: ';
begin

  bars_audit.trace('%s params: p_acc=>%s, p_tag=>%s, p_val=>%s',
       l_title, to_char(p_acc), p_tag, p_val);

  if p_val is null then

     delete from accountsw where acc = p_acc and tag = p_tag;

     bars_audit.trace(l_title || ' tag ' || p_tag || ' deleted for acc ' || p_acc);

  else

     begin

        insert into accountsw (acc, tag, value)
        values (p_acc, p_tag, p_val);

        bars_audit.trace(l_title || ' value on tag ' || p_tag || ' inserted for acc ' || p_acc);

     exception when dup_val_on_index then

        update accountsw
           set value = p_val
         where acc = p_acc and tag = p_tag;

        bars_audit.trace(l_title || ' value on tag ' || p_tag || ' modified for acc ' || p_acc);

     end;

  end if;

end setAccountwParam;


--***************************************************************************--
-- Procedure   : setAccountProf
-- Description : процедура заполнения параметров счета по профилю
--***************************************************************************--
procedure setAccountProf (Acc_ number, Nbs_ char)
is
   l_stmt    varchar2(4000);
   l_title   varchar2(70) := 'accreg.setAccountProf: ';
   l_acc     accounts.acc%type;
begin

   bars_audit.trace('%s params: Acc_=>%s, Nbs_=>%s',
        l_title, to_char(Acc_), Nbs_);

   for k in ( select np, sqlcondition from nbs_profacc
               where nbs = Nbs_ and sqlcondition is not null
               order by ord )
   loop

      begin

         l_stmt := 'select acc from accounts ' ||
                  ' where acc=:par_acc' ||
                  '   and (' || k.sqlcondition || ')';

         bars_audit.trace('%s executing stmt=>%s', l_title, l_stmt);

         execute immediate l_stmt into l_acc using Acc_ ;

         bars_audit.trace('%s set params from prof for acc %s', l_title, to_char(acc_));

         accreg.setAccountAttrfromProf(Acc_, Nbs_, k.np);
         accreg.setAccountSParamfromProf(Acc_, Nbs_, k.np);
         accreg.setAccountIntfromProf(Acc_, Nbs_, k.np);

         bars_audit.trace('%s params from prof for acc %s is set', l_title, to_char(acc_));

         exit;

      exception when no_data_found then null;

      end;

  end loop;

end setAccountProf;

--***************************************************************************--
-- Procedure   : setAccountAttrfromProf
-- Description : процедура заполнения основных параметров счета по профилю
--***************************************************************************--
procedure setAccountAttrfromProf (Acc_ number, Nbs_ char, Np_ number)
is
   l_value   varchar2(70);
   l_kv      number := null;
   l_isp     number := null;
   l_pap     number := null;
   l_tip     varchar2(3) := null;
   l_pos     number := null;
   l_vid     number := null;
   l_tobo    varchar2(12) := null;
   l_mfop    varchar2(12) := null;
   l_grp     varchar2(30) := null;
   l_title   varchar2(70) := 'accreg.setAccountAttrfromProf: ';
begin

  bars_audit.trace('%s params: Acc_=>%s, Nbs_=>%s, Np_=>%s',
        l_title, to_char(Acc_), Nbs_, to_char(Np_));

   for k in ( select upper(t.tag) tag , p.val, p.sql_text
                from nbs_prof p, nbs_proftag t
               where p.nbs=nbs_ and p.np=np_ and p.pr=1 and p.id=t.id )

   loop

      bars_audit.trace('%s tag=>%s, val=>%s, sqltext=>%s',
           l_title, k.tag, k.val, k.sql_text);

      l_value := '' ;

      if k.val is not null then

         l_value := k.val ;

      elsif k.sql_text is not null then

         bars_audit.trace('%s executing stmt=>%s', l_title, k.sql_text);

         execute immediate k.sql_text into l_value;

         bars_audit.trace('%s stmt executed', l_title);

      end if;

      bars_audit.trace('%s l_value=>%s', l_title, l_value);

      if l_value is not null then

         bars_audit.trace('%s tag=>%s', l_title, k.tag);

         if k.tag    = 'KV' then
            l_kv   := to_number(l_value) ;
         elsif k.tag = 'ISP' then
            l_isp  := to_number(l_value) ;
         elsif k.tag = 'PAP' then
            l_pap  := to_number(l_value) ;
         elsif k.tag = 'TIP' then
            l_tip  := l_value ;
         elsif k.tag = 'POS' then
            l_pos  := to_number(l_value) ;
         elsif k.tag = 'VID' then
            l_vid  := to_number(l_value) ;
         elsif k.tag = 'TOBO' then
            l_tobo := l_value ;
         elsif k.tag = 'GRP' then
            l_grp := l_value ;
            while instr(l_grp,',') > 0 loop
               sec.addAGrp(acc_, to_number(substr(l_grp,1,instr(l_grp,',')-1)));
               l_grp := substr(l_grp, instr(l_grp,',')+1);
            end loop;
            sec.addAGrp(acc_, to_number(l_grp));
         elsif k.tag = 'MFOP' then
            l_mfop := l_value ;
         end if;

      end if;

   end loop;

   bars_audit.trace('%s set params: kv=>%s, isp=>%s, pap=>%s, tip=>%s, pos=>%s, vid=>%s, tobo=>%s, mfop=>%s',
        l_title, to_char(l_kv), to_char(l_isp), to_char(l_pap), l_tip,
        to_char(l_pos), to_char(l_vid), l_tobo, l_mfop);

   if l_kv   is not null or l_isp is not null or l_pap is not null or
      l_tip  is not null or l_pos is not null or l_vid is not null or
      l_tobo is not null
   then

      bars_audit.trace('%s set params for acc %s', l_title, to_char(acc_));

      update accounts
         set kv   = nvl(l_kv,kv),
             isp  = nvl(l_isp,isp),
             pap  = nvl(l_pap,pap),
             tip  = nvl(l_tip,tip),
             pos  = nvl(l_pos,pos),
             vid  = nvl(l_vid,vid),
             tobo = nvl(l_tobo,tobo)
       where acc = acc_;

      bars_audit.trace('%s params for acc %s is set', l_title, to_char(acc_));

   end if;

   if l_mfop is not null then

      bars_audit.trace('%s set mfop for acc %s', l_title, to_char(acc_));

      update bank_acc set mfo = l_mfop where acc = acc_;

      if sql%rowcount = 0 then

         insert into bank_acc(mfo, acc) values(l_mfop, acc_);

         bars_audit.trace('%s mfop %s for acc %s inserted', l_title, l_mfop, to_char(acc_));

      else

         bars_audit.trace('%s mfop %s for acc %s is set', l_title);

      end if;

  end if;

end setAccountAttrfromProf;

--***************************************************************************--
-- Procedure   : setAccountSParamfromProf
-- Description : процедура заполнения спец.параметров счета по профилю
--***************************************************************************--
procedure setAccountSParamfromProf (Acc_ number, Nbs_ char, Np_ number)
is
   l_value   varchar2(70);
   l_kv      number := null;
   l_stmt    varchar2(2000);
   l_title   varchar2(70) := 'accreg.setAccountSParamfromProf: ';
begin

  bars_audit.trace('%s params: Acc_=>%s, Nbs_=>%s, Np_=>%s',
        l_title, to_char(Acc_), Nbs_, to_char(Np_));

   for k in ( select s.name tag, p.val, p. sql_text, s.tabname, upper(nvl(s.type,'C')) type
                from nbs_prof p, sparam_list s
               where p.pr=2 and p.id=s.spid and nbs=nbs_ and np=np_ and s.inuse=1 )

   loop

      bars_audit.trace('%s tag=>%s, val=>%s, sqltext=>%s, tabname=>%s, type=>%s',
           l_title, k.tag, k.val, k.sql_text, k.tabname, k.type);

      l_value := '' ;

      if k.val is not null then

         l_value := k.val ;

      elsif k.sql_text is not null then

         bars_audit.trace('%s executing stmt=>%s', l_title, k.sql_text);

         execute immediate k.sql_text into l_value;

         bars_audit.trace('%s stmt executed', l_title);

      end if;

      bars_audit.trace('%s l_value=>%s', l_title, l_value);

      if l_value is not null then

         bars_audit.trace('%s type=>%s', l_title, k.type);

         if k.type = 'D' then
            l_value := 'to_date(''' || l_value || ''',''dd/MM/yyyy'')';
         elsif k.type = 'C' or k.type = 'S' then
            l_value := '''' || l_value || '''';
         end if;

         bars_audit.trace('%s l_value=>%s', l_title, l_value);

         l_stmt :=
            'begin ' ||
            '   update ' || k.tabname ||
            '   set ' || k.tag || '=' || l_value ||
            '   where acc=' || to_char(acc_) || ';' ||
            '   if sql%rowcount = 0 then ' ||
            '      insert into ' || k.tabname || '(acc,' || k.tag || ')' ||
            '      values (' || to_char(acc_) || ', ' || l_value || ');' ||
            '   end if;' ||
            'end;';

         bars_audit.trace('%s executing stmt=>%s', l_title, l_stmt);

         execute immediate l_stmt;

         bars_audit.trace('%s specparam %s for acc %s is set', l_title, k.tag, to_char(acc_));

      end if;

  end loop;

end setAccountSParamfromProf;

--***************************************************************************--
-- Procedure   : setAccountIntfromProf
-- Description : процедура заполнения параметров %% счета (по профилю)
--***************************************************************************--
procedure setAccountIntfromProf (Acc_ number, Nbs_ char, Np_ number)
is
   bProf     number:=0;
   l_value   varchar2(70);
   l_pap     accounts.pap%type;
   l_lim     accounts.lim%type;
   l_id      number;
   l_metr    int_accn.metr%type  := 0;
   l_basem   int_accn.basem%type;
   l_basey   int_accn.basey%type := 0;
   l_freq    int_accn.freq%type  := 1;
   l_tt      int_accn.tt%type    := '%%1';
   l_acrb    int_accn.acrb%type;
   l_ttb     int_accn.ttb%type   := 'PS1';
   l_io      int_accn.io%type    := 0;
   l_bdat    date                := gl.bdate;
   l_ir      int_ratn.ir%type;
   l_br      int_ratn.br%type;
   l_title   varchar2(70) := 'accreg.setAccountIntfromProf: ';
begin

  bars_audit.trace('%s params: Acc_=>%s, Nbs_=>%s, Np_=>%s',
        l_title, to_char(Acc_), Nbs_, to_char(Np_));

   for k in ( select upper(t.tag) tag, p.val, p.sql_text
                from nbs_prof p, nbs_proftag t
               where p.nbs=Nbs_ and p.np=Np_ and p.pr=1 and p.id=t.id
                 and upper(t.tag) in ('P_RATI','P_RATB','P_METR','P_BASEY','P_FREQ',
                                      'P_IO','P_TT','P_TTB','P_ACRB') )
   loop

      bars_audit.trace('%s tag=>%s, val=>%s, sqltext=>%s',
           l_title, k.tag, k.val, k.sql_text);

      bProf   := 1 ;
      l_value := '' ;

      if k.val is not null then

         l_value := k.val ;

      elsif k.sql_text is not null then

         bars_audit.trace('%s executing stmt=>%s', l_title, k.sql_text);

         execute immediate k.sql_text into l_value;

         bars_audit.trace('%s stmt executed', l_title);

      end if;

      bars_audit.trace('%s l_value=>%s', l_title, l_value);

      if l_value is not null then

         bars_audit.trace('%s tag=>%s', l_title, k.tag);

         if k.tag = 'P_RATI' then
            l_ir    := to_number(l_value) ;
         elsif k.tag = 'P_RATB' then
            l_br    := to_number(l_value) ;
         elsif k.tag = 'P_METR' then
            l_metr  := to_number(l_value) ;
         elsif k.tag = 'P_BASEY' then
            l_basey := to_number(l_value) ;
         elsif k.tag = 'P_FREQ' then
            l_freq  := to_number(l_value) ;
         elsif k.tag = 'P_IO' then
            l_io    := to_number(l_value) ;
         elsif k.tag = 'P_TT' then
            l_tt    := l_value ;
         elsif k.tag = 'P_TTB' then
            l_ttb   := l_value ;
         elsif k.tag = 'P_ACRB' then
            begin
               select acc into l_acrb from accounts
                where nls=l_value and kv=gl.baseval ;
            exception when no_data_found then
               l_acrb := null ;
            end;
         end if;

      end if;

   end loop;

   bars_audit.trace('%s bProf=>%s', l_title, to_char(bProf));

   if bProf = 1 then

      select pap, lim into l_pap, l_lim from accounts where acc=Acc_ ;

      -- Определяем l_id
      if l_pap = 1 and l_lim >= 0 then
         l_id := 0 ;
      elsif l_pap = 2 and l_lim <= 0 then
         l_id := 1 ;
      else
         if l_lim > 0 then
            l_id := 0 ;
         else
            l_id := 1 ;
         end if;
      end if;

      -- Определяем nBaseM
      if l_basey = 2 then
         l_basem := 1 ;
      else
         l_basem := 0 ;
      end if;

      bars_audit.trace('%s set param: ir=>%s, br=>%s, metr=>%s, l_basem=>%s, basey=>%s, freq=>%s, io=>%s',
           l_title, to_char(l_ir), to_char(l_br), to_char(l_metr),
           to_char(l_basem), to_char(l_basey), to_char(l_freq), to_char(l_io));

      bars_audit.trace('%s set param: tt=>%s, ttb=>%s, acrb=>%s, id=>%s',
           l_title, l_tt, l_ttb, to_char(l_acrb), to_char(l_id));

      insert into int_accn (acc, id, metr, basem, basey, freq,
         stp_dat, acr_dat, apl_dat, tt, acra, acrb,
         ttb, kvb, nlsb, mfob, namb, nazn, io)
      values (Acc_, l_id, l_metr, l_basem, l_basey, l_freq,
         null, null, null, l_tt, null, l_acrb,
         l_ttb, null, null, null, null, null, l_io );

      bars_audit.trace('%s set int_accn for acc %s', l_title, to_char(acc_));

      insert into int_ratn (acc, id, bdat, ir, br, op)
      values (Acc_, l_id, l_bdat, l_ir, l_br, null ) ;

      bars_audit.trace('%s set int_ratn for acc %s', l_title, to_char(acc_));

  end if;

end setAccountIntfromProf;

--***************************************************************************--
-- Procedure   : setAccountTarif
-- Description : процедура обновления тарифов счета
--***************************************************************************--
procedure setAccountTarif (
   Acc_     number,
   Kod_     number,
   Tar_     number,
   Pr_      number,
   SMin_    number,
   SMax_    number )
is
   l_title   varchar2(70) := 'accreg.setAccountTarif: ';
begin

   bars_audit.trace('%s params: Acc_=>%s, Kod_=>%s, Tar_=>%s, Pr_=>%s, SMin_=>%s, SMax_=>%s',
        l_title, to_char(Acc_), to_char(Kod_), to_char(Tar_), to_char(Pr_), to_char(SMin_), to_char(SMax_));

   if Acc_ is not null and Kod_ is not null then

      if Tar_ is null and Pr_ is null and SMIn_ is null and SMax_ is null then

         bars_audit.trace('%s deleting kod %s for acc %s',
              l_title, to_char(Kod_), to_char(Acc_));

         delete from acc_tarif where acc=Acc_ and kod=Kod_ ;

         bars_audit.trace('%s kod %s for acc %s deleted',
              l_title, to_char(Kod_), to_char(Acc_));

      else

         bars_audit.trace('%s set kod %s for acc %s',
              l_title, to_char(Kod_), to_char(Acc_));

         update acc_tarif set tar=Tar_, pr=Pr_, smin=SMin_, smax=SMax_
          where acc=Acc_ and kod=Kod_ ;

         if sql%rowcount = 0 then

            insert into acc_tarif(acc,kod,tar,pr,smin,smax)
            values(Acc_, Kod_, Tar_, Pr_, SMin_, SMax_) ;

            bars_audit.trace('%s kod %s for acc %s inserted',
                 l_title, to_char(Kod_), to_char(Acc_));

         else

            bars_audit.trace('%s kod %s for acc %s is set',
                 l_title, to_char(Kod_), to_char(Acc_));

         end if;

      end if;

   end if;

end setAccountTarif;

--***************************************************************************--
-- Procedure   : setAccountSob
-- Description : процедура обновления событий счета
--***************************************************************************--
procedure setAccountSob
( Acc_    in     number
, Id_     in     number
, Isp_    in     number
, FDat_   in     date
, Txt_    in     varchar2
) is
  l_title        varchar2(70) := 'accreg.setAccountSob: ';
  l_id           acc_sob.id%type;
begin

  bars_audit.trace('%s params: Acc_=>%s, Id_=>%s, Isp_=>%s, FDat_=>%s, Txt_=>%s',
        l_title, to_char(Acc_), to_char(Id_), to_char(Isp_), to_char(FDat_,'dd.MM.yyyy'), Txt_);

  if Acc_ is not null
  then

    if Id_ is not null
    then

      bars_audit.trace('%s set act %s for acc %s', l_title, to_char(Id_), to_char(Acc_));

      update acc_sob set isp=Isp_, fdat=FDat_, txt=Txt_
       where Acc=Acc_ AND id=Id_ ;

      bars_audit.trace('%s act %s for acc %s is set', l_title, to_char(Id_), to_char(Acc_));

    else

      bars_audit.trace('%s inserting act for acc %s', l_title, to_char(Acc_));

      l_id := s_acc_sob.nextval;

      insert
        into ACC_SOB ( ACC, ID, ISP, FDAT, TXT )
      values ( Acc_, l_id, Isp_, FDat_, Txt_ );

      bars_audit.trace( '%s act for acc %s inserted', l_title, to_char(Acc_) );

    end if;

  end if;

end setAccountSob;

--***************************************************************************--
-- Procedure   : changeAccountOwner
-- Description : процедура перерегистрации счета на другого контрагента
--***************************************************************************--
procedure changeAccountOwner (Acc_ number, RnkA_ integer, RnkB_ integer)
is
  l_count   number;
  ern       number := 2;
  --        '9207 - Модульний рахунок! Неможливо перереєструвати на iншого контрагента' ;
  err       EXCEPTION;
  l_title   varchar2(70) := 'accreg.changeAccountOwner: ';

  procedure p_check_bpk(p_table varchar2, p_col varchar2)
  is
  begin
     execute immediate
     'select count(*) ' ||
     '  from ' || p_table || ' o, accounts a ' ||
     ' where o.' || p_col || ' = a.acc ' ||
     '   and a.rnk=' ||RnkA_ || ' and a.acc=' || Acc_ into l_count;
     if l_count > 0 then
        raise err;
     end if;
  end;

begin

  bars_audit.trace('%s params: Acc_=>%s, RnkA_=>%s, RnkB_=>%s',
       l_title, to_char(Acc_), to_char(RnkA_), to_char(RnkB_));

  begin
     select 1 into l_count from accounts where acc = Acc_ and rnk = RnkA_;
  exception when no_data_found then
     raise_application_error(-20000, 'Account not found or account don''t registered on rnk ' || RnkA_);
  end;

  select count(*) into l_count
    from cc_deal d, cc_add a
   where d.rnk=RnkA_ and d.nd=a.nd and (a.accs=Acc_ or a.accp=Acc_) ;

  bars_audit.trace('%s cc_deal: count=>%s', l_title, to_char(l_count));

  if l_count > 0
  then
    raise err;
  end if;

  select count(*) into l_count
    from dpt_deposit
   where rnk=RnkA_ and acc=Acc_ ;

  bars_audit.trace('%s dpt: count=>%s', l_title, to_char(l_count));

  if l_count > 0 then
     raise err;
  end if;

  select count(*)
    into l_count
    from dpt_deposit_clos
   where rnk=RnkA_ and acc=Acc_ ;

  if l_count > 0
  then
    raise err;
  end if;

  begin
     execute immediate
       'select count(*) from social_contracts
         where rnk=' || RnkA_ || ' and acc=' || Acc_ into l_count;

     if l_count > 0 then
        raise err;
     end if;

  exception when others then
     -- таблица или представление пользователя не существует
     if ( sqlcode = -00942 ) then null;
     else raise;
     end if;
  end;

  select count(*) into l_count
    from e_deal e, accounts a
   where e.rnk=RnkA_ and (e.nls36=a.nls or e.nls26=a.nls) and a.kv=980
     and a.acc=Acc_ ;

  bars_audit.trace('%s e_deal: count=>%s', l_title, to_char(l_count));

  if l_count > 0
  then
    raise err;
  end if;

  p_check_bpk('bpk_acc', 'acc_pk');
  p_check_bpk('bpk_acc', 'acc_ovr');
  p_check_bpk('bpk_acc', 'acc_tovr');
  p_check_bpk('bpk_acc', 'acc_3570');
  p_check_bpk('bpk_acc', 'acc_2208');
  p_check_bpk('bpk_acc', 'acc_2207');
  p_check_bpk('bpk_acc', 'acc_3579');
  p_check_bpk('bpk_acc', 'acc_2209');

  p_check_bpk('w4_acc', 'acc_pk');
  p_check_bpk('w4_acc', 'acc_ovr');
  p_check_bpk('w4_acc', 'acc_9129');
  p_check_bpk('w4_acc', 'acc_3570');
  p_check_bpk('w4_acc', 'acc_2208');
  p_check_bpk('w4_acc', 'acc_2627');
  p_check_bpk('w4_acc', 'acc_2207');
  p_check_bpk('w4_acc', 'acc_3579');
  p_check_bpk('w4_acc', 'acc_2209');
  p_check_bpk('w4_acc', 'acc_2625x');
  p_check_bpk('w4_acc', 'acc_2625d');
  p_check_bpk('w4_acc', 'acc_2628');
  p_check_bpk('w4_acc', 'acc_2203');

  bars_audit.trace('%s set new rnk %s for acc %s', l_title, to_char(RnkB_), to_char(Acc_));

  update accounts set rnk=RnkB_ where acc=Acc_ ;

  bars_audit.trace('%s new rnk %s for acc %s is set', l_title, to_char(RnkB_), to_char(Acc_));

exception when err then
   bars_error.raise_error(g_modcode, ern);

end changeAccountOwner;

--***************************************************************************--
-- Procedure   : check_account
-- Params      :
--   p_acc   in  - acc счета
--   p_msg   out - текстовое сообщение
--   p_check out - =0-предупреждение, =1-ошибка
-- Description : процедура для всяческих проверок
--***************************************************************************--
procedure check_account (
  p_acc   in  accounts.acc%type,
  p_msg   out varchar2,
  p_check out number )
is
$if ACC_PARAMS.KOD_D6
$then
  l_nbs   accounts.nbs%type;
  l_ise   customer.ise%type;	-- k070
  l_fs    customer.fs%type;	-- k080
  l_ved   customer.ved%type;	-- k110
  l_sed   customer.sed%type;	-- k051
  l_k071  kl_k070.k071%type;
  l_k072  kl_k070.k072%type;
  l_k051  kl_k051.k051%type;
  l_k111  kl_k110.k111%type;
  s_k071  varchar2(500);
  s_k072  varchar2(500);
  s_k051  varchar2(500);
  s_k111  varchar2(500);
  s_tmp   varchar2(500);
  l_txt   varchar2(2000);
  i       number;
  l_d6    number := 0;		-- проверка на kod_d6
$end
  l_title  varchar2(70) := 'accreg.check_account: ';
begin

  bars_audit.trace('%s params: p_acc=>%s', l_title, to_char(p_acc));

  p_msg   := null;
  p_check := 0;

$if ACC_PARAMS.KOD_D6
$then
   begin
      select a.nbs, c.ise, c.fs, c.ved, c.sed
        into l_nbs, l_ise, l_fs, l_ved, l_sed
        from accounts a, customer c
       where a.acc = p_acc
         and a.rnk = c.rnk;

      bars_audit.trace('%s en: nbs=>%s, ise=>%s, fs=>%s, ved=>%s, sed=>%s',
         l_title, l_nbs, l_ise, l_fs, l_ved, l_sed);

      l_k051 := substr(l_sed,1,2);

      select min(k071), min(k072) into l_k071, l_k072 from kl_k070 where k070 = l_ise;

      select min(k111) into l_k111 from kl_k110 where k110 = l_ved;

      bars_audit.trace('%s en: k071=>%s, k072=>%s, k051=>%s, k111=>%s',
         l_title, l_k071, l_k072, l_k051, l_k111);

      l_txt := '';

      for k in ( select k071, k072, k051, k111
                   from kod_d6
                  where r020 = l_nbs
                    and d_open <= bankdate
                    and ( d_close is null or d_close > bankdate) )
      loop
         bars_audit.trace('%s kod_d6: l_d6=>%s, k071=>%s, k072=>%s, k051=>%s, k111=>%s',
            l_title, to_char(l_d6), k.k071, k.k072, k.k051, k.k111);

         if l_d6 = 0 then
            if k.k071 is not null and l_k071 is not null then
               s_k071 := '''' || k.k071 || '''';
               l_txt  := '''' || l_k071 || ''' = ' || s_k071;
            end if;

            s_k072 := trim(k.k072);
            s_tmp := '';
            i := instr(s_k072,',');
            while i > 0 loop
               s_tmp  := s_tmp || '''' || substr(s_k072, 1, i-1) || '''';
               s_k072 := substr(s_k072, i+1, length(s_k072)-i);
               i := instr(s_k072,',');
               if i > 0 then s_tmp := s_tmp || ','; end if;
            end loop;
            s_k072 := s_tmp;
            if k.k072 is not null and l_k072 is not null then
               if l_txt is not null then
                  l_txt := l_txt || ' and ';
               end if;
               l_txt := l_txt || '''' || l_k072 || ''' in (' || s_k072 || ')';
            end if;

            s_k051 := trim(k.k051);
            s_tmp := '';
            i := instr(s_k051,',');
            while i > 0 loop
               s_tmp  := s_tmp || '''' || substr(s_k051, 1, i-1) || '''';
               s_k051 := substr(s_k051, i+1, length(s_k051)-i);
               i := instr(s_k051,',');
               if i > 0 then s_tmp := s_tmp || ','; end if;
            end loop;
            s_k051 := s_tmp;
            if k.k051 is not null and l_k051 is not null then
               if l_txt is not null then
                  l_txt := l_txt || ' and ';
               end if;
               l_txt := l_txt || '''' || l_k051 || ''' in (' || s_k051 || ')';
            end if;

            s_k111 := trim(k.k111);
            s_tmp := '';
            i := instr(s_k111,',');
            while i > 0 loop
               s_tmp  := s_tmp || '''' || substr(s_k111, 1, i-1) || '''';
               s_k111 := substr(s_k111, i+1, length(s_k111)-i);
               i := instr(s_k111,',');
               if i > 0 then s_tmp := s_tmp || ','; end if;
            end loop;
            s_k111 := s_tmp;
            if k.k111 is not null and l_k111 is not null then
               if l_txt is not null then
                  l_txt := l_txt || ' and ';
               end if;
               l_txt := l_txt || '''' || l_k111 || ''' in (' || s_k111 || ')';
            end if;

            bars_audit.trace('%s condition for query: l_txt=>%s', l_title, l_txt);

            if l_txt is not null then
               execute immediate 'select count(*) from dual where ' || l_txt into l_d6;
            end if;

          end if;

      end loop;

      if l_d6 = 0 and l_txt is not null then
         -- Недопустимое сочетание БС и эк.нормативов клиента по справочнику kod_d6
         p_msg := bars_msg.get_msg(g_modcode, 'MSG_KOD_D6');
      end if;

      p_check := 0;

      bars_audit.trace('%s out params: p_msg=>%s, p_check=>%s', l_title, p_msg, to_char(p_check));

   exception when no_data_found then null;

   end;
$end

end check_account;

--
--
--
procedure closeAccount
( p_acc         in accounts.acc%type,
  p_info       out varchar2,
  p_can_close  out number )
-- после выполнения процедуры:
-- если p_info is not null and p_can_close
--   (p_info-здесь указана причина, почему счет не закрывается,
--    p_can_close=1 - счет все-таки можно закрыть, но желательно спросить)
-- для след. вариантов счет закрывать можно:
--   недоначислены %% ! Продолжать закрытие счета?
--   Счет начисления %% может еще быть задействован! Продолжать закрытие счета?
is
  title      constant varchar2(64) := $$PLSQL_UNIT || '.CloseAccount';
  l_bankdate date;
  l_ostc     accounts.ostc%type;
  l_ostb     accounts.ostb%type;
  l_ostf     accounts.ostf%type;
  l_dapp     accounts.dapp%type;
  l_dappQ    accounts.dappq%type;
  l_dazs     accounts.dazs%type;
  l_daos     accounts.daos%type;
  l_kv       accounts.kv%type;
  l_nls      accounts.nls%type;
  l_nbs      accounts.nbs%type;
  l_tip      accounts.tip%type;
  l_rnk      accounts.rnk%type;
begin

  bars_audit.info( title||': Entry with ( p_acc=>'||to_char(p_acc)||' ).' );

  DBMS_APPLICATION_INFO.SET_ACTION( title );

  -- признак: счет закрывать нельзя
  p_can_close := 0;
  p_info      := '';

  l_bankdate := bankdate;

  begin

    select a.OSTC, a.OSTB, a.OSTF, a.DAPP, a.DAPPQ, a.DAZS, a.DAOS, a.KV, a.NLS, a.TIP
      into l_ostc, l_ostb, l_ostf, l_dapp, l_dappQ, l_dazs, l_daos, l_kv, l_nls, l_tip
      from ACCOUNTS a
     where a.ACC = p_acc;

    case
    when ( l_ostc <> 0 )
    then p_info := 'Счет ' || l_nls || ': ненулевой остаток (Ф)';
    when l_ostb <> 0 
    then p_info := 'Счет ' || l_nls || ': ненулевой остаток (П)';
    when l_ostf <> 0 
    then p_info := 'Счет ' || l_nls || ': ненулевой остаток (Б)';
    when l_dazs is not null 
    then p_info := 'Счет ' || l_nls || ': уже закрыт';
    when l_daos > l_bankdate 
    then p_info := 'Счет ' || l_nls || ': нельзя закрыть датой, меньшей даты открытия '||to_char(l_daos,'dd.mm.yyyy');
    when l_dapp >= l_bankdate 
    then p_info := 'Счет ' || l_nls || ': нельзя закрыть датой, меньшей даты последнего движения по счету '||to_char(l_dapp,'dd.mm.yyyy');
    when ( l_kv <> GL.baseval and l_dappQ >= l_bankdate )
    then p_info := 'Счет ' || l_nls || ': нельзя закрыть датой, меньшей даты последней переоценки '||to_char(l_dappQ,'dd.mm.yyyy');
    else p_can_close := 1; -- признак: счет закрывать можно
    end case;

    if ( p_can_close = 1 and SubStr(l_tip,1,2) = 'W4' )
    then

      select count(1)
        into p_can_close
        from ACCOUNTS
       where ACC in ( select ACC_ID
                        from ( select ACC_2203, ACC_2207, ACC_2208, ACC_2209, ACC_2625X
                                    , ACC_2627, ACC_2628, ACC_3570, ACC_3579, ACC_2627X
                                    , ACC_9129, ACC_2625D, ACC_OVR
                                 from W4_ACC
                                where ACC_PK = p_acc
                              ) unpivot ( ACC_ID FOR ACC_FILD IN ( ACC_2203, ACC_2207, ACC_2208, ACC_2209, ACC_2625X
                                                                 , ACC_2627, ACC_2628, ACC_3570, ACC_3579, ACC_2627X
                                                                 , ACC_9129, ACC_2625D, ACC_OVR ) )
                    )
         and OSTC <> 0;

      if ( p_can_close > 0 )
      then
        p_can_close := 0;
        p_info      := 'Заборонено закриття рахунку ' || l_nls || ': наявні залишки на інших рахунках договору БПК';
      else
        p_can_close := 1;
      end if;

    end if;

    if p_can_close = 1
    then

      for k in ( select i.acra, i.acr_dat, i.stp_dat,
                        a.ostc, a.ostb, a.ostf, a.dapp, a.nls
                   from accounts a, int_accn i
                  where i.acc   = p_acc
                    and i.acra <> p_acc
                    and i.acra  = a.acc
                    and a.dazs is null )
      loop
        -- счет закрывать нельзя
        p_can_close := 0;

        if k.ostc <> 0 then
           p_info := 'Счет начисления %% ' || k.nls || ': ненулевой остаток (Ф)';
        elsif k.ostb <> 0 then
           p_info := 'Счет начисления %% ' || k.nls || ': ненулевой остаток (П)';
        elsif k.ostf <> 0 then
           p_info := 'Счет начисления %% ' || k.nls || ': ненулевой остаток (Б)';
        elsif l_dapp = l_bankdate then
           p_info := 'Счет начисления %% ' || k.nls || ': имеет обороты';
        elsif ( (k.stp_dat is null and l_bankdate > k.acr_dat)
             or (k.stp_dat is not null and k.stp_dat > k.acr_dat) ) then
           p_info := 'Счет начисления %% ' || k.nls || ': недоначислены %%';
           -- счет закрывать можно
           p_can_close := 1;
        elsif k.dapp > k.acr_dat then
           p_info := 'Счет начисления %% ' || k.nls || ' может еще быть задействован!';
           -- счет закрывать можно
           p_can_close := 1;
        else
           -- счет закрывать можно
           p_can_close := 1;
           p_info      := '';
        end if;

        if p_can_close = 1 
        then
          
          update accounts
             set dazs = l_bankdate
           where acc = k.acra;

          update int_accn
             set stp_dat = l_bankdate,
                 acr_dat = l_bankdate
           where acc = p_acc
             and acra = k.acra;
         
        end if;

      end loop;

    end if;

    if ( p_can_close = 1 )
    then

      update ACCOUNTS a
         set a.DAZS = l_bankdate
       where a.ACC  = p_acc
      return a.NBS, a.RNK
        into l_nbs, l_rnk;

      if ( l_daos < to_date('01.09.2015','dd.mm.yyyy') and 
           l_nbs in ('2512','2513','2520','2523','2525'
                    ,'2526','2530','2531','2541','2542'
                    ,'2544','2545','2546','2552','2553'
                    ,'2554','2555','2560','2561','2562'
                    ,'2565','2570','2571','2572','2600'
                    ,'2601','2602','2603','2604','2605'
                    ,'2610','2611','2640','2641','2642'
                    ,'2643','2644','2650','2651','2655') )
      then -- COBUSUPABS-3939
        merge
         into SPECPARAM s
        using DUAL
           on ( s.ACC = p_acc )
         when matched
         then update
          set NKD = coalesce( s.NKD, to_char(l_rnk)||'_'||to_char(sysdate,'ddmmyyyy')||'_'||to_char(sysdate,'hh24miss') )
         when not matched
         then insert ( ACC, NKD )
              values ( p_acc, to_char(l_rnk)||'_'||to_char(sysdate,'ddmmyyyy')||'_'||to_char(sysdate,'hh24miss') );
      end if;

    end if;

  exception
    when no_data_found then
      p_can_close := 0;
      p_info      := 'Счет #' || to_char(p_acc) || ' не найден!';
  end;

  bars_audit.trace( '%s: Exit.', title );

  DBMS_APPLICATION_INFO.SET_ACTION( null );

end closeAccount;

--
--
--
procedure P_ACC_RESTORE
( p_acc   in number
, p_daos  in date default null
) is
  title      constant varchar2(64) := $$PLSQL_UNIT || 'P_ACC_RESTORE';
  l_dapp     date;
  l_acc_tp   accounts.tip%type;
  l_r020     accounts.nbs%type;
  l_rnk      accounts.rnk%type;
  l_active   number(1);
begin

  DBMS_APPLICATION_INFO.SET_ACTION( 'ACCREG.RestoreAccount' );

  bars_audit.info( title||': Entry with ( p_acc=>'||to_char(p_acc)
                        ||', p_daos=>'||to_char(p_daos,'dd.mm.yyyy')||' ).' );

  begin
    select nvl(a.NBS,SubStr(a.NLS,1,4)), a.TIP, a.RNK
      into l_r020, l_acc_tp, l_rnk
      from ACCOUNTS a
     where a.ACC = p_acc;
  exception
    when no_data_found then
      bars_error.raise_nerror( g_modcode, 'ACC_NOT_FOUND' );
  end;

  begin
    select DATE_OFF
      into l_dapp
      from CUSTOMER
     where RNK = l_rnk
       and DATE_OFF Is Null;
  exception
    when no_data_found then
      bars_error.raise_error( g_modcode, 41, to_char(l_rnk) );
  end;

  begin
    select D_CLOSE
      into l_dapp
      from PS
     where NBS = l_r020
       and lnnvl( D_CLOSE <= GL.GBD() );
  exception
    when no_data_found then
      bars_error.raise_nerror( g_modcode, 'INVALID_R020', l_r020 );
  end;

  -- если нужно поменять дату открытия счета, проверим дату последнего движения:
  -- дата открытия счета д.б. <= даты последнего движения
  if ( p_daos is not null )
  then

    select min(FDAT)
      into l_dapp
      from SALDOA
     where ACC  = p_acc
       and FDAT < p_daos;

    if ( ( l_dapp is not null ) and ( l_dapp < p_daos ) )
    then
      bars_error.raise_nerror( g_modcode, 'ACC_DAOS_DAPP', to_char(p_daos,'dd.MM.yyyy'), to_char(l_dapp,'dd.MM.yyyy') );
    end if;

  end if;

  if ( l_acc_tp in ('DEP','DEN','NL8') )
  then -- реанімування рахунків депозитних портфелів заборонена!

    select case
           when exists ( select 1 -- депозитний портфель ФО
                           from DPT_ACCOUNTS a
                           join DPT_DEPOSIT  d
                             on ( d.DEPOSIT_ID = a.DPTID )
                          where a.ACCID = p_acc )
           then 1
           when exists ( select 1 -- депозитний портфель ЮО
                           from DPU_ACCOUNTS a
                           join DPU_DEAL     d
                             on ( d.DPU_ID = a.DPUID and d.CLOSED = 0 )
                          where a.ACCID  = p_acc )
           THEN 1
           ELSE 0
           END
      into l_active
      from DUAL;

    if (l_active = 0)
    then
      raise_application_error( -20444, 'Заборонено реанімувати рахунок, що належить закритому депозитному договору!', TRUE );
    end if;

  end if;

  update ACCOUNTS
     set DAZS = null,
         DAOS = nvl(p_daos,DAOS)
   where ACC  = p_acc;

  if ( substr(l_acc_tp,1,2) = 'W4' )
  then -- реанімуємо договір БПК якому належить реанімуємий рахунок 2625
    update W4_ACC
       set DAT_CLOSE = NULL
     where ACC_PK = p_acc
       and DAT_CLOSE IS NOT NULL;
  end if;

  bars_audit.trace( '%s: Exit.', title );

  DBMS_APPLICATION_INFO.SET_ACTION( null );

end p_acc_restore;

--
-- Reservation of the account number
--
procedure RSRV_ACC_NUM
( p_nls      in     accounts_rsrv.nls%type
, p_kv       in     accounts_rsrv.kv%type
, p_nms      in     accounts_rsrv.nms%type
, p_branch   in     accounts_rsrv.branch%type
, p_isp      in     accounts_rsrv.isp%type
, p_vid      in     accounts_rsrv.vid%type
, p_rnk      in     accounts_rsrv.rnk%type
, p_agrm_num in     accounts_rsrv.agrm_num%type default null -- номер договору банківського обслуговування
, p_trf_id   in     accounts_rsrv.trf_id%type   default null -- код тарифного пакету
, p_ob22     in     accounts_rsrv.ob22%type     default null
, p_errmsg      out varchar2
) is
  title    constant varchar2(64) := $$PLSQL_UNIT || 'RSRV_ACC_NUM';
  l_rsrv_id         accounts_rsrv.rsrv_id%type;
  l_agrm_num        accounts_rsrv.agrm_num%type;
begin

  bars_audit.trace( '%s: Entry with ( p_nls=>%s, p_kv=>%s, p_nms=>%s, p_branch=>%s, p_isp=>%s, p_rnk=>%s ).'
                  , title, p_nls, to_char(p_kv), p_nms, p_branch, to_char(p_isp), to_char(p_rnk) );

  case
  when ( p_nls Is Null )
  then p_errmsg := 'Не вказано номер рахунку!';
  when ( p_kv  Is Null )
  then p_errmsg := 'Не вказано валюту рахунку!';
  when ( p_rnk Is Null )
  then p_errmsg := 'Не вказано РНК власника рахунку!';
--when ( l_agrm_num Is Null )
--then p_errmsg := 'Не вказано номер договору банківського обслуговування!';
  when ( p_trf_id   Is Null )
  then p_errmsg := 'Не вказано код тарифного пакету';
  else

    if ( p_agrm_num Is Null )
    then
      l_agrm_num := KL.GET_CUSTOMERW( p_rnk, 'NDBO' );
    else
      l_agrm_num := p_agrm_num;
      if ( p_agrm_num <> KL.GET_CUSTOMERW( p_rnk, 'NDBO' ) )
      then
$if ACC_PARAMS.MMFO
$then
        EAD_PACK.MSG_CREATE( 'UAGR', 'ACC;'||to_char(l_rsrv_id)||';RSRV', p_rnk, GL.KF() );
$else
        EAD_PACK.MSG_CREATE( 'UAGR', 'ACC;'||to_char(l_rsrv_id)||';RSRV' );
$end
      end if;
    end if;

    begin

      insert
        into ACCOUNTS_RSRV
           ( NLS, KV, NMS, BRANCH, ISP, RNK, AGRM_NUM, TRF_ID, OB22, VID
           , USR_ID, CRT_DT, RSRV_ID )
      values
           ( p_nls, p_kv, p_nms, p_branch, p_isp, p_rnk, l_agrm_num, p_trf_id, nvl(p_ob22,'01'), nvl(p_vid,0)
           , GL.USR_ID(), SYSDATE, S_ACCOUNTS_RSRV.NEXTVAL )
      return RSRV_ID
        into l_rsrv_id;

$if ACC_PARAMS.MMFO
$then
      EAD_PACK.MSG_CREATE( 'UACC', 'ACC;'||to_char(l_rsrv_id)||';RSRV', p_rnk, GL.KF() );
$else
      EAD_PACK.MSG_CREATE( 'ACC', 'ACC;'||to_char(l_rsrv_id)||';RSRV' );
$end

    exception
      when DUP_VAL_ON_INDEX then
        p_errmsg := 'Номер рахунку '||p_nls||' з кодом валюти '||p_kv||' вже зарезервовано!';
      when others then
        p_errmsg := sqlerrm;
    end;

    if ( p_errmsg Is Not Null )
    then
      bars_audit.error( title||': '||p_errmsg );
    end if;

  end case;

  bars_audit.trace( '%s: Exit with p_errmsg=>%s.', title, p_errmsg );

end RSRV_ACC_NUM;

--
-- Cancellation of the account number reservation
--
procedure CNCL_RSRV_ACC_NUM
( p_nls      in     accounts_rsrv.nls%type
, p_kv       in     accounts_rsrv.kv%type
-- , p_errmsg      out varchar2
) is
  title    constant varchar2(64) := $$PLSQL_UNIT || 'CNCL_RSRV_ACC_NUM';
  p_errmsg          varchar2(2048);
begin

  bars_audit.trace( '%s: Entry with ( p_nls=>%s, p_kv=>%s ).'
                  , title, p_nls, to_char(p_kv) );

  begin
    delete ACCOUNTS_RSRV
     where NLS = p_nls
       and KV  = p_kv;
--  if (sql%rowcount=0)
--  then
--    p_errmsg := 'Account number '||p_nls||'/'||to_char(p_kv)|| ' hasn`t been reserved';
--  end if;
  exception
    when others then
      p_errmsg := sqlerrm;
      bars_audit.error( title||': '||p_errmsg );
  end;

  bars_audit.trace( '%s: Exit with p_errmsg=>%s.', title, p_errmsg );

end CNCL_RSRV_ACC_NUM;

--***************************************************************************--
-- Procedure   : p_reserve_acc
-- Description : процедура резервирования номера счета (открытие счета и сразу закрытие)
--***************************************************************************--
procedure P_RESERVE_ACC
( p_acc      in out accounts.acc%type
, p_rnk      in     accounts.rnk%type                 -- Customer number
, p_nls      in     accounts.nls%type                 -- Account  number
, p_kv       in     accounts.kv%type                  -- Currency code
, p_nms      in     accounts.nms%type                 -- Account name
, p_tip      in     accounts.tip%type                 -- Account type
, p_grp      in     accounts.grp%type                 --
, p_isp      in     accounts.isp%type                 --
, p_pap      in     accounts.pap%type    default null --
, p_vid      in     accounts.vid%type    default null --
, p_pos      in     accounts.pos%type    default null --
, p_blkd     in     accounts.blkd%type   default null --
, p_blkk     in     accounts.blkk%type   default null --
, p_lim      in     accounts.lim%type    default null --
, p_ostx     in     accounts.ostx%type   default null --
, p_nlsalt   in     accounts.nlsalt%type default null --
, p_branch   in     accounts.branch%type default null --
, p_ob22     in     accounts.ob22%type   default null -- OB22
, p_agrm_num in     accountsw.value%type default null -- номер договору банківського обслуговування
, p_trf_id   in     sh_tarif.ids%type    default null -- код тарифного пакету
) is
  l_acc             accounts.acc%type;
  l_errmsg          varchar2(2048);
begin

  bars_audit.trace( $$PLSQL_UNIT || 'P_RESERVE_ACC: Entry with ( p_rnk=%s, p_nls=%s, p_kv=%s ).', to_char(p_rnk), p_nls, to_char(p_kv) );

  RSRV_ACC_NUM
  ( p_nls      => p_nls
  , p_kv       => p_kv
  , p_nms      => p_nms
  , p_branch   => p_branch
  , p_isp      => p_isp
  , p_vid      => p_vid
  , p_rnk      => p_rnk
  , p_agrm_num => p_agrm_num
  , p_trf_id   => p_trf_id
  , p_ob22     => p_ob22
  , p_errmsg   => l_errmsg
  );

  if ( l_errmsg Is Not Null )
  then
    raise_application_error( -20666, l_errmsg, true );
  end if;

  bars_audit.trace( $$PLSQL_UNIT || 'P_RESERVE_ACC: Exit.' );

end p_reserve_acc;

--
--
--
procedure REJECT_RESERVE_ACC
( p_nls      in     accounts_rsrv.nls%type
, p_kv       in     accounts_rsrv.kv%type
, p_errmsg      out varchar2
) is
  l_rnk             accounts.rnk%type;
  l_acc             accounts.acc%type;
begin

  bars_audit.trace( $$PLSQL_UNIT || 'REJECT_RESERVE_ACC: Entry with ( p_nls=%s, p_kv=%s ).', p_nls, to_char(p_kv) );

  begin

    -- на перехідний період (існують відкритто-закритті рах.)
    select a.ACC
      into l_acc
      from ACCOUNTS a
     where a.NLS  = p_nls
       and a.KV   = p_kv
       and a.DAZS Is Not Null
       and a.DAZS = a.DAOS;

    update ACCOUNTSW
       set VALUE = null
     where ACC   = l_acc
       and TAG   = 'RESERVED'
       and VALUE = '1';

    if ( sql%rowcount > 0 )
    then

      begin
        select to_number(VAL)
          into l_rnk
          from PARAMS
         where PAR = 'OUR_RNK';
      exception
        when NO_DATA_FOUND then
          l_rnk := 1;
$if ACC_PARAMS.MMFO
$then
          l_rnk := to_number( BARS_SQNC.RUKEY( l_rnk ) );
$end
      end;

      update ACCOUNTS
         set RNK = l_rnk
       where ACC = l_acc;

      setAccountSParam( l_acc, 'NKD',   null );
      setAccountwParam( l_acc, 'SHTAR', null );

    end if;

  exception
    when NO_DATA_FOUND then
      null;
  end;

  CNCL_RSRV_ACC_NUM
  ( p_nls => p_nls
  , p_kv  => p_kv
  );

  bars_audit.trace( $$PLSQL_UNIT || 'REJECT_RESERVE_ACC: Exit with ( p_errmsg = %s ).', p_errmsg );

end REJECT_RESERVE_ACC;

--
--
--
procedure CHECK_USER_PERMISSIONS (
  p_acc in  accounts.acc%type,
  p_nbs in  ps.nbs%type,
  p_rez out integer,  -- 1 - відкривати/редагувати; 2 - резервувати/переглядати
  p_msg out varchar2
) is
  l_flag     integer;
  l_nbs      ps.nbs%type;
  l_cnt_nbs  integer;
  l_branch   staff$base.branch%type;
begin

  begin
$if ACC_PARAMS.MMFO
$then
    l_flag := to_number(BRANCH_ATTRIBUTE_UTL.GET_VALUE('ACC_REZ'));
$else
    l_flag := F_GET_PARAMS('ACC_REZ',0);
$end
  exception
    when others then
      l_flag := 0;
  end;

  if l_flag = 0
  then
    p_rez := 1;
    p_msg := '';
  else

    if p_acc > 0
    then
      select nvl(nbs,substr(nls, 1, 4)) into l_nbs from accounts where acc = p_acc;
    else
      l_nbs := p_nbs;
    end if;

    select count(nbs) into l_cnt_nbs
      from NBS_FRONT_OFFICE where nbs = l_nbs;

    if l_cnt_nbs = 0
    then -- рахунок що аналізується не входить в перелік
      p_rez := 1;
      p_msg := '';
    else
      -- select branch into l_branch from staff$base where id = bars.user_id();
      l_branch := sys_context('bars_context','user_branch');
      case
        when length(l_branch) = 22 then -- бранч третього рівня
          p_rez := 2;
          p_msg := '';
        else
          p_rez := 1;
          p_msg := '';
      end case;
    end if;

  end if;

end CHECK_USER_PERMISSIONS;

procedure CHECK_USER_PERMISSIONS
( p_nbs   in    accounts.nbs%type
) is
  l_flag    number(1);
  l_branch  staff$base.branch%type;
begin

  begin
    l_flag := to_number(GET_GLOBAL_PARAM('ACC_REZ'));
  exception
    when others then
      l_flag := 0;
  end;

  if ( l_flag > 0 )
  then

    begin
      select 1
        into l_flag
        from NBS_FRONT_OFFICE
       where NBS = p_nbs;
    exception
      when NO_DATA_FOUND then
        l_flag := 0;
    end;

    if ( l_flag > 0 )
    then -- бал. рах. входить в перелік
      -- select branch into l_branch from staff$base where id = bars.user_id();
      l_branch := sys_context('bars_context','user_branch');
      case
        when length(l_branch) = 22 then -- бранч третього рівня
          raise_application_error(-20666, 'Користувач не належить до Бек-офісу', true);
        else
          null;
      end case;
    end if;

  end if;

end CHECK_USER_PERMISSIONS;

--***************************************************************************--
-- Procedure   : p_unreserve_acc
-- Description : перевод счета из статуса "Резерв" в "Открытый"
--***************************************************************************--
procedure P_UNRESERVE_ACC
( p_nls      in     accounts.nls%type
, p_kv       in     accounts.kv%type
, p_acc         out accounts.acc%type
) is
  l_rnk             accounts.rnk%type;
  l_nbs             accounts.nbs%type;
  l_ob22            accounts.ob22%type;
  l_nms             accounts.nms%type;
  l_vid             accounts.vid%type;
  l_blkd            accounts.blkd%type;
  l_branch          accounts.branch%type;
  l_agrm_num        specparam.nkd%type;
  l_trf_id          accountsw.value%type;
  l_msg             varchar2(2048);
begin

  begin
    select r.NMS, r.BRANCH, r.RNK, r.VID, r.AGRM_NUM, SubStr(r.NLS,1,4), r.OB22, to_char(r.TRF_ID)
      into l_nms, l_branch, l_rnk, l_vid, l_agrm_num, l_nbs, l_ob22, l_trf_id
      from ACCOUNTS_RSRV r
     where r.NLS = p_nls
       and r.KV  = p_kv;
  exception
    when NO_DATA_FOUND then
      raise_application_error( -20000, 'Номер рахунку '||p_nls||'('||to_char(p_kv)||') не зарезервовано!' );
  end;

  CHECK_USER_PERMISSIONS( l_nbs );

  l_msg := KL.GET_EMPTY_ATTR_FOROPENACC(l_rnk);

  if ( l_msg is not null )
  then
    raise_application_error( -20000, 'Для відкриття рахунку в картці клієнта необхідно заповнити поля:' || chr(10) || l_msg );
  end if;

  -- проверка балансовго счёта на пренадлежность к ДПА COBUMMFO-5343
  if ( BARS_DPA.DPA_NBS( l_nbs, null ) = 1 )
  then
$if ACC_PARAMS.MMFO
$then
    l_blkd := to_number(BRANCH_ATTRIBUTE_UTL.GET_VALUE('DPA_BLK'));
$else
    l_blkd := F_GET_PARAMS('DPA_BLK',0);
$end
  end if;

  CNCL_RSRV_ACC_NUM
  ( p_nls => p_nls
  , p_kv  => p_kv
  );

  begin

    select a.ACC
      into p_acc
      from ACCOUNTS a
     where a.NLS = p_nls
       and a.KV  = p_kv;

    delete ACCOUNTSW
     where ACC   = p_acc
       and TAG   = 'RESERVED'
       and VALUE = '1';

    if ( sql%rowcount = 0 )
    then
      raise_application_error( -20000, 'Рахунок #'||to_char(p_acc)||' не є зарезервованим!' );
    end if;

    update ACCOUNTS a
       set a.DAOS = BANKDATE()
         , a.NBS  = l_nbs
         , a.DAZS = Null
         , a.ISP  = USER_ID()
         , a.BLKD = l_blkd
     where a.ACC  = p_acc;

  exception
    when NO_DATA_FOUND then
      OPN_ACC
      ( p_acc    => p_acc
      , p_rnk    => l_rnk
      , p_nbs    => l_nbs
      , p_ob22   => l_ob22
      , p_nls    => p_nls
      , p_nms    => l_nms
      , p_kv     => p_kv
      , p_isp    => USER_ID()
      , p_vid    => l_vid
      , p_branch => l_branch
      , p_blkd   => l_blkd
      );
  end;

  -- «Номер договору (ф.71)» - номер договору банківського обслуговування (ДБО)
  setAccountSParam( p_acc, 'NKD', l_agrm_num );

  -- «Код пакету тарифів»
  setAccountWParam( p_acc, 'SHTAR', l_trf_id );

  -- параметру «Код строку кред/деп рахунків (S180)» - значенням «1»;
  setAccountSParam( p_acc, 'S180', '1' );

  -- параметру «Спеціальний параметр (S181)» - значенням «1»
  setAccountSParam( p_acc, 'S181', '1' );

  -- параметру «Код строку «до погашення» (S240)» - значенням «1»;
  setAccountSParam( p_acc, 'S240', '1' );

  bars_audit.trace( $$PLSQL_UNIT || 'P_UNRESERVE_ACC: Exit.' );

end P_UNRESERVE_ACC;


procedure UNRSRV_ACC
( p_acc      in     accounts.acc%type
, p_kv       in     accounts.kv%type
, p_errmsg      out varchar2
) is
  title    constant varchar2(64) := $$PLSQL_UNIT||'.UNRSRV_ACC';
  l_main_nls        accounts.nls%type;
  l_main_rnk        accounts.rnk%type;
  l_rsrv_rnk        accounts_rsrv.rnk%type;
  l_acc             accounts.acc%type;
begin

  bars_audit.trace( '%s: Entry with ( p_acc=%s, p_kv=%s ).', title, to_char(p_acc), to_char(p_kv) );

  begin

    select NLS, RNK
      into l_main_nls
         , l_main_rnk
      from ACCOUNTS
     where ACC = p_acc;

    begin

      select RNK
        into l_rsrv_rnk
        from ACCOUNTS_RSRV r
       where r.NLS = l_main_nls
         and r.KV  = p_kv;

      if ( l_main_rnk = l_rsrv_rnk )
      then

        l_acc := p_acc;

        CNCL_RSRV_ACC_NUM
        ( p_nls    => l_main_nls
        , p_kv     => p_kv
        );

        DUPLICATE_ACC
        ( p_acc    => l_acc
        , p_kv     => p_kv
        , p_errmsg => p_errmsg
        );

      else
        p_errmsg := 'РНК вказаного рахунку #'||to_char(p_acc)||' не відповідає РНК зарезервованого рахунку '||l_main_nls||'/'||to_char(p_kv);
      end if;

    exception
      when NO_DATA_FOUND then
        p_errmsg := 'Номер рахунку '||l_main_nls||'/'||to_char(p_kv)||' не зарезервовано!';
    end;

  exception
    when NO_DATA_FOUND then
      p_errmsg := 'Не знайдено рахунок #'||to_char(p_acc);
  end;

  bars_audit.trace( '%s: Exit.', title );

end UNRSRV_ACC;

--
--
--
procedure DUPLICATE_ACC
( p_acc      in out accounts.acc%type
, p_kv       in     accounts.kv%type
, p_errmsg      out varchar2
) is
  title    constant varchar2(64) := $$PLSQL_UNIT||'.DUPLICATE_ACC';
  r_accounts        accounts%rowtype;
  r_specparam       specparam%rowtype;
  l_acc_id          accounts.acc%type;
begin

  bars_audit.trace( '%s: Entry with ( p_acc=%s, p_kv=%s ).', title, to_char(p_acc), to_char(p_kv) );

  begin

    select *
      into r_accounts
      from ACCOUNTS
     where ACC = p_acc;

    OPN_ACC
    ( p_acc    => l_acc_id
    , p_rnk    => r_accounts.RNK
    , p_nbs    => r_accounts.NBS
    , p_ob22   => r_accounts.OB22
    , p_nls    => r_accounts.NLS
    , p_nms    => r_accounts.NMS
    , p_kv     => p_kv
    , p_isp    => r_accounts.ISP
    , p_nlsalt => r_accounts.NLSALT
    , p_pap    => r_accounts.PAP
    , p_tip    => r_accounts.TIP
    , p_pos    => case when p_kv = gl.baseval then r_accounts.POS else 1 end
    , p_vid    => r_accounts.VID
    , p_branch => r_accounts.BRANCH
    , p_blkd   => r_accounts.BLKD
    , p_blkk   => r_accounts.BLKK
    , p_mdate  => r_accounts.MDATE
    , p_mode   => 77
    );

    -- наслідуємо групи доступу
    for g in ( select COLUMN_VALUE as GRP_ID
                 from table( sec.getAgrp( p_acc ) )
    ) loop
      sec.addAgrp( l_acc_id, g.GRP_ID );
    end loop;

    -- наслідуємо додаткові реквізити рахунка
    insert
      into ACCOUNTSW
         ( KF, ACC, TAG, VALUE )
    select KF, l_acc_id, TAG, VALUE
      from ACCOUNTSW
     where ACC = p_acc;

    -- наслідуємо спецпараметри рахунка
    begin

      select *
        into r_specparam
        from SPECPARAM
       where ACC = p_acc;

      r_specparam.ACC := l_acc_id;

      update SPECPARAM
         set ROW = r_specparam
       where ACC = r_specparam.ACC;

      if ( sql%rowcount = 0 )
      then
        insert
          into SPECPARAM
        values r_specparam;
      end if;

    exception
      when NO_DATA_FOUND then
        null;
    end;

  exception
    when NO_DATA_FOUND then
      p_errmsg := 'Не знайдено рахунок #'||to_char(p_acc);
    when OTHERS then
      p_errmsg := SubStr(sqlerrm,12);
      l_acc_id := null;
      bars_audit.error( title || ': ' || p_errmsg || chr(10)|| dbms_utility.format_error_stack() );
      rollback;
  end;

  p_acc := l_acc_id;

  bars_audit.trace( '%s: Exit with ( p_acc=%s, p_errmsg=%s  ).', title, to_char(p_acc), p_errmsg );

end DUPLICATE_ACC;

--
-- Получить умолчательное значение для спецпараметра
-- Алгоритм расчета зависит от модуля, определяется контекстом 'MODULE'; Необходимые переменные также берутся из контекста
--
function get_default_spar_value(p_acc    in accounts.acc%type,
                                p_spid in sparam_list.spid%type)
return varchar2
is
title     constant   varchar2(64) := $$PLSQL_UNIT||'.GET_DEFAULT_SPAR_VALUE';
l_module  varchar2(32);
l_acc_row accounts%rowtype;
l_result  varchar2(500);
begin
    l_module := pul.get('MODULE');
    bars_audit.trace(title||': start for acc #'||p_acc||', module ('||l_module||')'||' spid = '||p_spid);
    select * into l_acc_row from accounts where acc = p_acc;

    if p_spid = 1 then -- R011

        bars_audit.trace(title||': R011. Tip = '||l_acc_row.tip||', nbs='||l_acc_row.nbs);
        /* общее */
        if l_acc_row.nbs = '3578' and l_acc_row.tip in ('SK0', 'SK9') then
            l_result := '1';
            return l_result;
        elsif l_acc_row.nbs = '9129' and l_acc_row.tip = 'CR9' then
            l_result := '4';
            return l_result;
        end if;
        
        if l_module = 'CCK' then
            bars_audit.trace(title||': CCK. Tip = '||l_acc_row.tip);
            
            /* COBUMMFO-6175 автоматически определяем R011 при открытии счета */
            if trim(l_acc_row.tip) in ('SS', 'SDI', 'SN') then
                bars_audit.trace(title||': CCK. Ищем r011 по справочнику');
begin
                    select r011
                    into l_result
                    from cck_r011
                    where nbs = l_acc_row.nbs;
                exception
                    when no_data_found then
                        bars_audit.error(title || ': не найдено значение r011 в справочнике для балансового #'||l_acc_row.nbs);
                end;
                
            elsif l_acc_row.tip in ('SNO', 'SNA', 'SP ', 'SPN') then
                bars_audit.trace(title||': CCK. ND = '||pul.get('ND'));
                
                select s.r011
                into l_result
                from accounts a
                join nd_acc n on a.acc = n.acc and a.kf = n.kf and n.nd = pul.get('ND')
                join specparam s on a.acc = s.acc
                where
                (
                    l_acc_row.tip in ('SNO', 'SNA') and a.tip = 'SN '
                    or
                    l_acc_row.tip in ('SP ', 'SPN') and a.tip in ('SS ', 'SN ')
                )
                and (dazs is null or dazs > gl.bd)
                and rownum = 1;
            end if;
        elsif l_module = 'BPK' then
  null;
        end if;
    elsif p_spid = 2 then -- R013
        if l_module = 'CCK' then
            /* COBUMMFO-6282 автоматически определяем R013 при открытии счета */
            bars_audit.trace(title||': CCK. Tip = '||l_acc_row.tip);

            if l_acc_row.tip in ('SN ', 'SK0') then
                l_result := '2';
            elsif l_acc_row.tip in ('SPN', 'SK9', 'OFR') then
                l_result := '3';
            else
                begin
                    select r013
                    into l_result
                    from cck_r013
                    where nbs = l_acc_row.nbs
                    and   ob22 = case when ob22 = '-' then '-' else l_acc_row.ob22 end;
                exception
                    when no_data_found then
                        bars_audit.error(title || ': не найдено значение r013 в справочнике для балансового #'||l_acc_row.nbs||', ob22='||l_acc_row.ob22);
                end;
            end if;
        end if;
    end if;

    bars_audit.trace(title||': Result = '||l_result);
    return l_result;
end get_default_spar_value;

--
-- Проставить умолчательные значения для спецпараметров (по флагу sparam_list.def_flag = 'Y')
--
procedure set_default_sparams(p_acc in accounts.acc%type)
    is
title       constant   varchar2(64) := $$PLSQL_UNIT||'.SET_DEFAULT_SPARAMS';
begin
    bars_audit.trace(title||': start for acc #'||p_acc);
    for spar in (select *
                 from sparam_list s
                 where s.def_flag = 'Y')
    loop
        begin
            if spar.tabname in ('ACCOUNTSW') then
                setAccountwParam(p_acc, spar.tag, get_default_spar_value(p_acc, spar.spid));
            else
                setAccountSParam(p_acc, spar.name, get_default_spar_value(p_acc, spar.spid));
            end if;
        exception
            when others then
                bars_audit.error(title||': '||SubStr(sqlerrm,12)||' : '||dbms_utility.format_error_stack);
        end;
    end loop;
    bars_audit.trace(title||': finish for acc #'||p_acc);
end set_default_sparams;

begin
  null;
end ACCREG;
/

show errors

grant execute on ACCREG to BARS_ACCESS_DEFROLE;
