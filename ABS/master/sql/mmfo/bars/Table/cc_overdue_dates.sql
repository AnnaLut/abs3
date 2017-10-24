

PROMPT ===================================================================================== 
PROMPT *** Run *** ========== Scripts /Sql/BARS/Table/CC_OVERDUE_DATES.sql =========*** Run 
PROMPT ===================================================================================== 


PROMPT *** ALTER_POLICY_INFO to CC_OVERDUE_DATES ***


BEGIN 
        execute immediate  
          'begin  
               bpa.alter_policy_info(''CC_OVERDUE_DATES'', ''CENTER'' , null, ''E'', ''E'', ''E'');
               bpa.alter_policy_info(''CC_OVERDUE_DATES'', ''FILIAL'' , ''M'', ''M'', ''M'', ''M'');
               bpa.alter_policy_info(''CC_OVERDUE_DATES'', ''WHOLE'' , null, ''E'', ''E'', ''E'');
               null;
           end; 
          '; 
END; 
/

PROMPT *** Create  table CC_OVERDUE_DATES ***
begin 
  execute immediate '
  CREATE TABLE BARS.CC_OVERDUE_DATES 
   (	ND NUMBER, 
	NDTYPE NUMBER, 
	OVERDUE_TYPE VARCHAR2(3), 
	OVERDUE_METHOD NUMBER, 
	REPORT_DATE DATE, 
	OVERDUE_DATE DATE, 
	KF VARCHAR2(6) DEFAULT sys_context(''bars_context'',''user_mfo'')
   ) SEGMENT CREATION IMMEDIATE 
  PCTFREE 10 PCTUSED 40 INITRANS 1 MAXTRANS 255 
 NOCOMPRESS LOGGING
  TABLESPACE BRSMDLD ';
exception when others then       
  if sqlcode=-955 then null; else raise; end if; 
end; 
/




PROMPT *** ALTER_POLICIES to CC_OVERDUE_DATES ***
 exec bpa.alter_policies('CC_OVERDUE_DATES');


COMMENT ON TABLE BARS.CC_OVERDUE_DATES IS 'Таблица содержит накопленные данные по датам появления просроченной заборгованости по юл';
COMMENT ON COLUMN BARS.CC_OVERDUE_DATES.ND IS '';
COMMENT ON COLUMN BARS.CC_OVERDUE_DATES.NDTYPE IS '';
COMMENT ON COLUMN BARS.CC_OVERDUE_DATES.OVERDUE_TYPE IS '';
COMMENT ON COLUMN BARS.CC_OVERDUE_DATES.OVERDUE_METHOD IS '';
COMMENT ON COLUMN BARS.CC_OVERDUE_DATES.REPORT_DATE IS '';
COMMENT ON COLUMN BARS.CC_OVERDUE_DATES.OVERDUE_DATE IS '';
COMMENT ON COLUMN BARS.CC_OVERDUE_DATES.KF IS '';




PROMPT *** Create  constraint PK_CCOVERDUEDATES ***
begin   
 execute immediate '
  ALTER TABLE BARS.CC_OVERDUE_DATES ADD CONSTRAINT PK_CCOVERDUEDATES PRIMARY KEY (REPORT_DATE, ND, OVERDUE_TYPE)
  USING INDEX PCTFREE 10 INITRANS 2 MAXTRANS 255 COMPUTE STATISTICS 
  TABLESPACE BRSMDLI  ENABLE';
exception when others then
  if  sqlcode=-2260 or sqlcode=-2261 or sqlcode=-2264 or sqlcode=-2275 or sqlcode=-1442 then null; else raise; end if;
 end;
/




PROMPT *** Create  constraint CC_CCOVERDUEDATES_KF_NN ***
begin   
 execute immediate '
  ALTER TABLE BARS.CC_OVERDUE_DATES MODIFY (KF CONSTRAINT CC_CCOVERDUEDATES_KF_NN NOT NULL ENABLE)';
exception when others then
  if  sqlcode=-2260 or sqlcode=-2261 or sqlcode=-2264 or sqlcode=-2275 or sqlcode=-1442 then null; else raise; end if;
 end;
/




PROMPT *** Create  constraint FK_CCOVERDUEDATES_KF ***
begin   
 execute immediate '
  ALTER TABLE BARS.CC_OVERDUE_DATES ADD CONSTRAINT FK_CCOVERDUEDATES_KF FOREIGN KEY (KF)
	  REFERENCES BARS.BANKS$BASE (MFO) ENABLE NOVALIDATE';
exception when others then
  if  sqlcode=-2260 or sqlcode=-2261 or sqlcode=-2264 or sqlcode=-2275 or sqlcode=-1442 then null; else raise; end if;
 end;
/




PROMPT *** Create  index PK_CCOVERDUEDATES ***
begin   
 execute immediate '
  CREATE UNIQUE INDEX BARS.PK_CCOVERDUEDATES ON BARS.CC_OVERDUE_DATES (REPORT_DATE, ND, OVERDUE_TYPE) 
  PCTFREE 10 INITRANS 2 MAXTRANS 255 COMPUTE STATISTICS 
  TABLESPACE BRSMDLI ';
exception when others then
  if  sqlcode=-955  then null; else raise; end if;
 end;
/



PROMPT *** Create  grants  CC_OVERDUE_DATES ***
grant SELECT                                                                 on CC_OVERDUE_DATES to BARSDWH_ACCESS_USER;
grant SELECT                                                                 on CC_OVERDUE_DATES to BARS_DM;



PROMPT ===================================================================================== 
PROMPT *** End *** ========== Scripts /Sql/BARS/Table/CC_OVERDUE_DATES.sql =========*** End 
PROMPT ===================================================================================== 
