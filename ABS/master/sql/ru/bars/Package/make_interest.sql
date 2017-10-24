
 
 PROMPT ===================================================================================== 
 PROMPT *** Run *** ========== Scripts /Sql/BARS/package/make_interest.sql =========*** Run *
 PROMPT ===================================================================================== 
 
  CREATE OR REPLACE PACKAGE BARS.MAKE_INTEREST 
is
  g_header_version  constant varchar2(64)  := 'version 1.01 13.05.2015';
  g_header_awk_defs constant varchar2(512) := '';

  g_use_tax_inc     constant boolean            := true;    -- утримання податку на прибуток з ФО (з суми нарахованих %% по депозиту)
  g_use_tax_mil     constant boolean            := true;    -- утримання військового збору з ФО   (з суми нарахованих %% по депозиту)
  g_nbs_tax_pay     constant  accounts.nbs%type := '3622';  -- бал.рах. утримання  податку з ФО (з суми нарахованих %% по депозиту)
  g_nbs_tax_ret     constant  accounts.nbs%type := '3522';  -- бал.рах. повернення податку з ФО (з суми нарахованих %% по депозиту)

  --
  -- types
  --
  type r_tax_nls_type is record ( acc_id   accounts.acc%type,
                                  acc_num  accounts.nls%type );

  --
  -- Службові функції (версія пакету)
  --
  function header_version return varchar2;
  function body_version   return varchar2;

  --
  -- Повертає ставку податку на вказану дату
  --
  function GET_TAX_RATE
  ( p_tax_date  in  tax_settings.dat_begin%type,
    p_tax_type  in  tax_settings.tax_type%type
$if dbms_db_version.version >= 11
$then
  ) return          tax_settings.tax_int%type
  RESULT_CACHE;
$else
  ) return          tax_settings.tax_int%type;
$end

  --
  -- Повертає рахунок для утримання / повернення податку
  --
  function GET_TAX_ACCOUNT
  ( p_tax_type   in   tax_settings.tax_type%type, -- Тип податку: 1 - податок на прибуток з ФО, 2 - військовий збір з ФО
    p_nls_type   in   dk.dk%type,                 -- Тип рахунка: 0 - для повернення податку, 1 - для сплати податку
    p_branch     in   branch.branch%type          -- Код філії рахунка
$if dbms_db_version.version >= 11
$then
  ) return            r_tax_nls_type
    RESULT_CACHE;
$else
  ) return            r_tax_nls_type;
$end

end MAKE_INTEREST;
/
CREATE OR REPLACE PACKAGE BODY BARS.MAKE_INTEREST 
is
  --
  -- constants
  --
  g_body_version             constant varchar2(64)  := 'version 1.01 13.05.2015';
  g_body_awk_defs            constant varchar2(512) := '';

  --
  -- types
  --
  type t_tax_nls_list is table of r_tax_nls_type
                         index by accounts.branch%type;

  type r_tax_settings is record ( tax_rate       number(6,3),                         -- ставка податку
                                  date_begin     tax_settings.dat_begin%type,         -- дата початку оподаткування (включно)
                                  date_end       tax_settings.dat_end%type,           -- дата завершення оподаткування (включно)
                                  ob22_tax_pay   tax_settings.tax_ob22_3622%type,     -- ОБ22 для рах. сплати утриманого податку (бал.3622)
                                  ob22_tax_ret   tax_settings.tax_ob22_3522%type );   -- ОБ22 для рах. повернення утриманого податку (бал.3522)
  type t_tax_settings is table of r_tax_settings;

  --
  -- variables
  --
  l_mfo                      varchar2(6);
  l_baseval                  number(3);  -- tabval$global%type;
  G_TAX_NLS_LIST_INCOME      t_tax_nls_list;
  G_TAX_NLS_LIST_MILITARY    t_tax_nls_list;

  G_TAX_RATE_LIST_INCOME     t_tax_settings;
  G_TAX_RATE_LIST_MILITARY   t_tax_settings;

  --
  -- повертає версію заголовка пакета FGV
  --
  function header_version
    return varchar2
  is
  begin
    return 'Package MAKE_INT header '||g_header_version||'.'||chr(10)||
           'AWK definition: '||chr(10)||g_header_awk_defs;
  end header_version;

  --
  -- повертає версію тіла пакета
  --
  function body_version
    return varchar2
  is
  begin
    return 'Package MAKE_INT body '  ||g_body_version||'.'||chr(10)||
           'AWK definition: '||chr(10)||g_body_awk_defs;
  end body_version;

  --
  -- Повертає ставку податку на вказану дату
  --
  function GET_TAX_RATE
  ( p_tax_date   in   tax_settings.dat_begin%type,
    p_tax_type   in   tax_settings.tax_type%type
  ) return            tax_settings.tax_int%type
$if dbms_db_version.version >= 11
$then
    RESULT_CACHE RELIES_ON( TAX_SETTINGS )
$end
  is
    c_title  constant varchar2(60) := 'make_interest.get_tax_rate';
    l_rate            tax_settings.tax_int%type;
  begin

    bars_audit.trace( '%s: entry.', c_title );

    begin
      SELECT tax_int
        into l_rate
        FROM BARS.TAX_SETTINGS
       WHERE tax_type   = p_tax_type
         and dat_begin <= p_tax_date
         and (dat_end  >= p_tax_date or dat_end is null);
    exception
      when NO_DATA_FOUND then
        l_rate := 0;
    end;

    return l_rate;

  end GET_TAX_RATE;

  --
  -- Повертає рахунок для утримання / повернення податку
  --
  function GET_TAX_ACCOUNT
  ( p_tax_type   in   tax_settings.tax_type%type, -- Тип податку: 1 - податок на прибуток з ФО, 2 - військовий збір з ФО
    p_nls_type   in   dk.dk%type,                 -- Тип рахунка: 0 - для повернення податку, 1 - для сплати податку
    p_branch     in   branch.branch%type          -- Код філії рахунка
  ) return            r_tax_nls_type
$if dbms_db_version.version >= 11
$then
    RESULT_CACHE RELIES_ON( TAX_SETTINGS )
$end
  is
    c_title  constant varchar2(60) := 'make_interest.get_tax_account';
    l_result          dpt_web.acc_rec;
    l_nbs             accounts.nbs%type;
  begin

    case p_nls_type
      when 0 then l_nbs := g_nbs_tax_ret;
      when 1 then l_nbs := g_nbs_tax_pay;
      else raise_application_error( -20666, 'Не допустиме значення параметру p_nls_type (лише 0 або 1)!', TRUE );
    end case;

    case p_tax_type
      when 1 then
        return G_TAX_NLS_LIST_INCOME(p_branch);
      when 2 then
        return G_TAX_NLS_LIST_MILITARY(p_branch);
      else
        return null;
        -- raise_application_error( -20666, 'Не допустиме значення параметру p_tax_type (лише 1 або 2)!', TRUE );
    end case;

  exception
    when NO_DATA_FOUND then
      if ( length(p_branch) > 8 )
      then
        return GET_TAX_ACCOUNT( p_tax_type, p_nls_type, SubStr(p_branch, 1, length(p_branch)-7) );
      else
        raise_application_error( -20666, 'Не знайдено рахунок для ' ||
                                         case p_nls_type when 0 then 'повернення ' else 'сплати ' end ||
                                         case p_tax_type when 1 then 'податоку на прибуток з ФО' else 'військового збору з ФО' end, TRUE );
      end if;
  end GET_TAX_ACCOUNT;

  --
  -- Ініціалізація масиву рахунків для сплати податку
  --
  procedure INIT_TAX_NLS_LIST
  is
    c_title          constant  varchar2(60)       := 'make_interest.init_tax_nls_list';
    -- замінити c_ob22_inc_pay на G_TAX_RATE_LIST_INCOME.ob22_tax_inc_pay
    -- замінити c_ob22_mil_pay на G_TAX_RATE_LIST_INCOME.ob22_tax_mil_ret
    c_ob22_inc_pay   constant  accounts.ob22%type := '37';
    c_ob22_mil_pay   constant  accounts.ob22%type := '36';
    ---
  begin

    bars_audit.trace( '%s: entry.', c_title );

    -- fill NLS_LIST for TAX INCOME
    for k in ( with tab as ( select ACC, NLS, BRANCH
                               from BARS.ACCOUNTS
                              where nbs  = g_nbs_tax_pay
                                and kv   = l_baseval
                                and ob22 = c_ob22_inc_pay
                                and dazs is null )
             select acc, nls, branch
               from tab
              union
             select acc, nls, SubStr(branch, 1,15)
               from tab
              where branch like '/______/______/06____/' )
    loop

      G_TAX_NLS_LIST_INCOME(k.branch).acc_id  := k.acc;
      G_TAX_NLS_LIST_INCOME(k.branch).acc_num := k.nls;

    end loop;

    bars_audit.trace( '%s INIT_TAX_NLS_LIST(INCOME): exit with %s rows in G_TAX_NLS_LIST_INCOME.', c_title, to_char(G_TAX_NLS_LIST_INCOME.COUNT) );

    -- fill NLS_LIST for TAX_MILITARY
    for k in ( with tab as ( select ACC, NLS, BRANCH
                               from BARS.ACCOUNTS
                              where nbs  = g_nbs_tax_pay
                                and kv   = l_baseval
                                and ob22 = c_ob22_mil_pay
                                and dazs is null )
             select acc, nls, branch
               from tab
              union
             select acc, nls, SubStr(branch, 1,15)
               from tab
              where branch like '/______/______/06____/' )
    loop

      G_TAX_NLS_LIST_MILITARY(k.branch).acc_id  := k.acc;
      G_TAX_NLS_LIST_MILITARY(k.branch).acc_num := k.nls;

    end loop;

    bars_audit.trace( '%s INIT_TAX_NLS_LIST(MILITARY): exit with %s accounts.', c_title, to_char(G_TAX_NLS_LIST_MILITARY.COUNT) );

  end INIT_TAX_NLS_LIST;

  --
  -- Ініціалізація масиву періодів та ставок оподаткування
  --
  procedure INIT_TAX_RATE_LIST
  is
    c_title  constant varchar2(60) := 'make_interest.init_tax_rate_list';
  begin

    bars_audit.trace( '%s: entry.', c_title );

    -- податк на прибуток з ФО
    begin
      SELECT tax_int, dat_begin, dat_end,
             tax_ob22_3622, tax_ob22_3522
        BULK COLLECT
        INTO G_TAX_RATE_LIST_INCOME
        FROM BARS.TAX_SETTINGS
       WHERE tax_type = 1;
    exception
      when NO_DATA_FOUND then
        G_TAX_RATE_LIST_INCOME(1).tax_rate   := 0;
        G_TAX_RATE_LIST_INCOME(1).date_begin := to_date('01/01/2000','dd/mm/yyyy');
        G_TAX_RATE_LIST_INCOME(1).date_end   := to_date('01/01/2999','dd/mm/yyyy');
    end;

    begin
      -- військовий збір з ФО
      SELECT tax_int, dat_begin, dat_end,
             tax_ob22_3622, tax_ob22_3522
        BULK COLLECT
        INTO G_TAX_RATE_LIST_MILITARY
        FROM BARS.TAX_SETTINGS
       WHERE tax_type = 2;
    exception
      when NO_DATA_FOUND then
        G_TAX_RATE_LIST_MILITARY(1).tax_rate   := 0;
        G_TAX_RATE_LIST_MILITARY(1).date_begin := to_date('01/01/2000','dd/mm/yyyy');
        G_TAX_RATE_LIST_MILITARY(1).date_end   := to_date('01/01/2999','dd/mm/yyyy');
    end;

  end INIT_TAX_RATE_LIST;

  --
  --
  --
  procedure ACCRUAL_INTEREST
  is
    c_title  constant varchar2(60) := 'make_interest.accrual_interest';
  begin
    bars_audit.trace( '%s: entry.', c_title );
  end ACCRUAL_INTEREST;

  --
  --
  --
  procedure ACCRUAL_INTEREST_PARALLEL
  is
    c_title  constant varchar2(60) := 'make_interest.accrual_interest_parallel';
  begin
    bars_audit.trace( '%s: entry.', c_title );
  end ACCRUAL_INTEREST_PARALLEL;

BEGIN

  l_mfo     := gl.amfo;
  l_baseval := gl.baseval;

  -- ініціалізація списку рахунків для сплати податку
  INIT_TAX_NLS_LIST;

  -- ініціалізація масиву періодів та ставок оподаткування
  -- INIT_TAX_RATE_LIST;

end MAKE_INTEREST;
/
 show err;
 
 
 
 PROMPT ===================================================================================== 
 PROMPT *** End *** ========== Scripts /Sql/BARS/package/make_interest.sql =========*** End *
 PROMPT ===================================================================================== 
 