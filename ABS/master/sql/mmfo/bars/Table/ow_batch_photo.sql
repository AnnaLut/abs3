PROMPT ===================================================================================== 
PROMPT *** Run *** ========== Scripts /Sql/BARS/Table/OW_BATCH_PHOTO.sql =========*** Run **
PROMPT ===================================================================================== 


PROMPT *** ALTER_POLICY_INFO to OW_BATCH_PHOTO ***


BEGIN 
        execute immediate  
          'begin  
               bpa.alter_policy_info(''OW_BATCH_PHOTO'', ''FILIAL'' , ''M'', ''M'', ''M'', ''M'');
               bpa.alter_policy_info(''OW_BATCH_PHOTO'', ''WHOLE'' , null, ''E'', ''E'', ''E'');
               null;
           end; 
          '; 
END; 
/

PROMPT *** Create  table OW_BATCH_PHOTO ***
begin 
  execute immediate '
  CREATE TABLE BARS.OW_BATCH_PHOTO 
   (	ID NUMBER, 
	IDN NUMBER, 
	PHOTO BLOB, 
	NAME VARCHAR2(100), 
	KF VARCHAR2(6) DEFAULT sys_context(''bars_context'',''user_mfo'')
   ) SEGMENT CREATION IMMEDIATE 
  PCTFREE 10 PCTUSED 40 INITRANS 1 MAXTRANS 255 
 NOCOMPRESS LOGGING
  TABLESPACE BRSDYND 
 LOB (PHOTO) STORE AS BASICFILE (
  TABLESPACE BRSDYND ENABLE STORAGE IN ROW CHUNK 8192 RETENTION 
  NOCACHE LOGGING ) ';
exception when others then       
  if sqlcode=-955 then null; else raise; end if; 
end; 
/

BEGIN
  EXECUTE IMMEDIATE 'alter table OW_BATCH_PHOTO add KF VARCHAR2(6) DEFAULT sys_context(''bars_context'',''user_mfo'')';
EXCEPTION
  WHEN OTHERS THEN
    IF SQLCODE = -01430 THEN
      NULL;
    ELSE
      RAISE;
    END IF; 
END;
/

PROMPT *** ALTER_POLICIES to OW_BATCH_PHOTO ***
 exec bpa.alter_policies('OW_BATCH_PHOTO');


COMMENT ON TABLE BARS.OW_BATCH_PHOTO IS '';
COMMENT ON COLUMN BARS.OW_BATCH_PHOTO.ID IS '';
COMMENT ON COLUMN BARS.OW_BATCH_PHOTO.IDN IS '';
COMMENT ON COLUMN BARS.OW_BATCH_PHOTO.PHOTO IS '';
COMMENT ON COLUMN BARS.OW_BATCH_PHOTO.NAME IS '';




PROMPT *** Create  constraint FK_BATCH_PHOTO_TO_DATA ***
begin   
 execute immediate '
  ALTER TABLE BARS.OW_BATCH_PHOTO ADD CONSTRAINT FK_BATCH_PHOTO_TO_DATA FOREIGN KEY (ID, IDN)
	  REFERENCES BARS.OW_BATCH_OPEN_DATA (ID, IDN) ENABLE';
exception when others then
  if  sqlcode=-2260 or sqlcode=-2261 or sqlcode=-2264 or sqlcode=-2275 or sqlcode=-1442 then null; else raise; end if;
 end;
/




PROMPT *** Create  constraint SYS_C00364211 ***
begin   
 execute immediate '
  ALTER TABLE BARS.OW_BATCH_PHOTO MODIFY (IDN NOT NULL ENABLE)';
exception when others then
  if  sqlcode=-2260 or sqlcode=-2261 or sqlcode=-2264 or sqlcode=-2275 or sqlcode=-1442 then null; else raise; end if;
 end;
/




PROMPT *** Create  constraint SYS_C00364210 ***
begin   
 execute immediate '
  ALTER TABLE BARS.OW_BATCH_PHOTO MODIFY (ID NOT NULL ENABLE)';
exception when others then
  if  sqlcode=-2260 or sqlcode=-2261 or sqlcode=-2264 or sqlcode=-2275 or sqlcode=-1442 then null; else raise; end if;
 end;
/




PROMPT *** Create  index PK_OW_BATCH_PHOTO ***
begin   
 execute immediate '
  CREATE UNIQUE INDEX BARS.PK_OW_BATCH_PHOTO ON BARS.OW_BATCH_PHOTO (ID, IDN) 
  PCTFREE 10 INITRANS 2 MAXTRANS 255 COMPUTE STATISTICS 
  TABLESPACE BRSDYND ';
exception when others then
  if  sqlcode=-955  then null; else raise; end if;
 end;
/





PROMPT ===================================================================================== 
PROMPT *** End *** ========== Scripts /Sql/BARS/Table/OW_BATCH_PHOTO.sql =========*** End **
PROMPT ===================================================================================== 
