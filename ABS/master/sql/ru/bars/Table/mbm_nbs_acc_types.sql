exec BARS_POLICY_ADM.ALTER_POLICY_INFO('MBM_NBS_ACC_TYPES','WHOLE', null, null, null, null);
exec BARS_POLICY_ADM.ALTER_POLICY_INFO('MBM_NBS_ACC_TYPES','FILIAL', null, null, null, null);

begin
  execute immediate 
'CREATE TABLE MBM_NBS_ACC_TYPES
(
  NBS      VARCHAR2(4) CONSTRAINT CC_MBM_NBSACCTYPES_TYPEID_NN NOT NULL,
  TYPE_ID  VARCHAR2(30) CONSTRAINT CC_MBM_NBSACCTYPES_NAME_NN NOT NULL
)';
exception
  when others then if (sqlcode = -955) then null; else raise; end if;
end;
/

begin   
 execute immediate '
  ALTER TABLE BARS.MBM_NBS_ACC_TYPES ADD CONSTRAINT PK_MBM_NBSACCTYPES PRIMARY KEY (NBS, TYPE_ID)
  USING INDEX PCTFREE 10 INITRANS 2 MAXTRANS 255 COMPUTE STATISTICS 
  TABLESPACE BRSSMLI  ENABLE';
exception when others then
  if  sqlcode=-2260 or sqlcode=-2261 or sqlcode=-2264 or sqlcode=-2275 or sqlcode=-1442 then null; else raise; end if;
 end;
/

COMMENT ON TABLE MBM_NBS_ACC_TYPES IS 'Типи рахунків(спрощений розподіл) по відношенню NBS';
COMMENT ON COLUMN MBM_NBS_ACC_TYPES.NBS IS 'План рахунку';
COMMENT ON COLUMN MBM_NBS_ACC_TYPES.TYPE_ID IS 'Код типу рахунку';

-- Index PK_MBM_NBSACCTYPES is created automatically by Oracle with index organized table MBM_NBS_ACC_TYPES.

GRANT ALL ON MBM_NBS_ACC_TYPES TO BARS_ACCESS_DEFROLE;
