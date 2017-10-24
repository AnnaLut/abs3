declare
L_CODEOPER VARCHAR2(10);
L_KODZ number(10);
begin
    begin
        SELECT CODEOPER
           into L_CODEOPER
          FROM operlist
         WHERE funcname LIKE '%/barsroot/cbirep/export_dbf.aspx%';
    exception when no_data_found then  null;    
    end; 

     begin
        insert into operapp (codeapp, codeoper, approve)
        values ('$RM_DRU1', L_CODEOPER, 1);
     exception when dup_val_on_index then null;
     end; 

     begin
        insert into operapp (codeapp, codeoper, approve)
        values ('$RM_CRPC', L_CODEOPER, 1);
     exception when dup_val_on_index then null;
     end; 
              
     begin
        insert into applist_staff(id, codeapp, approve)
        values (3540300 ,'$RM_DRU1', 1);
     exception when dup_val_on_index then null;
     end; 

     begin
        insert into applist_staff(id, codeapp, approve)
        values (3540300 ,'$RM_CRPC', 1);
     exception when dup_val_on_index then null;
     end; 

     begin
        insert into applist_staff(id, codeapp, approve)
        values (3634800 ,'$RM_DRU1', 1);
     exception when dup_val_on_index then null;
     end; 

     begin
        insert into applist_staff(id, codeapp, approve)
        values (3634800 ,'$RM_CRPC', 1);
     exception when dup_val_on_index then null;
     end; 
                
     begin
        insert into applist_staff(id, codeapp, approve)
        values (3634900 ,'$RM_DRU1', 1);
     exception when dup_val_on_index then null;
     end; 

     begin
        insert into applist_staff(id, codeapp, approve)
        values (3634900 ,'$RM_CRPC', 1);
     exception when dup_val_on_index then null;
     end; 

          
     begin
        insert into applist_staff(id, codeapp, approve)
        values (3650300 ,'$RM_DRU1', 1);
     exception when dup_val_on_index then null;
     end; 

     begin
        insert into applist_staff(id, codeapp, approve)
        values (3650300 ,'$RM_CRPC', 1);
     exception when dup_val_on_index then null;
     end; 

     begin
        insert into applist_staff(id, codeapp, approve)
        values (3663200 ,'$RM_DRU1', 1);
     exception when dup_val_on_index then null;
     end; 

     begin
        insert into applist_staff(id, codeapp, approve)
        values (3663200 ,'$RM_CRPC', 1);
     exception when dup_val_on_index then null;
     end; 
                   
     begin             
        insert into applist_staff(id, codeapp, approve)
        values (2009401 ,'$RM_DRU1', 1);
     exception when dup_val_on_index then null;
     end; 

     begin             
        insert into applist_staff(id, codeapp, approve)
        values (2009401 ,'$RM_CRPC', 1);
     exception when dup_val_on_index then null;
     end; 

     
    begin
        SELECT KODZ
           into L_KODZ
          from zapros where pkey = '\BRS\SBM\CAC\9';
    exception when no_data_found then  null;    
    end;     

     begin
        insert into ZAPROS_USERS(KODZ, USER_ID)
        values (L_KODZ, 3540300);
     exception when dup_val_on_index then null;
     end;  

     begin
        insert into ZAPROS_USERS(KODZ, USER_ID)
        values (L_KODZ, 3634800);
     exception when dup_val_on_index then null;
     end;  
  
     begin
        insert into ZAPROS_USERS(KODZ, USER_ID)
        values (L_KODZ, 3634900);
     exception when dup_val_on_index then null;
     end;  

     begin
        insert into ZAPROS_USERS(KODZ, USER_ID)
        values (L_KODZ, 3650300);
     exception when dup_val_on_index then null;
     end;  

     begin
        insert into ZAPROS_USERS(KODZ, USER_ID)
        values (L_KODZ, 3663200);
     exception when dup_val_on_index then null;
     end;  

     begin
        insert into ZAPROS_USERS(KODZ, USER_ID)
        values (L_KODZ, 2009401);
     exception when dup_val_on_index then null;
     end;  
     
end;
/
commit;
 