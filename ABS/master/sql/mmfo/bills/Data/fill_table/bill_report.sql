prompt fill bill_report
insert /*+ ignore_row_on_dupkey_index(BILL_REPORT XPK_BILL_REPORT)*/ into bill_report (report_id, report_name, frx_file_name)
values (1, '���������� ��� ������ �� ������ ������ �� ����������� �������������� ���������', 'PayVeks.frx');

insert /*+ ignore_row_on_dupkey_index(BILL_REPORT XPK_BILL_REPORT)*/ into bill_report (report_id, report_name, frx_file_name)
values (2, '����� ������ �� �������� ����', 'rep_6_1.frx');

insert /*+ ignore_row_on_dupkey_index(BILL_REPORT XPK_BILL_REPORT)*/ into bill_report (report_id, report_name, frx_file_name)
values (1, '', '');

commit;