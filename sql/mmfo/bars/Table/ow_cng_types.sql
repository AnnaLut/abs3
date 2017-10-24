

PROMPT ===================================================================================== 
PROMPT *** Run *** ========== Scripts /Sql/BARS/Table/OW_CNG_TYPES.sql =========*** Run *** 
PROMPT ===================================================================================== 


PROMPT *** ALTER_POLICY_INFO to OW_CNG_TYPES ***


BEGIN 
        execute immediate  
          'begin  
               bpa.alter_policy_info(''OW_CNG_TYPES'', ''FILIAL'' , null, ''E'', ''E'', ''E'');
               bpa.alter_policy_info(''OW_CNG_TYPES'', ''WHOLE'' , null, null, null, null);
               null;
           end; 
          '; 
END; 
/

PROMPT *** Create  table OW_CNG_TYPES ***
begin 
  execute immediate '
  CREATE TABLE BARS.OW_CNG_TYPES 
   (	ID NUMBER, 
	NBS_OW VARCHAR2(15), 
	NBS VARCHAR2(15), 
	DESCR VARCHAR2(4000)
   ) SEGMENT CREATION IMMEDIATE 
  PCTFREE 10 PCTUSED 40 INITRANS 1 MAXTRANS 255 
 NOCOMPRESS LOGGING
  TABLESPACE BRSDYND ';
exception when others then       
  if sqlcode=-955 then null; else raise; end if; 
end; 
/




PROMPT *** ALTER_POLICIES to OW_CNG_TYPES ***
 exec bpa.alter_policies('OW_CNG_TYPES');


COMMENT ON TABLE BARS.OW_CNG_TYPES IS '';
COMMENT ON COLUMN BARS.OW_CNG_TYPES.ID IS '';
COMMENT ON COLUMN BARS.OW_CNG_TYPES.NBS_OW IS '';
COMMENT ON COLUMN BARS.OW_CNG_TYPES.NBS IS '';
COMMENT ON COLUMN BARS.OW_CNG_TYPES.DESCR IS '';




PROMPT *** Create  constraint PK_OWCNGTYPES ***
begin   
 execute immediate '
  ALTER TABLE BARS.OW_CNG_TYPES ADD CONSTRAINT PK_OWCNGTYPES PRIMARY KEY (NBS_OW)
  USING INDEX PCTFREE 10 INITRANS 2 MAXTRANS 255 COMPUTE STATISTICS 
  TABLESPACE BRSDYND  ENABLE';
exception when others then
  if  sqlcode=-2260 or sqlcode=-2261 or sqlcode=-2264 or sqlcode=-2275 or sqlcode=-1442 then null; else raise; end if;
 end;
/




PROMPT *** Create  constraint CC_OWCNGTYPES_NBS_OW_NN ***
begin   
 execute immediate '
  ALTER TABLE BARS.OW_CNG_TYPES MODIFY (NBS_OW CONSTRAINT CC_OWCNGTYPES_NBS_OW_NN NOT NULL ENABLE)';
exception when others then
  if  sqlcode=-2260 or sqlcode=-2261 or sqlcode=-2264 or sqlcode=-2275 or sqlcode=-1442 then null; else raise; end if;
 end;
/




PROMPT *** Create  index PK_OWCNGTYPES ***
begin   
 execute immediate '
  CREATE UNIQUE INDEX BARS.PK_OWCNGTYPES ON BARS.OW_CNG_TYPES (NBS_OW) 
  PCTFREE 10 INITRANS 2 MAXTRANS 255 COMPUTE STATISTICS 
  TABLESPACE BRSDYND ';
exception when others then
  if  sqlcode=-955  then null; else raise; end if;
 end;
/



PROMPT *** Create  grants  OW_CNG_TYPES ***
grant DELETE,INSERT,SELECT,UPDATE                                            on OW_CNG_TYPES    to BARS_ACCESS_DEFROLE;
grant FLASHBACK,SELECT                                                       on OW_CNG_TYPES    to WR_REFREAD;



PROMPT ===================================================================================== 
PROMPT *** End *** ========== Scripts /Sql/BARS/Table/OW_CNG_TYPES.sql =========*** End *** 
PROMPT ===================================================================================== 
