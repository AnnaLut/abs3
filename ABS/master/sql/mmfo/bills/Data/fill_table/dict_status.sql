prompt fill dict_status
insert /*+ ignore_row_on_dupkey_index(dict_status XPK_DICT_STATUS)*/ into dict_status (CODE, NAME, TYPE)
values ('SG', '������� ��������� � ����', 'B');
insert /*+ ignore_row_on_dupkey_index(dict_status XPK_DICT_STATUS)*/ into dict_status (CODE, NAME, TYPE)
values ('SN', '������� ��������� �� �����', 'B');
insert /*+ ignore_row_on_dupkey_index(dict_status XPK_DICT_STATUS)*/ into dict_status (CODE, NAME, TYPE)
values ('RC', '������� ��������� ��', 'B');
insert /*+ ignore_row_on_dupkey_index(dict_status XPK_DICT_STATUS)*/ into dict_status (CODE, NAME, TYPE)
values ('SR', '������� ��������� � �� � �����', 'B');
insert /*+ ignore_row_on_dupkey_index(dict_status XPK_DICT_STATUS)*/ into dict_status (CODE, NAME, TYPE)
values ('RR', '������� ��������� � �����', 'B');
insert /*+ ignore_row_on_dupkey_index(dict_status XPK_DICT_STATUS)*/ into dict_status (CODE, NAME, TYPE)
values ('OK', '������� ������� ����������', 'B');
insert /*+ ignore_row_on_dupkey_index(dict_status XPK_DICT_STATUS)*/ into dict_status (CODE, NAME, TYPE)
values ('RQ', '��������� ����� �� ����', 'C');
insert /*+ ignore_row_on_dupkey_index(dict_status XPK_DICT_STATUS)*/ into dict_status (CODE, NAME, TYPE)
values ('XX', '����� ����� ���������� ������', 'C');
insert /*+ ignore_row_on_dupkey_index(dict_status XPK_DICT_STATUS)*/ into dict_status (CODE, NAME, TYPE)
values ('SN', '����� ��������� � ����', 'C');
insert /*+ ignore_row_on_dupkey_index(dict_status XPK_DICT_STATUS)*/ into dict_status (CODE, NAME, TYPE)
values ('RJ', '����� ������������ � ����', 'C');
insert /*+ ignore_row_on_dupkey_index(dict_status XPK_DICT_STATUS)*/ into dict_status (CODE, NAME, TYPE)
values ('AX', '�����', 'C');
insert /*+ ignore_row_on_dupkey_index(dict_status XPK_DICT_STATUS)*/ into dict_status (CODE, NAME, TYPE)
values ('IN', '�������� ��������', 'D');
insert /*+ ignore_row_on_dupkey_index(dict_status XPK_DICT_STATUS)*/ into dict_status (CODE, NAME, TYPE)
values ('OK', '�������� ����������', 'D');
insert /*+ ignore_row_on_dupkey_index(dict_status XPK_DICT_STATUS)*/ into dict_status (CODE, NAME, TYPE)
values ('RJ', '�������� ��������', 'D');
insert /*+ ignore_row_on_dupkey_index(dict_status XPK_DICT_STATUS)*/ into dict_status (CODE, NAME, TYPE)
values ('AX', '�����', 'R');
insert /*+ ignore_row_on_dupkey_index(dict_status XPK_DICT_STATUS)*/ into dict_status (CODE, NAME, TYPE)
values ('IN', '����� ���������', 'R');
insert /*+ ignore_row_on_dupkey_index(dict_status XPK_DICT_STATUS)*/ into dict_status (CODE, NAME, TYPE)
values ('OK', '�������� �������', 'R');
insert /*+ ignore_row_on_dupkey_index(dict_status XPK_DICT_STATUS)*/ into dict_status (CODE, NAME, TYPE)
values ('RQ', '����� ����������� � ����', 'R');
insert /*+ ignore_row_on_dupkey_index(dict_status XPK_DICT_STATUS)*/ into dict_status (CODE, NAME, TYPE)
values ('SN', '����� �����������', 'R');
insert /*+ ignore_row_on_dupkey_index(dict_status XPK_DICT_STATUS)*/ into dict_status (CODE, NAME, TYPE)
values ('XX', '����� ������������, ��������� �����', 'R');
insert /*+ ignore_row_on_dupkey_index(dict_status XPK_DICT_STATUS)*/ into dict_status (CODE, NAME, TYPE)
values ('GN', '������� ������������ � ����', 'B');
insert /*+ ignore_row_on_dupkey_index(dict_status XPK_DICT_STATUS)*/ into dict_status (CODE, NAME, TYPE)
values ('VH', '������� ����� ���������', 'R');
insert /*+ ignore_row_on_dupkey_index(dict_status XPK_DICT_STATUS)*/ into dict_status (CODE, NAME, TYPE)
values ('VH', '������� ����� ���������', 'C');
insert /*+ ignore_row_on_dupkey_index(dict_status XPK_DICT_STATUS)*/ into dict_status (CODE, NAME, TYPE)
values ('RJ', '����� ������������ � ����', 'R');
commit;

update dict_status
set name = '��������� �������������'
where code = 'RQ'
and type = 'R';

commit;