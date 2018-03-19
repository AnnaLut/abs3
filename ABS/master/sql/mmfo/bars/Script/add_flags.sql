begin
Insert into BARS.FLAGS
   (CODE, NAME, EDIT, OPT)
 Values
   (17, 'Редагування сторони А(NLSA,NAMA,IDA)', 1, 0);
exception when dup_val_on_index then null; 
end;    
/
begin
Insert into BARS.FLAGS
   (CODE, NAME, EDIT, OPT)
 Values
   (18, 'Редагування сторони Б(NLSB,NAMB,IDB)', 1, 0);
exception when dup_val_on_index then null; 
end;    
/
COMMIT;


DELETE FROM branch_attribute_value
      WHERE attribute_code = 'DEP_UP' AND branch_code = '\';
/

COMMIT;

UPDATE branch_attribute_value
   SET attribute_value = 0
 WHERE attribute_code = 'DEP_UP';
/

COMMIT;