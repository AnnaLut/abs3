

PROMPT ===================================================================================== 
PROMPT *** Run *** ========== Scripts /Sql/BARS/Table/TMP_FILTERED_OBJECTS.sql =========*** 
PROMPT ===================================================================================== 


PROMPT *** ALTER_POLICY_INFO to TMP_FILTERED_OBJECTS ***


BEGIN 
        execute immediate  
          'begin  
               null;
           end; 
          '; 
END; 
/

PROMPT *** Create  table TMP_FILTERED_OBJECTS ***
begin 
  execute immediate '
  CREATE TABLE BARS.TMP_FILTERED_OBJECTS 
   (	ID NUMBER(10,0)
   ) SEGMENT CREATION IMMEDIATE 
  PCTFREE 10 PCTUSED 40 INITRANS 1 MAXTRANS 255 
 NOCOMPRESS LOGGING
  TABLESPACE BRSDYND ';
exception when others then       
  if sqlcode=-955 then null; else raise; end if; 
end; 
/




PROMPT *** ALTER_POLICIES to TMP_FILTERED_OBJECTS ***
 exec bpa.alter_policies('TMP_FILTERED_OBJECTS');


COMMENT ON TABLE BARS.TMP_FILTERED_OBJECTS IS '';
COMMENT ON COLUMN BARS.TMP_FILTERED_OBJECTS.ID IS '';




PROMPT *** Create  constraint SYS_C00132033 ***
begin   
 execute immediate '
  ALTER TABLE BARS.TMP_FILTERED_OBJECTS MODIFY (ID NOT NULL ENABLE)';
exception when others then
  if  sqlcode=-2260 or sqlcode=-2261 or sqlcode=-2264 or sqlcode=-2275 or sqlcode=-1442 then null; else raise; end if;
 end;
/



PROMPT *** Create  grants  TMP_FILTERED_OBJECTS ***
grant SELECT                                                                 on TMP_FILTERED_OBJECTS to UPLD;



PROMPT ===================================================================================== 
PROMPT *** End *** ========== Scripts /Sql/BARS/Table/TMP_FILTERED_OBJECTS.sql =========*** 
PROMPT ===================================================================================== 
