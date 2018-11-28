

PROMPT ===================================================================================== 
PROMPT *** Run *** ========== Scripts /Sql/BARS/Table/DICT_DMSU_DEPTS.sql =========*** Run *
PROMPT ===================================================================================== 


PROMPT *** ALTER_POLICY_INFO to DICT_DMSU_DEPTS ***


BEGIN 
        execute immediate  
          'begin  
               bpa.alter_policy_info(''DICT_DMSU_DEPTS'', ''WHOLE'' , null, null, null, null);
               null;
           end; 
          '; 
END; 
/

PROMPT *** Create  table DICT_DMSU_DEPTS ***
begin 
  execute immediate '
  CREATE TABLE BARS.DICT_DMSU_DEPTS 
   (	ID NUMBER(*,0), 
	CODE VARCHAR2(10), 
	NAME VARCHAR2(1000), 
	IS_ACTIVE NUMBER(*,0), 
	VALID_FROM DATE, 
	VALID_TO DATE, 
	LAST_DT DATE, 
	LAST_USER VARCHAR2(100)
   ) SEGMENT CREATION IMMEDIATE 
  PCTFREE 10 PCTUSED 40 INITRANS 1 MAXTRANS 255 
 NOCOMPRESS LOGGING
  TABLESPACE BRSDYND ';
exception when others then       
  if sqlcode=-955 then null; else raise; end if; 
end; 
/




PROMPT *** ALTER_POLICIES to DICT_DMSU_DEPTS ***
 exec bpa.alter_policies('DICT_DMSU_DEPTS');


COMMENT ON TABLE BARS.DICT_DMSU_DEPTS IS '';
COMMENT ON COLUMN BARS.DICT_DMSU_DEPTS.ID IS '';
COMMENT ON COLUMN BARS.DICT_DMSU_DEPTS.CODE IS '';
COMMENT ON COLUMN BARS.DICT_DMSU_DEPTS.NAME IS '';
COMMENT ON COLUMN BARS.DICT_DMSU_DEPTS.IS_ACTIVE IS '';
COMMENT ON COLUMN BARS.DICT_DMSU_DEPTS.VALID_FROM IS '';
COMMENT ON COLUMN BARS.DICT_DMSU_DEPTS.VALID_TO IS '';
COMMENT ON COLUMN BARS.DICT_DMSU_DEPTS.LAST_DT IS '';
COMMENT ON COLUMN BARS.DICT_DMSU_DEPTS.LAST_USER IS '';




PROMPT *** Create  constraint SYS_C0028678 ***
begin   
 execute immediate '
  ALTER TABLE BARS.DICT_DMSU_DEPTS MODIFY (ID NOT NULL ENABLE)';
exception when others then
  if  sqlcode=-2260 or sqlcode=-2261 or sqlcode=-2264 or sqlcode=-2275 or sqlcode=-1442 then null; else raise; end if;
 end;
/




PROMPT *** Create  constraint SYS_C0028679 ***
begin   
 execute immediate '
  ALTER TABLE BARS.DICT_DMSU_DEPTS MODIFY (NAME NOT NULL ENABLE)';
exception when others then
  if  sqlcode=-2260 or sqlcode=-2261 or sqlcode=-2264 or sqlcode=-2275 or sqlcode=-1442 then null; else raise; end if;
 end;
/




PROMPT *** Create  constraint PK_DICT_DMSU ***
begin   
 execute immediate '
  ALTER TABLE BARS.DICT_DMSU_DEPTS ADD CONSTRAINT PK_DICT_DMSU PRIMARY KEY (ID)
  USING INDEX PCTFREE 10 INITRANS 2 MAXTRANS 255 COMPUTE STATISTICS 
  TABLESPACE BRSDYND  ENABLE';
exception when others then
  if  sqlcode=-2260 or sqlcode=-2261 or sqlcode=-2264 or sqlcode=-2275 or sqlcode=-1442 then null; else raise; end if;
 end;
/




PROMPT *** Create  index IDX_DICX_DMSU ***
begin   
 execute immediate '
  CREATE INDEX BARS.IDX_DICX_DMSU ON BARS.DICT_DMSU_DEPTS (CODE) 
  PCTFREE 10 INITRANS 2 MAXTRANS 255 COMPUTE STATISTICS 
  TABLESPACE BRSDYND ';
exception when others then
  if  sqlcode=-955  then null; else raise; end if;
 end;
/




PROMPT *** Create  index PK_DICT_DMSU ***
begin   
 execute immediate '
  CREATE UNIQUE INDEX BARS.PK_DICT_DMSU ON BARS.DICT_DMSU_DEPTS (ID) 
  PCTFREE 10 INITRANS 2 MAXTRANS 255 COMPUTE STATISTICS 
  TABLESPACE BRSDYND ';
exception when others then
  if  sqlcode=-955  then null; else raise; end if;
 end;
/





PROMPT ===================================================================================== 
PROMPT *** End *** ========== Scripts /Sql/BARS/Table/DICT_DMSU_DEPTS.sql =========*** End *
PROMPT ===================================================================================== 
