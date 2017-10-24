

PROMPT ===================================================================================== 
PROMPT *** Run *** ========== Scripts /Sql/BARS/Procedure/P_DPT_PI_FIND_NEW.sql =========***
PROMPT ===================================================================================== 


PROMPT *** Create  procedure P_DPT_PI_FIND_NEW ***

  CREATE OR REPLACE PROCEDURE BARS.P_DPT_PI_FIND_NEW (p_old_dpt_id  in dpt_deposit.deposit_id%type, -- � ���������� ���������� ��������
                                              p_deposit_id  in dpt_deposit.deposit_id%type, -- �
                                              p_dat_begin   in dpt_deposit.dat_begin%type, -- ���� �������
                                              p_dat_end     out dpt_deposit.dat_end%type, -- ���� ���������
                                              p_kv          out dpt_deposit.kv%type, -- ������
                                              p_sum         out dpt_deposit.limit%type, -- ���� ��������
                                              p_fio         out customer.nmk%type, -- ϲ� �볺���
                                              p_birth_date  out person.bday%type, -- ���� ���������� �볺���
                                              p_inn         out customer.okpo%type, -- ��� �볺���
                                              p_doc         out varchar2, -- �������� �볺���
                                              p_result_code out number,
                                              p_result_text out varchar2) is
  -- ��������� ������ ������ �������� ��� ��������� �� ��� �����. ������ �� ����������� �14/2-01/-ID-1241 �� 26.02.2014�.
  l_dpt_row    dpt_deposit%rowtype;
  l_dpt_cl_row dpt_deposit_clos%rowtype;
begin


  -- �������������� ���������� "�������"
  p_result_code := 0;
  p_result_text := null;

  -- ���� ������ �������
  select dc.*
    into l_dpt_cl_row
    from dpt_deposit_clos dc
   where dc.deposit_id = p_old_dpt_id
     and dc.action_id = 2;

  -- ����� ��������
  begin
    select d.*
      into l_dpt_row
      from dpt_deposit d
     where d.deposit_id = p_deposit_id
       and d.dat_begin = p_dat_begin;
  exception
    when no_data_found then
      p_result_code := 1;
      p_result_text := '������� �' || p_deposit_id || ' �� ' ||
                       to_char(p_dat_begin, 'dd.mm.yyyy') ||
                       ' �� ��������.';

      return;
  end;

  -- ��������� ��� ������ � ����� ������� ��� �� ����������� � �����
  declare
    l_tmp number;
  begin
    select count(1)
      into l_tmp
      from dpt_political_instability pi
     where pi.old_dpt_id = p_old_dpt_id
        or pi.new_dpt_id = p_deposit_id;

    if (l_tmp > 0) then
      p_result_code := 2;
      p_result_text := '������� �' || p_deposit_id || ' �� ' ||
                       to_char(p_dat_begin, 'dd.mm.yyyy') ||
                       ' ��/��� ������� �' || p_old_dpt_id || ' �� ' ||
                       to_char(l_dpt_cl_row.dat_begin, 'dd.mm.yyyy') ||
                       ' ��� �������� ������ � �����.';
    end if;
  end;

  -- ��������� ��� ����� �������� �� �� �� ���� ��� � ������
  if (l_dpt_row.rnk != l_dpt_cl_row.rnk) then
    p_result_code := 3;
    p_result_text := '������� �' || p_deposit_id || ' �� ' ||
                     to_char(p_dat_begin, 'dd.mm.yyyy') ||
                     ' ��������� �� ���� ����� �� ������� �' ||
                     p_old_dpt_id || ' �� ' ||
                     to_char(l_dpt_cl_row.dat_begin, 'dd.mm.yyyy') || '.';

    return;
  end if;

  -- ����� ������ ������ �� ���� �� ������ 3� ������
  if (months_between(l_dpt_row.dat_end, l_dpt_row.dat_begin) < 3) then
    p_result_code := 4;
    p_result_text := '������� �' || p_deposit_id || ' �� ' ||
                     to_char(p_dat_begin, 'dd.mm.yyyy') ||
                     ' �� ����� ������� �� 3 ��.';

    return;
  end if;

  -- ����� 䳿 ����� � 25 ������ 2014�. �� 14 ������� 2014�
  if (l_dpt_row.dat_begin < to_date('25.02.2014', 'dd.mm.yyyy') or
     l_dpt_row.dat_begin > to_date('20.04.2014', 'dd.mm.yyyy')) then
    p_result_code := 5;
    p_result_text := '������� �' || p_deposit_id || ' �� ' ||
                     to_char(p_dat_begin, 'dd.mm.yyyy') ||
                     ' ��� �������� �� � ����� 䳿 ����� (� 25.02.2014 �� 14.04.2014).';

    return;
  end if;

  -- ����� 䳺 �� ����� �������� ������ �������� �� �������� �����������,
  declare
    l_tmp number;
  begin
    select 1
      into l_tmp
      from dpt_vidd v
     where v.vidd = l_dpt_row.vidd
       and v.type_id = 2; -- ���������� �������� �����;
  exception
    when no_data_found then
      p_result_code := 6;
      p_result_text := '������� �' || p_deposit_id || ' �� ' ||
                       to_char(p_dat_begin, 'dd.mm.yyyy') ||
                       ' �� ��� ������� �� "���������� �������� �����".';

      return;
  end;

  -- ���� ������ �������� �� ���� �� ������ �� ���������� ���������� � �� ���� �����, ��� � ���������� �� ����� ��� �� ���� �������� ������ ��������
  declare
    l_old_balance       number;
    l_new_balance980    number := gl.p_icurval(l_dpt_row.kv,
                                               l_dpt_row.limit,
                                               gl.bd);
    l_new_balance_oldkv number := gl.p_ncurval(l_dpt_cl_row.kv,
                                               l_new_balance980,
                                               gl.bd);
  begin
    -- ������� �� ������ ����������
    select fost(dc.acc, trunc(dc.when) - 1) / 100
      into l_old_balance
      from dpt_deposit_clos dc
     where dc.deposit_id = p_old_dpt_id
       and dc.action_id = 2;

    if (l_old_balance > l_new_balance_oldkv) then
      p_result_code := 7;
      p_result_text := '����� �' || p_deposit_id || ' �� ' ||
                       to_char(p_dat_begin, 'dd.mm.yyyy') ||
                       ' �� ���� ������ ���������� ���������� ������ (� ���������) �' ||
                       p_old_dpt_id || ' �� ' ||
                       to_char(l_dpt_cl_row.dat_begin, 'dd.mm.yyyy') || '.';

      return;
    end if;
  end;

  -- ����� ������� �� ������������� � �� �� ������� (������), �� � ���������� ���������
  if (l_dpt_row.branch != l_dpt_cl_row.branch) then
    p_result_code := 8;
    p_result_text := '������� �' || p_deposit_id || ' �� ' ||
                     to_char(p_dat_begin, 'dd.mm.yyyy') ||
                     ' ��� �������� � ������ ������ �� �' ||
                     p_old_dpt_id || ' �� ' ||
                     to_char(l_dpt_cl_row.dat_begin, 'dd.mm.yyyy') || '.';

    return;
  end if;

  -- ���������� ��������� �������� � �������
  p_dat_end := l_dpt_row.dat_end;
  p_kv      := l_dpt_row.kv;
  p_sum     := l_dpt_row.limit / 100;

  select c.nmk, p.bday, c.okpo, p.ser || p.numdoc
    into p_fio, p_birth_date, p_inn, p_doc
    from customer c, person p
   where c.rnk = l_dpt_row.rnk
     and c.rnk = p.rnk;

end p_dpt_pi_find_new;
/
show err;

PROMPT *** Create  grants  P_DPT_PI_FIND_NEW ***
grant EXECUTE                                                                on P_DPT_PI_FIND_NEW to BARS_ACCESS_DEFROLE;



PROMPT ===================================================================================== 
PROMPT *** End *** ========== Scripts /Sql/BARS/Procedure/P_DPT_PI_FIND_NEW.sql =========***
PROMPT ===================================================================================== 
