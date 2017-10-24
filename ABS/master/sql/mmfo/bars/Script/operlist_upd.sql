  DECLARE
    -- Local variables here
    i INTEGER;
	l_codeoper number;
    l_codearm  varchar2(10) := '$RM_WCCK';
  BEGIN
   bc.go('/');   
   i := operlist_adm.add_new_func(p_name     => 'ESCR:Картотека відшкодувань по енергокредитам'
                                  , 
                                   p_funcname => '/barsroot/escr/PortfolioData/RefList'
                                  , 
                                   p_usearc   => 0
                                  , 
                                   p_frontend => 1
                                  , 
                                   p_runnable => 1);
       
	   umu.add_func2arm( i , l_codearm, 1 ); 
	   l_codearm:='WESR';
	   umu.add_func2arm( i , l_codearm, 1 ); 
	COMMIT;
  END;
/
DECLARE
  -- Local variables here
  i          INTEGER;
  l_codeoper NUMBER;
  l_codearm  VARCHAR2(10) := '$RM_KREA_F';
BEGIN
  i := operlist_adm.add_new_func(p_name     => 'Нарахування тест'
                                ,p_funcname => '/barsroot/ndi/referencebook/GetRefBookData/?tableName=V_INTEREST_CCK[NSIFUNCTION][ACCESSCODE=>2][PROC=>p_interest_cck1(11,:E)][PAR=>:E(SEM=Дата по,TYPE=D)][EXEC=>BEFORE][showDialogWindow=>false]'          
                                ,p_usearc => 0
                                ,p_frontend => 1
                                ,p_runnable => 1);

  umu.add_func2arm(i, l_codearm, 1);

  COMMIT;
   bc.home;
END;
/
BEGIN
  INSERT INTO tms_task_exclusion (task_code, kf) VALUES ('082', '322669');
EXCEPTION
  WHEN dup_val_on_index THEN
    NULL;
END;
/
		
