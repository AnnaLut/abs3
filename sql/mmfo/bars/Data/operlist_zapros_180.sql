declare
L_CODEOPER VARCHAR2(10);
L_KODZ number(10);
begin
     
    begin
        SELECT KODZ
           into L_KODZ
          from zapros where pkey = '\BRS\***\OBP\180';
    exception when no_data_found then  null;    
    end;     

     begin
        insert into ZAPROS_USERS(KODZ, USER_ID)
        values (L_KODZ, 79801);
     exception when dup_val_on_index then null;
     end;  

     begin
        insert into ZAPROS_USERS(KODZ, USER_ID)
        values (L_KODZ, 3669800);
     exception when dup_val_on_index then null;
     end;  

     begin
        insert into ZAPROS_USERS(KODZ, USER_ID)
        values (L_KODZ, 3628911);
     exception when dup_val_on_index then null;
     end;  

     begin
        insert into ZAPROS_USERS(KODZ, USER_ID)
        values (L_KODZ, 2009401);
     exception when dup_val_on_index then null;
     end;  

     begin
        insert into ZAPROS_USERS(KODZ, USER_ID)
        values (L_KODZ, 2009411);
     exception when dup_val_on_index then null;
     end;  
    
end;
/
commit;
 