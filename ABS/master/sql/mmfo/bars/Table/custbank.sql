

PROMPT ===================================================================================== 
PROMPT *** Run *** ========== Scripts /Sql/BARS/Table/CUSTBANK.sql =========*** Run *** ====
PROMPT ===================================================================================== 


PROMPT *** ALTER_POLICY_INFO to CUSTBANK ***


BEGIN 
        execute immediate  
          'begin  
               bpa.alter_policy_info(''CUSTBANK'', ''CENTER'' , null, null, null, null);
               bpa.alter_policy_info(''CUSTBANK'', ''FILIAL'' , null, null, null, null);
               bpa.alter_policy_info(''CUSTBANK'', ''WHOLE'' , null, null, null, null);
               null;
           end; 
          '; 
END; 
/

PROMPT *** Create  table CUSTBANK ***
begin 
  execute immediate '
  CREATE TABLE BARS.CUSTBANK 
   (	RNK NUMBER(38,0), 
	MFO VARCHAR2(12), 
	ALT_BIC CHAR(11), 
	BIC CHAR(11), 
	RATING VARCHAR2(5), 
	KOD_B NUMBER(5,0), 
	DAT_ND DATE, 
	RUK VARCHAR2(70), 
	TELR VARCHAR2(20), 
	BUH VARCHAR2(70), 
	TELB VARCHAR2(20), 
	NUM_ND VARCHAR2(20), 
	BKI NUMBER(1,0) DEFAULT 1, 
	K190 VARCHAR2(4)
   ) SEGMENT CREATION IMMEDIATE 
  PCTFREE 10 PCTUSED 40 INITRANS 1 MAXTRANS 255 
 NOCOMPRESS LOGGING
  TABLESPACE BRSMDLD ';
exception when others then       
  if sqlcode=-955 then null; else raise; end if; 
end; 
/


declare
  v_num integer;
begin
  select count(1) into v_num
    from user_tab_columns
    where table_name = 'CUSTBANK'
      and column_name = 'K190';
  if v_num = 0 then
    execute immediate 'alter table custbank add k190 varchar2(4)';
  end if;
end;
/



PROMPT *** ALTER_POLICIES to CUSTBANK ***
 exec bpa.alter_policies('CUSTBANK');


COMMENT ON TABLE BARS.CUSTBANK IS 'Клиенты-банки';
COMMENT ON COLUMN BARS.CUSTBANK.K190 IS 'Рейтинг надійності K190';
COMMENT ON COLUMN BARS.CUSTBANK.DAT_ND IS 'Дата регистрации';
COMMENT ON COLUMN BARS.CUSTBANK.RUK IS 'ФИО руководителя';
COMMENT ON COLUMN BARS.CUSTBANK.TELR IS 'Тел. руководителя';
COMMENT ON COLUMN BARS.CUSTBANK.BUH IS 'ФИО гл. бухгалтера';
COMMENT ON COLUMN BARS.CUSTBANK.TELB IS 'Тел .гл. бухгалтера';
COMMENT ON COLUMN BARS.CUSTBANK.NUM_ND IS 'Номер ген. соглашения';
COMMENT ON COLUMN BARS.CUSTBANK.BKI IS 'Ознака передачі ПВБКІ';
COMMENT ON COLUMN BARS.CUSTBANK.RNK IS 'Идентификатор клиента';
COMMENT ON COLUMN BARS.CUSTBANK.MFO IS 'Код МФО банка';
COMMENT ON COLUMN BARS.CUSTBANK.ALT_BIC IS 'Альтернативный BIC-код';
COMMENT ON COLUMN BARS.CUSTBANK.BIC IS 'BIC-код банка';
COMMENT ON COLUMN BARS.CUSTBANK.RATING IS 'Рейтинг';
COMMENT ON COLUMN BARS.CUSTBANK.KOD_B IS 'Код банка';




PROMPT *** Create  constraint CC_CUSTBANK_RNK_NN ***
begin   
 execute immediate '
  ALTER TABLE BARS.CUSTBANK MODIFY (RNK CONSTRAINT CC_CUSTBANK_RNK_NN NOT NULL ENABLE NOVALIDATE)';
exception when others then
  if  sqlcode=-2260 or sqlcode=-2261 or sqlcode=-2264 or sqlcode=-2275 or sqlcode=-1442 then null; else raise; end if;
 end;
/




PROMPT *** Create  constraint CC_CUSTBANK_BKI_NN ***
begin   
 execute immediate '
  ALTER TABLE BARS.CUSTBANK ADD CONSTRAINT CC_CUSTBANK_BKI_NN CHECK (bki is not null) ENABLE NOVALIDATE';
exception when others then
  if  sqlcode=-2260 or sqlcode=-2261 or sqlcode=-2264 or sqlcode=-2275 or sqlcode=-1442 then null; else raise; end if;
 end;
/




PROMPT *** Create  constraint PK_CUSTBANK ***
begin   
 execute immediate '
  ALTER TABLE BARS.CUSTBANK ADD CONSTRAINT PK_CUSTBANK PRIMARY KEY (RNK)
  USING INDEX PCTFREE 10 INITRANS 2 MAXTRANS 255 COMPUTE STATISTICS 
  TABLESPACE BRSMDLI  ENABLE NOVALIDATE';
exception when others then
  if  sqlcode=-2260 or sqlcode=-2261 or sqlcode=-2264 or sqlcode=-2275 or sqlcode=-1442 then null; else raise; end if;
 end;
/




PROMPT *** Create  constraint CC_CUSTBANK_BKI ***
begin   
 execute immediate '
  ALTER TABLE BARS.CUSTBANK ADD CONSTRAINT CC_CUSTBANK_BKI CHECK (bki in (0,1)) ENABLE NOVALIDATE';
exception when others then
  if  sqlcode=-2260 or sqlcode=-2261 or sqlcode=-2264 or sqlcode=-2275 or sqlcode=-1442 then null; else raise; end if;
 end;
/




PROMPT *** Create  index PK_CUSTBANK ***
begin   
 execute immediate '
  CREATE UNIQUE INDEX BARS.PK_CUSTBANK ON BARS.CUSTBANK (RNK) 
  PCTFREE 10 INITRANS 2 MAXTRANS 255 COMPUTE STATISTICS 
  TABLESPACE BRSMDLI ';
exception when others then
  if  sqlcode=-955  then null; else raise; end if;
 end;
/



PROMPT *** Create  grants  CUSTBANK ***
grant DELETE,INSERT,SELECT,UPDATE                                            on CUSTBANK        to ABS_ADMIN;
grant SELECT                                                                 on CUSTBANK        to BARSREADER_ROLE;
grant SELECT                                                                 on CUSTBANK        to BARSUPL;
grant ALTER,DELETE,FLASHBACK,INSERT,SELECT,UPDATE                            on CUSTBANK        to BARS_ACCESS_DEFROLE;
grant SELECT                                                                 on CUSTBANK        to BARS_DM;
grant ALTER,DELETE,INSERT,SELECT,UPDATE                                      on CUSTBANK        to CUST001;
grant SELECT                                                                 on CUSTBANK        to FOREX;
grant SELECT                                                                 on CUSTBANK        to RPBN002;
grant SELECT                                                                 on CUSTBANK        to START1;
grant SELECT                                                                 on CUSTBANK        to UPLD;
grant DELETE,FLASHBACK,INSERT,SELECT,UPDATE                                  on CUSTBANK        to WR_ALL_RIGHTS;
grant SELECT                                                                 on CUSTBANK        to WR_CUSTLIST;
grant SELECT                                                                 on CUSTBANK        to WR_CUSTREG;
grant FLASHBACK,SELECT                                                       on CUSTBANK        to WR_REFREAD;



PROMPT ===================================================================================== 
PROMPT *** End *** ========== Scripts /Sql/BARS/Table/CUSTBANK.sql =========*** End *** ====
PROMPT ===================================================================================== 
