exec BARS_POLICY_ADM.ALTER_POLICY_INFO('BARS_DBO_AUDIT','WHOLE', null, null, null, null);

exec BARS_POLICY_ADM.ALTER_POLICY_INFO('BARS_DBO_AUDIT','FILIAL', null, null, null, null);

begin
  execute immediate 'CREATE TABLE BARS_DBO_AUDIT
						(
						TIME       DATE,
						INNER_XML  CLOB,
						ID         NUMBER,
						OUTXML     CLOB
						)
					TABLESPACE  BRSDYND';
exception
  when others then if (sqlcode = -955) then null; else raise; end if;
end;
/

begin
  execute immediate 'CREATE UNIQUE INDEX PK_BARS_DBO_AUDIT ON BARS_DBO_AUDIT (ID)';
exception
  when others then if (sqlcode = -955) then null; else raise; end if;
end;
/

begin
  execute immediate 'ALTER TABLE BARS_DBO_AUDIT ADD (
						CONSTRAINT PK_BARS_DBO_AUDIT
						PRIMARY KEY
						(ID)
						USING INDEX PK_BARS_DBO_AUDIT
						ENABLE VALIDATE)';
exception
  when others then if (sqlcode = -2260) then null; else raise; end if;
end;
/

