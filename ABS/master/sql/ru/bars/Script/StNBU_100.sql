----------------------------------------------------------------------
--
--  "100 Обл.ставка НБУ" с 26/01/2018 устанавливается равной 16 %  
--                                                             
----------------------------------------------------------------------

exec tuda;

BEGIN
  INSERT INTO BR_NORMAL_EDIT ( BR_ID, BDATE, KV, RATE ) VALUES ( 
  100,  TO_Date( '26/01/2018', 'DD/MM/YYYY'), 980, 16 ); 
EXCEPTION WHEN OTHERS then           
  null;
END;
/

BEGIN
  INSERT INTO BR_NORMAL_EDIT ( BR_ID, BDATE, KV, RATE ) VALUES ( 
  100,  TO_Date( '26/01/2018', 'DD/MM/YYYY'), 840, 16 ); 
EXCEPTION WHEN OTHERS then           
  null;
END;
/

BEGIN
  INSERT INTO BR_NORMAL_EDIT ( BR_ID, BDATE, KV, RATE ) VALUES ( 
  100,  TO_Date( '26/01/2018', 'DD/MM/YYYY'), 978, 16 ); 
EXCEPTION WHEN OTHERS then           
  null;
END;
/

BEGIN
  INSERT INTO BR_NORMAL_EDIT ( BR_ID, BDATE, KV, RATE ) VALUES ( 
  100,  TO_Date( '26/01/2018', 'DD/MM/YYYY'), 643, 16 ); 
EXCEPTION WHEN OTHERS then           
  null;
END;
/

exec suda;


COMMIT;
