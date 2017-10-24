

PROMPT ===================================================================================== 
PROMPT *** Run *** ========== Scripts /Sql/BARS/Table/DPU_AGREEMENTS.sql =========*** Run **
PROMPT ===================================================================================== 


PROMPT *** ALTER_POLICY_INFO to DPU_AGREEMENTS ***


BEGIN 
        execute immediate  
          'begin  
               bpa.alter_policy_info(''DPU_AGREEMENTS'', ''CENTER'' , null, ''E'', ''E'', ''E'');
               bpa.alter_policy_info(''DPU_AGREEMENTS'', ''FILIAL'' , ''M'', ''M'', ''M'', ''M'');
               bpa.alter_policy_info(''DPU_AGREEMENTS'', ''WHOLE'' , null, ''E'', ''E'', ''E'');
               null;
           end; 
          '; 
END; 
/

PROMPT *** Create  table DPU_AGREEMENTS ***
begin 
  execute immediate '
  CREATE TABLE BARS.DPU_AGREEMENTS 
   (	KF VARCHAR2(6) DEFAULT sys_context(''bars_context'',''user_mfo''), 
	AGRMNT_ID NUMBER(38,0), 
	AGRMNT_TYPE NUMBER(3,0), 
	AGRMNT_NUM VARCHAR2(35), 
	AGRMNT_BDATE DATE, 
	AGRMNT_CRDATE DATE DEFAULT sysdate, 
	AGRMNT_CRUSER NUMBER(38,0), 
	AGRMNT_PRCDATE DATE, 
	AGRMNT_PRCUSER NUMBER(38,0), 
	AGRMNT_STATE NUMBER(1,0), 
	DPU_ID NUMBER(38,0), 
	DUE_DATE DATE, 
	UNDO_ID NUMBER(38,0), 
	AMOUNT NUMBER(38,0), 
	RATE NUMBER(5,3), 
	FREQ NUMBER(3,0), 
	BEGIN_DATE DATE, 
	END_DATE DATE, 
	STOP_ID NUMBER(10,0), 
	PAYMENT_DETAILS VARCHAR2(1000), 
	COMMENTS VARCHAR2(500)
   ) SEGMENT CREATION IMMEDIATE 
  PCTFREE 10 PCTUSED 40 INITRANS 1 MAXTRANS 255 
 NOCOMPRESS LOGGING
  TABLESPACE BRSSMLD ';
exception when others then       
  if sqlcode=-955 then null; else raise; end if; 
end; 
/




PROMPT *** ALTER_POLICIES to DPU_AGREEMENTS ***
 exec bpa.alter_policies('DPU_AGREEMENTS');


COMMENT ON TABLE BARS.DPU_AGREEMENTS IS 'Додаткові угоди заключені до депозитних договорів ЮО';
COMMENT ON COLUMN BARS.DPU_AGREEMENTS.KF IS '';
COMMENT ON COLUMN BARS.DPU_AGREEMENTS.AGRMNT_ID IS 'Ід. ДУ';
COMMENT ON COLUMN BARS.DPU_AGREEMENTS.AGRMNT_TYPE IS 'Ідентифікатор типу додаткової угоди';
COMMENT ON COLUMN BARS.DPU_AGREEMENTS.AGRMNT_NUM IS 'Номер ДУ';
COMMENT ON COLUMN BARS.DPU_AGREEMENTS.AGRMNT_BDATE IS 'Банківська дата створення (заключення) ДУ';
COMMENT ON COLUMN BARS.DPU_AGREEMENTS.AGRMNT_CRDATE IS 'Дата створення ДУ';
COMMENT ON COLUMN BARS.DPU_AGREEMENTS.AGRMNT_CRUSER IS 'Ідентифікатор користувача, що створив ДУ';
COMMENT ON COLUMN BARS.DPU_AGREEMENTS.AGRMNT_PRCDATE IS 'Дата погодження ДУ';
COMMENT ON COLUMN BARS.DPU_AGREEMENTS.AGRMNT_PRCUSER IS 'Ідентифікатор користувача, що погодив ДУ';
COMMENT ON COLUMN BARS.DPU_AGREEMENTS.AGRMNT_STATE IS 'Статус ДУ ( 0 - dummy / 1 - active / -1 - refused / -2 - revoked )';
COMMENT ON COLUMN BARS.DPU_AGREEMENTS.DPU_ID IS 'Ід. депозитного договору';
COMMENT ON COLUMN BARS.DPU_AGREEMENTS.DUE_DATE IS 'Дата виконання (дата початку дії ДУ)';
COMMENT ON COLUMN BARS.DPU_AGREEMENTS.UNDO_ID IS 'Ід. ДУ що анулювала дану';
COMMENT ON COLUMN BARS.DPU_AGREEMENTS.AMOUNT IS 'Сума';
COMMENT ON COLUMN BARS.DPU_AGREEMENTS.RATE IS 'Відсоткова ставка';
COMMENT ON COLUMN BARS.DPU_AGREEMENTS.FREQ IS 'Періодичність виплати відсотків';
COMMENT ON COLUMN BARS.DPU_AGREEMENTS.BEGIN_DATE IS 'Дата почтку';
COMMENT ON COLUMN BARS.DPU_AGREEMENTS.END_DATE IS 'Дата закінчення';
COMMENT ON COLUMN BARS.DPU_AGREEMENTS.STOP_ID IS 'Код штрафу';
COMMENT ON COLUMN BARS.DPU_AGREEMENTS.PAYMENT_DETAILS IS 'Платіжні реквізити повернення депозиту';
COMMENT ON COLUMN BARS.DPU_AGREEMENTS.COMMENTS IS 'Коментар до запиту';




PROMPT *** Create  constraint CC_DPUAGRMNTS_KF_NN ***
begin   
 execute immediate '
  ALTER TABLE BARS.DPU_AGREEMENTS MODIFY (KF CONSTRAINT CC_DPUAGRMNTS_KF_NN NOT NULL ENABLE)';
exception when others then
  if  sqlcode=-2260 or sqlcode=-2261 or sqlcode=-2264 or sqlcode=-2275 or sqlcode=-1442 then null; else raise; end if;
 end;
/




PROMPT *** Create  constraint CC_DPUAGRMNTS_AGRMNTID_NN ***
begin   
 execute immediate '
  ALTER TABLE BARS.DPU_AGREEMENTS MODIFY (AGRMNT_ID CONSTRAINT CC_DPUAGRMNTS_AGRMNTID_NN NOT NULL ENABLE)';
exception when others then
  if  sqlcode=-2260 or sqlcode=-2261 or sqlcode=-2264 or sqlcode=-2275 or sqlcode=-1442 then null; else raise; end if;
 end;
/




PROMPT *** Create  constraint FK_DPUAGRMNTS_CRUSER ***
begin   
 execute immediate '
  ALTER TABLE BARS.DPU_AGREEMENTS ADD CONSTRAINT FK_DPUAGRMNTS_CRUSER FOREIGN KEY (AGRMNT_CRUSER)
	  REFERENCES BARS.STAFF$BASE (ID) ENABLE NOVALIDATE';
exception when others then
  if  sqlcode=-2260 or sqlcode=-2261 or sqlcode=-2264 or sqlcode=-2275 or sqlcode=-1442 then null; else raise; end if;
 end;
/




PROMPT *** Create  constraint FK_DPUAGRMNTS_KF ***
begin   
 execute immediate '
  ALTER TABLE BARS.DPU_AGREEMENTS ADD CONSTRAINT FK_DPUAGRMNTS_KF FOREIGN KEY (KF)
	  REFERENCES BARS.BANKS$BASE (MFO) ENABLE NOVALIDATE';
exception when others then
  if  sqlcode=-2260 or sqlcode=-2261 or sqlcode=-2264 or sqlcode=-2275 or sqlcode=-1442 then null; else raise; end if;
 end;
/




PROMPT *** Create  constraint FK_DPUAGRMNTS_STOPID ***
begin   
 execute immediate '
  ALTER TABLE BARS.DPU_AGREEMENTS ADD CONSTRAINT FK_DPUAGRMNTS_STOPID FOREIGN KEY (STOP_ID)
	  REFERENCES BARS.DPT_STOP (ID) ENABLE NOVALIDATE';
exception when others then
  if  sqlcode=-2260 or sqlcode=-2261 or sqlcode=-2264 or sqlcode=-2275 or sqlcode=-1442 then null; else raise; end if;
 end;
/




PROMPT *** Create  constraint FK_DPUAGRMNTS_DPUDEAL ***
begin   
 execute immediate '
  ALTER TABLE BARS.DPU_AGREEMENTS ADD CONSTRAINT FK_DPUAGRMNTS_DPUDEAL FOREIGN KEY (DPU_ID)
	  REFERENCES BARS.DPU_DEAL (DPU_ID) ENABLE NOVALIDATE';
exception when others then
  if  sqlcode=-2260 or sqlcode=-2261 or sqlcode=-2264 or sqlcode=-2275 or sqlcode=-1442 then null; else raise; end if;
 end;
/




PROMPT *** Create  constraint FK_DPUAGRMNTS_DPUAGRMNTTYPES ***
begin   
 execute immediate '
  ALTER TABLE BARS.DPU_AGREEMENTS ADD CONSTRAINT FK_DPUAGRMNTS_DPUAGRMNTTYPES FOREIGN KEY (AGRMNT_TYPE)
	  REFERENCES BARS.DPU_AGREEMENT_TYPES (ID) ENABLE NOVALIDATE';
exception when others then
  if  sqlcode=-2260 or sqlcode=-2261 or sqlcode=-2264 or sqlcode=-2275 or sqlcode=-1442 then null; else raise; end if;
 end;
/




PROMPT *** Create  constraint CC_DPUAGRMNTS_COMMENTS ***
begin   
 execute immediate '
  ALTER TABLE BARS.DPU_AGREEMENTS ADD CONSTRAINT CC_DPUAGRMNTS_COMMENTS CHECK ( AGRMNT_STATE = -1 and COMMENTS is Not Null or AGRMNT_STATE != -1 ) ENABLE';
exception when others then
  if  sqlcode=-2260 or sqlcode=-2261 or sqlcode=-2264 or sqlcode=-2275 or sqlcode=-1442 then null; else raise; end if;
 end;
/




PROMPT *** Create  constraint CC_DPUAGRMNTS_AGRMNTSTATE ***
begin   
 execute immediate '
  ALTER TABLE BARS.DPU_AGREEMENTS ADD CONSTRAINT CC_DPUAGRMNTS_AGRMNTSTATE CHECK ( AGRMNT_STATE in ( -2, -1, 0, 1 ) ) ENABLE';
exception when others then
  if  sqlcode=-2260 or sqlcode=-2261 or sqlcode=-2264 or sqlcode=-2275 or sqlcode=-1442 then null; else raise; end if;
 end;
/




PROMPT *** Create  constraint UK_DPUAGRMNTS_DPTID_AGRMNTNUM ***
begin   
 execute immediate '
  ALTER TABLE BARS.DPU_AGREEMENTS ADD CONSTRAINT UK_DPUAGRMNTS_DPTID_AGRMNTNUM UNIQUE (DPU_ID, AGRMNT_NUM)
  USING INDEX PCTFREE 10 INITRANS 2 MAXTRANS 255 COMPUTE STATISTICS 
  TABLESPACE BRSMDLI  ENABLE';
exception when others then
  if  sqlcode=-2260 or sqlcode=-2261 or sqlcode=-2264 or sqlcode=-2275 or sqlcode=-1442 then null; else raise; end if;
 end;
/




PROMPT *** Create  constraint PK_DPUAGRMNTS ***
begin   
 execute immediate '
  ALTER TABLE BARS.DPU_AGREEMENTS ADD CONSTRAINT PK_DPUAGRMNTS PRIMARY KEY (AGRMNT_ID)
  USING INDEX PCTFREE 10 INITRANS 2 MAXTRANS 255 COMPUTE STATISTICS 
  TABLESPACE BRSMDLI  ENABLE';
exception when others then
  if  sqlcode=-2260 or sqlcode=-2261 or sqlcode=-2264 or sqlcode=-2275 or sqlcode=-1442 then null; else raise; end if;
 end;
/




PROMPT *** Create  constraint FK_DPUAGRMNTS_UNDOID ***
begin   
 execute immediate '
  ALTER TABLE BARS.DPU_AGREEMENTS ADD CONSTRAINT FK_DPUAGRMNTS_UNDOID FOREIGN KEY (UNDO_ID)
	  REFERENCES BARS.DPU_AGREEMENTS (AGRMNT_ID) ENABLE';
exception when others then
  if  sqlcode=-2260 or sqlcode=-2261 or sqlcode=-2264 or sqlcode=-2275 or sqlcode=-1442 then null; else raise; end if;
 end;
/




PROMPT *** Create  constraint FK_DPUAGRMNTS_FREQ ***
begin   
 execute immediate '
  ALTER TABLE BARS.DPU_AGREEMENTS ADD CONSTRAINT FK_DPUAGRMNTS_FREQ FOREIGN KEY (FREQ)
	  REFERENCES BARS.FREQ (FREQ) ENABLE';
exception when others then
  if  sqlcode=-2260 or sqlcode=-2261 or sqlcode=-2264 or sqlcode=-2275 or sqlcode=-1442 then null; else raise; end if;
 end;
/




PROMPT *** Create  constraint FK_DPUAGRMNTS_PRCUSER ***
begin   
 execute immediate '
  ALTER TABLE BARS.DPU_AGREEMENTS ADD CONSTRAINT FK_DPUAGRMNTS_PRCUSER FOREIGN KEY (AGRMNT_PRCUSER)
	  REFERENCES BARS.STAFF$BASE (ID) ENABLE';
exception when others then
  if  sqlcode=-2260 or sqlcode=-2261 or sqlcode=-2264 or sqlcode=-2275 or sqlcode=-1442 then null; else raise; end if;
 end;
/




PROMPT *** Create  constraint CC_DPUAGRMNTS_DUEDATE_NN ***
begin   
 execute immediate '
  ALTER TABLE BARS.DPU_AGREEMENTS MODIFY (DUE_DATE CONSTRAINT CC_DPUAGRMNTS_DUEDATE_NN NOT NULL ENABLE)';
exception when others then
  if  sqlcode=-2260 or sqlcode=-2261 or sqlcode=-2264 or sqlcode=-2275 or sqlcode=-1442 then null; else raise; end if;
 end;
/




PROMPT *** Create  constraint CC_DPUAGRMNTS_DPTID_NN ***
begin   
 execute immediate '
  ALTER TABLE BARS.DPU_AGREEMENTS MODIFY (DPU_ID CONSTRAINT CC_DPUAGRMNTS_DPTID_NN NOT NULL ENABLE)';
exception when others then
  if  sqlcode=-2260 or sqlcode=-2261 or sqlcode=-2264 or sqlcode=-2275 or sqlcode=-1442 then null; else raise; end if;
 end;
/




PROMPT *** Create  constraint CC_DPUAGRMNTS_AGRMNTCRUSER_NN ***
begin   
 execute immediate '
  ALTER TABLE BARS.DPU_AGREEMENTS MODIFY (AGRMNT_CRDATE CONSTRAINT CC_DPUAGRMNTS_AGRMNTCRUSER_NN NOT NULL ENABLE)';
exception when others then
  if  sqlcode=-2260 or sqlcode=-2261 or sqlcode=-2264 or sqlcode=-2275 or sqlcode=-1442 then null; else raise; end if;
 end;
/




PROMPT *** Create  constraint CC_DPUAGRMNTS_AGRMNTTYPE_NN ***
begin   
 execute immediate '
  ALTER TABLE BARS.DPU_AGREEMENTS MODIFY (AGRMNT_TYPE CONSTRAINT CC_DPUAGRMNTS_AGRMNTTYPE_NN NOT NULL ENABLE)';
exception when others then
  if  sqlcode=-2260 or sqlcode=-2261 or sqlcode=-2264 or sqlcode=-2275 or sqlcode=-1442 then null; else raise; end if;
 end;
/




PROMPT *** Create  constraint CC_DPUAGRMNTS_AGRMNTNUM_NN ***
begin   
 execute immediate '
  ALTER TABLE BARS.DPU_AGREEMENTS MODIFY (AGRMNT_NUM CONSTRAINT CC_DPUAGRMNTS_AGRMNTNUM_NN NOT NULL ENABLE)';
exception when others then
  if  sqlcode=-2260 or sqlcode=-2261 or sqlcode=-2264 or sqlcode=-2275 or sqlcode=-1442 then null; else raise; end if;
 end;
/




PROMPT *** Create  constraint CC_DPUAGRMNTS_AGRMNTBDATE_NN ***
begin   
 execute immediate '
  ALTER TABLE BARS.DPU_AGREEMENTS MODIFY (AGRMNT_BDATE CONSTRAINT CC_DPUAGRMNTS_AGRMNTBDATE_NN NOT NULL ENABLE)';
exception when others then
  if  sqlcode=-2260 or sqlcode=-2261 or sqlcode=-2264 or sqlcode=-2275 or sqlcode=-1442 then null; else raise; end if;
 end;
/




PROMPT *** Create  index PK_DPUAGRMNTS ***
begin   
 execute immediate '
  CREATE UNIQUE INDEX BARS.PK_DPUAGRMNTS ON BARS.DPU_AGREEMENTS (AGRMNT_ID) 
  PCTFREE 10 INITRANS 2 MAXTRANS 255 COMPUTE STATISTICS 
  TABLESPACE BRSMDLI ';
exception when others then
  if  sqlcode=-955  then null; else raise; end if;
 end;
/




PROMPT *** Create  index IDX_DPUAGRMNTS_DPUID ***
begin   
 execute immediate '
  CREATE INDEX BARS.IDX_DPUAGRMNTS_DPUID ON BARS.DPU_AGREEMENTS (DPU_ID) 
  PCTFREE 10 INITRANS 2 MAXTRANS 255 COMPUTE STATISTICS 
  TABLESPACE BRSMDLI ';
exception when others then
  if  sqlcode=-955  then null; else raise; end if;
 end;
/




PROMPT *** Create  index UK_DPUAGRMNTS_DPTID_AGRMNTNUM ***
begin   
 execute immediate '
  CREATE UNIQUE INDEX BARS.UK_DPUAGRMNTS_DPTID_AGRMNTNUM ON BARS.DPU_AGREEMENTS (DPU_ID, AGRMNT_NUM) 
  PCTFREE 10 INITRANS 2 MAXTRANS 255 COMPUTE STATISTICS 
  TABLESPACE BRSMDLI ';
exception when others then
  if  sqlcode=-955  then null; else raise; end if;
 end;
/



PROMPT *** Create  grants  DPU_AGREEMENTS ***
grant SELECT                                                                 on DPU_AGREEMENTS  to BARSUPL;
grant DELETE,INSERT,SELECT,UPDATE                                            on DPU_AGREEMENTS  to BARS_ACCESS_DEFROLE;
grant SELECT                                                                 on DPU_AGREEMENTS  to BARS_DM;
grant DELETE,INSERT,SELECT,UPDATE                                            on DPU_AGREEMENTS  to DPT_ROLE;
grant SELECT                                                                 on DPU_AGREEMENTS  to START1;



PROMPT ===================================================================================== 
PROMPT *** End *** ========== Scripts /Sql/BARS/Table/DPU_AGREEMENTS.sql =========*** End **
PROMPT ===================================================================================== 
