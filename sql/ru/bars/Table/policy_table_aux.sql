

PROMPT ===================================================================================== 
PROMPT *** Run *** ========== Scripts /Sql/BARS/Table/POLICY_TABLE_AUX.sql =========*** Run 
PROMPT ===================================================================================== 


PROMPT *** ALTER_POLICY_INFO to POLICY_TABLE_AUX ***


BEGIN 
        execute immediate  
          'begin  
               null;
           end; 
          '; 
END; 
/

PROMPT *** Create  table POLICY_TABLE_AUX ***
begin 
  execute immediate '
  CREATE TABLE BARS.POLICY_TABLE_AUX 
   (	TABLE_NAME VARCHAR2(30), 
	POLICY_GROUP VARCHAR2(30), 
	OWNER VARCHAR2(30), 
	CHILDSTATE VARCHAR2(30), 
	PARENTSTATE VARCHAR2(30), 
	SNAPSHOTCHILD NUMBER(*,0), 
	VERSIONCHILD NUMBER(*,0), 
	SNAPSHOTPARENT NUMBER(*,0), 
	VERSIONPARENT NUMBER(*,0), 
	VALUE VARCHAR2(1), 
	WM_OPCODE VARCHAR2(3)
   ) SEGMENT CREATION IMMEDIATE 
  PCTFREE 10 PCTUSED 40 INITRANS 1 MAXTRANS 255 
 NOCOMPRESS LOGGING
  TABLESPACE BRSSMLD ';
exception when others then       
  if sqlcode=-955 then null; else raise; end if; 
end; 
/




PROMPT *** ALTER_POLICIES to POLICY_TABLE_AUX ***
 exec bpa.alter_policies('POLICY_TABLE_AUX');


COMMENT ON TABLE BARS.POLICY_TABLE_AUX IS '';
COMMENT ON COLUMN BARS.POLICY_TABLE_AUX.TABLE_NAME IS '';
COMMENT ON COLUMN BARS.POLICY_TABLE_AUX.POLICY_GROUP IS '';
COMMENT ON COLUMN BARS.POLICY_TABLE_AUX.OWNER IS '';
COMMENT ON COLUMN BARS.POLICY_TABLE_AUX.CHILDSTATE IS '';
COMMENT ON COLUMN BARS.POLICY_TABLE_AUX.PARENTSTATE IS '';
COMMENT ON COLUMN BARS.POLICY_TABLE_AUX.SNAPSHOTCHILD IS '';
COMMENT ON COLUMN BARS.POLICY_TABLE_AUX.VERSIONCHILD IS '';
COMMENT ON COLUMN BARS.POLICY_TABLE_AUX.SNAPSHOTPARENT IS '';
COMMENT ON COLUMN BARS.POLICY_TABLE_AUX.VERSIONPARENT IS '';
COMMENT ON COLUMN BARS.POLICY_TABLE_AUX.VALUE IS '';
COMMENT ON COLUMN BARS.POLICY_TABLE_AUX.WM_OPCODE IS '';




PROMPT *** Create  constraint AUX_POLICY_TABLE ***
begin   
 execute immediate '
  ALTER TABLE BARS.POLICY_TABLE_AUX ADD CONSTRAINT AUX_POLICY_TABLE PRIMARY KEY (TABLE_NAME, POLICY_GROUP, OWNER, CHILDSTATE, PARENTSTATE)
  USING INDEX PCTFREE 10 INITRANS 2 MAXTRANS 255 COMPUTE STATISTICS 
  TABLESPACE BRSSMLI  ENABLE';
exception when others then
  if  sqlcode=-2260 or sqlcode=-2261 or sqlcode=-2264 or sqlcode=-2275 or sqlcode=-1442 then null; else raise; end if;
 end;
/




PROMPT *** Create  index AUX_POLICY_TABLE ***
begin   
 execute immediate '
  CREATE UNIQUE INDEX BARS.AUX_POLICY_TABLE ON BARS.POLICY_TABLE_AUX (TABLE_NAME, POLICY_GROUP, OWNER, CHILDSTATE, PARENTSTATE) 
  PCTFREE 10 INITRANS 2 MAXTRANS 255 COMPUTE STATISTICS 
  TABLESPACE BRSSMLI ';
exception when others then
  if  sqlcode=-955  then null; else raise; end if;
 end;
/




PROMPT *** Create  index POLICY_TABLE_AP1$ ***
begin   
 execute immediate '
  CREATE INDEX BARS.POLICY_TABLE_AP1$ ON BARS.POLICY_TABLE_AUX (PARENTSTATE, VERSIONPARENT) 
  PCTFREE 10 INITRANS 2 MAXTRANS 255 COMPUTE STATISTICS 
  TABLESPACE BRSSMLI ';
exception when others then
  if  sqlcode=-955  then null; else raise; end if;
 end;
/




PROMPT *** Create  index POLICY_TABLE_AP2$ ***
begin   
 execute immediate '
  CREATE INDEX BARS.POLICY_TABLE_AP2$ ON BARS.POLICY_TABLE_AUX (CHILDSTATE, VERSIONCHILD) 
  PCTFREE 10 INITRANS 2 MAXTRANS 255 COMPUTE STATISTICS 
  TABLESPACE BRSSMLI ';
exception when others then
  if  sqlcode=-955  then null; else raise; end if;
 end;
/



PROMPT *** Create  grants  POLICY_TABLE_AUX ***
grant DELETE,FLASHBACK,INSERT,SELECT,UPDATE                                  on POLICY_TABLE_AUX to WR_ALL_RIGHTS;



PROMPT ===================================================================================== 
PROMPT *** End *** ========== Scripts /Sql/BARS/Table/POLICY_TABLE_AUX.sql =========*** End 
PROMPT ===================================================================================== 
