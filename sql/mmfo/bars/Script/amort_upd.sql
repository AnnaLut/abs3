
---------------
begin
bc.go('/');
update OPERLIST t  set t.name='Нарахування відсотків,комісій,пені по КП ФО' where t.name='Нарахування %% Кредити ФО';
update OPERLIST t  set t.name='Нарахування відсотків,комісій,пені по КП ЮО' where t.name='Нарахування %% Кредити ЮО';
update tms_task t set t.state_id=1 where  t.task_name in ('КП F0: Авто-разбір рахунків погашення SG',
'КП F1: Вирівнювання залишків на 9129 по КП',
'КП F1_2: Вирівнювання залишків на 9129 по КП ЮО',
'КП F1_3: Вирівнювання залишків на 9129 по КП ФО',
'#2) КП S38: Перене-ня на прост. відс. згідно ДНЯ і ТИПУ погаш ФО',
'КП F05_3: Авто разбір рах-ів ISG (3600) Кред-ої заборг-ті ФО (SPN,SN)',
'КП S62: Нарахування Пенi  у КП ЮО',
'КП S63: Нарахування Пенi  у КП ФО');
bc.home;
end;
/
-----------------

DECLARE
  i      INTEGER;
  l_flag INTEGER;
BEGIN
bc.go('/');
  BEGIN
    SELECT MAX(id) INTO i FROM tms_task t;
  END;
  BEGIN
    SELECT COUNT(*)
      INTO l_flag
      FROM tms_task t
     WHERE t.task_code = 'AVTO%_CCKF';
  END;
  IF l_flag = 0 THEN
  begin
  INSERT INTO tms_task
      (id
      ,task_code
      ,task_type_id
      ,task_group_id
      ,sequence_number
      ,task_name
      ,task_description
      ,branch_processing_mode
      ,action_on_failure
      ,task_statement
      ,state_id)
    VALUES
      (i + 1
      ,'AVTO%_CCKF'
      ,1
      ,2
      ,i
      ,'Нарахування відсотків,комісій,пені по КП ФО '
      ,NULL
      ,2
      ,1
      ,'BEGIN
  cck_ui.p_interest_cck(p_type => 11, p_mode => NULL, p_date_to => NULL);
  END;
  '
      ,1);  
 exception when dup_val_on_index  then
 null;
 end;
  END IF;
  BEGIN
    SELECT COUNT(*)
      INTO l_flag
      FROM tms_task t
     WHERE t.task_code = 'AVTO%_CCKU';
  END;
  IF l_flag = 0 THEN
BEGIN   
   INSERT INTO tms_task
      (id
      ,task_code
      ,task_type_id
      ,task_group_id
      ,sequence_number
      ,task_name
      ,task_description
      ,branch_processing_mode
      ,action_on_failure
      ,task_statement
      ,state_id)
    VALUES
      (i + 1
      ,'AVTO%_CCKU'
      ,1
      ,2
      ,i
      ,'Нарахування відсотків,комісій,пені по КП ЮО '
      ,NULL
      ,2
      ,1
      ,'BEGIN
  cck_ui.p_interest_cck(p_type => 1, p_mode => NULL, p_date_to => NULL);
  END;
  '
      ,1);
exception when dup_val_on_index  then
 null;
 end;	  
  END IF;
  bc.home;
END;
/
BEGIN
  bc.go('/');
  UPDATE operlist t1
     SET t1.name = t1.name || ' з ЕПС'
   WHERE t1.name IN ('КП S7: Амортизація Диск/Прем'
                    ,'КП S7: Амортизація Дисконту/Премії ЮО'
                    ,'Амортизація Дисконту/Премії'
                    ,'Амортизація Дисконту/Премії ФО'
                    ,'Амортизація Дисконту/Премії ЮО');
bc.home;
END;
/ 

commit;
