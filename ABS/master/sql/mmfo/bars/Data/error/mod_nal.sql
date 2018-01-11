PROMPT ===================================================================================== 
PROMPT *** Run *** ========== Scripts /Sql/Bars/Data/Err/mod_NAL.sql =========*** Run *** ==
PROMPT ===================================================================================== 


PROMPT *** Create/replace ERR ������ NAL ***
declare
  l_mod  varchar2(3) := 'NAL';
  l_rus  varchar2(3) := 'RUS';
  l_ukr  varchar2(3) := 'UKR';
  l_eng  varchar2(3) := 'ENG';
  l_geo  varchar2(3) := 'GEO';
  l_exc  number      := -20000;
begin
    bars_error.add_module(l_mod, '��������� ����', 1);

    bars_error.add_message(l_mod, 1, l_exc, l_rus, '������� ������ 1 ����� �� � ����� P080: %s: %s: %s -> ��������� ���������� <<���������>>', '��������� ���������� <<���������>>', 1, 'NAL_DUPACCN');
    bars_error.add_message(l_mod, 1, l_exc, l_ukr, '�i������ �i���� 1 ������� �� � ����� P080: %s: %s: %s ->�����i��� ���i���� <<��i����i�>>', '�����i��� ���i���� <<��i����i�>>', 1, 'NAL_DUPACCN');

    bars_error.add_message(l_mod, 2, l_exc, l_rus, '�� �������  ���', '', 1, 'NAL_OURMFO');
    bars_error.add_message(l_mod, 2, l_exc, l_ukr, '�� �������� ���', '', 1, 'NAL_OURMFO');

    bars_error.add_message(l_mod, 3, l_exc, l_rus, '��� ��� ������ ��������� ��� ������� (������� ������)', '', 1, 'NAL_NU_KS6');
    bars_error.add_message(l_mod, 3, l_exc, l_ukr, '���� ��� ������� ������������ ��� �����i� (�����i ������)', '', 1, 'NAL_NU_KS6');

    bars_error.add_message(l_mod, 4, l_exc, l_rus, '��� ��� ������ ��������� ��� ������� (������� �������)', '', 1, 'NAL_NU_KS7');
    bars_error.add_message(l_mod, 4, l_exc, l_ukr, '���� ��� ������� ������������ ��� �����i� (�����i �������)', '', 1, 'NAL_NU_KS7');

    bars_error.add_message(l_mod, 5, l_exc, l_rus, '�� ����� ���. ���� � ����� ������', '', 1, 'NAL_NBS_PS');
    bars_error.add_message(l_mod, 5, l_exc, l_ukr, '�� ������ ���.������� � ����i ������i�', '', 1, 'NAL_NBS_PS');

    bars_error.add_message(l_mod, 6, l_exc, l_rus, '�� ������� ������� ����', '', 1, 'NAL_ACC_ERR');
    bars_error.add_message(l_mod, 6, l_exc, l_ukr, '�� ������ �i������ �������', '', 1, 'NAL_ACC_ERR');
  commit;
end;
/
PROMPT ===================================================================================== 
PROMPT *** End *** ========== Scripts /Sql/Bars/Data/Err/mod_NAL.sql =========*** Run *** ==
PROMPT ===================================================================================== 
