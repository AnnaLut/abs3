

PROMPT ===================================================================================== 
PROMPT *** Run *** ========== Scripts /Sql/BARS/Table/CC_ZAY.sql =========*** Run *** ======
PROMPT ===================================================================================== 


PROMPT *** ALTER_POLICY_INFO to CC_ZAY ***


BEGIN 
        execute immediate  
          'begin  
               bpa.alter_policy_info(''CC_ZAY'', ''CENTER'' , null, ''E'', ''E'', ''E'');
               bpa.alter_policy_info(''CC_ZAY'', ''FILIAL'' , ''M'', ''M'', ''M'', ''M'');
               bpa.alter_policy_info(''CC_ZAY'', ''WHOLE'' , null, ''E'', ''E'', ''E'');
               null;
           end; 
          '; 
END; 
/

PROMPT *** Create  table CC_ZAY ***
begin 
  execute immediate '
  CREATE TABLE BARS.CC_ZAY 
   (	FDAT DATE, 
	ID NUMBER(*,0), 
	RNK NUMBER(*,0), 
	TEL VARCHAR2(41), 
	S NUMBER(38,0), 
	KV NUMBER(38,0), 
	NZ NUMBER(38,0), 
	CUSTTYPE NUMBER(*,0), 
	NMK VARCHAR2(70), 
	DATZ DATE, 
	DATU DATE, 
	DATW DATE, 
	OKPO VARCHAR2(14), 
	SOS NUMBER(*,0), 
	KLA NUMBER(*,0), 
	BRANCH VARCHAR2(30) DEFAULT sys_context(''bars_context'',''user_branch''), 
	KF VARCHAR2(6) DEFAULT sys_context(''bars_context'',''user_mfo'')
   ) SEGMENT CREATION IMMEDIATE 
  PCTFREE 10 PCTUSED 40 INITRANS 1 MAXTRANS 255 
 NOCOMPRESS LOGGING
  TABLESPACE BRSMDLD ';
exception when others then       
  if sqlcode=-955 then null; else raise; end if; 
end; 
/




PROMPT *** ALTER_POLICIES to CC_ZAY ***
 exec bpa.alter_policies('CC_ZAY');


COMMENT ON TABLE BARS.CC_ZAY IS 'Заявки на кредиты ЮЛ и ФЛ';
COMMENT ON COLUMN BARS.CC_ZAY.NZ IS 'Реф заявки';
COMMENT ON COLUMN BARS.CC_ZAY.CUSTTYPE IS 'Тип заемщика';
COMMENT ON COLUMN BARS.CC_ZAY.NMK IS 'Наименование НЕЗАРЕГ.заемщика';
COMMENT ON COLUMN BARS.CC_ZAY.DATZ IS 'Дата заявки';
COMMENT ON COLUMN BARS.CC_ZAY.DATU IS 'Дата утверждения';
COMMENT ON COLUMN BARS.CC_ZAY.DATW IS 'Дата выдачи';
COMMENT ON COLUMN BARS.CC_ZAY.OKPO IS 'Код ОКПО заемщика';
COMMENT ON COLUMN BARS.CC_ZAY.SOS IS 'Статус заявки';
COMMENT ON COLUMN BARS.CC_ZAY.KLA IS 'Классификация заявки';
COMMENT ON COLUMN BARS.CC_ZAY.BRANCH IS '';
COMMENT ON COLUMN BARS.CC_ZAY.KF IS '';
COMMENT ON COLUMN BARS.CC_ZAY.FDAT IS 'Системная дата-время ввода';
COMMENT ON COLUMN BARS.CC_ZAY.ID IS 'Исполнитель';
COMMENT ON COLUMN BARS.CC_ZAY.RNK IS 'РНК заемщика';
COMMENT ON COLUMN BARS.CC_ZAY.TEL IS 'Контактные телефоны';
COMMENT ON COLUMN BARS.CC_ZAY.S IS 'Сумма заявки';
COMMENT ON COLUMN BARS.CC_ZAY.KV IS 'Вал заявки';




PROMPT *** Create  constraint PK_CCZAY ***
begin   
 execute immediate '
  ALTER TABLE BARS.CC_ZAY ADD CONSTRAINT PK_CCZAY PRIMARY KEY (ID)
  USING INDEX PCTFREE 10 INITRANS 2 MAXTRANS 255 COMPUTE STATISTICS 
  TABLESPACE BRSMDLI  ENABLE';
exception when others then
  if  sqlcode=-2260 or sqlcode=-2261 or sqlcode=-2264 or sqlcode=-2275 or sqlcode=-1442 then null; else raise; end if;
 end;
/




PROMPT *** Create  constraint FK_CC_ZAY_KLA ***
begin   
 execute immediate '
  ALTER TABLE BARS.CC_ZAY ADD CONSTRAINT FK_CC_ZAY_KLA FOREIGN KEY (KLA)
	  REFERENCES BARS.CC_KLA (ID) ENABLE';
exception when others then
  if  sqlcode=-2260 or sqlcode=-2261 or sqlcode=-2264 or sqlcode=-2275 or sqlcode=-1442 then null; else raise; end if;
 end;
/




PROMPT *** Create  constraint FK_CC_ZAY_KV ***
begin   
 execute immediate '
  ALTER TABLE BARS.CC_ZAY ADD CONSTRAINT FK_CC_ZAY_KV FOREIGN KEY (KV)
	  REFERENCES BARS.TABVAL$GLOBAL (KV) ENABLE';
exception when others then
  if  sqlcode=-2260 or sqlcode=-2261 or sqlcode=-2264 or sqlcode=-2275 or sqlcode=-1442 then null; else raise; end if;
 end;
/




PROMPT *** Create  constraint FK_CC_ZAY_BRANCH ***
begin   
 execute immediate '
  ALTER TABLE BARS.CC_ZAY ADD CONSTRAINT FK_CC_ZAY_BRANCH FOREIGN KEY (BRANCH)
	  REFERENCES BARS.BRANCH (BRANCH) DEFERRABLE ENABLE';
exception when others then
  if  sqlcode=-2260 or sqlcode=-2261 or sqlcode=-2264 or sqlcode=-2275 or sqlcode=-1442 then null; else raise; end if;
 end;
/




PROMPT *** Create  constraint FK_CCZAY_KF ***
begin   
 execute immediate '
  ALTER TABLE BARS.CC_ZAY ADD CONSTRAINT FK_CCZAY_KF FOREIGN KEY (KF)
	  REFERENCES BARS.BANKS$BASE (MFO) ENABLE';
exception when others then
  if  sqlcode=-2260 or sqlcode=-2261 or sqlcode=-2264 or sqlcode=-2275 or sqlcode=-1442 then null; else raise; end if;
 end;
/




PROMPT *** Create  constraint NK_CC_ZAY_ID ***
begin   
 execute immediate '
  ALTER TABLE BARS.CC_ZAY MODIFY (ID CONSTRAINT NK_CC_ZAY_ID NOT NULL ENABLE)';
exception when others then
  if  sqlcode=-2260 or sqlcode=-2261 or sqlcode=-2264 or sqlcode=-2275 or sqlcode=-1442 then null; else raise; end if;
 end;
/




PROMPT *** Create  constraint NK_CC_ZAY_RNK ***
begin   
 execute immediate '
  ALTER TABLE BARS.CC_ZAY MODIFY (RNK CONSTRAINT NK_CC_ZAY_RNK NOT NULL ENABLE)';
exception when others then
  if  sqlcode=-2260 or sqlcode=-2261 or sqlcode=-2264 or sqlcode=-2275 or sqlcode=-1442 then null; else raise; end if;
 end;
/




PROMPT *** Create  constraint CC_CCZAY_KF_NN ***
begin   
 execute immediate '
  ALTER TABLE BARS.CC_ZAY MODIFY (KF CONSTRAINT CC_CCZAY_KF_NN NOT NULL ENABLE)';
exception when others then
  if  sqlcode=-2260 or sqlcode=-2261 or sqlcode=-2264 or sqlcode=-2275 or sqlcode=-1442 then null; else raise; end if;
 end;
/




PROMPT *** Create  constraint CC_CC_ZAY_BRANCH_NN ***
begin   
 execute immediate '
  ALTER TABLE BARS.CC_ZAY MODIFY (BRANCH CONSTRAINT CC_CC_ZAY_BRANCH_NN NOT NULL ENABLE)';
exception when others then
  if  sqlcode=-2260 or sqlcode=-2261 or sqlcode=-2264 or sqlcode=-2275 or sqlcode=-1442 then null; else raise; end if;
 end;
/




PROMPT *** Create  index PK_CCZAY ***
begin   
 execute immediate '
  CREATE UNIQUE INDEX BARS.PK_CCZAY ON BARS.CC_ZAY (ID) 
  PCTFREE 10 INITRANS 2 MAXTRANS 255 COMPUTE STATISTICS 
  TABLESPACE BRSMDLI ';
exception when others then
  if  sqlcode=-955  then null; else raise; end if;
 end;
/



PROMPT *** Create  grants  CC_ZAY ***
grant DELETE,INSERT,SELECT,UPDATE                                            on CC_ZAY          to BARS_ACCESS_DEFROLE;
grant SELECT                                                                 on CC_ZAY          to BARS_DM;
grant DELETE,INSERT,SELECT,UPDATE                                            on CC_ZAY          to RCC_DEAL;
grant DELETE,FLASHBACK,INSERT,SELECT,UPDATE                                  on CC_ZAY          to WR_ALL_RIGHTS;



PROMPT ===================================================================================== 
PROMPT *** End *** ========== Scripts /Sql/BARS/Table/CC_ZAY.sql =========*** End *** ======
PROMPT ===================================================================================== 
