

PROMPT ===================================================================================== 
PROMPT *** Run *** ========== Scripts /Sql/BARS/Table/TMP_ATTR_NUMBER_HISTORY.sql =========*
PROMPT ===================================================================================== 


PROMPT *** ALTER_POLICY_INFO to TMP_ATTR_NUMBER_HISTORY ***


BEGIN 
        execute immediate  
          'begin  
               null;
           end; 
          '; 
END; 
/

PROMPT *** Create  table TMP_ATTR_NUMBER_HISTORY ***
begin 
  execute immediate '
  CREATE TABLE BARS.TMP_ATTR_NUMBER_HISTORY 
   (	ID NUMBER(10,0), 
	VALUE NUMBER(32,12)
   ) SEGMENT CREATION IMMEDIATE 
  PCTFREE 10 PCTUSED 40 INITRANS 1 MAXTRANS 255 
 NOCOMPRESS LOGGING
  TABLESPACE BRSDYND ';
exception when others then       
  if sqlcode=-955 then null; else raise; end if; 
end; 
/




PROMPT *** ALTER_POLICIES to TMP_ATTR_NUMBER_HISTORY ***
 exec bpa.alter_policies('TMP_ATTR_NUMBER_HISTORY');


COMMENT ON TABLE BARS.TMP_ATTR_NUMBER_HISTORY IS '';
COMMENT ON COLUMN BARS.TMP_ATTR_NUMBER_HISTORY.ID IS '';
COMMENT ON COLUMN BARS.TMP_ATTR_NUMBER_HISTORY.VALUE IS '';




PROMPT *** Create  constraint SYS_C00132032 ***
begin   
 execute immediate '
  ALTER TABLE BARS.TMP_ATTR_NUMBER_HISTORY MODIFY (ID NOT NULL ENABLE)';
exception when others then
  if  sqlcode=-2260 or sqlcode=-2261 or sqlcode=-2264 or sqlcode=-2275 or sqlcode=-1442 then null; else raise; end if;
 end;
/




PROMPT *** Create  index I_HIST ***
begin   
 execute immediate '
  CREATE INDEX BARS.I_HIST ON BARS.TMP_ATTR_NUMBER_HISTORY (ID) 
  PCTFREE 10 INITRANS 2 MAXTRANS 255 COMPUTE STATISTICS 
  TABLESPACE BRSDYND ';
exception when others then
  if  sqlcode=-955  then null; else raise; end if;
 end;
/



PROMPT *** Create  grants  TMP_ATTR_NUMBER_HISTORY ***
grant SELECT                                                                 on TMP_ATTR_NUMBER_HISTORY to UPLD;



PROMPT ===================================================================================== 
PROMPT *** End *** ========== Scripts /Sql/BARS/Table/TMP_ATTR_NUMBER_HISTORY.sql =========*
PROMPT ===================================================================================== 
