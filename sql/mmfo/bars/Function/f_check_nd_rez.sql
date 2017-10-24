
 
 PROMPT ===================================================================================== 
 PROMPT *** Run *** ========== Scripts /Sql/BARS/function/f_check_nd_rez.sql =========*** Run
 PROMPT ===================================================================================== 
 
  CREATE OR REPLACE FUNCTION BARS.F_CHECK_ND_REZ (p_ref oper.ref%type)
-- �������� ���������� ���� ��������� �� ����� ������������
  -- ��������
  -- ������ 06.02.2015
  -- ����� 2.0
 return number is
  l_cnt             number;
  l_nd_rez          number;
  l_rez             operw.value%type;
  l_type            passp.passp%type;
  g_modcode         varchar2(3) := 'DOC';
  l_ret             number := 0;
  l_paspt_resid    number; --������������ ����� �������� ���������

begin
  begin
    -- �������� ���������� �������
    begin
      select 1 into l_cnt from oper where ref = p_ref;
    exception
      when no_data_found then
        raise_application_error(-20000,
                                'Document ' || p_ref || ' not found');
    end;
    -- ��������� �������� ��� ���������� ������
    begin
      select length(trim(value))
        into l_nd_rez
        from operw
       where ref = p_ref
         and tag = 'NDREZ';
    exception
      when no_data_found then
        l_nd_rez := 0;

    end;
    -- �������� �������� �������������� ��������� ��� �����������
    if l_nd_rez < 5 and l_rez <> '1' then
      bars_error.raise_nerror(g_modcode, 'NDREZ_IS_NULL');
    end if;

    begin
      select value
        into l_rez
        from operw
       where ref = p_ref
         and tag = 'REZID';
    exception
      when no_data_found then
        l_rez := '1';

    end;
    -- � ���������� �� ���� ��������
    begin
      -- ������� PASSPT
      select p.passp doc
        into l_type
        from operw o, passp p
       where o.ref = p_ref
         and o.tag = 'NAMED'
         and rownum = 1
         and o.value = p.name;

      if l_rez = '2' and l_type in (5, 11, 13, 15) then
        l_ret := 0;
      else
        if l_rez = '1' and l_type not in (5, 11, 13, 15) then
          l_ret := 0;
        else
          bars_error.raise_nerror(g_modcode, 'NAMED_REZ');
        end if;
      end if;

    exception
      when no_data_found then
        -- ������� PASSPV
        select p.rezid
          into l_paspt_resid
          from operw o, passpv p
         where o.ref = p_ref
           and o.tag = 'NAMET'
           and rownum = 1
           and o.value = p.name;
       if (l_paspt_resid != to_number(l_rez)) then
          bars_error.raise_nerror(g_modcode, 'NAMED_REZ');
        end if;
    end;
end;
return l_ret;
end f_check_nd_rez;
/
 show err;
 
PROMPT *** Create  grants  F_CHECK_ND_REZ ***
grant EXECUTE                                                                on F_CHECK_ND_REZ  to BARS_ACCESS_DEFROLE;
grant EXECUTE                                                                on F_CHECK_ND_REZ  to START1;

 
 
 PROMPT ===================================================================================== 
 PROMPT *** End *** ========== Scripts /Sql/BARS/function/f_check_nd_rez.sql =========*** End
 PROMPT ===================================================================================== 
 