PROMPT ===================================================================================== 
PROMPT *** Run *** ========== Scripts /Sql/BARS/Table/OW_BATCH_FILES.sql =========*** Run **
PROMPT ===================================================================================== 


PROMPT *** ALTER_POLICY_INFO to OW_BATCH_FILES ***


BEGIN 
        execute immediate  
          'begin  
               bpa.alter_policy_info(''OW_BATCH_FILES'', ''FILIAL'' , ''M'', ''M'', ''M'', ''M'');
               bpa.alter_policy_info(''OW_BATCH_FILES'', ''WHOLE'' , null, ''E'', ''E'', ''E'');
               null;
           end; 
          '; 
END; 
/

PROMPT *** Create  table OW_BATCH_FILES ***
begin 
  execute immediate '
  CREATE TABLE BARS.OW_BATCH_FILES 
   (	ID NUMBER(22,0), 
	FILE_NAME VARCHAR2(100), 
	ZIPFILE_NAME VARCHAR2(100), 
	FILE_DATE DATE DEFAULT sysdate, 
	CARD_CODE VARCHAR2(32), 
	BRANCH VARCHAR2(30), 
	ISP NUMBER(22,0), 
	PROECT_ID NUMBER(22,0), 
	FILE_N NUMBER(22,0), 
	FILE_TYPE NUMBER, 
	STATE NUMBER, 
	KF VARCHAR2(6) DEFAULT sys_context(''bars_context'',''user_mfo'')	
   ) SEGMENT CREATION IMMEDIATE 
  PCTFREE 10 PCTUSED 40 INITRANS 1 MAXTRANS 255 
 NOCOMPRESS LOGGING
  TABLESPACE BRSDYND ';
exception when others then       
  if sqlcode=-955 then null; else raise; end if; 
end; 
/


BEGIN
  EXECUTE IMMEDIATE 'alter table OW_BATCH_FILES add external_file_id VARCHAR2(300 CHAR)';
EXCEPTION
  WHEN OTHERS THEN
    IF SQLCODE = -01430 THEN
      NULL;
    ELSE
      RAISE;
    END IF; 
END;
/


PROMPT *** ALTER_POLICIES to OW_BATCH_FILES ***
 exec bpa.alter_policies('OW_BATCH_FILES');


COMMENT ON TABLE BARS.OW_BATCH_FILES IS '';
COMMENT ON COLUMN BARS.OW_BATCH_FILES.ID IS '';
COMMENT ON COLUMN BARS.OW_BATCH_FILES.FILE_NAME IS '';
COMMENT ON COLUMN BARS.OW_BATCH_FILES.ZIPFILE_NAME IS '';
COMMENT ON COLUMN BARS.OW_BATCH_FILES.FILE_DATE IS '';
COMMENT ON COLUMN BARS.OW_BATCH_FILES.CARD_CODE IS '';
COMMENT ON COLUMN BARS.OW_BATCH_FILES.BRANCH IS '';
COMMENT ON COLUMN BARS.OW_BATCH_FILES.ISP IS '';
COMMENT ON COLUMN BARS.OW_BATCH_FILES.PROECT_ID IS '';
COMMENT ON COLUMN BARS.OW_BATCH_FILES.FILE_N IS '';
COMMENT ON COLUMN BARS.OW_BATCH_FILES.FILE_TYPE IS '';
COMMENT ON COLUMN BARS.OW_BATCH_FILES.STATE IS '';
COMMENT ON COLUMN BARS.OW_BATCH_FILES.KF IS '';




PROMPT *** Create  constraint PK_OW_BATCH_FILES ***
begin   
 execute immediate '
  ALTER TABLE BARS.OW_BATCH_FILES ADD CONSTRAINT PK_OW_BATCH_FILES PRIMARY KEY (ID)
  USING INDEX PCTFREE 10 INITRANS 2 MAXTRANS 255 COMPUTE STATISTICS 
  TABLESPACE BRSDYND  ENABLE';
exception when others then
  if  sqlcode=-2260 or sqlcode=-2261 or sqlcode=-2264 or sqlcode=-2275 or sqlcode=-1442 then null; else raise; end if;
 end;
/




PROMPT *** Create  index PK_OW_BATCH_FILES ***
begin   
 execute immediate '
  CREATE UNIQUE INDEX BARS.PK_OW_BATCH_FILES ON BARS.OW_BATCH_FILES (ID) 
  PCTFREE 10 INITRANS 2 MAXTRANS 255 COMPUTE STATISTICS 
  TABLESPACE BRSDYND ';
exception when others then
  if  sqlcode=-955  then null; else raise; end if;
 end;
/




PROMPT *** Create  index I_OW_BATCH_FILES_FDATE ***
begin   
 execute immediate '
  CREATE INDEX BARS.I_OW_BATCH_FILES_FDATE ON BARS.OW_BATCH_FILES (FILE_DATE) 
  PCTFREE 10 INITRANS 2 MAXTRANS 255 COMPUTE STATISTICS 
  TABLESPACE BRSDYND ';
exception when others then
  if  sqlcode=-955  then null; else raise; end if;
 end;
/



PROMPT *** Create  grants  OW_BATCH_FILES ***
grant SELECT                                                                 on OW_BATCH_FILES  to BARS_ACCESS_DEFROLE;



PROMPT ===================================================================================== 
PROMPT *** End *** ========== Scripts /Sql/BARS/Table/OW_BATCH_FILES.sql =========*** End **
PROMPT ===================================================================================== 

