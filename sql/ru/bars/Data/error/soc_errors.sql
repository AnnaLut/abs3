declare
  l_mod  varchar2(3) := 'SOC';
  l_rus  varchar2(3) := 'RUS';
  l_ukr  varchar2(3) := 'UKR';
  l_exc  number(6)   := -20000;
begin
  
  bars_error.add_module(l_mod, '����� ����������� � �����������', 1);
  
  --
  -- create_contract  (1 - 20)
  --
  bars_error.add_message(l_mod,  1, l_exc, l_rus, '�� ������ ������ � ��������������� � %s',   '', 1, 'CUST_NOT_FOUND');
  bars_error.add_message(l_mod,  1, l_exc, l_ukr, '�� ��������� �볺�� � ������������� � %s', '', 1, 'CUST_NOT_FOUND');

  bars_error.add_message(l_mod,  2, l_exc, l_rus, '�� ������ ����� ��� ������ � %s',     '', 1, 'AGENCY_NOT_FOUND');
  bars_error.add_message(l_mod,  2, l_exc, l_ukr, '�� �������� ������ ���.������� � %s', '', 1, 'AGENCY_NOT_FOUND');

  bars_error.add_message(l_mod,  3, l_exc, l_rus, '�� ������ ��� ���.�������� � %s',    '', 1, 'SOCDEALTYPE_NOT_FOUND');
  bars_error.add_message(l_mod,  3, l_exc, l_ukr, '�� ��������� ��� ���.�������� � %s', '', 1, 'SOCDEALTYPE_NOT_FOUND');

  bars_error.add_message(l_mod,  4, l_exc, l_rus, '�� ������ ��� ���.�������� � %s',    '', 1, 'SOCVIDD_NOT_FOUND');
  bars_error.add_message(l_mod,  4, l_exc, l_ukr, '�� ��������� ��� ���.�������� � %s', '', 1, 'SOCVIDD_NOT_FOUND');

  bars_error.add_message(l_mod,  5, l_exc, l_rus, '�� �������� �������� <����� ����������� ����>',   '', 1, 'PENSNUM_IS NULL');
  bars_error.add_message(l_mod,  5, l_exc, l_ukr, '�� ���������� ������� <����� ������� ������>', '', 1, 'PENSNUM_IS NULL');

  bars_error.add_message(l_mod,  6, l_exc, l_rus, '������ ������ � ���.�������� � ������������� %s: %s', '', 1, 'DEALNUM_GET_FAILED');
  bars_error.add_message(l_mod,  6, l_exc, l_ukr, '������� ������ � ���.�������� � ������� %s: %s',   '', 1, 'DEALNUM_GET_FAILED');

  bars_error.add_message(l_mod,  7, l_exc, l_rus, '������ �������� � ���.�������� � ������������� %s: %s', '', 1, 'DEALNUM_FIX_FAILED');
  bars_error.add_message(l_mod,  7, l_exc, l_ukr, '������� �������� � ���.�������� � ������� %s: %s',   '', 1, 'DEALNUM_FIX_FAILED');

  bars_error.add_message(l_mod,  8, l_exc, l_rus, '������ �������� ����� %s/%s : %s',     '', 1, 'SOCACC_OPEN_FAILED');
  bars_error.add_message(l_mod,  8, l_exc, l_ukr, '������� �������� ������� %s/%s : %s', '', 1, 'SOCACC_OPEN_FAILED');

  bars_error.add_message(l_mod,  9, l_exc, l_rus, '�� ������ ���� ���������� ��������',    '', 1, 'EXPACC_NOT_FOUND');
  bars_error.add_message(l_mod,  9, l_exc, l_ukr, '�� �������� ������� ���������� ������', '', 1, 'EXPACC_NOT_FOUND');

  bars_error.add_message(l_mod, 10, l_exc, l_rus, '������ ���������� ���������� �������� �� ����� %s/%s: %s',  '', 1, 'FILL_INTCARD_FAILED');
  bars_error.add_message(l_mod, 10, l_exc, l_ukr, '������� ���������� ��������� ������ �� ������� %s/%s: %s', '', 1, 'FILL_INTCARD_FAILED');

  bars_error.add_message(l_mod, 11, l_exc, l_rus, '������ ���������� ���������� ������ �� ����� %s/%s: %s',    '', 1, 'FILL_INTRATE_FAILED');
  bars_error.add_message(l_mod, 11, l_exc, l_ukr, '������� ���������� ��������� ������ �� ������� %s/%s: %s', '', 1, 'FILL_INTRATE_FAILED');

  bars_error.add_message(l_mod, 12, l_exc, l_rus, '���������� ����� ������������� ���.��������', '', 1, 'GET_CONTRACTID_FAILED');
  bars_error.add_message(l_mod, 12, l_exc, l_ukr, '��������� ������ ������������� ���.��������', '', 1, 'GET_CONTRACTID_FAILED');

  bars_error.add_message(l_mod, 13, l_exc, l_rus, '������ �������� ��������: %s',   '', 1, 'FILL_CONTRACT_FAILED');
  bars_error.add_message(l_mod, 13, l_exc, l_ukr, '������� �������� ��������: %s', '', 1, 'FILL_CONTRACT_FAILED');

  --
  -- pay_bankfile (21 - 40)
  --
  bars_error.add_message(l_mod, 21, l_exc, l_rus, '�� ������� �������� � ����� %s',  '', 1, 'PAYTT_NOT_FOUND');
  bars_error.add_message(l_mod, 21, l_exc, l_ukr, '�� �������� �������� � ����� %s', '', 1, 'PAYTT_NOT_FOUND');

  bars_error.add_message(l_mod, 22, l_exc, l_rus, '�� ������ ���� id = %s',         '', 1, 'FILE_NOT_FOUND');
  bars_error.add_message(l_mod, 22, l_exc, l_ukr, '�� ��������� ���� id = %s',      '', 1, 'FILE_NOT_FOUND');
                            
  bars_error.add_message(l_mod, 23, l_exc, l_rus, '�� ������ ���� �����.������������ ��� ��� � %s (acc=%s)', '', 1, 'DEBITACC_NOT_FOUND');
  bars_error.add_message(l_mod, 23, l_exc, l_ukr, '�� ��������� �����.������������� ��� ��� � %s (acc=%s)', '', 1, 'DEBITACC_NOT_FOUND');

  bars_error.add_message(l_mod, 24, l_exc, l_rus, '�� ������ ���� ������.������������ (��� ���.������) ��� ��� � %s (acc=%s)',           '', 1, 'CREDITACC_NOT_FOUND');
  bars_error.add_message(l_mod, 24, l_exc, l_ukr, '�� ��������� ������� ������.������������� (��� ������.���.)  ��� ��� � %s (acc=%s)', '', 1, 'CREDITACC_NOT_FOUND');

  bars_error.add_message(l_mod, 25, l_exc, l_rus, '�� ������ ���� ������.������������ (��� ����.������)  ��� ��� � %s (acc=%s)',       '', 1, 'CARDACC_NOT_FOUND');
  bars_error.add_message(l_mod, 25, l_exc, l_ukr, '�� ��������� ������� ������.������������� (��� �����.���.) ��� ��� � %s (acc=%s)', '', 1, 'CARDACC_NOT_FOUND');

  bars_error.add_message(l_mod, 26, l_exc, l_rus, '�� ������ ���� ������������ ������� ��� ��� � %s (acc=%s)',     '', 1, 'COMISSACC_NOT_FOUND');
  bars_error.add_message(l_mod, 26, l_exc, l_ukr, '�� ��������� ������� �������� ������ ��� ��� � %s (acc=%s)', '', 1, 'COMISSACC_NOT_FOUND');

  bars_error.add_message(l_mod, 27, l_exc, l_rus, '������������ ������� �� ����� %s/%s (������� = %s, ����� ���������� = %s)',  '', 1, 'RED_SALDO');
  bars_error.add_message(l_mod, 27, l_exc, l_ukr, '����������� ����� �� ������� %s/%s (������� = %s, ����  ����������� = %s)', '', 1, 'RED_SALDO');

  bars_error.add_message(l_mod, 28, l_exc, l_rus, '������ ������ ��������� (�� %s, �� %s �� ����� %s): %s', '', 1, 'PAYDOC_FAILED');
  bars_error.add_message(l_mod, 28, l_exc, l_ukr, '������� ������ ��������� (�� %s, �� %s �� ���� %s): %s', '', 1, 'PAYDOC_FAILED');

  bars_error.add_message(l_mod, 29, l_exc, l_rus, '�� ������� �������� ��� ��������� �������� �� ������ �%s', '', 1, 'COMISSTT_NOT_FOUND');
  bars_error.add_message(l_mod, 29, l_exc, l_ukr, '�� �������� �������� ��� ��������� ���� �� ������ �%s', '', 1, 'COMISSTT_NOT_FOUND');

  bars_error.add_message(l_mod, 30, l_exc, l_rus, '�� ������ ���� %s/%s �볺��� %s',       '', 1, 'FILEACC_NOT_FOUND');
  bars_error.add_message(l_mod, 30, l_exc, l_ukr, '�� ��������� ������� %s/%s �볺��� %s', '', 1, 'FILEACC_NOT_FOUND');

  bars_error.add_message(l_mod, 31, l_exc, l_rus, '������ ������ ���.��������� %s �� ��������� %s: %s',  '', 1, 'FILL_DOCVAL_FAILED');
  bars_error.add_message(l_mod, 31, l_exc, l_ukr, '������� ������ ���.�������� %s �� ��������� %s: %s', '', 1, 'FILL_DOCVAL_FAILED');

  bars_error.add_message(l_mod, 32, l_exc, l_rus, '�� ������ ��� ���������� � ����� %s',     '', 1, 'FILETYPE_NOT_FOUND');
  bars_error.add_message(l_mod, 32, l_exc, l_ukr, '�� ��������� ��� ����������� � ����� %s', '', 1, 'FILETYPE_NOT_FOUND');

  bars_error.add_message(l_mod, 33, l_exc, l_rus, '��������� ���� %s �� ������ ��� ����������',   '', 1, 'CARDACC_INVALID');
  bars_error.add_message(l_mod, 33, l_exc, l_ukr, '��������� ������� %s �� ��������/�����������', '', 1, 'CARDACC_INVALID');

  --
  --  close_contract (41 - 60)
  --
  bars_error.add_message(l_mod, 41, l_exc, l_rus, '�� ������ ���.������� �%s',   '', 1, 'CONTRACT_NOT_FOUND');
  bars_error.add_message(l_mod, 41, l_exc, l_ukr, '�� �������� ���.������ �%s', '', 1, 'CONTRACT_NOT_FOUND');

  bars_error.add_message(l_mod, 42, l_exc, l_rus, '�������� ���.�������� � %s ���������: %s', '', 1, 'CLOSE_CONTRACT_DENIED');
  bars_error.add_message(l_mod, 42, l_exc, l_ukr, '�������� ���.�������� �%s ����������: %s', '', 1, 'CLOSE_CONTRACT_DENIED');

  bars_error.add_message(l_mod, 43, l_exc, l_rus, '������ �������� ����� � %s / %s',    '', 1, 'CONTRACTACC_CLOSE_FAILED');
  bars_error.add_message(l_mod, 43, l_exc, l_ukr, '������� �������� ������� � %s / %s', '', 1, 'CONTRACTACC_CLOSE_FAILED');

  bars_error.add_message(l_mod, 44, l_exc, l_rus, '������ �������� �������� � %s (%s): %s', '', 1, 'CLOSE_CONTRACT_FAILED');
  bars_error.add_message(l_mod, 44, l_exc, l_ukr, '������� �������� �������� �%s (%s): %s', '', 1, 'CLOSE_CONTRACT_FAILED');

  bars_error.add_message(l_mod, 45, l_exc, l_rus, '�� �������� � %s �� %s �� ��������� ��������',  '', 1, 'INT_NOT_ACCURED');
  bars_error.add_message(l_mod, 45, l_exc, l_ukr, '�� �������� �%s �� %s �� ���������� �������', '', 1, 'INT_NOT_ACCURED');

  --
  -- p_supplementary_agreement (51 - 60)
  --
  bars_error.add_message(l_mod, 51, l_exc, l_rus, '������-�������� �������� �� ����� ��� ��������� �����', '', 1,'TRUSTCUST_INVALID');
  bars_error.add_message(l_mod, 51, l_exc, l_ukr, '�볺��-������� �������� �� ���� ���� �������� ������',   '', 1,'TRUSTCUST_INVALID');

  bars_error.add_message(l_mod, 52, l_exc, l_rus, '�� ������� ���������� ���� � %s', '', 1, 'TRUSTCUST_NOT_FOUND');
  bars_error.add_message(l_mod, 52, l_exc, l_ukr, '�� �������� ������� ����� � %s', '', 1, 'TRUSTCUST_NOT_FOUND');

  bars_error.add_message(l_mod, 53, l_exc, l_rus, '��������� ���������� ���.���������� ���� %s ��� ���� �������� %s', '', 1, 'TRUSTYPE_DENIED');
  bars_error.add_message(l_mod, 53, l_exc, l_ukr, '���������� ���������� ���.����� ���� %s ��� ���� �������� � %s',   '', 1, 'TRUSTYPE_DENIED');

  bars_error.add_message(l_mod, 54, l_exc, l_rus, '�� ������ ��� ����������� ���� (��� ���.���������� - %s)', '', 1, 'TRUSTTYPE_NOT_FOUND');
  bars_error.add_message(l_mod, 54, l_exc, l_ukr, '�� ��������� ��� ������� ����� (��� ���.����� - %s)',    '', 1, 'TRUSTTYPE_NOT_FOUND');
 
  bars_error.add_message(l_mod, 55, l_exc, l_rus, '�� ������� ��������� ���.����������, ������� ����� ������������ ������', '', 1,'PRIMARY_TRUST_NOT_FOUND');
  bars_error.add_message(l_mod, 55, l_exc, l_ukr, '�� �������� �������� ���.�����, ��� �� ���� ���������� ����� ������',   '', 1,'PRIMARY_TRUST_NOT_FOUND');

  bars_error.add_message(l_mod, 56, l_exc, l_rus, '������ ���������� ���.���������� (��� %s) � ���.�������� � %s: %s', '', 1, 'TRUSTOPEN_FAILED');
  bars_error.add_message(l_mod, 56, l_exc, l_ukr, '������� ���������� ���.����� (��� %s) �� ���.�������� � %s: %s',    '', 1,'TRUSTOPEN_FAILED');

  bars_error.add_message(l_mod, 57, l_exc, l_rus, '���.���������� (��� %s) � ������ 3-�� ���� � %s � ���.�������� � %s ��� ����������', '', 1, 'TRUSTEE_DUPLICATE');
  bars_error.add_message(l_mod, 57, l_exc, l_ukr, '���.����� (��� %s) ��� ����� 3-� ����� � %s �� ���.�������� � %s ��� ����',        '', 1, 'TRUSTEE_DUPLICATE');
  --
  -- open_social_agency (+ prepare_agency_account + get_agency_account) (61 - 80)
  --
  -- prepare_agency_account
  bars_error.add_message(l_mod, 61, l_exc, l_rus, '���� �%s ��������� �� ������ �������������� (%s)',   '', 1, 'FOREIGN_AGENCY_ACC');
  bars_error.add_message(l_mod, 61, l_exc, l_ukr, '������� � %s ���������� �� ����� ��������� (%s)', '', 1, 'FOREIGN_AGENCY_ACC');

  bars_error.add_message(l_mod, 62, l_exc, l_rus, '���� �%s ��� ������ %s',       '', 1, 'AGENCY_ACC_CLOSED');
  bars_error.add_message(l_mod, 62, l_exc, l_ukr, '������� � %s ���� ������� %s', '', 1, 'AGENCY_ACC_CLOSED');

  bars_error.add_message(l_mod, 63, l_exc, l_rus, '��������� ������������� ����� ���� %s ��� ��� ���� %s',   '', 1, 'INVALID_AGENCY_ACC_TYPE');
  bars_error.add_message(l_mod, 63, l_exc, l_ukr, '���������� ������������ ������� ���� %s ��� ��� ���� %s', '', 1, 'INVALID_AGENCY_ACC_TYPE');

  bars_error.add_message(l_mod, 64, l_exc, l_rus, '����� ������������ ���������� ���� (%s) ��� ������� ���� �����',       '', 1, 'INVALID_AGENCY_BAL_ACC');
  bars_error.add_message(l_mod, 64, l_exc, l_ukr, '������ ������������� ���������� ������� (%s) ��� ������ ���� �������', '', 1, 'INVALID_AGENCY_BAL_ACC');
  -- get_agency_account
  bars_error.add_message(l_mod, 65, l_exc, l_rus, '�� ������ ������, �� �������� ����������� ����� ������� ���.������ ������������� %s',   '', 1, 'AGENCY_ACC_OWNER_NOT_FOUND');
  bars_error.add_message(l_mod, 65, l_exc, l_ukr, '�� ��������� �볺��, �� ����� ������������ ������� ������ ���.������� �������� %s', '', 1, 'AGENCY_ACC_OWNER_NOT_FOUND');

  bars_error.add_message(l_mod, 66, l_exc, l_rus, '������ �������� ����� %s: %s',     '', 1, 'OPEN_AGENCY_ACC_ERROR');
  bars_error.add_message(l_mod, 66, l_exc, l_ukr, '������� �������� ������� %s: %s', '', 1, 'OPEN_AGENCY_ACC_ERROR');

  bars_error.add_message(l_mod, 67, l_exc, l_rus, '��������� ���� %s ������ � ������ �������������',   '', 1, 'DUPL_AGENCY_ACC');
  bars_error.add_message(l_mod, 67, l_exc, l_ukr, '�������� ������� %s �������� � ������ �������', '', 1, 'DUPL_AGENCY_ACC');
  -- open_social_agency
  bars_error.add_message(l_mod, 68, l_exc, l_rus, '����������� ����� ��� ������ ���.������ = %s',   '', 1, 'AGENCY_TYPE_NOT_FOUND');
  bars_error.add_message(l_mod, 68, l_exc, l_ukr, '���������� ������� ��� ������ ���.������� = %s', '', 1, 'AGENCY_TYPE_NOT_FOUND');

  bars_error.add_message(l_mod, 69, l_exc, l_rus, '����������� ����� ��� ������������� = %s', '', 1, 'BRANCH_NOT_FOUND');
  bars_error.add_message(l_mod, 69, l_exc, l_ukr, '���������� ������� ��� �������� = %s',   '', 1, 'BRANCH_NOT_FOUND');

  bars_error.add_message(l_mod, 70, l_exc, l_rus, '������ ������/�������� ����� �����.������������ � %s: %s',       '', 1,'SOC_AGENCY_DEBIT_ACC_ERROR');
  bars_error.add_message(l_mod, 70, l_exc, l_ukr, '������� ������/�������� ������� �����.������������� � %s: %s', '', 1,'SOC_AGENCY_DEBIT_ACC_ERROR');
  
  bars_error.add_message(l_mod, 71, l_exc, l_rus, '������ ������/�������� ����� ������.������������ � %s: %s',      '', 1,'SOC_AGENCY_CREDIT_ACC_ERROR');
  bars_error.add_message(l_mod, 71, l_exc, l_ukr, '������� ������/�������� ������� ������.������������� � %s: %s','', 1,'SOC_AGENCY_CREDIT_ACC_ERROR');
  
  bars_error.add_message(l_mod, 72, l_exc, l_rus, '������ ������/�������� ������.������������ (����.) � %s: %s',              '', 1,'SOC_AGENCY_CARD_ACC_ERROR');
  bars_error.add_message(l_mod, 72, l_exc, l_ukr, '������� ������/�������� ������� ������.������������� (�����.) � %s: %s', '', 1,'SOC_AGENCY_CARD_ACC_ERROR');
  
  bars_error.add_message(l_mod, 73, l_exc, l_rus, '������ ������/�������� ����� ������.������� � %s : %s',           '', 1,'SOC_AGENCY_COMISS_ACC_ERROR');
  bars_error.add_message(l_mod, 73, l_exc, l_ukr, '������� ������/�������� ������� ����.������ � %s: %s',         '', 1,'SOC_AGENCY_COMISS_ACC_ERROR');
  
  -- close_agency
  bars_error.add_message(l_mod, 74, l_exc, l_rus, '����� ���.������ � %s - %s ��� ������',    '', 1, 'AGENCY_ALREADY_CLOSED');
  bars_error.add_message(l_mod, 74, l_exc, l_ukr, '����� ���.������� � %s - %s ��� ��������', '', 1, 'AGENCY_ALREADY_CLOSED');

  bars_error.add_message(l_mod, 75, l_exc, l_rus, '���� �������� �������� � ��� ������ ���� ���������� ��������','', 1, 'AGENCY_INVALIDCLOSDATE');
  bars_error.add_message(l_mod, 75, l_exc, l_ukr, '���� �������� �������� � ��� ����� ���� ���������� ��������', '', 1, 'AGENCY_INVALIDCLOSDATE');
  
  --
  --
  --
  bars_error.add_message(l_mod, 81, l_exc, l_rus, '��������� ���������� ���������� ������� � ����� %s �� %s', '', 1, 'BF_INFO_LENGTH');
  bars_error.add_message(l_mod, 81, l_exc, l_ukr, '���������� ��������� ������� ������ � ���� %s �� %s', '', 1,  'BF_INFO_LENGTH');

  bars_error.add_message(l_mod, 82, l_exc, l_rus, '��������� ����� ����� %s �� %s', '', 1, 'BF_SUM');
  bars_error.add_message(l_mod, 82, l_exc, l_ukr, '���������� ���� ����� %s �� %s', '', 1, 'BF_SUM');

  bars_error.add_message(l_mod, 83, l_exc, l_rus, '��������� ��������� ��������� ������ (id = %s, ��������� %s)', '', 1, 'BF_IS_PAID');
  bars_error.add_message(l_mod, 83, l_exc, l_ukr, '���������� ���� ��������� ����� (id = %s, �������� %s)', '', 1, 'BF_IS_PAID');
  
  bars_error.add_message(l_mod, 84, l_exc, l_rus, '��������� �������� ��������� ������ ���������� (id = %s)', '', 1, 'BF_CANT_BE_DELETED');
  bars_error.add_message(l_mod, 84, l_exc, l_ukr, '���������� ��������� ��������� ����� ���������� (id = %s)', '', 1, 'BF_CANT_BE_DELETED');

  bars_error.add_message(l_mod, 85, l_exc, l_rus, '������ ������ �� ������ ������� ��������� ��� ������������� �� ��������� %s', '', 1, 'USER_NOT_ALLOWED');
  bars_error.add_message(l_mod, 85, l_exc, l_ukr, '������ ����� � ���� ������� ���������� ��� ������������ �� �������� %s', '', 1, 'USER_NOT_ALLOWED');

  bars_error.add_message(l_mod, 86, l_exc, l_rus, '�� ������� ����� ���. ������ � ��������� %s ���� %s', '', 1, 'AG_TYPE_NOT_FOUND');
  bars_error.add_message(l_mod, 86, l_exc, l_ukr, '�� �������� ����� ���. ������� � ������ %s ���� %s', '', 1, 'AG_TYPE_NOT_FOUND');

  bars_error.add_message(l_mod, 87, l_exc, l_rus, '�� ������� ��� ������� ������ ������ ���� ��������, ��������� � ������� ���. ������ %s', '', 1, 'SOC_TYPE_NOT_FOUND');
  bars_error.add_message(l_mod, 87, l_exc, l_ukr, '�� �������� ��� �������� ����� ������ ���� ��������, �������� � ������� ���. ������� %s', '', 1, 'SOC_TYPE_NOT_FOUND');

  --
  -- dpt_social.prepare2closdeal
  --
  bars_error.add_message(l_mod, 88, l_exc, l_rus, '���.������� � %s ��� �� ������� � ����',                                 '', 1, 'PREPARE2CLOS_NOT_OPENED_YET');
  bars_error.add_message(l_mod, 88, l_exc, l_ukr, '���.������ � %s �� �� ������� � ��',                                   '', 1, 'PREPARE2CLOS_NOT_OPENED_YET');

  bars_error.add_message(l_mod, 89, l_exc, l_rus, '���.������� � %s ��� ������',                                            '', 1, 'PREPARE2CLOS_ALREADY_CLOSED');
  bars_error.add_message(l_mod, 89, l_exc, l_ukr, '���.������ � %s ��� �������',                                           '', 1, 'PREPARE2CLOS_ALREADY_CLOSED');

  bars_error.add_message(l_mod, 90, l_exc, l_rus, '�� ������ ������-�������� ���.�������� � %s',                            '', 1, 'PREPARE2CLOS_CUST_NOT_FOUND');
  bars_error.add_message(l_mod, 90, l_exc, l_ukr, '�� ��������� �볺��-������� ���.�������� � %s',                          '', 1, 'PREPARE2CLOS_CUST_NOT_FOUND');

  bars_error.add_message(l_mod, 91, l_exc, l_rus, '������ ������ ���������� ��������� ����� �� ���.�������� � %s: %s',      '', 1, 'PREPARE2CLOS_DEPACC_NOT_FOUND');
  bars_error.add_message(l_mod, 91, l_exc, l_ukr, '������� ������ �������� ��������� ������� �� ���.�������� � %s: %s',   '', 1, 'PREPARE2CLOS_DEPACC_NOT_FOUND');

  bars_error.add_message(l_mod, 92, l_exc, l_rus, '�� ����� %s/%s ������� ���������������� ���������',                      '', 1, 'PREPARE2CLOS_INVALID_SALDO');
  bars_error.add_message(l_mod, 92, l_exc, l_ukr, '�� ������� %s/%s �������� ���������� ���������',                       '', 1, 'PREPARE2CLOS_INVALID_SALDO');

  bars_error.add_message(l_mod, 93, l_exc, l_rus, '������ ������ ���������� ����������� ����� �� ���.�������� � %s: %s',    '', 1, 'PREPARE2CLOS_INTACC_NOT_FOUND');
  bars_error.add_message(l_mod, 93, l_exc, l_ukr, '������� ������ �������� ����������� ������� �� ���.�������� � %s: %s', '', 1, 'PREPARE2CLOS_INTACC_NOT_FOUND');

  bars_error.add_message(l_mod, 94, l_exc, l_rus, '������ ���������� ��������� �� ���.�������� � %s: %s',                   '', 1, 'PREPARE2CLOS_MAKEINT_FAILED');
  bars_error.add_message(l_mod, 94, l_exc, l_ukr, '������� ����������� ������� �� ���.�������� � %s: %s',                 '', 1, 'PREPARE2CLOS_MAKEINT_FAILED');

  bars_error.add_message(l_mod, 95, l_exc, l_rus, '������ ������� ��������� �� ���.�������� � %s: %s',                      '', 1, 'PREPARE2CLOS_PAYINT_FAILED');
  bars_error.add_message(l_mod, 95, l_exc, l_ukr, '������� �������������� �� ���.�������� � %s: %s',                      '', 1, 'PREPARE2CLOS_PAYINT_FAILED');

  bars_error.add_message(l_mod, 96, l_exc, l_rus, '� ��������� %s �� ������ ����� ���������� ������ ��� %s',                '', 1, 'AGENCY_BRANCH_NOT_FOUND');
  bars_error.add_message(l_mod, 96, l_exc, l_ukr, '� ������� %s �� �������� ����� ����������� ������� ��� %s',           '', 1, 'AGENCY_BRANCH_NOT_FOUND');

  bars_error.add_message(l_mod, 97, l_exc, l_rus, '����� ���. ������ ��� ���� %s � ��������� %s ��� ������ � � %s.',        '', 1, 'AGENCY_ALREADY_EXISTS');
  bars_error.add_message(l_mod, 97, l_exc, l_ukr, '����� ���. ������� ��� ���� %s �� �������� %s ��� ���� ��  � %s.',   '', 1, 'AGENCY_ALREADY_EXISTS');

  bars_error.add_message(l_mod, 98, l_exc, l_rus, '������� ������ ������ ������ ���. ������ ��� ���� %s � ��������� %s.',   '', 1, 'TOO_MANY_AGENCIES_EXIST');
  bars_error.add_message(l_mod, 98, l_exc, l_ukr, '���� ����� ������ ������ ���. ������� ��� ���� %s �� �������� %s.',  '', 1, 'TOO_MANY_AGENCIES_EXIST');

  l_exc := -20666;

  bars_error.add_message( l_mod, 666, l_exc, l_ukr, '%s', '', 1, 'GENERAL_ERROR_CODE' );
  bars_error.add_message( l_mod, 666, l_exc, l_rus, '%s', '', 1, 'GENERAL_ERROR_CODE' );

end;
/

commit;
