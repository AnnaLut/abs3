

PROMPT ===================================================================================== 
PROMPT *** Run *** ========== Scripts /Sql/BARS/Table/DILER_KURS_FACT.sql =========*** Run *
PROMPT ===================================================================================== 


PROMPT *** ALTER_POLICY_INFO to DILER_KURS_FACT ***


BEGIN 
        execute immediate  
          'begin  
               bpa.alter_policy_info(''DILER_KURS_FACT'', ''CENTER'' , null, null, null, null);
               bpa.alter_policy_info(''DILER_KURS_FACT'', ''FILIAL'' , null, null, null, null);
               bpa.alter_policy_info(''DILER_KURS_FACT'', ''WHOLE'' , null, null, null, null);
               null;
           end; 
          '; 
END; 
/

PROMPT *** Create  table DILER_KURS_FACT ***
begin 
  execute immediate '
  CREATE TABLE BARS.DILER_KURS_FACT 
   (	DAT DATE, 
	KV NUMBER, 
	ID NUMBER, 
	KURS_B NUMBER(35,8), 
	KURS_S NUMBER(35,8), 
	CODE NUMBER
   ) SEGMENT CREATION IMMEDIATE 
  PCTFREE 10 PCTUSED 40 INITRANS 1 MAXTRANS 255 
 NOCOMPRESS LOGGING
  TABLESPACE BRSMDLD ';
exception when others then       
  if sqlcode=-955 then null; else raise; end if; 
end; 
/




PROMPT *** ALTER_POLICIES to DILER_KURS_FACT ***
 exec bpa.alter_policies('DILER_KURS_FACT');


COMMENT ON TABLE BARS.DILER_KURS_FACT IS 'Предварит.курсы покупки/продажи валют';
COMMENT ON COLUMN BARS.DILER_KURS_FACT.DAT IS 'Дата установки';
COMMENT ON COLUMN BARS.DILER_KURS_FACT.KV IS 'Код валюты';
COMMENT ON COLUMN BARS.DILER_KURS_FACT.ID IS 'Код исполнителя';
COMMENT ON COLUMN BARS.DILER_KURS_FACT.KURS_B IS 'Курс покупки';
COMMENT ON COLUMN BARS.DILER_KURS_FACT.KURS_S IS 'Курс продажи';
COMMENT ON COLUMN BARS.DILER_KURS_FACT.CODE IS 'Идентификатор';




PROMPT *** Create  constraint PK_DILERKURSFACT ***
begin   
 execute immediate '
  ALTER TABLE BARS.DILER_KURS_FACT ADD CONSTRAINT PK_DILERKURSFACT PRIMARY KEY (CODE)
  USING INDEX PCTFREE 10 INITRANS 2 MAXTRANS 255 COMPUTE STATISTICS 
  TABLESPACE BRSMDLD  ENABLE';
exception when others then
  if  sqlcode=-2260 or sqlcode=-2261 or sqlcode=-2264 or sqlcode=-2275 or sqlcode=-1442 then null; else raise; end if;
 end;
/




PROMPT *** Create  index PK_DILERKURSFACT ***
begin   
 execute immediate '
  CREATE UNIQUE INDEX BARS.PK_DILERKURSFACT ON BARS.DILER_KURS_FACT (CODE) 
  PCTFREE 10 INITRANS 2 MAXTRANS 255 COMPUTE STATISTICS 
  TABLESPACE BRSMDLD ';
exception when others then
  if  sqlcode=-955  then null; else raise; end if;
 end;
/




PROMPT *** Create  index I_DILERKURSFACT_KV_DAT ***
begin   
 execute immediate '
  CREATE UNIQUE INDEX BARS.I_DILERKURSFACT_KV_DAT ON BARS.DILER_KURS_FACT (KV, DAT) 
  PCTFREE 10 INITRANS 2 MAXTRANS 255 COMPUTE STATISTICS 
  TABLESPACE BRSMDLI ';
exception when others then
  if  sqlcode=-955  then null; else raise; end if;
 end;
/



PROMPT *** Create  grants  DILER_KURS_FACT ***
grant SELECT                                                                 on DILER_KURS_FACT to BARSREADER_ROLE;
grant DELETE,INSERT,SELECT,UPDATE                                            on DILER_KURS_FACT to BARS_ACCESS_DEFROLE;
grant SELECT                                                                 on DILER_KURS_FACT to BARS_DM;
grant SELECT                                                                 on DILER_KURS_FACT to UPLD;
grant DELETE,INSERT,SELECT,UPDATE                                            on DILER_KURS_FACT to ZAY;



PROMPT ===================================================================================== 
PROMPT *** End *** ========== Scripts /Sql/BARS/Table/DILER_KURS_FACT.sql =========*** End *
PROMPT ===================================================================================== 
