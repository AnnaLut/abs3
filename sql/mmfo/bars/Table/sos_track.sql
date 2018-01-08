

PROMPT ===================================================================================== 
PROMPT *** Run *** ========== Scripts /Sql/BARS/Table/SOS_TRACK.sql =========*** Run *** ===
PROMPT ===================================================================================== 


PROMPT *** ALTER_POLICY_INFO to SOS_TRACK ***


BEGIN 
        execute immediate  
          'begin  
               bpa.alter_policy_info(''SOS_TRACK'', ''CENTER'' , null, ''E'', ''E'', ''E'');
               bpa.alter_policy_info(''SOS_TRACK'', ''FILIAL'' , ''M'', ''M'', ''M'', ''M'');
               bpa.alter_policy_info(''SOS_TRACK'', ''WHOLE'' , null, ''E'', ''E'', ''E'');
               null;
           end; 
          '; 
END; 
/

PROMPT *** Create  table SOS_TRACK ***
begin 
  execute immediate '
  CREATE TABLE BARS.SOS_TRACK 
   (	REF NUMBER(*,0), 
	SOS_TRACKER NUMBER(*,0), 
	OLD_SOS NUMBER(*,0), 
	NEW_SOS NUMBER(*,0), 
	CHANGE_TIME DATE, 
	USERID NUMBER(*,0), 
	KF VARCHAR2(6) DEFAULT sys_context(''bars_context'',''user_mfo''), 
	 CONSTRAINT PK_SOSTRACK PRIMARY KEY (REF, SOS_TRACKER) ENABLE
   ) ORGANIZATION INDEX NOCOMPRESS PCTFREE 10 INITRANS 2 MAXTRANS 255 LOGGING
  TABLESPACE BRSBIGD 
 PCTTHRESHOLD 50';
exception when others then       
  if sqlcode=-955 then null; else raise; end if; 
end; 
/




PROMPT *** ALTER_POLICIES to SOS_TRACK ***
 exec bpa.alter_policies('SOS_TRACK');


COMMENT ON TABLE BARS.SOS_TRACK IS 'Історія змін статусів документів';
COMMENT ON COLUMN BARS.SOS_TRACK.REF IS 'REF документа';
COMMENT ON COLUMN BARS.SOS_TRACK.SOS_TRACKER IS 'Номер зміни статусу документа';
COMMENT ON COLUMN BARS.SOS_TRACK.OLD_SOS IS 'Старий статус документа';
COMMENT ON COLUMN BARS.SOS_TRACK.NEW_SOS IS 'Новий статус документа';
COMMENT ON COLUMN BARS.SOS_TRACK.CHANGE_TIME IS 'Час зміни статусу документа';
COMMENT ON COLUMN BARS.SOS_TRACK.USERID IS 'Код користувача, що змінив стан документу';
COMMENT ON COLUMN BARS.SOS_TRACK.KF IS '';




PROMPT *** Create  constraint FK_SOSTRACK_KF ***
begin   
 execute immediate '
  ALTER TABLE BARS.SOS_TRACK ADD CONSTRAINT FK_SOSTRACK_KF FOREIGN KEY (KF)
	  REFERENCES BARS.BANKS$BASE (MFO) ENABLE NOVALIDATE';
exception when others then
  if  sqlcode=-2260 or sqlcode=-2261 or sqlcode=-2264 or sqlcode=-2275 or sqlcode=-1442 then null; else raise; end if;
 end;
/




PROMPT *** Create  constraint FK_SOSTRACK_STAFF ***
begin   
 execute immediate '
  ALTER TABLE BARS.SOS_TRACK ADD CONSTRAINT FK_SOSTRACK_STAFF FOREIGN KEY (USERID)
	  REFERENCES BARS.STAFF$BASE (ID) ENABLE NOVALIDATE';
exception when others then
  if  sqlcode=-2260 or sqlcode=-2261 or sqlcode=-2264 or sqlcode=-2275 or sqlcode=-1442 then null; else raise; end if;
 end;
/




PROMPT *** Create  constraint CC_SOSTRACK_REF_NN ***
begin   
 execute immediate '
  ALTER TABLE BARS.SOS_TRACK MODIFY (REF CONSTRAINT CC_SOSTRACK_REF_NN NOT NULL ENABLE)';
exception when others then
  if  sqlcode=-2260 or sqlcode=-2261 or sqlcode=-2264 or sqlcode=-2275 or sqlcode=-1442 then null; else raise; end if;
 end;
/




PROMPT *** Create  constraint CC_SOSTRACK_SOSTRACKER_NN ***
begin   
 execute immediate '
  ALTER TABLE BARS.SOS_TRACK MODIFY (SOS_TRACKER CONSTRAINT CC_SOSTRACK_SOSTRACKER_NN NOT NULL ENABLE)';
exception when others then
  if  sqlcode=-2260 or sqlcode=-2261 or sqlcode=-2264 or sqlcode=-2275 or sqlcode=-1442 then null; else raise; end if;
 end;
/




PROMPT *** Create  constraint PK_SOSTRACK ***
begin   
 execute immediate '
  ALTER TABLE BARS.SOS_TRACK ADD CONSTRAINT PK_SOSTRACK PRIMARY KEY (REF, SOS_TRACKER)
  USING INDEX PCTFREE 10 INITRANS 2 MAXTRANS 255 COMPUTE STATISTICS 
  TABLESPACE BRSBIGD  ENABLE';
exception when others then
  if  sqlcode=-2260 or sqlcode=-2261 or sqlcode=-2264 or sqlcode=-2275 or sqlcode=-1442 then null; else raise; end if;
 end;
/




PROMPT *** Create  constraint CC_SOSTRACK_CHTIME_NN ***
begin   
 execute immediate '
  ALTER TABLE BARS.SOS_TRACK MODIFY (CHANGE_TIME CONSTRAINT CC_SOSTRACK_CHTIME_NN NOT NULL ENABLE)';
exception when others then
  if  sqlcode=-2260 or sqlcode=-2261 or sqlcode=-2264 or sqlcode=-2275 or sqlcode=-1442 then null; else raise; end if;
 end;
/




PROMPT *** Create  constraint CC_SOSTRACK_USERID_NN ***
begin   
 execute immediate '
  ALTER TABLE BARS.SOS_TRACK MODIFY (USERID CONSTRAINT CC_SOSTRACK_USERID_NN NOT NULL ENABLE)';
exception when others then
  if  sqlcode=-2260 or sqlcode=-2261 or sqlcode=-2264 or sqlcode=-2275 or sqlcode=-1442 then null; else raise; end if;
 end;
/




PROMPT *** Create  constraint CC_SOSTRACK_KF_NN ***
begin   
 execute immediate '
  ALTER TABLE BARS.SOS_TRACK MODIFY (KF CONSTRAINT CC_SOSTRACK_KF_NN NOT NULL ENABLE)';
exception when others then
  if  sqlcode=-2260 or sqlcode=-2261 or sqlcode=-2264 or sqlcode=-2275 or sqlcode=-1442 then null; else raise; end if;
 end;
/




PROMPT *** Create  constraint CC_SOSTRACK_NEWSOS_NN ***
begin   
 execute immediate '
  ALTER TABLE BARS.SOS_TRACK MODIFY (NEW_SOS CONSTRAINT CC_SOSTRACK_NEWSOS_NN NOT NULL ENABLE)';
exception when others then
  if  sqlcode=-2260 or sqlcode=-2261 or sqlcode=-2264 or sqlcode=-2275 or sqlcode=-1442 then null; else raise; end if;
 end;
/




PROMPT *** Create  index PK_SOSTRACK ***
begin   
 execute immediate '
  CREATE UNIQUE INDEX BARS.PK_SOSTRACK ON BARS.SOS_TRACK (REF, SOS_TRACKER) 
  PCTFREE 10 INITRANS 2 MAXTRANS 255 COMPUTE STATISTICS 
  TABLESPACE BRSBIGD ';
exception when others then
  if  sqlcode=-955  then null; else raise; end if;
 end;
/



PROMPT *** Create  grants  SOS_TRACK ***
grant FLASHBACK,REFERENCES,SELECT                                            on SOS_TRACK       to BARSAQ with grant option;
grant SELECT                                                                 on SOS_TRACK       to BARS_ACCESS_DEFROLE;
grant SELECT                                                                 on SOS_TRACK       to START1;



PROMPT ===================================================================================== 
PROMPT *** End *** ========== Scripts /Sql/BARS/Table/SOS_TRACK.sql =========*** End *** ===
PROMPT ===================================================================================== 
