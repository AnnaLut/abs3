begin
  execute immediate 'CREATE SEQUENCE S_AUD
						START WITH 1
						MAXVALUE 9999999999
						MINVALUE 1
						NOCYCLE
						CACHE 20
						NOORDER';
exception
  when others then if (sqlcode = -955) then null; else raise; end if;
end;
/