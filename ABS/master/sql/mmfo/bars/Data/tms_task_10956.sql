begin
  bc.home;
--------------------------------------
  update tms_task
    set task_name = '����������� �������,����� (�� ����������� ���)  �� �� ��'
    where task_code = 'AVTO%_CCKF';
  commit;
----------------------------------------



end;
/