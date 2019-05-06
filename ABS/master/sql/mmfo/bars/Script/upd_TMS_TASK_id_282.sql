



 exec bc.go('/');

 update TMS_TASK set  
   TASK_STATEMENT = 'begin if trunc(gl.bd,''MM'')<trunc(DAT_NEXT_U(gl.bd,1),''MM'') then RKO.ACR(1, last_day(gl.BD), NULL); RKO.PAY(1, gl.BD, NULL); end if; end ;' 
     where ID = 282 and TASK_CODE = 'RKO1' ;

 COMMIT;

