-- ***************************************************************************
set verify off

begin
   dbms_output.put_line(to_char(sysdate(), 'dd.mm.yyyy hh24:mi:ss') ||': Process for T0_UPLOAD_PARAMS');
end;
/

-- ======================================================================================
-- ETL-20823 -UPL - выгрузить из АБС в ХД параметры договора/счёта для IFRS9: BUSINESS_MODEL, IFRS_CATEGORY, SPPI, Ринкова ставка (INTRT), Референс реструкт.договору (ND_REST) с соответствующими справочниками
-- добавляются теги в справочник выгружаемых в Т0
-- ======================================================================================

delete 
  from barsupl.t0_upload_params 
 where param_name in ('BUS_MOD', 'SPPI', 'IFRS', 'INTRT', 'ND_REST');


-- Insert into BARSUPL.T0_UPLOAD_PARAMS   (param_id, param_name, param_desc, object_id) Values   (1,  'VED', 'Код отрасли економіки', 1);
-- Insert into BARSUPL.T0_UPLOAD_PARAMS   (param_id, param_name, param_desc, object_id) Values   (2,  'ISE', 'Інституційний сектор економіки (K070)', 1);
-- Insert into BARSUPL.T0_UPLOAD_PARAMS   (param_id, param_name, param_desc, object_id) Values   (3,  'FS', 'Форма власності (K081)', 1);
-- Insert into BARSUPL.T0_UPLOAD_PARAMS   (param_id, param_name, param_desc, object_id) Values   (4,  'COUNTRY', 'Код країни клієнта', 1);
-- Insert into BARSUPL.T0_UPLOAD_PARAMS   (param_id, param_name, param_desc, object_id) Values   (5,  'VIDD', 'Код виду кредитного договору', 2);
-- Insert into BARSUPL.T0_UPLOAD_PARAMS   (param_id, param_name, param_desc, object_id) Values   (6,  'WDATE', 'Дата закінчення дії договору', 2);
-- Insert into BARSUPL.T0_UPLOAD_PARAMS   (param_id, param_name, param_desc, object_id) Values   (7,  'KAT23', 'Категорiя якостi за кредитом по НБУ-23', 2);
-- Insert into BARSUPL.T0_UPLOAD_PARAMS   (param_id, param_name, param_desc, object_id) Values   (8,  'CPROD', 'Код продукта', 2);
-- Insert into BARSUPL.T0_UPLOAD_PARAMS   (param_id, param_name, param_desc, object_id) Values   (9,  'VNCRR', 'Внутрiшнiй кредитний рейтiнг', 2);
-- Insert into BARSUPL.T0_UPLOAD_PARAMS   (param_id, param_name, param_desc, object_id) Values   (10, 'OB22', 'Параметр ОБ22', 3);
-- Insert into BARSUPL.T0_UPLOAD_PARAMS   (param_id, param_name, param_desc, object_id) Values   (11, 'IR', 'Номінальна відстокова ставка', 3);
-- Insert into BARSUPL.T0_UPLOAD_PARAMS   (param_id, param_name, param_desc, object_id) Values   (12, 'EIR', 'Ефективна відстокова ставка', 3);
-- Insert into BARSUPL.T0_UPLOAD_PARAMS   (param_id, param_name, param_desc, object_id) Values   (13, 'R013', 'Параметр R013', 3);

--параметры для договоров
Insert into BARSUPL.T0_UPLOAD_PARAMS   (param_id, param_name, param_desc, object_id) Values   (14, 'BUS_MOD', 'Бізнес-модель (BUS_MOD)', 2);
Insert into BARSUPL.T0_UPLOAD_PARAMS   (param_id, param_name, param_desc, object_id) Values   (15, 'SPPI', 'Критерій SPPI (SPPI)', 2);
Insert into BARSUPL.T0_UPLOAD_PARAMS   (param_id, param_name, param_desc, object_id) Values   (16, 'IFRS', 'Класифікація МСФЗ (IFRS)', 2);
Insert into BARSUPL.T0_UPLOAD_PARAMS   (param_id, param_name, param_desc, object_id) Values   (17, 'INTRT', 'Ринкова ставка (INTRT)', 2);
Insert into BARSUPL.T0_UPLOAD_PARAMS   (param_id, param_name, param_desc, object_id) Values   (18, 'ND_REST', 'Посилання на референс реструкт.договору (ND_REST)', 2);

--параметры для счетов
Insert into BARSUPL.T0_UPLOAD_PARAMS   (param_id, param_name, param_desc, object_id) Values   (19, 'BUS_MOD', 'Бізнес-модель (BUS_MOD)', 3);
Insert into BARSUPL.T0_UPLOAD_PARAMS   (param_id, param_name, param_desc, object_id) Values   (20, 'SPPI', 'Критерій SPPI (SPPI)', 3);
Insert into BARSUPL.T0_UPLOAD_PARAMS   (param_id, param_name, param_desc, object_id) Values   (21, 'IFRS', 'Класифікація МСФЗ (IFRS)', 3);
Insert into BARSUPL.T0_UPLOAD_PARAMS   (param_id, param_name, param_desc, object_id) Values   (22, 'INTRT', 'Ринкова ставка (INTRT)', 3);
Insert into BARSUPL.T0_UPLOAD_PARAMS   (param_id, param_name, param_desc, object_id) Values   (23, 'ND_REST', 'Посилання на референс реструкт.договору (ND_REST)', 3);

