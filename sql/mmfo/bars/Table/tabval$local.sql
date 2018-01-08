

PROMPT ===================================================================================== 
PROMPT *** Run *** ========== Scripts /Sql/BARS/Table/TABVAL$LOCAL.sql =========*** Run *** 
PROMPT ===================================================================================== 


PROMPT *** ALTER_POLICY_INFO to TABVAL$LOCAL ***


BEGIN 
        execute immediate  
          'begin  
               bpa.alter_policy_info(''TABVAL$LOCAL'', ''CENTER'' , null, null, null, null);
               bpa.alter_policy_info(''TABVAL$LOCAL'', ''FILIAL'' , ''M'', ''M'', ''M'', ''M'');
               bpa.alter_policy_info(''TABVAL$LOCAL'', ''WHOLE'' , null, null, null, null);
               null;
           end; 
          '; 
END; 
/

PROMPT *** Create  table TABVAL$LOCAL ***
begin 
  execute immediate '
  CREATE TABLE BARS.TABVAL$LOCAL 
   (	KV NUMBER(3,0), 
	SKV NUMBER(5,0), 
	S0000 VARCHAR2(15), 
	S3800 VARCHAR2(15), 
	S3801 NUMBER(*,0), 
	S3802 VARCHAR2(15), 
	S6201 VARCHAR2(15), 
	S7201 VARCHAR2(15), 
	S9282 VARCHAR2(15), 
	S9280 VARCHAR2(15), 
	S9281 VARCHAR2(15), 
	S0009 VARCHAR2(15), 
	G0000 VARCHAR2(15), 
	KF VARCHAR2(6) DEFAULT sys_context(''bars_context'',''user_mfo'')
   ) SEGMENT CREATION IMMEDIATE 
  PCTFREE 10 PCTUSED 40 INITRANS 1 MAXTRANS 255 
 NOCOMPRESS LOGGING
  TABLESPACE BRSSMLD ';
exception when others then       
  if sqlcode=-955 then null; else raise; end if; 
end; 
/




PROMPT *** ALTER_POLICIES to TABVAL$LOCAL ***
 exec bpa.alter_policies('TABVAL$LOCAL');


COMMENT ON TABLE BARS.TABVAL$LOCAL IS 'Справочник валют(локальная часть)';
COMMENT ON COLUMN BARS.TABVAL$LOCAL.KV IS '';
COMMENT ON COLUMN BARS.TABVAL$LOCAL.SKV IS 'Порядок сортировки';
COMMENT ON COLUMN BARS.TABVAL$LOCAL.S0000 IS 'Сч.техн. переоц(1-7 кл) Вешалка';
COMMENT ON COLUMN BARS.TABVAL$LOCAL.S3800 IS 'Счет ВАЛ.ПОЗ';
COMMENT ON COLUMN BARS.TABVAL$LOCAL.S3801 IS 'Счет ЭКВ.ВАЛ.ПОЗ';
COMMENT ON COLUMN BARS.TABVAL$LOCAL.S3802 IS 'Переоценка ВАЛ.ПОЗ (НКР).';
COMMENT ON COLUMN BARS.TABVAL$LOCAL.S6201 IS 'Счет доходов';
COMMENT ON COLUMN BARS.TABVAL$LOCAL.S7201 IS 'Счет расходов';
COMMENT ON COLUMN BARS.TABVAL$LOCAL.S9282 IS 'Переоценка  Внеб. ВАЛ.ПОЗ (НКР).';
COMMENT ON COLUMN BARS.TABVAL$LOCAL.S9280 IS '';
COMMENT ON COLUMN BARS.TABVAL$LOCAL.S9281 IS 'Счет Внеб. ЭКВ.ВАЛ.ПОЗ';
COMMENT ON COLUMN BARS.TABVAL$LOCAL.S0009 IS 'Сч.техн. переоц(9 кл) Вешалка';
COMMENT ON COLUMN BARS.TABVAL$LOCAL.G0000 IS '';
COMMENT ON COLUMN BARS.TABVAL$LOCAL.KF IS '';




PROMPT *** Create  constraint PK_TABVAL$LOCAL ***
begin   
 execute immediate '
  ALTER TABLE BARS.TABVAL$LOCAL ADD CONSTRAINT PK_TABVAL$LOCAL PRIMARY KEY (KF, KV)
  USING INDEX PCTFREE 10 INITRANS 2 MAXTRANS 255 COMPUTE STATISTICS 
  TABLESPACE BRSSMLI  ENABLE';
exception when others then
  if  sqlcode=-2260 or sqlcode=-2261 or sqlcode=-2264 or sqlcode=-2275 or sqlcode=-1442 then null; else raise; end if;
 end;
/




PROMPT *** Create  constraint FK_TABVAL$LOCAL_KF ***
begin   
 execute immediate '
  ALTER TABLE BARS.TABVAL$LOCAL ADD CONSTRAINT FK_TABVAL$LOCAL_KF FOREIGN KEY (KF)
	  REFERENCES BARS.BANKS$BASE (MFO) ENABLE';
exception when others then
  if  sqlcode=-2260 or sqlcode=-2261 or sqlcode=-2264 or sqlcode=-2275 or sqlcode=-1442 then null; else raise; end if;
 end;
/




PROMPT *** Create  constraint FK_TABVAL$LOCAL_TABVAL$GLOBAL ***
begin   
 execute immediate '
  ALTER TABLE BARS.TABVAL$LOCAL ADD CONSTRAINT FK_TABVAL$LOCAL_TABVAL$GLOBAL FOREIGN KEY (KV)
	  REFERENCES BARS.TABVAL$GLOBAL (KV) ENABLE';
exception when others then
  if  sqlcode=-2260 or sqlcode=-2261 or sqlcode=-2264 or sqlcode=-2275 or sqlcode=-1442 then null; else raise; end if;
 end;
/




PROMPT *** Create  constraint CC_TABVAL$LOCAL_KV_NN ***
begin   
 execute immediate '
  ALTER TABLE BARS.TABVAL$LOCAL MODIFY (KV CONSTRAINT CC_TABVAL$LOCAL_KV_NN NOT NULL ENABLE)';
exception when others then
  if  sqlcode=-2260 or sqlcode=-2261 or sqlcode=-2264 or sqlcode=-2275 or sqlcode=-1442 then null; else raise; end if;
 end;
/




PROMPT *** Create  constraint CC_TABVAL$LOCAL_KF_NN ***
begin   
 execute immediate '
  ALTER TABLE BARS.TABVAL$LOCAL MODIFY (KF CONSTRAINT CC_TABVAL$LOCAL_KF_NN NOT NULL ENABLE)';
exception when others then
  if  sqlcode=-2260 or sqlcode=-2261 or sqlcode=-2264 or sqlcode=-2275 or sqlcode=-1442 then null; else raise; end if;
 end;
/




PROMPT *** Create  index PK_TABVAL$LOCAL ***
begin   
 execute immediate '
  CREATE UNIQUE INDEX BARS.PK_TABVAL$LOCAL ON BARS.TABVAL$LOCAL (KF, KV) 
  PCTFREE 10 INITRANS 2 MAXTRANS 255 COMPUTE STATISTICS 
  TABLESPACE BRSSMLI ';
exception when others then
  if  sqlcode=-955  then null; else raise; end if;
 end;
/



PROMPT *** Create  grants  TABVAL$LOCAL ***
grant SELECT                                                                 on TABVAL$LOCAL    to BARS_DM;
grant SELECT                                                                 on TABVAL$LOCAL    to SWTOSS;
grant DELETE,FLASHBACK,INSERT,SELECT,UPDATE                                  on TABVAL$LOCAL    to WR_ALL_RIGHTS;



PROMPT ===================================================================================== 
PROMPT *** End *** ========== Scripts /Sql/BARS/Table/TABVAL$LOCAL.sql =========*** End *** 
PROMPT ===================================================================================== 
