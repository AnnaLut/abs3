

PROMPT ===================================================================================== 
PROMPT *** Run *** ========== Scripts /Sql/BARS/Table/OB_CORPORATION_SESS_TRACKING.sql =====
PROMPT ===================================================================================== 


PROMPT *** ALTER_POLICY_INFO to OB_CORPORATION_SESS_TRACKING ***


BEGIN 
        execute immediate  
          'begin  
               bpa.alter_policy_info(''OB_CORPORATION_SESS_TRACKING'', ''FILIAL'' , null, null, null, null);
               bpa.alter_policy_info(''OB_CORPORATION_SESS_TRACKING'', ''WHOLE'' , null, null, null, null);
               null;
           end; 
          '; 
END; 
/

PROMPT *** Create  table OB_CORPORATION_SESS_TRACKING ***
begin 
  execute immediate '
  CREATE TABLE BARS.OB_CORPORATION_SESS_TRACKING 
   (	ID NUMBER(10,0), 
	SESSION_ID NUMBER(10,0), 
	STATE_ID NUMBER(5,0), 
	TRACKING_MESSAGE NUMBER(5,0), 
	TRACKING_REPORT CLOB, 
	SYS_TIME DATE, 
	USER_ID NUMBER(5,0)
   ) SEGMENT CREATION DEFERRED 
  PCTFREE 10 PCTUSED 40 INITRANS 1 MAXTRANS 255 
 NOCOMPRESS LOGGING
  TABLESPACE BRSDYND 
 LOB (TRACKING_REPORT) STORE AS BASICFILE (
  TABLESPACE BRSDYND ENABLE STORAGE IN ROW CHUNK 8192 RETENTION 
  NOCACHE LOGGING ) ';
exception when others then       
  if sqlcode=-955 then null; else raise; end if; 
end; 
/




PROMPT *** ALTER_POLICIES to OB_CORPORATION_SESS_TRACKING ***
 exec bpa.alter_policies('OB_CORPORATION_SESS_TRACKING');


COMMENT ON TABLE BARS.OB_CORPORATION_SESS_TRACKING IS 'Історія обробки сесій завантаження К-файлів';
COMMENT ON COLUMN BARS.OB_CORPORATION_SESS_TRACKING.ID IS 'Ідентифікатор історії обробки';
COMMENT ON COLUMN BARS.OB_CORPORATION_SESS_TRACKING.SESSION_ID IS 'Сесія завантаження К-файлу';
COMMENT ON COLUMN BARS.OB_CORPORATION_SESS_TRACKING.STATE_ID IS 'Стан обробки сесії';
COMMENT ON COLUMN BARS.OB_CORPORATION_SESS_TRACKING.TRACKING_MESSAGE IS 'Коментар до етапу обробки сесії';
COMMENT ON COLUMN BARS.OB_CORPORATION_SESS_TRACKING.TRACKING_REPORT IS 'Сформована відповідь за результатами обробки файлу (звіт про прийняті дані та опис помилок)';
COMMENT ON COLUMN BARS.OB_CORPORATION_SESS_TRACKING.SYS_TIME IS 'Системна дата/час зміни статусу';
COMMENT ON COLUMN BARS.OB_CORPORATION_SESS_TRACKING.USER_ID IS 'Користувач, що виконав даний етап обробки файлу';




PROMPT *** Create  constraint SYS_C00109863 ***
begin   
 execute immediate '
  ALTER TABLE BARS.OB_CORPORATION_SESS_TRACKING MODIFY (ID NOT NULL ENABLE)';
exception when others then
  if  sqlcode=-2260 or sqlcode=-2261 or sqlcode=-2264 or sqlcode=-2275 or sqlcode=-1442 then null; else raise; end if;
 end;
/




PROMPT *** Create  constraint SYS_C00109864 ***
begin   
 execute immediate '
  ALTER TABLE BARS.OB_CORPORATION_SESS_TRACKING MODIFY (SESSION_ID NOT NULL ENABLE)';
exception when others then
  if  sqlcode=-2260 or sqlcode=-2261 or sqlcode=-2264 or sqlcode=-2275 or sqlcode=-1442 then null; else raise; end if;
 end;
/




PROMPT *** Create  constraint SYS_C00109865 ***
begin   
 execute immediate '
  ALTER TABLE BARS.OB_CORPORATION_SESS_TRACKING MODIFY (STATE_ID NOT NULL ENABLE)';
exception when others then
  if  sqlcode=-2260 or sqlcode=-2261 or sqlcode=-2264 or sqlcode=-2275 or sqlcode=-1442 then null; else raise; end if;
 end;
/




PROMPT *** Create  constraint SYS_C00109866 ***
begin   
 execute immediate '
  ALTER TABLE BARS.OB_CORPORATION_SESS_TRACKING MODIFY (SYS_TIME NOT NULL ENABLE)';
exception when others then
  if  sqlcode=-2260 or sqlcode=-2261 or sqlcode=-2264 or sqlcode=-2275 or sqlcode=-1442 then null; else raise; end if;
 end;
/




PROMPT *** Create  constraint SYS_C00109867 ***
begin   
 execute immediate '
  ALTER TABLE BARS.OB_CORPORATION_SESS_TRACKING MODIFY (USER_ID NOT NULL ENABLE)';
exception when others then
  if  sqlcode=-2260 or sqlcode=-2261 or sqlcode=-2264 or sqlcode=-2275 or sqlcode=-1442 then null; else raise; end if;
 end;
/




PROMPT *** Create  constraint PK_CORP_SESS_TRACKING ***
begin   
 execute immediate '
  ALTER TABLE BARS.OB_CORPORATION_SESS_TRACKING ADD CONSTRAINT PK_CORP_SESS_TRACKING PRIMARY KEY (ID)
  USING INDEX PCTFREE 10 INITRANS 2 MAXTRANS 255 COMPUTE STATISTICS 
  TABLESPACE BRSDYND  ENABLE';
exception when others then
  if  sqlcode=-2260 or sqlcode=-2261 or sqlcode=-2264 or sqlcode=-2275 or sqlcode=-1442 then null; else raise; end if;
 end;
/




PROMPT *** Create  index PK_CORP_SESS_TRACKING ***
begin   
 execute immediate '
  CREATE UNIQUE INDEX BARS.PK_CORP_SESS_TRACKING ON BARS.OB_CORPORATION_SESS_TRACKING (ID) 
  PCTFREE 10 INITRANS 2 MAXTRANS 255 COMPUTE STATISTICS 
  TABLESPACE BRSDYND ';
exception when others then
  if  sqlcode=-955  then null; else raise; end if;
 end;
/




PROMPT *** Create  index OB_CORP_SESS_TRACK_IDX ***
begin   
 execute immediate '
  CREATE INDEX BARS.OB_CORP_SESS_TRACK_IDX ON BARS.OB_CORPORATION_SESS_TRACKING (SESSION_ID) 
  PCTFREE 10 INITRANS 2 MAXTRANS 255 COMPUTE STATISTICS 
  TABLESPACE BRSDYNI ';
exception when others then
  if  sqlcode=-955  then null; else raise; end if;
 end;
/



PROMPT *** Create  grants  OB_CORPORATION_SESS_TRACKING ***
grant SELECT                                                                 on OB_CORPORATION_SESS_TRACKING to BARSREADER_ROLE;
grant ALTER,DEBUG,DELETE,FLASHBACK,INSERT,ON COMMIT REFRESH,QUERY REWRITE,SELECT,UPDATE on OB_CORPORATION_SESS_TRACKING to BARS_ACCESS_DEFROLE;
grant SELECT                                                                 on OB_CORPORATION_SESS_TRACKING to UPLD;



PROMPT ===================================================================================== 
PROMPT *** End *** ========== Scripts /Sql/BARS/Table/OB_CORPORATION_SESS_TRACKING.sql =====
PROMPT ===================================================================================== 
