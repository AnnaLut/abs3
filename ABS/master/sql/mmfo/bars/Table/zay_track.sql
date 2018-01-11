

PROMPT ===================================================================================== 
PROMPT *** Run *** ========== Scripts /Sql/BARS/Table/ZAY_TRACK.sql =========*** Run *** ===
PROMPT ===================================================================================== 


PROMPT *** ALTER_POLICY_INFO to ZAY_TRACK ***


BEGIN 
        execute immediate  
          'begin  
               bpa.alter_policy_info(''ZAY_TRACK'', ''CENTER'' , null, ''E'', ''E'', ''E'');
               bpa.alter_policy_info(''ZAY_TRACK'', ''FILIAL'' , ''B'', null, null, null);
               bpa.alter_policy_info(''ZAY_TRACK'', ''WHOLE'' , null, ''E'', ''E'', ''E'');
               null;
           end; 
          '; 
END; 
/

PROMPT *** Create  table ZAY_TRACK ***
begin 
  execute immediate '
  CREATE TABLE BARS.ZAY_TRACK 
   (	TRACK_ID NUMBER(*,0), 
	ID NUMBER(*,0), 
	OLD_SOS NUMBER, 
	NEW_SOS NUMBER, 
	OLD_VIZA NUMBER, 
	NEW_VIZA NUMBER, 
	CHANGE_TIME DATE, 
	USERID NUMBER(*,0), 
	BRANCH VARCHAR2(30), 
	 CONSTRAINT PK_ZAYTRACK PRIMARY KEY (TRACK_ID) ENABLE
   ) ORGANIZATION INDEX NOCOMPRESS PCTFREE 10 INITRANS 2 MAXTRANS 255 LOGGING
  TABLESPACE BRSMDLD 
 PCTTHRESHOLD 50';
exception when others then       
  if sqlcode=-955 then null; else raise; end if; 
end; 
/




PROMPT *** ALTER_POLICIES to ZAY_TRACK ***
 exec bpa.alter_policies('ZAY_TRACK');


COMMENT ON TABLE BARS.ZAY_TRACK IS 'Історія змін статусів заявок';
COMMENT ON COLUMN BARS.ZAY_TRACK.TRACK_ID IS 'ID зміни заявок';
COMMENT ON COLUMN BARS.ZAY_TRACK.ID IS 'ID заявки';
COMMENT ON COLUMN BARS.ZAY_TRACK.OLD_SOS IS 'Старий статус заявки';
COMMENT ON COLUMN BARS.ZAY_TRACK.NEW_SOS IS 'Новий статус заявки';
COMMENT ON COLUMN BARS.ZAY_TRACK.OLD_VIZA IS 'Старий код візи заявки';
COMMENT ON COLUMN BARS.ZAY_TRACK.NEW_VIZA IS 'Новий код візи заявки';
COMMENT ON COLUMN BARS.ZAY_TRACK.CHANGE_TIME IS 'Час зміни статусу заявки';
COMMENT ON COLUMN BARS.ZAY_TRACK.USERID IS 'Код користувача, що змінив стан заявки';
COMMENT ON COLUMN BARS.ZAY_TRACK.BRANCH IS '';




PROMPT *** Create  constraint CC_ZAYTRACK_TRACKID_NN ***
begin   
 execute immediate '
  ALTER TABLE BARS.ZAY_TRACK MODIFY (TRACK_ID CONSTRAINT CC_ZAYTRACK_TRACKID_NN NOT NULL ENABLE)';
exception when others then
  if  sqlcode=-2260 or sqlcode=-2261 or sqlcode=-2264 or sqlcode=-2275 or sqlcode=-1442 then null; else raise; end if;
 end;
/




PROMPT *** Create  constraint CC_ZAYTRACK_ID_NN ***
begin   
 execute immediate '
  ALTER TABLE BARS.ZAY_TRACK MODIFY (ID CONSTRAINT CC_ZAYTRACK_ID_NN NOT NULL ENABLE)';
exception when others then
  if  sqlcode=-2260 or sqlcode=-2261 or sqlcode=-2264 or sqlcode=-2275 or sqlcode=-1442 then null; else raise; end if;
 end;
/




PROMPT *** Create  constraint CC_ZAYTRACK_NEWSOS_NN ***
begin   
 execute immediate '
  ALTER TABLE BARS.ZAY_TRACK MODIFY (NEW_SOS CONSTRAINT CC_ZAYTRACK_NEWSOS_NN NOT NULL ENABLE)';
exception when others then
  if  sqlcode=-2260 or sqlcode=-2261 or sqlcode=-2264 or sqlcode=-2275 or sqlcode=-1442 then null; else raise; end if;
 end;
/




PROMPT *** Create  constraint CC_ZAYTRACK_NEWVIZA_NN ***
begin   
 execute immediate '
  ALTER TABLE BARS.ZAY_TRACK MODIFY (NEW_VIZA CONSTRAINT CC_ZAYTRACK_NEWVIZA_NN NOT NULL ENABLE)';
exception when others then
  if  sqlcode=-2260 or sqlcode=-2261 or sqlcode=-2264 or sqlcode=-2275 or sqlcode=-1442 then null; else raise; end if;
 end;
/




PROMPT *** Create  constraint CC_ZAYTRACK_CHTIME_NN ***
begin   
 execute immediate '
  ALTER TABLE BARS.ZAY_TRACK MODIFY (CHANGE_TIME CONSTRAINT CC_ZAYTRACK_CHTIME_NN NOT NULL ENABLE)';
exception when others then
  if  sqlcode=-2260 or sqlcode=-2261 or sqlcode=-2264 or sqlcode=-2275 or sqlcode=-1442 then null; else raise; end if;
 end;
/




PROMPT *** Create  constraint CC_ZAYTRACK_USERID_NN ***
begin   
 execute immediate '
  ALTER TABLE BARS.ZAY_TRACK MODIFY (USERID CONSTRAINT CC_ZAYTRACK_USERID_NN NOT NULL ENABLE)';
exception when others then
  if  sqlcode=-2260 or sqlcode=-2261 or sqlcode=-2264 or sqlcode=-2275 or sqlcode=-1442 then null; else raise; end if;
 end;
/




PROMPT *** Create  constraint PK_ZAYTRACK ***
begin   
 execute immediate '
  ALTER TABLE BARS.ZAY_TRACK ADD CONSTRAINT PK_ZAYTRACK PRIMARY KEY (TRACK_ID)
  USING INDEX PCTFREE 10 INITRANS 2 MAXTRANS 255 COMPUTE STATISTICS 
  TABLESPACE BRSMDLD  ENABLE';
exception when others then
  if  sqlcode=-2260 or sqlcode=-2261 or sqlcode=-2264 or sqlcode=-2275 or sqlcode=-1442 then null; else raise; end if;
 end;
/




PROMPT *** Create  index PK_ZAYTRACK ***
begin   
 execute immediate '
  CREATE UNIQUE INDEX BARS.PK_ZAYTRACK ON BARS.ZAY_TRACK (TRACK_ID) 
  PCTFREE 10 INITRANS 2 MAXTRANS 255 COMPUTE STATISTICS 
  TABLESPACE BRSMDLD ';
exception when others then
  if  sqlcode=-955  then null; else raise; end if;
 end;
/




PROMPT *** Create  index I_ZAYTRACK_ID ***
begin   
 execute immediate '
  CREATE INDEX BARS.I_ZAYTRACK_ID ON BARS.ZAY_TRACK (ID) 
  PCTFREE 10 INITRANS 2 MAXTRANS 255 COMPUTE STATISTICS 
  TABLESPACE BRSMDLI ';
exception when others then
  if  sqlcode=-955  then null; else raise; end if;
 end;
/



PROMPT *** Create  grants  ZAY_TRACK ***
grant FLASHBACK,REFERENCES,SELECT                                            on ZAY_TRACK       to BARSAQ with grant option;
grant SELECT                                                                 on ZAY_TRACK       to BARSREADER_ROLE;
grant SELECT                                                                 on ZAY_TRACK       to BARS_ACCESS_DEFROLE;
grant SELECT                                                                 on ZAY_TRACK       to BARS_DM;
grant SELECT                                                                 on ZAY_TRACK       to ZAY;



PROMPT ===================================================================================== 
PROMPT *** End *** ========== Scripts /Sql/BARS/Table/ZAY_TRACK.sql =========*** End *** ===
PROMPT ===================================================================================== 
