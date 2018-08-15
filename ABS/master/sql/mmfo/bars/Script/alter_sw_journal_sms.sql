begin
execute immediate 'alter table bars.sw_journal add count_send_sms number';
exception when others then if (sqlcode=-1430) then null; else raise; end if;
end;
/

comment on column sw_journal.count_send_sms is 'Відправка смс';
/


begin
Insert into BARS.SW_TT_IMPORT
   (TT, IO_IND, ORD)
 Values
   ('CLG', 'O', 77);
exception when dup_val_on_index then null; 
end;
/
COMMIT;
