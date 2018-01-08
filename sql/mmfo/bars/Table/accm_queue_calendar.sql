

PROMPT ===================================================================================== 
PROMPT *** Run *** ========== Scripts /Sql/BARS/Table/ACCM_QUEUE_CALENDAR.sql =========*** R
PROMPT ===================================================================================== 


PROMPT *** ALTER_POLICY_INFO to ACCM_QUEUE_CALENDAR ***


BEGIN 
        execute immediate  
          'begin  
               bpa.alter_policy_info(''ACCM_QUEUE_CALENDAR'', ''CENTER'' , null, null, null, null);
               bpa.alter_policy_info(''ACCM_QUEUE_CALENDAR'', ''FILIAL'' , null, null, null, null);
               bpa.alter_policy_info(''ACCM_QUEUE_CALENDAR'', ''WHOLE'' , null, null, null, null);
               null;
           end; 
          '; 
END; 
/

PROMPT *** Create  table ACCM_QUEUE_CALENDAR ***
begin 
  execute immediate '
  CREATE TABLE BARS.ACCM_QUEUE_CALENDAR 
   (	CAL_DATE DATE, 
	BANK_DATE DATE, 
	REP_DATE DATE, 
	 CONSTRAINT PK_ACCMQUECAL PRIMARY KEY (CAL_DATE) ENABLE
   ) ORGANIZATION INDEX NOCOMPRESS PCTFREE 10 INITRANS 2 MAXTRANS 255 LOGGING
  TABLESPACE BRSDYNI 
 PCTTHRESHOLD 50';
exception when others then       
  if sqlcode=-955 then null; else raise; end if; 
end; 
/




PROMPT *** ALTER_POLICIES to ACCM_QUEUE_CALENDAR ***
 exec bpa.alter_policies('ACCM_QUEUE_CALENDAR');


COMMENT ON TABLE BARS.ACCM_QUEUE_CALENDAR IS '';
COMMENT ON COLUMN BARS.ACCM_QUEUE_CALENDAR.CAL_DATE IS '';
COMMENT ON COLUMN BARS.ACCM_QUEUE_CALENDAR.BANK_DATE IS '';
COMMENT ON COLUMN BARS.ACCM_QUEUE_CALENDAR.REP_DATE IS '';




PROMPT *** Create  constraint CC_ACCMQUECAL_CALDATE_NN ***
begin   
 execute immediate '
  ALTER TABLE BARS.ACCM_QUEUE_CALENDAR MODIFY (CAL_DATE CONSTRAINT CC_ACCMQUECAL_CALDATE_NN NOT NULL ENABLE)';
exception when others then
  if  sqlcode=-2260 or sqlcode=-2261 or sqlcode=-2264 or sqlcode=-2275 or sqlcode=-1442 then null; else raise; end if;
 end;
/




PROMPT *** Create  constraint CC_ACCMQUECAL_BANKDATE_NN ***
begin   
 execute immediate '
  ALTER TABLE BARS.ACCM_QUEUE_CALENDAR MODIFY (BANK_DATE CONSTRAINT CC_ACCMQUECAL_BANKDATE_NN NOT NULL ENABLE)';
exception when others then
  if  sqlcode=-2260 or sqlcode=-2261 or sqlcode=-2264 or sqlcode=-2275 or sqlcode=-1442 then null; else raise; end if;
 end;
/




PROMPT *** Create  constraint CC_ACCMQUECAL_REPDATE_NN ***
begin   
 execute immediate '
  ALTER TABLE BARS.ACCM_QUEUE_CALENDAR MODIFY (REP_DATE CONSTRAINT CC_ACCMQUECAL_REPDATE_NN NOT NULL ENABLE)';
exception when others then
  if  sqlcode=-2260 or sqlcode=-2261 or sqlcode=-2264 or sqlcode=-2275 or sqlcode=-1442 then null; else raise; end if;
 end;
/




PROMPT *** Create  constraint PK_ACCMQUECAL ***
begin   
 execute immediate '
  ALTER TABLE BARS.ACCM_QUEUE_CALENDAR ADD CONSTRAINT PK_ACCMQUECAL PRIMARY KEY (CAL_DATE)
  USING INDEX PCTFREE 10 INITRANS 2 MAXTRANS 255 COMPUTE STATISTICS 
  TABLESPACE BRSDYNI  ENABLE';
exception when others then
  if  sqlcode=-2260 or sqlcode=-2261 or sqlcode=-2264 or sqlcode=-2275 or sqlcode=-1442 then null; else raise; end if;
 end;
/




PROMPT *** Create  index PK_ACCMQUECAL ***
begin   
 execute immediate '
  CREATE UNIQUE INDEX BARS.PK_ACCMQUECAL ON BARS.ACCM_QUEUE_CALENDAR (CAL_DATE) 
  PCTFREE 10 INITRANS 2 MAXTRANS 255 COMPUTE STATISTICS 
  TABLESPACE BRSDYNI ';
exception when others then
  if  sqlcode=-955  then null; else raise; end if;
 end;
/



PROMPT *** Create  grants  ACCM_QUEUE_CALENDAR ***
grant SELECT                                                                 on ACCM_QUEUE_CALENDAR to BARSREADER_ROLE;
grant DELETE,INSERT,SELECT,UPDATE                                            on ACCM_QUEUE_CALENDAR to BARS_ACCESS_DEFROLE;
grant SELECT                                                                 on ACCM_QUEUE_CALENDAR to BARS_DM;
grant DELETE,INSERT,SELECT,UPDATE                                            on ACCM_QUEUE_CALENDAR to START1;



PROMPT ===================================================================================== 
PROMPT *** End *** ========== Scripts /Sql/BARS/Table/ACCM_QUEUE_CALENDAR.sql =========*** E
PROMPT ===================================================================================== 
