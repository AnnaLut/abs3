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
        values ('WVIP', L_CODEOPER, 1);
     exception when dup_val_on_index then null;
     end; 

end;
/

commit;

declare
L_CODEOPER VARCHAR2(10);
L_KODZ number(10);
begin


     begin
  	  SELECT CODEOPER
  	    into L_CODEOPER
       	   FROM operlist
       	 WHERE funcname LIKE '%/barsroot/cbirep/rep_list.aspx?codeapp=\S*%';
     exception when no_data_found then  null;    
     end; 
    
     begin
        insert into operapp (codeapp, codeoper, approve)
        values ('STO1', L_CODEOPER, 1);
     exception when dup_val_on_index then null;
     end; 

end;
/

commit;

