
---------------
begin
bc.go('/');
update OPERLIST t  set t.name='����������� �������,�����,��� �� �� ��' where t.name='����������� %% ������� ��';
update OPERLIST t  set t.name='����������� �������,�����,��� �� �� ��' where t.name='����������� %% ������� ��';
update tms_task t set t.state_id=1 where  t.task_name in ('�� F0: ����-����� ������� ��������� SG',
'�� F1: ����������� ������� �� 9129 �� ��',
'�� F1_2: ����������� ������� �� 9129 �� �� ��',
'�� F1_3: ����������� ������� �� 9129 �� �� ��',
'#2) �� S38: ������-�� �� �����. ���. ����� ��� � ���� ����� ��',
'�� F05_3: ���� ����� ���-�� ISG (3600) ����-� ������-� �� (SPN,SN)',
'�� S62: ����������� ���i  � �� ��',
'�� S63: ����������� ���i  � �� ��');
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
      ,'����������� �������,�����,��� �� �� �� '
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
      ,'����������� �������,�����,��� �� �� �� '
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
     SET t1.name = t1.name || ' � ���'
   WHERE t1.name IN ('�� S7: ����������� ����/����'
                    ,'�� S7: ����������� ��������/���쳿 ��'
                    ,'����������� ��������/���쳿'
                    ,'����������� ��������/���쳿 ��'
                    ,'����������� ��������/���쳿 ��');
bc.home;
END;
/ 

commit;
