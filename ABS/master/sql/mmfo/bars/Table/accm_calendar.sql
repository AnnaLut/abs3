

PROMPT ===================================================================================== 
PROMPT *** Run *** ========== Scripts /Sql/BARS/Table/ACCM_CALENDAR.sql =========*** Run ***
PROMPT ===================================================================================== 


PROMPT *** ALTER_POLICY_INFO to ACCM_CALENDAR ***


BEGIN 
        execute immediate  
          'begin  
               bpa.alter_policy_info(''ACCM_CALENDAR'', ''CENTER'' , null, null, null, null);
               bpa.alter_policy_info(''ACCM_CALENDAR'', ''FILIAL'' , null, null, null, null);
               bpa.alter_policy_info(''ACCM_CALENDAR'', ''WHOLE'' , null, null, null, null);
               null;
           end; 
          '; 
END; 
/

PROMPT *** Create  table ACCM_CALENDAR ***
begin 
  execute immediate '
  CREATE TABLE BARS.ACCM_CALENDAR 
   (	CALDT_ID NUMBER(38,0), 
	CALDT_DATE DATE, 
	BANKDT_ID NUMBER(38,0), 
	BANKDT_DATE DATE, 
	REPDT_ID NUMBER(38,0), 
	REPDT_DATE DATE
   ) SEGMENT CREATION IMMEDIATE 
  PCTFREE 10 PCTUSED 40 INITRANS 1 MAXTRANS 255 
 NOCOMPRESS LOGGING
  TABLESPACE BRSACCM ';
exception when others then       
  if sqlcode=-955 then null; else raise; end if; 
end; 
/




PROMPT *** ALTER_POLICIES to ACCM_CALENDAR ***
 exec bpa.alter_policies('ACCM_CALENDAR');


COMMENT ON TABLE BARS.ACCM_CALENDAR IS 'Подсистема накопления. Календарь';
COMMENT ON COLUMN BARS.ACCM_CALENDAR.CALDT_ID IS 'Ид. календарной даты';
COMMENT ON COLUMN BARS.ACCM_CALENDAR.CALDT_DATE IS 'Календарная дата';
COMMENT ON COLUMN BARS.ACCM_CALENDAR.BANKDT_ID IS 'Ид. банковской даты';
COMMENT ON COLUMN BARS.ACCM_CALENDAR.BANKDT_DATE IS 'Банковская дата';
COMMENT ON COLUMN BARS.ACCM_CALENDAR.REPDT_ID IS 'Ид. отчетной даты';
COMMENT ON COLUMN BARS.ACCM_CALENDAR.REPDT_DATE IS 'Отчетная дата';




PROMPT *** Create  constraint PK_ACCMCAL ***
begin   
 execute immediate '
  ALTER TABLE BARS.ACCM_CALENDAR ADD CONSTRAINT PK_ACCMCAL PRIMARY KEY (CALDT_ID)
  USING INDEX PCTFREE 10 INITRANS 2 MAXTRANS 255 COMPUTE STATISTICS 
  TABLESPACE BRSACCM  ENABLE';
exception when others then
  if  sqlcode=-2260 or sqlcode=-2261 or sqlcode=-2264 or sqlcode=-2275 or sqlcode=-1442 then null; else raise; end if;
 end;
/




PROMPT *** Create  constraint UK_ACCMCAL ***
begin   
 execute immediate '
  ALTER TABLE BARS.ACCM_CALENDAR ADD CONSTRAINT UK_ACCMCAL UNIQUE (CALDT_DATE)
  USING INDEX PCTFREE 10 INITRANS 2 MAXTRANS 255 COMPUTE STATISTICS 
  TABLESPACE BRSDYND  ENABLE';
exception when others then
  if  sqlcode=-2260 or sqlcode=-2261 or sqlcode=-2264 or sqlcode=-2275 or sqlcode=-1442 then null; else raise; end if;
 end;
/




PROMPT *** Create  constraint CC_ACCMCAL_CALID_NN ***
begin   
 execute immediate '
  ALTER TABLE BARS.ACCM_CALENDAR MODIFY (CALDT_ID CONSTRAINT CC_ACCMCAL_CALID_NN NOT NULL ENABLE)';
exception when others then
  if  sqlcode=-2260 or sqlcode=-2261 or sqlcode=-2264 or sqlcode=-2275 or sqlcode=-1442 then null; else raise; end if;
 end;
/




PROMPT *** Create  constraint CC_ACCMCAL_CALDATE_NN ***
begin   
 execute immediate '
  ALTER TABLE BARS.ACCM_CALENDAR MODIFY (CALDT_DATE CONSTRAINT CC_ACCMCAL_CALDATE_NN NOT NULL ENABLE)';
exception when others then
  if  sqlcode=-2260 or sqlcode=-2261 or sqlcode=-2264 or sqlcode=-2275 or sqlcode=-1442 then null; else raise; end if;
 end;
/




PROMPT *** Create  index PK_ACCMCAL ***
begin   
 execute immediate '
  CREATE UNIQUE INDEX BARS.PK_ACCMCAL ON BARS.ACCM_CALENDAR (CALDT_ID) 
  PCTFREE 10 INITRANS 2 MAXTRANS 255 COMPUTE STATISTICS 
  TABLESPACE BRSACCM ';
exception when others then
  if  sqlcode=-955  then null; else raise; end if;
 end;
/




PROMPT *** Create  index UK_ACCMCAL ***
begin   
 execute immediate '
  CREATE UNIQUE INDEX BARS.UK_ACCMCAL ON BARS.ACCM_CALENDAR (CALDT_DATE) 
  PCTFREE 10 INITRANS 2 MAXTRANS 255 COMPUTE STATISTICS 
  TABLESPACE BRSDYND ';
exception when others then
  if  sqlcode=-955  then null; else raise; end if;
 end;
/



PROMPT *** Create  grants  ACCM_CALENDAR ***
grant SELECT                                                                 on ACCM_CALENDAR   to BARSDWH_ACCESS_USER;
grant SELECT                                                                 on ACCM_CALENDAR   to BARSUPL;
grant SELECT                                                                 on ACCM_CALENDAR   to BARS_ACCESS_DEFROLE;
grant SELECT                                                                 on ACCM_CALENDAR   to BARS_DM;
grant SELECT                                                                 on ACCM_CALENDAR   to SALGL;
grant SELECT                                                                 on ACCM_CALENDAR   to START1;
grant SELECT                                                                 on ACCM_CALENDAR   to UPLD;



PROMPT ===================================================================================== 
PROMPT *** End *** ========== Scripts /Sql/BARS/Table/ACCM_CALENDAR.sql =========*** End ***
PROMPT ===================================================================================== 
