
 
 PROMPT ===================================================================================== 
 PROMPT *** Run *** ========== Scripts /Sql/BARS/package/bars_blkdocs.sql =========*** Run **
 PROMPT ===================================================================================== 
 
  CREATE OR REPLACE PACKAGE BARS.BARS_BLKDOCS is

  -------------------------------------------------
  -- Module  : WEB
  -- Author  : Oleg
  -- Purpose : ��������������� � ������������� ����������, ������������� ��� ������
  --
  -- Change log:
  --
  --  22.05.2007 Oleg  ��������
  --

  -----
  -- header_version - ���������� ������ �������� ������
  --
  function header_version return varchar2;

  -----
  -- body_version - ���������� ������ ���� ������
  --
  function body_version return varchar2;

  -----
  -- unblock - ������������ ������������� ��������
  -- @p_ref - �������� ���������
  procedure unblock(p_ref in number);

  -----
  -- back_doc - ���������� ��������
  -- @p_ref - �������� ���������
  procedure back_doc(p_ref in number);

end bars_blkdocs;
 
/
CREATE OR REPLACE PACKAGE BODY BARS.BARS_BLKDOCS is

  g_header_version varchar2(30) := 'header version 1.0 22/05/2007';
  g_body_version varchar2(30) := 'body version 1.0 22/05/2007';
  g_module_name varchar2(3) := 'BRS';

  -----
  -- header_version - ���������� ������ �������� ������
  --
  function header_version return varchar2 is
  begin
    return g_header_version;
  end;

  -----
  -- body_version - ���������� ������ ���� ������
  --
  function body_version return varchar2 is
  begin
    return g_body_version;
  end;

  -----
  -- unblock - ������������ ������������� ��������
  -- @p_ref - �������� ���������
  procedure unblock(p_ref in number) is
  begin
    bars_audit.trace('bars_blkdocs.unblock entry point, ref='||p_ref);
    update oper set otm=0 where ref=p_ref and otm=-1;
    if sql%rowcount=0 then
      -- �������� �� ������
      bars_error.raise_error(g_module_name, 18005, to_char(p_ref));
    end if;
    bars_audit.financial('��������� ������������� ��� ������: ������������ '||user||' (user_id='||user_id||') ������������� �������� � ref='||p_ref);
    bars_audit.trace('bars_blkdocs.unblock complete, ref='||p_ref);
  end;

  -----
  -- back_doc - ���������� ��������
  -- @p_ref - �������� ���������
  procedure back_doc(p_ref in number) is
  begin
    bars_audit.trace('bars_blkdocs.back_doc entry point, ref='||p_ref);
    update oper set otm=-2 where ref=p_ref and otm=-1;
    if sql%rowcount=0 then
      -- �������� �� ������
      bars_error.raise_error(g_module_name, 18005, to_char(p_ref));
    end if;
    ful_bak(p_ref);
    bars_audit.financial('��������� ������������� ��� ������: ������������ '||user||' (user_id='||user_id||') ����������� �������� � ref='||p_ref);
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
 