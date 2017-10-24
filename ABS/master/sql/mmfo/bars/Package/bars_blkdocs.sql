
 
 PROMPT ===================================================================================== 
 PROMPT *** Run *** ========== Scripts /Sql/BARS/package/bars_blkdocs.sql =========*** Run **
 PROMPT ===================================================================================== 
 
  CREATE OR REPLACE PACKAGE BARS.BARS_BLKDOCS is

  -------------------------------------------------
  -- Module  : WEB
  -- Author  : Oleg
  -- Purpose : Разблокирование и сторнирование документов, блокированных при оплате
  --
  -- Change log:
  --
  --  22.05.2007 Oleg  Создание
  --

  -----
  -- header_version - возвращает версию заголова пакета
  --
  function header_version return varchar2;

  -----
  -- body_version - возвращает версию тела пакета
  --
  function body_version return varchar2;

  -----
  -- unblock - разблокирует блокированный документ
  -- @p_ref - референс документа
  procedure unblock(p_ref in number);

  -----
  -- back_doc - сторнирует документ
  -- @p_ref - референс документа
  procedure back_doc(p_ref in number);

end bars_blkdocs;
 
/
CREATE OR REPLACE PACKAGE BODY BARS.BARS_BLKDOCS is

  g_header_version varchar2(30) := 'header version 1.0 22/05/2007';
  g_body_version varchar2(30) := 'body version 1.0 22/05/2007';
  g_module_name varchar2(3) := 'BRS';

  -----
  -- header_version - возвращает версию заголова пакета
  --
  function header_version return varchar2 is
  begin
    return g_header_version;
  end;

  -----
  -- body_version - возвращает версию тела пакета
  --
  function body_version return varchar2 is
  begin
    return g_body_version;
  end;

  -----
  -- unblock - разблокирует блокированный документ
  -- @p_ref - референс документа
  procedure unblock(p_ref in number) is
  begin
    bars_audit.trace('bars_blkdocs.unblock entry point, ref='||p_ref);
    update oper set otm=0 where ref=p_ref and otm=-1;
    if sql%rowcount=0 then
      -- документ не найден
      bars_error.raise_error(g_module_name, 18005, to_char(p_ref));
    end if;
    bars_audit.financial('Документы блокированные при оплате: пользоваетль '||user||' (user_id='||user_id||') разблокировал документ с ref='||p_ref);
    bars_audit.trace('bars_blkdocs.unblock complete, ref='||p_ref);
  end;

  -----
  -- back_doc - сторнирует документ
  -- @p_ref - референс документа
  procedure back_doc(p_ref in number) is
  begin
    bars_audit.trace('bars_blkdocs.back_doc entry point, ref='||p_ref);
    update oper set otm=-2 where ref=p_ref and otm=-1;
    if sql%rowcount=0 then
      -- документ не найден
      bars_error.raise_error(g_module_name, 18005, to_char(p_ref));
    end if;
    ful_bak(p_ref);
    bars_audit.financial('Документы блокированные при оплате: пользоваетль '||user||' (user_id='||user_id||') сторнировал документ с ref='||p_ref);
    bars_audit.trace('bars_blkdocs.back_doc complete, ref='||p_ref);
  end;

end bars_blkdocs;
/
 show err;
 
PROMPT *** Create  grants  BARS_BLKDOCS ***
grant EXECUTE                                                                on BARS_BLKDOCS    to WR_ALL_RIGHTS;
grant EXECUTE                                                                on BARS_BLKDOCS    to WR_BLKDOCS;

 
 
 PROMPT ===================================================================================== 
 PROMPT *** End *** ========== Scripts /Sql/BARS/package/bars_blkdocs.sql =========*** End **
 PROMPT ===================================================================================== 
 