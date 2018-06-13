begin
 execute immediate 'insert into /*+APPEND PARALLEL 16*/  TMP_EAD_SYNC_QUEUE  select * from EAD_SYNC_QUEUE';
 commit;
 exception when others then       
null;
end; 
/

