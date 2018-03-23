begin
  execute immediate 'create sequence S_CCK_CC_LIM_COPY
minvalue 0
maxvalue 999999999999999999999999999
start with 1
increment by 1
cache 20';
exception
  when others then
    if sqlcode = -955 then
      null;
    else 
      raise;
    end if;
end;
/