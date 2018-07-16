UPDATE staff$base
   SET branch = '/', can_select_branch = 'Y', policy_group = 'WHOLE'
 WHERE logname = 'GERCTEST';
/
COMMIT;