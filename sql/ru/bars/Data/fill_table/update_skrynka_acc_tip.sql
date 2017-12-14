BEGIN 
  update SKRYNKA_ACC_TIP
  set nbs = 6519
  where tip = 'C';
END;
/

commit;
