
 
 PROMPT ===================================================================================== 
 PROMPT *** Run *** ========== Scripts /Sql/BARS/package/clim_ru_pack.sql =========*** Run **
 PROMPT ===================================================================================== 
 
  CREATE OR REPLACE PACKAGE BARS.CLIM_RU_PACK is

  -- Author  : IVAN.GALISEVYCH
  -- Created : 19.11.2014 14:59:09
  -- Purpose : Package for RU for work CLIM module

  g_header_version constant varchar2(64) := 'version 1.01 22/05/2015';

  -- header_version - возвращает версию заголовка пакета
  function header_version return varchar2;
  -- body_version - возвращает версию тела пакета
  function body_version return varchar2;

  type r_accarcinfo is record(
    acc_id      number,
    mfo         varchar2(6),
    bdate       date,
    acc_balance number);

  type t_accarcinfo is table of r_accarcinfo;

    -- ATM transaction
    type recordAtmTrans is record(
         kf             varchar2(6),
         acc_sourceid   number,
         acc_number     varchar2(15),
         acc_currency   number(3),
         s              number(24),
         fdat           date,
         ref            number);

    type tableAtmTrans is table of recordAtmTrans;

  function getaccarc(p_bdate date) return t_accarcinfo
    pipelined;

-- транзакції завантаження по АТМ з дати по поточну
function getAtmTrans (p_startdate date) return tableAtmTrans
  pipelined;

  procedure set_paramdate(p_date in date);

  function get_paramdate return date;

  function get_startdate return date;

end clim_ru_pack;
/
CREATE OR REPLACE PACKAGE BODY BARS.CLIM_RU_PACK is

  -- Версія пакету
  g_body_version constant varchar2(64) := 'version 1.01 22/05/2015';
  g_dbgcode      constant varchar2(20) := 'clim_ru_pack';

  g_paramdate date default sysdate-1;

  -- конфігураційні парамерти
  START_DATE constant date := to_date('01.06.2016', 'dd.mm.yyyy');

  -- header_version - возвращает версию заголовка пакета
  function header_version return varchar2 is
  begin
    return 'Package header ' || g_dbgcode || ' ' || g_header_version || '.';
  end header_version;
  -- body_version - возвращает версию тела пакета
  function body_version return varchar2 is
  begin
    return 'Package body ' || g_dbgcode || ' ' || g_body_version || '.';
  end body_version;

-- транзакції завантаження по АТМ з дати по поточну
function getAtmTrans (p_startdate date) return tableAtmTrans
  pipelined is

begin
  for cur in (SELECT a.KF,
               a.acc AS acc_sourceid,
               a.nls AS acc_number,
               a.kv AS acc_currency,
               o.s,
               o.fdat,
               o.ref
               FROM accounts a
                    join saldoa s ON (s.acc = a.acc)
                    JOIN opldok o ON (s.acc = o.acc AND s.fdat = o.fdat)
                 WHERE nbs LIKE '1004%' AND (dazs IS NULL OR dazs >= p_startdate)
                       and s.dos > 0
                             AND o.dk = 0
                             AND o.tt = '185'
                             AND o.sos = 5
                             AND s.fdat >= p_startdate) loop
    pipe row(cur);
  end loop;
end getAtmTrans;

  function getaccarc(p_bdate date) return t_accarcinfo
    pipelined is
    l_th constant varchar2(100) := g_dbgcode || '.getaccarc';
    l_bdate date;
  begin
    bars_audit.trace('%s: entry point p_bdate=%s', l_th, to_char(p_bdate));
    l_bdate := trunc(p_bdate);
    for cur in (SELECT a.acc acc_id,
                       a.kf mfo,
                       l_bdate as bdate,
                       fost(a.acc, l_bdate) acc_balance
                  FROM accounts a
                 WHERE nbs LIKE '100%'
                   AND (dazs IS NULL OR dazs >= l_bdate)) loop
      pipe row(cur);
    end loop;
    bars_audit.trace('%s: done', l_th);
  end getaccarc;

  procedure set_paramdate(p_date in date) is
  begin
    g_paramdate := p_date;
  end set_paramdate;

  function get_paramdate return date is
  begin
    return trunc(g_paramdate);
  end get_paramdate;

  function get_startdate return date is
  begin
    return trunc(START_DATE);
  end get_startdate;

begin
  -- Initialization
  null;
end clim_ru_pack;
/
 show err;
 
PROMPT *** Create  grants  CLIM_RU_PACK ***
grant EXECUTE                                                                on CLIM_RU_PACK    to BARS_ACCESS_DEFROLE;

 
 
 PROMPT ===================================================================================== 
 PROMPT *** End *** ========== Scripts /Sql/BARS/package/clim_ru_pack.sql =========*** End **
 PROMPT ===================================================================================== 
 