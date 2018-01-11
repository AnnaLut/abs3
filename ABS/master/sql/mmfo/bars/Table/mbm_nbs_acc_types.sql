

PROMPT ===================================================================================== 
PROMPT *** Run *** ========== Scripts /Sql/BARS/Table/MBM_NBS_ACC_TYPES.sql =========*** Run
PROMPT ===================================================================================== 


PROMPT *** ALTER_POLICY_INFO to MBM_NBS_ACC_TYPES ***


BEGIN 
        execute immediate  
          'begin  
               bpa.alter_policy_info(''MBM_NBS_ACC_TYPES'', ''FILIAL'' , null, null, null, null);
               bpa.alter_policy_info(''MBM_NBS_ACC_TYPES'', ''WHOLE'' , null, null, null, null);
               null;
           end; 
          '; 
END; 
/

PROMPT *** Create  table MBM_NBS_ACC_TYPES ***
begin 
  execute immediate '
  CREATE TABLE BARS.MBM_NBS_ACC_TYPES 
   (	NBS VARCHAR2(4), 
	TYPE_ID VARCHAR2(30)
   ) SEGMENT CREATION IMMEDIATE 
  PCTFREE 10 PCTUSED 40 INITRANS 1 MAXTRANS 255 
 NOCOMPRESS LOGGING
  TABLESPACE BRSDYND ';
exception when others then       
  if sqlcode=-955 then null; else raise; end if; 
end; 
/




PROMPT *** ALTER_POLICIES to MBM_NBS_ACC_TYPES ***
 exec bpa.alter_policies('MBM_NBS_ACC_TYPES');


COMMENT ON TABLE BARS.MBM_NBS_ACC_TYPES IS 'Типи рахунків(спрощений розподіл) по відношенню NBS';
COMMENT ON COLUMN BARS.MBM_NBS_ACC_TYPES.NBS IS 'План рахунку';
COMMENT ON COLUMN BARS.MBM_NBS_ACC_TYPES.TYPE_ID IS 'Код типу рахунку';




PROMPT *** Create  constraint CC_MBM_NBSACCTYPES_TYPEID_NN ***
begin   
 execute immediate '
  ALTER TABLE BARS.MBM_NBS_ACC_TYPES MODIFY (NBS CONSTRAINT CC_MBM_NBSACCTYPES_TYPEID_NN NOT NULL ENABLE)';
exception when others then
  if  sqlcode=-2260 or sqlcode=-2261 or sqlcode=-2264 or sqlcode=-2275 or sqlcode=-1442 then null; else raise; end if;
 end;
/




PROMPT *** Create  constraint CC_MBM_NBSACCTYPES_NAME_NN ***
begin   
 execute immediate '
  ALTER TABLE BARS.MBM_NBS_ACC_TYPES MODIFY (TYPE_ID CONSTRAINT CC_MBM_NBSACCTYPES_NAME_NN NOT NULL ENABLE)';
exception when others then
  if  sqlcode=-2260 or sqlcode=-2261 or sqlcode=-2264 or sqlcode=-2275 or sqlcode=-1442 then null; else raise; end if;
 end;
/




PROMPT *** Create  constraint PK_MBM_NBSACCTYPES ***
begin   
 execute immediate '
  ALTER TABLE BARS.MBM_NBS_ACC_TYPES ADD CONSTRAINT PK_MBM_NBSACCTYPES PRIMARY KEY (NBS, TYPE_ID)
  USING INDEX PCTFREE 10 INITRANS 2 MAXTRANS 255 COMPUTE STATISTICS 
  TABLESPACE BRSDYND  ENABLE';
exception when others then
  if  sqlcode=-2260 or sqlcode=-2261 or sqlcode=-2264 or sqlcode=-2275 or sqlcode=-1442 then null; else raise; end if;
 end;
/




PROMPT *** Create  index PK_MBM_NBSACCTYPES ***
begin   
 execute immediate '
  CREATE UNIQUE INDEX BARS.PK_MBM_NBSACCTYPES ON BARS.MBM_NBS_ACC_TYPES (NBS, TYPE_ID) 
  PCTFREE 10 INITRANS 2 MAXTRANS 255 COMPUTE STATISTICS 
  TABLESPACE BRSDYND ';
exception when others then
  if  sqlcode=-955  then null; else raise; end if;
 end;
/



PROMPT *** Create  grants  MBM_NBS_ACC_TYPES ***
grant SELECT                                                                 on MBM_NBS_ACC_TYPES to BARSREADER_ROLE;
grant ALTER,DEBUG,DELETE,FLASHBACK,INSERT,ON COMMIT REFRESH,QUERY REWRITE,SELECT,UPDATE on MBM_NBS_ACC_TYPES to BARS_ACCESS_DEFROLE;
grant SELECT                                                                 on MBM_NBS_ACC_TYPES to UPLD;



PROMPT ===================================================================================== 
PROMPT *** End *** ========== Scripts /Sql/BARS/Table/MBM_NBS_ACC_TYPES.sql =========*** End
PROMPT ===================================================================================== 
