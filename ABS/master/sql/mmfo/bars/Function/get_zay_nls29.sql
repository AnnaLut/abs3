CREATE OR REPLACE function BARS.get_zay_nls29(p_mode integer)
-- ������� ���������� ���� 2900 ����������� � ����������� zay_mfo_nls29
-- ���� �������� ��������:
--  - ����� 1, �� ���������� ���� nls29ca - �������� ���� �� �������� � ��;
--  - ����� 2, �� ���������� ���� nls29 - �������� ���� ��;
--  - ����� 3, �� ���������� ���� nls6114 - ���� ��� ���������� �������;

   return varchar2
is
   l_nls6    zay_mfo_nls29.nls6114%TYPE;
   l_nls    zay_mfo_nls29.nls29%TYPE;
   l_nls_ca zay_mfo_nls29.nls29ca%TYPE;
   l_result zay_mfo_nls29.nls29%TYPE;
   l_par    number;
begin
  begin
     select trim(nls29), trim(nls29ca), trim(nls6114)
       into l_nls, l_nls_ca,l_nls6
       from zay_mfo_nls29
      where mfo = f_ourmfo;
  exception
     when no_data_found
     then
        l_nls := null;
        l_nls_ca := null;
        l_nls6:= null;
  end;

begin
  select val into l_par from params where par = 'IS_MMFO';
  exception when no_data_found then l_par := 0;
end;

/*if l_par = 1 then l_result := '29003';
                  return l_result;
                  end if;*/

  case
    when p_mode = 1 then
      if l_nls_ca is null or l_nls_ca = '' then
        raise_application_error(-20001,'�� �������� �������� ���� �� �������� � ��, ���=2900 � ������� ZAY_MFO_NLS29.');
      else
        l_result := l_nls_ca;
      end if;
    when p_mode = 2 then
      if l_nls is null or l_nls = '' then
        raise_application_error(-20001,'�� �������� �������� ���� ��, ���=2900 � ������� ZAY_MFO_NLS29.');
      else
        l_result := l_nls;
      end if;
    when p_mode = 3 then
      if l_nls6 is null or l_nls6 = '' then
        raise_application_error(-20001,'�� �������� ���� ������� ��, ���='||case when newnbs.g_state= 1 then '6514' else'6114' end ||' � ������� ZAY_MFO_NLS29.');
      else
        l_result := l_nls6;
      end if;
    else
      null;
  end case;

  return l_result;
end get_zay_nls29;
/
