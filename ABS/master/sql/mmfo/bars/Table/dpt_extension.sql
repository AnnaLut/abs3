

PROMPT ===================================================================================== 
PROMPT *** Run *** ========== Scripts /Sql/BARS/Table/DPT_EXTENSION.sql =========*** Run ***
PROMPT ===================================================================================== 


PROMPT *** ALTER_POLICY_INFO to DPT_EXTENSION ***


BEGIN 
        execute immediate  
          'begin  
               bpa.alter_policy_info(''DPT_EXTENSION'', ''CENTER'' , null, null, null, null);
               bpa.alter_policy_info(''DPT_EXTENSION'', ''FILIAL'' , ''B'', ''B'', ''B'', ''B'');
               bpa.alter_policy_info(''DPT_EXTENSION'', ''WHOLE'' , null, null, null, null);
               null;
           end; 
          '; 
END; 
/

PROMPT *** Create  table DPT_EXTENSION ***
begin 
  execute immediate '
  CREATE TABLE BARS.DPT_EXTENSION 
   (	ID NUMBER(38,0), 
	NAME VARCHAR2(50), 
	N_DUBL NUMBER(10,0), 
	DURATION VARCHAR2(20), 
	IR NUMBER(20,4), 
	OP NUMBER(38,0), 
	BR NUMBER(38,0), 
	METHOD NUMBER(38,0), 
	BRANCH VARCHAR2(30) DEFAULT sys_context(''bars_context'',''user_branch'')
   ) SEGMENT CREATION IMMEDIATE 
  PCTFREE 5 PCTUSED 40 INITRANS 1 MAXTRANS 255 
 NOCOMPRESS LOGGING
  TABLESPACE BRSSMLD ';
exception when others then       
  if sqlcode=-955 then null; else raise; end if; 
end; 
/




PROMPT *** ALTER_POLICIES to DPT_EXTENSION ***
 exec bpa.alter_policies('DPT_EXTENSION');


COMMENT ON TABLE BARS.DPT_EXTENSION IS 'Таблица описания изменений %%-ных ставок при автопереоформлении вкладов';
COMMENT ON COLUMN BARS.DPT_EXTENSION.ID IS 'Идентификатор метода';
COMMENT ON COLUMN BARS.DPT_EXTENSION.NAME IS 'Наименование';
COMMENT ON COLUMN BARS.DPT_EXTENSION.N_DUBL IS 'Порядковый номер изменения %%-ной ставки';
COMMENT ON COLUMN BARS.DPT_EXTENSION.DURATION IS 'Длит-ть действия %%-ной ставки';
COMMENT ON COLUMN BARS.DPT_EXTENSION.IR IS 'Индивид.%%-ная ставка';
COMMENT ON COLUMN BARS.DPT_EXTENSION.OP IS 'Код арифмет.операции';
COMMENT ON COLUMN BARS.DPT_EXTENSION.BR IS 'Код базовой %%-ной ставки';
COMMENT ON COLUMN BARS.DPT_EXTENSION.METHOD IS 'Метод вычисления значения баз.%%-ной ставки';
COMMENT ON COLUMN BARS.DPT_EXTENSION.BRANCH IS 'Код отделения';




PROMPT *** Create  constraint PK_DPTEXT ***
begin   
 execute immediate '
  ALTER TABLE BARS.DPT_EXTENSION ADD CONSTRAINT PK_DPTEXT PRIMARY KEY (ID, N_DUBL)
  USING INDEX PCTFREE 10 INITRANS 2 MAXTRANS 255 COMPUTE STATISTICS 
  TABLESPACE BRSSMLI  ENABLE';
exception when others then
  if  sqlcode=-2260 or sqlcode=-2261 or sqlcode=-2264 or sqlcode=-2275 or sqlcode=-1442 then null; else raise; end if;
 end;
/




PROMPT *** Create  constraint FK_DPTEXT_BRANCH ***
begin   
 execute immediate '
  ALTER TABLE BARS.DPT_EXTENSION ADD CONSTRAINT FK_DPTEXT_BRANCH FOREIGN KEY (BRANCH)
	  REFERENCES BARS.BRANCH (BRANCH) DEFERRABLE ENABLE';
exception when others then
  if  sqlcode=-2260 or sqlcode=-2261 or sqlcode=-2264 or sqlcode=-2275 or sqlcode=-1442 then null; else raise; end if;
 end;
/




PROMPT *** Create  constraint FK_DPTEXT_DPTEXTMETHOD ***
begin   
 execute immediate '
  ALTER TABLE BARS.DPT_EXTENSION ADD CONSTRAINT FK_DPTEXT_DPTEXTMETHOD FOREIGN KEY (METHOD)
	  REFERENCES BARS.DPT_EXTENSION_METHOD (METHOD) ENABLE';
exception when others then
  if  sqlcode=-2260 or sqlcode=-2261 or sqlcode=-2264 or sqlcode=-2275 or sqlcode=-1442 then null; else raise; end if;
 end;
/




PROMPT *** Create  constraint FK_DPTEXT_INTOP ***
begin   
 execute immediate '
  ALTER TABLE BARS.DPT_EXTENSION ADD CONSTRAINT FK_DPTEXT_INTOP FOREIGN KEY (OP)
	  REFERENCES BARS.INT_OP (OP) ENABLE';
exception when others then
  if  sqlcode=-2260 or sqlcode=-2261 or sqlcode=-2264 or sqlcode=-2275 or sqlcode=-1442 then null; else raise; end if;
 end;
/




PROMPT *** Create  constraint CC_DPTEXT_ID_NN ***
begin   
 execute immediate '
  ALTER TABLE BARS.DPT_EXTENSION MODIFY (ID CONSTRAINT CC_DPTEXT_ID_NN NOT NULL ENABLE)';
exception when others then
  if  sqlcode=-2260 or sqlcode=-2261 or sqlcode=-2264 or sqlcode=-2275 or sqlcode=-1442 then null; else raise; end if;
 end;
/




PROMPT *** Create  constraint CC_DPTEXT_NAME_NN ***
begin   
 execute immediate '
  ALTER TABLE BARS.DPT_EXTENSION MODIFY (NAME CONSTRAINT CC_DPTEXT_NAME_NN NOT NULL ENABLE)';
exception when others then
  if  sqlcode=-2260 or sqlcode=-2261 or sqlcode=-2264 or sqlcode=-2275 or sqlcode=-1442 then null; else raise; end if;
 end;
/




PROMPT *** Create  constraint CC_DPTEXT_BRANCH_NN ***
begin   
 execute immediate '
  ALTER TABLE BARS.DPT_EXTENSION MODIFY (BRANCH CONSTRAINT CC_DPTEXT_BRANCH_NN NOT NULL ENABLE)';
exception when others then
  if  sqlcode=-2260 or sqlcode=-2261 or sqlcode=-2264 or sqlcode=-2275 or sqlcode=-1442 then null; else raise; end if;
 end;
/




PROMPT *** Create  constraint CC_DPTEXT_NDUBL_NN ***
begin   
 execute immediate '
  ALTER TABLE BARS.DPT_EXTENSION MODIFY (N_DUBL CONSTRAINT CC_DPTEXT_NDUBL_NN NOT NULL ENABLE)';
exception when others then
  if  sqlcode=-2260 or sqlcode=-2261 or sqlcode=-2264 or sqlcode=-2275 or sqlcode=-1442 then null; else raise; end if;
 end;
/




PROMPT *** Create  index PK_DPTEXT ***
begin   
 execute immediate '
  CREATE UNIQUE INDEX BARS.PK_DPTEXT ON BARS.DPT_EXTENSION (ID, N_DUBL) 
  PCTFREE 10 INITRANS 2 MAXTRANS 255 COMPUTE STATISTICS 
  TABLESPACE BRSSMLI ';
exception when others then
  if  sqlcode=-955  then null; else raise; end if;
 end;
/



PROMPT *** Create  grants  DPT_EXTENSION ***
grant DELETE,INSERT,SELECT,UPDATE                                            on DPT_EXTENSION   to ABS_ADMIN;
grant DELETE,FLASHBACK,INSERT,SELECT,UPDATE                                  on DPT_EXTENSION   to BARS_ACCESS_DEFROLE;
grant SELECT                                                                 on DPT_EXTENSION   to BARS_DM;
grant DELETE,INSERT,SELECT,UPDATE                                            on DPT_EXTENSION   to DPT_ADMIN;
grant SELECT                                                                 on DPT_EXTENSION   to START1;
grant DELETE,INSERT,SELECT,UPDATE                                            on DPT_EXTENSION   to VKLAD;
grant DELETE,FLASHBACK,INSERT,SELECT,UPDATE                                  on DPT_EXTENSION   to WR_ALL_RIGHTS;
grant FLASHBACK,SELECT                                                       on DPT_EXTENSION   to WR_REFREAD;



PROMPT ===================================================================================== 
PROMPT *** End *** ========== Scripts /Sql/BARS/Table/DPT_EXTENSION.sql =========*** End ***
PROMPT ===================================================================================== 
