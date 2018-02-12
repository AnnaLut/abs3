BEGIN

umu.add_report2arm(  p_report_id => 5712,
                      p_arm_code  => '$RM_DRU1',
                      p_approve   => 1);
  
EXCEPTION
   WHEN DUP_VAL_ON_INDEX
   THEN
      NULL;
END;
/

commit;
/

