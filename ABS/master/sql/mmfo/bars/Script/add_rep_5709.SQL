/* Formatted on 06.09.2016 9:52:54 (QP5 v5.265.14096.38000) */
BEGIN

umu.add_report2arm(  p_report_id => 5709,
                     p_arm_code  => '$RM_BVBB',
                     p_approve   => 1);
EXCEPTION
   WHEN DUP_VAL_ON_INDEX
   THEN
      NULL;
                      
END;
/
commit;

