begin    
    update rep_proc 
    set name = 'P_F01_NC'
    where procc = '2';
    
	commit;
	
    update rep_proc 
    set name = 'P_F02_NC'
    where procc = '3';
	
	commit;
end;
/