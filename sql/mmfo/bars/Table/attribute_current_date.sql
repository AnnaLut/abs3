

PROMPT ===================================================================================== 
PROMPT *** Run *** ========== Scripts /Sql/BARS/Table/ATTRIBUTE_CURRENT_DATE.sql =========**
PROMPT ===================================================================================== 


PROMPT *** ALTER_POLICY_INFO to ATTRIBUTE_CURRENT_DATE ***


BEGIN 
        execute immediate  
          'begin  
               bpa.alter_policy_info(''ATTRIBUTE_CURRENT_DATE'', ''FILIAL'' , null, null, null, null);
               null;
           end; 
          '; 
END; 
/

PROMPT *** Create  table ATTRIBUTE_CURRENT_DATE ***
begin 
  execute immediate '
  CREATE TABLE BARS.ATTRIBUTE_CURRENT_DATE 
   (	ATTRIBUTE_KIND_ID NUMBER(5,0), 
	CURRENT_VALUE_DATE DATE
   ) SEGMENT CREATION IMMEDIATE 
  PCTFREE 10 PCTUSED 40 INITRANS 1 MAXTRANS 255 
 NOCOMPRESS LOGGING
  TABLESPACE BRSSMLI ';
exception when others then       
  if sqlcode=-955 then null; else raise; end if; 
end; 
/




PROMPT *** ALTER_POLICIES to ATTRIBUTE_CURRENT_DATE ***
 exec bpa.alter_policies('ATTRIBUTE_CURRENT_DATE');


COMMENT ON TABLE BARS.ATTRIBUTE_CURRENT_DATE IS '';
COMMENT ON COLUMN BARS.ATTRIBUTE_CURRENT_DATE.ATTRIBUTE_KIND_ID IS '';
COMMENT ON COLUMN BARS.ATTRIBUTE_CURRENT_DATE.CURRENT_VALUE_DATE IS '';




PROMPT *** Create  constraint SYS_C0025682 ***
begin   
 execute immediate '
  ALTER TABLE BARS.ATTRIBUTE_CURRENT_DATE MODIFY (ATTRIBUTE_KIND_ID NOT NULL ENABLE)';
exception when others then
  if  sqlcode=-2260 or sqlcode=-2261 or sqlcode=-2264 or sqlcode=-2275 or sqlcode=-1442 then null; else raise; end if;
 end;
/




PROMPT *** Create  constraint SYS_C0025683 ***
begin   
 execute immediate '
  ALTER TABLE BARS.ATTRIBUTE_CURRENT_DATE MODIFY (CURRENT_VALUE_DATE NOT NULL ENABLE)';
exception when others then
  if  sqlcode=-2260 or sqlcode=-2261 or sqlcode=-2264 or sqlcode=-2275 or sqlcode=-1442 then null; else raise; end if;
 end;
/




PROMPT *** Create  constraint PK_ATTRIBUTE_CURRENT_DATE ***
begin   
 execute immediate '
  ALTER TABLE BARS.ATTRIBUTE_CURRENT_DATE ADD CONSTRAINT PK_ATTRIBUTE_CURRENT_DATE PRIMARY KEY (ATTRIBUTE_KIND_ID)
  USING INDEX PCTFREE 10 INITRANS 2 MAXTRANS 255 COMPUTE STATISTICS 
  TABLESPACE BRSSMLI  ENABLE';
exception when others then
  if  sqlcode=-2260 or sqlcode=-2261 or sqlcode=-2264 or sqlcode=-2275 or sqlcode=-1442 then null; else raise; end if;
 end;
/




PROMPT *** Create  index PK_ATTRIBUTE_CURRENT_DATE ***
begin   
 execute immediate '
  CREATE UNIQUE INDEX BARS.PK_ATTRIBUTE_CURRENT_DATE ON BARS.ATTRIBUTE_CURRENT_DATE (ATTRIBUTE_KIND_ID) 
  PCTFREE 10 INITRANS 2 MAXTRANS 255 COMPUTE STATISTICS 
  TABLESPACE BRSSMLI ';
exception when others then
  if  sqlcode=-955  then null; else raise; end if;
 end;
/



PROMPT *** Create  grants  ATTRIBUTE_CURRENT_DATE ***
grant SELECT                                                                 on ATTRIBUTE_CURRENT_DATE to BARSREADER_ROLE;
grant SELECT                                                                 on ATTRIBUTE_CURRENT_DATE to BARS_DM;
grant SELECT                                                                 on ATTRIBUTE_CURRENT_DATE to UPLD;



PROMPT ===================================================================================== 
PROMPT *** End *** ========== Scripts /Sql/BARS/Table/ATTRIBUTE_CURRENT_DATE.sql =========**
PROMPT ===================================================================================== 
