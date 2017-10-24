

PROMPT ===================================================================================== 
PROMPT *** Run *** ========== Scripts /Sql/BARS/Table/WCS_BCK_REPORTS.sql =========*** Run *
PROMPT ===================================================================================== 


PROMPT *** ALTER_POLICY_INFO to WCS_BCK_REPORTS ***


BEGIN 
        execute immediate  
          'begin  
               bpa.alter_policy_info(''WCS_BCK_REPORTS'', ''CENTER'' , null, null, null, null);
               bpa.alter_policy_info(''WCS_BCK_REPORTS'', ''FILIAL'' , null, null, null, null);
               bpa.alter_policy_info(''WCS_BCK_REPORTS'', ''WHOLE'' , null, null, null, null);
               null;
           end; 
          '; 
END; 
/

PROMPT *** Create  table WCS_BCK_REPORTS ***
begin 
  execute immediate '
  CREATE TABLE BARS.WCS_BCK_REPORTS 
   (	REP_ID NUMBER(38,0), 
	BCK_ID NUMBER(38,0), 
	REP_TYPE VARCHAR2(3), 
	REP_DATE DATE, 
	REP_USER NUMBER(38,0), 
	RES_CODE NUMBER(5,0), 
	RES_MESSAGE VARCHAR2(512), 
	OKPO VARCHAR2(10), 
	REPORT CLOB
   ) SEGMENT CREATION IMMEDIATE 
  PCTFREE 10 PCTUSED 40 INITRANS 1 MAXTRANS 255 
 NOCOMPRESS LOGGING
  TABLESPACE BRSMDLD 
 LOB (REPORT) STORE AS BASICFILE (
  TABLESPACE BRSMDLD ENABLE STORAGE IN ROW CHUNK 8192 RETENTION 
  NOCACHE LOGGING ) ';
exception when others then       
  if sqlcode=-955 then null; else raise; end if; 
end; 
/




PROMPT *** ALTER_POLICIES to WCS_BCK_REPORTS ***
 exec bpa.alter_policies('WCS_BCK_REPORTS');


COMMENT ON TABLE BARS.WCS_BCK_REPORTS IS 'Таблица полученных от кредитного бюро отчетов';
COMMENT ON COLUMN BARS.WCS_BCK_REPORTS.REPORT IS 'Отчет';
COMMENT ON COLUMN BARS.WCS_BCK_REPORTS.REP_ID IS 'Идентификатор отчета';
COMMENT ON COLUMN BARS.WCS_BCK_REPORTS.BCK_ID IS 'Идентификатор кредитного бюро';
COMMENT ON COLUMN BARS.WCS_BCK_REPORTS.REP_TYPE IS 'Тип отчета';
COMMENT ON COLUMN BARS.WCS_BCK_REPORTS.REP_DATE IS 'Дата получения отчета';
COMMENT ON COLUMN BARS.WCS_BCK_REPORTS.REP_USER IS 'Пользователь, запросивший отчет';
COMMENT ON COLUMN BARS.WCS_BCK_REPORTS.RES_CODE IS 'Код ответа';
COMMENT ON COLUMN BARS.WCS_BCK_REPORTS.RES_MESSAGE IS 'Сообщение ответа';
COMMENT ON COLUMN BARS.WCS_BCK_REPORTS.OKPO IS 'ИНН физ.лица';




PROMPT *** Create  constraint CC_WCSBCKREPS_NN ***
begin   
 execute immediate '
  ALTER TABLE BARS.WCS_BCK_REPORTS MODIFY (BCK_ID CONSTRAINT CC_WCSBCKREPS_NN NOT NULL ENABLE)';
exception when others then
  if  sqlcode=-2260 or sqlcode=-2261 or sqlcode=-2264 or sqlcode=-2275 or sqlcode=-1442 then null; else raise; end if;
 end;
/




PROMPT *** Create  constraint CC_WCSBCKREPS_REPTYPE_NN ***
begin   
 execute immediate '
  ALTER TABLE BARS.WCS_BCK_REPORTS MODIFY (REP_TYPE CONSTRAINT CC_WCSBCKREPS_REPTYPE_NN NOT NULL ENABLE)';
exception when others then
  if  sqlcode=-2260 or sqlcode=-2261 or sqlcode=-2264 or sqlcode=-2275 or sqlcode=-1442 then null; else raise; end if;
 end;
/




PROMPT *** Create  constraint CC_WCSBCKREPS_REPDATE_NN ***
begin   
 execute immediate '
  ALTER TABLE BARS.WCS_BCK_REPORTS MODIFY (REP_DATE CONSTRAINT CC_WCSBCKREPS_REPDATE_NN NOT NULL ENABLE)';
exception when others then
  if  sqlcode=-2260 or sqlcode=-2261 or sqlcode=-2264 or sqlcode=-2275 or sqlcode=-1442 then null; else raise; end if;
 end;
/




PROMPT *** Create  constraint CC_WCSBCKREPS_REPUSER_NN ***
begin   
 execute immediate '
  ALTER TABLE BARS.WCS_BCK_REPORTS MODIFY (REP_USER CONSTRAINT CC_WCSBCKREPS_REPUSER_NN NOT NULL ENABLE)';
exception when others then
  if  sqlcode=-2260 or sqlcode=-2261 or sqlcode=-2264 or sqlcode=-2275 or sqlcode=-1442 then null; else raise; end if;
 end;
/




PROMPT *** Create  constraint CC_WCSBCKREPS_OKPO_NN ***
begin   
 execute immediate '
  ALTER TABLE BARS.WCS_BCK_REPORTS MODIFY (OKPO CONSTRAINT CC_WCSBCKREPS_OKPO_NN NOT NULL ENABLE)';
exception when others then
  if  sqlcode=-2260 or sqlcode=-2261 or sqlcode=-2264 or sqlcode=-2275 or sqlcode=-1442 then null; else raise; end if;
 end;
/




PROMPT *** Create  constraint FK_WCSBCKREPORTS_WCSBCK ***
begin   
 execute immediate '
  ALTER TABLE BARS.WCS_BCK_REPORTS ADD CONSTRAINT FK_WCSBCKREPORTS_WCSBCK FOREIGN KEY (BCK_ID)
	  REFERENCES BARS.WCS_BCK (BCK_ID) ENABLE';
exception when others then
  if  sqlcode=-2260 or sqlcode=-2261 or sqlcode=-2264 or sqlcode=-2275 or sqlcode=-1442 then null; else raise; end if;
 end;
/




PROMPT *** Create  constraint CC_WCSBCKREPS_REPTYPE ***
begin   
 execute immediate '
  ALTER TABLE BARS.WCS_BCK_REPORTS ADD CONSTRAINT CC_WCSBCKREPS_REPTYPE CHECK (REP_TYPE IN (''PSP'',''ALL'', ''ALB'', ''BLC'', ''12'', ''2'')) ENABLE';
exception when others then
  if  sqlcode=-2260 or sqlcode=-2261 or sqlcode=-2264 or sqlcode=-2275 or sqlcode=-1442 then null; else raise; end if;
 end;
/




PROMPT *** Create  constraint PK_WCSBCKREPS ***
begin   
 execute immediate '
  ALTER TABLE BARS.WCS_BCK_REPORTS ADD CONSTRAINT PK_WCSBCKREPS PRIMARY KEY (REP_ID)
  USING INDEX PCTFREE 10 INITRANS 2 MAXTRANS 255 COMPUTE STATISTICS 
  TABLESPACE BRSMDLD  ENABLE';
exception when others then
  if  sqlcode=-2260 or sqlcode=-2261 or sqlcode=-2264 or sqlcode=-2275 or sqlcode=-1442 then null; else raise; end if;
 end;
/




PROMPT *** Create  index PK_WCSBCKREPS ***
begin   
 execute immediate '
  CREATE UNIQUE INDEX BARS.PK_WCSBCKREPS ON BARS.WCS_BCK_REPORTS (REP_ID) 
  PCTFREE 10 INITRANS 2 MAXTRANS 255 COMPUTE STATISTICS 
  TABLESPACE BRSMDLD ';
exception when others then
  if  sqlcode=-955  then null; else raise; end if;
 end;
/




PROMPT *** Create  index I1_WCSBCKREPS ***
begin   
 execute immediate '
  CREATE INDEX BARS.I1_WCSBCKREPS ON BARS.WCS_BCK_REPORTS (OKPO) 
  PCTFREE 10 INITRANS 2 MAXTRANS 255 COMPUTE STATISTICS 
  TABLESPACE BRSDYND ';
exception when others then
  if  sqlcode=-955  then null; else raise; end if;
 end;
/



PROMPT *** Create  grants  WCS_BCK_REPORTS ***
grant DELETE,INSERT,SELECT,UPDATE                                            on WCS_BCK_REPORTS to BARS_ACCESS_DEFROLE;
grant SELECT                                                                 on WCS_BCK_REPORTS to BARS_DM;
grant DELETE,INSERT,SELECT,UPDATE                                            on WCS_BCK_REPORTS to START1;



PROMPT ===================================================================================== 
PROMPT *** End *** ========== Scripts /Sql/BARS/Table/WCS_BCK_REPORTS.sql =========*** End *
PROMPT ===================================================================================== 
