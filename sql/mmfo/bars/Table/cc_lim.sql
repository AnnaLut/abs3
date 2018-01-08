

PROMPT ===================================================================================== 
PROMPT *** Run *** ========== Scripts /Sql/BARS/Table/CC_LIM.sql =========*** Run *** ======
PROMPT ===================================================================================== 


PROMPT *** ALTER_POLICY_INFO to CC_LIM ***


BEGIN 
        execute immediate  
          'begin  
               bpa.alter_policy_info(''CC_LIM'', ''CENTER'' , null, ''E'', ''E'', ''E'');
               bpa.alter_policy_info(''CC_LIM'', ''FILIAL'' , ''M'', ''M'', ''M'', ''M'');
               bpa.alter_policy_info(''CC_LIM'', ''WHOLE'' , null, ''E'', ''E'', ''E'');
               null;
           end; 
          '; 
END; 
/

PROMPT *** Create  table CC_LIM ***
begin 
  execute immediate '
  CREATE TABLE BARS.CC_LIM 
   (	ND NUMBER(38,0), 
	FDAT DATE, 
	LIM2 NUMBER(38,0), 
	ACC NUMBER(*,0), 
	NOT_9129 NUMBER(*,0), 
	SUMG NUMBER(38,0), 
	SUMO NUMBER(38,0), 
	OTM NUMBER(*,0), 
	KF VARCHAR2(6) DEFAULT sys_context(''bars_context'',''user_mfo''), 
	SUMK NUMBER, 
	NOT_SN NUMBER(*,0)
   ) SEGMENT CREATION IMMEDIATE 
  PCTFREE 10 PCTUSED 40 INITRANS 1 MAXTRANS 255 
 NOCOMPRESS LOGGING
  TABLESPACE BRSBIGD  ENABLE ROW MOVEMENT ';
exception when others then       
  if sqlcode=-955 then null; else raise; end if; 
end; 
/




PROMPT *** ALTER_POLICIES to CC_LIM ***
 exec bpa.alter_policies('CC_LIM');


COMMENT ON TABLE BARS.CC_LIM IS 'График Лимитов Кредитования (ГЛК),он же График Погашения Кредита (ГПК)';
COMMENT ON COLUMN BARS.CC_LIM.ND IS 'Реф КД';
COMMENT ON COLUMN BARS.CC_LIM.FDAT IS 'Плат.дата или Дата изм.лимита';
COMMENT ON COLUMN BARS.CC_LIM.LIM2 IS 'Сумма нового лимита';
COMMENT ON COLUMN BARS.CC_LIM.ACC IS 'Сч 8999*';
COMMENT ON COLUMN BARS.CC_LIM.NOT_9129 IS 'Не менять 9129';
COMMENT ON COLUMN BARS.CC_LIM.SUMG IS 'План-сумма гашения осн.долга';
COMMENT ON COLUMN BARS.CC_LIM.SUMO IS 'Общая План-Сумма гашения';
COMMENT ON COLUMN BARS.CC_LIM.OTM IS 'Отметка о ПОЛНОСТЬЮ загашенном платеже';
COMMENT ON COLUMN BARS.CC_LIM.KF IS '';
COMMENT ON COLUMN BARS.CC_LIM.SUMK IS 'План-Сумма гашения комиссии';
COMMENT ON COLUMN BARS.CC_LIM.NOT_SN IS '1= В занную дату Не платить нач.доходы (% и комиссию)';




PROMPT *** Create  constraint XPK_CC_LIM ***
begin   
 execute immediate '
  ALTER TABLE BARS.CC_LIM ADD CONSTRAINT XPK_CC_LIM PRIMARY KEY (ND, FDAT)
  USING INDEX PCTFREE 10 INITRANS 2 MAXTRANS 255 COMPUTE STATISTICS 
  TABLESPACE BRSBIGI  ENABLE NOVALIDATE';
exception when others then
  if  sqlcode=-2260 or sqlcode=-2261 or sqlcode=-2264 or sqlcode=-2275 or sqlcode=-1442 then null; else raise; end if;
 end;
/




PROMPT *** Create  constraint FK_CCLIM_ACCOUNTS ***
begin   
 execute immediate '
  ALTER TABLE BARS.CC_LIM ADD CONSTRAINT FK_CCLIM_ACCOUNTS FOREIGN KEY (ACC)
	  REFERENCES BARS.ACCOUNTS (ACC) ENABLE NOVALIDATE';
exception when others then
  if  sqlcode=-2260 or sqlcode=-2261 or sqlcode=-2264 or sqlcode=-2275 or sqlcode=-1442 then null; else raise; end if;
 end;
/




PROMPT *** Create  constraint FK_CC_LIM ***
begin   
 execute immediate '
  ALTER TABLE BARS.CC_LIM ADD CONSTRAINT FK_CC_LIM FOREIGN KEY (ND)
	  REFERENCES BARS.CC_DEAL (ND) DEFERRABLE ENABLE NOVALIDATE';
exception when others then
  if  sqlcode=-2260 or sqlcode=-2261 or sqlcode=-2264 or sqlcode=-2275 or sqlcode=-1442 then null; else raise; end if;
 end;
/




PROMPT *** Create  constraint FK_CCLIM_KF ***
begin   
 execute immediate '
  ALTER TABLE BARS.CC_LIM ADD CONSTRAINT FK_CCLIM_KF FOREIGN KEY (KF)
	  REFERENCES BARS.BANKS$BASE (MFO) ENABLE NOVALIDATE';
exception when others then
  if  sqlcode=-2260 or sqlcode=-2261 or sqlcode=-2264 or sqlcode=-2275 or sqlcode=-1442 then null; else raise; end if;
 end;
/




PROMPT *** Create  constraint CC_CCLIM_KF_NN ***
begin   
 execute immediate '
  ALTER TABLE BARS.CC_LIM MODIFY (KF CONSTRAINT CC_CCLIM_KF_NN NOT NULL ENABLE NOVALIDATE)';
exception when others then
  if  sqlcode=-2260 or sqlcode=-2261 or sqlcode=-2264 or sqlcode=-2275 or sqlcode=-1442 then null; else raise; end if;
 end;
/




PROMPT *** Create  index IDX_CCLIM_KFACC ***
begin   
 execute immediate '
  CREATE INDEX BARS.IDX_CCLIM_KFACC ON BARS.CC_LIM (KF, ACC) 
  PCTFREE 10 INITRANS 2 MAXTRANS 255 COMPUTE STATISTICS 
  TABLESPACE BRSDYND ';
exception when others then
  if  sqlcode=-955  then null; else raise; end if;
 end;
/




PROMPT *** Create  index UK_CCLIM ***
begin   
 execute immediate '
  CREATE UNIQUE INDEX BARS.UK_CCLIM ON BARS.CC_LIM (KF, ND, FDAT) 
  PCTFREE 10 INITRANS 2 MAXTRANS 255 COMPUTE STATISTICS 
  TABLESPACE BRSBIGI ';
exception when others then
  if  sqlcode=-955  then null; else raise; end if;
 end;
/




PROMPT *** Create  index XPK_CC_LIM ***
begin   
 execute immediate '
  CREATE UNIQUE INDEX BARS.XPK_CC_LIM ON BARS.CC_LIM (ND, FDAT) 
  PCTFREE 10 INITRANS 2 MAXTRANS 255 COMPUTE STATISTICS 
  TABLESPACE BRSBIGI ';
exception when others then
  if  sqlcode=-955  then null; else raise; end if;
 end;
/



PROMPT *** Create  grants  CC_LIM ***
grant SELECT                                                                 on CC_LIM          to BARSUPL;
grant ALTER,DEBUG,DELETE,INSERT,ON COMMIT REFRESH,QUERY REWRITE,SELECT,UPDATE on CC_LIM          to BARS_ACCESS_DEFROLE;
grant SELECT                                                                 on CC_LIM          to BARS_DM;
grant ALTER,DEBUG,DELETE,INSERT,ON COMMIT REFRESH,QUERY REWRITE,SELECT,UPDATE on CC_LIM          to RCC_DEAL;
grant DELETE,FLASHBACK,INSERT,SELECT,UPDATE                                  on CC_LIM          to WR_ALL_RIGHTS;



PROMPT *** Create SYNONYM  to CC_LIM ***

  CREATE OR REPLACE PUBLIC SYNONYM CC_POG FOR BARS.CC_LIM;


PROMPT ===================================================================================== 
PROMPT *** End *** ========== Scripts /Sql/BARS/Table/CC_LIM.sql =========*** End *** ======
PROMPT ===================================================================================== 
