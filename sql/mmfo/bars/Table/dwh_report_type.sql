

PROMPT ===================================================================================== 
PROMPT *** Run *** ========== Scripts /Sql/BARS/Table/DWH_REPORT_TYPE.sql =========*** Run *
PROMPT ===================================================================================== 


PROMPT *** ALTER_POLICY_INFO to DWH_REPORT_TYPE ***


BEGIN 
        execute immediate  
          'begin  
               bpa.alter_policy_info(''DWH_REPORT_TYPE'', ''FILIAL'' , null, null, null, null);
               bpa.alter_policy_info(''DWH_REPORT_TYPE'', ''WHOLE'' , null, null, null, null);
               null;
           end; 
          '; 
END; 
/

PROMPT *** Create  table DWH_REPORT_TYPE ***
begin 
  execute immediate '
  CREATE TABLE BARS.DWH_REPORT_TYPE 
   (	ID NUMBER, 
	VALUE VARCHAR2(100), 
	NAME VARCHAR2(100), 
	DESCRIPTION VARCHAR2(200)
   ) SEGMENT CREATION IMMEDIATE 
  PCTFREE 10 PCTUSED 40 INITRANS 1 MAXTRANS 255 
 NOCOMPRESS LOGGING
  TABLESPACE BRSDYND ';
exception when others then       
  if sqlcode=-955 then null; else raise; end if; 
end; 
/




PROMPT *** ALTER_POLICIES to DWH_REPORT_TYPE ***
 exec bpa.alter_policies('DWH_REPORT_TYPE');


COMMENT ON TABLE BARS.DWH_REPORT_TYPE IS 'Directory of report types';
COMMENT ON COLUMN BARS.DWH_REPORT_TYPE.ID IS '';
COMMENT ON COLUMN BARS.DWH_REPORT_TYPE.VALUE IS 'Value of report type';
COMMENT ON COLUMN BARS.DWH_REPORT_TYPE.NAME IS 'Name of report type';
COMMENT ON COLUMN BARS.DWH_REPORT_TYPE.DESCRIPTION IS 'Description of report type';




PROMPT *** Create  constraint CC_DWHREPORTSTYPE_VALUE_NN ***
begin   
 execute immediate '
  ALTER TABLE BARS.DWH_REPORT_TYPE MODIFY (VALUE CONSTRAINT CC_DWHREPORTSTYPE_VALUE_NN NOT NULL ENABLE)';
exception when others then
  if  sqlcode=-2260 or sqlcode=-2261 or sqlcode=-2264 or sqlcode=-2275 or sqlcode=-1442 then null; else raise; end if;
 end;
/




PROMPT *** Create  constraint CC_DWHREPORTSTYPE_NAME_NN ***
begin   
 execute immediate '
  ALTER TABLE BARS.DWH_REPORT_TYPE MODIFY (NAME CONSTRAINT CC_DWHREPORTSTYPE_NAME_NN NOT NULL ENABLE)';
exception when others then
  if  sqlcode=-2260 or sqlcode=-2261 or sqlcode=-2264 or sqlcode=-2275 or sqlcode=-1442 then null; else raise; end if;
 end;
/




PROMPT *** Create  constraint PK_DWHREPORTSTYPE_ID ***
begin   
 execute immediate '
  ALTER TABLE BARS.DWH_REPORT_TYPE ADD CONSTRAINT PK_DWHREPORTSTYPE_ID PRIMARY KEY (ID)
  USING INDEX PCTFREE 10 INITRANS 2 MAXTRANS 255 COMPUTE STATISTICS 
  TABLESPACE BRSDYND  ENABLE';
exception when others then
  if  sqlcode=-2260 or sqlcode=-2261 or sqlcode=-2264 or sqlcode=-2275 or sqlcode=-1442 then null; else raise; end if;
 end;
/




PROMPT *** Create  index PK_DWHREPORTSTYPE_ID ***
begin   
 execute immediate '
  CREATE UNIQUE INDEX BARS.PK_DWHREPORTSTYPE_ID ON BARS.DWH_REPORT_TYPE (ID) 
  PCTFREE 10 INITRANS 2 MAXTRANS 255 COMPUTE STATISTICS 
  TABLESPACE BRSDYND ';
exception when others then
  if  sqlcode=-955  then null; else raise; end if;
 end;
/



PROMPT *** Create  grants  DWH_REPORT_TYPE ***
grant SELECT                                                                 on DWH_REPORT_TYPE to BARSREADER_ROLE;
grant DELETE,INSERT,SELECT,UPDATE                                            on DWH_REPORT_TYPE to BARS_ACCESS_DEFROLE;
grant SELECT                                                                 on DWH_REPORT_TYPE to UPLD;



PROMPT ===================================================================================== 
PROMPT *** End *** ========== Scripts /Sql/BARS/Table/DWH_REPORT_TYPE.sql =========*** End *
PROMPT ===================================================================================== 
