begin
execute immediate(
'create sequence SAGO_DOCUMENTS_SEQ
minvalue 1
maxvalue 9999999999999999999999999999
start with 1
increment by 1
cache 20');

exception when others then
  if sqlcode= -955 then 
     null;
  end if; 

end;
/
