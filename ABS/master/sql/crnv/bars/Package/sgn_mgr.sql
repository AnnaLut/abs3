create or replace package bars.sgn_mgr is
  --------------------------------------------------------------------------------
  --  Author : andriy.sukhov, sergey.gorobets 
  --  Created : 05.08.2016 18:08:02
  --  Purpose: ����� ��� ������ � ������������� (���)
  --------------------------------------------------------------------------------

  g_header_version constant varchar2(64) := 'version 1.0 05/08/2016';
  g_trace_module  varchar2(20) := 'sgn_mgr.';
  g_trace_enabled number(1) := 0;

  -- Public constant declarations
  -- ��� ���� ��� VEGA1
  g_sign_type_vega1 constant varchar2(3) := 'VEG';
  -- ��� ���� ��� VEGA2
  g_sign_type_vega2 constant varchar2(3) := 'VG2';

  --------------------------------------------------------------------------------
  -- header_version - ���������� ������ ��������� ������
  --
  function header_version return varchar2;

  --------------------------------------------------------------------------------
  -- body_version - ���������� ������ ���� ������
  --
  function body_version return varchar2;

  --------------------------------------------------------------------------------
  -- set_sign_data - �������� ������� � ���������
  --
  function set_sign_data(p_sign_type in sgn_data.sign_type%type, -- ��� ���
                         p_key_id    in sgn_data.key_id%type, -- ������������� �����
                         p_sign_hex  in sgn_data.sign_hex%type -- ������� � HEX �������
                         ) return sgn_data.id%type;

  --------------------------------------------------------------------------------
  -- del_sign_data - �������� ������� �� ���������
  --
  procedure del_sign_data(p_id in sgn_data.id%type);

  --------------------------------------------------------------------------------
  -- get_sign_data - ��������� ������ � ������� �� ���������
  --
  procedure get_sign_data(p_id        in sgn_data.id%type,
                          p_sign_type out sgn_data.sign_type%type, -- ��� ���
                          p_key_id    out sgn_data.key_id%type, -- ������������� �����
                          p_sign_hex  out sgn_data.sign_hex%type -- ������� � HEX �������
                          );

  --------------------------------------------------------------------------------
  -- store_sep_sign - �������� ���-������ ������� �� ���������
  --
  procedure store_sep_sign(p_ref       oper.ref%type, -- ref ��������� �� oper 
                           p_sign_type in sgn_data.sign_type%type, -- ��� ���
                           p_key_id    in sgn_data.key_id%type, -- ������������� �����
                           p_sign_hex  in sgn_data.sign_hex%type -- ������� � HEX �������
                           );
  --------------------------------------------------------------------------------
  -- store_int_sign - �������� ���������� ������� �� ��������� (����)
  --
  procedure store_int_sign(p_ref       oper.ref%type, -- ref ��������� �� oper 
                           p_rec_id    oper_visa.sqnc%type, -- ����� ������ �� oper_visa
                           p_sign_type in sgn_data.sign_type%type, -- ��� ���
                           p_key_id    in sgn_data.key_id%type, -- ������������� �����
                           p_sign_hex  in sgn_data.sign_hex%type -- ������� � HEX �������
                           );

  --------------------------------------------------------------------------------
  -- del_int_sign - �������� ���������� ������� (��� �������� �� ���� ����)
  --
  procedure del_int_sign(p_ref    oper.ref%type, -- ref ��������� �� oper                           
                         p_rec_id oper_visa.sqnc%type -- ����� ������ �� oper_visa
                         );

  --------------------------------------------------------------------------------
  -- toggle_trace - ��������\��������� �������
  --
  procedure toggle_trace;

  --------------------------------------------------------------------------------
  -- trace_sign - ���������� ��������� ��� ������� ������� � ��������
  --                         
  procedure trace_sign(p_ref           oper.ref%type, -- ref ��������� �� oper
                       p_level         in number, -- ����� ���� 
                       p_key_id        in sgn_data.key_id%type, -- ������������� ����� 
                       p_sign_mode     in varchar2, -- ����� ������ (sign\verify)
                       p_buffer_type   in varchar2, -- ��� ������ (int\ext)
                       p_buffer_hex    in clob, -- ����� � HEX
                       p_sign_hex      in sgn_data.sign_hex%type, -- ������� � HEX,
                       p_verify_status in number, -- ������ �������� ������� (0-��)
                       p_verify_error  in varchar2 -- ������ �������� �������
                       );

  --------------------------------------------------------------------------------
  -- diagnostic_problem_sign - ����������� �� ���������� ����������
  --                                              
  procedure diagnostic_problem_sign(p_ref in number default null);

end sgn_mgr;
/

show err

create or replace package body bars.sgn_mgr is

  g_body_version constant varchar2(64) := 'version 1.1 12/03/2017';

  --------------------------------------------------------------------------------
  -- header_version - ���������� ������ ��������� ������
  --
  function header_version return varchar2 is
  begin
    return 'Package header sgn_mgr' || ' ' || g_header_version || '.';
  end header_version;

  --------------------------------------------------------------------------------
  -- body_version - ���������� ������ ���� ������
  --
  function body_version return varchar2 is
  begin
    return 'Package body sgn_mgr' || ' ' || g_body_version || '.';
  end body_version;

  --------------------------------------------------------------------------------
  -- set_sign_data - �������� ������� � ���������
  --
  function set_sign_data(p_sign_type in sgn_data.sign_type%type, -- ��� ���
                         p_key_id    in sgn_data.key_id%type, -- ������������� �����
                         p_sign_hex  in sgn_data.sign_hex%type -- ������� � HEX �������
                         ) return sgn_data.id%type is
    l_id sgn_data.id%type;
  begin
    insert into sgn_data
      (id, creating_date, sign_type, key_id, sign_hex)
    values
      (s_sgndata.nextval, sysdate, p_sign_type, p_key_id, p_sign_hex)
    returning id into l_id;
    return l_id;
  end set_sign_data;

  --------------------------------------------------------------------------------
  -- del_sign_data - �������� ������� �� ���������
  --
  procedure del_sign_data(p_id in sgn_data.id%type) is
  begin
    delete from sgn_data sd where sd.id = p_id;
  end del_sign_data;

  --------------------------------------------------------------------------------
  -- get_sign_data - ��������� ������ � ������� �� ���������
  --
  procedure get_sign_data(p_id        in sgn_data.id%type,
                          p_sign_type out sgn_data.sign_type%type, -- ��� ���
                          p_key_id    out sgn_data.key_id%type, -- ������������� �����
                          p_sign_hex  out sgn_data.sign_hex%type -- ������� � HEX �������
                          ) is
  begin
    select sd.sign_type, sd.key_id, sd.sign_hex
      into p_sign_type, p_key_id, p_sign_hex
      from sgn_data sd
     where sd.id = p_id;
  exception
    when no_data_found then
      raise_application_error(-20000,
                              g_trace_module ||
                              'get_sign_data: �� �������� ����� � ��������������� id = [' ||
                              to_char(p_id) || ']',
                              true);
  end get_sign_data;

  --------------------------------------------------------------------------------
  -- store_sep_sign - �������� ���-������ ������� �� ���������
  --
  procedure store_sep_sign(p_ref       oper.ref%type, -- ref ��������� �� oper 
                           p_sign_type in sgn_data.sign_type%type, -- ��� ���
                           p_key_id    in sgn_data.key_id%type, -- ������������� �����
                           p_sign_hex  in sgn_data.sign_hex%type -- ������� � HEX �������
                           ) is
    l_id      sgn_data.id%type;
    l_id_prev sgn_data.id%type;
  begin
    -- put signature in store
    l_id := sgn_mgr.set_sign_data(p_sign_type, p_key_id, p_sign_hex);
    -- check if already exist
    begin
      select s.sign_id
        into l_id_prev
        from sgn_ext_store s
       where s.ref = p_ref;
      -- find, then replace sign
      update sgn_ext_store s set s.sign_id = l_id where s.ref = p_ref;
      del_sign_data(l_id_prev);
    exception
      when no_data_found then
        insert into sgn_ext_store (ref, sign_id) values (p_ref, l_id);
    end;
  end;

  --------------------------------------------------------------------------------
  -- store_int_sign - �������� ���������� ������� �� ��������� (����)
  --
  procedure store_int_sign(p_ref       oper.ref%type, -- ref ��������� �� oper 
                           p_rec_id    oper_visa.sqnc%type, -- ����� ������ �� oper_visa
                           p_sign_type in sgn_data.sign_type%type, -- ��� ���
                           p_key_id    in sgn_data.key_id%type, -- ������������� �����
                           p_sign_hex  in sgn_data.sign_hex%type -- ������� � HEX �������
                           ) is
    l_id sgn_data.id%type;
  begin
    -- put signature in store
    l_id := sgn_mgr.set_sign_data(p_sign_type, p_key_id, p_sign_hex);
    -- put link between oper_visa and sign
    insert into sgn_int_store
      (ref, rec_id, sign_id)
    values
      (p_ref, p_rec_id, l_id);
  end;

  --------------------------------------------------------------------------------
  -- del_int_sign - �������� ���������� ������� (��� �������� �� ���� ����)
  --
  procedure del_int_sign(p_ref    oper.ref%type, -- ref ��������� �� oper                           
                         p_rec_id oper_visa.sqnc%type -- ����� ������ �� oper_visa
                         ) is
    l_id sgn_data.id%type;
  begin
    select sis.sign_id
      into l_id
      from sgn_int_store sis
     where sis.ref = p_ref
       and sis.rec_id = p_rec_id;
  
    -- delete from int store
    delete from sgn_int_store sis
     where sis.ref = p_ref
       and sis.rec_id = p_rec_id;
    -- delete sign from store
    del_sign_data(l_id);
  exception
    when no_data_found then
      null;
  end;

  --------------------------------------------------------------------------------
  -- toggle_trace - ��������\��������� �������
  --
  procedure toggle_trace is
  begin
    bc.subst_branch('/');
    update web_barsconfig
       set val = decode(val, '1', '0', '1')
     where key = 'Crypto.DebugMode';
    bc.home;
  end;

  --------------------------------------------------------------------------------
  -- trace_sign - ���������� ��������� ��� ������� ������� � ��������
  --                         
  procedure trace_sign(p_ref           oper.ref%type, -- ref ��������� �� oper
                       p_level         number, -- ����� ���� 
                       p_key_id        in sgn_data.key_id%type, -- ������������� ����� 
                       p_sign_mode     in varchar2, -- ����� ������ (sign\verify)
                       p_buffer_type   in varchar2, -- ��� ������ (int\ext)
                       p_buffer_hex    in clob, -- ����� � HEX
                       p_sign_hex      in sgn_data.sign_hex%type, -- ������� � HEX,
                       p_verify_status in number, -- ������ �������� ������� (0-��)
                       p_verify_error  in varchar2 -- ������ �������� �������
                       ) is
  begin
    insert into sgn_trace_sign
      (user_id,
       ref,
       visa_level,
       key_id,
       sign_mode,
       buffer_type,
       buffer_hex,
       buffer_bin,
       sign_hex,
       verify_status,
       verify_error)
    values
      (bars.user_id,
       p_ref,
       p_level,
       p_key_id,
       p_sign_mode,
       p_buffer_type,
       p_buffer_hex,
       utl_raw.cast_to_varchar2(hextoraw(to_char(p_buffer_hex))),
       p_sign_hex,
       p_verify_status,
       p_verify_error);
  end trace_sign;

  --------------------------------------------------------------------------------
  -- diagnostic_problem_sign - ����������� �� ���������� ����������
  --                                              
  procedure diagnostic_problem_sign(p_ref in number default null) is
    l_buffer clob;
  begin
    for c in (select * from sgn_trace_sign where nvl(verify_status, 0) != 0 and ref = nvl(p_ref, ref)) loop
      begin
        select buffer_bin
          into l_buffer
          from sgn_trace_sign
         where ref = c.ref
           and sign_mode = 'VISA'
           and buffer_type = c.buffer_type;
        dbms_output.put_line('------------------------------------------');
        dbms_output.put_line('ref:: [' || c.ref || ']');
        dbms_output.put_line('buffer1=[' || l_buffer || ']');
        dbms_output.put_line('buffer2=[' || c.buffer_bin || ']');
      exception
        when no_data_found then
          null;
      end;
    end loop;
  end;

begin
  -- Initialization
  select nvl(max(val), 0)
    into g_trace_enabled
    from web_barsconfig
   where key = 'Crypto.DebugMode';
end sgn_mgr;
/

show err

GRANT EXECUTE ON SGN_MGR TO BARS_ACCESS_USER;