
 
 PROMPT ===================================================================================== 
 PROMPT *** Run *** ========== Scripts /Sql/BARS/function/f_crypt.sql =========*** Run *** ==
 PROMPT ===================================================================================== 
 
  CREATE OR REPLACE FUNCTION BARS.F_CRYPT (p_s in varchar2 -- ������ ��� ����������
                                   ) return varchar2 is
  /*
  ������� �������� ���������� �������(�������� ������).

  ����������:
  1. ����������� ������� ������� � ������ ������, ��� ������� �����������;
  2. ����� ������ � ������ ��������� �� ������, ���� ����������� ���������� �� ASCII - ���� �������
     ������� ������� � ������ ������. ���� ����� ASCII - ��� �������� �� ��� ���������� �������,
     �� �������� ������ � ������� �������� �� �������� ������ ������ �� ���.
  */

  l_ifront number := length(p_s);
  l_res    varchar2(4000);
  l_c      varchar2(1);
  l_cnew   varchar2(1);
begin
  for i in 1 .. l_ifront loop
    l_c := substr(p_s, i, 1);
    if (l_c < '�' or l_c > '�') then
      l_res := l_res || l_c;
    else
      l_cnew := chr(ascii(l_c) + l_ifront);
      if (l_cnew <= '�') then
        l_res := l_res || l_cnew;
      else
        l_res := l_res || chr(ascii('�') + ascii(l_cnew) - ascii('�'));
      end if;
    end if;
  end loop;

  return l_res;
end f_crypt;
/
 show err;
 
 
 
 PROMPT ===================================================================================== 
 PROMPT *** End *** ========== Scripts /Sql/BARS/function/f_crypt.sql =========*** End *** ==
 PROMPT ===================================================================================== 
 