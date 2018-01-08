

PROMPT ===================================================================================== 
PROMPT *** Run *** ========== Scripts /Sql/BARS/Table/TMP_NOTIFICATION.sql =========*** Run 
PROMPT ===================================================================================== 


PROMPT *** ALTER_POLICY_INFO to TMP_NOTIFICATION ***


BEGIN 
        execute immediate  
          'begin  
               null;
           end; 
          '; 
END; 
/

PROMPT *** Create  table TMP_NOTIFICATION ***
begin 
  execute immediate '
  CREATE TABLE BARS.TMP_NOTIFICATION 
   (	TEXT VARCHAR2(1024), 
	ID NUMBER(*,0), 
	FL NUMBER(*,0)
   ) SEGMENT CREATION IMMEDIATE 
  PCTFREE 10 PCTUSED 40 INITRANS 1 MAXTRANS 255 
 NOCOMPRESS LOGGING
  TABLESPACE BRSDYND ';
exception when others then       
  if sqlcode=-955 then null; else raise; end if; 
end; 
/




PROMPT *** ALTER_POLICIES to TMP_NOTIFICATION ***
 exec bpa.alter_policies('TMP_NOTIFICATION');


COMMENT ON TABLE BARS.TMP_NOTIFICATION IS '';
COMMENT ON COLUMN BARS.TMP_NOTIFICATION.TEXT IS '';
COMMENT ON COLUMN BARS.TMP_NOTIFICATION.ID IS '';
COMMENT ON COLUMN BARS.TMP_NOTIFICATION.FL IS '';




PROMPT *** Create  constraint TMP_NOTIFICATION_PK ***
begin   
 execute immediate '
  ALTER TABLE BARS.TMP_NOTIFICATION ADD CONSTRAINT TMP_NOTIFICATION_PK PRIMARY KEY (TEXT, ID)
  USING INDEX PCTFREE 10 INITRANS 2 MAXTRANS 255 COMPUTE STATISTICS 
  TABLESPACE BRSDYND  ENABLE';
exception when others then
  if  sqlcode=-2260 or sqlcode=-2261 or sqlcode=-2264 or sqlcode=-2275 or sqlcode=-1442 then null; else raise; end if;
 end;
/




PROMPT *** Create  index PK_TMP_NOTIFICATION ***
begin   
 execute immediate '
  CREATE INDEX BARS.PK_TMP_NOTIFICATION ON BARS.TMP_NOTIFICATION (ID, TEXT) 
  PCTFREE 10 INITRANS 2 MAXTRANS 255 COMPUTE STATISTICS 
  TABLESPACE BRSDYND ';
exception when others then
  if  sqlcode=-955  then null; else raise; end if;
 end;
/





PROMPT ===================================================================================== 
PROMPT *** End *** ========== Scripts /Sql/BARS/Table/TMP_NOTIFICATION.sql =========*** End 
PROMPT ===================================================================================== 
