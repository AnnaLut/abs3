

PROMPT ===================================================================================== 
PROMPT *** Run *** ========== Scripts /Sql/BARS/Table/BANKS$SETTINGS.sql =========*** Run **
PROMPT ===================================================================================== 


PROMPT *** ALTER_POLICY_INFO to BANKS$SETTINGS ***


BEGIN 
        execute immediate  
          'begin  
               bpa.alter_policy_info(''BANKS$SETTINGS'', ''CENTER'' , null, ''E'', ''E'', ''E'');
               bpa.alter_policy_info(''BANKS$SETTINGS'', ''FILIAL'' , ''M'', ''M'', ''M'', ''M'');
               bpa.alter_policy_info(''BANKS$SETTINGS'', ''WHOLE'' , null, ''E'', ''E'', ''E'');
               null;
           end; 
          '; 
END; 
/

PROMPT *** Create  table BANKS$SETTINGS ***
begin 
  execute immediate '
  CREATE TABLE BARS.BANKS$SETTINGS 
   (	KF VARCHAR2(6) DEFAULT sys_context(''bars_context'',''user_mfo''), 
	MFO VARCHAR2(6), 
	FMI VARCHAR2(2), 
	FMO VARCHAR2(2), 
	PM NUMBER(1,0), 
	KODN NUMBER(1,0), 
	MFOP VARCHAR2(6)
   ) SEGMENT CREATION IMMEDIATE 
  PCTFREE 10 PCTUSED 40 INITRANS 1 MAXTRANS 255 
 NOCOMPRESS LOGGING
  TABLESPACE BRSSMLD ';
exception when others then       
  if sqlcode=-955 then null; else raise; end if; 
end; 
/




PROMPT *** ALTER_POLICIES to BANKS$SETTINGS ***
 exec bpa.alter_policies('BANKS$SETTINGS');


COMMENT ON TABLE BARS.BANKS$SETTINGS IS '';
COMMENT ON COLUMN BARS.BANKS$SETTINGS.KF IS '';
COMMENT ON COLUMN BARS.BANKS$SETTINGS.MFO IS '';
COMMENT ON COLUMN BARS.BANKS$SETTINGS.FMI IS '';
COMMENT ON COLUMN BARS.BANKS$SETTINGS.FMO IS '';
COMMENT ON COLUMN BARS.BANKS$SETTINGS.PM IS '';
COMMENT ON COLUMN BARS.BANKS$SETTINGS.KODN IS '';
COMMENT ON COLUMN BARS.BANKS$SETTINGS.MFOP IS '';




PROMPT *** Create  constraint PK_BANKSSETTINGS ***
begin   
 execute immediate '
  ALTER TABLE BARS.BANKS$SETTINGS ADD CONSTRAINT PK_BANKSSETTINGS PRIMARY KEY (KF, MFO)
  USING INDEX PCTFREE 10 INITRANS 2 MAXTRANS 255 COMPUTE STATISTICS 
  TABLESPACE BRSSMLI  ENABLE';
exception when others then
  if  sqlcode=-2260 or sqlcode=-2261 or sqlcode=-2264 or sqlcode=-2275 or sqlcode=-1442 then null; else raise; end if;
 end;
/




PROMPT *** Create  constraint FK_BANKSSETTINGS_KF ***
begin   
 execute immediate '
  ALTER TABLE BARS.BANKS$SETTINGS ADD CONSTRAINT FK_BANKSSETTINGS_KF FOREIGN KEY (KF)
	  REFERENCES BARS.BANKS$BASE (MFO) ENABLE';
exception when others then
  if  sqlcode=-2260 or sqlcode=-2261 or sqlcode=-2264 or sqlcode=-2275 or sqlcode=-1442 then null; else raise; end if;
 end;
/




PROMPT *** Create  constraint CC_BANKSSETTINGS_MFOP_NN ***
begin   
 execute immediate '
  ALTER TABLE BARS.BANKS$SETTINGS MODIFY (MFOP CONSTRAINT CC_BANKSSETTINGS_MFOP_NN NOT NULL ENABLE)';
exception when others then
  if  sqlcode=-2260 or sqlcode=-2261 or sqlcode=-2264 or sqlcode=-2275 or sqlcode=-1442 then null; else raise; end if;
 end;
/




PROMPT *** Create  constraint CC_BANKSSETTINGS_MFO_NN ***
begin   
 execute immediate '
  ALTER TABLE BARS.BANKS$SETTINGS MODIFY (MFO CONSTRAINT CC_BANKSSETTINGS_MFO_NN NOT NULL ENABLE)';
exception when others then
  if  sqlcode=-2260 or sqlcode=-2261 or sqlcode=-2264 or sqlcode=-2275 or sqlcode=-1442 then null; else raise; end if;
 end;
/




PROMPT *** Create  constraint CC_BANKSSETTINGS_KF_NN ***
begin   
 execute immediate '
  ALTER TABLE BARS.BANKS$SETTINGS MODIFY (KF CONSTRAINT CC_BANKSSETTINGS_KF_NN NOT NULL ENABLE)';
exception when others then
  if  sqlcode=-2260 or sqlcode=-2261 or sqlcode=-2264 or sqlcode=-2275 or sqlcode=-1442 then null; else raise; end if;
 end;
/




PROMPT *** Create  constraint FK_BANKSSETTINGS_PM ***
begin   
 execute immediate '
  ALTER TABLE BARS.BANKS$SETTINGS ADD CONSTRAINT FK_BANKSSETTINGS_PM FOREIGN KEY (PM)
	  REFERENCES BARS.PM_RRP (PM) ENABLE';
exception when others then
  if  sqlcode=-2260 or sqlcode=-2261 or sqlcode=-2264 or sqlcode=-2275 or sqlcode=-1442 then null; else raise; end if;
 end;
/




PROMPT *** Create  constraint FK_BANKSSETTINGS_KODN ***
begin   
 execute immediate '
  ALTER TABLE BARS.BANKS$SETTINGS ADD CONSTRAINT FK_BANKSSETTINGS_KODN FOREIGN KEY (KODN)
	  REFERENCES BARS.DIR_RRP (KODN) ENABLE';
exception when others then
  if  sqlcode=-2260 or sqlcode=-2261 or sqlcode=-2264 or sqlcode=-2275 or sqlcode=-1442 then null; else raise; end if;
 end;
/




PROMPT *** Create  constraint FK_BANKSSETTINGS_MFO ***
begin   
 execute immediate '
  ALTER TABLE BARS.BANKS$SETTINGS ADD CONSTRAINT FK_BANKSSETTINGS_MFO FOREIGN KEY (MFO)
	  REFERENCES BARS.BANKS$BASE (MFO) ENABLE';
exception when others then
  if  sqlcode=-2260 or sqlcode=-2261 or sqlcode=-2264 or sqlcode=-2275 or sqlcode=-1442 then null; else raise; end if;
 end;
/




PROMPT *** Create  constraint FK_BANKSSETTINGS_MFOP ***
begin   
 execute immediate '
  ALTER TABLE BARS.BANKS$SETTINGS ADD CONSTRAINT FK_BANKSSETTINGS_MFOP FOREIGN KEY (MFOP)
	  REFERENCES BARS.BANKS$BASE (MFO) ENABLE';
exception when others then
  if  sqlcode=-2260 or sqlcode=-2261 or sqlcode=-2264 or sqlcode=-2275 or sqlcode=-1442 then null; else raise; end if;
 end;
/




PROMPT *** Create  index PK_BANKSSETTINGS ***
begin   
 execute immediate '
  CREATE UNIQUE INDEX BARS.PK_BANKSSETTINGS ON BARS.BANKS$SETTINGS (KF, MFO) 
  PCTFREE 10 INITRANS 2 MAXTRANS 255 COMPUTE STATISTICS 
  TABLESPACE BRSSMLI ';
exception when others then
  if  sqlcode=-955  then null; else raise; end if;
 end;
/



PROMPT *** Create  grants  BANKS$SETTINGS ***
grant SELECT                                                                 on BANKS$SETTINGS  to BARS_DM;
grant SELECT                                                                 on BANKS$SETTINGS  to JBOSS_USR;
grant SELECT                                                                 on BANKS$SETTINGS  to KLBX;
grant DELETE,FLASHBACK,INSERT,SELECT,UPDATE                                  on BANKS$SETTINGS  to WR_ALL_RIGHTS;



PROMPT ===================================================================================== 
PROMPT *** End *** ========== Scripts /Sql/BARS/Table/BANKS$SETTINGS.sql =========*** End **
PROMPT ===================================================================================== 
