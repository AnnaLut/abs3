
 
 PROMPT ===================================================================================== 
 PROMPT *** Run *** ========== Scripts /Sql/BARSAQ/package/bars_accsync.sql =========*** Run 
 PROMPT ===================================================================================== 
 
  CREATE OR REPLACE PACKAGE BARSAQ.BARS_ACCSYNC is

  -- Copyryight : UNITY-BARS
  -- Author     : SERG
  -- Created    : 29.08.2007
  -- Purpose    : ����� �������� ��� ������������� �� ������

  -- global consts
  G_HEADER_VERSION constant varchar2(64)  := 'version 1.05 07/10/2008';

  ----
  -- header_version - ���������� ������ ��������� ������
  --
  function header_version return varchar2;

  ----
  -- body_version - ���������� ������ ���� ������
  --
  function body_version return varchar2;

  ----
  -- mark_saldoa - �������� ������ � saldoa ��� �������� �����������
  -- @param p_acc - ��� �����, ������ �� �������� ���������� ��������
  --
  procedure mark_saldoa(p_acc in number);

  ----
  -- mark_opldok - �������� ����������� �������� � opldok ��� �������� �����������
  -- @param p_acc - ��� �����, �������� �� �������� ���������� ��������
  --
  procedure mark_opldok(p_acc in number);

  ----
  -- mark_opldok - �������� ����������� �������� � opldok ��� �������� �����������
  -- @param p_nls - ����� �������� �����
  -- @param p_kv - ��� ������
  --
  procedure mark_opldok(p_nls in varchar2, p_kv in number);

  ----
  -- subscribe - ����������� ������������ p_user �� ��������� �� ����� p_acc
  --
  procedure subscribe(p_user in varchar2, p_acc in number);


  ------------------------------------
  --  SUBSCRIBE
  --
  --  ����������� ������������ p_user �� ��������� �� ����� (p_nls,p_kv, branch)
  --
  procedure subscribe(
                  p_user   in varchar2,
                  p_nls    in varchar2,
                  p_kv     in number,
                  p_branch in varchar2 default null);

  ------------------------------------
  --   SUBSCRIBE_ACC
  --
  --   ����������� ������������ p_user �� ��������� �� ����� p_acc
  --   ���������� ������� ��� Centura, �.�. ��� �� �������� ������������ �����
  --
  procedure subscribe_acc(
                  p_user in varchar2,
                  p_acc in number);



  ------------------------------------
  --  UNSUBSCRIBE
  --
  --  ������� �������� ������������ p_user �� ��������� �� ����� (p_nls,p_kv)
  --
  procedure unsubscribe(
                  p_user    in varchar2,
                  p_nls     in varchar2,
                  p_kv      in number,
                  p_branch  in varchar2 default null );


  ------------------------------------
  --  UNSUBSCRIBE
  --
  -- ������� �������� ������������ p_user �� ��������� �� ����� p_acc
  --
  procedure unsubscribe(
                  p_user in varchar2,
                  p_acc in number);


  ------------------------------------
  --   UNSUBSCRIBE_ACC
  --
  --   ������� �������� ������������ p_user �� ��������� �� ����� p_acc
  --   ���������� ������� ��� Centura, �.�. ��� �� �������������������� �����
  --
  procedure unsubscribe_acc(
                  p_user in varchar2,
                  p_acc  in number);


  --------------------------------------------
  --  SUBSRIBER_ACC
  --
  --  ������� ��������, �������� �� ������ ��� ������ ����������
  --
  --  @param   p_acc     - ��� �����
  --  @return  smallint  - =1-��, =0-���
  --
  function subscriber_acc(p_acc in number)  return smallint;



end bars_accsync;
/
CREATE OR REPLACE PACKAGE BODY BARSAQ.BARS_ACCSYNC is

   G_BODY_DEFS constant varchar2(512) := ''
  	||'MKF - ���������������� ������'
  ;


  -- global consts
  G_BODY_VERSION constant varchar2(64)  := 'version 2.2 08/10/2008';

  --
  -- global variables
  --
  g_mosdate         date;   -- "mark_opldok"_start_date (���� ������ ������� ������� � OPLDOK)

  ----
  -- header_version - ���������� ������ ��������� ������
  --
  function header_version return varchar2 is
  begin
    return 'Package header '||G_HEADER_VERSION;
  end header_version;

  ----
  -- body_version - ���������� ������ ���� ������
  --
  function body_version return varchar2 is
  begin
    return 'Package body '||G_BODY_VERSION||'awk: '||G_BODY_DEFS;
  end body_version;


  ----
  -- mark_saldoa - �������� ������ � saldoa ��� �������� �����������
  -- @param p_acc - ��� �����, ������ �� �������� ���������� ��������
  --
  procedure mark_saldoa(p_acc in number) is
  begin
    update bars.saldoa set ostf=ostf where acc=p_acc and fdat>=g_mosdate;
    bars.bars_audit.info('������ �� SALDOA(�������) �� ����� ACC='||p_acc||' �������� ��� �������� �����������. ���-�� = '||sql%rowcount);
  end mark_saldoa;


  ----
  -- mark_opldok - �������� ����������� �������� � opldok ��� �������� �����������
  -- @param p_acc - ��� �����, �������� �� �������� ���������� ��������
  --
  procedure mark_opldok(p_acc in number) is
  begin
    update bars.opldok set sos=sos where acc=p_acc and sos=5 and fdat>=g_mosdate;
    bars.bars_audit.info('����������� �������� �� ����� ACC='||p_acc||' �������� ��� �������� �����������. ���-�� = '||sql%rowcount);
  end mark_opldok;




  --------------------------------------------
  --  SUBSRIBER_ACC
  --
  --  ������� ��������, �������� �� ������ ��� ������ ����������
  --
  --  @param   p_acc     - ��� �����
  --  @return  smallint  - =1-��, =0-���
  --
  function subscriber_acc(p_acc in number)
  return smallint
  is
     l_acc number;
  begin
     select acc into l_acc
     from barsaq.aq_subscribers_acc where acc  = p_acc;
     return 1;
  exception when no_data_found then
     return 0;
  end;



  ----
  -- mark_opldok - �������� ����������� �������� � opldok ��� �������� �����������
  -- @param p_nls - ����� �������� �����
  -- @param p_kv - ��� ������
  --
  procedure mark_opldok(p_nls in varchar2, p_kv in number) is
    l_acc bars.accounts.acc%type;
  begin
    select acc into l_acc from bars.accounts where nls=p_nls and kv=p_kv;
	mark_opldok(l_acc);
  end mark_opldok;

  ----
  -- subscribe - ����������� ������������ p_user �� ��������� �� ����� p_acc
  --
  procedure subscribe(p_user in varchar2, p_acc in number) is
    l_user  varchar2(30);
  begin
    l_user := upper(p_user);
    insert into aq_subscribers_acc(name, acc)
    values(l_user, p_acc);
    bars.bars_audit.info('������������ '||l_user||' �������� �� ��������� �� ����� ACC='||p_acc);
  end subscribe;


  ------------------------------------
  --   SUBSCRIBE_ACC
  --
  --   ����������� ������������ p_user �� ��������� �� ����� p_acc
  --   ���������� ������� ��� Centura, �.�. ��� �� �������������������� �����
  --
  procedure subscribe_acc(p_user in varchar2, p_acc in number) is
  begin
    subscribe(p_user,p_acc);
  end;



  ------------------------------------
  --  SUBSCRIBE
  --
  --  ����������� ������������ p_user �� ��������� �� ����� (p_nls,p_kv, branch)
  --
  procedure subscribe(
                  p_user   in varchar2,
                  p_nls    in varchar2,
                  p_kv     in number,
                  p_branch in varchar2 default null)
  is
     l_user  varchar2(30);
     l_acc   bars.accounts.acc%type;
  begin

     l_user := upper(p_user);

     select acc into l_acc from bars.accounts
     where nls = p_nls and kv = p_kv and kf = bars.bars_context.extract_mfo(p_branch);
     insert into aq_subscribers_acc(name, acc)
     values(l_user, l_acc);
     bars.bars_audit.info('������������ '||l_user||' �������� �� ��������� �� ����� ACC='||l_acc||', NLS='||p_nls||', KV='||p_kv);

  end subscribe;



  ---------------------------
  --  UNSUBSCRIBE
  --
  --  ������� �������� ������������ p_user �� ��������� �� ����� p_acc
  --
  --
  procedure unsubscribe(
                   p_user in varchar2,
                   p_acc  in number   ) is
    l_user  varchar2(30);
  begin
    l_user := upper(p_user);
    delete from aq_subscribers_acc where name=l_user and acc=p_acc;
    bars.bars_audit.info('������� �������� ������������ '||l_user||' �� ��������� �� ����� ACC='||p_acc);
  end unsubscribe;


  ------------------------------------
  --   UNSUBSCRIBE_ACC
  --
  --   ������� �������� ������������ p_user �� ��������� �� ����� p_acc
  --   ���������� ������� ��� Centura, �.�. ��� �� �������������������� �����
  --
  procedure unsubscribe_acc(
                  p_user in varchar2,
                  p_acc  in number) is
  begin
     unsubscribe(p_user,p_acc);
  end;



  ------------------------------
  --  UNSUBSCRIBE
  --
  --  ������� �������� ������������ p_user �� ��������� �� ����� (p_nls,p_kv)
  --
  procedure unsubscribe(
                  p_user    in varchar2,
                  p_nls     in varchar2,
                  p_kv      in number,
                  p_branch  in varchar2 default null ) is
    l_user  varchar2(30);
    l_acc   bars.accounts.acc%type;
  begin
    l_user := upper(p_user);

    select acc into l_acc from bars.accounts
     where nls = p_nls and kv = p_kv and kf = bars.bars_context.extract_mfo(p_branch);

    delete from aq_subscribers_acc where name=l_user and acc=l_acc;
    bars.bars_audit.info('������� �������� ������������ '||l_user||' �� ��������� �� ����� ACC='||l_acc||', NLS='||p_nls||', KV='||p_kv);
  end unsubscribe;

  ----
  -- init - ������������� ������
  --
  procedure init is
  begin
    begin
      select to_date(val,'DD.MM.YYYY') into g_mosdate from bars.params where par='MOSDATE';
    exception when no_data_found then
      g_mosdate := to_date('01.01.2008','DD.MM.YYYY');
    end;
  end init;

begin
  -- Initialization
  init;
end bars_accsync;
/
 show err;
 
 
 
 PROMPT ===================================================================================== 
 PROMPT *** End *** ========== Scripts /Sql/BARSAQ/package/bars_accsync.sql =========*** End 
 PROMPT ===================================================================================== 
 