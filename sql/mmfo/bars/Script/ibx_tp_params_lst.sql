/*�����: ��������� �������� */
prompt Importing table ibx_tp_params_lst...

insert into ibx_tp_params_lst (PARAMCODE, PARAMNAME, DEFVALUE)
values ('NLS_ACC', '����� ������� �����', '1004');

insert into ibx_tp_params_lst (PARAMCODE, PARAMNAME, DEFVALUE)
values ('NLS_BR', '�����, �� ���� ������� ������� �����', '[MFO]');

insert into ibx_tp_params_lst (PARAMCODE, PARAMNAME, DEFVALUE)
values ('COV_ACC', '����� ������� �������� ��� ��������� � ��������', '2920');

insert into ibx_tp_params_lst (PARAMCODE, PARAMNAME, DEFVALUE)
values ('COV_BR', '�����, �� ���� ������� ������� ��������', '[MFO]');

insert into ibx_tp_params_lst (PARAMCODE, PARAMNAME, DEFVALUE)
values ('TRANS_ACC', '����� ����������� ������� ��� ��������� � ��������', '2902');

insert into ibx_tp_params_lst (PARAMCODE, PARAMNAME, DEFVALUE)
values ('TRANS_BR', '�����, �� ���� ������� ���������� �������', '[MFO]');

insert into ibx_tp_params_lst (PARAMCODE, PARAMNAME, DEFVALUE)
values ('FEE_ACC', '����� ������� ���� ��� ��������� � ��������', '6110');

insert into ibx_tp_params_lst (PARAMCODE, PARAMNAME, DEFVALUE)
values ('FEE_BR', '�����, �� ���� ������� ������� ����', '[MFO]');

insert into ibx_tp_params_lst (PARAMCODE, PARAMNAME, DEFVALUE)
values ('TRANS_CARD_ACC', '���������� ������� ��� �������� �� ������������', '2924');

insert into ibx_tp_params_lst (PARAMCODE, PARAMNAME, DEFVALUE)
values ('TRANS_CARD_BR', '�����, �� ���� ������� ���������� ������� ��� �������� �� ������������', '[MFO]');

prompt Done.
