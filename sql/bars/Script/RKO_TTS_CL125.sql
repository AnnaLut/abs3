-----------------------------------------------------------------------------
--
--                      Задача "Плата за РО".  
--                      ---------------------
--
--  Добавление в список операций, за которые начисляется комиссия, 
--  операций CL1,CL2,CL5
--
-----------------------------------------------------------------------------

begin
   INSERT INTO RKO_TTS ( TT, DK, NTAR ) VALUES ('CL1', 0, 14); 
exception when dup_val_on_index then
   null;
end;
/


begin
   INSERT INTO RKO_TTS ( TT, DK, NTAR ) VALUES ('CL2', 0, 14); 
exception when dup_val_on_index then
   null;
end;
/


begin
   INSERT INTO RKO_TTS ( TT, DK, NTAR ) VALUES ('CL5', 0, 14); 
exception when dup_val_on_index then
   null;
end;
/



begin
   INSERT INTO RKO_TTS ( TT, DK, NTAR ) VALUES ('CL1', 1, 15); 
exception when dup_val_on_index then
   null;
end;
/

COMMIT;