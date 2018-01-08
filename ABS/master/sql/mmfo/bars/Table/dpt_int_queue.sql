

PROMPT ========================================================================================= 
PROMPT *** Run *** ========== Scripts /Sql/BARS/Table/DPT_INT_QUEUE.sql =========*** Run *** ===
PROMPT ========================================================================================= 


PROMPT *** ALTER_POLICY_INFO to DPT_INT_QUEUE ***


BEGIN 
        execute immediate  
          'begin  
               bpa.alter_policy_info(''DPT_INT_QUEUE'', ''CENTER'' , null, null, null, null);
               bpa.alter_policy_info(''DPT_INT_QUEUE'', ''FILIAL'' , null, null, null, null);
               bpa.alter_policy_info(''DPT_INT_QUEUE'', ''WHOLE'' , null, null, null, null);
               null;
           end; 
          '; 
END; 
/

PROMPT *** Create  table DPT_INT_QUEUE ***
begin 
  execute immediate '
create table DPT_INT_QUEUE
 (ID          number(38), 
  kf          VARCHAR2(12),
  branch      VARCHAR2(30),
  int_id      NUMBER(1),
  acc_id      NUMBER(38),
  acc_num     VARCHAR2(15),
  acc_cur     NUMBER(3),
  acc_nbs     CHAR(4),
  acc_name    VARCHAR2(38),
  acc_iso     CHAR(3),
  acc_open    DATE,
  acc_amount  NUMBER(38),
  int_details VARCHAR2(160),
  int_tt      CHAR(3),
  deal_id     NUMBER(38),
  deal_num    VARCHAR2(35),
  deal_dat    DATE,
  cust_id     NUMBER(38),
  mod_code    CHAR(3),
  ins_time    DATE
  )';
exception when others then       
  if sqlcode=-955 then null; else raise; end if; 
end; 
/




PROMPT *** ALTER_POLICIES to DPT_INT_QUEUE ***
 exec bpa.alter_policies('DPT_INT_QUEUE');


COMMENT ON TABLE BARS.DPT_INT_QUEUE IS 'Накопительная таблица с данными по нач%%';
COMMENT ON COLUMN BARS.DPT_INT_QUEUE.KF IS 'МФО';
COMMENT ON COLUMN BARS.DPT_INT_QUEUE.BRANCH IS 'Код подразделения счета';
COMMENT ON COLUMN BARS.DPT_INT_QUEUE.INT_ID IS 'Код процентной карточки';
COMMENT ON COLUMN BARS.DPT_INT_QUEUE.ACC_ID IS 'Внутр.номер счета';
COMMENT ON COLUMN BARS.DPT_INT_QUEUE.ACC_NUM IS 'Номер счета';
COMMENT ON COLUMN BARS.DPT_INT_QUEUE.ACC_CUR IS 'Код валюты счета';
COMMENT ON COLUMN BARS.DPT_INT_QUEUE.ACC_NBS IS 'Бал.счет';
COMMENT ON COLUMN BARS.DPT_INT_QUEUE.ACC_NAME IS 'Наименование счета';
COMMENT ON COLUMN BARS.DPT_INT_QUEUE.ACC_ISO IS 'Код валюты ISO';
COMMENT ON COLUMN BARS.DPT_INT_QUEUE.ACC_OPEN IS 'Дата открытия счета';
COMMENT ON COLUMN BARS.DPT_INT_QUEUE.ACC_AMOUNT IS 'Остаток для начисления';
COMMENT ON COLUMN BARS.DPT_INT_QUEUE.INT_DETAILS IS 'Назначение платежа';
COMMENT ON COLUMN BARS.DPT_INT_QUEUE.INT_TT IS 'Код операции';
COMMENT ON COLUMN BARS.DPT_INT_QUEUE.DEAL_ID IS 'Идентификатор договора';
COMMENT ON COLUMN BARS.DPT_INT_QUEUE.DEAL_NUM IS 'Номер договора';
COMMENT ON COLUMN BARS.DPT_INT_QUEUE.DEAL_DAT IS 'Дата договора';
COMMENT ON COLUMN BARS.DPT_INT_QUEUE.CUST_ID IS 'Рег.№ клиента';
COMMENT ON COLUMN BARS.DPT_INT_QUEUE.MOD_CODE IS 'Код модуля';




PROMPT *** Create  constraint PK_DPTINTQUEUE ***
begin   
 execute immediate '
  ALTER TABLE BARS.DPT_INT_QUEUE ADD CONSTRAINT PK_DPTINTQUEUE PRIMARY KEY (ID, ACC_ID, INT_ID) ENABLE';
exception when others then
  if  sqlcode=-2260 or sqlcode=-2261 or sqlcode=-2264 or sqlcode=-2275 or sqlcode=-1442 then null; else raise; end if;
 end;
/

PROMPT *** Create  index PK_DPTINTQUEUE ***
begin   
 execute immediate '
  CREATE UNIQUE INDEX BARS.PK_DPTINTQUEUE ON BARS.DPT_INT_QUEUE (ID, ACC_ID, INT_ID) ';
exception when others then
  if  sqlcode=-955  then null; else raise; end if;
 end;
/



PROMPT *** Create  grants  DPT_INT_QUEUE ***
grant INSERT,SELECT                                                          on DPT_INT_QUEUE       to BARS_ACCESS_DEFROLE;
grant SELECT                                                                 on DPT_INT_QUEUE       to BARS_DM;
grant DELETE,FLASHBACK,INSERT,SELECT,UPDATE                                  on DPT_INT_QUEUE       to WR_ALL_RIGHTS;




PROMPT =========================================================================================
PROMPT *** End *** ========== Scripts /Sql/BARS/Table/DPT_INT_QUEUE.sql =========*** End *** ===
PROMPT ========================================================================================= 
