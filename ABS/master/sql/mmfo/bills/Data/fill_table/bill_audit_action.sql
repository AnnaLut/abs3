prompt fill BILL_AUDIT_ACTION
insert /*+ ignore_row_on_dupkey_index(bill_audit_action xpk_bill_audit_action)*/ into bill_audit_action (action, descript)
values ('SearchResolutionResult', '����� ������');
insert /*+ ignore_row_on_dupkey_index(bill_audit_action xpk_bill_audit_action)*/ into bill_audit_action (action, descript)
values ('DeleteReceiver', '��������� ��������� (��������)');
insert /*+ ignore_row_on_dupkey_index(bill_audit_action xpk_bill_audit_action)*/ into bill_audit_action (action, descript)
values ('ClearRequest', '³����� �� ������ � ����������');
insert /*+ ignore_row_on_dupkey_index(bill_audit_action xpk_bill_audit_action)*/ into bill_audit_action (action, descript)
values ('ConfirmRequest', 'ϳ����������� ������ - ���������� �����������');
insert /*+ ignore_row_on_dupkey_index(bill_audit_action xpk_bill_audit_action)*/ into bill_audit_action (action, descript)
values ('ConfirmRequestList', '���������� ������');
insert /*+ ignore_row_on_dupkey_index(bill_audit_action xpk_bill_audit_action)*/ into bill_audit_action (action, descript)
values ('Move2Work', '������� ������ � ����������');
insert /*+ ignore_row_on_dupkey_index(bill_audit_action xpk_bill_audit_action)*/ into bill_audit_action (action, descript)
values ('UpdateReceiver', '��������� ����� ���������');
insert /*+ ignore_row_on_dupkey_index(bill_audit_action xpk_bill_audit_action)*/ into bill_audit_action (action, descript)
values ('SendDocument', '³������� ��������� � ����');
insert /*+ ignore_row_on_dupkey_index(bill_audit_action xpk_bill_audit_action)*/ into bill_audit_action (action, descript)
values ('HandOutBills', '������ ������� ���������');
insert /*+ ignore_row_on_dupkey_index(bill_audit_action xpk_bill_audit_action)*/ into bill_audit_action (action, descript)
values ('CheckSignInternal', '�������� ����������� ���');


commit;