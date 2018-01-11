

PROMPT ===================================================================================== 
PROMPT *** Run *** ========== Scripts /Sql/BARS/Table/TMP_ATTR_NUMBER_VALUE.sql =========***
PROMPT ===================================================================================== 


PROMPT *** ALTER_POLICY_INFO to TMP_ATTR_NUMBER_VALUE ***


BEGIN 
        execute immediate  
          'begin  
               null;
           end; 
          '; 
END; 
/

PROMPT *** Create  table TMP_ATTR_NUMBER_VALUE ***
begin 
  execute immediate '
  CREATE TABLE BARS.TMP_ATTR_NUMBER_VALUE 
   (	OBJECT_ID NUMBER(12,0), 
	ATTRIBUTE_ID NUMBER(5,0), 
	VALUE NUMBER(32,12)
   ) SEGMENT CREATION IMMEDIATE 
  PCTFREE 10 PCTUSED 40 INITRANS 1 MAXTRANS 255 
 NOCOMPRESS LOGGING
  TABLESPACE BRSDYND ';
exception when others then       
  if sqlcode=-955 then null; else raise; end if; 
end; 
/




PROMPT *** ALTER_POLICIES to TMP_ATTR_NUMBER_VALUE ***
 exec bpa.alter_policies('TMP_ATTR_NUMBER_VALUE');


COMMENT ON TABLE BARS.TMP_ATTR_NUMBER_VALUE IS '';
COMMENT ON COLUMN BARS.TMP_ATTR_NUMBER_VALUE.OBJECT_ID IS '';
COMMENT ON COLUMN BARS.TMP_ATTR_NUMBER_VALUE.ATTRIBUTE_ID IS '';
COMMENT ON COLUMN BARS.TMP_ATTR_NUMBER_VALUE.VALUE IS '';




PROMPT *** Create  constraint SYS_C00139272 ***
begin   
 execute immediate '
  ALTER TABLE BARS.TMP_ATTR_NUMBER_VALUE MODIFY (OBJECT_ID NOT NULL ENABLE)';
exception when others then
  if  sqlcode=-2260 or sqlcode=-2261 or sqlcode=-2264 or sqlcode=-2275 or sqlcode=-1442 then null; else raise; end if;
 end;
/




PROMPT *** Create  constraint SYS_C00139273 ***
begin   
 execute immediate '
  ALTER TABLE BARS.TMP_ATTR_NUMBER_VALUE MODIFY (ATTRIBUTE_ID NOT NULL ENABLE)';
exception when others then
  if  sqlcode=-2260 or sqlcode=-2261 or sqlcode=-2264 or sqlcode=-2275 or sqlcode=-1442 then null; else raise; end if;
 end;
/




PROMPT *** Create  constraint SYS_C00139274 ***
begin   
 execute immediate '
  ALTER TABLE BARS.TMP_ATTR_NUMBER_VALUE MODIFY (VALUE NOT NULL ENABLE)';
exception when others then
  if  sqlcode=-2260 or sqlcode=-2261 or sqlcode=-2264 or sqlcode=-2275 or sqlcode=-1442 then null; else raise; end if;
 end;
/




PROMPT *** Create  index I_DEL_1 ***
begin   
 execute immediate '
  CREATE INDEX BARS.I_DEL_1 ON BARS.TMP_ATTR_NUMBER_VALUE (ATTRIBUTE_ID) 
  PCTFREE 10 INITRANS 2 MAXTRANS 255 COMPUTE STATISTICS 
  TABLESPACE BRSDYND ';
exception when others then
  if  sqlcode=-955  then null; else raise; end if;
 end;
/



PROMPT *** Create  grants  TMP_ATTR_NUMBER_VALUE ***
grant SELECT                                                                 on TMP_ATTR_NUMBER_VALUE to UPLD;



PROMPT ===================================================================================== 
PROMPT *** End *** ========== Scripts /Sql/BARS/Table/TMP_ATTR_NUMBER_VALUE.sql =========***
PROMPT ===================================================================================== 
