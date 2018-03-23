----------------------------------------------------------------------
--
--  "100 Обл.ставка НБУ" с 27/10/2017 устанавливается равной 13.5 %  
--                                                             
----------------------------------------------------------------------

exec tuda;

BEGIN
  INSERT INTO BR_NORMAL_EDIT ( BR_ID, BDATE, KV, RATE ) VALUES ( 
  100,  TO_Date( '27/10/2017', 'DD/MM/YYYY'), 980, 13.5 ); 
EXCEPTION WHEN OTHERS then           
  null;
END;
/

BEGIN
  INSERT INTO BR_NORMAL_EDIT ( BR_ID, BDATE, KV, RATE ) VALUES ( 
  100,  TO_Date( '27/10/2017', 'DD/MM/YYYY'), 840, 13.5 ); 
EXCEPTION WHEN OTHERS then           
  null;
END;
/

BEGIN
  INSERT INTO BR_NORMAL_EDIT ( BR_ID, BDATE, KV, RATE ) VALUES ( 
  100,  TO_Date( '27/10/2017', 'DD/MM/YYYY'), 978, 13.5 ); 
EXCEPTION WHEN OTHERS then           
  null;
END;
/

BEGIN
  INSERT INTO BR_NORMAL_EDIT ( BR_ID, BDATE, KV, RATE ) VALUES ( 
  100,  TO_Date( '27/10/2017', 'DD/MM/YYYY'), 643, 13.5 ); 
EXCEPTION WHEN OTHERS then           
  null;
END;
/

exec suda;


COMMIT;
