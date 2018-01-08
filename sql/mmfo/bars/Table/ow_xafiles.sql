

PROMPT ===================================================================================== 
PROMPT *** Run *** ========== Scripts /Sql/BARS/Table/OW_XAFILES.sql =========*** Run *** ==
PROMPT ===================================================================================== 


PROMPT *** ALTER_POLICY_INFO to OW_XAFILES ***


BEGIN 
        execute immediate  
          'begin  
               bpa.alter_policy_info(''OW_XAFILES'', ''CENTER'' , null, ''E'', ''E'', ''E'');
               bpa.alter_policy_info(''OW_XAFILES'', ''FILIAL'' , null, null, null, null);
               bpa.alter_policy_info(''OW_XAFILES'', ''WHOLE'' , null, ''E'', ''E'', ''E'');
               null;
           end; 
          '; 
END; 
/

PROMPT *** Create  table OW_XAFILES ***
begin 
  execute immediate '
  CREATE TABLE BARS.OW_XAFILES 
   (	FILE_NAME VARCHAR2(100), 
	FILE_DATE DATE DEFAULT sysdate, 
	FILE_N NUMBER(22,0), 
	TICK_NAME VARCHAR2(100), 
	TICK_DATE DATE, 
	TICK_STATUS VARCHAR2(23), 
	TICK_ACCEPT_REC NUMBER(*,0), 
	TICK_REJECT_REC NUMBER(*,0), 
	UNFORM_FLAG NUMBER(1,0), 
	UNFORM_USER NUMBER(22,0), 
	UNFORM_DATE DATE, 
	FILE_TYPE NUMBER(1,0)
   ) SEGMENT CREATION DEFERRED 
  PCTFREE 10 PCTUSED 40 INITRANS 1 MAXTRANS 255 
 NOCOMPRESS LOGGING
  TABLESPACE BRSSMLD ';
exception when others then       
  if sqlcode=-955 then null; else raise; end if; 
end; 
/




PROMPT *** ALTER_POLICIES to OW_XAFILES ***
 exec bpa.alter_policies('OW_XAFILES');


COMMENT ON TABLE BARS.OW_XAFILES IS 'OW. Файлы на открытие карт для Way4';
COMMENT ON COLUMN BARS.OW_XAFILES.FILE_NAME IS 'І'мя файла';
COMMENT ON COLUMN BARS.OW_XAFILES.FILE_DATE IS 'Дата формування файла';
COMMENT ON COLUMN BARS.OW_XAFILES.FILE_N IS '';
COMMENT ON COLUMN BARS.OW_XAFILES.TICK_NAME IS '';
COMMENT ON COLUMN BARS.OW_XAFILES.TICK_DATE IS '';
COMMENT ON COLUMN BARS.OW_XAFILES.TICK_STATUS IS '';
COMMENT ON COLUMN BARS.OW_XAFILES.TICK_ACCEPT_REC IS '';
COMMENT ON COLUMN BARS.OW_XAFILES.TICK_REJECT_REC IS '';
COMMENT ON COLUMN BARS.OW_XAFILES.UNFORM_FLAG IS '';
COMMENT ON COLUMN BARS.OW_XAFILES.UNFORM_USER IS '';
COMMENT ON COLUMN BARS.OW_XAFILES.UNFORM_DATE IS '';
COMMENT ON COLUMN BARS.OW_XAFILES.FILE_TYPE IS '';




PROMPT *** Create  constraint FK_OWXAFILES_STAFF ***
begin   
 execute immediate '
  ALTER TABLE BARS.OW_XAFILES ADD CONSTRAINT FK_OWXAFILES_STAFF FOREIGN KEY (UNFORM_USER)
	  REFERENCES BARS.STAFF$BASE (ID) ENABLE';
exception when others then
  if  sqlcode=-2260 or sqlcode=-2261 or sqlcode=-2264 or sqlcode=-2275 or sqlcode=-1442 then null; else raise; end if;
 end;
/




PROMPT *** Create  constraint FK_OWXAFILES_OWCRVREQUEST ***
begin   
 execute immediate '
  ALTER TABLE BARS.OW_XAFILES ADD CONSTRAINT FK_OWXAFILES_OWCRVREQUEST FOREIGN KEY (FILE_TYPE)
	  REFERENCES BARS.OW_CRV_REQUEST (ID) ENABLE';
exception when others then
  if  sqlcode=-2260 or sqlcode=-2261 or sqlcode=-2264 or sqlcode=-2275 or sqlcode=-1442 then null; else raise; end if;
 end;
/




PROMPT *** Create  constraint CC_OWXAFILES_FILENAME_NN ***
begin   
 execute immediate '
  ALTER TABLE BARS.OW_XAFILES MODIFY (FILE_NAME CONSTRAINT CC_OWXAFILES_FILENAME_NN NOT NULL ENABLE)';
exception when others then
  if  sqlcode=-2260 or sqlcode=-2261 or sqlcode=-2264 or sqlcode=-2275 or sqlcode=-1442 then null; else raise; end if;
 end;
/




PROMPT *** Create  constraint CC_OWXAFILES_FILEDATE_NN ***
begin   
 execute immediate '
  ALTER TABLE BARS.OW_XAFILES MODIFY (FILE_DATE CONSTRAINT CC_OWXAFILES_FILEDATE_NN NOT NULL ENABLE)';
exception when others then
  if  sqlcode=-2260 or sqlcode=-2261 or sqlcode=-2264 or sqlcode=-2275 or sqlcode=-1442 then null; else raise; end if;
 end;
/




PROMPT *** Create  constraint CC_OWXAFILES_FILEN_NN ***
begin   
 execute immediate '
  ALTER TABLE BARS.OW_XAFILES MODIFY (FILE_N CONSTRAINT CC_OWXAFILES_FILEN_NN NOT NULL ENABLE)';
exception when others then
  if  sqlcode=-2260 or sqlcode=-2261 or sqlcode=-2264 or sqlcode=-2275 or sqlcode=-1442 then null; else raise; end if;
 end;
/




PROMPT *** Create  constraint PK_OWXAFILES ***
begin   
 execute immediate '
  ALTER TABLE BARS.OW_XAFILES ADD CONSTRAINT PK_OWXAFILES PRIMARY KEY (FILE_NAME)
  USING INDEX PCTFREE 10 INITRANS 2 MAXTRANS 255 COMPUTE STATISTICS 
  TABLESPACE BRSSMLI  ENABLE';
exception when others then
  if  sqlcode=-2260 or sqlcode=-2261 or sqlcode=-2264 or sqlcode=-2275 or sqlcode=-1442 then null; else raise; end if;
 end;
/




PROMPT *** Create  index PK_OWXAFILES ***
begin   
 execute immediate '
  CREATE UNIQUE INDEX BARS.PK_OWXAFILES ON BARS.OW_XAFILES (FILE_NAME) 
  PCTFREE 10 INITRANS 2 MAXTRANS 255 COMPUTE STATISTICS 
  TABLESPACE BRSSMLI ';
exception when others then
  if  sqlcode=-955  then null; else raise; end if;
 end;
/



PROMPT *** Create  grants  OW_XAFILES ***
grant INSERT,SELECT                                                          on OW_XAFILES      to BARS_ACCESS_DEFROLE;
grant INSERT,SELECT                                                          on OW_XAFILES      to OW;



PROMPT ===================================================================================== 
PROMPT *** End *** ========== Scripts /Sql/BARS/Table/OW_XAFILES.sql =========*** End *** ==
PROMPT ===================================================================================== 
