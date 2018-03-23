----------------------------------------------------------------------
--
--  Базовая ставка 100 "Обл.ставка НБУ" с 02/03/2018 устанавливается равной 17 %  
--                                                             
----------------------------------------------------------------------

exec tuda;

BEGIN
  INSERT INTO BR_NORMAL_EDIT ( BR_ID, BDATE, KV, RATE ) VALUES ( 
  100,  TO_Date( '02/03/2018', 'DD/MM/YYYY'), 980, 17 ); 
EXCEPTION WHEN OTHERS then           
  null;
END;
/

BEGIN
  INSERT INTO BR_NORMAL_EDIT ( BR_ID, BDATE, KV, RATE ) VALUES ( 
  100,  TO_Date( '02/03/2018', 'DD/MM/YYYY'), 840, 17 ); 
EXCEPTION WHEN OTHERS then           
  null;
END;
/

BEGIN
  INSERT INTO BR_NORMAL_EDIT ( BR_ID, BDATE, KV, RATE ) VALUES ( 
  100,  TO_Date( '02/03/2018', 'DD/MM/YYYY'), 978, 17 ); 
EXCEPTION WHEN OTHERS then           
  null;
END;
/

BEGIN
  INSERT INTO BR_NORMAL_EDIT ( BR_ID, BDATE, KV, RATE ) VALUES ( 
  100,  TO_Date( '02/03/2018', 'DD/MM/YYYY'), 643, 17 ); 
EXCEPTION WHEN OTHERS then           
  null;
END;
/

exec suda;


COMMIT;
