begin
  execute immediate 'DROP TRIGGER bars.DDDDDDD';
    dbms_output.put_line('DROP TRIGGER bars.DDDDDDD.'); 
exception
  when others then
    if sqlcode = -04080 then
         null;
    else raise;
    end if;
end;
/


begin
  execute immediate 'alter table CC_SOB   drop constraint FK1_CC_SOB';
    dbms_output.put_line('Drop constraint FK1_CC_SOB.'); 
exception
  when others then
    if sqlcode = -02443 then
         null;
    else raise;
    end if;
end;
/