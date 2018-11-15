prompt fill_table bars_dev_schema

insert /*+ ignore_row_on_dupkey_index(BARS_DEV_SCHEMA XPK_BARS_DEV_SCHEMA) */ into bars_dev_schema (schemaname, description) values ('BARS', '�������� ����� ����������');

insert /*+ ignore_row_on_dupkey_index(BARS_DEV_SCHEMA XPK_BARS_DEV_SCHEMA) */ into bars_dev_schema (schemaname, description) values ('BARS_DM', '������� ������ ��� CRM (�������� �����)');

insert /*+ ignore_row_on_dupkey_index(BARS_DEV_SCHEMA XPK_BARS_DEV_SCHEMA) */ into bars_dev_schema (schemaname, description) values ('BARS_INTGR', '������-������ ������� ��� CRM + �����������');

insert /*+ ignore_row_on_dupkey_index(BARS_DEV_SCHEMA XPK_BARS_DEV_SCHEMA) */ into bars_dev_schema (schemaname, description) values ('FINMON', '������ �������� ������ "���������� ����������"');

insert /*+ ignore_row_on_dupkey_index(BARS_DEV_SCHEMA XPK_BARS_DEV_SCHEMA) */ into bars_dev_schema (schemaname, description) values ('BARSUPL', '�������� �������� - DWH, CRM etc.');

insert /*+ ignore_row_on_dupkey_index(BARS_DEV_SCHEMA XPK_BARS_DEV_SCHEMA) */ into bars_dev_schema (schemaname, description) values ('BARSOS', '������ � �������� ��������');

insert /*+ ignore_row_on_dupkey_index(BARS_DEV_SCHEMA XPK_BARS_DEV_SCHEMA) */ into bars_dev_schema (schemaname, description) values ('BILLS', '������������ �������');

insert /*+ ignore_row_on_dupkey_index(BARS_DEV_SCHEMA XPK_BARS_DEV_SCHEMA) */ into bars_dev_schema (schemaname, description) values ('SBON', '���������� �� ������');

insert /*+ ignore_row_on_dupkey_index(BARS_DEV_SCHEMA XPK_BARS_DEV_SCHEMA) */ into bars_dev_schema (schemaname, description) values ('PFU', '-');

insert /*+ ignore_row_on_dupkey_index(BARS_DEV_SCHEMA XPK_BARS_DEV_SCHEMA) */ into bars_dev_schema (schemaname, description) values ('MSP', '��������������');

insert /*+ ignore_row_on_dupkey_index(BARS_DEV_SCHEMA XPK_BARS_DEV_SCHEMA) */ into bars_dev_schema (schemaname, description) values ('NBU_GATEWAY', '����� 601 ��� ���');

insert /*+ ignore_row_on_dupkey_index(BARS_DEV_SCHEMA XPK_BARS_DEV_SCHEMA) */ into bars_dev_schema (schemaname, description) values ('BARSTRANS', '����� ���������� ������');

insert /*+ ignore_row_on_dupkey_index(BARS_DEV_SCHEMA XPK_BARS_DEV_SCHEMA) */ into bars_dev_schema (schemaname, description) values ('DM', '-');

insert /*+ ignore_row_on_dupkey_index(BARS_DEV_SCHEMA XPK_BARS_DEV_SCHEMA) */ into bars_dev_schema (schemaname, description) values ('BARSAQ', '-');

insert /*+ ignore_row_on_dupkey_index(BARS_DEV_SCHEMA XPK_BARS_DEV_SCHEMA) */ into bars_dev_schema (schemaname, description) values ('CDB', '��������� �������');

insert /*+ ignore_row_on_dupkey_index(BARS_DEV_SCHEMA XPK_BARS_DEV_SCHEMA) */ into bars_dev_schema (schemaname, description) values ('BARSAQ', '-');

commit;