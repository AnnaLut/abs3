

PROMPT ===================================================================================== 
PROMPT *** Run *** ========== Scripts /Sql/BARS/Table/TMP_SW_REG_DIRS.sql =========*** Run *
PROMPT ===================================================================================== 


PROMPT *** ALTER_POLICY_INFO to TMP_SW_REG_DIRS ***


BEGIN 
        execute immediate  
          'begin  
               null;
           end; 
          '; 
END; 
/

PROMPT *** Create  table TMP_SW_REG_DIRS ***
begin 
  execute immediate '
  CREATE TABLE BARS.TMP_SW_REG_DIRS 
   (	RNK NUMBER(38,0), 
	DIR VARCHAR2(50), 
	KF VARCHAR2(6)
   ) SEGMENT CREATION IMMEDIATE 
  PCTFREE 10 PCTUSED 40 INITRANS 1 MAXTRANS 255 
 NOCOMPRESS LOGGING
  TABLESPACE BRSDYND ';
exception when others then       
  if sqlcode=-955 then null; else raise; end if; 
end; 
/




PROMPT *** ALTER_POLICIES to TMP_SW_REG_DIRS ***
 exec bpa.alter_policies('TMP_SW_REG_DIRS');


COMMENT ON TABLE BARS.TMP_SW_REG_DIRS IS '';
COMMENT ON COLUMN BARS.TMP_SW_REG_DIRS.RNK IS '';
COMMENT ON COLUMN BARS.TMP_SW_REG_DIRS.DIR IS '';
COMMENT ON COLUMN BARS.TMP_SW_REG_DIRS.KF IS '';




PROMPT *** Create  constraint SYS_C00119337 ***
begin   
 execute immediate '
  ALTER TABLE BARS.TMP_SW_REG_DIRS MODIFY (RNK NOT NULL ENABLE)';
exception when others then
  if  sqlcode=-2260 or sqlcode=-2261 or sqlcode=-2264 or sqlcode=-2275 or sqlcode=-1442 then null; else raise; end if;
 end;
/




PROMPT *** Create  constraint SYS_C00119338 ***
begin   
 execute immediate '
  ALTER TABLE BARS.TMP_SW_REG_DIRS MODIFY (DIR NOT NULL ENABLE)';
exception when others then
  if  sqlcode=-2260 or sqlcode=-2261 or sqlcode=-2264 or sqlcode=-2275 or sqlcode=-1442 then null; else raise; end if;
 end;
/




PROMPT *** Create  constraint SYS_C00119339 ***
begin   
 execute immediate '
  ALTER TABLE BARS.TMP_SW_REG_DIRS MODIFY (KF NOT NULL ENABLE)';
exception when others then
  if  sqlcode=-2260 or sqlcode=-2261 or sqlcode=-2264 or sqlcode=-2275 or sqlcode=-1442 then null; else raise; end if;
 end;
/



PROMPT *** Create  grants  TMP_SW_REG_DIRS ***
grant SELECT                                                                 on TMP_SW_REG_DIRS to BARSREADER_ROLE;
grant SELECT                                                                 on TMP_SW_REG_DIRS to UPLD;



PROMPT ===================================================================================== 
PROMPT *** End *** ========== Scripts /Sql/BARS/Table/TMP_SW_REG_DIRS.sql =========*** End *
PROMPT ===================================================================================== 
