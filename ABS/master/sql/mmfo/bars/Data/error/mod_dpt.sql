PROMPT ===================================================================================== 
PROMPT *** Run *** ========== Scripts /Sql/Bars/Data/Err/mod_DPT.sql =========*** Run *** ==
PROMPT ===================================================================================== 


PROMPT *** Create/replace ERR ������ DPT ***
declare
  l_mod  varchar2(3) := 'DPT';
  l_rus  varchar2(3) := 'RUS';
  l_ukr  varchar2(3) := 'UKR';
  l_eng  varchar2(3) := 'ENG';
  l_geo  varchar2(3) := 'GEO';
  l_exc  number      := -20000;
begin
    bars_error.add_module(l_mod, '�������� ���.���.', 1);

    bars_error.add_message(l_mod, 1, l_exc, l_rus, '���������� �������� ������������� ��������', '', 1, 'CANT_GET_DPTID');
    bars_error.add_message(l_mod, 1, l_exc, l_ukr, '��������� �������� ������������� ��������', '', 1, 'CANT_GET_DPTID');

    bars_error.add_message(l_mod, 2, l_exc, l_rus, '���������� �������� ����� ��������', '', 1, 'CANT_GET_DPTNUM');
    bars_error.add_message(l_mod, 2, l_exc, l_ukr, '��������� �������� ����� ��������', '', 1, 'CANT_GET_DPTNUM');

    bars_error.add_message(l_mod, 3, l_exc, l_rus, '�� ������ ������������� �����������', '', 1, 'ISP_NOT_FOUND');
    bars_error.add_message(l_mod, 3, l_exc, l_ukr, '�� ��������� ������������ ����������', '', 1, 'ISP_NOT_FOUND');

    bars_error.add_message(l_mod, 4, l_exc, l_rus, '�� ������ (��� ������) ��� ������ � %s', '', 1, 'VIDD_NOT_FOUND_OR_CLOSED');
    bars_error.add_message(l_mod, 4, l_exc, l_ukr, '�� ��������� (��� ��������) ��� ������ � %s', '', 1, 'VIDD_NOT_FOUND_OR_CLOSED');

    bars_error.add_message(l_mod, 5, l_exc, l_rus, '������ ���������� ������������ ������', '', 1, 'INVALID_DPT_TERM');
    bars_error.add_message(l_mod, 5, l_exc, l_ukr, '������� ���������� ������ ������', '', 1, 'INVALID_DPT_TERM');

    bars_error.add_message(l_mod, 6, l_exc, l_rus, '�� ������ (��� ������) ���� ������������ = %s', '', 1, 'CONSACC_NOT_FOUND');
    bars_error.add_message(l_mod, 6, l_exc, l_ukr, '�� ��������� (��� ��������) ������� ����������� = %s', '', 1, 'CONSACC_NOT_FOUND');

    bars_error.add_message(l_mod, 7, l_exc, l_rus, '������ ��� ������������ ������ ����� (%s) �� �������� � %s/%s (��� ������ = %s, ������ � %s): %s', '', 1, 'NLS_MASK_FAILED');
    bars_error.add_message(l_mod, 7, l_exc, l_ukr, '������� ��� ��������� ������ ������� (%s) �� �������� � %s/%s (��� ������ = %s, �볺�� � %s): %s', '', 1, 'NLS_MASK_FAILED');

    bars_error.add_message(l_mod, 8, l_exc, l_rus, '������ ��� ������������ �������� ����� (%s) �� �������� � %s/%s (��� ������ = %s, ������ � %s): %s', '', 1, 'NMS_MASK_FAILED');
    bars_error.add_message(l_mod, 8, l_exc, l_ukr, '������� ��� ��������� ����� ������� (%s) �� �������� � %s/%s (��� ������ = %s, �볺�� � %s): %s', '', 1, 'NMS_MASK_FAILED');

    bars_error.add_message(l_mod, 9, l_exc, l_rus, '������ ��� �������� ����� � %s / %s : %s', '', 1, 'OPENACC_FAILED');
    bars_error.add_message(l_mod, 9, l_exc, l_ukr, '������� ��� ������� ������� � %s / %s : %s', '', 1, 'OPENACC_FAILED');

    bars_error.add_message(l_mod, 10, l_exc, l_rus, '�� ������ c��� ������������ ��������� ��� �������� � %s', '', 1, 'AMRACC_NOT_FOUND');
    bars_error.add_message(l_mod, 10, l_exc, l_ukr, '�� ��������� ������� ����������� ������� ��� �������� � %s', '', 1, 'AMRACC_NOT_FOUND');

    bars_error.add_message(l_mod, 11, l_exc, l_rus, '�� ������� �������� ����������� ������� ���������', '', 1, 'PAYINT_TT_NOT_FOUND');
    bars_error.add_message(l_mod, 11, l_exc, l_ukr, '�� �������� �������� ����������� ������� �������', '', 1, 'PAYINT_TT_NOT_FOUND');

    bars_error.add_message(l_mod, 12, l_exc, l_rus, '������ ��� ���������� ���������� ��������: %s', '', 1, 'FILL_INTCARD_FAILED');
    bars_error.add_message(l_mod, 12, l_exc, l_ukr, '������� ��� ��������� ��������� ������: %s ', '', 1, 'FILL_INTCARD_FAILED');

    bars_error.add_message(l_mod, 13, l_exc, l_rus, '������ ��� ���������� ���������� ������: %s', '', 1, 'FILL_INTRATE_FAILED');
    bars_error.add_message(l_mod, 13, l_exc, l_ukr, '������� ��� ��������� ��������� ������: %s ', '', 1, 'FILL_INTRATE_FAILED');

    bars_error.add_message(l_mod, 14, l_exc, l_rus, '�� ������ ���� �������� ��� ���� ������ � %s', '', 1, 'EXPACC_NOT_FOUND');
    bars_error.add_message(l_mod, 14, l_exc, l_ukr, '�� ��������� ������� ������� ��� ���� ������ � %s', '', 1, 'EXPACC_NOT_FOUND');

    bars_error.add_message(l_mod, 15, l_exc, l_rus, '�� ������ ��� ������ �� ������������� ��� ������ = %s', '', 1, 'DMNDVIDD_NOT_FOUND');
    bars_error.add_message(l_mod, 15, l_exc, l_ukr, '�� ��������� ��� ������ �� ��������� ��� ������ = %s', '', 1, 'DMNDVIDD_NOT_FOUND');

    bars_error.add_message(l_mod, 16, l_exc, l_rus, '���������� ���������� ����� ��� ������ �� ������������� ��� ������ = %s', '', 1, 'DMNDVIDD_TOO_MANY_ROWS');
    bars_error.add_message(l_mod, 16, l_exc, l_ukr, '��������� ���������� ������ ��� ������ �� ��������� ��� ������ = %s', '', 1, 'DMNDVIDD_TOO_MANY_ROWS');

    bars_error.add_message(l_mod, 17, l_exc, l_rus, '������� ������ ���� ��� �������� ��������', '', 1, '17');
    bars_error.add_message(l_mod, 17, l_exc, l_ukr, '������ �������� ������� ��� ���������� ��������', '', 1, '17');

    bars_error.add_message(l_mod, 18, l_exc, l_rus, '�� ������ ������� � %s', '', 1, 'DPT_NOT_FOUND');
    bars_error.add_message(l_mod, 18, l_exc, l_ukr, '�� ��������� ������ � %s', '', 1, 'DPT_NOT_FOUND');

    bars_error.add_message(l_mod, 19, l_exc, l_rus, '�� ������� ��������� ������ � %s', '', 1, 'FINEPARAMS_NOT_FOUND');
    bars_error.add_message(l_mod, 19, l_exc, l_ukr, '�� ������ ��������� ������ � %s', '', 1, 'FINEPARAMS_NOT_FOUND');

    bars_error.add_message(l_mod, 20, l_exc, l_rus, '���������� ��������� ����������� ���������� ������ �� ������!', '', 1, 'DPTRATE_CALC_ERROR');
    bars_error.add_message(l_mod, 20, l_exc, l_ukr, '��������� ���������� ���� ��������� ������ �� ������!', '', 1, 'DPTRATE_CALC_ERROR');

    bars_error.add_message(l_mod, 21, l_exc, l_rus, '���������� �������� �������� ������� ������ � %s', '', 1, 'BASERATE_CALC_ERROR');
    bars_error.add_message(l_mod, 21, l_exc, l_ukr, '��������� �������� �������� ������ ������ � %s', '', 1, 'BASERATE_CALC_ERROR');

    bars_error.add_message(l_mod, 22, l_exc, l_rus, '�� ������ ����� � %s', '', 1, 'FINE_NOT_FOUND');
    bars_error.add_message(l_mod, 22, l_exc, l_ukr, '�� ��������� ����� � %s', '', 1, 'FINE_NOT_FOUND');

    bars_error.add_message(l_mod, 23, l_exc, l_rus, '����������� ������ �����!', '', 1, 'INVALID_FINE');
    bars_error.add_message(l_mod, 23, l_exc, l_ukr, '���������� �������� �����!', '', 1, 'INVALID_FINE');

    bars_error.add_message(l_mod, 24, l_exc, l_rus, '�� ������� ����� ���������� ������', '', 1, 'FIRST_PAYMENT_NOT_FOUND');
    bars_error.add_message(l_mod, 24, l_exc, l_ukr, '�� �������� ���� ���������� ������', '', 1, 'FIRST_PAYMENT_NOT_FOUND');

    bars_error.add_message(l_mod, 25, l_exc, l_rus, '�� ������ ���� %s / %s', '', 1, 'ACC_NOT_FOUND_2');
    bars_error.add_message(l_mod, 25, l_exc, l_ukr, '�� ��������� ������� %s / %s', '', 1, 'ACC_NOT_FOUND_2');

    bars_error.add_message(l_mod, 26, l_exc, l_rus, '���������� ��������� �������� ������� ������ = %s(%s) �� %s!', '', 1, '26');
    bars_error.add_message(l_mod, 26, l_exc, l_ukr, '��������� ���������� �������� ������ ������ = %s(%s) �� %s!', '', 1, '26');

    bars_error.add_message(l_mod, 27, l_exc, l_rus, '������ ��� ������� �������������� �������� ���������� ������ = %s, ���� %s!', '', 1, '27');
    bars_error.add_message(l_mod, 27, l_exc, l_ukr, '������� ��� ��������� ������������ ������� ��������� ������ = %s, %s!', '', 1, '27');

    bars_error.add_message(l_mod, 28, l_exc, l_rus, '������ ��� ������� ������� �������� ���������� ������ = %s, ���� %s!', '', 1, '28');
    bars_error.add_message(l_mod, 28, l_exc, l_ukr, '������� ��� ��������� ������ ������� ��������� ������ = %s, ���� %s!', '', 1, '28');

    bars_error.add_message(l_mod, 29, l_exc, l_rus, '�� ������� �������� ��� ����� ������� ��� �������������� �������� (%s)', '', 1, 'CANT_GET_EXTEND_TT');
    bars_error.add_message(l_mod, 29, l_exc, l_ukr, '�� �������� �������� ��� ����� ����� ��� ������������� �������� (%s)', '', 1, 'CANT_GET_EXTEND_TT');

    bars_error.add_message(l_mod, 30, l_exc, l_rus, '������������ ���������� ���������� (DPT_EXTD=%s, DPT_EXTT=%s, DPT_EXTR=%s)', '', 1, 'INVALID_EXTPARAMS');
    bars_error.add_message(l_mod, 30, l_exc, l_ukr, '������������ ��������� ��������� (DPT_EXTD=%s, DPT_EXTT=%s, DPT_EXTR=%s)', '', 1, 'INVALID_EXTPARAMS');

    bars_error.add_message(l_mod, 31, l_exc, l_rus, '��������� �������������� ���.��������� %s ��� ���� ������ %s (������ %s)', '', 1, 'VIDDPARAM_SET_DENIED');
    bars_error.add_message(l_mod, 31, l_exc, l_ukr, '���������� ����������� ���.��������� %s ��� ���� ������ %s (������ %s)', '', 1, 'VIDDPARAM_SET_DENIED');

    bars_error.add_message(l_mod, 32, l_exc, l_rus, '��������� �������� ���.��������� %s (%s) �� ������������� ������� ��������� %s', '', 1, 'VIDDPARAM_CHECK_FAILED');
    bars_error.add_message(l_mod, 32, l_exc, l_ukr, '������� �������� ���.��������� %s (%s) �� ������� ������� ��������� %s', '', 1, 'VIDDPARAM_CHECK_FAILED');

    bars_error.add_message(l_mod, 33, l_exc, l_rus, '������ ���������� ���������� ������ �� ���.�������� � %s : %s', '', 1, 'RATE_REVIEW_FAILED');
    bars_error.add_message(l_mod, 33, l_exc, l_ukr, '������� ��������� ��������� ������ �� ���.�������� � %s : %s', '', 1, 'RATE_REVIEW_FAILED');

    bars_error.add_message(l_mod, 34, l_exc, l_rus, '������������ ���� �������� �������� (%s-��������)', '', 1, 'INVALID_OPENDATE_HLD');
    bars_error.add_message(l_mod, 34, l_exc, l_ukr, '���������� ���� �������� �������� (%s-��������)', '', 1, 'INVALID_OPENDATE_HLD');

    bars_error.add_message(l_mod, 35, l_exc, l_rus, '������ ������������ ���� �������� �������� (%s)', '', 1, 'INVALID_OPENDATE');
    bars_error.add_message(l_mod, 35, l_exc, l_ukr, '������� ������������ ���� �������� �������� (%s)', '', 1, 'INVALID_OPENDATE');

    bars_error.add_message(l_mod, 36, l_exc, l_rus, '�� ������� �������� � %s', '', 1, 'OPERATION_NOT_FOUND');
    bars_error.add_message(l_mod, 36, l_exc, l_ukr, '�� �������� �������� � %s', '', 1, 'OPERATION_NOT_FOUND');

    bars_error.add_message(l_mod, 37, l_exc, l_rus, '��������� ���������� �������� <%s> �� ������ � %s (%s): %s', '', 1, 'CHECKOPERPERM_ACCESS_DENIED');
    bars_error.add_message(l_mod, 37, l_exc, l_ukr, '���������� ��������� �������� <%s> �� ������ � %s (%s): %s', '', 1, 'CHECKOPERPERM_ACCESS_DENIED');

    bars_error.add_message(l_mod, 38, l_exc, l_rus, '�������� <%s> �� ��������� ��� ���� ������ <%s>', '', 1, 'OPERATION_NOT_ALLOWED');
    bars_error.add_message(l_mod, 38, l_exc, l_ukr, '�������� <%s> �� ��������� ��� ���� ������ <%s>', '', 1, 'OPERATION_NOT_ALLOWED');

    bars_error.add_message(l_mod, 39, l_exc, l_rus, '�� ������� �������� ��� ������������ ��������/������ �� ������', '', 1, 'INITVDPTT_NOT_FOUND');
    bars_error.add_message(l_mod, 39, l_exc, l_ukr, '�� �������� �������� ��� ���������� ��������/���쳳 �� ������', '', 1, 'INITVDPTT_NOT_FOUND');

    bars_error.add_message(l_mod, 40, l_exc, l_rus, '�� ������ ��������.���� �������� �������� �������� ��� �������� � ���', '', 1, 'CONSAVANSACC_NOT_FOUND');
    bars_error.add_message(l_mod, 40, l_exc, l_ukr, '�� ��������� �������.������� ������ ����.������ ��� �������� � ���', '', 1, 'CONSAVANSACC_NOT_FOUND');

    bars_error.add_message(l_mod, 41, l_exc, l_rus, '������ ������� ���� ��������� ������ (��� ������ � %s): %s', '', 1, 'GET_DATEND_FAILED');
    bars_error.add_message(l_mod, 41, l_exc, l_ukr, '������ ������� ���� ��������� ������ (��� ������ � %s): %s', '', 1, 'GET_DATEND_FAILED');

    bars_error.add_message(l_mod, 42, l_exc, l_rus, '�� ������ ����� � ���������� �����������', '', 1, 'CORRTERM_DEPNOTFOUND');
    bars_error.add_message(l_mod, 42, l_exc, l_ukr, '�� ��������� ����� � ��������� ����������', '', 1, 'CORRTERM_DEPNOTFOUND');

    bars_error.add_message(l_mod, 43, l_exc, l_rus, '����� ������������ ���� �������� ������', '', 1, 'CORRTERM_INVALIDATES');
    bars_error.add_message(l_mod, 43, l_exc, l_ukr, '������� ����������� ����� 䳿 ������', '', 1, 'CORRTERM_INVALIDATES');

    bars_error.add_message(l_mod, 44, l_exc, l_rus, '�������� ���� ���������� ������������', '', 1, 'CORRTERM_NOTHING2CHANGE');
    bars_error.add_message(l_mod, 44, l_exc, l_ukr, '������� ����� ���������� ������', '', 1, 'CORRTERM_NOTHING2CHANGE');

    bars_error.add_message(l_mod, 45, l_exc, l_rus, '������ ��������� ���� �������� ������ � %s: %s', '', 1, 'CORRTERM_FAILED');
    bars_error.add_message(l_mod, 45, l_exc, l_ukr, '������� �������� ������ 䳿 ������  � %s: %s', '', 1, 'CORRTERM_FAILED');

    bars_error.add_message(l_mod, 46, l_exc, l_rus, '�� ������ ����� � %s ��� �������� �� ����� �� �������������', '', 1, 'MOVE2DMND_DPT_NOT_FOUND');
    bars_error.add_message(l_mod, 46, l_exc, l_ukr, '�� ��������� ����� � %s ��� �������� �� ����� �� ���������', '', 1, 'MOVE2DMND_DPT_NOT_FOUND');

    bars_error.add_message(l_mod, 47, l_exc, l_rus, '������� ���������.��������� �� ����������� ����� ������ � %s', '', 1, 'MOVE2DMND_INVALID_DPTSALDO');
    bars_error.add_message(l_mod, 47, l_exc, l_ukr, '�������� ��������.��������� �� ����������� ������� ������ � %s', '', 1, 'MOVE2DMND_INVALID_DPTSALDO');

    bars_error.add_message(l_mod, 48, l_exc, l_rus, '������� ���������.��������� �� ����������� ����� ������ � %s', '', 1, 'MOVE2DMND_INVALID_INTSALDO');
    bars_error.add_message(l_mod, 48, l_exc, l_ukr, '�������� ��������.��������� �� ����������� ������� ������ � %s', '', 1, 'MOVE2DMND_INVALID_INTSALDO');

    bars_error.add_message(l_mod, 49, l_exc, l_rus, '�� ������ ���������� ���� ��� �������� ����� %s/%s ������ %s', '', 1, 'MOVE2DMND_INTACC_NOT_FOUND');
    bars_error.add_message(l_mod, 49, l_exc, l_ukr, '�� ��������� ���������� ������� ��� ��������� ������� %s/%s ������ %s', '', 1, 'MOVE2DMND_INTACC_NOT_FOUND');

    bars_error.add_message(l_mod, 50, l_exc, l_rus, '������ �������� ������ �� ������������� ��� ������ � %s: %s', '', 1, 'MOVE2DMND_DMNDOPEN_FAILED');
    bars_error.add_message(l_mod, 50, l_exc, l_ukr, '������� �������� ������ �� ��������� ��� ������ � %s: %s', '', 1, 'MOVE2DMND_DMNDOPEN_FAILED');

    bars_error.add_message(l_mod, 51, l_exc, l_rus, '������ ���������� ����������� ����� ������ � %s: %s', '', 1, 'MOVE2DMND_ACCBLK_FAILED');
    bars_error.add_message(l_mod, 51, l_exc, l_ukr, '������� ���������� ����������� ������� ������ � %s: %s', '', 1, 'MOVE2DMND_ACCBLK_FAILED');

    bars_error.add_message(l_mod, 52, l_exc, l_rus, '������ �������� ����� �������� ��� ������ � %s: %s', '', 1, 'MOVE2DMND_PAYDOCDEP_FAILED');
    bars_error.add_message(l_mod, 52, l_exc, l_ukr, '������� �������� ���� �������� ��� ������ � %s: %s', '', 1, 'MOVE2DMND_PAYDOCDEP_FAILED');

    bars_error.add_message(l_mod, 53, l_exc, l_rus, '������ �������� ����� ��������� ��� ������ � %s: %s', '', 1, 'MOVE2DMND_PAYDOCINT_FAILED');
    bars_error.add_message(l_mod, 53, l_exc, l_ukr, '������� �������� ���� ������� ��� ������ � %s: %s', '', 1, 'MOVE2DMND_PAYDOCINT_FAILED');

    bars_error.add_message(l_mod, 54, l_exc, l_rus, '����������� ������ ���.� ����.���������� ����� ��� ���� ������ � %s: %s', '', 1, 'SET_DPTLIMITS_FAILED');
    bars_error.add_message(l_mod, 54, l_exc, l_ukr, '���������� ������ ��.�� ����.��������� ���� ��� ���� ������ � %s: %s', '', 1, 'SET_DPTLIMITS_FAILED');

    bars_error.add_message(l_mod, 55, l_exc, l_rus, '������ �������������� ���.���������� ���.����� �� ������ � %s: %s', '', 1, 'RESTORE_DPTLIMITS_FAILED');
    bars_error.add_message(l_mod, 55, l_exc, l_ukr, '������� ���������� ���.�������� ���.������� �� ������ � %s: %s', '', 1, 'RESTORE_DPTLIMITS_FAILED');

    bars_error.add_message(l_mod, 56, l_exc, l_rus, '�������� ���� �������� �� ������������� ���.����� %s (%s != %s)', '', 1, 'NBS181_MISMATCH');
    bars_error.add_message(l_mod, 56, l_exc, l_ukr, '������� ����� 䳿 �������� �� ������� ���.������� %s (%s != %s)', '', 1, 'NBS181_MISMATCH');

    bars_error.add_message(l_mod, 57, l_exc, l_rus, '������ �������� ������������ �������� ������: %s', '', 1, 'VALIDATE_DPTOPEN_ERROR');
    bars_error.add_message(l_mod, 57, l_exc, l_ukr, '������� �������� ������������ �������� ������: %s', '', 1, 'VALIDATE_DPTOPEN_ERROR');

    bars_error.add_message(l_mod, 58, l_exc, l_rus, '�������� ������� ������ �������������: %s', '', 1, 'VALIDATE_DPTOPEN_FAILED');
    bars_error.add_message(l_mod, 58, l_exc, l_ukr, '³������� ������ ������ �����������: %s', '', 1, 'VALIDATE_DPTOPEN_FAILED');

    bars_error.add_message(l_mod, 99, l_exc, l_rus, '���������� ����������� ����� ������������� (�� ������ 5 ����  �� ���� �������� � ������� �������)', '', 1, 'AUGMENTER_DEPOSIT_VETO3');
    bars_error.add_message(l_mod, 99, l_exc, l_ukr, '���������� ����������� ������� ���������� (�� ����� 5 ��� �� ���� ������� �� ������� ��������)', '', 1, 'AUGMENTER_DEPOSIT_VETO3');

    bars_error.add_message(l_mod, 100, l_exc, l_rus, '�����.���������� ����� ��� ������ �������� - %s %s!', '', 1, '100');
    bars_error.add_message(l_mod, 100, l_exc, l_ukr, '̳��.���������� ���� ��� ���� �������� - %s %s!', '', 1, '100');

    bars_error.add_message(l_mod, 101, l_exc, l_rus, '����.���������� ����� ��� ������ �������� - %s %s!', '', 1, '101');
    bars_error.add_message(l_mod, 101, l_exc, l_ukr, '����.���������� ���� ��� ���� �������� - %s %s!', '', 1, '101');

    bars_error.add_message(l_mod, 102, l_exc, l_rus, '���� ���������� ����� ��� %s!', '', 1, '102');
    bars_error.add_message(l_mod, 102, l_exc, l_ukr, '����� ���������� ��������� �� %s!', '', 1, '102');

    bars_error.add_message(l_mod, 103, l_exc, l_rus, '�������� ����� ��������� ������ �� ������!', '', 1, '103');
    bars_error.add_message(l_mod, 103, l_exc, l_ukr, '��������� ��� ��������� ������ � ������!', '', 1, '103');

    bars_error.add_message(l_mod, 104, l_exc, l_rus, '��������� ���������� ���������� ��������� ������ �� ������!', '', 1, '104');
    bars_error.add_message(l_mod, 104, l_exc, l_ukr, '���������� ��������� ������� ��������� ������ � ������!', '', 1, '104');

    bars_error.add_message(l_mod, 105, l_exc, l_rus, '�������� ����� ��������� ������ �� ������!', '', 1, '105');
    bars_error.add_message(l_mod, 105, l_exc, l_ukr, '��������� ��� ��������� ������ � ������!', '', 1, '105');

    bars_error.add_message(l_mod, 106, l_exc, l_rus, '����� �������� ������� �� ���������� �������� %s!', '', 1, '106');
    bars_error.add_message(l_mod, 106, l_exc, l_ukr, '����� � �������� �� ��������� ��������� %s!', '', 1, '106');

    bars_error.add_message(l_mod, 107, l_exc, l_rus, '���� ������������ �� �����! (%s)', '', 1, 'ACCOUNT_DEBIT_DENIED');
    bars_error.add_message(l_mod, 107, l_exc, l_ukr, '������� ����������� �� �����! (%s)', '', 1, 'ACCOUNT_DEBIT_DENIED');

    bars_error.add_message(l_mod, 108, l_exc, l_rus, '���� ������������ �� ������! (%s)', '', 1, 'ACCOUNT_CREDIT_DENIED');
    bars_error.add_message(l_mod, 108, l_exc, l_ukr, '������� ����������� �� ������! (%s)', '', 1, 'ACCOUNT_CREDIT_DENIED');

    bars_error.add_message(l_mod, 109, l_exc, l_rus, '�� ������ ������ � ��� %s!', '', 1, '109');
    bars_error.add_message(l_mod, 109, l_exc, l_ukr, '�� �������� �볺��� � ��� %s!', '', 1, '109');

    bars_error.add_message(l_mod, 110, l_exc, l_rus, '�� ������ ��� ������!', '', 1, '110');
    bars_error.add_message(l_mod, 110, l_exc, l_ukr, '�� ������� ��� ������!', '', 1, '110');

    bars_error.add_message(l_mod, 111, l_exc, l_rus, '��������� ��� ������ �� ������������� ������������ (%s<>%s)!', '', 1, '111');
    bars_error.add_message(l_mod, 111, l_exc, l_ukr, '�������� ��� ������ �� ������� ���������� (%s<>%s)!', '', 1, '111');

    bars_error.add_message(l_mod, 112, l_exc, l_rus, '��������� ��� ������ �� ������������� ������� ������������� (vidd = %s, ins = %s)!', '', 1, '112');
    bars_error.add_message(l_mod, 112, l_exc, l_ukr, '�������� ��� ������ �� ������� ������ �������� (vidd = %s, ins = %s)!', '', 1, '112');

    bars_error.add_message(l_mod, 113, l_exc, l_rus, '�������������� �����/���� ������/������������� (%s,%s,%s)!', '', 1, '113');
    bars_error.add_message(l_mod, 113, l_exc, l_ukr, '������������ �������/���� ������/�������� (%s,%s,%s)!', '', 1, '113');

    bars_error.add_message(l_mod, 114, l_exc, l_rus, '��������� ���� (%s) �� �������� ������������!', '', 1, '114');
    bars_error.add_message(l_mod, 114, l_exc, l_ukr, '�������� ������� (%s) �� � ������������!', '', 1, '114');

    bars_error.add_message(l_mod, 115, l_exc, l_rus, '�� ������ ���� � ��� ��������� ��� = %s!', '', 1, '115');
    bars_error.add_message(l_mod, 115, l_exc, l_ukr, '�� �������� ������� � ��� ��������� ��� = %s!', '', 1, '115');

    bars_error.add_message(l_mod, 116, l_exc, l_rus, 'C��� %s �� �������� ������ ��������!', '', 1, '116');
    bars_error.add_message(l_mod, 116, l_exc, l_ukr, '������� %s �� � �������� ������������!', '', 1, '116');

    bars_error.add_message(l_mod, 117, l_exc, l_rus, '��������� ���� � ���� �������� ����������� ������ ��������!', '', 1, '117');
    bars_error.add_message(l_mod, 117, l_exc, l_ukr, '��������� ������� � ������� ������������ �������� ����� �볺����!', '', 1, '117');

    bars_error.add_message(l_mod, 118, l_exc, l_rus, '���� ���������� �������� �������� ��������!', '', 1, '118');
    bars_error.add_message(l_mod, 118, l_exc, l_ukr, '���� �������� �������� ������� ����������!', '', 1, '118');

    bars_error.add_message(l_mod, 119, l_exc, l_rus, '�� ������� ������������� �����!', '', 1, '119');
    bars_error.add_message(l_mod, 119, l_exc, l_ukr, '�� ������ ������������� �����!', '', 1, '119');

    bars_error.add_message(l_mod, 120, l_exc, l_rus, 'CR �� ����������� ��� �� �����������!', '', 1, '120');
    bars_error.add_message(l_mod, 120, l_exc, l_ukr, 'CR �� ������������ ��� �� �����������!', '', 1, '120');

    bars_error.add_message(l_mod, 121, l_exc, l_rus, '���� ���������� ������� = 0!', '', 1, '121');
    bars_error.add_message(l_mod, 121, l_exc, l_ukr, '������ ���������� ������� = 0!', '', 1, '121');

    bars_error.add_message(l_mod, 122, l_exc, l_rus, '�� ������� ����� �����!', '', 1, '122');
    bars_error.add_message(l_mod, 122, l_exc, l_ukr, '�� �������� ����� �����!', '', 1, '122');

    bars_error.add_message(l_mod, 123, l_exc, l_rus, '����� ��������� � ����-�����!', '', 1, '123');
    bars_error.add_message(l_mod, 123, l_exc, l_ukr, '����� ����������� � ����-����!', '', 1, '123');

    bars_error.add_message(l_mod, 124, l_exc, l_rus, '������������ �����!', '', 1, '124');
    bars_error.add_message(l_mod, 124, l_exc, l_ukr, '����������� ���!', '', 1, '124');

    bars_error.add_message(l_mod, 125, l_exc, l_rus, '����� ��������� � �������� ����-�����!', '', 1, '125');
    bars_error.add_message(l_mod, 125, l_exc, l_ukr, '����� ����������� � ��������� ����-����!', '', 1, '125');

    bars_error.add_message(l_mod, 126, l_exc, l_rus, '������� �� ����� ������ ������������ (%s %s)', '', 1, '126');
    bars_error.add_message(l_mod, 126, l_exc, l_ukr, '������� �� ������� ����� ��������������� (%s %s)', '', 1, '126');

    bars_error.add_message(l_mod, 127, l_exc, l_rus, '��������� ������ ������� � ����������� ����� �������������', '', 1, 'ADVANCE_PAYMENT_VETO');
    bars_error.add_message(l_mod, 127, l_exc, l_ukr, '���������� ������ ����� � ����������� ������� �����������', '', 1, 'ADVANCE_PAYMENT_VETO');

    bars_error.add_message(l_mod, 128, l_exc, l_rus, '���������� ����������� ����� ������������� (���� ������ ���������� %s)', '', 1, 'AUGMENTER_DEPOSIT_VETO1');
    bars_error.add_message(l_mod, 128, l_exc, l_ukr, '���������� ����������� ������� ���������� (����� ������ ��������� %s)', '', 1, 'AUGMENTER_DEPOSIT_VETO1');

    bars_error.add_message(l_mod, 129, l_exc, l_rus, '���������� ����������� ����� ������������� (�� ������ ���� ��������� ��������� ����������� %s)', '', 1, 'AUGMENTER_DEPOSIT_VETO2');
    bars_error.add_message(l_mod, 129, l_exc, l_ukr, '���������� ����������� ������� ���������� (����� ���� ���������� ����������� %s)', '', 1, 'AUGMENTER_DEPOSIT_VETO2');

    bars_error.add_message(l_mod, 130, l_exc, l_rus, '��������� ������������ ���� ������ ���������!', '', 1, '130');
    bars_error.add_message(l_mod, 130, l_exc, l_ukr, '��������� ���������� ���� ������ ����������!', '', 1, '130');

    bars_error.add_message(l_mod, 131, l_exc, l_rus, '�� ������� ���������� ��� ��������/������ (%s, %s, %s)', '', 1, 'IRRACCS_NOT_FOUND');
    bars_error.add_message(l_mod, 131, l_exc, l_ukr, '�� ������� ����������� ��� ��������/���쳳 (%s, %s, %s)', '', 1, 'IRRACCS_NOT_FOUND');

    bars_error.add_message(l_mod, 132, l_exc, l_rus, '�� ������� ����������� ������ ��� ������ � %s (%s), ��� ������ � %s', '', 1, 'IRR_NOT_FOUND');
    bars_error.add_message(l_mod, 132, l_exc, l_ukr, '�� �������� ��������� ������ ��� ������ � %s (%s), ��� ������ � %s', '', 1, 'IRR_NOT_FOUND');

    bars_error.add_message(l_mod, 133, l_exc, l_rus, '������ �������� ���������� �������� ��� ����������� ��������/������ �� ������ � %s (%s): %s', '', 1, 'IRRCARDOPEN_FAILED');
    bars_error.add_message(l_mod, 133, l_exc, l_ukr, '������� �������� ��������� ������ ��� ����������� ��������/���쳳 �� ������ � %s (%s): %s', '', 1, 'IRRCARDOPEN_FAILED');

    bars_error.add_message(l_mod, 134, l_exc, l_rus, '������ ������������ ��������/������ �� ������ � %s (%s): %s', '', 1, 'IRR_INITDR_FAILED');
    bars_error.add_message(l_mod, 134, l_exc, l_ukr, '������� ���������� ��������/���쳳 �� ������ � %s (%s): %s', '', 1, 'IRR_INITDR_FAILED');

    bars_error.add_message(l_mod, 135, l_exc, l_rus, '������ ������� ����������� ������: %s', '', 1, 'IRR_CALCULATION_FAILED');
    bars_error.add_message(l_mod, 135, l_exc, l_ukr, '������� ������������������� ������: %s', '', 1, 'IRR_CALCULATION_FAILED');

    bars_error.add_message(l_mod, 136, l_exc, l_rus, '�� ������ �������� ������ ��� ���� ������ � %s', '', 1, 'MRATE_NOT_FOUND');
    bars_error.add_message(l_mod, 136, l_exc, l_ukr, '�� ������ ������� ������ ��� ���� ������ � %s', '', 1, 'MRATE_NOT_FOUND');

    bars_error.add_message(l_mod, 137, l_exc, l_rus, '�� ��������� ������ �������� ������ (%s)', '', 1, 'MRATE_INVALID_VALUE');
    bars_error.add_message(l_mod, 137, l_exc, l_ukr, '�� �������� ������ ������� ������ (%s)', '', 1, 'MRATE_INVALID_VALUE');

    bars_error.add_message(l_mod, 138, l_exc, l_rus, '������ �������� ������ � %s �� ������� �� ������ ��������/������', '', 1, 'IRR_DELQUEREC_FAILED');
    bars_error.add_message(l_mod, 138, l_exc, l_ukr, '������� ��������� ������ � %s � ����� �� ���������� ��������/���쳿', '', 1, 'IRR_DELQUEREC_FAILED');

    bars_error.add_message(l_mod, 139, l_exc, l_rus, '������ ������ ������ ������ ��� ������� ��������/������ �� ������ � %s', '', 1, 'IRR_UPDQUEREC_FAILED');
    bars_error.add_message(l_mod, 139, l_exc, l_ukr, '������� ������ ������ ������� ��� ���������� ��������/���쳿 �� ������ � %s', '', 1, 'IRR_UPDQUEREC_FAILED');

    bars_error.add_message(l_mod, 140, l_exc, l_rus, '�� ������� ���������� �������� ������ ��� ���� ������ � %s', '', 1, 'IRR_MKTRATE_NOT_FOUND');
    bars_error.add_message(l_mod, 140, l_exc, l_ukr, '�� �������� �������� ������ ������ ��� ���� ������ � %s', '', 1, 'IRR_MKTRATE_NOT_FOUND');

    bars_error.add_message(l_mod, 141, l_exc, l_rus, '�� ������ ���.���� ��������/������ ��� ������ � %s', '', 1, 'IRR_DPNBS_NOT_FOUND');
    bars_error.add_message(l_mod, 141, l_exc, l_ukr, '�� ��������� ���.������� ��������/���쳿 ��� ������ � %s', '', 1, 'IRR_DPNBS_NOT_FOUND');

    bars_error.add_message(l_mod, 142, l_exc, l_rus, '������ ��� ������������ ������ c���� ���� %s ��� ������ � %s: %s', '', 1, 'IRR_DPACCGETMASK_FAILED');
    bars_error.add_message(l_mod, 142, l_exc, l_ukr, '������� ��� ��������� ������ ������� ���� %s ��� ������ � %s: %s', '', 1, 'IRR_DPACCGETMASK_FAILED');

    bars_error.add_message(l_mod, 143, l_exc, l_rus, '������ ��� �������� ����� ��������/������ � %s/%s : %s', '', 1, 'IRR_DPACCOPEN_FAILED');
    bars_error.add_message(l_mod, 143, l_exc, l_ukr, '������� ��� ������� ������� ��������/���쳿 � %s/%s : %s', '', 1, 'IRR_DPACCOPEN_FAILED');

    bars_error.add_message(l_mod, 144, l_exc, l_rus, '�� ������ ��������� ��� ����� ���� %s (�� %s, ��� %s, ��� %s)', '', 1, 'IRR_CONTRACC_NOT_FOUND');
    bars_error.add_message(l_mod, 144, l_exc, l_ukr, '�� ��������� ������������ ��� ������� ���� %s (�� %s, ��� %s, ²�� %s)', '', 1, 'IRR_CONTRACC_NOT_FOUND');

    bars_error.add_message(l_mod, 145, l_exc, l_rus, '������ ������������ ��������/������ �� ������ � %s : %s', '', 1, 'IRR_PAYDP_FAILED');
    bars_error.add_message(l_mod, 145, l_exc, l_ukr, '������� ���������� ��������/���쳿 �� ������ � %s : %s', '', 1, 'IRR_PAYDP_FAILED');

    bars_error.add_message(l_mod, 146, l_exc, l_rus, '������ �������� ����� %s � ������ � %s: %s', '', 1, 'IRR_DPACCBINDING_FAILED');
    bars_error.add_message(l_mod, 146, l_exc, l_ukr, '������� ��''�������� ������� %s � ������� � %s : %s', '', 1, 'IRR_DPACCBINDING_FAILED');

    bars_error.add_message(l_mod, 147, l_exc, l_rus, '������ ��� ���������� ���������� �������� ��� ����� � %s/%s : %s', '', 1, 'IRR_DPACCINTCARD_FAILED');
    bars_error.add_message(l_mod, 147, l_exc, l_ukr, '������� ��� ��������� ��������� ������ ��� ������� � %s/%s : %s', '', 1, 'IRR_DPACCINTCARD_FAILED');

    bars_error.add_message(l_mod, 148, l_exc, l_rus, '������ ��� �������.����������� ������ ��������/������ �� ������ � %s: %s', '', 1, 'IRR_FINALAMRT_FAILED');
    bars_error.add_message(l_mod, 148, l_exc, l_ukr, '������� ��� �����.����������� ������� ��������/���쳿 �� ������ � %s: %s', '', 1, 'IRR_FINALAMRT_FAILED');

    bars_error.add_message(l_mod, 149, l_exc, l_rus, '������ ��� �������� ����� � %s', '', 1, 'IRR_CLOSDPACC_FAILED');
    bars_error.add_message(l_mod, 149, l_exc, l_ukr, '������� ��� ������� ������� � %s', '', 1, 'IRR_CLOSDPACC_FAILED');

    bars_error.add_message(l_mod, 150, l_exc, l_rus, '�������� ����� � %s �����������', '', 1, 'IRR_CLOSDPACC_DENIED');
    bars_error.add_message(l_mod, 150, l_exc, l_ukr, '�������� ������� � %s ������������', '', 1, 'IRR_CLOSDPACC_DENIED');

    bars_error.add_message(l_mod, 151, l_exc, l_rus, '������������ �������� ����� ������ �� ������� ������.������', '', 1, 'IRRDENIED_INVALID_VALUE');
    bars_error.add_message(l_mod, 151, l_exc, l_ukr, '���������� �������� ������ ������ �� ���������� �����.������', '', 1, 'IRRDENIED_INVALID_VALUE');

    bars_error.add_message(l_mod, 201, l_exc, l_rus, '�� ������ ��� ������ � %s', '', 1, 'VIDD_NOT_FOUND');
    bars_error.add_message(l_mod, 201, l_exc, l_ukr, '�� ��������� ��� ������ � %s', '', 1, 'VIDD_NOT_FOUND');

    bars_error.add_message(l_mod, 202, l_exc, l_rus, '�� ������ ������-�������� ������ � %s', '', 1, 'CUSTOMER_NOT_FOUND');
    bars_error.add_message(l_mod, 202, l_exc, l_ukr, '�� ��������� �볺��, �� ����� ������� ����� � %s', '', 1, 'CUSTOMER_NOT_FOUND');

    bars_error.add_message(l_mod, 203, l_exc, l_rus, '�� ������ ���������� �������� "��� ����� ������"', '', 1, 'COUNTY_NOT_FOUND');
    bars_error.add_message(l_mod, 203, l_exc, l_ukr, '�� ��������� ���������� �������� "��� ���� �����"', '', 1, 'COUNTY_NOT_FOUND');

    bars_error.add_message(l_mod, 204, l_exc, l_rus, '�� ������ ���������� �������� "��� ������ ���������� ������"', '', 1, 'DPTGRP_NOT_FOUND');
    bars_error.add_message(l_mod, 204, l_exc, l_ukr, '�� ��������� ���������� �������� "��� ����� ���������� �������"', '', 1, 'DPTGRP_NOT_FOUND');

    bars_error.add_message(l_mod, 205, l_exc, l_rus, '����� ��������������� ���������� �%s �� ����������� �������� �%s � �������� %s ��� ����������!', '', 1, 'TEXT_ALREADY_EXISTS');
    bars_error.add_message(l_mod, 205, l_exc, l_ukr, '����� ��������� ����� �%s �� ����������� �������� �%s � �������� %s ��� ����!', '', 1, 'TEXT_ALREADY_EXISTS');

    bars_error.add_message(l_mod, 206, l_exc, l_rus, '������ ��� �������� ����������� �������� �%s', '', 1, 'DPT_CLOSE_ERR');
    bars_error.add_message(l_mod, 206, l_exc, l_ukr, '������� ��� ������� ����������� �������� �%s', '', 1, 'DPT_CLOSE_ERR');

    bars_error.add_message(l_mod, 207, l_exc, l_rus, '������ ��� �������� ����� (�����.� %s)', '', 1, 'ACC_CLOSE_ERR');
    bars_error.add_message(l_mod, 207, l_exc, l_ukr, '������� ��� ������� ������� (�����.� %s)', '', 1, 'ACC_CLOSE_ERR');

    bars_error.add_message(l_mod, 208, l_exc, l_rus, '�������� ����������� �������� �%s ���������: %s', '', 1, 'DPT_CLOSE_VETO');
    bars_error.add_message(l_mod, 208, l_exc, l_ukr, '��������� ����������� �������� �%s ����������: %s', '', 1, 'DPT_CLOSE_VETO');

    bars_error.add_message(l_mod, 209, l_exc, l_rus, '���� �� ������ (�����.� %s)', '', 1, 'ACC_NOT_FOUND');
    bars_error.add_message(l_mod, 209, l_exc, l_ukr, '������� �� ��������� (�����.� %s)', '', 1, 'ACC_NOT_FOUND');

    bars_error.add_message(l_mod, 210, l_exc, l_rus, '������ ������������� ���������� ���������� ��� ������ ����������� ��������. ��������������� ������� ������!', '', 1, 'NOT_ENOUGH_PARAMS');
    bars_error.add_message(l_mod, 210, l_exc, l_ukr, '������ ���������� ������� ��������� ��� ������ ����������� ��������. ������������� ����� ������!', '', 1, 'NOT_ENOUGH_PARAMS');

    bars_error.add_message(l_mod, 211, l_exc, l_rus, '������������ ����� ����������� �������� ������ �� ��� �������. ��������������� ������� ������!', '', 1, 'NOT_ENOUGH_PARAMS_CUSTNAME');
    bars_error.add_message(l_mod, 211, l_exc, l_ukr, '����������� ����� ����������� �������� ����� �� ϲ� �볺���. ������������� ����� ������!', '', 1, 'NOT_ENOUGH_PARAMS_CUSTNAME');

    bars_error.add_message(l_mod, 212, l_exc, l_rus, '������������ ����� ����������� �������� �� ����� �����.���� (��� �� 00000...). ������� ��.��� ��������� ��� ��������������� ������� ������!', '', 1, 'NOT_ENOUGH_PARAMS_CUSTCODE');
    bars_error.add_message(l_mod, 212, l_exc, l_ukr, '����������� ����� ����������� �������� �� ����� �����.���� (��� �� 00000...). ������ ��.��� ������� ��� ������������� ����� ������!', '', 1, 'NOT_ENOUGH_PARAMS_CUSTCODE');

    bars_error.add_message(l_mod, 213, l_exc, l_rus, '��������� ���� �������� ��� �������� � %s ���������', '', 1, 'CHG_DPTYPE_DENIED');
    bars_error.add_message(l_mod, 213, l_exc, l_ukr, '���� ���� �������� ��� �������� � %s ����������', '', 1, 'CHG_DPTYPE_DENIED');

    bars_error.add_message(l_mod, 214, l_exc, l_rus, '��������� ���� �������� ��� �������� � %s ���������: ����������� ���.�������������� ����� ������� � %s - %s � � %s - %s', '', 1, 'CHG_DPTYPE_INVALID');
    bars_error.add_message(l_mod, 214, l_exc, l_ukr, '���� ���� �������� ��� �������� � %s ����������: ������������ ���.�������������� ���� ������ � %s - %s �� � %s - %s', '', 1, 'CHG_DPTYPE_INVALID');

    bars_error.add_message(l_mod, 215, l_exc, l_rus, '������ ��� ��������� ���� �������� ��� �������� � %s: %s', '', 1, 'CHG_DPTYPE_ERROR');
    bars_error.add_message(l_mod, 215, l_exc, l_ukr, '������� ��� ��� ���� �������� ��� �������� � %s: %s', '', 1, 'CHG_DPTYPE_ERROR');

    bars_error.add_message(l_mod, 216, l_exc, l_rus, '������ �������������� ������ (� %s) �� �������� �������� � %s', '', 1, 'REQCLOSE_DENIED');
    bars_error.add_message(l_mod, 216, l_exc, l_ukr, '��������� ������������ ����� (� %s) �� ��������� �������� � %s', '', 1, 'REQCLOSE_DENIED');

    bars_error.add_message(l_mod, 221, l_exc, l_rus, '����������� ������ ��������� ������������ ��������/��������� (��� %s, ���� %s)', '', 1, 'INVALID_PAYOFF_PARAMS');
    bars_error.add_message(l_mod, 221, l_exc, l_ukr, '���������� ����� ��������� ������������� ��������/������� (��� %s, ������� %s)', '', 1, 'INVALID_PAYOFF_PARAMS');

    bars_error.add_message(l_mod, 222, l_exc, l_rus, '����������� ������ ��������� ������� ��������� (��� %s, ���� %s)', '', 1, '222');
    bars_error.add_message(l_mod, 222, l_exc, l_ukr, '���������� ����� ��������� ������ ������� (��� %s, ������� %s)', '', 1, '222');

    bars_error.add_message(l_mod, 223, l_exc, l_rus, '������ � �����.������� ����� %s, ��������  � ����� � ��� %s', '', 1, 'INVALID_PAYOFF_ACCOUNT');
    bars_error.add_message(l_mod, 223, l_exc, l_ukr, '������� � ����������� ������ ������� %s, ��������� � ����� � ��� %s', '', 1, 'INVALID_PAYOFF_ACCOUNT');

    bars_error.add_message(l_mod, 224, l_exc, l_rus, '������ ���������� ���������� ������������ ����� �������� �� ������ � %s, (��� %s, ���� %s)', '', 1, 'UPD_DEPPAYOFFPARAMS_FAILED');
    bars_error.add_message(l_mod, 224, l_exc, l_ukr, '������� ��������� ��������� �������������  ���������� ����� �� ������ � %s, (��� %s, ���.%s)', '', 1, 'UPD_DEPPAYOFFPARAMS_FAILED');

    bars_error.add_message(l_mod, 225, l_exc, l_rus, '������ ���������� ���������� ������� ��������� �� ������ � %s, (��� %s, ���� %s)', '', 1, 'UPD_INTPAYOFFPARAMS_FAILED');
    bars_error.add_message(l_mod, 225, l_exc, l_ukr, '������� ��������� ��������� ������ ������� �� ������ � %s, (��� %s, ���. %s)', '', 1, 'UPD_INTPAYOFFPARAMS_FAILED');

    bars_error.add_message(l_mod, 226, l_exc, l_rus, '��� ���������� ���.���������� (= %s) �� �������� ���.����������� � 3-�� �����', '', 1, '226');
    bars_error.add_message(l_mod, 226, l_exc, l_ukr, '��� ������� ��������� ����� (= %s) �� � ���������� ������ ��� 3-�� ���', '', 1, '226');

    bars_error.add_message(l_mod, 227, l_exc, l_rus, '����������� �������� ���.���������� ��� 3-�� ���� �%s �� �������� %s', '', 1, '227');
    bars_error.add_message(l_mod, 227, l_exc, l_ukr, '³������ ������� ��������� ����� ��� 3-� ����� �%s �� �������� %s', '', 1, '227');

    bars_error.add_message(l_mod, 228, l_exc, l_rus, '������ ��� ������ ������ � 3-�� ����: %s', '', 1, '228');
    bars_error.add_message(l_mod, 228, l_exc, l_ukr, '������� ��� ������ ����� ��� 3-�� �����: %s', '', 1, '228');

    bars_error.add_message(l_mod, 230, l_exc, l_rus, '������� ������ ��� ���.���������� = %s', '', 1, '230');
    bars_error.add_message(l_mod, 230, l_exc, l_ukr, '������ �������� ��� ��������� ����� = %s', '', 1, '230');

    bars_error.add_message(l_mod, 231, l_exc, l_rus, '�� ������� ���.���������� � ����� � %s', '', 1, '231');
    bars_error.add_message(l_mod, 231, l_exc, l_ukr, '�� �������� ��������� ����� � ����� � %s', '', 1, '231');

    bars_error.add_message(l_mod, 232, l_exc, l_rus, '�� ������ ������ ���.���������� ���� %s ��� ���� ������ � %s', '', 1, '232');
    bars_error.add_message(l_mod, 232, l_exc, l_ukr, '�� ��������� ������ ��������� ����� ���� %s ��� ���� ������ � %s', '', 1, '232');

    bars_error.add_message(l_mod, 233, l_exc, l_rus, '���������� ���������� ���������� ������ ���.���������� ���� %s ��� ���� ������ � %s', '', 1, '233');
    bars_error.add_message(l_mod, 233, l_exc, l_ukr, '��������� ���������� ��������� ������ ��������� ����� ���� %s ��� ���� ������ � %s', '', 1, '233');

    bars_error.add_message(l_mod, 234, l_exc, l_rus, '�� ������� ��������� ���� � � %s', '', 1, '234');
    bars_error.add_message(l_mod, 234, l_exc, l_ukr, '�� �������� ������� ����� � � %s', '', 1, '234');

    bars_error.add_message(l_mod, 235, l_exc, l_rus, '������� ������� ����� ����������/������ ����������� = %s � ����������� ������������� = %s', '', 1, '235');
    bars_error.add_message(l_mod, 235, l_exc, l_ukr, '������ ������ ���� ���������/����� ������� = %s �� ����������� ������ = %s', '', 1, '235');

    bars_error.add_message(l_mod, 236, l_exc, l_rus, '��������� ���������� ���.���������� �� ������� � %s �� ��������� ���������� ������ �� �������� � %s', '', 1, '236');
    bars_error.add_message(l_mod, 236, l_exc, l_ukr, '���������� ���������� ���.����� �� ������ � %s �� ���� ��������� ������ �� �������� � %s', '', 1, '236');

    bars_error.add_message(l_mod, 237, l_exc, l_rus, '���������� ���������� ����� %-��� ������ �� �������� � %s � %s, (���,���) = (%s, %s)', '', 1, 'SET_RATE_FAILED');
    bars_error.add_message(l_mod, 237, l_exc, l_ukr, '��������� ���������� ���� %-�� ������ �� �������� � %s � %s, (���,���) = (%s, %s)', '', 1, 'SET_RATE_FAILED');

    bars_error.add_message(l_mod, 238, l_exc, l_rus, '������� ������� ���� ������ �������� ����� ���������� ������ = %s', '', 1, '238');
    bars_error.add_message(l_mod, 238, l_exc, l_ukr, '������ ������� ���� ������� 䳿 ���� ��������� ������ = %s', '', 1, '238');

    bars_error.add_message(l_mod, 239, l_exc, l_rus, '������� ����� ������� �������� ��������: %s - %s', '', 1, '239');
    bars_error.add_message(l_mod, 239, l_exc, l_ukr, '������ ������� ����� 䳿 ��������: %s - %s', '', 1, '239');

    bars_error.add_message(l_mod, 240, l_exc, l_rus, '�� ������� �����, ������������� ����� #%s!', '', 1, '240');
    bars_error.add_message(l_mod, 240, l_exc, l_ukr, '�� ������� �������, �� ������������ ����� �%s', '', 1, '240');

    bars_error.add_message(l_mod, 241, l_exc, l_rus, '������ ��� ��������� ����� �������� �������� � %s', '', 1, '241');
    bars_error.add_message(l_mod, 241, l_exc, l_ukr, '������� ��� ��� ������ 䳿 �������� � %s', '', 1, '241');

    bars_error.add_message(l_mod, 242, l_exc, l_rus, '������ ��� ��������� ���� ��������� ��� ����� (#%s) �� ������ � %s', '', 1, '242');
    bars_error.add_message(l_mod, 242, l_exc, l_ukr, '������� ��� ��� ���� ��������� ��� ������� (#%s) �� ������ � %s', '', 1, '242');

    bars_error.add_message(l_mod, 243, l_exc, l_rus, '������ ��� ��������� ����-���� �� ���������� ��������� ��� ������ � %s', '', 1, '243');
    bars_error.add_message(l_mod, 243, l_exc, l_ukr, '������� ��� ��� ����-���� �� ����������� ������� ��� ������ � %s', '', 1, '243');

    bars_error.add_message(l_mod, 244, l_exc, l_rus, '�� ������� ���.���������� � 3-�� ����� � %s', '', 1, '244');
    bars_error.add_message(l_mod, 244, l_exc, l_ukr, '�� �������� ��������� ����� ��� 3-�� ��� � %s', '', 1, '244');

    bars_error.add_message(l_mod, 245, l_exc, l_rus, '�� ��������� ����� ������������� ���.���������� � 3-�� ����� � %s: %s', '', 1, '245');
    bars_error.add_message(l_mod, 245, l_exc, l_ukr, '�� �������� ������� ������������� ��������� ����� ��� 3-�� ��� � %s: %s', '', 1, '245');

    bars_error.add_message(l_mod, 246, l_exc, l_rus, '������ ��� ��������������� ����� (#%s) �� ������� � %s', '', 1, '246');
    bars_error.add_message(l_mod, 246, l_exc, l_ukr, '������� ��� �������������� ������� (#%s) �� �볺��� � %s', '', 1, '246');

    bars_error.add_message(l_mod, 247, l_exc, l_rus, '������ ��� ��������������� ������ � %s �� ������� � %s', '', 1, '247');
    bars_error.add_message(l_mod, 247, l_exc, l_ukr, '������� ��� �������������� ������ � %s �� �볺��� � %s', '', 1, '247');

    bars_error.add_message(l_mod, 248, l_exc, l_rus, '���������� ������� �������������� ���������� � %s � ����������� �������� � %s', '', 1, 'AGRMT_TERM_VETO');
    bars_error.add_message(l_mod, 248, l_exc, l_ukr, '��������� ������� ��������� ����� � %s �� ����������� �������� � %s', '', 1, 'AGRMT_TERM_VETO');

    bars_error.add_message(l_mod, 249, l_exc, l_rus, '���������� ������� �������������� ���������� � 3-�� ����� � %s � ����������� �������� � %s', '', 1, 'TRUST_TERM_VETO');
    bars_error.add_message(l_mod, 249, l_exc, l_ukr, '��������� ������� ��������� ����� ��� 3-�� ��� � %s �� ����������� �������� � %s', '', 1, 'TRUST_TERM_VETO');

    bars_error.add_message(l_mod, 250, l_exc, l_rus, '������ ��� ������� ������ �%s ��� %s/%s', '', 1, '250');
    bars_error.add_message(l_mod, 250, l_exc, l_ukr, '������� ��� ���������� ������ �%s ��� %s/%s', '', 1, '250');

    bars_error.add_message(l_mod, 251, l_exc, l_rus, '���������� ����� ������ �� ������ � %s �� %s', '', 1, '251');
    bars_error.add_message(l_mod, 251, l_exc, l_ukr, '��������� ������ ������ �� ������ � %s �� %s', '', 1, '251');

    bars_error.add_message(l_mod, 252, l_exc, l_rus, '�� ������� ������� ������ � %s �� ������ � %s', '', 1, '252');
    bars_error.add_message(l_mod, 252, l_exc, l_ukr, '�� �������� ������ ������ � %s �� ������ � %s', '', 1, '252');

    bars_error.add_message(l_mod, 253, l_exc, l_rus, '�� ������� ����� �������� ������� ������ � %s �� ������ � %s', '', 1, '253');
    bars_error.add_message(l_mod, 253, l_exc, l_ukr, '�� �������� ���� �������� ������ ������ � %s �� ������ � %s', '', 1, '253');

    bars_error.add_message(l_mod, 261, l_exc, l_rus, '��������� ���������� ������ �� �������������!', '', 1, '261');
    bars_error.add_message(l_mod, 261, l_exc, l_ukr, '��������� ���������� ������ �� �����������!', '', 1, '261');

    bars_error.add_message(l_mod, 262, l_exc, l_rus, '���� ������ ����� -> �������������� ���������� �������� ��������!', '', 1, '262');
    bars_error.add_message(l_mod, 262, l_exc, l_ukr, '����� ������ ��������� -> ������������� ���������� ���������� ��������!', '', 1, '262');

    bars_error.add_message(l_mod, 263, l_exc, l_rus, '������� �������� ������ �����������!', '', 1, '263');
    bars_error.add_message(l_mod, 263, l_exc, l_ukr, '������� �������� ����� �����������!', '', 1, '263');

    bars_error.add_message(l_mod, 264, l_exc, l_rus, '������ ���������� %% �� ����� %s/%s (#%s): %s', '', 1, 'MAKE_INT_ERROR');
    bars_error.add_message(l_mod, 264, l_exc, l_ukr, '������� ����������� %% �� ������� %s/%s (#%s): %s', '', 1, 'MAKE_INT_ERROR');

    bars_error.add_message(l_mod, 265, l_exc, l_rus, '�� ������ ���������� ���� �� �������� � %s', '', 1, 'DPTACC_NOT_FOUND');
    bars_error.add_message(l_mod, 265, l_exc, l_ukr, '�� ��������� ���������� ������� �� �������� � %s', '', 1, 'DPTACC_NOT_FOUND');

    bars_error.add_message(l_mod, 266, l_exc, l_rus, '�� ������ ���� ����������� ��������� �� �������� � %s', '', 1, 'INTACC_NOT_FOUND');
    bars_error.add_message(l_mod, 266, l_exc, l_ukr, '�� ��������� ������� ����������� ������� �� �������� � %s', '', 1, 'INTACC_NOT_FOUND');

    bars_error.add_message(l_mod, 267, l_exc, l_rus, '�� ������ ���� ���������� �������� �� �������� � %s', '', 1, 'ACC7_NOT_FOUND');
    bars_error.add_message(l_mod, 267, l_exc, l_ukr, '�� ��������� ������� ���������� ������� �� �������� � %s', '', 1, 'ACC7_NOT_FOUND');

    bars_error.add_message(l_mod, 268, l_exc, l_rus, '������ ������ ���������  : %s', '', 1, 'PAYDOC_ERROR');
    bars_error.add_message(l_mod, 268, l_exc, l_ukr, '������� ������ ��������� : %s', '', 1, 'PAYDOC_ERROR');

    bars_error.add_message(l_mod, 269, l_exc, l_rus, '���������� ��������� �������� ��������� ������ �� ��������� ����������� �������� � %s �� %s: �� ����� %s/%s ���� ���������������� ���������', '', 1, 'PENALTY_NOT_ALLOWED');
    bars_error.add_message(l_mod, 269, l_exc, l_ukr, '��������� �������� �������� ��������� ������ �� ���������� ������������ �������� � %s �� %s: �� ������� %s/%s � ���������� ���������', '', 1, 'PENALTY_NOT_ALLOWED');

    bars_error.add_message(l_mod, 271, l_exc, l_rus, '������ ������� ���������: %s', '', 1, 'PAYOUT_ERR');
    bars_error.add_message(l_mod, 271, l_exc, l_ukr, '������� ������ �������: %s', '', 1, 'PAYOUT_ERR');

    bars_error.add_message(l_mod, 291, l_exc, l_rus, '������ �������������� ��� �������� ������������ �����  #%s', '', 1, '291');
    bars_error.add_message(l_mod, 291, l_exc, l_ukr, '������� ��������� ��� �������� ��������� ������� #%s', '', 1, '291');

    bars_error.add_message(l_mod, 292, l_exc, l_rus, '����������� �������� ������������ ����� #%s', '', 1, '292');
    bars_error.add_message(l_mod, 292, l_exc, l_ukr, '����������� �������� ��������� ������� #%s', '', 1, '292');

    bars_error.add_message(l_mod, 293, l_exc, l_rus, '������ ��� ���������� ���� ��������� �������� ������������ �����  #%s', '', 1, '293');
    bars_error.add_message(l_mod, 293, l_exc, l_ukr, '������� ��� ��������� ���� ��������� �������� ��������� ������� #%s', '', 1, '293');

    bars_error.add_message(l_mod, 294, l_exc, l_rus, '���������� ������� ������-���������� ����.����� (ref = %s) � ����������-��������� (ref = %s)', '', 1, '294');
    bars_error.add_message(l_mod, 294, l_exc, l_ukr, '��������� ������� �����-���������� ����.������� (ref = %s) � ����������-����� (ref = %s)', '', 1, '294');

    bars_error.add_message(l_mod, 295, l_exc, l_rus, '�� ������ �������� ������������ ���������� ������������ �����, �������� = %s', '', 1, '295');
    bars_error.add_message(l_mod, 295, l_exc, l_ukr, '�� ��������� �������� ������������� ���������� ��������� �������, �������� = %s', '', 1, '295');

    bars_error.add_message(l_mod, 296, l_exc, l_rus, '�� ������� �������� �� ��������� �������� �� ����������� ���������� ������������ �����, �������� = %s', '', 1, '296');
    bars_error.add_message(l_mod, 296, l_exc, l_ukr, '�� �������� �������� �� ��������� ���� �� ����������� ���������� ��������� �������, �������� = %s', '', 1, '296');

    bars_error.add_message(l_mod, 297, l_exc, l_rus, '���������� ���������� ���������� �������� �� ��������� �������� �� ����������� ���������� ������������ �����, �������� = %s', '', 1, '297');
    bars_error.add_message(l_mod, 297, l_exc, l_ukr, '��������� ���������� ��������� �������� �� ��������� ������ �� ����������� ���������� ��������� �������, �������� = %s', '', 1, '297');

    bars_error.add_message(l_mod, 298, l_exc, l_rus, '���������� ���������� ����-���������� (���� �������) �� ������� �� �������� �������� %s', '', 1, '298');
    bars_error.add_message(l_mod, 298, l_exc, l_ukr, '��������� ��������� �������-��������� (������� ������) �� �������� � ������ �������� %s', '', 1, '298');

    bars_error.add_message(l_mod, 299, l_exc, l_rus, '�� ������ ����-���������� (���� �������) %s/%s', '', 1, '299');
    bars_error.add_message(l_mod, 299, l_exc, l_ukr, '�� ��������� �������-��������� (������� ������) %s/%s', '', 1, '299');

    bars_error.add_message(l_mod, 300, l_exc, l_rus, '�� ������� ������� ���������� ������� ��� �������� %s', '', 1, '300');
    bars_error.add_message(l_mod, 300, l_exc, l_ukr, '�� ������� ������� ����������� ������� ��� �������� %s', '', 1, '300');

    bars_error.add_message(l_mod, 301, l_exc, l_rus, '���������� ���������� ���������� ������� �� ������� �� �������� �������� %s (%s)', '', 1, '301');
    bars_error.add_message(l_mod, 301, l_exc, l_ukr, '��������� ��������� ����������� ������� �� �������� � ������ �������� %s (%s)', '', 1, '301');

    bars_error.add_message(l_mod, 302, l_exc, l_rus, '�� ������� ������� ���������� ����� �������� ��� �������� %s', '', 1, '302');
    bars_error.add_message(l_mod, 302, l_exc, l_ukr, '�� ������� ������� ���������� ���� ���� ��� �������� %s', '', 1, '302');

    bars_error.add_message(l_mod, 303, l_exc, l_rus, '���������� ���������� ����� �������� �� ������� �� �������� �������� %s', '', 1, '303');
    bars_error.add_message(l_mod, 303, l_exc, l_ukr, '��������� ��������� ���� ���� �� �������� � ������ �������� %s', '', 1, '303');

    bars_error.add_message(l_mod, 304, l_exc, l_rus, '������ �������������� (� �����) ��� ������� ����� �������� �� ������� �� �������� �������� (%s)', '', 1, '304');
    bars_error.add_message(l_mod, 304, l_exc, l_ukr, '������� ��� ����������� (� �����) ��� ���������� ���� ���� �� �������� � ������ �������� (%s)', '', 1, '304');

    bars_error.add_message(l_mod, 305, l_exc, l_rus, '������ ������ ��������� �� ��������� �������� �� ����������� ���������� ����.����� - %s', '', 1, '305');
    bars_error.add_message(l_mod, 305, l_exc, l_ukr, '������� ��� ����� ��������� �� �������� ���� �� ����������� ���������� ����.������� - %s', '', 1, '305');

    bars_error.add_message(l_mod, 311, l_exc, l_rus, '������ �������� (��� %s) ��� ������ � ���������� ��������� � %s', '', 1, '311');
    bars_error.add_message(l_mod, 311, l_exc, l_ukr, '����� �������� (��� %s) ��� ��''������ � ���������� ��������� � %s', '', 1, '311');

    bars_error.add_message(l_mod, 312, l_exc, l_rus, '���������� ������� �������� (��� %s) � ���������� ��������� � %s: %s', '', 1, '312');
    bars_error.add_message(l_mod, 312, l_exc, l_ukr, '��������� ��''����� �������� (��� %s) � ���������� ��������� � %s: %s', '', 1, '312');

    bars_error.add_message(l_mod, 313, l_exc, l_rus, '���������� ������������ �������� (��� %s) �� ����������� �������� � %s: %s', '', 1, 'DPT_KILLDOC_ERROR');
    bars_error.add_message(l_mod, 313, l_exc, l_ukr, '��������� ���������� �������� (��� %s) �� ����������� �������� � %s: %s', '', 1, 'DPT_KILLDOC_ERROR');

    bars_error.add_message(l_mod, 314, l_exc, l_rus, '��������� ������������� ��������� (��� %s) �� ����������� �������� � %s', '', 1, 'DPT_KILLDOC_DENIED');
    bars_error.add_message(l_mod, 314, l_exc, l_ukr, '���������� ����������� ��������� (��� %s) �� ����������� �������� � %s', '', 1, 'DPT_KILLDOC_DENIED');

    bars_error.add_message(l_mod, 320, l_exc, l_rus, '�� ������� ���. ���������� %s', '', 1, 'AGREEMENT_NOT_FOUND');
    bars_error.add_message(l_mod, 320, l_exc, l_ukr, '�� �������� ��������� ����� %s', '', 1, 'AGREEMENT_NOT_FOUND');

    bars_error.add_message(l_mod, 321, l_exc, l_rus, '���������� ������������ ���.���������� � %s �� %s � �������� � %s (������ - %s, �������� %s, ��� �� - %s, ���-�� �����.���-��� - %s)', '', 1, 'CANT_REVERSE_AGREEMENT');
    bars_error.add_message(l_mod, 321, l_exc, l_ukr, '��������� ���������� ��������� ����� � %s �� %s �� �������� � %s(������ - %s, ��������� %s, ��� �� - %s, ��-�� �����.���-�� - %s)', '', 1, 'CANT_REVERSE_AGREEMENT');

    bars_error.add_message(l_mod, 322, l_exc, l_rus, '���. ���������� %s ������������. �� ������� ����������, ������� ���������� ������.', '', 1, 'INCORRECT_CANCEL_AGREEMENT');
    bars_error.add_message(l_mod, 322, l_exc, l_ukr, '��������� ����� %s ����������. �� �������� �����, �� ����������� �����.', '', 1, 'INCORRECT_CANCEL_AGREEMENT');

    bars_error.add_message(l_mod, 323, l_exc, l_rus, '�� ������ ������ � %s', '', 1, 'CUST_NOT_FOUND');
    bars_error.add_message(l_mod, 323, l_exc, l_ukr, '�� ��������� �볺�� � %s', '', 1, 'CUST_NOT_FOUND');

    bars_error.add_message(l_mod, 324, l_exc, l_rus, '������ � ��������� ���� (��. = %s) �� �������.', '', 1, 'TRUSTEE_NOT_FOUND');
    bars_error.add_message(l_mod, 324, l_exc, l_ukr, '����� ��� ������� ����� (��. = %s) �� ��������.', '', 1, 'TRUSTEE_NOT_FOUND');

    bars_error.add_message(l_mod, 325, l_exc, l_rus, '������ ������������� ��������� � %s : %s', '', 1, 'BACK_DOC_ERROR');
    bars_error.add_message(l_mod, 325, l_exc, l_ukr, '������� ����������� ��������� � %s : %s', '', 1, 'BACK_DOC_ERROR');

    bars_error.add_message(l_mod, 339, l_exc, l_rus, '�� ����� ������� ������ �� ������� �������� ����������', '', 1, 'INVALID_INHERIT_INCOME');
    bars_error.add_message(l_mod, 339, l_exc, l_ukr, '�� ������� ������ ������ �� ������ �������� ���������', '', 1, 'INVALID_INHERIT_INCOME');

    bars_error.add_message(l_mod, 340, l_exc, l_rus, '�� ������ ��������� ������������� � ����� �� ����������', '', 1, 'INVALID_INHERIT_CERT');
    bars_error.add_message(l_mod, 340, l_exc, l_ukr, '�� ����� �������� �������� ��� ����� �� ������', '', 1, 'INVALID_INHERIT_CERT');

    bars_error.add_message(l_mod, 341, l_exc, l_rus, '�� ������ ��������� ���������� (���� � ���� ���������� � ����� ������������)', '', 1, 'INVALID_INHERIT_PARAMS');
    bars_error.add_message(l_mod, 341, l_exc, l_ukr, '�� ����� �������� ��������� (���� � ���� ���������� � ����� �����������)', '', 1, 'INVALID_INHERIT_PARAMS');

    bars_error.add_message(l_mod, 342, l_exc, l_rus, '�� ������� ������ � ���������� � %s �� �������� � %s', '', 1, 'INHERITOR_NOT_FOUND');
    bars_error.add_message(l_mod, 342, l_exc, l_ukr, '�� ��������� ����� ��� ��������� � %s �� �������� � %s', '', 1, 'INHERITOR_NOT_FOUND');

    bars_error.add_message(l_mod, 343, l_exc, l_rus, '������ ��������� ���������� ���������� � %s �� �������� � %s', '', 1, 'INHERIT_UPDATE_FAILED');
    bars_error.add_message(l_mod, 343, l_exc, l_ukr, '������� ���� �������� ��������� � %s �� �������� � %s', '', 1, 'INHERIT_UPDATE_FAILED');

    bars_error.add_message(l_mod, 344, l_exc, l_rus, '������� ������ ���� ������������ �� �������� � %s', '', 1, 'INVALID_INHERIT_SHARE');
    bars_error.add_message(l_mod, 344, l_exc, l_ukr, '������ ����� ������ ������ �� �������� � %s', '', 1, 'INVALID_INHERIT_SHARE');

    bars_error.add_message(l_mod, 345, l_exc, l_rus, '��������� � %s ��� �� ������� � ����� ������������ �������� � %s', '', 1, 'INHERIT_NOT_ACTIVE');
    bars_error.add_message(l_mod, 345, l_exc, l_ukr, '���������� �� �� ������� � ����� ����������� �������� � %s', '', 1, 'INHERIT_NOT_ACTIVE');

    bars_error.add_message(l_mod, 346, l_exc, l_rus, '���������� ��������� ���������� ����� ������� �� ����� %s / %s - ���� ���������.���������', '', 1, 'INHERIT_CALC_DENIED');
    bars_error.add_message(l_mod, 346, l_exc, l_ukr, '��������� ����������� ��������� ���� ������� �� ������� %s / %s - � ������.���������', '', 1, 'INHERIT_CALC_DENIED');

    bars_error.add_message(l_mod, 347, l_exc, l_rus, '���������� ���������� ������� �� ����� %s / %s �� %s', '', 1, 'SALDO_CALC_ERROR');
    bars_error.add_message(l_mod, 347, l_exc, l_ukr, '��������� ��������� ������� �� ������� %s / %s �� %s', '', 1, 'SALDO_CALC_ERROR');

    bars_error.add_message(l_mod, 348, l_exc, l_rus, '��������� ��� ������� � ����� ������������, ��������� ���������� �����������', '', 1, 'INHERIT_UPDATE_DENIED');
    bars_error.add_message(l_mod, 348, l_exc, l_ukr, '���������� ��� ������� � ����� �����������, ���� �������� ������������', '', 1, 'INHERIT_UPDATE_DENIED');

    bars_error.add_message(l_mod, 349, l_exc, l_rus, '������������� � ����� ������������ �������� � %s ��� ������������', '', 1, 'INHERIT_ALREADY_ACTIVATED');
    bars_error.add_message(l_mod, 349, l_exc, l_ukr, '�������� ��� ����� ����������� �������� � %s ��� ����������', '', 1, 'INHERIT_ALREADY_ACTIVATED');

    bars_error.add_message(l_mod, 350, l_exc, l_rus, '������ ��������� ������������� � ������ ������������ �������� � %s', '', 1, 'INHERIT_ACTIVATION_FAILED');
    bars_error.add_message(l_mod, 350, l_exc, l_ukr, '������� ���������� �������� ��� ����� ����������� �������� � %s', '', 1, 'INHERIT_ACTIVATION_FAILED');

    bars_error.add_message(l_mod, 351, l_exc, l_rus, '���� ���������� � ����� ������ ���� ������ ���� ������ �������������!', '', 1, 'INVALID_INHERIT_DATES');
    bars_error.add_message(l_mod, 351, l_exc, l_ukr, '���� ������ � ����� �� ���� ����� �� ���� ������ ��������!', '', 1, 'INVALID_INHERIT_DATES');

    bars_error.add_message(l_mod, 352, l_exc, l_rus, '�� ������� ��� ���������  ������ ������!', '', 1, 'INVALID_TAX_DETAILS');
    bars_error.add_message(l_mod, 352, l_exc, l_ukr, '�� ������� �� �������� �������� ��� ������ �������!', '', 1, 'INVALID_TAX_DETAILS');

    bars_error.add_message(l_mod, 353, l_exc, l_rus, '�� ������� ��������� ��� ������ ������ �� ��������������: %s', '', 1, 'NOT_FOUND_TAX_TRANSFER_DETAILS');
    bars_error.add_message(l_mod, 353, l_exc, l_ukr, '�� �������� �������� ��� ������������� ������� �� ���������: %s', '', 1, 'NOT_FOUND_TAX_TRANSFER_DETAILS');

    bars_error.add_message(l_mod, 354, l_exc, l_rus, '��������� �������������� ���� ������������� (���� ����������� ��������)', '', 1, 'BRANCH_EDIT_DENIED');
    bars_error.add_message(l_mod, 354, l_exc, l_ukr, '���������� ����������� ���� �������� (������� �������� ��������)', '', 1, 'BRANCH_EDIT_DENIED');

    bars_error.add_message(l_mod, 355, l_exc, l_rus, '��������� �������������� ���� ���������� ����� ���������� �����!', '', 1, 'BLK_EDIT_DENIED');
    bars_error.add_message(l_mod, 355, l_exc, l_ukr, '���������� ����������� ���� ���������� ������� ��������� ��!', '', 1, 'BLK_EDIT_DENIED');

    bars_error.add_message(l_mod, 369, l_exc, l_rus, '������ �������� ��� ����������� ������ - %s', '', 1, 'INVALID_PENALTY_MODCODE');
    bars_error.add_message(l_mod, 369, l_exc, l_ukr, '�������� ������� ��� ����������� ������ - %s', '', 1, 'INVALID_PENALTY_MODCODE');

    bars_error.add_message(l_mod, 370, l_exc, l_rus, '������ ����������� ��� ������� �������� - %s', '', 1, 'INVALID_PENALTY_TYPE');
    bars_error.add_message(l_mod, 370, l_exc, l_ukr, '�������� �������� ��� ������� �������� - %s', '', 1, 'INVALID_PENALTY_TYPE');

    bars_error.add_message(l_mod, 371, l_exc, l_rus, '������ ����������� ����� ���������� ��������� - %s', '', 1, 'INVALID_PENALTY_MODE');
    bars_error.add_message(l_mod, 371, l_exc, l_ukr, '�������� �������� ����� ��������� ��������� - %s', '', 1, 'INVALID_PENALTY_MODE');

    bars_error.add_message(l_mod, 372, l_exc, l_rus, '������ ������ ��� �������� � %s ������������: %s', '', 1, 'PENALTY_DENIED');
    bars_error.add_message(l_mod, 372, l_exc, l_ukr, '���������� ������ ��� �������� � %s �����������: %s', '', 1, 'PENALTY_DENIED');

    bars_error.add_message(l_mod, 373, l_exc, l_rus, '������ ������� �������� ������ ��� �������� � %s', '', 1, 'PENALTY_RATE_NOT_FOUND');
    bars_error.add_message(l_mod, 373, l_exc, l_ukr, '������� ���������� ������� ������ ��� �������� � %s', '', 1, 'PENALTY_RATE_NOT_FOUND');

    bars_error.add_message(l_mod, 374, l_exc, l_rus, '�������� �������������: ����� �������� � %s ����� ������ ��������� ����� (%s), �������� �������� (%s + %s) � �������� ������� ������.��������� (%s) ������ ���������� ���������� (%s)', '', 1, 'PENALTY_EXCESSAMOUNT');
    bars_error.add_message(l_mod, 374, l_exc, l_ukr, '�������� �����������: ���� �������� � %s ���� ������ ������� ���� (%s), ��������� ����� (%s + %s) � ���������� ����� �����.������� (%s) ����� �������� ��������� (%s)', '', 1, 'PENALTY_EXCESSAMOUNT');

    bars_error.add_message(l_mod, 375, l_exc, l_rus, '��� ������ � %s �� %s (� %s) �� ������������� ��������� ���������� ���������', '', 1, 'ADVANCE_MAKEINT_DENIED');
    bars_error.add_message(l_mod, 375, l_exc, l_ukr, '��� ������ � %s �� %s (� %s) �� ����������� �������� ����������� �������', '', 1, 'ADVANCE_MAKEINT_DENIED');

    bars_error.add_message(l_mod, 376, l_exc, l_rus, '������ ���������� ���������� ��������� �� ������ � %s �� %s (� %s): %s', '', 1, 'ADVANCE_MAKEINT_FAILED');
    bars_error.add_message(l_mod, 376, l_exc, l_ukr, '������� ���������� ����������� ������� �� ������ � %s �� %s (� %s): %s', '', 1, 'ADVANCE_MAKEINT_FAILED');

    bars_error.add_message(l_mod, 377, l_exc, l_rus, '����� �� �������������� ������ �%s �������� ������ �� %s ����� ������', '', 1, 'FIX_EXTCANCEL_DENIED');
    bars_error.add_message(l_mod, 377, l_exc, l_ukr, '³����� �� �������������� ������ �%s ��������� ���� �� %s ����� �����', '', 1, 'FIX_EXTCANCEL_DENIED');

    bars_error.add_message(l_mod, 378, l_exc, l_rus, '������ �� ����� ������� �� �������������� ������ �%s �� %s (%s) ��� �����������', '', 1, 'FIX_EXTCANCEL_DUPLICATE');
    bars_error.add_message(l_mod, 378, l_exc, l_ukr, '����� �� ������ �볺��� �� �������������� ������ �%s �� %s (%s) ��� �����������', '', 1, 'FIX_EXTCANCEL_DUPLICATE');

    bars_error.add_message(l_mod, 379, l_exc, l_rus, '������ ������������ ������� �� ����� ������� �� �������������� ������ �%s �� %s (%s): %s', '', 1, 'FIX_EXTCANCEL_FAILED');
    bars_error.add_message(l_mod, 379, l_exc, l_ukr, '������� ���������� ������ �� ������ �볺��� �� �������������� ������ �%s �� %s (%s): %s', '', 1, 'FIX_EXTCANCEL_FAILED');

    bars_error.add_message(l_mod, 380, l_exc, l_rus, '������ �������������� �������� �%s (%s): %s', '', 1, 'AUTOEXT_FAILED');
    bars_error.add_message(l_mod, 380, l_exc, l_ukr, '������� �������������� �������� �%s (%s): %s', '', 1, 'AUTOEXT_FAILED');

    bars_error.add_message(l_mod, 381, l_exc, l_rus, '������ ��������� ������ ��� ���������������� ��������� ������������� %s (��� %s, ��������� %s, ���.� %s): %s', '', 1, 'AUTOEXTBONUS_FAILED');
    bars_error.add_message(l_mod, 381, l_exc, l_ukr, '������� ������������ ������ ��� ������������� �������� �������� %s (��� %s, ��������� %s, ���.� %s): %s', '', 1, 'AUTOEXTBONUS_FAILED');

    bars_error.add_message(l_mod, 382, l_exc, l_rus, '�� ������� ��������� ������� ������ ��� ������ ����������� � %s', '', 1, 'EXTBONUS_TYPE_NOT_FOUND');
    bars_error.add_message(l_mod, 382, l_exc, l_ukr, '�� �������� ��������� ���������� ������ ��� ������ ����������� � %s', '', 1, 'EXTBONUS_TYPE_NOT_FOUND');

    bars_error.add_message(l_mod, 383, l_exc, l_rus, '�� ������� ����� ��� ���������� ������ �� ����������� �������� � %s �� %s (%s)', '', 1, 'EXTBONUS_PAYACC_NOT_FOUND');
    bars_error.add_message(l_mod, 383, l_exc, l_ukr, '�� �������� ������� ��� ����������� ������ �� ����������� �������� � %s �� %s (%s)', '', 1, 'EXTBONUS_PAYACC_NOT_FOUND');

    bars_error.add_message(l_mod, 384, l_exc, l_rus, '������ ������ ��������� �� ���������� ������ �� ����������� �������� � %s �� %s (%s): %s', '', 1, 'EXTBONUS_PAYDOC_FAILED');
    bars_error.add_message(l_mod, 384, l_exc, l_ukr, '������� ������ ��������� �� ����������� ������ �� ����������� �������� � %s �� %s (%s): %s', '', 1, 'EXTBONUS_PAYDOC_FAILED');

    bars_error.add_message(l_mod, 385, l_exc, l_rus, '������ ������� � ���������� ������ �� ����������� �������� � %s �� %s (%s): %s', '', 1, 'EXTBONUS_FAILED');
    bars_error.add_message(l_mod, 385, l_exc, l_ukr, '������� ���������� � ����������� ������ �� ����������� �������� � %s �� %s (%s): %s', '', 1, 'EXTBONUS_FAILED');

    bars_error.add_message(l_mod, 386, l_exc, l_rus, '������ ���������� ��������� R013 ��� ������ �� ������ � %s: %s', '', 1, 'SYNCR013_FAILED');
    bars_error.add_message(l_mod, 386, l_exc, l_ukr, '������� ��������� ��������� R013 ��� ������� �� ������ � %s: %s', '', 1, 'SYNCR013_FAILED');

    bars_error.add_message(l_mod, 387, l_exc, l_rus, '�� ������ �������������� ������ �� ����� ������� �� �������������� ������ � %s �� %s (%s)', '', 1, 'VERIFY_EXTCANCEL_NOT_FOUND');
    bars_error.add_message(l_mod, 387, l_exc, l_ukr, '�� ��������� ������������ ����� �� ������ ������ �� �������������� ������ � %s �� %s (%s)', '', 1, 'VERIFY_EXTCANCEL_NOT_FOUND');

    bars_error.add_message(l_mod, 388, l_exc, l_rus, '������ �� ����� ������� �� �������������� ������ � %s �� %s (%s) ������ ���� ����������� ��.�������������', '', 1, 'VERIFY_EXTCANCEL_DENIED');
    bars_error.add_message(l_mod, 388, l_exc, l_ukr, '����� �� ������ �볺��� �� �������������� ������ � %s �� %s (%s) ������� ���� ������������ ���.������������', '', 1, 'VERIFY_EXTCANCEL_DENIED');

    bars_error.add_message(l_mod, 389, l_exc, l_rus, '������������ ������ (%s) ������� �� ����� ������� �� �������������� ������ � %s �� %s (%s)', '', 1, 'VERIFY_EXTCANCEL_INVALIDSTATE');
    bars_error.add_message(l_mod, 389, l_exc, l_ukr, '����������� ������ (%s) ������ �� ������ �볺��� �� �������������� ������ � %s �� %s (%s)', '', 1, 'VERIFY_EXTCANCEL_INVALIDSTATE');

    bars_error.add_message(l_mod, 390, l_exc, l_rus, '������ ������������� ������� �� ����� ��������� �� �������������� ������ � %s �� %s (%s): %s', '', 1, 'VERIFY_EXTCANCEL_FAILED');
    bars_error.add_message(l_mod, 390, l_exc, l_ukr, '������� ������������ ������ �� ������ ������ �� �������������� ������ � %s �� %s (%s): %s', '', 1, 'VERIFY_EXTCANCEL_FAILED');

    bars_error.add_message(l_mod, 391, l_exc, l_rus, '������� ��������/������� ��������� �������������: ��������� ����������� ������ � %s', '', 1, 'DEPRETURN_DENID');
    bars_error.add_message(l_mod, 391, l_exc, l_ukr, '��������� ��������/������� ������� �����������: ��������� ����������� ������ � %s', '', 1, 'DEPRETURN_DENID');

    bars_error.add_message(l_mod, 392, l_exc, l_rus, '��� ���������� %% ������ ��� ������������������ ������ ������ ����������� ����� � ����� %s.', '', 1, 'INVALID_EXTENSION_METHOD');
    bars_error.add_message(l_mod, 392, l_exc, l_ukr, '��� ���������� %% ������ ��� ����������������� �������� ������� �������� ����� � ����� %s.', '', 1, 'INVALID_EXTENSION_METHOD');

    bars_error.add_message(l_mod, 393, l_exc, l_rus, '�� ������� �� � %% ������� ��� ������������������ ������ � %s.', '', 1, 'EXTENSION_RATE_NOT_FOUND');
    bars_error.add_message(l_mod, 393, l_exc, l_ukr, '�� �������� �� � %% ������� ��� ������������������ �������� � %s.', '', 1, 'EXTENSION_RATE_NOT_FOUND');

    bars_error.add_message(l_mod, 401, l_exc, l_rus, '�� ������� ��������: %s', '', 1, 'TT_NOT_FOUND');
    bars_error.add_message(l_mod, 401, l_exc, l_ukr, '�� �������� ��������: %s', '', 1, 'TT_NOT_FOUND');

    bars_error.add_message(l_mod, 402, l_exc, l_rus, '������ ���������� ������� �����: %s', '', 1, 'SUM_EVAL_ERR');
    bars_error.add_message(l_mod, 402, l_exc, l_ukr, '������� ���������� ������� ����: %s', '', 1, 'SUM_EVAL_ERR');

    bars_error.add_message(l_mod, 403, l_exc, l_rus, '����������� ����� ��� ���������� (%s)', '', 1, 'CTRLDEPAMNT_INVALID_MODE');
    bars_error.add_message(l_mod, 403, l_exc, l_ukr, '�������� ����� ��������� (%s)', '', 1, 'CTRLDEPAMNT_INVALID_MODE');

    bars_error.add_message(l_mod, 404, l_exc, l_rus, '���������� ������������ ����� ��������', '', 1, 'CTRLDEPAMNT_BROKEN_LIMIT');
    bars_error.add_message(l_mod, 404, l_exc, l_ukr, '����������� ����������� ���� ��������', '', 1, 'CTRLDEPAMNT_BROKEN_LIMIT');

    bars_error.add_message(l_mod, 405, l_exc, l_rus, '������ �������� ����� ������������� ������ � %s: %s', '', 1, 'CTRLDEPAMNT_FAILED');
    bars_error.add_message(l_mod, 405, l_exc, l_ukr, '������� �������� ���� ���������� ������ � %s: %s', '', 1, 'CTRLDEPAMNT_FAILED');

    bars_error.add_message(l_mod, 410, l_exc, l_rus, '%s', '', 1, 'BONUS_CHECK_ERROR');
    bars_error.add_message(l_mod, 410, l_exc, l_ukr, '%s', '', 1, 'BONUS_CHECK_ERROR');

    bars_error.add_message(l_mod, 411, l_exc, l_rus, '������ ���������� ���������� �������� ������ �%s - %s � ���� ������ � %s: %s', '', 1, 'BONUS_CHECK_FAILED');
    bars_error.add_message(l_mod, 411, l_exc, l_ukr, '������� ���������� ��������� ����''���� ����� �%s - %s �� ���� ������ � %s: %s', '', 1, 'BONUS_CHECK_FAILED');

    bars_error.add_message(l_mod, 412, l_exc, l_rus, ' %s', '', 1, 'BONUS_CALC_ERROR');
    bars_error.add_message(l_mod, 412, l_exc, l_ukr, ' %s', '', 1, 'BONUS_CALC_ERROR');

    bars_error.add_message(l_mod, 413, l_exc, l_rus, '������ ���������� ������� ������ �%s - %s: %s', '', 1, 'BONUS_CALC_FAILED');
    bars_error.add_message(l_mod, 413, l_exc, l_ukr, '������� ���������� ������ ����� �%s - %s: %s', '', 1, 'BONUS_CALC_FAILED');

    bars_error.add_message(l_mod, 414, l_exc, l_rus, '������ ������ ������� �� ��������� ������ � %s �� �������� �%s: %s', '', 1, 'FIX_BONUS_REQUEST_ERROR');
    bars_error.add_message(l_mod, 414, l_exc, l_ukr, '������� ������ ������ �� ��������� ����� � %s �� �������� �%s: %s', '', 1, 'FIX_BONUS_REQUEST_ERROR');

    bars_error.add_message(l_mod, 415, l_exc, l_rus, '������ ������� �������� �� ��������� ������ � ������� �������� �� �������� � %s: %s', '', 1, 'INS_BONUS_QUERY_ERROR');
    bars_error.add_message(l_mod, 415, l_exc, l_ukr, '������� ������ ������ �� ��������� ����� � ����� ������ �� �������� � %s: %s', '', 1, 'INS_BONUS_QUERY_ERROR');

    bars_error.add_message(l_mod, 416, l_exc, l_rus, '� ������� �������� �� ��������� ����� �� ������� ���-��� �� �������� � %s', '', 1, 'BONUS_REQUE_NOT_FOUND');
    bars_error.add_message(l_mod, 416, l_exc, l_ukr, '� ���� ������ �� ��������� ���� �� �������� ���-��� �� �������� � %s', '', 1, 'BONUS_REQUE_NOT_FOUND');

    bars_error.add_message(l_mod, 417, l_exc, l_rus, '������ �������� �������� �� ��������� ������ �� �������� � %s �� ������� ��������: %s', '', 1, 'DEL_BONUS_QUERY_ERROR');
    bars_error.add_message(l_mod, 417, l_exc, l_ukr, '������� ��������� ������ �� ��������� ���� �� �������� � %s � ����� ������: %s', '', 1, 'DEL_BONUS_QUERY_ERROR');

    bars_error.add_message(l_mod, 418, l_exc, l_rus, '%s', '', 1, 'BONUS_EXCLUSION_ERROR');
    bars_error.add_message(l_mod, 418, l_exc, l_ukr, '%s', '', 1, 'BONUS_EXCLUSION_ERROR');

    bars_error.add_message(l_mod, 419, l_exc, l_rus, '������ ��� ���������� ��������� ���������� ����� �� �������� � %s: %s', '', 1, 'BONUS_EXCLUSION_FAILED');
    bars_error.add_message(l_mod, 419, l_exc, l_ukr, '������� ��� �������� ��������� ���������� ���� �� �������� � %s: %s', '', 1, 'BONUS_EXCLUSION_FAILED');

    bars_error.add_message(l_mod, 420, l_exc, l_rus, '������ ���������� ��������� ������ � %s � ���� �������� � %s (���� %s): %s', '', 1, 'ADD_VIDD2BONUS_FAILED');
    bars_error.add_message(l_mod, 420, l_exc, l_ukr, '������� ��������� ����''����� ����� � %s �� ���� �������� � %s (���� %s): %s', '', 1, 'ADD_VIDD2BONUS_FAILED');

    bars_error.add_message(l_mod, 421, l_exc, l_rus, '�� ������ ������ �� ��������� ������ � %s �� �������� � %s', '', 1, 'BONUS_REQUEST_NOT_FOUND');
    bars_error.add_message(l_mod, 421, l_exc, l_ukr, '�� ��������� ����� �� ��������� ����� � %s �� �������� � %s', '', 1, 'BONUS_REQUEST_NOT_FOUND');

    bars_error.add_message(l_mod, 422, l_exc, l_rus, '��������� �������� ������� �� ��������� ������ � %s �� �������� � %s (������ = %s, ���� ������������� = %s)', '', 1, 'INVALID_BONUS_REQUEST_4DEL');
    bars_error.add_message(l_mod, 422, l_exc, l_ukr, '���������� ��������� ������ �� ��������� ����� � %s �� �������� � %s (������ = %s, ���� ������������ = %s)', '', 1, 'INVALID_BONUS_REQUEST_4DEL');

    bars_error.add_message(l_mod, 423, l_exc, l_rus, '������ �������� ������� �� ��������� ������ � %s �� �������� � %s: %s', '', 1, 'BONUS_REQUEST_DEL_ERROR');
    bars_error.add_message(l_mod, 423, l_exc, l_ukr, '������� ��������� ������ �� ��������� ����� � %s �� �������� � %s: %s', '', 1, 'BONUS_REQUEST_DEL_ERROR');

    bars_error.add_message(l_mod, 424, l_exc, l_rus, '���������� ���������� �������� ������: �� �������� � %s ���� �������������� �������', '', 1, 'DPT_BONUS_IN_WORK');
    bars_error.add_message(l_mod, 424, l_exc, l_ukr, '��������� ����������� ��������� �����: �� ��������  � %s � ���������� ������', '', 1, 'DPT_BONUS_IN_WORK');

    bars_error.add_message(l_mod, 425, l_exc, l_rus, '�� ������� ������� %-��� ������ �� �������� � %s �� %s', '', 1, 'DPT_RATE_NOT FOUND');
    bars_error.add_message(l_mod, 425, l_exc, l_ukr, '�� �������� ������ %-�� ������ �� �������� � %s �� %s', '', 1, 'DPT_RATE_NOT FOUND');

    bars_error.add_message(l_mod, 426, l_exc, l_rus, '���������� ���������� �������� %-��� ������ �� �������� � %s (������ = %s, ���� = %s)', '', 1, 'SET_BONUS_RATE_FAILED');
    bars_error.add_message(l_mod, 426, l_exc, l_ukr, '��������� ���������� ������� %-�� ������ �� �������� � %s (����� = %s, ���� = %s)', '', 1, 'SET_BONUS_RATE_FAILED');

    bars_error.add_message(l_mod, 427, l_exc, l_rus, '������������� ������� �� ��������� ������ � %s �� �������� � %s ����������� (������ = %s, �����-�� ���������. = %s, ������� ����. = %s, ����.����. = %s)', '', 1, 'INVALID_BONUS_REQUEST_2CONFIRM');
    bars_error.add_message(l_mod, 427, l_exc, l_ukr, 'ϳ����������� ������ �� ��������� ����� � %s �� �������� � %s ������������ (������ = %s, �����-�� ���������. = %s, ������� ����. = %s, ����.����. = %s)', '', 1, 'INVALID_BONUS_REQUEST_2CONFIRM');

    bars_error.add_message(l_mod, 428, l_exc, l_rus, '������ ������������� ������� �� ��������� ������ � %s �� �������� � %s: %s', '', 1, 'BONUS_REQUEST_CONFIRM_ERROR');
    bars_error.add_message(l_mod, 428, l_exc, l_ukr, '������� ������������ ������ �� ��������� ����� � %s �� �������� � %s: %s', '', 1, 'BONUS_REQUEST_CONFIRM_ERROR');

    bars_error.add_message(l_mod, 429, l_exc, l_rus, '������ ����������� ������� ������ � %s-%s �� �������� � %s: %s', '', 1, 'BONUS_RECALC_FAILED');
    bars_error.add_message(l_mod, 429, l_exc, l_ukr, '������� ����������� ������ ����� � %s-%s �� �������� � %s: %s', '', 1, 'BONUS_RECALC_FAILED');

    bars_error.add_message(l_mod, 430, l_exc, l_rus, '������ ���������� ����������������� �������� ������ � %s �� �������� � %s: %s', '', 1, 'BONUS_RECALC_ERROR');
    bars_error.add_message(l_mod, 430, l_exc, l_ukr, '������� ���������� �������������� �������� ����� � %s �� �������� � %s: %s', '', 1, 'BONUS_RECALC_ERROR');

    bars_error.add_message(l_mod, 431, l_exc, l_rus, '���� �������������� ������ � �������� ������� � %s �� ��������� ����� �� �������� � %s', '', 1, 'BONUS_QUERY_DISBALANCE');
    bars_error.add_message(l_mod, 431, l_exc, l_ukr, '� ���������� ������ � ��������� ����� � %s �� ��������� ���� �� �������� � %s', '', 1, 'BONUS_QUERY_DISBALANCE');

    bars_error.add_message(l_mod, 500, l_exc, l_rus, '������� � ����� � %s �� ������� � ����������� �������������� ��������!', '', 1, '500');
    bars_error.add_message(l_mod, 500, l_exc, l_ukr, '�������� � ����� � %s �� ������� � �������� ������������ ��������!', '', 1, '500');

    bars_error.add_message(l_mod, 501, l_exc, l_rus, '������ ��� ������ � ������ ���������� ������� � %s - %s', '', 1, '501');
    bars_error.add_message(l_mod, 501, l_exc, l_ukr, '������� ��� ������ � ������ ��������� �������� � %s - %s', '', 1, '501');

    bars_error.add_message(l_mod, 502, l_exc, l_rus, '�� ������� ������� � %s', '', 1, 'JOB_RUNID_NOT_FOUND');
    bars_error.add_message(l_mod, 502, l_exc, l_ukr, '�� �������� �������� � %s', '', 1, 'JOB_RUNID_NOT_FOUND');

    bars_error.add_message(l_mod, 503, l_exc, l_rus, '������ ������ � ������ ���������� ������� � %s ���������� �� �������� � %s - %s', '', 1, '503');
    bars_error.add_message(l_mod, 503, l_exc, l_ukr, '������� ������ � ������ ��������� �������� � %s ���������� �� �������� � %s - %s', '', 1, '503');

    bars_error.add_message(l_mod, 504, l_exc, l_rus, '������ �������� ��������� ���������� ������� � %s - %s', '', 1, '504');
    bars_error.add_message(l_mod, 504, l_exc, l_ukr, '������� �������� ��������� ��������� �������� � %s - %s', '', 1, '504');

    bars_error.add_message(l_mod, 505, l_exc, l_rus, '������ ������������ ������� ���������� �������������� �������� ��� OFFLINE-��������� - %s', '', 1, '505');
    bars_error.add_message(l_mod, 505, l_exc, l_ukr, '������� ���������� ����� ��������� ������������ �������� ��� OFFLINE-������� - %s', '', 1, '505');

    bars_error.add_message(l_mod, 506, l_exc, l_rus, '�� ������� �������������� ������� � %s ��� OFFLINE-��������� � %s', '', 1, '506');
    bars_error.add_message(l_mod, 506, l_exc, l_ukr, '�� �������� ����������� �������� � %s ��� OFFLINE-�������� � %s', '', 1, '506');

    bars_error.add_message(l_mod, 510, l_exc, l_rus, '�������������� ������� � ����� %s �� ������� � ����������� �������������� ��������!', '', 1, 'JOB_NOT_FOUND');
    bars_error.add_message(l_mod, 510, l_exc, l_ukr, '����������� �������� � ����� %s �� ������� � �������� ������������ ��������!', '', 1, 'JOB_NOT_FOUND');

    bars_error.add_message(l_mod, 511, l_exc, l_rus, '������ �������� �������� ��� �������� ���� ������ � %s: %s', '', 1, 'GEN_EXPDPTYPE_FAILED');
    bars_error.add_message(l_mod, 511, l_exc, l_ukr, '������� ��������� ������� ��� �������� ���� ������ � %s: %s', '', 1, 'GEN_EXPDPTYPE_FAILED');

    bars_error.add_message(l_mod, 520, l_exc, l_rus, '����������� ��� ������� %s', '', 1, 'REQTYPE_NOT_FOUND');
    bars_error.add_message(l_mod, 520, l_exc, l_ukr, '�������� ��� ������ %s', '', 1, 'REQTYPE_NOT_FOUND');

    bars_error.add_message(l_mod, 521, l_exc, l_rus, '������ � �����. %s �� ������', '', 1, 'REQUEST_NOT_FOUND');
    bars_error.add_message(l_mod, 521, l_exc, l_ukr, '����� � �����. %s �� ��������', '', 1, 'REQUEST_NOT_FOUND');

    bars_error.add_message(l_mod, 522, l_exc, l_rus, '������ � �����. %s ��� ���������', '', 1, 'REQUEST_PROCESSED');
    bars_error.add_message(l_mod, 522, l_exc, l_ukr, '����� � �����. %s ��� ���������', '', 1, 'REQUEST_PROCESSED');

    bars_error.add_message(l_mod, 523, l_exc, l_rus, '�������� ���. �������� %s ����������', '', 1, 'DELETE_DEAL_DISALLOWED');
    bars_error.add_message(l_mod, 523, l_exc, l_ukr, '��������� ���. �������� %s ���������', '', 1, 'DELETE_DEAL_DISALLOWED');

    bars_error.add_message(l_mod, 524, l_exc, l_rus, '���������� ���������� ������������, ���������� ���.������� %s', '', 1, 'DPTCREATOR_NOT_EXISTS');
    bars_error.add_message(l_mod, 524, l_exc, l_ukr, '��������� ������ �����������, ���� ������� ������', '', 1, 'DPTCREATOR_NOT_EXISTS');

    bars_error.add_message(l_mod, 525, l_exc, l_rus, '������������ ��� ��������� ������', '', 1, 'REQUEST_USER_CHECK_PUT');
    bars_error.add_message(l_mod, 525, l_exc, l_ukr, '���������� ��� ������� �����', '', 1, 'REQUEST_USER_CHECK_PUT');

    bars_error.add_message(l_mod, 526, l_exc, l_rus, '������ �� �����������', '', 1, 'CANCEL_COMMIS_REFUSED');
    bars_error.add_message(l_mod, 526, l_exc, l_ukr, '����� �� ������������', '', 1, 'CANCEL_COMMIS_REFUSED');

    bars_error.add_message(l_mod, 527, l_exc, l_rus, '��� ������� ���� ���.���������� �������� �����������', '', 1, 'REQUIRED_COMMISSDOC');
    bars_error.add_message(l_mod, 527, l_exc, l_ukr, '��� ������ ���� ���.����� ����� ����''������', '', 1, 'REQUIRED_COMMISSDOC');

    bars_error.add_message(l_mod, 528, l_exc, l_rus, '����� ������ ����� ��������� ����� ��������', '', 1, 'INVALID_DENOM_AMOUNT');
    bars_error.add_message(l_mod, 528, l_exc, l_ukr, '���� �������� ����� ����� �� ���� ��������', '', 1, 'INVALID_DENOM_AMOUNT');

    bars_error.add_message(l_mod, 529, l_exc, l_rus, '������ �� ������ � ���������� ����������� ��� ���������� ��� ������� #%s!', '', 1, 'REQ_ACCESS_ALREADY_EXISTS');
    bars_error.add_message(l_mod, 529, l_exc, l_ukr, '����� �� ������ � ��������� ����������� ��� ���� �� ������� #%s!', '', 1, 'REQ_ACCESS_ALREADY_EXISTS');

    bars_error.add_message(l_mod, 530, l_exc, l_rus, '����������� ������������ �� ����� �� �������� ���� ������������������ ���������� ���������!', '', 1, 'REQ_ACCESS_REGISTRATION_DENIED');
    bars_error.add_message(l_mod, 530, l_exc, l_ukr, '��������� ��������� �� ����� �� ����� � ����������� ��������� ����������!', '', 1, 'REQ_ACCESS_REGISTRATION_DENIED');

    bars_error.add_message(l_mod, 531, l_exc, l_rus, '���� ���������� ������ ���� � �������� �� 1 �� 100%!', '', 1, 'INVALID_INHERIT_SHARE_RANGE');
    bars_error.add_message(l_mod, 531, l_exc, l_ukr, '������ ������ �� ���� � ����� �� 1 �� 100%!', '', 1, 'INVALID_INHERIT_SHARE_RANGE');

    bars_error.add_message(l_mod, 532, l_exc, l_rus, '�� ������ ��� ���������� ������������������ ���������� � ����� %s !', '', 1, 'REGISTERED_INHERITORS_EXISTS');
    bars_error.add_message(l_mod, 532, l_exc, l_ukr, '�� ������ ��� ������� ����������� ��������� � ������� %s !', '', 1, 'REGISTERED_INHERITORS_EXISTS');

    bars_error.add_message(l_mod, 533, l_exc, l_rus, '�� ������� ����� ��������� ��������������� �������� ����������� �������� � ���% s!', '', 1, 'DOC_SIGNED_CLIENT_NOT_FOUND');
    bars_error.add_message(l_mod, 533, l_exc, l_ukr, '�� �������� ���� ���������, �� ������� ����� �������� �볺���� � ��� %s !', '', 1, 'DOC_SIGNED_CLIENT_NOT_FOUND');

    bars_error.add_message(l_mod, 534, l_exc, l_rus, '�� ������� ������� ������ � �������!', '', 1, 'REQ_NOT_VALID_REASON_REJECT');
    bars_error.add_message(l_mod, 534, l_exc, l_ukr, '�� ������� ������� ������ � ������!', '', 1, 'REQ_NOT_VALID_REASON_REJECT');

    bars_error.add_message(l_mod, 535, l_exc, l_rus, '������� ������ �������� ������������� ���-�� ��������!', '', 1, 'REQ_NOT_ENOUGH_CHARS_REASONS');
    bars_error.add_message(l_mod, 535, l_exc, l_ukr, '������� ������ ������ ���������� �-�� �������!', '', 1, 'REQ_NOT_ENOUGH_CHARS_REASONS');

    bars_error.add_message(l_mod, 536, l_exc, l_rus, '������ ��� �������� ��� �������� � ������� ������� ��� ������� ���� ��������', '', 1, 'ERROR_TEMPLATES');
    bars_error.add_message(l_mod, 536, l_exc, l_ukr, '����� ��� 䳿 ��� ��������� �� ������ ������� ��� ������ ���� ��������', '', 1, 'ERROR_TEMPLATES');

    bars_error.add_message(l_mod, 537, l_exc, l_rus, 'GLPENALTY_MAINTAXDET', '(�� ������ � %s �� %s /%s ��./ �� ����� %s)', 1, 'GLPENALTY_MAINTAXDET');

    bars_error.add_message(l_mod, 538, l_exc, l_rus, 'GLPENALTY_PENYATAX', '�� �������� ������ ��������� %s %', 1, 'GLPENALTY_PENYATAX');

    bars_error.add_message(l_mod, 539, l_exc, l_rus, 'GLPENALTY_PENYATAXDET', '(�� ������ � %s �� %s /%s ��./ �� ����� %s)', 1, 'GLPENALTY_PENYATAXDET');

    bars_error.add_message(l_mod, 540, l_exc, l_rus, '������� %s �� ������������', '', 1, 'PROCEDURE_DEPRECATED');
    bars_error.add_message(l_mod, 540, l_exc, l_ukr, '������� %s �� ���������������', '', 1, 'PROCEDURE_DEPRECATED');

    bars_error.add_message(l_mod, 666, l_exc, l_rus, '%s', '', 1, 'GENERAL_ERROR_CODE');
    bars_error.add_message(l_mod, 666, l_exc, l_ukr, '%s', '', 1, 'GENERAL_ERROR_CODE');

    bars_error.add_message(l_mod, 999, l_exc, l_rus, '������ ���������� �������.�������� - %s', '', 1, 'AUTOJOB_ERROR');
    bars_error.add_message(l_mod, 999, l_exc, l_ukr, '������� ��������� �������.�������� - %s', '', 1, 'AUTOJOB_ERROR');
  commit;
end;
/
PROMPT ===================================================================================== 
PROMPT *** End *** ========== Scripts /Sql/Bars/Data/Err/mod_DPT.sql =========*** Run *** ==
PROMPT ===================================================================================== 
