exec BARS_POLICY_ADM.ALTER_POLICY_INFO('MBM_PARAMETERS','WHOLE', null, null, null, null);
exec BARS_POLICY_ADM.ALTER_POLICY_INFO('MBM_PARAMETERS','FILIAL', null, null, null, null);

begin
  execute immediate 
'CREATE TABLE MBM_PARAMETERS
(
  PARAMETER_NAME   VARCHAR2(30 BYTE),
  PARAMETER_VALUE  VARCHAR2(256 BYTE),
  DESCRIPTION      VARCHAR2(4000 BYTE)
)';
exception
  when others then if (sqlcode = -955) then null; else raise; end if;
end;
/

begin   
 execute immediate '
  ALTER TABLE BARS.MBM_PARAMETERS ADD CONSTRAINT PK_MBM_PARAMETERS_PARAMETER_NAME PRIMARY KEY (PARAMETER_NAME)
  USING INDEX PCTFREE 10 INITRANS 2 MAXTRANS 255 COMPUTE STATISTICS 
  TABLESPACE BRSSMLI  ENABLE';
exception when others then
  if  sqlcode=-2260 or sqlcode=-2261 or sqlcode=-2264 or sqlcode=-2275 or sqlcode=-1442 then null; else raise; end if;
 end;
/


COMMENT ON TABLE MBM_PARAMETERS IS 'Module parameters';
COMMENT ON COLUMN MBM_PARAMETERS.PARAMETER_NAME IS 'Parameter name';
COMMENT ON COLUMN MBM_PARAMETERS.PARAMETER_VALUE IS 'Parameter value';
COMMENT ON COLUMN MBM_PARAMETERS.DESCRIPTION IS 'Parameter description';

GRANT ALL ON MBM_PARAMETERS TO BARS_ACCESS_DEFROLE;

