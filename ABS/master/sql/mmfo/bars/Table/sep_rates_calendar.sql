

PROMPT ===================================================================================== 
PROMPT *** Run *** ========== Scripts /Sql/BARS/Table/SEP_RATES_CALENDAR.sql =========*** Ru
PROMPT ===================================================================================== 


PROMPT *** ALTER_POLICY_INFO to SEP_RATES_CALENDAR ***


BEGIN 
        execute immediate  
          'begin  
               bpa.alter_policy_info(''SEP_RATES_CALENDAR'', ''CENTER'' , null, null, null, null);
               bpa.alter_policy_info(''SEP_RATES_CALENDAR'', ''FILIAL'' , null, null, null, null);
               bpa.alter_policy_info(''SEP_RATES_CALENDAR'', ''WHOLE'' , null, null, null, null);
               null;
           end; 
          '; 
END; 
/

PROMPT *** Create  table SEP_RATES_CALENDAR ***
begin 
  execute immediate '
  CREATE TABLE BARS.SEP_RATES_CALENDAR 
   (	ID NUMBER(*,0), 
	START_DATE DATE, 
	FINISH_DATE DATE, 
	TOTAL_SUM NUMBER, 
	CLOSED VARCHAR2(1)
   ) SEGMENT CREATION IMMEDIATE 
  PCTFREE 10 PCTUSED 40 INITRANS 1 MAXTRANS 255 
 NOCOMPRESS LOGGING
  TABLESPACE BRSDYND ';
exception when others then       
  if sqlcode=-955 then null; else raise; end if; 
end; 
/




PROMPT *** ALTER_POLICIES to SEP_RATES_CALENDAR ***
 exec bpa.alter_policies('SEP_RATES_CALENDAR');


COMMENT ON TABLE BARS.SEP_RATES_CALENDAR IS '';
COMMENT ON COLUMN BARS.SEP_RATES_CALENDAR.ID IS '';
COMMENT ON COLUMN BARS.SEP_RATES_CALENDAR.START_DATE IS '';
COMMENT ON COLUMN BARS.SEP_RATES_CALENDAR.FINISH_DATE IS '';
COMMENT ON COLUMN BARS.SEP_RATES_CALENDAR.TOTAL_SUM IS '';
COMMENT ON COLUMN BARS.SEP_RATES_CALENDAR.CLOSED IS '';




PROMPT *** Create  constraint PK_SEPRATESCAL ***
begin   
 execute immediate '
  ALTER TABLE BARS.SEP_RATES_CALENDAR ADD CONSTRAINT PK_SEPRATESCAL PRIMARY KEY (ID)
  USING INDEX PCTFREE 10 INITRANS 2 MAXTRANS 255 COMPUTE STATISTICS 
  TABLESPACE BRSDYND  ENABLE';
exception when others then
  if  sqlcode=-2260 or sqlcode=-2261 or sqlcode=-2264 or sqlcode=-2275 or sqlcode=-1442 then null; else raise; end if;
 end;
/




PROMPT *** Create  constraint CC_SEPRATESCAL_ID_NN ***
begin   
 execute immediate '
  ALTER TABLE BARS.SEP_RATES_CALENDAR MODIFY (ID CONSTRAINT CC_SEPRATESCAL_ID_NN NOT NULL ENABLE)';
exception when others then
  if  sqlcode=-2260 or sqlcode=-2261 or sqlcode=-2264 or sqlcode=-2275 or sqlcode=-1442 then null; else raise; end if;
 end;
/




PROMPT *** Create  constraint CC_SEPRATESCAL_SDATE_NN ***
begin   
 execute immediate '
  ALTER TABLE BARS.SEP_RATES_CALENDAR MODIFY (START_DATE CONSTRAINT CC_SEPRATESCAL_SDATE_NN NOT NULL ENABLE)';
exception when others then
  if  sqlcode=-2260 or sqlcode=-2261 or sqlcode=-2264 or sqlcode=-2275 or sqlcode=-1442 then null; else raise; end if;
 end;
/




PROMPT *** Create  constraint CC_SEPRATESCAL_FDATE_NN ***
begin   
 execute immediate '
  ALTER TABLE BARS.SEP_RATES_CALENDAR MODIFY (FINISH_DATE CONSTRAINT CC_SEPRATESCAL_FDATE_NN NOT NULL ENABLE)';
exception when others then
  if  sqlcode=-2260 or sqlcode=-2261 or sqlcode=-2264 or sqlcode=-2275 or sqlcode=-1442 then null; else raise; end if;
 end;
/




PROMPT *** Create  index PK_SEPRATESCAL ***
begin   
 execute immediate '
  CREATE UNIQUE INDEX BARS.PK_SEPRATESCAL ON BARS.SEP_RATES_CALENDAR (ID) 
  PCTFREE 10 INITRANS 2 MAXTRANS 255 COMPUTE STATISTICS 
  TABLESPACE BRSDYND ';
exception when others then
  if  sqlcode=-955  then null; else raise; end if;
 end;
/



PROMPT *** Create  grants  SEP_RATES_CALENDAR ***
grant DELETE,INSERT,SELECT,UPDATE                                            on SEP_RATES_CALENDAR to BARS_ACCESS_DEFROLE;
grant SELECT                                                                 on SEP_RATES_CALENDAR to BARS_DM;
grant DELETE,INSERT,SELECT,UPDATE                                            on SEP_RATES_CALENDAR to START1;



PROMPT ===================================================================================== 
PROMPT *** End *** ========== Scripts /Sql/BARS/Table/SEP_RATES_CALENDAR.sql =========*** En
PROMPT ===================================================================================== 
