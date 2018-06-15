begin 
  execute immediate 'alter table EAD_SYNC_QUEUE rename to TMP_old_EAD_SYNC_QUEUE';
end;
/
begin 
  execute immediate 'alter table TMP_EAD_SYNC_QUEUE rename to EAD_SYNC_QUEUE';
end;
/