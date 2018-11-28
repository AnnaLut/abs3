
declare
     procedure insert_data(p_param_id in number, p_param_name in varchar2, p_param_desc in varchar2, p_object_id in number) as
     begin
        Insert into T0_UPLOAD_PARAMS   (param_id, param_name, param_desc, object_id) Values   (p_param_id,  p_param_name, p_param_desc, p_object_id);
     exception
        when dup_val_on_index then null;
        when others then rollback; raise;
     end;
begin
     insert_data(1,  'VED', 'Код отрасли економіки', 1);
     insert_data (2,  'ISE', 'Інституційний сектор економіки (K070)', 1);
     insert_data (3,  'FS', 'Форма власності (K081)', 1);
     insert_data (4,  'COUNTRY', 'Код країни клієнта', 1);
     insert_data (5,  'VIDD', 'Код виду кредитного договору', 2);
     insert_data (6,  'WDATE', 'Дата закінчення дії договору', 2);
     insert_data (7,  'KAT23', 'Категорiя якостi за кредитом по НБУ-23', 2);
     insert_data (8,  'CPROD', 'Код продукта', 2);
     insert_data (9,  'VNCRR', 'Внутрiшнiй кредитний рейтiнг', 2);
     insert_data (10, 'OB22', 'Параметр ОБ22', 3);
     insert_data (11, 'IR', 'Номінальна відстокова ставка', 2);
     insert_data (11, 'IR', 'Номінальна відстокова ставка', 3);
     insert_data (12, 'EIR', 'Ефективна відстокова ставка', 2);
     insert_data (12, 'EIR', 'Ефективна відстокова ставка', 3);
     insert_data (13, 'R013', 'Параметр R013', 3);
     insert_data (14, 'BUS_MOD', 'Бізнес-модель (BUS_MOD)', 2);
     insert_data (15, 'SPPI', 'Критерій SPPI (SPPI)', 2);
     insert_data (16, 'IFRS', 'Класифікація МСФЗ (IFRS)', 2);
     insert_data (17, 'INTRT', 'Ринкова ставка (INTRT)', 2);
     insert_data (18, 'ND_REST', 'Посилання на референс реструкт.договору (ND_REST)', 2);
     insert_data (19, 'BUS_MOD', 'Бізнес-модель (BUS_MOD)', 3);
     insert_data (20, 'SPPI', 'Критерій SPPI (SPPI)', 3);
     insert_data (21, 'IFRS', 'Класифікація МСФЗ (IFRS)', 3);
     insert_data (22, 'INTRT', 'Ринкова ставка (INTRT)', 3);
     insert_data (23, 'ND_REST', 'Посилання на референс реструкт.договору (ND_REST)', 3);
     COMMIT;
end;
/

