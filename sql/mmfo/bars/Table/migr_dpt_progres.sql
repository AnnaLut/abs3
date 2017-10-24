

PROMPT ===================================================================================== 
PROMPT *** Run *** ========== Scripts /Sql/BARS/Table/MIGR_DPT_PROGRES.sql =========*** Run 
PROMPT ===================================================================================== 


PROMPT *** ALTER_POLICY_INFO to MIGR_DPT_PROGRES ***


BEGIN 
        execute immediate  
          'begin  
               bpa.alter_policy_info(''MIGR_DPT_PROGRES'', ''CENTER'' , null, null, null, null);
               bpa.alter_policy_info(''MIGR_DPT_PROGRES'', ''FILIAL'' , null, null, null, null);
               bpa.alter_policy_info(''MIGR_DPT_PROGRES'', ''WHOLE'' , null, null, null, null);
               null;
           end; 
          '; 
END; 
/

PROMPT *** Create  table MIGR_DPT_PROGRES ***
begin 
  execute immediate '
  CREATE TABLE BARS.MIGR_DPT_PROGRES 
   (	DATE_ON DATE, 
	KV NUMBER(3,0), 
	TERM NUMBER(4,0), 
	RATE NUMBER(20,4)
   ) SEGMENT CREATION DEFERRED 
  PCTFREE 10 PCTUSED 40 INITRANS 1 MAXTRANS 255 
 NOCOMPRESS LOGGING
  TABLESPACE BRSSMLI ';
exception when others then       
  if sqlcode=-955 then null; else raise; end if; 
end; 
/




PROMPT *** ALTER_POLICIES to MIGR_DPT_PROGRES ***
 exec bpa.alter_policies('MIGR_DPT_PROGRES');


COMMENT ON TABLE BARS.MIGR_DPT_PROGRES IS 'Шкала процентных ставок для миграции вкладов типа <Прогрессивный>';
COMMENT ON COLUMN BARS.MIGR_DPT_PROGRES.DATE_ON IS 'Дата начала действия ставки';
COMMENT ON COLUMN BARS.MIGR_DPT_PROGRES.KV IS 'Валюта';
COMMENT ON COLUMN BARS.MIGR_DPT_PROGRES.TERM IS 'Срок в месяцах';
COMMENT ON COLUMN BARS.MIGR_DPT_PROGRES.RATE IS 'Значение ставки';




PROMPT *** Create  constraint PK_MIGRDPTPROGRES ***
begin   
 execute immediate '
  ALTER TABLE BARS.MIGR_DPT_PROGRES ADD CONSTRAINT PK_MIGRDPTPROGRES PRIMARY KEY (KV, TERM, DATE_ON)
  USING INDEX PCTFREE 10 INITRANS 2 MAXTRANS 255 COMPUTE STATISTICS 
  TABLESPACE BRSSMLI  ENABLE';
exception when others then
  if  sqlcode=-2260 or sqlcode=-2261 or sqlcode=-2264 or sqlcode=-2275 or sqlcode=-1442 then null; else raise; end if;
 end;
/




PROMPT *** Create  constraint FK_MIGRDPTPROGRES_TABVAL ***
begin   
 execute immediate '
  ALTER TABLE BARS.MIGR_DPT_PROGRES ADD CONSTRAINT FK_MIGRDPTPROGRES_TABVAL FOREIGN KEY (KV)
	  REFERENCES BARS.TABVAL$GLOBAL (KV) ENABLE';
exception when others then
  if  sqlcode=-2260 or sqlcode=-2261 or sqlcode=-2264 or sqlcode=-2275 or sqlcode=-1442 then null; else raise; end if;
 end;
/




PROMPT *** Create  constraint CC_MIGRDPTPROGRES_DATEON_NN ***
begin   
 execute immediate '
  ALTER TABLE BARS.MIGR_DPT_PROGRES MODIFY (DATE_ON CONSTRAINT CC_MIGRDPTPROGRES_DATEON_NN NOT NULL ENABLE)';
exception when others then
  if  sqlcode=-2260 or sqlcode=-2261 or sqlcode=-2264 or sqlcode=-2275 or sqlcode=-1442 then null; else raise; end if;
 end;
/




PROMPT *** Create  constraint CC_MIGRDPTPROGRES_KV_NN ***
begin   
 execute immediate '
  ALTER TABLE BARS.MIGR_DPT_PROGRES MODIFY (KV CONSTRAINT CC_MIGRDPTPROGRES_KV_NN NOT NULL ENABLE)';
exception when others then
  if  sqlcode=-2260 or sqlcode=-2261 or sqlcode=-2264 or sqlcode=-2275 or sqlcode=-1442 then null; else raise; end if;
 end;
/




PROMPT *** Create  constraint CC_MIGRDPTPROGRES_TERM_NN ***
begin   
 execute immediate '
  ALTER TABLE BARS.MIGR_DPT_PROGRES MODIFY (TERM CONSTRAINT CC_MIGRDPTPROGRES_TERM_NN NOT NULL ENABLE)';
exception when others then
  if  sqlcode=-2260 or sqlcode=-2261 or sqlcode=-2264 or sqlcode=-2275 or sqlcode=-1442 then null; else raise; end if;
 end;
/




PROMPT *** Create  constraint CC_MIGRDPTPROGRES_RATE_NN ***
begin   
 execute immediate '
  ALTER TABLE BARS.MIGR_DPT_PROGRES MODIFY (RATE CONSTRAINT CC_MIGRDPTPROGRES_RATE_NN NOT NULL ENABLE)';
exception when others then
  if  sqlcode=-2260 or sqlcode=-2261 or sqlcode=-2264 or sqlcode=-2275 or sqlcode=-1442 then null; else raise; end if;
 end;
/




PROMPT *** Create  index PK_MIGRDPTPROGRES ***
begin   
 execute immediate '
  CREATE UNIQUE INDEX BARS.PK_MIGRDPTPROGRES ON BARS.MIGR_DPT_PROGRES (KV, TERM, DATE_ON) 
  PCTFREE 10 INITRANS 2 MAXTRANS 255 COMPUTE STATISTICS 
  TABLESPACE BRSSMLI ';
exception when others then
  if  sqlcode=-955  then null; else raise; end if;
 end;
/



PROMPT *** Create  grants  MIGR_DPT_PROGRES ***
grant DELETE,FLASHBACK,INSERT,SELECT,UPDATE                                  on MIGR_DPT_PROGRES to BARS_ACCESS_DEFROLE;
grant DELETE,INSERT,SELECT,UPDATE                                            on MIGR_DPT_PROGRES to DPT_ADMIN;
grant FLASHBACK,SELECT                                                       on MIGR_DPT_PROGRES to WR_REFREAD;



PROMPT ===================================================================================== 
PROMPT *** End *** ========== Scripts /Sql/BARS/Table/MIGR_DPT_PROGRES.sql =========*** End 
PROMPT ===================================================================================== 
