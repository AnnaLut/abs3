
 
 PROMPT ===================================================================================== 
 PROMPT *** Run *** ========== Scripts /Sql/BARS/package/bars_sqnc.sql =========*** Run *** =
 PROMPT ===================================================================================== 
 
  CREATE OR REPLACE PACKAGE BARS.BARS_SQNC is

  -- Copyryight : UNITY-BARS
  -- Author     : SERG
  -- Created    : 06/08/2012
  -- Purpose    : Вспомагательные функции для работы с последовательностями

    -- SRU - последовательности в разрезе RU: <SEQUENCE>||<RU>, RU=01,02,...37

  -- global consts
  G_HEADER_VERSION constant varchar2(64)  := 'version 1.00 06/08/2012';

  ----
  -- header_version - возвращает версию заголовка пакета
  --
  function header_version return varchar2;

  ----
  -- body_version - возвращает версию тела пакета
  --
  function body_version return varchar2;

  ----
  -- get_kf - код МФО по коду РУ
  --
  function get_kf(p_ru in varchar2) return varchar2 result_cache;

  ----
  -- get_ru - код РУ по коду МФО
  --
  function get_ru(p_kf in varchar2) return varchar2 result_cache;

  ----
  -- get_currval - возвращает текущее значение последовательности p_sqnc
  --
  function get_currval(
      p_sqnc in varchar2,
      p_kf in varchar2 default gl.aMFO)
  return number;

  ----
  -- get_nextval - возвращает следующее значение последовательности p_sqnc
  --
  function get_nextval(
      p_sqnc in varchar2,
      p_kf in varchar2 default gl.aMFO)
  return number;

  ----
  -- ru - возвращает суффикс <RU>
  --
  function ru(p_kf in varchar2 default gl.aMFO) return varchar2;

  ----
  -- rukey - возвращает ключ с суффиксом <RU>
  --
  function rukey(
      p_key in varchar2,
      p_kf in varchar2 default gl.aMFO)
  return varchar2;

  procedure split_key(
      p_key in varchar2,
      p_old_key out varchar2,
      p_kf out varchar2);
end bars_sqnc;
/
CREATE OR REPLACE PACKAGE BODY BARS.BARS_SQNC is

    -- Copyryight : UNITY-BARS
    -- Author     : SERG
    -- Created    : 06/08/2012
    -- Purpose    : Вспомагательные функции для работы с последовательностями
    -----------------------------------------------------------------------------------
    -- Edited     : 18/04/2016 Artem Yurchenko - добавил функцию получения старого ключа из нового,
    --            : добавил функции получения МФО по РУ и наоборот.
    --            : В функции добавил параметр p_kf, позволяющий работать с идентификаторами разных МФО -
    --            : по умолчанию, p_kf равен текущему филиалу пользователя

    -- SRU - последовательности в разрезе RU: <SEQUENCE>||<RU>, RU=01,02,...37

    g_kf    varchar2(6); -- код филиала(МФО)
    g_ru    varchar2(2); -- код учреждения

    -- global consts
    G_BODY_VERSION constant varchar2(64)  := 'version 1.01 18/04/2016';

    G_PKG constant varchar2(30) := 'bars_sqnc';


    ----
    -- header_version - возвращает версию заголовка пакета
    --
    function header_version return varchar2 is
    begin
      return 'Package header '||G_PKG||' '||G_HEADER_VERSION;
    end header_version;

    ----
    -- body_version - возвращает версию тела пакета
    --
    function body_version return varchar2 is
    begin
      return 'Package body '||G_PKG||' '||G_BODY_VERSION;
    end body_version;

    ----
    -- get_kf - код МФО по коду РУ
    --
    function get_kf(
        p_ru in varchar2)
    return varchar2
    result_cache relies_on (kf_ru)
    is
        l_kf varchar2(6 char);
    begin
        if (p_ru = '00') then
            return null;
        end if;

        select kf
        into   l_kf
        from   kf_ru
        where  ru = p_ru;

        return l_kf;
    exception
        when no_data_found then
             raise_application_error(-20000, 'Код МФО, що відповідає коду РУ {' || p_ru || '}, не знайдений');
    end;

    ----
    -- get_ru - код РУ по коду МФО
    --
    function get_ru(
        p_kf in varchar2)
    return varchar2
    result_cache relies_on (kf_ru)
    is
        l_ru varchar2(6 char);
    begin
        if (p_kf is null) then
            return '00';
        end if;

        select ru
        into   l_ru
        from   kf_ru
        where  kf = p_kf;

        return l_ru;
    exception
        when no_data_found then
             raise_application_error(-20000, 'Код РУ, що відповідає коду МФО {' || p_kf || '}, не знайдений');
    end;

    ----
    -- iload - инициализация внутренних переменных
    --
    procedure iload
    is
    begin
        if (g_kf = gl.aMFO) then
            return;
        end if;

        g_kf := gl.aMFO;
        g_ru := get_ru(g_kf);
    end;

    ----
    -- ru - возвращает суффикс <RU>
    --
    function ru(
        p_kf in varchar2 default gl.aMFO)
    return varchar2
    is
    begin
        if (p_kf = g_kf) then
            return g_ru;
        else
            return get_ru(p_kf);
        end if;
    end ru;

    ----
    -- rukey - возвращает ключ с суффиксом <RU>
    --
    function rukey(
        p_key in varchar2,
        p_kf in varchar2 default gl.aMFO)
    return varchar2
    is
    begin
        if (p_key is null) then
            return null;
        end if;

        return p_key;
        -- return p_key || ru(p_kf);
    end;

    ----
    -- oldey - расщепляет новый ключ на составляющие: старый ключ и код МФО, в котором данный идентификатор был зарегистрирован
    --
    procedure split_key(
        p_key in varchar2,
        p_old_key out varchar2,
        p_kf out varchar2)
    is
    begin
        p_old_key := p_key;
        p_kf := gl.aMFO;
/*
        p_old_key := substr(p_key, 1, length(p_key) - 2);
        p_kf := get_kf(substr(p_key, -2, 2));
*/
    end;

    ----
    -- get_currval - возвращает текущее значение последовательности p_sqnc
    --
    function get_currval(
        p_sqnc in varchar2,
        p_kf in varchar2 default gl.aMFO)
    return number
    is
        l_sqnc number;
        l_stmt varchar2(200);
    begin
        l_stmt := 'select ' || p_sqnc || '.currval from dual';
        execute immediate l_stmt into l_sqnc;
        return rukey(l_sqnc, p_kf);
    end get_currval;

    ----
    -- get_nextval - возвращает следующее значение последовательности p_sqnc
    --
    function get_nextval(
        p_sqnc in varchar2,
        p_kf in varchar2 default gl.aMFO)
    return number
    is
        l_sqnc number;
        l_stmt varchar2(200);
    begin
        l_stmt := 'select ' || p_sqnc || '.nextval from dual';
        execute immediate l_stmt into l_sqnc;
        return rukey(l_sqnc, p_kf);
    end get_nextval;

begin
    iload();
end bars_sqnc;
/
 show err;
 
PROMPT *** Create  grants  BARS_SQNC ***
grant EXECUTE                                                                on BARS_SQNC       to BARS_ACCESS_DEFROLE;
grant EXECUTE                                                                on BARS_SQNC       to SBON;
grant EXECUTE                                                                on BARS_SQNC       to START1;

 
 
 PROMPT ===================================================================================== 
 PROMPT *** End *** ========== Scripts /Sql/BARS/package/bars_sqnc.sql =========*** End *** =
 PROMPT ===================================================================================== 
 