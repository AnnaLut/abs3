

PROMPT ===================================================================================== 
PROMPT *** Run *** ========== Scripts /Sql/BARS/Table/ESCR_REG_STATUS.sql =========*** Run *
PROMPT ===================================================================================== 


PROMPT *** ALTER_POLICY_INFO to ESCR_REG_STATUS ***


BEGIN 
        execute immediate  
          'begin  
               bpa.alter_policy_info(''ESCR_REG_STATUS'', ''FILIAL'' , null, null, null, null);
               bpa.alter_policy_info(''ESCR_REG_STATUS'', ''WHOLE'' , null, null, null, null);
               null;
           end; 
          '; 
END; 
/

PROMPT *** Create  table ESCR_REG_STATUS ***
begin 
  execute immediate '
  CREATE TABLE BARS.ESCR_REG_STATUS 
   (	ID NUMBER, 
	CODE VARCHAR2(100), 
	NAME VARCHAR2(250), 
	LEVEL_TYPE VARCHAR2(100), 
	PRIORITY NUMBER
   ) SEGMENT CREATION IMMEDIATE 
  PCTFREE 10 PCTUSED 40 INITRANS 1 MAXTRANS 255 
 NOCOMPRESS LOGGING
  TABLESPACE BRSDYND ';
exception when others then       
  if sqlcode=-955 then null; else raise; end if; 
end; 
/




PROMPT *** ALTER_POLICIES to ESCR_REG_STATUS ***
 exec bpa.alter_policies('ESCR_REG_STATUS');


COMMENT ON TABLE BARS.ESCR_REG_STATUS IS '';
COMMENT ON COLUMN BARS.ESCR_REG_STATUS.ID IS '';
COMMENT ON COLUMN BARS.ESCR_REG_STATUS.CODE IS '';
COMMENT ON COLUMN BARS.ESCR_REG_STATUS.NAME IS '';
COMMENT ON COLUMN BARS.ESCR_REG_STATUS.LEVEL_TYPE IS '';
COMMENT ON COLUMN BARS.ESCR_REG_STATUS.PRIORITY IS '';




PROMPT *** Create  constraint PK_REG_ST_ID ***
begin   
 execute immediate '
  ALTER TABLE BARS.ESCR_REG_STATUS ADD CONSTRAINT PK_REG_ST_ID PRIMARY KEY (ID)
  USING INDEX PCTFREE 10 INITRANS 2 MAXTRANS 255 COMPUTE STATISTICS 
  TABLESPACE BRSDYND  ENABLE';
exception when others then
  if  sqlcode=-2260 or sqlcode=-2261 or sqlcode=-2264 or sqlcode=-2275 or sqlcode=-1442 then null; else raise; end if;
 end;
/




PROMPT *** Create  constraint CC_ESCR_REG_STATUS_CODE ***
begin   
 execute immediate '
  ALTER TABLE BARS.ESCR_REG_STATUS ADD CONSTRAINT CC_ESCR_REG_STATUS_CODE CHECK (CODE IS NOT NULL) ENABLE';
exception when others then
  if  sqlcode=-2260 or sqlcode=-2261 or sqlcode=-2264 or sqlcode=-2275 or sqlcode=-1442 then null; else raise; end if;
 end;
/




PROMPT *** Create  index PK_REG_ST_ID ***
begin   
 execute immediate '
  CREATE UNIQUE INDEX BARS.PK_REG_ST_ID ON BARS.ESCR_REG_STATUS (ID) 
  PCTFREE 10 INITRANS 2 MAXTRANS 255 COMPUTE STATISTICS 
  TABLESPACE BRSDYND ';
exception when others then
  if  sqlcode=-955  then null; else raise; end if;
 end;
/



PROMPT *** Create  grants  ESCR_REG_STATUS ***
grant DELETE,INSERT,SELECT,UPDATE                                            on ESCR_REG_STATUS to BARS_ACCESS_DEFROLE;



PROMPT ===================================================================================== 
PROMPT *** End *** ========== Scripts /Sql/BARS/Table/ESCR_REG_STATUS.sql =========*** End *
PROMPT ===================================================================================== 
