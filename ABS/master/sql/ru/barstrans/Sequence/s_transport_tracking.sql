begin 
 execute immediate 'create sequence BARSTRANS.S_TRANSPORT_TRACKING
minvalue 1
maxvalue 9999999999999999999999999999
start with 81
increment by 1
cache 20';
exception when others then if (sqlcode = -00955) then null; else raise; end if;
end;
/ 