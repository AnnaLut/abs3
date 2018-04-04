begin
Insert into BARS.FLAGS
   (CODE, NAME, EDIT, OPT)
 Values
   (19, 'Дебет завжди вгорі(заміна DEP_UP)', 1, 0);
exception when dup_val_on_index then null;
end ;   
/ 
COMMIT;



update tts set flags=substr(flags,1,19)||'1'||substr(flags,21) where tt in ( '901','428','429');
/
commit; 