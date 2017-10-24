declare
L_CODEOPER VARCHAR2(10);
L_KODZ number(10);
begin

    begin
        SELECT CODEOPER
           into L_CODEOPER
          FROM operlist
         WHERE funcname LIKE '%/barsroot/referencebook/referencelist/%';
    exception when no_data_found then  null;    
    end; 
  
     begin
        insert into operapp (codeapp, codeoper, approve)
        values ('$RM_CRPC', L_CODEOPER, 1);
     exception when dup_val_on_index then null;
     end; 

     begin
        insert into operapp (codeapp, codeoper, approve)
        values ('$RM_WVIP', L_CODEOPER, 1);
     exception when dup_val_on_index then null;
     end; 

     begin
        insert into applist_staff(id, codeapp, approve)
        values (3540300 ,'$RM_CRPC', 1);
     exception when dup_val_on_index then null;
     end; 

     begin
        insert into applist_staff(id, codeapp, approve)
        values (3634800 ,'$RM_CRPC', 1);
     exception when dup_val_on_index then null;
     end; 
                   
     begin
        insert into applist_staff(id, codeapp, approve)
        values (3634900 ,'$RM_CRPC', 1);
     exception when dup_val_on_index then null;
     end; 
          
     begin
        insert into applist_staff(id, codeapp, approve)
        values (3650300 ,'$RM_CRPC', 1);
     exception when dup_val_on_index then null;
     end; 

     begin
        insert into applist_staff(id, codeapp, approve)
        values (3663200 ,'$RM_CRPC', 1);
     exception when dup_val_on_index then null;
     end; 
                 
     begin
        insert into applist_staff(id, codeapp, approve)
        values (2009401 ,'$RM_CRPC', 1);
     exception when dup_val_on_index then null;
     end; 

     begin
        insert into applist_staff(id, codeapp, approve)
        values (2009411 ,'$RM_CRPC', 1);
     exception when dup_val_on_index then null;
     end; 

      	    begin
    	  	  SELECT CODEOPER
       		    into L_CODEOPER
       		   FROM operlist
        	 WHERE funcname LIKE '%/barsroot/cbirep/rep_list.aspx?codeapp=\S*%';
	    exception when no_data_found then  null;    
	    end; 
    
     begin
        insert into operapp (codeapp, codeoper, approve)
        values ('$RM_STO', L_CODEOPER, 1);
     exception when dup_val_on_index then null;
     end; 

     begin
        insert into operapp (codeapp, codeoper, approve)
        values ('$RM_STO1', L_CODEOPER, 1);
     exception when dup_val_on_index then null;
     end; 

     begin
        insert into applist_staff(id, codeapp, approve)
        values (2009401 ,'$RM_STO', 1);
     exception when dup_val_on_index then null;
     end; 

     begin
        insert into applist_staff(id, codeapp, approve)
        values (2009411 ,'$RM_STO', 1);
     exception when dup_val_on_index then null;
     end; 

     begin
        insert into applist_staff(id, codeapp, approve)
        values (2009401 ,'$RM_STO1', 1);
     exception when dup_val_on_index then null;
     end; 

     begin
        insert into applist_staff(id, codeapp, approve)
        values (2009411 ,'$RM_STO1', 1);
     exception when dup_val_on_index then null;
     end; 
               

end;
/
commit;