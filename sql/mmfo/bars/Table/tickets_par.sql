

PROMPT ===================================================================================== 
PROMPT *** Run *** ========== Scripts /Sql/BARS/Table/TICKETS_PAR.sql =========*** Run *** =
PROMPT ===================================================================================== 


PROMPT *** ALTER_POLICY_INFO to TICKETS_PAR ***


BEGIN 
        execute immediate  
          'begin  
               bpa.alter_policy_info(''TICKETS_PAR'', ''CENTER'' , null, null, null, null);
               bpa.alter_policy_info(''TICKETS_PAR'', ''FILIAL'' , null, ''E'', ''E'', ''E'');
               bpa.alter_policy_info(''TICKETS_PAR'', ''WHOLE'' , null, null, null, null);
               null;
           end; 
          '; 
END; 
/

PROMPT *** Create  table TICKETS_PAR ***
begin 
  execute immediate '
  CREATE TABLE BARS.TICKETS_PAR 
   (	REP_PREFIX VARCHAR2(8), 
	PAR VARCHAR2(12), 
	TXT VARCHAR2(4000), 
	COMM VARCHAR2(70), 
	MOD_CODE VARCHAR2(3) DEFAULT ''TIC''
   ) SEGMENT CREATION IMMEDIATE 
  PCTFREE 5 PCTUSED 40 INITRANS 1 MAXTRANS 255 
 NOCOMPRESS LOGGING
  TABLESPACE BRSSMLD ';
exception when others then       
  if sqlcode=-955 then null; else raise; end if; 
end; 
/




PROMPT *** ALTER_POLICIES to TICKETS_PAR ***
 exec bpa.alter_policies('TICKETS_PAR');


COMMENT ON TABLE BARS.TICKETS_PAR IS 'Справочник переменных для тикетов';
COMMENT ON COLUMN BARS.TICKETS_PAR.REP_PREFIX IS 'Ім'я файла шаблона';
COMMENT ON COLUMN BARS.TICKETS_PAR.PAR IS 'Ім'я змінної';
COMMENT ON COLUMN BARS.TICKETS_PAR.TXT IS 'SQL-вираз для визначення змінної';
COMMENT ON COLUMN BARS.TICKETS_PAR.COMM IS 'Коментар';
COMMENT ON COLUMN BARS.TICKETS_PAR.MOD_CODE IS 'Код модуля: TIC-печать тикетов операций';




PROMPT *** Create  constraint PK_TICKETSPAR ***
begin   
 execute immediate '
  ALTER TABLE BARS.TICKETS_PAR ADD CONSTRAINT PK_TICKETSPAR PRIMARY KEY (REP_PREFIX, PAR)
  USING INDEX PCTFREE 10 INITRANS 2 MAXTRANS 255 COMPUTE STATISTICS 
  TABLESPACE BRSSMLI  ENABLE';
exception when others then
  if  sqlcode=-2260 or sqlcode=-2261 or sqlcode=-2264 or sqlcode=-2275 or sqlcode=-1442 then null; else raise; end if;
 end;
/




PROMPT *** Create  constraint CC_TICKETSPAR_REPPREFIX_NN ***
begin   
 execute immediate '
  ALTER TABLE BARS.TICKETS_PAR MODIFY (REP_PREFIX CONSTRAINT CC_TICKETSPAR_REPPREFIX_NN NOT NULL ENABLE)';
exception when others then
  if  sqlcode=-2260 or sqlcode=-2261 or sqlcode=-2264 or sqlcode=-2275 or sqlcode=-1442 then null; else raise; end if;
 end;
/




PROMPT *** Create  constraint CC_TICKETSPAR_PAR_NN ***
begin   
 execute immediate '
  ALTER TABLE BARS.TICKETS_PAR MODIFY (PAR CONSTRAINT CC_TICKETSPAR_PAR_NN NOT NULL ENABLE)';
exception when others then
  if  sqlcode=-2260 or sqlcode=-2261 or sqlcode=-2264 or sqlcode=-2275 or sqlcode=-1442 then null; else raise; end if;
 end;
/




PROMPT *** Create  constraint CC_TICKETSPAR_MODCODE_NN ***
begin   
 execute immediate '
  ALTER TABLE BARS.TICKETS_PAR MODIFY (MOD_CODE CONSTRAINT CC_TICKETSPAR_MODCODE_NN NOT NULL ENABLE)';
exception when others then
  if  sqlcode=-2260 or sqlcode=-2261 or sqlcode=-2264 or sqlcode=-2275 or sqlcode=-1442 then null; else raise; end if;
 end;
/




PROMPT *** Create  index PK_TICKETSPAR ***
begin   
 execute immediate '
  CREATE UNIQUE INDEX BARS.PK_TICKETSPAR ON BARS.TICKETS_PAR (REP_PREFIX, PAR) 
  PCTFREE 10 INITRANS 2 MAXTRANS 255 COMPUTE STATISTICS 
  TABLESPACE BRSSMLI ';
exception when others then
  if  sqlcode=-955  then null; else raise; end if;
 end;
/



PROMPT *** Create  grants  TICKETS_PAR ***
grant DELETE,INSERT,SELECT,UPDATE                                            on TICKETS_PAR     to ABS_ADMIN;
grant SELECT                                                                 on TICKETS_PAR     to BARS014;
grant SELECT                                                                 on TICKETS_PAR     to BARSREADER_ROLE;
grant DELETE,FLASHBACK,INSERT,SELECT,UPDATE                                  on TICKETS_PAR     to BARS_ACCESS_DEFROLE;
grant SELECT                                                                 on TICKETS_PAR     to BARS_DM;
grant SELECT                                                                 on TICKETS_PAR     to CHCK002;
grant SELECT                                                                 on TICKETS_PAR     to FOREX;
grant SELECT                                                                 on TICKETS_PAR     to SALGL;
grant SELECT                                                                 on TICKETS_PAR     to START1;
grant DELETE,INSERT,SELECT,UPDATE                                            on TICKETS_PAR     to TECH005;
grant DELETE,INSERT,SELECT,UPDATE                                            on TICKETS_PAR     to TICKETS_PAR;
grant SELECT                                                                 on TICKETS_PAR     to UPLD;
grant DELETE,FLASHBACK,INSERT,SELECT,UPDATE                                  on TICKETS_PAR     to WR_ALL_RIGHTS;
grant FLASHBACK,SELECT                                                       on TICKETS_PAR     to WR_REFREAD;



PROMPT ===================================================================================== 
PROMPT *** End *** ========== Scripts /Sql/BARS/Table/TICKETS_PAR.sql =========*** End *** =
PROMPT ===================================================================================== 
