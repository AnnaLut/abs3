

PROMPT ===================================================================================== 
PROMPT *** Run *** ========== Scripts /Sql/BARS/Table/CC_VIDD.sql =========*** Run *** =====
PROMPT ===================================================================================== 


PROMPT *** ALTER_POLICY_INFO to CC_VIDD ***


BEGIN 
        execute immediate  
          'begin  
               bpa.alter_policy_info(''CC_VIDD'', ''CENTER'' , null, null, null, null);
               bpa.alter_policy_info(''CC_VIDD'', ''FILIAL'' , null, ''E'', ''E'', ''E'');
               bpa.alter_policy_info(''CC_VIDD'', ''WHOLE'' , null, null, null, null);
               null;
           end; 
          '; 
END; 
/

PROMPT *** Create  table CC_VIDD ***
begin 
  execute immediate '
  CREATE TABLE BARS.CC_VIDD 
   (	VIDD NUMBER(38,0), 
	CUSTTYPE NUMBER(1,0), 
	TIPD NUMBER(1,0), 
	NAME VARCHAR2(70), 
	SPS NUMBER(1,0)
   ) SEGMENT CREATION IMMEDIATE 
  PCTFREE 10 PCTUSED 40 INITRANS 1 MAXTRANS 255 
 NOCOMPRESS LOGGING
  TABLESPACE BRSSMLD ';
exception when others then       
  if sqlcode=-955 then null; else raise; end if; 
end; 
/




PROMPT *** ALTER_POLICIES to CC_VIDD ***
 exec bpa.alter_policies('CC_VIDD');


COMMENT ON TABLE BARS.CC_VIDD IS 'Виды договоров';
COMMENT ON COLUMN BARS.CC_VIDD.VIDD IS 'Код вида договора';
COMMENT ON COLUMN BARS.CC_VIDD.CUSTTYPE IS 'Тип клиента
3 - физическое лицо
2 - юридическое лицо
1 - банк';
COMMENT ON COLUMN BARS.CC_VIDD.TIPD IS 'Код типа договора
1 - Кредитный, 2 - Депозитный';
COMMENT ON COLUMN BARS.CC_VIDD.NAME IS 'Вид договора';
COMMENT ON COLUMN BARS.CC_VIDD.SPS IS 'Способ вычисления';




PROMPT *** Create  constraint PK_CCVIDD ***
begin   
 execute immediate '
  ALTER TABLE BARS.CC_VIDD ADD CONSTRAINT PK_CCVIDD PRIMARY KEY (VIDD)
  USING INDEX PCTFREE 10 INITRANS 2 MAXTRANS 255 COMPUTE STATISTICS 
  TABLESPACE BRSSMLI  ENABLE';
exception when others then
  if  sqlcode=-2260 or sqlcode=-2261 or sqlcode=-2264 or sqlcode=-2275 or sqlcode=-1442 then null; else raise; end if;
 end;
/




PROMPT *** Create  constraint FK_CCVIDD_CCTIPD ***
begin   
 execute immediate '
  ALTER TABLE BARS.CC_VIDD ADD CONSTRAINT FK_CCVIDD_CCTIPD FOREIGN KEY (TIPD)
	  REFERENCES BARS.CC_TIPD (TIPD) ENABLE';
exception when others then
  if  sqlcode=-2260 or sqlcode=-2261 or sqlcode=-2264 or sqlcode=-2275 or sqlcode=-1442 then null; else raise; end if;
 end;
/




PROMPT *** Create  constraint FK_CCVIDD_CUSTTYPE ***
begin   
 execute immediate '
  ALTER TABLE BARS.CC_VIDD ADD CONSTRAINT FK_CCVIDD_CUSTTYPE FOREIGN KEY (CUSTTYPE)
	  REFERENCES BARS.CUSTTYPE (CUSTTYPE) ENABLE';
exception when others then
  if  sqlcode=-2260 or sqlcode=-2261 or sqlcode=-2264 or sqlcode=-2275 or sqlcode=-1442 then null; else raise; end if;
 end;
/




PROMPT *** Create  constraint CC_CCVIDD_VIDD_NN ***
begin   
 execute immediate '
  ALTER TABLE BARS.CC_VIDD MODIFY (VIDD CONSTRAINT CC_CCVIDD_VIDD_NN NOT NULL ENABLE)';
exception when others then
  if  sqlcode=-2260 or sqlcode=-2261 or sqlcode=-2264 or sqlcode=-2275 or sqlcode=-1442 then null; else raise; end if;
 end;
/




PROMPT *** Create  constraint CC_CCVIDD_CUSTTYPE_NN ***
begin   
 execute immediate '
  ALTER TABLE BARS.CC_VIDD MODIFY (CUSTTYPE CONSTRAINT CC_CCVIDD_CUSTTYPE_NN NOT NULL ENABLE)';
exception when others then
  if  sqlcode=-2260 or sqlcode=-2261 or sqlcode=-2264 or sqlcode=-2275 or sqlcode=-1442 then null; else raise; end if;
 end;
/




PROMPT *** Create  constraint CC_CCVIDD_TIPD_NN ***
begin   
 execute immediate '
  ALTER TABLE BARS.CC_VIDD MODIFY (TIPD CONSTRAINT CC_CCVIDD_TIPD_NN NOT NULL ENABLE)';
exception when others then
  if  sqlcode=-2260 or sqlcode=-2261 or sqlcode=-2264 or sqlcode=-2275 or sqlcode=-1442 then null; else raise; end if;
 end;
/




PROMPT *** Create  constraint CC_CCVIDD_NAME_NN ***
begin   
 execute immediate '
  ALTER TABLE BARS.CC_VIDD MODIFY (NAME CONSTRAINT CC_CCVIDD_NAME_NN NOT NULL ENABLE)';
exception when others then
  if  sqlcode=-2260 or sqlcode=-2261 or sqlcode=-2264 or sqlcode=-2275 or sqlcode=-1442 then null; else raise; end if;
 end;
/




PROMPT *** Create  index PK_CCVIDD ***
begin   
 execute immediate '
  CREATE UNIQUE INDEX BARS.PK_CCVIDD ON BARS.CC_VIDD (VIDD) 
  PCTFREE 10 INITRANS 2 MAXTRANS 255 COMPUTE STATISTICS 
  TABLESPACE BRSSMLI ';
exception when others then
  if  sqlcode=-955  then null; else raise; end if;
 end;
/



PROMPT *** Create  grants  CC_VIDD ***
grant DELETE,INSERT,SELECT,UPDATE                                            on CC_VIDD         to ABS_ADMIN;
grant DELETE,INSERT,SELECT,UPDATE                                            on CC_VIDD         to BARS009;
grant SELECT                                                                 on CC_VIDD         to BARSUPL;
grant ALTER,DELETE,FLASHBACK,INSERT,SELECT,UPDATE                            on CC_VIDD         to BARS_ACCESS_DEFROLE;
grant SELECT                                                                 on CC_VIDD         to BARS_DM;
grant DELETE,INSERT,SELECT,UPDATE                                            on CC_VIDD         to CC_VIDD;
grant DELETE,INSERT,SELECT,UPDATE                                            on CC_VIDD         to DPT_ADMIN;
grant SELECT                                                                 on CC_VIDD         to FOREX;
grant ALTER,DELETE,INSERT,SELECT,UPDATE                                      on CC_VIDD         to RCC_DEAL;
grant DELETE,INSERT,SELECT,UPDATE                                            on CC_VIDD         to TECH005;
grant DELETE,INSERT,SELECT,UPDATE                                            on CC_VIDD         to TECH006;
grant DELETE,FLASHBACK,INSERT,SELECT,UPDATE                                  on CC_VIDD         to WR_ALL_RIGHTS;
grant FLASHBACK,SELECT                                                       on CC_VIDD         to WR_REFREAD;



PROMPT ===================================================================================== 
PROMPT *** End *** ========== Scripts /Sql/BARS/Table/CC_VIDD.sql =========*** End *** =====
PROMPT ===================================================================================== 
