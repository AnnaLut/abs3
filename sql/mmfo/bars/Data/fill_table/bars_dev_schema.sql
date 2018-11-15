prompt fill_table bars_dev_schema

insert /*+ ignore_row_on_dupkey_index(BARS_DEV_SCHEMA XPK_BARS_DEV_SCHEMA) */ into bars_dev_schema (schemaname, description) values ('BARS', 'Основная схема разработки');

insert /*+ ignore_row_on_dupkey_index(BARS_DEV_SCHEMA XPK_BARS_DEV_SCHEMA) */ into bars_dev_schema (schemaname, description) values ('BARS_DM', 'Витрины данных для CRM (файловый обмен)');

insert /*+ ignore_row_on_dupkey_index(BARS_DEV_SCHEMA XPK_BARS_DEV_SCHEMA) */ into bars_dev_schema (schemaname, description) values ('BARS_INTGR', 'Псевдо-онлайн витрины для CRM + справочники');

insert /*+ ignore_row_on_dupkey_index(BARS_DEV_SCHEMA XPK_BARS_DEV_SCHEMA) */ into bars_dev_schema (schemaname, description) values ('FINMON', 'Работа внешнего модуля "Финансовый мониторинг"');

insert /*+ ignore_row_on_dupkey_index(BARS_DEV_SCHEMA XPK_BARS_DEV_SCHEMA) */ into bars_dev_schema (schemaname, description) values ('BARSUPL', 'Файловые выгрузки - DWH, CRM etc.');

insert /*+ ignore_row_on_dupkey_index(BARS_DEV_SCHEMA XPK_BARS_DEV_SCHEMA) */ into bars_dev_schema (schemaname, description) values ('BARSOS', 'Работа с файловой системой');

insert /*+ ignore_row_on_dupkey_index(BARS_DEV_SCHEMA XPK_BARS_DEV_SCHEMA) */ into bars_dev_schema (schemaname, description) values ('BILLS', 'Казначейские векселя');

insert /*+ ignore_row_on_dupkey_index(BARS_DEV_SCHEMA XPK_BARS_DEV_SCHEMA) */ into bars_dev_schema (schemaname, description) values ('SBON', 'Интеграция со СБОНом');

insert /*+ ignore_row_on_dupkey_index(BARS_DEV_SCHEMA XPK_BARS_DEV_SCHEMA) */ into bars_dev_schema (schemaname, description) values ('PFU', '-');

insert /*+ ignore_row_on_dupkey_index(BARS_DEV_SCHEMA XPK_BARS_DEV_SCHEMA) */ into bars_dev_schema (schemaname, description) values ('MSP', 'Минсоцполитики');

insert /*+ ignore_row_on_dupkey_index(BARS_DEV_SCHEMA XPK_BARS_DEV_SCHEMA) */ into bars_dev_schema (schemaname, description) values ('NBU_GATEWAY', 'Форма 601 для НБУ');

insert /*+ ignore_row_on_dupkey_index(BARS_DEV_SCHEMA XPK_BARS_DEV_SCHEMA) */ into bars_dev_schema (schemaname, description) values ('BARSTRANS', 'Схема транспорта данных');

insert /*+ ignore_row_on_dupkey_index(BARS_DEV_SCHEMA XPK_BARS_DEV_SCHEMA) */ into bars_dev_schema (schemaname, description) values ('DM', '-');

insert /*+ ignore_row_on_dupkey_index(BARS_DEV_SCHEMA XPK_BARS_DEV_SCHEMA) */ into bars_dev_schema (schemaname, description) values ('BARSAQ', '-');

insert /*+ ignore_row_on_dupkey_index(BARS_DEV_SCHEMA XPK_BARS_DEV_SCHEMA) */ into bars_dev_schema (schemaname, description) values ('CDB', 'Кредитная фабрика');

insert /*+ ignore_row_on_dupkey_index(BARS_DEV_SCHEMA XPK_BARS_DEV_SCHEMA) */ into bars_dev_schema (schemaname, description) values ('BARSAQ', '-');

commit;