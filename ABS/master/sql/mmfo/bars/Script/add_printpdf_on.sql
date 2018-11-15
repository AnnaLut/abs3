begin
    /*для отключения-включения печати PDF для ДКБО */        
    BAU.ADD_NEW_ATTRIBUTE('OWENABLEEA', 'Друк PDF для ДКБО (1-PDF, 0-DOC)');    
    /*включаем печать*/
    BAU.SET_ATTRIBUTE_VALUE('/','OWENABLEEA',1);  
end;
/
commit; 