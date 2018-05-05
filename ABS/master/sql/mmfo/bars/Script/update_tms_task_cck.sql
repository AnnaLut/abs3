UPDATE tms_task t
   SET T.TASK_STATEMENT ='BEGIN  cck_ui.p_interest_cck(p_type => 1, p_mode => NULL, p_date_to => NULL);  END;'
 WHERE t.task_code = 'AVTO%_CCKF';

UPDATE tms_task t
   SET T.TASK_STATEMENT ='BEGIN  cck_ui.p_interest_cck(p_type => 2, p_mode => NULL, p_date_to => NULL);  END;'
 WHERE t.task_code = 'AVTO%_CCKU';

COMMIT;