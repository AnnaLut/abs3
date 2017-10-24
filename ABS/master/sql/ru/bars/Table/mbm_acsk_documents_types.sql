exec BARS_POLICY_ADM.ALTER_POLICY_INFO('MBM_ACSK_DOCUMENTS_TYPES','WHOLE', null, null, null, null);
exec BARS_POLICY_ADM.ALTER_POLICY_INFO('MBM_ACSK_DOCUMENTS_TYPES','FILIAL', null, null, null, null);

begin
  execute immediate 
'CREATE TABLE MBM_ACSK_DOCUMENTS_TYPES
(
  ID   			    NUMBER,
  NAME          VARCHAR2(200)
)';
exception
  when others then if (sqlcode = -955) then null; else raise; end if;
end;
/

begin   
 execute immediate '
  ALTER TABLE BARS.MBM_ACSK_DOCUMENTS_TYPES ADD CONSTRAINT PK_MBM_ACSK_DOCUMENTS_TYPES_ID PRIMARY KEY (ID)
  USING INDEX PCTFREE 10 INITRANS 2 MAXTRANS 255 COMPUTE STATISTICS 
  TABLESPACE BRSSMLI  ENABLE';
exception when others then
  if  sqlcode=-2260 or sqlcode=-2261 or sqlcode=-2264 or sqlcode=-2275 or sqlcode=-1442 then null; else raise; end if;
 end;
/

COMMENT ON TABLE MBM_ACSK_DOCUMENTS_TYPES IS 'Довідник типів документів АЦСК';

grant all on MBM_ACSK_DOCUMENTS_TYPES to bars_access_defrole;