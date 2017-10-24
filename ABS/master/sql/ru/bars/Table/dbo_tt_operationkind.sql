exec BARS_POLICY_ADM.ALTER_POLICY_INFO('DBO_TT_OPERATIONKIND','WHOLE', null, null, null, null);

exec BARS_POLICY_ADM.ALTER_POLICY_INFO('DBO_TT_OPERATIONKIND','FILIAL', null, null, null, null);

begin
  execute immediate 'CREATE TABLE DBO_TT_OPERATIONKIND
						(
							ID              NUMBER(38),
							OPERATION_KIND  NUMBER(38),
							TT              VARCHAR2(3),
							NAME_OPERATION  VARCHAR2(400)
						)';
exception
  when others then if (sqlcode = -955) then null; else raise; end if;
end;
/

begin
  execute immediate 
	'CREATE UNIQUE INDEX DBO_TT_OPERATIONKIND_PK ON DBO_TT_OPERATIONKIND (ID)';
exception
  when others then if (sqlcode = -955) then null; else raise; end if;
end;
/

begin
  execute immediate 'ALTER TABLE DBO_TT_OPERATIONKIND ADD (
						CONSTRAINT DBO_TT_OPERATIONKIND_PK
						PRIMARY KEY
						(ID)
						USING INDEX DBO_TT_OPERATIONKIND_PK
						ENABLE VALIDATE)';
exception
  when others then if (sqlcode = -2260) then null; else raise; end if;
end;
/

GRANT SELECT ON DBO_TT_OPERATIONKIND TO BARS_ACCESS_DEFROLE;
