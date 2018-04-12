CREATE OR REPLACE PACKAGE BARS.GL
IS
--***************************************************************--
--                 General Ledger Package Header
--                 (C) Unity-BARS 2000-2013
--***************************************************************--
--
--***************************************************************--

  G_HEADER_VERSION  CONSTANT VARCHAR2(64)  := 'version 7.3  26/10/2017';

  G_AWK_HEADER_DEFS CONSTANT VARCHAR2(512) := '';

  p_notpaid         CONSTANT NUMBER := 0;
  p_booked          CONSTANT NUMBER := 1;
  p_forward         CONSTANT NUMBER := 3;
  p_cleared         CONSTANT NUMBER := 5;

  p_vp              CONSTANT CHAR(3) := 'VP ';
  p_vvp             CONSTANT CHAR(3) := 'VVP';

  aMFO     VARCHAR(12) DEFAULT NULL;  -- Local bank MFO
  aOKPO    VARCHAR(12) DEFAULT NULL;  -- Local bank TAX Code
  bDATE    DATE        DEFAULT NULL;  -- Current Banking day (local)
--gbDATE   DATE        DEFAULT NULL;  -- Current Banking day (global)
  vDATE    DATE        DEFAULT NULL;  -- Current Value date
  aUID     NUMBER      DEFAULT NULL;  -- current user id
  aUKF     VARCHAR2(6) DEFAULT NULL;  -- current user branch code
  baseval  NUMBER      DEFAULT 980 ;  -- Base Currency
  aRNK     NUMBER      DEFAULT 1   ;  -- Local bank RNK
  fRCVR    NUMBER      DEFAULT 0;     -- Recovery flag
  fSOS0    NUMBER      DEFAULT 0;     -- Normal=0/Clearing=1 transaction

  aREF     NUMBER      DEFAULT NULL;  -- current refrence
  aSTMT    NUMBER      DEFAULT 0;     -- current statement number
  aOROW    UROWID      DEFAULT NULL;  -- current opldok rowid
  aTT      CHAR(3)     DEFAULT NULL;  -- current tt
  aSOS     NUMBER      DEFAULT NULL;  -- current doc payment status
  aFMcheck SMALLINT    DEFAULT NULL;  -- FM-check status

  acc_rec  accounts%ROWTYPE;       -- Transit record of accounts update(TRIG)
  acc_otm  SMALLINT;               -- Flag of kind changing for Accounts_Update

  TYPE saldrec IS RECORD      -- Transit record of saldoa table (TRIG)
           ( a_acc    NUMBER,
             a_ost    NUMBER,
             b_ost    NUMBER,
             a_ostq   NUMBER,
             b_ostq   NUMBER
           );

  val      saldrec;

  TYPE t_acc_rec IS RECORD      -- Transit record of accounts update(TRIG)
               (n_acc    INTEGER,
                n_nls    VARCHAR2(15),
                n_nlsalt VARCHAR2(15),
                n_kv     SMALLINT,
                n_nbs    CHAR(4),
                n_nbs2   CHAR(4),
                n_daos   DATE,
                n_isp    SMALLINT,
                n_nms    VARCHAR2(70),
                n_pap    SMALLINT,
                n_grp    SMALLINT,
                n_seci   SMALLINT,
                n_seco   SMALLINT,
                n_vid    SMALLINT,
                n_tip    CHAR(3),
                n_dazs   DATE,
                n_blkd   SMALLINT,
                n_blkk   SMALLINT,
                n_otm    SMALLINT);

  avl      t_acc_rec;

--TYPE    cus_rec IS RECORD      -- Transit record of customers update(TRIG)
--             (n_rnk        customer.rnk%type,
--              n_custtype   customer.custtype%type,
--              n_country    customer.country%type,
--              n_nmk        customer.nmk%type,
--              n_nmkv       customer.nmkv%type,
--              n_nmkk       customer.nmkk%type,
--              n_codcagent  customer.codcagent%type,
--              n_prinsider  customer.prinsider%type,
--              n_okpo       customer.okpo%type,
--              n_adr        customer.adr%type,
--              n_sab        customer.sab%type,
--              n_taxf       customer.taxf%type,
--              n_c_reg      customer.c_reg%type,
--              n_c_dst      customer.c_dst%type,
--              n_rgtax      customer.rgtax%type,
--              n_datet      customer.datet%type,
--              n_adm        customer.adm%type,
--              n_datea      customer.datea%type,
--              n_stmt       customer.stmt%type,
--              n_date_on    customer.date_on%type,
--              n_date_off   customer.date_off%type,
--              n_notes      customer.notes%type,
--              n_notesec    customer.notesec%type,
--              n_crisk      customer.crisk%type,
--              n_pincode    customer.pincode%type,
--              n_otm        SMALLINT);
--
--cvl               cus_rec;

  doc      oper%rowtype;     -- Образ документа
  opl      opldok%rowtype;   -- Образ записи проводки
  cus      customer%rowtype; -- Образ записи клиентов
  acc      accounts%rowtype; -- образ записи счетов

/**
 * version - возвращает версию пакета
 */
function header_version return varchar2;
function body_version return varchar2;
function version return varchar2;

/*%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
%
% PROCEDURE     : reinit
% DESCRIPTION   : Initialization of global variables without cache
%
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%*/

PROCEDURE reinit(p_level in number);

/*%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
%
% PROCEDURE     : clear_context
% DESCRIPTION   : Clear global variable cache
%
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%*/

PROCEDURE clear_session_context;

/*%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
%
% PROCEDURE   : getP/setP
% DESCRIPTION : Отримує/Встановлює значення голобальної змінної
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%*/
PROCEDURE getP( tag VARCHAR2, val OUT VARCHAR2);
PROCEDURE setP( tag VARCHAR2, val VARCHAR2, client_id VARCHAR2 DEFAULT NULL);

/*%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
%
% PROCEDURE     : param
% DESCRIPTION   : Used to initialization of global variables
%
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%*/

PROCEDURE param;

/*%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
%
% PROCEDURE     : ref
% DESCRIPTION   : Returns next ref number for the oper's sequence
%
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%*/

PROCEDURE ref (i_ref IN OUT NUMBER);

/*%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
%
% PROCEDURE     : in_doc
% DESCRIPTION   : Inserts a new document into oper
%
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%*/
PROCEDURE in_doc4
   (   ref_    NUMBER,
       tt_     CHAR,
       vob_    NUMBER,
       nd_     VARCHAR2,
       pdat_   DATE DEFAULT SYSDATE,
       vdat_   DATE DEFAULT SYSDATE,
       dk_     NUMBER,
       kv_     NUMBER,
       s_      NUMBER,
       kv2_    NUMBER,
       s2_     NUMBER,
       sq_     NUMBER,      -- Eqv of S
       sk_     NUMBER,
       sub_    VARCHAR2,    -- субрахунок
       data_   DATE,
       datp_   DATE,
       nam_a_  VARCHAR2,
       nlsa_   VARCHAR2,
       mfoa_   VARCHAR2,
       nam_b_  VARCHAR2,
       nlsb_   VARCHAR2,
       mfob_   VARCHAR2,
       nazn_   VARCHAR2,
       d_rec_  VARCHAR2,
       id_a_   VARCHAR2,
       id_b_   VARCHAR2,
       id_o_   VARCHAR2,
       sign_   RAW,
       sos_    NUMBER,     -- Doc status
       prty_   NUMBER,     -- Doc priority
       uid_    NUMBER DEFAULT NULL);

PROCEDURE in_doc3
   (   ref_    NUMBER,
       tt_     CHAR,
       vob_    NUMBER,
       nd_     VARCHAR2,
       pdat_   DATE DEFAULT SYSDATE,
       vdat_   DATE DEFAULT SYSDATE,
       dk_     NUMBER,
       kv_     NUMBER,
       s_      NUMBER,
       kv2_    NUMBER,
       s2_     NUMBER,
       sk_     NUMBER,
       data_   DATE,
       datp_   DATE,
       nam_a_  VARCHAR2,
       nlsa_   VARCHAR2,
       mfoa_   VARCHAR2,
       nam_b_  VARCHAR2,
       nlsb_   VARCHAR2,
       mfob_   VARCHAR2,
       nazn_   VARCHAR2,
       d_rec_  VARCHAR2,
       id_a_   VARCHAR2,
       id_b_   VARCHAR2,
       id_o_   VARCHAR2,
       sign_   RAW,
       sos_    NUMBER,     -- Doc status
       prty_   NUMBER,     -- Doc priority
       uid_    NUMBER DEFAULT NULL);

PROCEDURE in_doc2
   (   ref_    NUMBER,
       tt_     CHAR,
       vob_    NUMBER,
       nd_     VARCHAR2,
       pdat_   DATE DEFAULT SYSDATE,
       vdat_   DATE DEFAULT SYSDATE,
       dk_     NUMBER,
       kv_     NUMBER,
       s_      NUMBER,
       kv2_    NUMBER,
       s2_     NUMBER,
       sq_     NUMBER,    -- Eqv of S
       sk_     NUMBER,
       data_   DATE,
       datp_   DATE,
       nam_a_  VARCHAR2,
       nlsa_   VARCHAR2,
       mfoa_   VARCHAR2,
       nam_b_  VARCHAR2,
       nlsb_   VARCHAR2,
       mfob_   VARCHAR2,
       nazn_   VARCHAR2,
       d_rec_  VARCHAR2,
       id_a_   VARCHAR2,
       id_b_   VARCHAR2,
       id_o_   VARCHAR2,
       sign_   RAW,
       sos_    NUMBER,     -- Doc status
       prty_   NUMBER,     -- Doc priority
       uid_    NUMBER DEFAULT NULL);

/*%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
%
% PROCEDURE     : pay
% DESCRIPTION   : Inserts and pays new document into oper and opldok
%
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%*/

PROCEDURE pay (
      p_flag NUMBER,        -- "Last entry" flag
      p_ref  NUMBER,        -- Doc reference
      p_vdat DATE,          -- Value date
      p_tt   CHAR     DEFAULT NULL,   -- Transaction type
      p_kv   NUMBER   DEFAULT NULL,   -- Currency code
      p_dk   NUMBER   DEFAULT NULL,   -- Debit/Credit flag
      p_nls  VARCHAR2 DEFAULT NULL,   -- Account number
      p_s    NUMBER   DEFAULT NULL,   -- Amount
      p_sq   NUMBER   DEFAULT NULL,   -- Amount (Base Equivalent)
      p_txt  VARCHAR2 DEFAULT NULL ); -- Comment

PROCEDURE pay2 (
            p_flag NUMBER,              -- "Last entry" flag
            p_ref  NUMBER,              -- Doc reference
            p_vdat DATE,                -- Value date
            p_tt   CHAR DEFAULT NULL,   -- Transaction type
            p_kv   NUMBER   DEFAULT NULL,   -- Currency code
            p_dk   NUMBER   DEFAULT NULL,   -- Debet/Credit flag
            p_nls  VARCHAR2 DEFAULT NULL,   -- Account number
            p_s    NUMBER   DEFAULT NULL,   -- Amount
            p_sq   NUMBER   DEFAULT NULL,   -- Amount (Base Equivalent)
            p_stmt NUMBER   DEFAULT NULL,   -- First(1)/Next(0) Flag
            p_txt  VARCHAR2 DEFAULT NULL ); -- Comment

/*%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
%
% PROCEDURE     : pay_bck
% DESCRIPTION   : Reverse payment
%
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%*/

PROCEDURE pay_bck ( ref_ NUMBER,               -- Reference number
                    lev_ SMALLINT DEFAULT 5 ); -- BackPay Level

/*%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
%
% PROCEDURE   : bck
% DESCRIPTION : RealBack/FulBack Payment.
%
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%*/

PROCEDURE bck ( ref_ NUMBER,               -- Reference number
                lev_ SMALLINT DEFAULT 5 );  -- BackPay Level

-------------------------------------------------
-- Динамически вычисляет номер счета по формуле
-------------------------------------------------
FUNCTION dyn_nls ( f VARCHAR2,
           ref NUMBER   DEFAULT NULL,   tt VARCHAR2 DEFAULT NULL,
          vdat DATE     DEFAULT NULL,   dk NUMBER   DEFAULT NULL,
          mfoa VARCHAR2 DEFAULT NULL, nlsa VARCHAR2 DEFAULT NULL,
           kva NUMBER   DEFAULT NULL,    s NUMBER   DEFAULT NULL,
          mfob VARCHAR2 DEFAULT NULL, nlsb VARCHAR2 DEFAULT NULL,
           kvb NUMBER   DEFAULT NULL,   s2 NUMBER   DEFAULT NULL)
  RETURN VARCHAR2;

/*%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
%
% PROCEDURE     : payv
% DESCRIPTION   : Multicurrency payment
%
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%*/

PROCEDURE payv(flg_  SMALLINT DEFAULT NULL,  -- Plan/Fact flg
               ref_  INTEGER,    -- Reference
               dat_  DATE,       -- Value Date
                tt_  CHAR,       -- Transaction code
                dk_  SMALLINT,   -- Debet/Credit
               kv1_  SMALLINT,   -- Currency code 1
              nls1_  VARCHAR2,   -- Account number 1
              sum1_  DECIMAL,    -- Amount 1
               kv2_  SMALLINT,   -- Currency code 2
              nls2_  VARCHAR2,   -- Account number 2
              sum2_  DECIMAL);   -- Amount 2

PROCEDURE pays(flg_  SMALLINT DEFAULT NULL,  -- Plan/Fact flg
               ref_  INTEGER,    -- Reference
               dat_  DATE,       -- Value Date
                tt_  CHAR,       -- Transaction code
                dk_  SMALLINT,   -- Debet/Credit
               kv1_  SMALLINT,   -- Currency code 1
              nls1_  VARCHAR2,   -- Account number 1
              sum1_  DECIMAL,    -- Amount 1
               kv2_  SMALLINT,   -- Currency code 2
              nls2_  VARCHAR2,   -- Account number 2
              sum2_  DECIMAL,    -- Amount 2
               sub_  VARCHAR2 DEFAULT NULL,   --SubAccount N
               txt_  VARCHAR2 DEFAULT NULL);  --transaction comm

/*%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
%
% PROCEDURE     : p_pvp
% DESCRIPTION   : Re-evaluation of Currency position accounts
%
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%*/

PROCEDURE p_pvp  ( kv_ NUMBER DEFAULT NULL,
                   dat_  DATE DEFAULT NULL);

/*%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
%
% PROCEDURE     : x_rat
% DESCRIPTION   : Calculates Cross Rate of 2 currencies
%                 via NBU rate to BASE curency
%
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%*/

PROCEDURE x_rat ( rat_o OUT NUMBER,     -- xrato
                  rat_b OUT NUMBER,     -- xratb
                  rat_s OUT NUMBER,     -- xrats
                   kv1_ NUMBER,         -- cur1
                   kv2_ NUMBER,         -- cur2
                   dat_ DATE DEFAULT NULL );


/*%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
%
% PROCEDURE     : dyntt
% DESCRIPTION   : Dynamic payment transaction linking
%
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%*/

PROCEDURE dyntt (flg_ NUMBER, ref_ NUMBER, vdat_ DATE,
      dk_ NUMBER,kva_ NUMBER,nlsa_ VARCHAR2,sa_ NUMBER,
                 kvb_ NUMBER,nlsb_ VARCHAR2,sb_ NUMBER);

PROCEDURE dyntt2 (sos_ IN OUT NUMBER,
                 mod1_ NUMBER, mod2_ NUMBER,
                  ref_ NUMBER,
                vdat1_ DATE, vdat2_ DATE,  tt0_ CHAR,
       dk_ NUMBER,kva_ NUMBER,mfoa_ VARCHAR2,nlsa_ VARCHAR2,sa_ NUMBER,
                  kvb_ NUMBER,mfob_ VARCHAR2,nlsb_ VARCHAR2,sb_ NUMBER,
       sq_ NUMBER,
      nom_ NUMBER);


--
-- Оплата проводок sos=0
--
PROCEDURE paysos0;

--
-- Оплата проводок переоцінки породжених при формуванні знімків балансу
--
procedure OVERPAY_PVP;

--
--
--
PROCEDURE create_paysos0_job;

--
-- Оплата проводок sos=0 по всем МФО
--
procedure paysos0_full;
/*%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
%
% FUNCTION   : p_icurval
% DESCRIPTION: This function calculates equivalent of given SUM in
%              given CURRENCY', on given DATE.
% PARAMETERS:
%
%           Currency Code
%       Sum (IN MINIMAL UNITS!!!)
%       Date on which to calculate
%       Type (Reserved for future)
%       1=Use Future Value if Previous not found (0=Return 1:1)
%
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%*/

FUNCTION p_icurval ( iCur      NUMBER,
                     iSum      NUMBER,
                     dDesiredDate  DATE,
                     iType         NUMBER   DEFAULT 0,
                     iDefaultValue NUMBER   DEFAULT 1,
                     iUseFuture    NUMBER   DEFAULT 0,
                     iCheck4Errors NUMBER   DEFAULT 0  )

RETURN NUMBER;

/*%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
%
% FUNCTION   : p_Ncurval
% DESCRIPTION: This function calculates nominal of given SUM in
%              given CURRENCY', on given DATE.
% PARAMETERS:
%
%           Currency Code
%       Sum (IN MINIMAL UNITS!!!)
%       Date on which to calculate
%       Type (Reserved for future)
%       1=Use Future Value if Previous not found (0=Return 1:1)
%
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%*/

FUNCTION p_Ncurval ( iCur      NUMBER,
                     iSum      NUMBER,
                     dDesiredDate  DATE,
                     iType         NUMBER   DEFAULT 0,
                     iDefaultValue NUMBER   DEFAULT 1,
                     iUseFuture    NUMBER   DEFAULT 0,
                     iCheck4Errors NUMBER   DEFAULT 0  )

RETURN NUMBER;

/*%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
%
% PROCEDURE     : pl_dat
% DESCRIPTION   : Esteblishing local Banking Day
%
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%*/

PROCEDURE pl_dat(dat_      DATE);

/*%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
%
% FUNCTION    : bd
% DESCRIPTION : Returns current local business date
%
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%*/

FUNCTION bd RETURN DATE;

/*%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
%
% FUNCTION    : gbd
% DESCRIPTION : Returns current global business date
%
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%*/

FUNCTION gbd RETURN DATE;

/*%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
%
% FUNCTION    : kf
% DESCRIPTION : Returns current branch code
%
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%*/

FUNCTION kf RETURN VARCHAR2;

/*%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
%
% FUNCTION  : USR_ID
% DESCRIPTION : Returns current user id
%
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%*/

function USR_ID return number;

END gl;
/

show errors;

----------------------------------------------------------------------

create or replace package body GL
is
  --***************************************************************--
  --                     General Ledger Package
  --                   (C) Unity-Bars 2000 - 2015
  --
  --                      (ErrCode 9300-9349)
  --
  --***************************************************************--

  G_BODY_VERSION  CONSTANT VARCHAR2(100)  := '$7.14 2018-04-12';

  G_AWK_BODY_DEFS CONSTANT VARCHAR2(512) := '';

  gbDATE     DATE   := NULL;      -- Current Banking day (global)
  pay_schema NUMBER := 3;         -- MultiCurrency Payment Schema
  aEQIV      NUMBER := 0;         -- Current document equivalent

  g_root_initialized  boolean := false;

  TYPE TDig IS TABLE OF BINARY_INTEGER INDEX BY BINARY_INTEGER;
  Dig  TDig;

  --
  -- именованные исключения
  --
  PART_NOT_EXISTS exception;
  pragma exception_init(PART_NOT_EXISTS, -2149);

  RESOURCE_BUSY   exception;
  pragma exception_init(RESOURCE_BUSY,   -54  );

  /**
   * version - возвращает версию пакета
   */
  function header_version return varchar2
  is
  begin
    return 'Package header GL '||G_HEADER_VERSION||'.'||chr(10)
    ||'AWK definition: '||chr(10)
    ||G_AWK_HEADER_DEFS;
  end header_version;

  function body_version return varchar2
  is
  begin
    return 'Package body GL '||G_BODY_VERSION||'.'||chr(10)
      ||'AWK definition: '||chr(10)
      ||G_AWK_BODY_DEFS;
  end body_version;

  function version return varchar2
  is
  begin
    return 'Package header GL '||G_HEADER_VERSION||'.'||chr(10)
      ||'AWK definition: '||chr(10)
      ||G_AWK_HEADER_DEFS ||chr(10)||chr(10)
      ||'Package body GL '||G_BODY_VERSION||'.'||chr(10)
      ||'AWK definition: '||chr(10)
      ||G_AWK_BODY_DEFS;
  end version;

  --
  --
  --
  procedure SET_BANK_DATE
  ( p_bnk_dt       in     date
  ) is
  begin
    gl.bDATE := p_bnk_dt;
    sys.dbms_session.set_context( 'bars_gl', 'bankdate', to_char(p_bnk_dt,'mm/dd/yyyy')
                                , client_id => bars_login.get_session_clientid() );
  end SET_BANK_DATE;

  /*%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
  %
  % PROCEDURE   : reinit
  % DESCRIPTION : Initialization of global variables without cache
  %
  %%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%*/
  PROCEDURE reinit(p_level in number)
  IS
    erm          VARCHAR2(80);
    ern          CONSTANT POSITIVE := 200;
    err          EXCEPTION;
    l_bankdate   varchar2(10);
    l_clientid   varchar2(64);
  BEGIN

    IF deb.debug
    THEN
      deb.trace( ern, 'module/0', 'reinit');
    END IF;
    --sys.dbms_system.ksdwrt(3,'gl.reinit('||to_char(p_level)||')');

    -- читаем свой клиентский идентификатор
    l_clientid := bars_login.get_session_clientid;
    sys.dbms_session.clear_context('bars_gl', client_id => l_clientid);

    -- чтение общих параметров
    BEGIN
      SELECT val
        INTO gl.baseval
        FROM params
       WHERE par='BASEVAL';
    EXCEPTION
      WHEN NO_DATA_FOUND THEN
        gl.baseval := 980;
    END;

    aUID := sys_context('bars_global','user_id');

    sys.dbms_session.set_context( 'bars_gl', 'branch', sys_context('bars_context','user_branch'), client_id => l_clientid );

    --
    -- global bank date
    --
    l_bankdate := sys_context('BARS_CONTEXT','GLOBAL_BANKDATE');

    if ( l_bankdate is null )
    then
      l_bankdate := BRANCH_ATTRIBUTE_UTL.GET_ATTRIBUTE_VALUE('/','BANKDATE');
    end if;

    gl.gbDATE := to_date(l_bankdate,'mm/dd/yyyy');

    -- схема с полем KF: корневые пользователи находятся вне МФО !!!
    if ( sys_context('bars_context','user_branch') = '/' or
         sys_context('bars_context','user_branch') is null )
    then -- для внешних пользователей (не из таблицы STAFF)

      -- инициализация корневого пользователя
      gl.amfo  := null;
      gl.arnk  := null;
      gl.aokpo := null;

      --
      -- local bank date
      --
      SET_BANK_DATE( gl.gbDATE );

    else

      --
      -- local bank date
      --
      l_bankdate := sys_context('BARS_GLOBAL','USER_BANKDATE');

      if ( l_bankdate is null )
      then -- set local equal to global
        SET_BANK_DATE( gl.gbDATE );
      else -- set local with checks
        PL_DAT( to_date(l_bankdate,'MM/DD/YYYY') );
      end if;

      BEGIN
        SELECT TRIM(val)
          INTO pay_schema
          FROM params
         WHERE par = 'PYSCHEMA';
      EXCEPTION
        WHEN NO_DATA_FOUND THEN
          pay_schema := 3;
      END;

      BEGIN
        SELECT TRIM(val)
          INTO gl.aMFO
          FROM params
         WHERE par = 'MFO';
      EXCEPTION
        WHEN NO_DATA_FOUND THEN
          erm := 'Parameter MFO is not defined';
          RAISE err;
      END;

      BEGIN
        SELECT val
          INTO aOKPO
          FROM params
         WHERE par='OKPO';
      EXCEPTION
        WHEN NO_DATA_FOUND THEN
          NULL;
      END;

      BEGIN
        SELECT val
          INTO aRNK
          FROM params
         WHERE par='OUR_RNK';
      EXCEPTION
        WHEN NO_DATA_FOUND THEN
          gl.aRNK := 1;
      END;

      sys.dbms_session.set_context( 'bars_gl', 'pay_schema', to_char(pay_schema), client_id=> l_clientid );
      sys.dbms_session.set_context( 'bars_gl', 'mfo',        aMFO,                client_id=> l_clientid );
      sys.dbms_session.set_context( 'bars_gl', 'okpo',       aOKPO,               client_id=> l_clientid );
      sys.dbms_session.set_context( 'bars_gl', 'rnk',        aRNK,                client_id=> l_clientid );

    end if;

    -- Устанавливаем признак инициализации и базовую валюту
    sys.dbms_session.set_context( 'bars_gl', 'baseval',   to_char(baseval), client_id => l_clientid );
    sys.dbms_session.set_context( 'bars_gl', 'last_init', to_char(sysdate, 'dd.mm.yyyy hh24:mi:ss'), client_id =>l_clientid );

  EXCEPTION
    WHEN err    THEN
      raise_application_error(-(20000+ern),chr(92)||erm,TRUE);
  END REINIT;



/*%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
%
% PROCEDURE     : clear_context
% DESCRIPTION   : Clear global variable cache
%
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%*/

PROCEDURE clear_session_context
is
begin
  sys.dbms_session.clear_context( 'bars_gl', client_id=> bars_login.get_session_clientid );
end clear_session_context;


/*%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
%
% PROCEDURE   : getP/setP
% DESCRIPTION : Отримує/Встановлює значення голобальної змінної
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%*/

PROCEDURE getP( tag VARCHAR2, val OUT VARCHAR2)
IS
BEGIN
  sys.DBMS_SESSION.CLEAR_IDENTIFIER;
  val:=SYS_CONTEXT('bars_glparam', tag );
END getP;

PROCEDURE setP( tag VARCHAR2, val VARCHAR2, client_id VARCHAR2 DEFAULT NULL)
IS
BEGIN
  sys.dbms_session.set_context('bars_glparam', tag, val, client_id=>client_id );
END setP;


/*%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
%
% PROCEDURE   : param
% DESCRIPTION : Used to initialization of global variables
%
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%*/

PROCEDURE PARAM
IS
  erm          VARCHAR2 (80);
  ern          CONSTANT POSITIVE := 200;
  err          EXCEPTION;
  l_bankdate   VARCHAR2(10);
BEGIN

  IF deb.debug
  THEN
    deb.trace( ern, 'module/0', 'param' );
  END IF;

  -- Проверяем выполнялась ли инициализация
  if ( sys_context('bars_gl','last_init') is null
    or sys_context('bars_gl','branch') != sys_context('bars_context','user_branch') )
  then
    reinit(0);
  else

    -- Читаем параметры из сохраненного контекста
    gl.baseval    := sys_context('bars_gl',     'baseval');
    gl.pay_schema := sys_context('bars_gl',     'pay_schema');
    gl.aUID       := sys_context('bars_global', 'user_id');
    gl.aUKF       := sys_context('bars_gl',     'kf');
    gl.aMFO       := sys_context('bars_gl',     'mfo');
    gl.aOKPO      := sys_context('bars_gl',     'okpo');
    gl.aRNK       := sys_context('bars_gl',     'rnk');

    -- global bank date
    l_bankdate := sys_context('bars_context','global_bankdate');

    if ( l_bankdate is null )
    then
      l_bankdate := BRANCH_ATTRIBUTE_UTL.GET_ATTRIBUTE_VALUE('/','BANKDATE');
    end if;

    gl.gbDATE := to_date(l_bankdate,'mm/dd/yyyy');

    -- local bank date
    l_bankdate := nvl( sys_context('bars_global','user_bankdate'), sys_context('bars_gl','bankdate') );

    if ( l_bankdate is null )
    then
      SET_BANK_DATE( gl.gbDATE );
    else
      PL_DAT( to_date(l_bankdate,'MM/DD/YYYY') );
    end if;

   end if;

end PARAM;



/*%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
%
% PROCEDURE   : ref
% DESCRIPTION : Returns next ref number for the oper's sequence
%
%    Receiving ReferenceDocNumber (MIK)
%
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%*/

PROCEDURE ref (i_ref IN OUT NUMBER) IS

   ern   CONSTANT POSITIVE := 201;  -- Cannot obtain ref

BEGIN

   i_ref := bars_sqnc.get_nextval('s_oper');

EXCEPTION
   WHEN OTHERS THEN
        raise_application_error(-(20000+ern),
          '\9345 - Cannot obtain ref value :' || sqlerrm, TRUE);
END ref;


/*%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
%
% PROCEDURE  : in_doc
% DESCRIPTION : Inserts a new document into oper (multicurrency)
%
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%*/

PROCEDURE in_doc4

   (   ref_    NUMBER,
       tt_     CHAR,
       vob_    NUMBER,
       nd_     VARCHAR2,
       pdat_   DATE DEFAULT SYSDATE,
       vdat_   DATE DEFAULT SYSDATE,
       dk_     NUMBER,
       kv_     NUMBER,
       s_      NUMBER,
       kv2_    NUMBER,
       s2_     NUMBER,
       sq_     NUMBER,      -- Eqv of S
       sk_     NUMBER,
       sub_    VARCHAR2,    -- субрахунок
       data_   DATE,
       datp_   DATE,
       nam_a_  VARCHAR2,
       nlsa_   VARCHAR2,
       mfoa_   VARCHAR2,
       nam_b_  VARCHAR2,
       nlsb_   VARCHAR2,
       mfob_   VARCHAR2,
       nazn_   VARCHAR2,
       d_rec_  VARCHAR2,
       id_a_   VARCHAR2,
       id_b_   VARCHAR2,
       id_o_   VARCHAR2,
       sign_   RAW,
       sos_    NUMBER,     -- Doc status
       prty_   NUMBER,     -- Doc priority
       uid_    NUMBER DEFAULT NULL)
IS
--
-- Insert into OPER  (MIK)
--

 id_         POSITIVE;
 tip_a_      CHAR(3) := NULL;
 tip_b_      CHAR(3) := NULL;

 i_          NUMBER;
 x           NUMBER;

 flg_        CHAR(1);

 nbs_        CHAR(4);
 nls_        VARCHAR2(14);

 nbsa_       CHAR(4) :=NULL;
 nbsb_       CHAR(4) :=NULL;

 err         EXCEPTION;
 erm         VARCHAR2(80);
 ern         CONSTANT POSITIVE := 202;    -- Cash symbol missing

 S           VARCHAR2(250);

 ref_a_      VARCHAR2(9);
 l_nd        oper.nd%type;

BEGIN



   IF uid_ IS NULL THEN
      id_ := gl.aUID;
   ELSE
      BEGIN
         SELECT id INTO id_ FROM staff$base WHERE id=uid_;
      EXCEPTION
         WHEN NO_DATA_FOUND THEN
            erm := '9343 - Unregistered user';
            RAISE err;
      END;
   END IF;

   IF s_<0 OR s2_<0 OR sq_<0 THEN
      erm := '9315 - Negative DOC amount';
      RAISE err;
   END IF;

   gl.aSOS  :=sos_;
   gl.aEQIV := sq_;

   ref_a_ := MOD(ref_,1000000000);

   IF mfoa_ = gl.aMFO THEN

      BEGIN
        SELECT tip,nbs INTO tip_a_,nbsa_
          FROM accounts
         WHERE kv=kv_ AND nls=nlsa_;
      EXCEPTION
         WHEN NO_DATA_FOUND THEN tip_a_ := NULL; nbsa_ := NULL;
      END;
   END IF;

   IF mfob_ = gl.aMFO THEN

      BEGIN
        SELECT tip,nbs INTO tip_b_,nbsb_
          FROM accounts
         WHERE kv=kv2_ AND nls=nlsb_;
      EXCEPTION
         WHEN NO_DATA_FOUND THEN tip_b_ := NULL; nbsb_ := NULL;
      END;
   END IF;

   IF gl.baseval=980 AND
     (SUBSTR(nbsa_,1,1)='9' AND SUBSTR(nbsb_,1,1) NOT IN ('8','9')
   OR SUBSTR(nbsb_,1,1)='9' AND SUBSTR(nbsa_,1,1) NOT IN ('8','9')) THEN

      BEGIN
         SELECT SUBSTR(flags,40,1) INTO flg_
           FROM tts WHERE tt=tt_;
      EXCEPTION WHEN NO_DATA_FOUND THEN flg_:='0';
      END;
      IF flg_='0' THEN
         erm := '9319 - improper off-balance operation';
         RAISE err;
      END IF;
   END IF;

   IF dk_=0 OR dk_=1 THEN     -- Validate balance acc number
      FOR i_ IN 0..1 LOOP
         IF i_=dk_ THEN
            nbs_ := nbsb_;
            nls_ := nlsb_;
         ELSE
            nbs_ := nbsa_;
            nls_ := nlsa_;
         END IF;

         IF nbs_ IS NOT NULL THEN
            x := 0;

            FOR nbs_rec IN (SELECT nbs,1 x FROM ps_tts WHERE tt=tt_ AND dk=i_)

            LOOP
               x := nbs_rec.x;
               IF nbs_rec.nbs = nbs_   OR
                  RTRIM(nbs_rec.nbs) = SUBSTR(nbs_,1,3) OR
                  RTRIM(nbs_rec.nbs) = SUBSTR(nbs_,1,2) OR
                  RTRIM(nbs_rec.nbs) = SUBSTR(nbs_,1,1)
               THEN
                  x := 1-nbs_rec.x;
                  EXIT;
               END IF;
            END LOOP;
            IF x>0 THEN
               erm := '9309 - Improper acc operation \#'||
                       nls_||'('||tt_||'-'||i_||')';
               RAISE err;
            END IF;
         END IF;
      END LOOP;
   END IF;

   IF (tip_a_='KAS' OR tip_b_='KAS') AND (dk_=0 OR dk_=1) THEN
      IF sk_ IS NULL THEN
         BEGIN
            SELECT SUBSTR(flags,62,1) INTO flg_
              FROM tts WHERE tt=tt_;
         EXCEPTION WHEN NO_DATA_FOUND THEN flg_:='0';
         END;
         IF flg_='0' THEN
            erm := '9311 - Cash Symbol missing';
            RAISE err;
         END IF;
      ELSIF NOT( sk_>=40 AND ( dk_=1 AND tip_b_='KAS' OR dk_=0 AND tip_a_='KAS') OR
                 sk_< 40 AND ( dk_=0 AND tip_b_='KAS' OR dk_=1 AND tip_a_='KAS'))
      THEN
         erm := '9321 - Cash Symbol invalid';
         RAISE err;
      END IF;
   END IF;

   bars_audit.trace('gl.in_doc4: id_o='||id_o_);

   if length(nd_) > 10 then
      l_nd := substr( nd_, -10);
   else
      l_nd := nd_;
   end if;

   INSERT INTO oper
      (ref,tt,vob,nd,pdat,vdat,dk,kv,s,kv2,s2,sk,
       datd,datp,
       nam_a,nlsa,mfoa,nam_b,nlsb,mfob,nazn,d_rec,
       userid,id_a,id_b,id_o,sign,sos,prty,sq,ref_a)
   VALUES (ref_,tt_,vob_, l_nd ,SYSDATE,vdat_,dk_,kv_,s_,kv2_,s2_,sk_,
           data_,datp_,
           nam_a_,nlsa_,mfoa_,nam_b_,nlsb_,mfob_,nazn_,d_rec_,
           id_,id_a_,id_b_,id_o_,sign_,sos_,prty_,sq_,ref_a_);

   doc.ref  :=  ref_;          doc.nam_a:=nam_a_;
   doc.tt   :=   tt_;          doc.nlsa := nlsa_;
   doc.vob  :=  vob_;          doc.mfoa := mfoa_;
   doc.nd   :=   l_nd;          doc.nam_b:=nam_b_;
   doc.pdat := SYSDATE;        doc.nlsb := nlsb_;
   doc.vdat := vdat_;          doc.mfob := mfob_;
   doc.dk   :=   dk_;          doc.nazn := nazn_;
   doc.kv   :=   kv_;          doc.d_rec:=d_rec_;
   doc.s    :=    s_;          doc.userid  :=id_;
   doc.kv2  :=  kv2_;          doc.id_a := id_a_;
   doc.s2   :=   s2_;          doc.id_b := id_b_;
   doc.sk   :=   sk_;          doc.id_o := id_o_;
   doc.datd := data_;          doc.sign := sign_;
   doc.datp := datp_;          doc.sos  :=  sos_;
   doc.sq   :=   sq_;          doc.prty := prty_;
   doc.ref_a:=ref_a_;
--
   IF dk_=2 OR dk_=3 THEN
      INSERT INTO ref_que (ref) VALUES (ref_);
   END IF;

-- Add default dop-rekvizity

   FOR c IN (SELECT a.tag,TRIM(b.val) val FROM op_field a, op_rules b
                WHERE b.tt=tt_  AND a.tag=b.tag AND b.used4input<>1 AND
                      b.opt='M' AND b.val IS NOT NULL)
   LOOP
      S:=c.val;
      IF SUBSTR(S,1,2)='#(' THEN -- Dynamic formula
        BEGIN
           S := REPLACE(S,'#(S)',   TO_CHAR(s_));
           S := REPLACE(S,'#(S2)',  TO_CHAR(s2_));
           S := REPLACE(S,'#(NLSA)',''''||nlsa_||'''');
           S := REPLACE(S,'#(NLSB)',''''||nlsb_||'''');
           S := REPLACE(S,'#(MFOA)',''''||mfoa_||'''');
           S := REPLACE(S,'#(MFOB)',''''||mfob_||'''');
           S := REPLACE(S,'#(REF)',TO_CHAR(ref_));
           S := REPLACE(S,'#(KV)',TO_CHAR(kv_));
           S := REPLACE(S,'#(KV2)',TO_CHAR(kv2_));
           S := REPLACE(S,'#(TT)',''''||tt_||'''');
           EXECUTE IMMEDIATE
          'SELECT '||SUBSTR(S,3,LENGTH(S)-3)||' FROM DUAL' INTO S;
        EXCEPTION
           WHEN OTHERS THEN
              erm := '9318 - Cannot get attribute '||c.tag||' via '||S;
              RAISE err;
        END;
      END IF;

      INSERT INTO operw (REF,TAG,VALUE) VALUES(ref_,c.tag,S);
   END LOOP;

EXCEPTION
   WHEN err           THEN
        raise_application_error(-(20000+ern),chr(92)||erm,TRUE);
   WHEN NO_DATA_FOUND THEN
        raise_application_error(-(20000+ern),'\9333 - Cannot execute #in_doc4',TRUE);
END in_doc4;

PROCEDURE in_doc3

   (   ref_    NUMBER,
       tt_     CHAR,
       vob_    NUMBER,
       nd_     VARCHAR2,
       pdat_   DATE DEFAULT SYSDATE,
       vdat_   DATE DEFAULT SYSDATE,
       dk_     NUMBER,
       kv_     NUMBER,
       s_      NUMBER,
       kv2_    NUMBER,
       s2_     NUMBER,
       sk_     NUMBER,
       data_   DATE,
       datp_   DATE,
       nam_a_  VARCHAR2,
       nlsa_   VARCHAR2,
       mfoa_   VARCHAR2,
       nam_b_  VARCHAR2,
       nlsb_   VARCHAR2,
       mfob_   VARCHAR2,
       nazn_   VARCHAR2,
       d_rec_  VARCHAR2,
       id_a_   VARCHAR2,
       id_b_   VARCHAR2,
       id_o_   VARCHAR2,
       sign_   RAW,
       sos_    NUMBER,     -- Doc status
       prty_   NUMBER,     -- Doc priority
       uid_    NUMBER DEFAULT NULL)
IS

BEGIN

  in_doc4(ref_,tt_,vob_,nd_,pdat_,vdat_,dk_,kv_,s_,kv2_,s2_,0,sk_,NULL,
         data_,datp_,nam_a_,nlsa_,mfoa_,nam_b_,nlsb_,mfob_,nazn_,d_rec_,
         id_a_,id_b_,id_o_,sign_,sos_,prty_,uid_);

END in_doc3;

PROCEDURE in_doc2

   (   ref_    NUMBER,
       tt_     CHAR,
       vob_    NUMBER,
       nd_     VARCHAR2,
       pdat_   DATE DEFAULT SYSDATE,
       vdat_   DATE DEFAULT SYSDATE,
       dk_     NUMBER,
       kv_     NUMBER,
       s_      NUMBER,
       kv2_    NUMBER,
       s2_     NUMBER,
       sq_     NUMBER,      -- Eqv of S
       sk_     NUMBER,
       data_   DATE,
       datp_   DATE,
       nam_a_  VARCHAR2,
       nlsa_   VARCHAR2,
       mfoa_   VARCHAR2,
       nam_b_  VARCHAR2,
       nlsb_   VARCHAR2,
       mfob_   VARCHAR2,
       nazn_   VARCHAR2,
       d_rec_  VARCHAR2,
       id_a_   VARCHAR2,
       id_b_   VARCHAR2,
       id_o_   VARCHAR2,
       sign_   RAW,
       sos_    NUMBER,     -- Doc status
       prty_   NUMBER,     -- Doc priority
       uid_    NUMBER DEFAULT NULL)
IS

BEGIN

  in_doc4(ref_,tt_,vob_,nd_,pdat_,vdat_,dk_,kv_,s_,kv2_,s2_,sq_,sk_,NULL,
         data_,datp_,nam_a_,nlsa_,mfoa_,nam_b_,nlsb_,mfob_,nazn_,d_rec_,
         id_a_,id_b_,id_o_,sign_,sos_,prty_,uid_);

END in_doc2;

/*%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
%
% PROCEDURE  : payi  (internal)
% DESCRIPTION : Inserts and pays new document into opldok
%
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%*/

PROCEDURE payi(
      p_flag NUMBER,        -- "Last entry" flag
      p_ref  NUMBER,        -- Doc reference
      p_vdat DATE,          -- Value date
      p_tt   CHAR     DEFAULT NULL,   -- Transaction type
      p_kv   NUMBER   DEFAULT NULL,   -- Currency code
      p_dk   NUMBER   DEFAULT NULL,   -- Debit/Credit flag
      p_nls  VARCHAR2 DEFAULT NULL,   -- Account number
      p_s    NUMBER   DEFAULT NULL,   -- Amount
      p_sq   NUMBER   DEFAULT NULL,   -- Amount (Base Equivalent)
      p_stmt NUMBER   DEFAULT NULL,   -- First(1)/Next(0) Flag
      p_sub  VARCHAR2 DEFAULT NULL,   -- SubAccount number
      p_txt  VARCHAR2 DEFAULT NULL    -- Comment
              )
IS
--
--  BARS98 Payment program. ()
--
 acc_        NUMBER;
 accc_       NUMBER;
 dapp_       DATE;
 dazs_       DATE;
 daos_       DATE;
 vdat_       DATE;
 sosf_       BOOLEAN;
 s_          NUMBER;
 s_q         NUMBER;
 s_f         NUMBER;
 s_b         NUMBER;
 ost_        NUMBER;
 lim_        NUMBER;
 ostx_       NUMBER;
 dos_        NUMBER;
 kos_        NUMBER;
 check_s     NUMBER;
 nbs_        VARCHAR2(4);
 tip_        VARCHAR2(3);
 nls_        VARCHAR2(14);
 kv_         BINARY_INTEGER;
 dk_         BINARY_INTEGER;
 i           BINARY_INTEGER;
 x           BINARY_INTEGER;
 pap_        BINARY_INTEGER;
 sos_        BINARY_INTEGER;
 tt_         CHAR(3);
 blkd_       BINARY_INTEGER;
 blkk_       BINARY_INTEGER;
 rang_       BINARY_INTEGER;
 flr_        CHAR(1);
 flg_        CHAR(1);
 stmt_       NUMBER; -- nomer provodki
 ref_        NUMBER;
 txt_        VARCHAR2(70);
 ms_         NUMBER(24);
 mkv_        BINARY_INTEGER;
 rato_       NUMBER;
 ratb_       NUMBER;
 rats_       NUMBER;
 tobo_       accounts.tobo%type;
 opt_        NUMBER;
 vob_        NUMBER;

TYPE AccTyp IS
  RECORD ( nls  VARCHAR2(15),
           kv   BINARY_INTEGER,
           pap  BINARY_INTEGER,
           ostc NUMBER(24),
           ostx NUMBER(24),
           lim  NUMBER(24),
           dlta NUMBER(24));
AccRec AccTyp;

TYPE PayTyp IS TABLE OF AccRec%TYPE INDEX BY BINARY_INTEGER;
PayRec PayTyp;
n_     BINARY_INTEGER;
-- ** -- ** --
locked_acc EXCEPTION;
PRAGMA     EXCEPTION_INIT(locked_acc, -54);

wait_expired_acc EXCEPTION;
PRAGMA           EXCEPTION_INIT(wait_expired_acc, -30006);

 ern         CONSTANT POSITIVE := 203;    -- Pay program err code
 err         EXCEPTION;
 erm         VARCHAR2(80);


CURSOR c0 IS
       SELECT o.tt,o.fdat,o.dk,o.acc,o.s,o.sq,o.sos,o.stmt,o.txt
         FROM opldok o,accounts a
        WHERE o.ref=p_ref AND o.acc=a.acc
          AND o.sos IN (0,1,3,4)
       FOR UPDATE OF o.sos;

  -- возвращает форматированную строку с ACC-счета или NLS(KV)
  function get_account_desc(p_flag number, p_acc number, p_nls varchar2, p_kv number)
  return varchar2 is
  nls_ accounts.nls%type := p_nls;
  kv_  accounts.kv%type  := p_kv;
  begin
    if p_flag is null then
       begin
          select nls,kv into nls_,kv_ from accounts where acc=p_acc;
       exception
          when no_data_found then return 'INT#'||p_acc;
       end;
    end if;
    return '#'||nls_||'('||kv_||')';
  end get_account_desc;

BEGIN

nls_  := p_nls;
txt_  := SUBSTR(TRIM(p_txt),1,70);
vdat_ := TRUNC(p_vdat);

IF p_flag IS NULL OR p_flag IN (0,1) THEN

   IF NVL(p_s,0)=0 AND NVL(p_sq,0)=0 THEN
      RETURN;
   END IF;

   IF p_s<0 OR p_sq<0 THEN
      erm := '9316 - Negative TRANSACTION amount';
      RAISE err;
   END IF;

   IF p_dk NOT IN ( 0, 1 ) THEN
      erm := '9312 - Debit/Credit invalid #'||p_dk;
      RAISE err;
   END IF;

   BEGIN

      IF p_flag IS NULL THEN  -- Internal acc

         acc_ := TO_NUMBER(nls_);

         SELECT accc, daos, dazs, nls, kv, nbs, opt, 1
           INTO accc_,daos_,dazs_,nls_,kv_,nbs_,opt_,sos_
           FROM accounts
          WHERE acc=acc_
            AND BITAND(NVL(opt,0),1)=0
            FOR UPDATE OF ostb,ostf NOWAIT;
      ELSE                      -- External

         kv_ := p_kv;

         SELECT acc, accc, daos, dazs ,nls ,kv, nbs, opt, 1
           INTO acc_,accc_,daos_,dazs_,nls_,kv_,nbs_,opt_,sos_
           FROM accounts
          WHERE nls=nls_ AND kv=kv_
            AND BITAND(NVL(opt,0),1)=0
            FOR UPDATE OF ostb,ostf NOWAIT;

      END IF;
   EXCEPTION
      WHEN NO_DATA_FOUND THEN

         BEGIN
            IF p_flag IS NULL THEN  -- Internal acc

               SELECT accc, daos, dazs, nls, kv, nbs, opt, 0
                 INTO accc_,daos_,dazs_,nls_,kv_,nbs_,opt_,sos_
                 FROM accounts
                WHERE acc=acc_  AND BITAND(NVL(opt,0),1)=1;

            ELSE

               SELECT acc, accc, daos, dazs ,nls ,kv, nbs, opt, 0
                 INTO acc_,accc_,daos_,dazs_,nls_,kv_,nbs_,opt_,sos_
                 FROM accounts
                WHERE nls=nls_ AND kv=kv_ AND BITAND(NVL(opt,0),1)=1;

            END IF;
         EXCEPTION WHEN NO_DATA_FOUND THEN
           BEGIN
               kv_ := p_kv;

               SELECT acc, accc, daos, dazs ,nls ,kv, nbs, opt, 1
                   INTO acc_,accc_,daos_,dazs_,nls_,kv_,nbs_,opt_,sos_
               FROM accounts
               WHERE nlsalt=nls_ AND kv=kv_ AND dat_alt IS NOT NULL
                 AND BITAND(NVL(opt,0),1)=0
                FOR UPDATE OF ostb,ostf NOWAIT;

            EXCEPTION WHEN NO_DATA_FOUND THEN

               BEGIN

                 SELECT acc, accc, daos, dazs ,nls ,kv, nbs, opt, 0
                   INTO acc_,accc_,daos_,dazs_,nls_,kv_,nbs_,opt_,sos_
                 FROM accounts
                 WHERE nlsalt=nls_ AND kv=kv_ AND dat_alt IS NOT NULL
                 AND BITAND(NVL(opt,0),1)=1;

               EXCEPTION WHEN NO_DATA_FOUND THEN
                  erm := '9300 - No account found '||get_account_desc(p_flag, acc_, nls_, kv_);
                  RAISE err;
                END;
           END;

         END;

      WHEN locked_acc THEN
         erm := '9349 - Locked account '||get_account_desc(p_flag, acc_, nls_, kv_);
         RAISE err;
      WHEN wait_expired_acc THEN
         erm := '9349 - Locked account(wait timeout expired) '||get_account_desc(p_flag, acc_, nls_, kv_);
         RAISE err;
   END;

   IF gl.bDATE IS NULL THEN
      erm := '9344 - Undefined BankDate';
      RAISE err;
   END IF;

   IF sos_=0 THEN NULL;
   ELSE
   IF TRUNC(vdat_) <= TRUNC(gl.bDATE) THEN -- Mark
      sos_ := 1; --booked
   ELSE
      sos_ := 3; --forward
   END IF;
   END IF;
   IF kv_=gl.BASEVAL THEN s_q := p_s;
   ELSE  IF p_sq = 0 THEN s_q := gl.p_icurval(kv_,p_s,vdat_);
                     ELSE s_q := p_sq; END IF;
   END IF;

   IF p_stmt=1 THEN
      begin
	 gl.aSTMT := bars_sqnc.get_nextval('s_stmt');
      exception
         when others then
            erm := '9346 - Can''t get stmt number';
            RAISE err;
      end;
   END IF;


   INSERT INTO opldok(ref, tt, dk, acc, fdat, sq, s, txt, sos, stmt
		    , kf
                     )
   VALUES(p_ref,p_tt,p_dk,acc_,vdat_,s_q,p_s,txt_,sos_,gl.aSTMT
		    , gl.aMFO
         )  RETURNING rowid INTO gl.aOROW;

   gl.aREF  := p_ref;
   gl.aTT   := p_tt;

   IF sos_=0 THEN GOTO SET_SOS013; END IF;

   i := 0; -- Zero Linkage counter

   ms_ :=p_s; -- Store main acc currency and delta value
   mkv_:=kv_;
   x := CASE WHEN p_dk=0 THEN -1 ELSE 1 END;
   WHILE acc_ IS NOT NULL
   LOOP
      IF TRUNC(dazs_) <= TRUNC(gl.bDATE) THEN
         erm := '9303 - Account is closed #'||nls_||'('||TO_CHAR(kv_)||')';
         RAISE err;
      END IF;

      IF TRUNC(daos_) > TRUNC(gl.bDATE) AND sos_=1 and p_tt!='BAK' THEN
         erm := '9340 - Account is not opened yet #'||nls_||'('||TO_CHAR(kv_)||')';
         RAISE err;
      END IF;

      IF sos_ = p_booked THEN -- Pay booked
         UPDATE accounts SET ostb=ostb+x*ms_ WHERE acc=acc_;
      ELSE                    -- Pay future
         UPDATE accounts SET ostf=ostf+x*ms_ WHERE acc=acc_;
      END IF;

      IF accc_ IS NULL THEN
         EXIT;
      ELSE

         BEGIN
            SELECT acc, accc, daos, dazs ,nls ,kv
              INTO acc_,accc_,daos_,dazs_,nls_,kv_
            FROM accounts
              WHERE acc=accc_ FOR UPDATE OF ostb,ostf
            NOWAIT
             ;
         EXCEPTION
            WHEN NO_DATA_FOUND THEN
              erm := '9348 - No link account found INT#'||TO_CHAR(accc_);
              RAISE err;
            WHEN locked_acc THEN
              erm := '9349 - Locked account #'||TO_CHAR(accc_);
              RAISE err;
            WHEN wait_expired_acc THEN
              erm := '9349 - Locked account(wait timeout expired) #'||TO_CHAR(accc_);
              RAISE err;
         END;

         IF mkv_=kv_ THEN ms_:=p_s;
         ELSE
            x_rat ( rato_,ratb_,rats_,mkv_,kv_,vdat_ );
            ms_ := p_s * rato_;
         END IF;
      END IF;

      i := i + 1;
      IF i > 20 THEN
         erm := '9347 - Err link account counter';
         RAISE err;
      END IF;

   END LOOP;                   -- Loop thru chained accounts

<<SET_SOS013>>

   gl.aSOS := sos_;

-- UPDATE oper SET sos=GREATEST(NVL(sos,0),sos_) WHERE ref=p_ref;
   UPDATE oper
      SET sos=GREATEST((CASE WHEN sos=5 OR sos IS NULL THEN 0 ELSE sos END),sos_)
    WHERE ref=p_ref;
   BEGIN
      SELECT ref INTO ref_ FROM ref_que WHERE ref=p_ref;
   EXCEPTION
      WHEN NO_DATA_FOUND THEN
           INSERT INTO ref_que (ref) VALUES (p_ref);
   END;
END IF;
-------------------------
--   Фактична оплата
-------------------------

IF p_flag IN (1,2,3) THEN -- Pay cleared

   IF TRUNC(vdat_) > TRUNC(gl.bDATE) THEN

      RETURN;          -- Unable to clear

   END IF;


   BEGIN
      SELECT vob INTO vob_ FROM oper WHERE ref=p_ref;
   EXCEPTION WHEN NO_DATA_FOUND THEN vob_:=0;
   END;


   check_s := 0;
   sosf_   := TRUE;

   OPEN c0;
   LOOP

      FETCH c0 INTO tt_,vdat_,dk_,acc_,s_,s_q,sos_,stmt_,txt_
      ;
      EXIT WHEN c0%NOTFOUND;

      IF TRUNC(vdat_) > TRUNC(gl.bDATE) THEN
         sosf_ := FALSE;
         GOTO NEXT_REC;
      END IF;

      BEGIN
         SELECT rang,SUBSTR(flags,39,1),SUBSTR(flags,38,1)
           INTO rang_,flr_,flg_
           FROM tts WHERE tt=tt_;
      EXCEPTION
         WHEN NO_DATA_FOUND THEN rang_ := NULL; flr_ := NULL;
      END;

      IF p_flag=3 AND flg_='0' THEN  -- пропуск план комбо
         sosf_ := FALSE;
         GOTO NEXT_REC;
      END IF;

      IF gl.fSOS0 = 0 AND sos_ = 4 THEN GOTO NEXT_REC; END IF;
      x := CASE WHEN dk_=0 THEN -1 ELSE 1 END;
      check_s := check_s+x*s_;     -- CheckSum counting

      IF gl.fSOS0 = 0 AND sos_ = 0 THEN GOTO SET_SOS45; END IF;

      flr_  := NVL(flr_,'0');
      rang_ := NVL(rang_,0);

      i := 0;                      -- Zero Linkage counter

      gl.aREF := p_ref;   -- Current ref and tt assigning
      gl.aTT  := tt_;
      gl.vDATE:= vdat_;

--    Присвоєння змінних для використання за межами пакеджа
      gl.opl.ref :=p_ref;
      gl.opl.tt  :=tt_;
      gl.opl.fdat:=vdat_;
      gl.opl.dk  :=dk_;
      gl.opl.acc :=acc_;
      gl.opl.s   :=s_;
      gl.opl.sq  :=s_q;
      gl.opl.sos :=sos_;
      gl.opl.stmt:=stmt_;
      gl.opl.txt :=txt_;

      WHILE acc_ IS NOT NULL
      LOOP
	 BEGIN
           SELECT accc, pap, ostC,lim, ostX, dapp, daos, dazs,
                  nls, kv ,nbs, tip, blkd, blkk, opt, tobo
             INTO accc_,pap_,ost_,lim_,ostx_,dapp_,daos_,dazs_,
                  nls_,kv_,nbs_,tip_,blkd_,blkk_,opt_,tobo_
             FROM accounts WHERE acc=acc_
              FOR UPDATE OF trcn,dapp,ostB,ostC,ostF,dos,kos
            NOWAIT
           ;

         EXCEPTION
           WHEN NO_DATA_FOUND THEN
              erm := '9300 - No open account INT#'||TO_CHAR(acc_);
              RAISE err;
           WHEN locked_acc THEN
              erm := '9349 - Locked account #'||TO_CHAR(acc_);
              RAISE err;
           WHEN wait_expired_acc THEN
              erm := '9349 - Locked account(wait timeout expired) #'||TO_CHAR(acc_);
              RAISE err;
         END;

         IF i=0 THEN mkv_:=kv_;
--    Присвоєння змінних для використання за межами пакеджа
            gl.acc.acc:=acc_;
            gl.acc.nbs:=nbs_;
            gl.acc.nls:=nls_;
            gl.acc.kv :=kv_;
            gl.acc.tip:=tip_;
            gl.acc.opt:=opt_;
            gl.acc.tobo:=tobo_;

         END IF;

         IF mkv_=kv_ THEN ms_:=s_;
         ELSE
            x_rat ( rato_,ratb_,rats_,mkv_,kv_,vdat_ );
            ms_ := s_ * rato_;
         END IF;

         IF   dk_=0  AND blkd_>rang_ AND ms_>0 THEN  -- Check blocked account to pass thru
            erm := '9304 - Blocked account #'||nls_||'('||TO_CHAR(kv_)||')';
            RAISE err;
         ELSIF dk_=1 AND blkk_>rang_ AND ms_>0 THEN
            erm := '9305 - Blocked account #'||nls_||'('||TO_CHAR(kv_)||')';
            RAISE err;
         END IF;

         lim_ := NVL(lim_,0);

         IF TRUNC(dazs_) <= TRUNC(gl.bDATE) THEN
             erm := '9303 - Account is closed #'||nls_||'('||TO_CHAR(kv_)||')';
             RAISE err;
         END IF;

         IF TRUNC(daos_) > TRUNC(gl.bDATE) AND sos_=1 THEN
            erm := '9340 - Account is not opened yet #'||nls_||'('||TO_CHAR(kv_)||')';
            RAISE err;
         END IF;

         CASE sos_
            WHEN 1 THEN s_f := 0;   s_b := 0;
            WHEN 3 THEN s_f := ms_; s_b := ms_;
            WHEN 0 THEN s_f := 0;   s_b := ms_;
            WHEN 4 THEN s_f := 0;   s_b := ms_;
         END CASE;

         IF dk_=0 THEN
            dos_  := ms_;   kos_  :=   0;
         ELSE
            dos_  :=   0;   kos_  := ms_;
         END IF;

         IF (pap_=1 OR pap_=2)
         AND acc_ >= 0 AND acc_ <= 4294967296 AND flr_<>'1'
         THEN
            n_:=acc_-2147483648;

            IF PayRec.EXISTS(n_) THEN
               PayRec(n_).dlta:=PayRec(n_).dlta-dos_+kos_;
            ELSE
               PayRec(n_).nls:=nls_;
               PayRec(n_).kv :=kv_;
               PayRec(n_).pap:=pap_;
               PayRec(n_).ostc:=ost_;
               PayRec(n_).ostx:=ostx_;
               PayRec(n_).lim:=lim_;
               PayRec(n_).dlta:=-dos_+kos_;
            END IF;

         END IF;

         gl.fRCVR := 0; -- PreLoad Trig's value

         IF TRUNC(dapp_) = TRUNC(gl.bDATE) THEN

            UPDATE accounts
            SET trcn = trcn + 1,
                dapp = gl.bDATE,
                ostB = ostB + x*s_b,
                ostC = ostC + x*ms_,
                dos  = dos  + dos_,
                kos  = kos  + kos_,
                ostF = ostF - x*s_f

            WHERE acc=acc_;

         ELSIF TRUNC(dapp_) > TRUNC(gl.bDATE) THEN  -- Back-Valued-Payment

            UPDATE accounts
            SET trcn = trcn + 1,
                ostB = ostB + x*s_b,
                ostC = ostC + x*ms_,
                ostF = ostF - x*s_f
            WHERE acc=acc_;

         ELSE

            UPDATE accounts
            SET trcn = trcn + 1,
                dapp = gl.bDATE,
                ostB = ostB + x*s_b,
                ostC = ostC + x*ms_,
                dos  = dos_ ,
                kos  = kos_,
                ostF = ostF - x*s_f

              WHERE acc=acc_;

         END IF;

         IF ( x*ms_<0 AND tip_='OVN' )
         THEN
           execute immediate 'begin OVRN.DEB_LIM ( :acc, :s ); end;' USING acc_, x*ms_;
         END IF;

         IF gl.fRCVR <> 2 THEN  -- check to see if trig fired
            erm := '9341 - No triggers TU_SAL enabled';
            RAISE err;
         END IF;

         i := i + 1;

         IF i>20 THEN
            erm := '9347 - Err link account counter';
            RAISE err;
         END IF;

         IF ( vob_ = 96 )
         THEN -- Виконати накопичення виправних

           DECLARE
             fdat_   DATE   := TRUNC(gl.bDATE,'MM')-1;  -- ост число мин міс
             dosq_   NUMBER := CASE dk_ WHEN 0 THEN s_q ELSE 0 END;
             kosq_   NUMBER := CASE dk_ WHEN 0 THEN 0 ELSE s_q END;
           BEGIN

             fdat_ := TRUNC(fdat_,'MM');  -- 1е число

             UPDATE saldoz
                SET dos  = dos  + dos_
                  , kos  = kos  + kos_
                  , dosq = dosq + dosq_
                  , kosq = kosq + kosq_
              WHERE acc  = acc_
                AND fdat=fdat_;

             IF SQL%ROWCOUNT=0 THEN
               insert into SALDOZ ( ACC, FDAT, DOS, KOS ,DOSQ, KOSQ )
               values ( acc_,fdat_,dos_,kos_,dosq_,kosq_);
             END IF;

           END;

         END IF;

         IF ( vob_ = 99 )
         THEN -- Виконати накопичення виправних за рік

           DECLARE
             fdat_   DATE   := TRUNC(gl.bDATE,'YYYY')-1;  -- ост число мин рок
             dosq_   NUMBER := CASE dk_ WHEN 0 THEN s_q ELSE 0 END;
             kosq_   NUMBER := CASE dk_ WHEN 0 THEN 0 ELSE s_q END;
           BEGIN

               fdat_ := TRUNC(fdat_,'YYYY'); -- 1е число минулого року

               UPDATE saldoy
                  SET dos  = dos  + dos_
                    , kos  = kos  + kos_
                    , dosq = dosq + dosq_
                    , kosq = kosq + kosq_
                WHERE acc  = acc_
                  AND fdat = fdat_;

               IF SQL%ROWCOUNT=0 THEN
                 insert into SALDOY ( ACC, FDAT, DOS, KOS ,DOSQ, KOSQ )
                 values ( acc_, fdat_, dos_, kos_, dosq_, kosq_ );
               END IF;

               fdat_ := add_months( trunc( gl.bDATE, 'MM' ), -1 ); -- 1е число минулого міс.

               update SALDOZ
                  set DOS_YR  = DOS_YR  + dos_
                    , DOSQ_YR = DOSQ_YR + dosq_
                    , KOS_YR  = KOS_YR  + kos_
                    , KOSQ_YR = KOSQ_YR + kosq_
                where ACC     = acc_
                  and FDAT    = fdat_;
               
               IF SQL%ROWCOUNT=0 THEN
                  insert into SALDOZ ( ACC, FDAT, DOS, DOSQ, KOS, KOSQ, DOS_YR, DOSQ_YR, KOS_YR, KOSQ_YR )
                  values ( acc_, fdat_, 0, 0, 0, 0, dos_, dosq_, kos_, kosq_ );
               END IF;

            END;

         END IF;
         acc_ := accc_;

      END LOOP;                  -- Loop through chained accounts
<<SET_SOS45>>
      IF gl.fSOS0 = 0 AND sos_ = 0 THEN  -- Normal=0/Clearing=1 transaction
         BEGIN
            SELECT ref INTO ref_ FROM sos0que WHERE ref=p_ref;
         EXCEPTION
            WHEN NO_DATA_FOUND THEN
               INSERT INTO sos0que (ref) VALUES (p_ref);
         END;
         sos_:=4;
      ELSE
         sos_:=5;
      END IF;

      UPDATE opldok SET fdat = gl.bDATE, sos = sos_ WHERE CURRENT OF c0;

<<NEXT_REC>>
       NULL;
   END LOOP;
    IF check_s <> 0 AND gl.fSOS0 = 0 THEN
      erm := '9308 - No balance in transaction';
      RAISE err;
    END IF;

    n_ := PayRec.FIRST;     -- Account Limits Violation checking
    WHILE n_ IS NOT NULL
    LOOP
      IF PayRec(n_).pap = 1 AND PayRec(n_).dlta > 0 AND
         PayRec(n_).ostc + PayRec(n_).lim + PayRec(n_).dlta > 0
      OR PayRec(n_).pap = 2 AND PayRec(n_).dlta < 0 AND
         PayRec(n_).ostc + PayRec(n_).lim + PayRec(n_).dlta < 0
      THEN  erm := '9301 - Broken limit on account #'||
            PayRec(n_).nls||'('||TO_CHAR(PayRec(n_).kv)||')';
            RAISE err;
      END IF;
      IF PayRec(n_).pap = 1 AND PayRec(n_).dlta < 0 AND
         PayRec(n_).ostc + PayRec(n_).dlta - PayRec(n_).ostx < 0
      OR PayRec(n_).pap = 2 AND PayRec(n_).dlta > 0 AND
         PayRec(n_).ostc + PayRec(n_).dlta - PayRec(n_).ostx > 0
      THEN  erm := '9302 - Broken max balance on account #'||
            PayRec(n_).nls||'('||TO_CHAR(PayRec(n_).kv)||')';
            RAISE err;
      END IF;
      n_ := PayRec.NEXT(n_);
    END LOOP;

    IF sosf_ THEN
      gl.aSOS := 5;
      UPDATE oper SET odat=SYSDATE, bdat=gl.bDATE, sos = 5 WHERE ref=p_ref;
--#ifdef FM
      DELETE FROM ref_que WHERE ref=p_ref RETURNING fmcheck INTO gl.aFMcheck;
--#else
--   DELETE FROM ref_que WHERE ref=p_ref;
--#endif
    END IF;

  END IF;

EXCEPTION
  WHEN err THEN
    bars_audit.trace( 'GL.PAYI: REF=>%s, ERRMSG=>%s', to_char(p_ref)
                    , dbms_utility.format_error_stack() || chr(10) || dbms_utility.format_error_backtrace() );
    raise_application_error(-(20000+ern),chr(92)||erm,TRUE);
  WHEN NO_DATA_FOUND THEN
    raise_application_error(-(20000+ern),'\9333 - Cannot execute #pay',TRUE);
END payi;

/*%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
%
% PROCEDURE  : pay (old external)
% DESCRIPTION : Inserts and pays new document into opldok
%
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%*/

PROCEDURE pay (
      p_flag NUMBER,        -- "Last entry" flag
      p_ref  NUMBER,        -- Doc reference
      p_vdat DATE,          -- Value date
      p_tt   CHAR     DEFAULT NULL,   -- Transaction type
      p_kv   NUMBER   DEFAULT NULL,   -- Currency code
      p_dk   NUMBER   DEFAULT NULL,   -- Debit/Credit flag
      p_nls  VARCHAR2 DEFAULT NULL,   -- Account number
      p_s    NUMBER   DEFAULT NULL,   -- Amount
      p_sq   NUMBER   DEFAULT NULL,   -- Amount (Base Equivalent)
      p_txt  VARCHAR2 DEFAULT NULL    -- Comment
              )
IS
--
--  BARS98 OLD Payment program. ()
--
BEGIN
  gl.payi(p_flag,p_ref,p_vdat,p_tt,p_kv,p_dk,p_nls,p_s,p_sq,0,NULL,p_txt);
END pay;

/*%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
%
% PROCEDURE  : pay2 (Старий виклик (без субрахунків, для сумісності)
% DESCRIPTION : Inserts and pays new document into  opldok
%
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%*/

PROCEDURE pay2 (
      p_flag NUMBER,        -- "Last entry" flag
      p_ref  NUMBER,        -- Doc reference
      p_vdat DATE,          -- Value date
      p_tt   CHAR     DEFAULT NULL,   -- Transaction type
      p_kv   NUMBER   DEFAULT NULL,   -- Currency code
      p_dk   NUMBER   DEFAULT NULL,   -- Debit/Credit flag
      p_nls  VARCHAR2 DEFAULT NULL,   -- Account number
      p_s    NUMBER   DEFAULT NULL,   -- Amount
      p_sq   NUMBER   DEFAULT NULL,   -- Amount (Base Equivalent)
      p_stmt NUMBER   DEFAULT NULL,   -- First(1)/Next(0) Flag
      p_txt  VARCHAR2 DEFAULT NULL    -- Comment
              )
IS
--
--  BARS98 OLD Payment program. ()
--
BEGIN
  gl.payi(p_flag,p_ref,p_vdat,p_tt,p_kv,p_dk,p_nls,p_s,p_sq,p_stmt,NULL,p_txt);
END pay2;

/*%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
%
% PROCEDURE   : pay_bck
% DESCRIPTION : Back Payment.
%
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%*/

PROCEDURE pay_bck ( ref_ NUMBER,               -- Reference number
                    lev_ SMALLINT DEFAULT 5 )  -- BackPay Level
IS
BEGIN
   gl.bck( ref_,lev_);
END pay_bck;

/*%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
%
% PROCEDURE   : bck
% DESCRIPTION : Real Back Payment.
%
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%*/
PROCEDURE bck ( ref_ NUMBER,               -- Reference number
                lev_ SMALLINT DEFAULT 5 )  -- BackPay Level
IS
  sos_    NUMBER;
  dat_    DATE  := gl.bDATE;
  dapp_   DATE;
  acc_    NUMBER;
  accc_   NUMBER;
  stmt_   NUMBER := -1;
  fl_     NUMBER;
  j       NUMBER;
  ms_     NUMBER;
  kv_     NUMBER;
  mkv_    NUMBER;
  rato_   NUMBER;
  ratb_   NUMBER;
  rats_   NUMBER;
  vob_    NUMBER;

  dos_    NUMBER;
  kos_    NUMBER;
  opt_    NUMBER;

  tt_     opldok.tt%type := '001';  --тип транзакціі повторного БЕК
  l_max_dapp  date;    -- дата последних оборотов по saldoa
  l_fRCVR     number;  -- recovery flag

  CURSOR c0 IS
  SELECT ref,fdat,tt,dk,acc,s,sq,stmt,
         txt, NVL(sos,0) sos, rowid
    FROM opldok
   WHERE ref = ref_
     AND NVL(sos,0) <= lev_
   ORDER BY stmt, sos
     FOR UPDATE OF ref NOWAIT;

  CURSOR c1 IS
  SELECT fdat
    FROM opldok
   WHERE ref = ref_
   GROUP BY fdat
   ORDER by fdat;

  ern         CONSTANT POSITIVE := 204;
  err         EXCEPTION;
  erm         VARCHAR2(80);

BEGIN

  bars_audit.info('BCK: STARTED ref='||ref_||',bDATE='||GL.BD()||',lev='||lev_);

   BEGIN
      SELECT 1,vob INTO sos_,vob_ FROM oper WHERE ref = ref_; -- AND sos IN ( 0,1,3,5 );
   EXCEPTION WHEN NO_DATA_FOUND THEN RETURN;
   END;

   IF lev_>=5 THEN -- ful_bak
      BEGIN
         SELECT 1 INTO sos_
           FROM dual
          WHERE EXISTS(SELECT 1 FROM opldok WHERE ref = ref_ AND sos=5 AND fdat > GL.BD() );

          raise_application_error( -(20000+ern), '\9323 - Unable to ful_bak transaction dated after #'||to_char(GL.BD(),'dd-mm-yyyy'), TRUE );

      EXCEPTION
        WHEN NO_DATA_FOUND THEN NULL;
      END;
   END IF;

   UPDATE opldok SET tt=tt_ WHERE ref = ref_ AND tt = 'BAK';

-- Идем по бухмодели, платим обратные фактически, другие - убиваем

   FOR c IN c0 LOOP
      IF c.sos = 0 THEN  -- c.sos = 0
         DELETE FROM opldok WHERE rowid=c.rowid;
      ELSIF c.sos IN (1,3,4,5) THEN  -- c.sos = 1,3,4,5

         if c.stmt=stmt_
         then
           fl_   := 0;
         else
           fl_   := 1;
           stmt_ := c.stmt;
         end if;

         gl.bDATE := c.fdat - CASE WHEN c.sos=3 THEN 1 ELSE 0 END;

         gl.payi( NULL, c.ref, c.fdat,
                  'BAK',NULL,
                     1 - c.dk,
                         c.acc,
                         c.s,
                         c.sq,fl_,
              'СТОРНО '||c.txt);

         IF c.sos = 5 THEN sos_:=5;
         ELSIF c.sos = 4 THEN sos_:=5;
            UPDATE opldok SET sos=4 WHERE rowid=gl.aOROW;
         ELSE   -- sos 1,3
            DELETE FROM opldok WHERE rowid IN (c.rowid, gl.aOROW);
         END IF;
         gl.bDATE := dat_;
      ELSE
         raise_application_error( -(20000+ern), '\9322 - Invalid transaction sos #'||c.sos, TRUE );
      END IF;
   END LOOP;

   IF sos_ = 5 THEN  -- были фактические проводки (sos=5)

      -- Теперь платим по-факту всю бухмодель в режиме "убоя" или "обратной проводки"
      gl.fSOS0 := 1;

      FOR c IN c1 LOOP        -- Для ful-bak платим в каждой дате отдельно
          gl.bDATE := c.fdat; -- попутно ищем максимальную дату
          if lev_>5 THEN
             gl.payi( 2,ref_,gl.bDATE );
          end if;
      END LOOP;

      if NOT (lev_>5) THEN    -- Для обычной оплаты платим все в макс дне
         gl.bDATE:=greatest( gl.bDATE,dat_);
         gl.payi( 2,ref_,gl.bDATE );
      END IF;

      gl.fSOS0 := 0;

      -- осталось упорядочить обороты, убрать "дырки"
      gl.bDATE := dat_;

      FOR c IN c0 LOOP

         IF c.sos=5 AND c.tt<>'BAK' AND (lev_>5 OR c.fdat=gl.bDATE) THEN

            accc_ := c.acc;

            j:=0;

            WHILE accc_ IS NOT NULL LOOP
               SELECT acc, accc, dapp, kv, opt
                 INTO acc_,accc_,dapp_,kv_,opt_ FROM accounts WHERE acc=accc_;

               IF j=0 THEN mkv_:=kv_; j:=1; END IF;

               IF mkv_=kv_ THEN
                 ms_:=c.s;
               ELSE
                 gl.x_rat ( rato_,ratb_,rats_,mkv_,kv_,c.fdat );
                 ms_ := c.s * rato_;
               END IF;

               de_sal( acc_,c.fdat,ms_,c.sq );

               IF vob_=96 THEN   -- Виконати вилучення виправних

                  DECLARE

                     fdat_   DATE :=TRUNC(c.fdat,'MM')-1;
                     dosq0_  NUMBER;
                     kosq0_  NUMBER;
                     dosq_   NUMBER := gl.p_icurval(kv_,ms_,fdat_);
                     kosq_   NUMBER := gl.p_icurval(kv_,ms_,fdat_);

                  BEGIN

                     fdat_:=TRUNC(fdat_,'MM');

                     dos_:=NULL; kos_:=NULL; dosq0_:=NULL; kosq0_:=NULL;

                     UPDATE saldoz
                        SET dos  = dos  - ms_,  kos  = kos  - ms_,
                            dosq = dosq - dosq_,kosq = kosq - kosq_
                      WHERE acc=acc_ AND fdat=fdat_
                     RETURNING dos, kos, dosq,  kosq
                          INTO dos_,kos_,dosq0_,kosq0_;

                     IF dos_=0 AND kos_=0 AND dosq0_=0 AND kosq0_=0 THEN
                        DELETE FROM saldoz WHERE acc=acc_ AND fdat=fdat_;
                     END IF;

                  END;

               END IF;

               IF ( vob_ = 99 ) 
               THEN -- Виконати вилучення виправних за рік

                 DECLARE
                   fdat_   DATE :=TRUNC(c.fdat,'YYYY')-1;
                   dosq0_  NUMBER;
                   kosq0_  NUMBER;
                   dosq_   NUMBER := gl.p_icurval(kv_,ms_,fdat_); -- завжди по курсу ост. роб. дня року
                   kosq_   NUMBER := gl.p_icurval(kv_,ms_,fdat_); -- завжди по курсу ост. роб. дня року
                 BEGIN

                   fdat_ := TRUNC(fdat_,'YYYY');

                   dos_   := NULL;
                   kos_   := NULL;
                   dosq0_ := NULL;
                   kosq0_ := NULL;

                     UPDATE saldoy
                        SET dos  = dos  - ms_
                          , kos  = kos  - ms_
                          , dosq = dosq - dosq_
                          , kosq = kosq - kosq_
                      WHERE acc  = acc_
                        AND fdat = fdat_
                     RETURN dos, kos, dosq,  kosq
                       INTO dos_,kos_,dosq0_,kosq0_;

                     IF ( dos_ = 0 AND kos_ = 0 AND dosq0_ = 0 AND kosq0_ = 0 )
                     THEN
                       delete from SALDOY where ACC = acc_ and FDAT = fdat_;
                     END IF;

                     fdat_ := add_months( trunc( c.fdat, 'MM' ), -1 ); -- 1е число минулого міс.

                     update SALDOZ
                        set DOS_YR  = DOS_YR  - ms_
                          , DOSQ_YR = DOSQ_YR - dosq_
                          , KOS_YR  = KOS_YR  - ms_
                          , KOSQ_YR = KOSQ_YR - kosq_
                      where ACC     = acc_
                        and FDAT    = fdat_;

                  END;

               END IF;


               IF dapp_=c.fdat THEN
                  UPDATE accounts
                     SET dos= dos -ms_,  kos =kos -ms_
                   WHERE acc=acc_ AND dapp=dapp_;
               END IF;
               --
               -- синхронизируем поля dapp, ostc, dos, kos в accounts с последней записью в saldoa(по дате)
               --
               select max(fdat)
                 into l_max_dapp
                 from saldoa
                where acc = acc_;
               --
               if l_max_dapp is not null and l_max_dapp < dapp_
               then
                   -- сохраняем текущий флаг восстановления
                   l_fRCVR  := gl.fRCVR;
                   -- устанавливаем флаг восстановления, чтобы не лазить по saldoa
                   gl.fRCVR := 1;
                   --
                   begin
                        update accounts
                           set (dapp, ostc, dos, kos)
                               =
                               (select fdat, ostf-dos+kos, dos, kos
                                  from saldoa
                                 where acc = acc_
                                   and fdat = l_max_dapp
                               )
                         where acc = acc_;
                        --
                        gl.fRCVR := l_fRCVR;
                   exception
                      when others then
                          -- возвращаем флаг восстановления
                          gl.fRCVR := l_fRCVR;
                          raise;
                   end;
                   --
               end if;
               --
            END LOOP;
         END IF;
      END LOOP;
   END IF;

   -- Теперь убиваем уже не нужные записи в бух-модели
   IF lev_>5 THEN
      DELETE FROM opldok WHERE ref=ref_ AND sos=5;
   ELSE
      DECLARE
         rw0_ ROWID;
         rw1_ ROWID;
      BEGIN
         FOR x IN (
            select a.rowid rwa,b.rowid rwb,a.acc acca,b.acc accb,a.s,a.fdat
              from opldok a,opldok b
             WHERE a.ref=ref_ AND a.tt='BAK' AND a.sos=5
               AND a.dk=0
               AND b.dk=1
               AND a.s=b.s
               AND a.tt=b.tt
               AND a.ref=b.ref
               AND a.sos=b.sos
               AND a.fdat=b.fdat
               AND a.stmt=b.stmt )
         LOOP  -- Вилучити прямі-зворотні проведення
           BEGIN
              select a.rowid,b.rowid INTO rw0_,rw1_
                from opldok a,opldok b
               WHERE a.ref=ref_ AND a.tt<>'BAK' AND a.sos=5
                 AND a.acc=x.accb AND b.acc=x.acca
                 AND a.s=x.s      AND a.fdat=x.fdat
                 AND a.dk=0
                 AND b.dk=1
                 AND a.s=b.s
                 AND a.tt=b.tt
                 AND a.ref=b.ref
                 AND a.sos=b.sos
                 AND a.fdat=b.fdat
                 AND a.stmt=b.stmt
                 AND rownum=1;

              DELETE FROM opldok WHERE rowid IN (x.rwa,x.rwb,rw0_,rw1_);

           EXCEPTION
             WHEN NO_DATA_FOUND THEN NULL;
           END;
         END LOOP;
      END;

   END IF;

   UPDATE oper
      SET sos = NVL((SELECT -2 FROM dual WHERE EXISTS(SELECT 1 FROM opldok WHERE ref=ref_)),-1)
    WHERE ref = ref_;

  bars_audit.info('BCK: COMPLETED ref='||ref_||',bDATE='||gl.bDATE||',lev='||lev_);

  DELETE FROM sos0que
   WHERE ref = ref_
     AND NOT EXISTS (SELECT 1 FROM opldok WHERE sos=4 AND ref = ref_);

  DELETE FROM ref_que
   WHERE ref = ref_;

EXCEPTION
  WHEN OTHERS THEN
  gl.bDATE := dat_;
  gl.fSOS0 := 0;
  bars_audit.info( 'BCK: FAILED '||SQLERRM );
  RAISE;
END bck;

-------------------------------------------------
-- Динамически вычисляет номер счета по формуле
-------------------------------------------------
FUNCTION dyn_nls ( f VARCHAR2,
           ref NUMBER   DEFAULT NULL,   tt VARCHAR2 DEFAULT NULL,
          vdat DATE     DEFAULT NULL,   dk NUMBER   DEFAULT NULL,
          mfoa VARCHAR2 DEFAULT NULL, nlsa VARCHAR2 DEFAULT NULL,
           kva NUMBER   DEFAULT NULL,    s NUMBER   DEFAULT NULL,
          mfob VARCHAR2 DEFAULT NULL, nlsb VARCHAR2 DEFAULT NULL,
           kvb NUMBER   DEFAULT NULL,   s2 NUMBER   DEFAULT NULL)
  RETURN VARCHAR2
IS

c        NUMBER;
n        NUMBER;
x        VARCHAR2(1024)  := f;
nls_     VARCHAR2(15)    := rpad(' ',15);

BEGIN

  x := REPLACE(x,'#(REF)' ,':REF' );
  x := REPLACE(x,'#(TT)'  ,':TT'  );
  x := REPLACE(x,'#(VDAT)',':VDAT');
  x := REPLACE(x,'#(DK)'  ,':DK'  );
  x := REPLACE(x,'#(MFOA)',':MFOA');
  x := REPLACE(x,'#(NLSA)',':NLSA');
  x := REPLACE(x,'#(KVA)' ,':KVA' );
  x := REPLACE(x,'#(S)'   ,':S'   );
  x := REPLACE(x,'#(MFOB)',':MFOB');
  x := REPLACE(x,'#(NLSB)',':NLSB');
  x := REPLACE(x,'#(KVB)' ,':KVB' );
  x := REPLACE(x,'#(S2)'  ,':S2'  );

  c := DBMS_SQL.OPEN_CURSOR;

  DBMS_SQL.PARSE(c,
   'BEGIN :NLS := SUBSTR('|| x ||',1,14);'||
   'END;',DBMS_SQL.NATIVE);


  IF INSTR(f,'#(REF)' )>0 THEN DBMS_SQL.BIND_VARIABLE(c,':REF' , ref); END IF;
  IF INSTR(f,'#(TT)'  )>0 THEN DBMS_SQL.BIND_VARIABLE(c,':TT'  ,  tt); END IF;
  IF INSTR(f,'#(VDAT)')>0 THEN DBMS_SQL.BIND_VARIABLE(c,':VDAT',vdat); END IF;
  IF INSTR(f,'#(DK)'  )>0 THEN DBMS_SQL.BIND_VARIABLE(c,':DK'  ,  dk); END IF;
  IF INSTR(f,'#(MFOA)')>0 THEN DBMS_SQL.BIND_VARIABLE(c,':MFOA',mfoa); END IF;
  IF INSTR(f,'#(NLSA)')>0 THEN DBMS_SQL.BIND_VARIABLE(c,':NLSA',nlsa); END IF;
  IF INSTR(f,'#(KVA)' )>0 THEN DBMS_SQL.BIND_VARIABLE(c,':KVA' , kva); END IF;
  IF INSTR(f,'#(S)'   )>0 THEN DBMS_SQL.BIND_VARIABLE(c,':S'   ,   s); END IF;
  IF INSTR(f,'#(MFOB)')>0 THEN DBMS_SQL.BIND_VARIABLE(c,':MFOB',mfob); END IF;
  IF INSTR(f,'#(NLSB)')>0 THEN DBMS_SQL.BIND_VARIABLE(c,':NLSB',nlsb); END IF;
  IF INSTR(f,'#(KVB)' )>0 THEN DBMS_SQL.BIND_VARIABLE(c,':KVB' , kvb); END IF;
  IF INSTR(f,'#(S2)'  )>0 THEN DBMS_SQL.BIND_VARIABLE(c,':S2'  ,  s2); END IF;

  DBMS_SQL.BIND_VARIABLE(c,':NLS' , nls_);


  n := DBMS_SQL.EXECUTE(c);

  DBMS_SQL.VARIABLE_VALUE(c,':NLS', nls_);
  DBMS_SQL.CLOSE_CURSOR(c);

  RETURN TRIM(nls_);
EXCEPTION WHEN OTHERS THEN
  IF DBMS_SQL.IS_OPEN(c) THEN
     DBMS_SQL.CLOSE_CURSOR(c);
  END IF;
  raise_application_error(-20063,
      substr('\9317 - Cannot get account number via function#'||f
             ||chr(10)||'stmt='||x||chr(10)
             ||dbms_utility.format_error_stack()||chr(10)
             ||dbms_utility.format_error_backtrace(), 1, 4000)
  );

END dyn_nls;
/*%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
%
% PROCEDURE  : payv
% DESCRIPTION : Multicurrency payment
%
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%*/
PROCEDURE payv(flg_  SMALLINT DEFAULT NULL,  -- Plan/Fact flg
               ref_  INTEGER,    -- Reference
               dat_  DATE,       -- Value Date
                tt_  CHAR,       -- Transaction code
                dk_  SMALLINT,   -- Debit/Credit
               kv1_  SMALLINT,   -- Currency code 1
              nls1_  VARCHAR2,   -- Account number 1
              sum1_  DECIMAL,    -- Amount 1
               kv2_  SMALLINT,   -- Currency code 2
              nls2_  VARCHAR2,   -- Account number 2
              sum2_  DECIMAL     -- Amount 2
              )
IS
BEGIN
   pays(flg_,ref_,dat_,tt_,dk_,kv1_,nls1_,sum1_,kv2_,nls2_,sum2_,NULL,NULL);
END payv;
PROCEDURE pays(flg_  SMALLINT DEFAULT NULL,  -- Plan/Fact flg
               ref_  INTEGER,    -- Reference
               dat_  DATE,       -- Value Date
                tt_  CHAR,       -- Transaction code
                dk_  SMALLINT,   -- Debit/Credit
               kv1_  SMALLINT,   -- Currency code 1
              nls1_  VARCHAR2,   -- Account number 1
              sum1_  DECIMAL,    -- Amount 1
               kv2_  SMALLINT,   -- Currency code 2
              nls2_  VARCHAR2,   -- Account number 2
              sum2_  DECIMAL,    -- Amount 2
              sub_   VARCHAR2 DEFAULT NULL, --SubAccount N
              txt_   VARCHAR2 DEFAULT NULL  --transaction comm
              )
IS
--
--  Modification history:
--  10/01/99  (MIK) Created
--
kv980_   SMALLINT;
fact_    SMALLINT;
dk0_     SMALLINT;
dk1_     SMALLINT;
xk0_     SMALLINT;
xk1_     SMALLINT;


s3801_1  INTEGER;
s3801_2  INTEGER;
s6201_   INTEGER;
s7201_   INTEGER;

s6201_1  INTEGER;
s6201_2  INTEGER;
s7201_1  INTEGER;
s7201_2  INTEGER;

acc0_    INTEGER;
acc1_    INTEGER;
acc2_    INTEGER;

eq1_     DECIMAL(24);
eq2_     DECIMAL(24);
s1_      DECIMAL(24);
s2_      DECIMAL(24);
x1_      DECIMAL(24);
x2_      DECIMAL(24);


pos1_    INTEGER;
pos2_    INTEGER;
peq_     DECIMAL;    -- Base Equvivalent

s3800_   VARCHAR2(200);
ves1_    VARCHAR2(15);
ves2_    VARCHAR2(15);

ttn_     VARCHAR(70);

rato_    NUMBER;
ratb_    NUMBER;
rats_    NUMBER;

tip_    CHAR(3);

ern                             CONSTANT POSITIVE := 063;
erm                             VARCHAR2(256);
err                             EXCEPTION;

BEGIN


IF deb.debug THEN
   deb.trace(ern,'ref',ref_);
END IF;

kv980_ := gl.baseval;

s1_  := sum1_;
s2_  := sum2_;
peq_ := gl.aEQIV;  -- Base Equvivalent

IF dk_=0 THEN
   dk0_ := 1;
   dk1_ := 0;
ELSIF dk_=1 THEN
   dk0_ := 0;
   dk1_ := 1;
ELSE
   erm := '9312 - Debit/Credit invalid #'||dk_;
   RAISE err;
END IF;

BEGIN
   SELECT SUBSTR(flags,38,1), TRIM(s3800), s6201, s7201, name
    INTO  fact_,s3800_,s6201_,s7201_,ttn_ FROM tts WHERE tt=tt_;
EXCEPTION
   WHEN NO_DATA_FOUND THEN
   erm := '9342 - No transaction defined #'||tt_;
   RAISE err;
END;

ttn_:=NVL(txt_,ttn_);

IF kv1_ = kv2_ THEN      -- Single currency
   gl.aEQIV := 0;
   gl.payi(0, ref_, dat_, tt_, kv1_, dk0_, nls1_, s1_, peq_, 1, sub_, ttn_);
   gl.payi(0, ref_, dat_, tt_, kv2_, dk1_, nls2_, s1_, peq_, 0, sub_, ttn_);
ELSE                     -- Multy currency

   IF SUBSTR(s3800_,1,2)='#(' THEN -- Dynamic CUR_POS account number present
      s3800_ :=  dyn_nls(SUBSTR(s3800_,3,LENGTH(s3800_)-3),
                 ref  => ref_,  tt  => tt_,
                 nlsa => nls1_, kva => kv1_, s  => sum1_,
                 nlsb => nls2_, kvb => kv2_, s2 => sum2_);
   END IF;

   IF s1_ IS NULL AND s2_ IS NOT NULL THEN
      x_rat ( rato_,ratb_,rats_,kv2_,kv1_,dat_ );
      s1_ := s2_ * rato_;
      UPDATE oper SET s=s1_ WHERE ref=ref_ AND s IS NULL;
   END IF;
   IF s2_ IS NULL AND s1_ IS NOT NULL THEN
      x_rat ( rato_,ratb_,rats_,kv1_,kv2_,dat_ );
      s2_ := s1_ * rato_;
      UPDATE oper SET s2=s2_ WHERE ref=ref_ AND s2 IS NULL;
   END IF;

   tip_  := NULL;
   pos1_ := 0;
   pos2_ := 0;

   IF kv1_<>kv980_ THEN
      BEGIN
         SELECT acc,tip
         INTO acc1_,tip_
         FROM accounts
         WHERE nls=s3800_ AND kv=kv1_;
      EXCEPTION
      WHEN NO_DATA_FOUND THEN
         erm := '9310 - No CUR-POS account found #'||s3800_||'('||TO_CHAR(kv1_)||')';
         RAISE err;
      END;

      IF pay_schema=2 AND kv2_=kv980_ THEN -- NBU Payment schema
         BEGIN
            SELECT pos INTO pos1_ FROM accounts
             WHERE nls=nls1_ AND kv=kv1_;
         EXCEPTION
            WHEN NO_DATA_FOUND THEN
            erm := '9300 - No account found #'||nls1_||'('||TO_CHAR(kv1_)||')';
            RAISE err;
         END;
         BEGIN
            SELECT s0000 INTO ves1_ FROM tabval WHERE kv=kv1_;
         EXCEPTION
            WHEN NO_DATA_FOUND THEN
            erm := '9313 - No currency defined #('||TO_CHAR(kv1_)||')';
            RAISE err;
         END;
      END IF;
      IF pay_schema=2 AND kv2_=kv980_  THEN -- NBU Payment schema
         gl.payi(   0, ref_, dat_, tt_, kv1_, dk0_, nls1_, s1_, s2_, 1, sub_, ttn_);
         gl.payi(NULL, ref_, dat_, tt_, kv1_, dk1_, acc1_, s1_, s2_, 0, sub_, ttn_);

         x1_ := gl.p_icurval(kv1_,s1_,dat_) - s2_;
         IF x1_<0 THEN xk0_ := 1-dk0_; xk1_ := 1-dk1_; x1_:= -x1_;
                  ELSE xk0_ :=   dk0_; xk1_ :=   dk1_; END IF;

         IF NVL(pos1_,0)=0 THEN
            gl.payi(   0, ref_, dat_, tt_, kv1_,   xk0_, nls1_,   0, x1_, 1, sub_, ttn_);
            gl.payi(   0, ref_, dat_, tt_, kv1_,   xk1_, ves1_,   0, x1_, 0, sub_, ttn_);
         END IF;


         gl.payi(   0, ref_, dat_, tt_, kv1_,   xk0_, ves1_,   0, x1_, 1, sub_, ttn_);
         gl.payi(NULL, ref_, dat_, tt_, kv1_,   xk1_, acc1_,   0, x1_, 0, sub_, ttn_);

      ELSE
         gl.payi(   0, ref_, dat_, tt_, kv1_, dk0_, nls1_, s1_, 0, 1, sub_, ttn_);
         gl.payi(NULL, ref_, dat_, tt_, kv1_, dk1_, acc1_, s1_, 0, 0, sub_, ttn_);
      END IF;
   END IF;

   IF kv2_<>kv980_ THEN
      BEGIN
         SELECT acc,tip
         INTO acc2_,tip_
         FROM accounts
         WHERE nls=s3800_ AND kv=kv2_;
      EXCEPTION
      WHEN NO_DATA_FOUND THEN
         erm := '9310 - No CUR-POS account found #'||s3800_||'('||TO_CHAR(kv2_)||')';
         RAISE err;
      END;

      IF pay_schema=2 AND kv1_=kv980_  THEN -- NBU Payment schema
         BEGIN
            SELECT pos INTO pos2_ FROM accounts
             WHERE nls=nls2_ AND kv=kv2_;
         EXCEPTION
            WHEN NO_DATA_FOUND THEN
            erm := '9300 - No account found #'||nls2_||'('||TO_CHAR(kv2_)||')';
            RAISE err;
         END;
         BEGIN
            SELECT s0000 INTO ves2_ FROM tabval WHERE kv=kv2_;
         EXCEPTION
            WHEN NO_DATA_FOUND THEN
            erm := '9313 - No currency defined #('||TO_CHAR(kv2_)||')';
            RAISE err;
         END;
      END IF;
      IF pay_schema=2 AND kv1_=kv980_ THEN -- NBU Payment schema
         gl.payi(NULL, ref_, dat_, tt_, kv2_, dk0_, acc2_, s2_, s1_, 1, sub_, ttn_);
         gl.payi(   0, ref_, dat_, tt_, kv2_, dk1_, nls2_, s2_, s1_, 0, sub_, ttn_);

         x2_ := gl.p_icurval(kv2_,s2_,dat_) - s1_;
         IF x2_<0 THEN xk0_ := 1-dk0_; xk1_ := 1-dk1_; x2_:= -x2_;
                  ELSE xk0_ :=   dk0_; xk1_ :=   dk1_; END IF;
         IF NVL(pos2_,0)=0 THEN
            gl.payi( 0, ref_, dat_, tt_,   kv2_, xk0_, ves2_,   0, x2_, 1, sub_, ttn_);
            gl.payi( 0, ref_, dat_, tt_,   kv2_, xk1_, nls2_,   0, x2_, 0, sub_, ttn_);
         END IF;

         gl.payi(NULL, ref_, dat_, tt_,   kv2_,   xk0_, acc2_,   0, x2_, 1, sub_, ttn_);
         gl.payi(   0, ref_, dat_, tt_,   kv2_,   xk1_, ves2_,   0, x2_, 0, sub_, ttn_);
      ELSE
         gl.payi(NULL, ref_, dat_, tt_, kv2_, dk0_, acc2_, s2_, 0, 1, sub_, ttn_);
         gl.payi(   0, ref_, dat_, tt_, kv2_, dk1_, nls2_, s2_, 0, 0, sub_, ttn_);
      END IF;
   END IF;

   BEGIN
      IF kv1_=kv980_ THEN
         eq1_  := s1_;
         SELECT acc INTO s3801_1 FROM accounts
          WHERE nls=nls1_ AND kv=kv980_;
      ELSE
         eq1_ := gl.p_icurval(kv1_,s1_,dat_);
         SELECT acc3801,acc_rrd,acc_rrr
           INTO s3801_1,s6201_1,s7201_1
           FROM vp_list
          WHERE acc3800=acc1_;
      END IF;
   EXCEPTION
      WHEN NO_DATA_FOUND THEN
         IF kv1_=kv980_ THEN
            erm := '#'||nls1_;
         ELSE
            erm := tip_ ||' CUR_POS_EQV';
         END IF;
         erm := '9300 - No account found '||erm||'('||TO_CHAR(kv1_)||')';
         RAISE err;
   END;

   BEGIN

      IF kv2_=kv980_ THEN
         eq2_  := s2_;
         SELECT acc INTO s3801_2 FROM accounts
          WHERE nls=nls2_ AND kv=kv980_;
      ELSE
         eq2_ := gl.p_icurval(kv2_,s2_,dat_);
         SELECT acc3801,acc_rrd,acc_rrr
           INTO s3801_2,s6201_2,s7201_2
           FROM vp_list
          WHERE acc3800=acc2_;
      END IF;

   EXCEPTION
      WHEN NO_DATA_FOUND THEN
         IF kv2_=kv980_ THEN
            erm := '#'||nls2_;
         ELSE
            erm := tip_ ||' CUR_POS_EQV';
         END IF;
         erm := '9300 - No account found '||erm||'('||TO_CHAR(kv2_)||')';
         RAISE err;
   END;

   IF pay_schema IN (2,3) AND eq1_<>eq2_ AND (s6201_ IS NULL OR s7201_ IS NULL)
      THEN -- NBU Payment schema
      IF dk_=1 THEN
         IF kv2_=kv980_ THEN
            s7201_ := s7201_1; s6201_ := s6201_1;
         ELSE
            s7201_ := s7201_2; s6201_ := s6201_2;
         END IF;
      ELSE
         IF kv1_=kv980_ THEN
            s7201_ := s7201_2; s6201_ := s6201_2;
         ELSE
            s7201_ := s7201_1; s6201_ := s6201_1;
         END IF;
      END IF;
   END IF;

   IF deb.debug THEN
      deb.trace(ern,'s3800',s3800_);
      deb.trace(ern,'s6201',s6201_);
      deb.trace(ern,'s7201',s7201_);
   END IF;

   IF dk_=1 AND eq1_<eq2_ OR dk_=0 AND eq1_>eq2_ THEN       -- Loses
      IF s7201_ IS NULL THEN
         erm := '9300 - No CUR expense account defined';
         RAISE err;
      END IF;
      gl.payi(NULL,ref_,dat_,tt_,kv980_,0,s7201_,ABS(eq2_-eq1_),0,1,sub_,ttn_);
   ELSIF dk_=1 AND eq1_>eq2_ OR dk_=0 AND eq1_<eq2_ THEN    -- Profit
      IF s7201_ IS NULL THEN
         erm := '9300 - No CUR profit account defined';
         RAISE err;
      END IF;
      gl.payi(NULL,ref_,dat_,tt_,kv980_,1,s6201_,ABS(eq1_-eq2_),0,1,sub_,ttn_);
   END IF;

   IF pay_schema=1 THEN -- Georgian  Payment schema

      IF eq1_=eq2_ THEN  -- GEO
         gl.payi(NULL,ref_,dat_,tt_,kv980_,dk0_,s3801_1,eq1_,0,1,sub_,ttn_);
         gl.payi(NULL,ref_,dat_,tt_,kv980_,dk1_,s3801_2,eq2_,0,0,sub_,ttn_);

      ELSIF eq1_>eq2_ THEN
        gl.payi(NULL,ref_,dat_,tt_,kv980_,dk0_,s3801_1,eq1_-eq2_,0,0,sub_,ttn_);
        gl.payi(NULL,ref_,dat_,tt_,kv980_,dk1_,s3801_2, eq2_,    0,1,sub_,ttn_);
        gl.payi(NULL,ref_,dat_,tt_,kv980_,dk0_,s3801_1, eq2_,    0,0,sub_,ttn_);

      ELSIF eq1_<eq2_ THEN
        gl.payi(NULL,ref_,dat_,tt_,kv980_,dk1_,s3801_2,eq2_-eq1_,0,0,sub_,ttn_);
        gl.payi(NULL,ref_,dat_,tt_,kv980_,dk0_,s3801_1, eq1_,    0,1,sub_,ttn_);
        gl.payi(NULL,ref_,dat_,tt_,kv980_,dk1_,s3801_2, eq1_,    0,0,sub_,ttn_);
      END IF;

   ELSIF pay_schema in (2,3) THEN -- NBU Payment schema
      IF eq1_=eq2_ THEN  --
         gl.payi(NULL,ref_,dat_,tt_,kv980_,dk0_,s3801_1,eq1_,0,1,sub_,ttn_);
         gl.payi(NULL,ref_,dat_,tt_,kv980_,dk1_,s3801_2,eq2_,0,0,sub_,ttn_);
      ELSE

        IF dk_=1 THEN
          IF kv2_=kv980_ THEN -- grn cred
           IF eq1_<eq2_ THEN
              gl.payi(NULL,ref_,dat_,tt_,kv980_,1,s3801_1,eq2_-eq1_,0,0,sub_,ttn_);
           ELSIF eq1_>eq2_ THEN
              gl.payi(NULL,ref_,dat_,tt_,kv980_,0,s3801_1,eq1_-eq2_,0,0,sub_,ttn_);
           END IF;
           gl.payi(NULL,ref_,dat_,tt_,kv980_,0,s3801_1, eq2_,    0,1,sub_,ttn_);
           gl.payi(NULL,ref_,dat_,tt_,kv980_,1,s3801_2, eq2_,    0,0,sub_,ttn_);
          ELSE
           IF eq1_<eq2_ THEN
              gl.payi(NULL,ref_,dat_,tt_,kv980_,1,s3801_2,eq2_-eq1_,0,0,sub_,ttn_);
           ELSIF eq1_>eq2_ THEN
              gl.payi(NULL,ref_,dat_,tt_,kv980_,0,s3801_2,eq1_-eq2_,0,0,sub_,ttn_);
           END IF;
           gl.payi(NULL,ref_,dat_,tt_,kv980_,0,s3801_1, eq1_,    0,1,sub_,ttn_);
           gl.payi(NULL,ref_,dat_,tt_,kv980_,1,s3801_2, eq1_,    0,0,sub_,ttn_);
          END IF;
        ELSIF dk_=0 THEN

          IF kv1_=kv980_ THEN -- grn cred
           IF eq1_<eq2_ THEN
              gl.payi(NULL,ref_,dat_,tt_,kv980_,0,s3801_2,eq2_-eq1_,0,0,sub_,ttn_);
           ELSIF eq1_>eq2_ THEN
              gl.payi(NULL,ref_,dat_,tt_,kv980_,1,s3801_2,eq1_-eq2_,0,0,sub_,ttn_);
           END IF;
           gl.payi(NULL,ref_,dat_,tt_,kv980_,1,s3801_1, eq1_,    0,1,sub_,ttn_);
           gl.payi(NULL,ref_,dat_,tt_,kv980_,0,s3801_2, eq1_,    0,0,sub_,ttn_);
          ELSE
           IF eq1_<eq2_ THEN
              gl.payi(NULL,ref_,dat_,tt_,kv980_,0,s3801_1,eq2_-eq1_,0,0,sub_,ttn_);
           ELSIF eq1_>eq2_ THEN
              gl.payi(NULL,ref_,dat_,tt_,kv980_,1,s3801_1,eq1_-eq2_,0,0,sub_,ttn_);
           END IF;
           gl.payi(NULL,ref_,dat_,tt_,kv980_,1,s3801_1, eq2_,    0,1,sub_,ttn_);
           gl.payi(NULL,ref_,dat_,tt_,kv980_,0,s3801_2, eq2_,    0,0,sub_,ttn_);
          END IF;
        END IF;
      END IF;
   ELSE                 -- Ukrainian Payment schema

      gl.payi(NULL,ref_,dat_,tt_,kv980_,dk0_,s3801_1,eq1_,0,0,sub_,ttn_);
      gl.payi(NULL,ref_,dat_,tt_,kv980_,dk1_,s3801_2,eq2_,0,0,sub_,ttn_);

   END IF;

END IF;

IF flg_=1 OR (flg_=2 OR flg_ IS NULL) AND fact_=1 THEN
   gl.payi( 2,ref_,dat_);
END IF;

EXCEPTION
   WHEN err    THEN
        raise_application_error(-(20000+ern),chr(92)||erm,TRUE);
   WHEN NO_DATA_FOUND THEN
        raise_application_error(-(20000+ern),'\9333 - Cannot execute #pays',TRUE);
END pays;

/*%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
%
% DESCRIPTION : Re-evaluation of Currency position accounts
% COPYRIGHT   : Copyright UNITY-BARS Limited, 1998.  All Rights Reserved.
%
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%*/

PROCEDURE p_pvp  ( kv_ NUMBER DEFAULT NULL,
                   dat_  DATE DEFAULT NULL) IS

fdat_    DATE;
bdat_    DATE;         -- для БД
acc3801_ NUMBER;       -- sch EKV VAL POZ
acc6204_ NUMBER;       -- sch PER VAL POZ
s1_      DECIMAL(24);  -- VAL POZ tek kurs
s2_      DECIMAL(24);  -- na sch EKV VAL POZ
dk_      INTEGER;
ref_     INTEGER;
name_    VARCHAR2(70);  -- PVP Transaction name
nam_a_   VARCHAR2(70);
nam_b_   VARCHAR2(70);
nls3801_ VARCHAR2(15);   -- sch EKV VAL POZ
nls6204_ VARCHAR2(15);   -- sch PER VAL POZ
l_nd     oper.nd%type;

CURSOR c0 IS
SELECT v.acc3801,SUM(gl.p_icurval( a.kv, s.ostf-s.dos+s.kos, gl.bDATE ))
  FROM accounts a, saldoa s, vp_list v
 WHERE a.acc=v.acc3800 AND a.acc=s.acc AND v.acc3801 IS NOT NULL AND
      (a.acc,s.fdat) =
      (SELECT c.acc,MAX(c.fdat) FROM saldoa c
        WHERE c.acc=a.acc AND c.fdat<=gl.bDATE GROUP BY c.acc)
  AND (a.kv=kv_ OR kv_ is NULL)
GROUP BY v.acc3801;

ern         CONSTANT POSITIVE := 205;
err         EXCEPTION;
erm         VARCHAR2(80);

BEGIN

bdat_ := gl.bDATE;
fdat_ := NVL(dat_,gl.bDATE);

BEGIN
   SELECT name INTO name_ FROM tts WHERE tt='PVP';
EXCEPTION
   WHEN NO_DATA_FOUND THEN name_ := 'Currency position Revaluation';
END;

IF deb.debug THEN
   deb.trace( ern, 'PVP Started, KV', kv_ );
END IF;

FOR d IN ( SELECT gl.bDATE fdat FROM dual
            UNION
           SELECT fdat FROM fdat WHERE fdat >= fdat_
           GROUP BY fdat
           ORDER BY 1 ) LOOP

   gl.bDATE := d.fdat;

   IF deb.debug THEN
      deb.trace( ern, 'bDATE SELECTED', gl.bDATE );
   END IF;

   OPEN c0;
   LOOP <<MET>>

      FETCH c0 INTO acc3801_,s1_;
      EXIT WHEN c0%NOTFOUND;

      BEGIN
         SELECT s.ostf-s.dos+s.kos INTO s2_
           FROM accounts a,saldoa s
          WHERE a.acc = acc3801_ AND a.acc=s.acc AND
                (s.acc,s.fdat) =
                (SELECT c.acc,MAX(c.fdat) FROM saldoa c
                  WHERE c.acc=a.acc AND c.fdat<=gl.bDATE GROUP BY c.acc );
      EXCEPTION
         WHEN NO_DATA_FOUND THEN s2_ := 0;
      END;

      IF deb.debug THEN
         deb.trace( ern, s1_||' ? '||s2_,acc3801_);
      END IF;

      s2_ := s1_ + s2_;

      IF s2_ = 0 THEN  -- est ravenstvo
         GOTO MET;
      END IF;

      IF s2_ > 0 THEN
         dk_ := 0;
      ELSE
         dk_ := 1;
      END IF;

      BEGIN
         SELECT nls,nms INTO nls3801_,nam_a_
           FROM accounts WHERE acc=acc3801_;
      EXCEPTION
         WHEN NO_DATA_FOUND THEN nam_a_ := 'Currency position EQV';
      END;

      BEGIN
         SELECT acc,nls,nms INTO acc6204_,nls6204_,nam_b_
           FROM accounts
          WHERE acc =
       ( SELECT acc6204 FROM vp_list
          WHERE acc3801=acc3801_ AND rownum=1
            AND acc6204 IS NOT NULL );
      EXCEPTION
         WHEN NO_DATA_FOUND THEN
         erm := '9300 - No CUR P/L account defined';
         RAISE err;
      END;

      gl.ref (ref_);


	  if length(ref_) > 10 then
      l_nd := substr(ref_,-10);
	  else
      l_nd := ref_;
	  end if;

	  INSERT INTO oper (ref,tt,vob,nd,dk,pdat,vdat,datd,userid,
                      nam_a,nlsa,mfoa,nam_b,nlsb,mfob,kv,s,nazn)
    VALUES
      (ref_,'PVP',6, l_nd ,1-dk_, SYSDATE,gl.bDATE,gl.bDATE,gl.aUID,
       SUBSTR(nam_a_,1,38),nls3801_,gl.aMFO,
       SUBSTR(nam_b_,1,38),nls6204_,gl.aMFO,gl.baseval,ABS(s2_),name_);

      gl.payi( NULL,ref_,gl.bDATE,'PVP',gl.baseval,  dk_,acc3801_,ABS(s2_),0,1,NULL,name_);
      gl.payi( NULL,ref_,gl.bDATE,'PVP',gl.baseval,1-dk_,acc6204_,ABS(s2_),0,0,NULL,name_);
      gl.payi( 2,   ref_,gl.bDATE);

    END LOOP;
    CLOSE c0;

  END LOOP;

  gl.bDATE := bdat_;

EXCEPTION
  WHEN err    THEN
    gl.bDATE := bdat_;
    raise_application_error(-(20000+ern),chr(92)||erm,TRUE);
  WHEN OTHERS THEN
    gl.bDATE := bdat_;
    raise_application_error(-(20000+ern),SQLERRM,TRUE);
END p_pvp;

/*%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
%
% PROCEDURE  : x_rat
% DESCRIPTION : Calculates Cross Rate of 2 currencies
%                 via NBU rate to BASE curency
%
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%*/
PROCEDURE x_rat ( rat_o OUT NUMBER,     -- xrato
                  rat_b OUT NUMBER,     -- xratb
                  rat_s OUT NUMBER,     -- xrats
                   kv1_ NUMBER,         -- cur1
                   kv2_ NUMBER,         -- cur2
                   dat_ DATE DEFAULT NULL ) IS

rdat_     DATE;
i         SMALLINT;
kv_       SMALLINT;
rato_     NUMBER;
ratb_     NUMBER;
rats_     NUMBER;

rat1_o    NUMBER;
rat1_b    NUMBER;
rat1_s    NUMBER;
rat2_o    NUMBER;
rat2_b    NUMBER;
rat2_s    NUMBER;

bsum_     NUMBER;
bsum1_    NUMBER;
bsum2_    NUMBER;
ern         CONSTANT POSITIVE := 223;  -- Cannot obtain rate
err         EXCEPTION;
erm         VARCHAR2(80);

BEGIN

   IF dat_ IS NULL THEN
      rdat_ := gl.bDATE;
   ELSE
      rdat_ := dat_;
   END IF;

   FOR i IN 1 .. 2 LOOP

      IF i=1 THEN kv_ := kv1_; ELSE kv_ := kv2_; END IF;

      BEGIN
         SELECT bsum,rate_o,rate_b,rate_s
           INTO bsum_, rato_, ratb_, rats_
           FROM cur_rates WHERE (kv,vdate) =
        (SELECT kv,MAX(vdate) FROM cur_rates
          WHERE kv=kv_ AND vdate <= rdat_ GROUP BY kv);
      EXCEPTION
         WHEN NO_DATA_FOUND THEN
              erm := '9314 - No rate was set for currency #('||kv_||'@'||rdat_||')';
              RAISE err;
      END;

   IF deb.debug THEN
      deb.trace(ern,'kv',kv_);
      deb.trace(ern,'rat',rato_);
   END IF;

      IF i=1 THEN
         rat1_o := rato_;
         IF ratb_ IS NULL THEN rat1_b := rato_; ELSE rat1_b := ratb_; END IF;
         IF rats_ IS NULL THEN rat1_s := rato_; ELSE rat1_s := rats_; END IF;
         bsum1_ := bsum_;
      ELSE
         rat2_o := rato_;
         IF ratb_ IS NULL THEN rat2_b := rato_; ELSE rat2_b := ratb_; END IF;
         IF rats_ IS NULL THEN rat2_s := rato_; ELSE rat2_s := rats_; END IF;
         bsum2_ := bsum_;
      END IF;

   END LOOP;
   rat_o := bsum2_*rat1_o/rat2_o/bsum1_;
   rat_b := bsum2_*rat1_b/rat2_s/bsum1_;
   rat_s := bsum2_*rat1_s/rat2_b/bsum1_;

   RETURN;
EXCEPTION
   WHEN err    THEN
        raise_application_error(-(20000+ern),chr(92)||erm,TRUE);
END x_rat;

/*%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
%
% PROCEDURE  : dyntt
% DESCRIPTION : Dynamic payment transaction linking
%
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%*/
--**************************************************************************
--*  Динамічний виклик paytt * Викинути, разом з dyntt, коли все затихне ***
--**************************************************************************

PROCEDURE dyn_paytt (flg_ SMALLINT,  -- флаг оплаты
                     ref_ INTEGER,   -- референция
                    vdat_ DATE,      -- дата валютировния
                      tt_ CHAR,      -- тип транзакции
                      dk_ NUMBER,    -- признак дебет-кредит
                     kva_ SMALLINT,  -- код валюты А
                    nls1_ VARCHAR2,  -- номер счета А
                      sa_ DECIMAL,   -- сумма в валюте А
                     kvb_ SMALLINT,  -- код валюты Б
                    nls2_ VARCHAR2,  -- номер счета Б
                      sb_ DECIMAL    -- сумма в валюте Б
) IS

BEGIN

  PAYTT(flg_, ref_, vdat_, tt_, DK_, kVA_, NLS1_, SA_, KVB_, NLS2_, SB_);

END dyn_paytt;

PROCEDURE dyntt (flg_ NUMBER, ref_ NUMBER, vdat_ DATE,
      dk_ NUMBER,kva_ NUMBER,nlsa_ VARCHAR2,sa_ NUMBER,
                 kvb_ NUMBER,nlsb_ VARCHAR2,sb_ NUMBER) IS

dk0_ INT;
ern         CONSTANT POSITIVE := 206;
err         EXCEPTION;
erm         VARCHAR2(80);

BEGIN
   FOR c0 IN (SELECT tt FROM tts_dyn d,accounts a
               WHERE a.tip=d.tip
                 AND a.nls=nlsb_ AND a.kv=kvb_
)
   LOOP

      dyn_PAYTT( flg_,ref_,vdat_,c0.tt,dk_,kva_,nlsa_,sa_,kvb_,nlsb_,sb_);

      FOR c1 IN (SELECT t.tt,a.dk FROM tts t, ttsap a
                  WHERE a.ttap=t.tt and a.tt=c0.tt )
      LOOP
         IF c1.dk=1 THEN dk0_:=1-dk_; ELSE dk0_:=dk_; END IF;
         dyn_PAYTT( flg_,ref_,vdat_,c1.tt,dk0_,kva_,nlsa_,sa_,kvb_,nlsb_,sb_);
      END LOOP;

   END LOOP;

EXCEPTION
   WHEN NO_DATA_FOUND THEN
        raise_application_error(-(20000+ern),'\9333 - Cannot execute #dyntt',TRUE);

END dyntt;
PROCEDURE dyntt2 (sos_ IN OUT NUMBER,
                 mod1_ NUMBER, mod2_ NUMBER,
                  ref_ NUMBER,
                vdat1_ DATE, vdat2_ DATE,  tt0_ CHAR,
       dk_ NUMBER,kva_ NUMBER,mfoa_ VARCHAR2,nlsa_ VARCHAR2,sa_ NUMBER,
                  kvb_ NUMBER,mfob_ VARCHAR2,nlsb_ VARCHAR2,sb_ NUMBER,
       sq_ NUMBER,
      nom_ NUMBER) IS
-------------------------------------------------
-- Платить:
-------------------------------------------------
-- mod1 0 - по плану
--      1 - по факту
--      2 - без оплати основної (але дочірні - по факту)
--      4 - без оплати основної (з візами)
--      8 - Формула суми в головній операції
--      9 - по факту (динамічна прив"язка дочірніх по типу рахунку)
-- mod2 0 - Відкладена фактична оплата (десь платиться потім в процедурі)
-------------------------------------------------
tt_   CHAR(3);
dk0_  NUMBER;
vdat_ DATE;
s1_   NUMBER;
s2_   NUMBER;
flg36_  SMALLINT := 0; -- комбо

S1    tts.s %type;
S2    tts.s2%type;

ern         CONSTANT POSITIVE := 204;
err         EXCEPTION;
erm         VARCHAR2(80);

PROCEDURE get_s (S1# VARCHAR2, S2# VARCHAR2) IS
S     VARCHAR2(4000);
rez_  NUMBER;
BEGIN

   FOR i IN 0..1 LOOP
      IF i=0 THEN S:=S1#; s1_:=sa_; rez_:=sa_;
             ELSE S:=S2#; s2_:=sb_; rez_:=sb_; END IF;  -- Formula
      IF TRIM(S) IS NOT NULL THEN
         S := REPLACE(S,'#(DK)',  TO_CHAR(dk_));
         S := REPLACE(S,'#(S)',   TO_CHAR(sa_));
         S := REPLACE(S,'#(S2)',  TO_CHAR(sb_));
         S := REPLACE(S,'#(NOM)', TO_CHAR(nom_));
         S := REPLACE(S,'#(TT)',  ''''||tt0_ ||'''');
         S := REPLACE(S,'#(NLSA)',''''||nlsa_||'''');
         S := REPLACE(S,'#(NLSB)',''''||nlsb_||'''');
         S := REPLACE(S,'#(MFOA)',''''||mfoa_||'''');
         S := REPLACE(S,'#(MFOB)',''''||mfob_||'''');
         S := REPLACE(S,'#(REF)',TO_CHAR(ref_));
         S := REPLACE(S,'#(KVA)',TO_CHAR(kva_));
         S := REPLACE(S,'#(KVB)',TO_CHAR(kvb_));

         EXECUTE IMMEDIATE 'BEGIN :REZ := '||S||'; END;'
         using out rez_;

         IF i=0 THEN s1_:=rez_; ELSE s2_:=rez_; END IF;  -- Formula
      END IF;
   END LOOP;
END get_s;

BEGIN

dk0_:= dk_;
tt_ := tt0_;
s1_ := sa_;
s2_ := sb_;

IF mod1_ IN (0,1,4) THEN

   BEGIN
      SELECT t.s,t.s2,SUBSTR(flags,37,1) INTO S1,S2,flg36_
        FROM tts t
       WHERE t.tt = tt_;
   EXCEPTION
      WHEN NO_DATA_FOUND THEN GOTO M;
   END;

ELSIF mod1_=9 THEN

   BEGIN
      SELECT t.tt,t.dk,t.s,t.s2 INTO tt_,dk0_,S1,S2
        FROM tts_dyn d,accounts a,tts t
       WHERE a.tip=d.tip AND d.tt=t.tt AND a.nls=nlsb_ AND a.kv=kvb_;
   EXCEPTION
      WHEN NO_DATA_FOUND THEN GOTO M;
   END;

END IF;

if mod1_ IN (0,1,9) and dk0_ IN (0,1) THEN -- Main transaction payment

   get_s( S1,S2 );  -- подстановка формулы суммы

   dyn_PAYTT( 0,ref_,vdat1_,tt_,dk0_,kva_,nlsa_,s1_,kvb_,nlsb_,s2_);
END IF;

FOR c0 IN (SELECT t.tt,a.dk,t.s,t.s2
             FROM tts t, ttsap a
            WHERE a.ttap=t.tt and a.tt=tt_ )
LOOP

   IF vdat2_ IS NULL THEN
      vdat_ := vdat1_;
   ELSE
      vdat_ := vdat2_;
   END IF;

   IF c0.dk=1 THEN dk0_:=1-dk_; ELSE dk0_:=dk_; END IF;

-- Linked operation payment

   get_s( c0.s,c0.s2 );  -- подстановка формулы суммы

   dyn_PAYTT( 0,ref_,vdat_,c0.tt,dk0_,kva_,nlsa_,s1_,kvb_,nlsb_,s2_);
END LOOP;

<<M>>
IF mod2_=1 AND mod1_ IN (1,2,9) THEN
   gl.payi(2,ref_,vdat1_);
ELSIF mod1_ IN (0,4) AND flg36_=1 THEN   -- платим комбо (по факту дочірні)
   gl.payi(3,ref_,vdat1_);
END IF;
sos_ := gl.aSOS;


EXCEPTION
   WHEN NO_DATA_FOUND THEN
        raise_application_error(-(20000+ern),'\9333 - Cannot execute #dyntt2',TRUE);
END dyntt2;

--
-- Оплата проводок sos=0
-- по одному МФО
--
procedure PAYSOS0
is
  ref#       NUMBER(38)  := NULL;
  ref_       NUMBER(38);
  fdat#      DATE        := NULL;
  fdat_      DATE;

  acc#       NUMBER(38)  := NULL;
  acc_       NUMBER(38);

  vob#       SMALLINT   := NULL;
  vob_       SMALLINT;
  vobO_      SMALLINT   := 0;

  dk#        opldok.dk%type;
  s#         opldok.s%type;
  sq#        opldok.sq%type;

  sde_       NUMBER(38) := 0;
  sdeq_      NUMBER(38) := 0;

  skr_       NUMBER(38) := 0;
  skrq_      NUMBER(38) := 0;

  rowid#     UROWID;
  i          INTEGER    := 0;
  j          INTEGER    := 0;
  k          INTEGER    := 0;

  l_kf       oper.kf%type := gl.aMFO;
  l_branch   oper.branch%type := sys_context('bars_context','user_branch');

  CURSOR c0 ( v_min_dt date, v_max_dt date )
  IS
  select o.ref, o.acc, o.fdat, decode(p.VOB,96,96,99,99,6) as VOB
       , o.DK, o.S, o.SQ, o.ROWID
    from OPER    p
       , OPLDOK  o
       , SOS0QUE q
   where o.sos = 4
     and o.ref = q.ref
     and p.ref = q.ref
     and o.ref = p.ref
     and o.FDAT between v_min_dt and v_max_dt
   order by 4, o.ACC, o.FDAT
     FOR UPDATE OF q.ref NOWAIT;

--r_txn  c0%rowtype;

BEGIN

  bars_audit.info( 'SOS0 STARTED' );

  gl.fSOS0 := 1;

  OPEN c0( DAT_NEXT_U( GL.GBD, -1 ), GL.GBD );

  savepoint this#accountT00;

  LOOP

    FETCH c0
     INTO ref#, acc#, fdat#, vob#, dk#, s#, sq#, rowid#;

    IF c0%NOTFOUND AND ref# IS NULL
    THEN EXIT;
    END IF;

    IF c0%NOTFOUND
    OR acc#  <> acc_
    OR fdat# <> fdat_
    OR vob#  <> vob_
    THEN

      begin

--      gl.bDATE := fdat_;
        GL.PL_DAT( fdat_ );

        IF vobO_ <> vob_
        THEN
--        ref_ := to_number( BARS_SQNC.RUKEY( '1' ) );
--
--        update OPER
--           set PDAT = fdat_
--             , VDAT = fdat_
--             , VOB  = vob_
--         where REF = ref_;
--
--        if ( sql%rowcount = 0 )
--        then
          gl.ref( ref_ );

          insert
            into OPER ( REF, TT, PDAT, VDAT, VOB, KF, BRANCH, TOBO )
          values ( ref_,'R00', fdat_, fdat_, vob_, l_kf, l_branch, l_branch )
          return VOB
            into vobO_;

--        bars_audit.info( 'SOS0: ref='||ref_||', vob='||vob_||', vobO='||vobO_ );
--        end if;

        END IF;

        IF sde_>0
        THEN
          insert
            into OPLDOK ( REF, TT, ACC, FDAT, DK, S, SQ, SOS, STMT ,KF )
          values ( ref_, 'R00', acc_, fdat_, 0 ,sde_, sdeq_, 4, 1, l_kf );
        END IF;

        IF ( skr_ > 0 )
        THEN
          INSERT
            INTO OPLDOK ( REF, TT, ACC, FDAT, DK, S, SQ, SOS, STMT, KF )
          VALUES ( ref_,'R00',acc_,fdat_,1 ,skr_,skrq_,4, 1, l_kf );
        END IF;

        GL.PAYI( 2, ref_, fdat_ );

        DELETE FROM opldok WHERE ref=ref_;

        i := i + 1;

      exception
        when others then
          rollback to this#accountT00;
          vobO_ := 0;
          j := j + 1;
          bars_audit.error( 'SOS0 ( ref='||to_char(ref_)||', acc='||to_char(acc_)||', fdat='||
                            to_char(fdat_, 'dd.mm.yyyy')||', vob='||to_char(vob_)||' ) ERROR:'||
                            SubStr( sqlerrm||chr(10)||dbms_utility.format_error_backtrace, 1, 3000 ) );
      end;

      savepoint this#accountT00;

      sde_  := 0;
      sdeq_ := 0;
      skr_  := 0;
      skrq_ := 0;

    END IF;

    EXIT WHEN c0%NOTFOUND;

    IF dk#=0
    THEN
      sde_  := sde_ +s#;
      sdeq_ := sdeq_+sq#;
    ELSE
      skr_  := skr_ +s#;
      skrq_ := skrq_+sq#;
    END IF;

    acc_  := acc#;
    fdat_ := fdat#;
    vob_  := vob#;

    UPDATE opldok
       SET sos = 5
     WHERE rowid = rowid#;

    DELETE sos0que
     WHERE ref = ref#
       AND NOT EXISTS (SELECT 1 FROM opldok WHERE sos=4 AND ref = ref#);

    k := k + 1;

    bars_audit.trace('SOS0 SELECTED ref:'||ref#);

  END LOOP;

  CLOSE c0;

  gl.fSOS0 := 0;

  -- не удаляем запись из OPER, т.к. это приводит к блокировкам по внешним ключам !!!
  --IF i>0 THEN DELETE FROM oper WHERE ref=ref_; END IF;

  GL.PL_DAT( gl.gbDATE );

  bars_audit.info('SOS0 COMPLETED. Success:'||i||', Errors:'||j);

END paysos0;

--
--
--
procedure OVERPAY_PVP
is
  title   constant   varchar2(64) := $$PLSQL_UNIT||'.OVERPAY_PVP';
  l_bnk_dt           oper.vdat%type;
  l_ref              oper.ref%type;
  l_kf               oper.kf%type := gl.aMFO;
  l_branch           oper.branch%type := '/'||l_kf||'/';
begin

  bars_audit.info( title||': Entry.' );

  gl.fSOS0 := 1;

  l_bnk_dt := DAT_NEXT_U( GL.GBD, -1 );

  l_ref := to_number( BARS_SQNC.RUKEY( '1', l_kf ) );

  bars_audit.trace( '%s: bnk_dt=%s, ref=%s.', title, to_char(l_bnk_dt,'dd/mm/yyyy'), to_char(l_ref) );

  savepoint SP_BFR_PAY;

  update OPER
     set PDAT = sysdate
       , VDAT = l_bnk_dt
       , VOB  = 6
       , SOS  = 0
   where REF  = l_ref;

  if ( sql%rowcount = 0 )
  then
    insert
      into OPER
         ( REF, TT, PDAT, VDAT, VOB, SOS, MFOA, MFOB, KF, BRANCH, TOBO )
    values
         ( l_ref, 'PVP', sysdate, l_bnk_dt, 6, 0, l_kf, l_kf, l_kf, l_branch, l_branch );
  end if;

  for t in ( select t.REF, DK, ACC, S, SQ, TT, STMT
               from SOS0QUE q
               join OPLDOK  t
                 on ( t.REF = q.REF )
              where t.SOS  = 4
                and t.TT   = 'PVP'
                and t.FDAT = l_bnk_dt
                and t.KF   = l_kf
                for update of q.REF nowait
           )
  loop

    bars_audit.trace( '%s: ref=%s, acc=%s, dk=%s, s=%s, sq=%s.', title
                    , to_char(t.ref), to_char(t.acc), to_char(t.dk), to_char(t.s), to_char(t.sq) );

    update OPLDOK
       set SOS = 5
     where REF = t.REF;

    delete SOS0QUE
     where ref = t.REF;

    update OPLDOK
       set S  = S  + t.S
         , SQ = SQ + t.SQ
     where FDAT = l_bnk_dt
       and KF   = l_kf
       and REF  = l_ref
       and ACC  = t.ACC
       and DK   = t.DK;

    if ( sql%rowcount = 0 )
    then
      insert
        into OPLDOK
           ( FDAT, KF, REF, ACC, DK, TT, S, SQ, SOS, STMT )
      values
           ( l_bnk_dt, l_kf, l_ref, t.ACC, t.DK, t.TT, t.S, t.SQ, 4, t.STMT );
    end if;

  end loop;

  GL.BDATE := l_bnk_dt;

  GL.PAYI( 2, l_ref, l_bnk_dt );

  delete OPLDOK
   where ref = l_ref;

  gl.bDATE := GL.GBD;
  gl.fSOS0 := 0;

  bars_audit.info( title||': Exit.' );

exception
  when OTHERS then
    gl.bDATE := GL.GBD;
    gl.fSOS0 := 0;
    bars_audit.error( title || ': ' || dbms_utility.format_error_stack() || chr(10) || dbms_utility.format_error_backtrace() );
    rollback to SP_BFR_PAY;
    raise_application_error( -20666, title || ': ' || SQLERRM, true );
end OVERPAY_PVP;

--
-- Создание JOBа оплаты sos0
--
PROCEDURE create_paysos0_job
IS
  l_jobid   number;    /* идентификатор созданного задания */
BEGIN
  DBMS_JOB.SUBMIT(l_jobid, 'gl.paysos0;', SYSDATE,'SYSDATE + 1/48');
  bars_audit.info('SOS0 paysos0 JOB created id='|| to_char(l_jobid));
  COMMIT;
END create_paysos0_job;


--
-- Оплата проводок sos=0 по всем МФО
--
procedure paysos0_full
is
begin
  for c in (select kf from mv_kf)
  loop
    bc.subst_mfo(c.kf);
    gl.paysos0;
    commit;
  end loop;
  bc.set_context;
exception when others then
  bc.set_context;
  raise;
end paysos0_full;

/*%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
%
% FUNCTION  : p_icurval
% DESCRIPTION : This function calculates equivalent of given SUM in
%               given CURRENCY', on given DATE.
% PARAMETERS:
%
%    Currency Code
%    Sum (IN MINIMAL UNITS!!!)
%    Date on which to calculate
%    Type 0 - GetQ(Equivalent)  1- GetN(Nominal)
%
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%*/
FUNCTION p_icurval ( iCur          NUMBER,
                     iSum          NUMBER,
                     dDesiredDate  DATE,
                     iType         NUMBER DEFAULT 0,
                     iDefaultValue NUMBER DEFAULT 1,    -- not used
                     iUseFuture    NUMBER DEFAULT 0,    -- not used
                     iCheck4Errors NUMBER DEFAULT 0     -- not used
                    )

RETURN NUMBER IS         -- ToBeDone: Value, Date, Status

 fVal     NUMBER;
 dDate    DATE;

 digs_    NUMBER;

 ern         CONSTANT POSITIVE := 207;
 err         EXCEPTION;
 erm         VARCHAR2(80);

BEGIN

  IF iCur = gl.baseval OR iSum = 0 THEN
     RETURN iSum;
  END IF;

-- Get Digs for currencies
  BEGIN
     digs_:=Dig(gl.baseval)-Dig(iCur);
  EXCEPTION
     WHEN OTHERS THEN

     FOR x IN (SELECT NVL(dig,2) dig,kv FROM tabval)
     LOOP
        Dig(x.kv):=x.dig;
     END LOOP;

     BEGIN
        digs_:=Dig(gl.baseval)-Dig(iCur);
     EXCEPTION
        WHEN OTHERS THEN
           bars_audit.error('gl.p_icurval (exception)' || chr(10) ||
                           'iCur          : ' || iCur          || chr(10) ||
                           'iSum          : ' || iSum          || chr(10) ||
                           'dDesiredDate  : ' || dDesiredDate  || chr(10) ||
                           'iType         : ' || iType         || chr(10) ||
                           'iDefaultValue : ' || iDefaultValue || chr(10) ||
                           'iUseFuture    : ' || iUseFuture    || chr(10) ||
                           'iCheck4Errors : ' || iCheck4Errors || chr(10) ||
                            sqlerrm || chr(10) ||
                            dbms_utility.format_error_backtrace() || chr(10) ||
                            dbms_utility.format_call_stack());

           erm := '9313 - No currency defined #('||
                  TO_CHAR(gl.baseval)||'/'||TO_CHAR(iCur)||')';
        RAISE err;
     END;
  END;

--

  fVal := rato(iCur,dDesiredDate);

  IF fVal = 0 THEN
     erm := '9314 - Zero rate was set for currency #('||iCur||'@'||dDesiredDate||')';
     RAISE err;
  END IF;

  IF iType = 0 THEN            -- p_icurval;
     fVal := ROUND(fVal*iSum*POWER(10,digs_));
     IF fVal =  0 THEN
        RETURN SIGN(iSum);
     ELSE
        RETURN fVal;
     END IF;
  ELSE                         -- p_ncurval
     RETURN ROUND(iSum/(fVal*POWER(10,digs_)));
  END IF;

EXCEPTION
  WHEN err THEN
    raise_application_error(-(20000+ern),chr(92)||erm,TRUE);
END p_icurval;

/*%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
%
% FUNCTION  : p_Ncurval
% DESCRIPTION : This function calculates nominal of given SUM in
%               given CURRENCY', on given DATE.
% PARAMETERS:
%
%    Currency Code
%    Sum (IN MINIMAL UNITS!!!)
%    Date on which to calculate
%
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%*/
FUNCTION p_Ncurval ( iCur  NUMBER,
                     iSum  NUMBER,
                     dDesiredDate  DATE,
                     iType         NUMBER DEFAULT 0, -- not used
                     iDefaultValue NUMBER DEFAULT 1, -- not used
                     iUseFuture    NUMBER DEFAULT 0, -- not used
                     iCheck4Errors NUMBER DEFAULT 0  -- not used
                    )

RETURN NUMBER IS         -- ToBeDone: Value, Date, Status

BEGIN
  RETURN p_icurval(iCur,iSum,dDesiredDate,1);
END p_Ncurval;

/*%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
%
% PROCEDURE  : pl_dat
% DESCRIPTION : Esteblishing local Banking Day
%
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%*/
procedure PL_DAT
( dat_           in     date
) is
  l_bnk_dt_st    fdat.stat%type;
begin

  if ( dat_ < gl.gbDATE )
  then

    begin
      select STAT
        into l_bnk_dt_st
        from FDAT
       where FDAT = dat_;
    exception
      when NO_DATA_FOUND then
        raise_application_error( -20666, 'Банківська дата ' || to_char(dat_,'dd/mm/yyyy') || ' ще не відкрита!', true );
    end;

    if ( l_bnk_dt_st = 9 )
    then
      raise_application_error( -20666, 'Банківська дата ' || to_char(dat_,'dd/mm/yyyy') || ' закрита для входу!', true );
    else -- 0 or null
      if ( TMS_UTL.CHECK_ACCESS( gl.aMFO ) = 0 )
      then
        raise_application_error( -20666, 'Філіалу '||gl.aMFO||' заборонено вхід в минулу банківську дату!', true );
      end if;
    end if;

  end if;

  SET_BANK_DATE( dat_ );

end PL_DAT;

/*%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
%
% FUNCTION  : bd
% DESCRIPTION : Returns current business (local) date
%
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%*/

FUNCTION bd RETURN DATE
IS
BEGIN
  RETURN gl.bDATE;
END bd;

/*%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
%
% FUNCTION  : gbd
% DESCRIPTION : Returns current business (global) date
%
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%*/

FUNCTION gbd RETURN DATE
IS
BEGIN
  return GL.gbDATE;
END gbd;

/*%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
%
% FUNCTION  : bd
% DESCRIPTION : Returns current branch code
%
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%*/

FUNCTION kf RETURN VARCHAR2
IS
BEGIN
  return GL.aMFO;
END kf;

/*%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
%
% FUNCTION  : USR_ID
% DESCRIPTION : Returns current user id
%
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%*/

function USR_ID return number
is
begin
  return GL.aUID;
end USR_ID;

/*%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
%
% FUNCTION  : Anonymous block
% DESCRIPTION : Provides first initialisation for global variables
%
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%*/

BEGIN
  param;
END gl;
/

show err;

exec sys.utl_recomp.recomp_serial('BARS');

grant EXECUTE on GL to ABS_ADMIN;
grant EXECUTE on GL to BARSAQ with grant option;
grant EXECUTE on GL to BARSAQ_ADM with grant option;
grant EXECUTE on GL to BARSDWH_ACCESS_USER;
grant EXECUTE on GL to BARSUPL;
grant EXECUTE on GL to BARS_ACCESS_DEFROLE;
grant EXECUTE on GL to BARS_DM;
grant EXECUTE on GL to FINMON;
grant EXECUTE on GL to INSPECTOR;
grant EXECUTE on GL to PYOD001;
grant EXECUTE on GL to RCC_DEAL;
grant EXECUTE on GL to RPBN001;
grant EXECUTE on GL to START1;
grant EXECUTE on GL to SWTOSS;
grant EXECUTE on GL to TASK_LIST;
grant EXECUTE on GL to TOSS;
grant EXECUTE on GL to WR_ACRINT;
grant EXECUTE on GL to WR_ALL_RIGHTS;
grant EXECUTE on GL to WR_CREDIT;
grant EXECUTE on GL to WR_DEPOSIT_U;
grant EXECUTE on GL to WR_DOCHAND;
grant EXECUTE on GL to WR_DOC_INPUT;
grant EXECUTE on GL to WR_IMPEXP;
