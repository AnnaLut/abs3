begin
Insert into BARS.W4_STO_TTS
   (TT, DESCRIPTION)
 Values
   ('G4W', '�������� ��� �190 �� WAY4');
exception when dup_val_on_index then null;   
end;
/  
COMMIT;
