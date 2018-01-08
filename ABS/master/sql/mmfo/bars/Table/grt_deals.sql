

PROMPT ===================================================================================== 
PROMPT *** Run *** ========== Scripts /Sql/BARS/Table/GRT_DEALS.sql =========*** Run *** ===
PROMPT ===================================================================================== 


PROMPT *** ALTER_POLICY_INFO to GRT_DEALS ***


BEGIN 
        execute immediate  
          'begin  
               bpa.alter_policy_info(''GRT_DEALS'', ''CENTER'' , null, null, null, null);
               bpa.alter_policy_info(''GRT_DEALS'', ''FILIAL'' , null, null, null, null);
               bpa.alter_policy_info(''GRT_DEALS'', ''WHOLE'' , null, null, null, null);
               null;
           end; 
          '; 
END; 
/

PROMPT *** Create  table GRT_DEALS ***
begin 
  execute immediate '
  CREATE TABLE BARS.GRT_DEALS 
   (	DEAL_ID NUMBER(38,0), 
	GRT_TYPE_ID NUMBER(10,0), 
	GRT_PLACE_ID NUMBER(4,0), 
	DEAL_RNK NUMBER(38,0), 
	DEAL_NUM VARCHAR2(24), 
	DEAL_DATE DATE, 
	DEAL_NAME VARCHAR2(128), 
	DEAL_PLACE VARCHAR2(128), 
	GRT_NAME VARCHAR2(4000), 
	GRT_COMMENT VARCHAR2(4000), 
	GRT_BUY_DOGNUM VARCHAR2(24), 
	GRT_BUY_DOGDATE DATE, 
	GRT_UNIT NUMBER(3,0), 
	GRT_CNT NUMBER(38,0), 
	GRT_SUM NUMBER(38,0), 
	GRT_SUM_CURCODE NUMBER(3,0), 
	CHK_DATE_AVAIL DATE, 
	CHK_DATE_STATUS DATE, 
	REVALUE_DATE DATE, 
	CHK_SUM NUMBER(38,0), 
	ACC NUMBER(38,0), 
	WARN_DAYS NUMBER(3,0), 
	STAFF_ID NUMBER(38,0), 
	BRANCH VARCHAR2(30), 
	CHK_FREQ NUMBER(3,0), 
	CALC_SUM NUMBER(38,0), 
	STATUS_ID NUMBER(3,0) DEFAULT 0, 
	STATUS_DATE DATE DEFAULT sysdate, 
	GRT_SUBJ_ID NUMBER(38,0)
   ) SEGMENT CREATION DEFERRED 
  PCTFREE 10 PCTUSED 40 INITRANS 1 MAXTRANS 255 
 NOCOMPRESS LOGGING
  TABLESPACE BRSDYND ';
exception when others then       
  if sqlcode=-955 then null; else raise; end if; 
end; 
/




PROMPT *** ALTER_POLICIES to GRT_DEALS ***
 exec bpa.alter_policies('GRT_DEALS');


COMMENT ON TABLE BARS.GRT_DEALS IS 'Таблица договоров обеспечения';
COMMENT ON COLUMN BARS.GRT_DEALS.DEAL_ID IS 'Идетнификатор договора обеспечения';
COMMENT ON COLUMN BARS.GRT_DEALS.GRT_TYPE_ID IS 'Тип обеспечения';
COMMENT ON COLUMN BARS.GRT_DEALS.GRT_PLACE_ID IS 'Рамещение обеспечения';
COMMENT ON COLUMN BARS.GRT_DEALS.DEAL_RNK IS 'Регистрационный номер залогодателя';
COMMENT ON COLUMN BARS.GRT_DEALS.DEAL_NUM IS 'Номер договора обеспечения';
COMMENT ON COLUMN BARS.GRT_DEALS.DEAL_DATE IS 'Дата договора обеспечения';
COMMENT ON COLUMN BARS.GRT_DEALS.DEAL_NAME IS 'Название договора обеспечения';
COMMENT ON COLUMN BARS.GRT_DEALS.DEAL_PLACE IS 'Место заключения договора обеспечения';
COMMENT ON COLUMN BARS.GRT_DEALS.GRT_NAME IS 'Полное название заложенного имущества';
COMMENT ON COLUMN BARS.GRT_DEALS.GRT_COMMENT IS 'Описание заложенного имущества';
COMMENT ON COLUMN BARS.GRT_DEALS.GRT_BUY_DOGNUM IS 'Номер догоовра купли/продажи заложенного имущества';
COMMENT ON COLUMN BARS.GRT_DEALS.GRT_BUY_DOGDATE IS 'Дата догоовра купли/продажи заложенного имущества';
COMMENT ON COLUMN BARS.GRT_DEALS.GRT_UNIT IS 'Еденица измерения заложенного имущества';
COMMENT ON COLUMN BARS.GRT_DEALS.GRT_CNT IS 'Количество едениц заложенного имущества';
COMMENT ON COLUMN BARS.GRT_DEALS.GRT_SUM IS 'Начальная стоимость заложенного имущества';
COMMENT ON COLUMN BARS.GRT_DEALS.GRT_SUM_CURCODE IS 'Валюта';
COMMENT ON COLUMN BARS.GRT_DEALS.CHK_DATE_AVAIL IS 'Дата проверки наличия залога';
COMMENT ON COLUMN BARS.GRT_DEALS.CHK_DATE_STATUS IS 'Дата проверки состояния залога';
COMMENT ON COLUMN BARS.GRT_DEALS.REVALUE_DATE IS 'Дата переоценки залога';
COMMENT ON COLUMN BARS.GRT_DEALS.CHK_SUM IS 'Оценочная стоимость залога (в валюте grt_sum_curcode)';
COMMENT ON COLUMN BARS.GRT_DEALS.ACC IS '';
COMMENT ON COLUMN BARS.GRT_DEALS.WARN_DAYS IS 'Кол-во дней, за которые нужно оповещать о наступлении события в графике';
COMMENT ON COLUMN BARS.GRT_DEALS.STAFF_ID IS 'Идентификатор пользователя, добавившего запись';
COMMENT ON COLUMN BARS.GRT_DEALS.BRANCH IS 'Идентификатор подразделения';
COMMENT ON COLUMN BARS.GRT_DEALS.CHK_FREQ IS 'Періодичність перевірки';
COMMENT ON COLUMN BARS.GRT_DEALS.CALC_SUM IS 'Розрахункова сума';
COMMENT ON COLUMN BARS.GRT_DEALS.STATUS_ID IS 'id статусу договора';
COMMENT ON COLUMN BARS.GRT_DEALS.STATUS_DATE IS 'Дата зміни статусу договору';
COMMENT ON COLUMN BARS.GRT_DEALS.GRT_SUBJ_ID IS 'Id предмету забезпечення';




PROMPT *** Create  constraint PK_GRTDEALS ***
begin   
 execute immediate '
  ALTER TABLE BARS.GRT_DEALS ADD CONSTRAINT PK_GRTDEALS PRIMARY KEY (DEAL_ID)
  USING INDEX PCTFREE 10 INITRANS 2 MAXTRANS 255 COMPUTE STATISTICS 
  TABLESPACE BRSDYND  ENABLE';
exception when others then
  if  sqlcode=-2260 or sqlcode=-2261 or sqlcode=-2264 or sqlcode=-2275 or sqlcode=-1442 then null; else raise; end if;
 end;
/




PROMPT *** Create  constraint FK_GRTDEALS_GRTTYPES ***
begin   
 execute immediate '
  ALTER TABLE BARS.GRT_DEALS ADD CONSTRAINT FK_GRTDEALS_GRTTYPES FOREIGN KEY (GRT_TYPE_ID)
	  REFERENCES BARS.GRT_TYPES (TYPE_ID) ENABLE';
exception when others then
  if  sqlcode=-2260 or sqlcode=-2261 or sqlcode=-2264 or sqlcode=-2275 or sqlcode=-1442 then null; else raise; end if;
 end;
/




PROMPT *** Create  constraint CC_GRTDEALS_STATUSDATE_NN ***
begin   
 execute immediate '
  ALTER TABLE BARS.GRT_DEALS MODIFY (STATUS_DATE CONSTRAINT CC_GRTDEALS_STATUSDATE_NN NOT NULL ENABLE)';
exception when others then
  if  sqlcode=-2260 or sqlcode=-2261 or sqlcode=-2264 or sqlcode=-2275 or sqlcode=-1442 then null; else raise; end if;
 end;
/




PROMPT *** Create  constraint CC_GRTDEALS_STATUSID_NN ***
begin   
 execute immediate '
  ALTER TABLE BARS.GRT_DEALS MODIFY (STATUS_ID CONSTRAINT CC_GRTDEALS_STATUSID_NN NOT NULL ENABLE)';
exception when others then
  if  sqlcode=-2260 or sqlcode=-2261 or sqlcode=-2264 or sqlcode=-2275 or sqlcode=-1442 then null; else raise; end if;
 end;
/




PROMPT *** Create  constraint CC_GRTDEALS_BRANCH_NN ***
begin   
 execute immediate '
  ALTER TABLE BARS.GRT_DEALS MODIFY (BRANCH CONSTRAINT CC_GRTDEALS_BRANCH_NN NOT NULL ENABLE)';
exception when others then
  if  sqlcode=-2260 or sqlcode=-2261 or sqlcode=-2264 or sqlcode=-2275 or sqlcode=-1442 then null; else raise; end if;
 end;
/




PROMPT *** Create  constraint CC_GRTDEALS_STAFFID_NN ***
begin   
 execute immediate '
  ALTER TABLE BARS.GRT_DEALS MODIFY (STAFF_ID CONSTRAINT CC_GRTDEALS_STAFFID_NN NOT NULL ENABLE)';
exception when others then
  if  sqlcode=-2260 or sqlcode=-2261 or sqlcode=-2264 or sqlcode=-2275 or sqlcode=-1442 then null; else raise; end if;
 end;
/




PROMPT *** Create  constraint CC_GRTDEALS_GRTCURCODE_NN ***
begin   
 execute immediate '
  ALTER TABLE BARS.GRT_DEALS MODIFY (GRT_SUM_CURCODE CONSTRAINT CC_GRTDEALS_GRTCURCODE_NN NOT NULL ENABLE)';
exception when others then
  if  sqlcode=-2260 or sqlcode=-2261 or sqlcode=-2264 or sqlcode=-2275 or sqlcode=-1442 then null; else raise; end if;
 end;
/




PROMPT *** Create  constraint CC_GRTDEALS_GRTINITSUM_NN ***
begin   
 execute immediate '
  ALTER TABLE BARS.GRT_DEALS MODIFY (GRT_SUM CONSTRAINT CC_GRTDEALS_GRTINITSUM_NN NOT NULL ENABLE)';
exception when others then
  if  sqlcode=-2260 or sqlcode=-2261 or sqlcode=-2264 or sqlcode=-2275 or sqlcode=-1442 then null; else raise; end if;
 end;
/




PROMPT *** Create  constraint CC_GRTDEALS_GRTCNT_NN ***
begin   
 execute immediate '
  ALTER TABLE BARS.GRT_DEALS MODIFY (GRT_CNT CONSTRAINT CC_GRTDEALS_GRTCNT_NN NOT NULL ENABLE)';
exception when others then
  if  sqlcode=-2260 or sqlcode=-2261 or sqlcode=-2264 or sqlcode=-2275 or sqlcode=-1442 then null; else raise; end if;
 end;
/




PROMPT *** Create  constraint CC_GRTDEALS_DEALDATE_NN ***
begin   
 execute immediate '
  ALTER TABLE BARS.GRT_DEALS MODIFY (DEAL_DATE CONSTRAINT CC_GRTDEALS_DEALDATE_NN NOT NULL ENABLE)';
exception when others then
  if  sqlcode=-2260 or sqlcode=-2261 or sqlcode=-2264 or sqlcode=-2275 or sqlcode=-1442 then null; else raise; end if;
 end;
/




PROMPT *** Create  constraint CC_GRTDEALS_DEALRNK_NN ***
begin   
 execute immediate '
  ALTER TABLE BARS.GRT_DEALS MODIFY (DEAL_RNK CONSTRAINT CC_GRTDEALS_DEALRNK_NN NOT NULL ENABLE)';
exception when others then
  if  sqlcode=-2260 or sqlcode=-2261 or sqlcode=-2264 or sqlcode=-2275 or sqlcode=-1442 then null; else raise; end if;
 end;
/




PROMPT *** Create  constraint CC_GRTDEALS_GRTPLACEID_NN ***
begin   
 execute immediate '
  ALTER TABLE BARS.GRT_DEALS MODIFY (GRT_PLACE_ID CONSTRAINT CC_GRTDEALS_GRTPLACEID_NN NOT NULL ENABLE)';
exception when others then
  if  sqlcode=-2260 or sqlcode=-2261 or sqlcode=-2264 or sqlcode=-2275 or sqlcode=-1442 then null; else raise; end if;
 end;
/




PROMPT *** Create  constraint FK_GRTDEALS_GRTPLACES ***
begin   
 execute immediate '
  ALTER TABLE BARS.GRT_DEALS ADD CONSTRAINT FK_GRTDEALS_GRTPLACES FOREIGN KEY (GRT_PLACE_ID)
	  REFERENCES BARS.GRT_PLACES (PLACE_ID) ENABLE';
exception when others then
  if  sqlcode=-2260 or sqlcode=-2261 or sqlcode=-2264 or sqlcode=-2275 or sqlcode=-1442 then null; else raise; end if;
 end;
/




PROMPT *** Create  constraint FK_GRTDEALS_CUSTOMER ***
begin   
 execute immediate '
  ALTER TABLE BARS.GRT_DEALS ADD CONSTRAINT FK_GRTDEALS_CUSTOMER FOREIGN KEY (DEAL_RNK)
	  REFERENCES BARS.CUSTOMER (RNK) ENABLE';
exception when others then
  if  sqlcode=-2260 or sqlcode=-2261 or sqlcode=-2264 or sqlcode=-2275 or sqlcode=-1442 then null; else raise; end if;
 end;
/




PROMPT *** Create  constraint FK_GRTDEALS_GRTUNITS ***
begin   
 execute immediate '
  ALTER TABLE BARS.GRT_DEALS ADD CONSTRAINT FK_GRTDEALS_GRTUNITS FOREIGN KEY (GRT_UNIT)
	  REFERENCES BARS.GRT_UNITS (UNIT_ID) ENABLE';
exception when others then
  if  sqlcode=-2260 or sqlcode=-2261 or sqlcode=-2264 or sqlcode=-2275 or sqlcode=-1442 then null; else raise; end if;
 end;
/




PROMPT *** Create  constraint FK_GRTDEALS_STAFF ***
begin   
 execute immediate '
  ALTER TABLE BARS.GRT_DEALS ADD CONSTRAINT FK_GRTDEALS_STAFF FOREIGN KEY (STAFF_ID)
	  REFERENCES BARS.STAFF$BASE (ID) ENABLE';
exception when others then
  if  sqlcode=-2260 or sqlcode=-2261 or sqlcode=-2264 or sqlcode=-2275 or sqlcode=-1442 then null; else raise; end if;
 end;
/




PROMPT *** Create  constraint FK_GRTDEALS_BRANCH ***
begin   
 execute immediate '
  ALTER TABLE BARS.GRT_DEALS ADD CONSTRAINT FK_GRTDEALS_BRANCH FOREIGN KEY (BRANCH)
	  REFERENCES BARS.BRANCH (BRANCH) ENABLE';
exception when others then
  if  sqlcode=-2260 or sqlcode=-2261 or sqlcode=-2264 or sqlcode=-2275 or sqlcode=-1442 then null; else raise; end if;
 end;
/




PROMPT *** Create  constraint FK_GRTDEALS_TABVAL ***
begin   
 execute immediate '
  ALTER TABLE BARS.GRT_DEALS ADD CONSTRAINT FK_GRTDEALS_TABVAL FOREIGN KEY (GRT_SUM_CURCODE)
	  REFERENCES BARS.TABVAL$GLOBAL (KV) ENABLE';
exception when others then
  if  sqlcode=-2260 or sqlcode=-2261 or sqlcode=-2264 or sqlcode=-2275 or sqlcode=-1442 then null; else raise; end if;
 end;
/




PROMPT *** Create  constraint FK_GRTDEALS_FREQ ***
begin   
 execute immediate '
  ALTER TABLE BARS.GRT_DEALS ADD CONSTRAINT FK_GRTDEALS_FREQ FOREIGN KEY (CHK_FREQ)
	  REFERENCES BARS.FREQ (FREQ) ENABLE';
exception when others then
  if  sqlcode=-2260 or sqlcode=-2261 or sqlcode=-2264 or sqlcode=-2275 or sqlcode=-1442 then null; else raise; end if;
 end;
/




PROMPT *** Create  constraint FK_GRTDEALS_GRTDEALSTATUSES ***
begin   
 execute immediate '
  ALTER TABLE BARS.GRT_DEALS ADD CONSTRAINT FK_GRTDEALS_GRTDEALSTATUSES FOREIGN KEY (STATUS_ID)
	  REFERENCES BARS.GRT_DEAL_STATUSES (STATUS_ID) ENABLE';
exception when others then
  if  sqlcode=-2260 or sqlcode=-2261 or sqlcode=-2264 or sqlcode=-2275 or sqlcode=-1442 then null; else raise; end if;
 end;
/




PROMPT *** Create  constraint FK_GRTDEALS_GRTSUBJECTS ***
begin   
 execute immediate '
  ALTER TABLE BARS.GRT_DEALS ADD CONSTRAINT FK_GRTDEALS_GRTSUBJECTS FOREIGN KEY (GRT_SUBJ_ID)
	  REFERENCES BARS.GRT_SUBJECTS (SUBJ_ID) ENABLE';
exception when others then
  if  sqlcode=-2260 or sqlcode=-2261 or sqlcode=-2264 or sqlcode=-2275 or sqlcode=-1442 then null; else raise; end if;
 end;
/




PROMPT *** Create  constraint CC_GRTDEALS_GRTTYPEID_NN ***
begin   
 execute immediate '
  ALTER TABLE BARS.GRT_DEALS MODIFY (GRT_TYPE_ID CONSTRAINT CC_GRTDEALS_GRTTYPEID_NN NOT NULL ENABLE)';
exception when others then
  if  sqlcode=-2260 or sqlcode=-2261 or sqlcode=-2264 or sqlcode=-2275 or sqlcode=-1442 then null; else raise; end if;
 end;
/




PROMPT *** Create  index PK_GRTDEALS ***
begin   
 execute immediate '
  CREATE UNIQUE INDEX BARS.PK_GRTDEALS ON BARS.GRT_DEALS (DEAL_ID) 
  PCTFREE 10 INITRANS 2 MAXTRANS 255 COMPUTE STATISTICS 
  TABLESPACE BRSDYND ';
exception when others then
  if  sqlcode=-955  then null; else raise; end if;
 end;
/




PROMPT *** Create  index IDX_GRTDEALS_DEAL ***
begin   
 execute immediate '
  CREATE UNIQUE INDEX BARS.IDX_GRTDEALS_DEAL ON BARS.GRT_DEALS (DEAL_RNK, DEAL_NUM, DEAL_DATE) 
  PCTFREE 10 INITRANS 2 MAXTRANS 255 COMPUTE STATISTICS 
  TABLESPACE BRSSMLI ';
exception when others then
  if  sqlcode=-955  then null; else raise; end if;
 end;
/



PROMPT *** Create  grants  GRT_DEALS ***
grant SELECT                                                                 on GRT_DEALS       to BARSUPL;
grant DELETE,INSERT,SELECT,UPDATE                                            on GRT_DEALS       to BARS_ACCESS_DEFROLE;
grant SELECT                                                                 on GRT_DEALS       to BARS_DM;
grant DELETE,INSERT,SELECT,UPDATE                                            on GRT_DEALS       to START1;



PROMPT ===================================================================================== 
PROMPT *** End *** ========== Scripts /Sql/BARS/Table/GRT_DEALS.sql =========*** End *** ===
PROMPT ===================================================================================== 
