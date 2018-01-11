

PROMPT ===================================================================================== 
PROMPT *** Run *** ========== Scripts /Sql/BARS/Table/TMP_FILTERED_OBJECTS2.sql =========***
PROMPT ===================================================================================== 


PROMPT *** ALTER_POLICY_INFO to TMP_FILTERED_OBJECTS2 ***


BEGIN 
        execute immediate  
          'begin  
               null;
           end; 
          '; 
END; 
/

PROMPT *** Create  table TMP_FILTERED_OBJECTS2 ***
begin 
  execute immediate '
  CREATE TABLE BARS.TMP_FILTERED_OBJECTS2 
   (	ID NUMBER(10,0)
   ) SEGMENT CREATION IMMEDIATE 
  PCTFREE 10 PCTUSED 40 INITRANS 1 MAXTRANS 255 
 NOCOMPRESS LOGGING
  TABLESPACE BRSDYND ';
exception when others then       
  if sqlcode=-955 then null; else raise; end if; 
end; 
/




PROMPT *** ALTER_POLICIES to TMP_FILTERED_OBJECTS2 ***
 exec bpa.alter_policies('TMP_FILTERED_OBJECTS2');


COMMENT ON TABLE BARS.TMP_FILTERED_OBJECTS2 IS '';
COMMENT ON COLUMN BARS.TMP_FILTERED_OBJECTS2.ID IS '';




PROMPT *** Create  constraint SYS_C00132481 ***
begin   
 execute immediate '
  ALTER TABLE BARS.TMP_FILTERED_OBJECTS2 MODIFY (ID NOT NULL ENABLE)';
exception when others then
  if  sqlcode=-2260 or sqlcode=-2261 or sqlcode=-2264 or sqlcode=-2275 or sqlcode=-1442 then null; else raise; end if;
 end;
/




PROMPT *** Create  constraint PK_GGG2 ***
begin   
 execute immediate '
  ALTER TABLE BARS.TMP_FILTERED_OBJECTS2 ADD CONSTRAINT PK_GGG2 PRIMARY KEY (ID)
  USING INDEX PCTFREE 10 INITRANS 2 MAXTRANS 255 COMPUTE STATISTICS 
  TABLESPACE BRSDYND  ENABLE';
exception when others then
  if  sqlcode=-2260 or sqlcode=-2261 or sqlcode=-2264 or sqlcode=-2275 or sqlcode=-1442 then null; else raise; end if;
 end;
/




PROMPT *** Create  index PK_GGG2 ***
begin   
 execute immediate '
  CREATE UNIQUE INDEX BARS.PK_GGG2 ON BARS.TMP_FILTERED_OBJECTS2 (ID) 
  PCTFREE 10 INITRANS 2 MAXTRANS 255 COMPUTE STATISTICS 
  TABLESPACE BRSDYND ';
exception when others then
  if  sqlcode=-955  then null; else raise; end if;
 end;
/



PROMPT *** Create  grants  TMP_FILTERED_OBJECTS2 ***
grant SELECT                                                                 on TMP_FILTERED_OBJECTS2 to UPLD;



PROMPT ===================================================================================== 
PROMPT *** End *** ========== Scripts /Sql/BARS/Table/TMP_FILTERED_OBJECTS2.sql =========***
PROMPT ===================================================================================== 
