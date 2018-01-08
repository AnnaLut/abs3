

PROMPT ===================================================================================== 
PROMPT *** Run *** ========== Scripts /Sql/BARS/Table/KL_CUSTOMER_PARAMS.sql =========*** Ru
PROMPT ===================================================================================== 


PROMPT *** ALTER_POLICY_INFO to KL_CUSTOMER_PARAMS ***


BEGIN 
        execute immediate  
          'begin  
               bpa.alter_policy_info(''KL_CUSTOMER_PARAMS'', ''CENTER'' , null, null, null, null);
               bpa.alter_policy_info(''KL_CUSTOMER_PARAMS'', ''FILIAL'' , null, null, null, null);
               bpa.alter_policy_info(''KL_CUSTOMER_PARAMS'', ''WHOLE'' , null, null, null, null);
               null;
           end; 
          '; 
END; 
/

PROMPT *** Create  table KL_CUSTOMER_PARAMS ***
begin 
  execute immediate '
  CREATE TABLE BARS.KL_CUSTOMER_PARAMS 
   (	RNK NUMBER, 
	BLK NUMBER(1,0), 
	EMAIL VARCHAR2(100), 
	MAKE_VP NUMBER(1,0), 
	POST_TYPE VARCHAR2(1), 
	ALT_POST NUMBER(1,0) DEFAULT 0, 
	ALT_EMAIL VARCHAR2(100), 
	TECH_KEY VARCHAR2(10), 
	FILESAB VARCHAR2(10), 
	ISACTIVE NUMBER(*,0), 
	LAST_BNKDAY DATE, 
	LAST_FILENUM NUMBER DEFAULT 0
   ) SEGMENT CREATION IMMEDIATE 
  PCTFREE 10 PCTUSED 40 INITRANS 1 MAXTRANS 255 
 NOCOMPRESS LOGGING
  TABLESPACE BRSDYND ';
exception when others then       
  if sqlcode=-955 then null; else raise; end if; 
end; 
/




PROMPT *** ALTER_POLICIES to KL_CUSTOMER_PARAMS ***
 exec bpa.alter_policies('KL_CUSTOMER_PARAMS');


COMMENT ON TABLE BARS.KL_CUSTOMER_PARAMS IS 'Параметры клиент-банковского клиента';
COMMENT ON COLUMN BARS.KL_CUSTOMER_PARAMS.RNK IS '';
COMMENT ON COLUMN BARS.KL_CUSTOMER_PARAMS.BLK IS '';
COMMENT ON COLUMN BARS.KL_CUSTOMER_PARAMS.EMAIL IS '';
COMMENT ON COLUMN BARS.KL_CUSTOMER_PARAMS.MAKE_VP IS '';
COMMENT ON COLUMN BARS.KL_CUSTOMER_PARAMS.POST_TYPE IS 'Тип обмена сообщениями (F - offline, M - почта)';
COMMENT ON COLUMN BARS.KL_CUSTOMER_PARAMS.ALT_POST IS 'Отправлять ли по альтернативному адрессу 0-нет, 1-да';
COMMENT ON COLUMN BARS.KL_CUSTOMER_PARAMS.ALT_EMAIL IS 'Альтернативный email';
COMMENT ON COLUMN BARS.KL_CUSTOMER_PARAMS.TECH_KEY IS 'Саб для имени файла';
COMMENT ON COLUMN BARS.KL_CUSTOMER_PARAMS.FILESAB IS '';
COMMENT ON COLUMN BARS.KL_CUSTOMER_PARAMS.ISACTIVE IS 'Активность ТВБВ';
COMMENT ON COLUMN BARS.KL_CUSTOMER_PARAMS.LAST_BNKDAY IS 'Последняя банковская дата когда формировали файл на ТВБВ';
COMMENT ON COLUMN BARS.KL_CUSTOMER_PARAMS.LAST_FILENUM IS 'Последний номер файла за последнюю банковскую длятьу для данного ТВБВ';




PROMPT *** Create  constraint UK_CUSTOMER_PARAMS_RNK ***
begin   
 execute immediate '
  ALTER TABLE BARS.KL_CUSTOMER_PARAMS ADD CONSTRAINT UK_CUSTOMER_PARAMS_RNK UNIQUE (RNK)
  USING INDEX PCTFREE 10 INITRANS 2 MAXTRANS 255 COMPUTE STATISTICS 
  TABLESPACE BRSDYNI  ENABLE';
exception when others then
  if  sqlcode=-2260 or sqlcode=-2261 or sqlcode=-2264 or sqlcode=-2275 or sqlcode=-1442 then null; else raise; end if;
 end;
/




PROMPT *** Create  constraint FK_CUSTOMER_PARAMS_RNK ***
begin   
 execute immediate '
  ALTER TABLE BARS.KL_CUSTOMER_PARAMS ADD CONSTRAINT FK_CUSTOMER_PARAMS_RNK FOREIGN KEY (RNK)
	  REFERENCES BARS.CUSTOMER (RNK) ENABLE';
exception when others then
  if  sqlcode=-2260 or sqlcode=-2261 or sqlcode=-2264 or sqlcode=-2275 or sqlcode=-1442 then null; else raise; end if;
 end;
/




PROMPT *** Create  constraint CC_KLCUSTOMER_POSTTYPE ***
begin   
 execute immediate '
  ALTER TABLE BARS.KL_CUSTOMER_PARAMS MODIFY (POST_TYPE CONSTRAINT CC_KLCUSTOMER_POSTTYPE NOT NULL ENABLE)';
exception when others then
  if  sqlcode=-2260 or sqlcode=-2261 or sqlcode=-2264 or sqlcode=-2275 or sqlcode=-1442 then null; else raise; end if;
 end;
/




PROMPT *** Create  constraint CC_KLCUSTOMER_TECHKEY ***
begin   
 execute immediate '
  ALTER TABLE BARS.KL_CUSTOMER_PARAMS MODIFY (TECH_KEY CONSTRAINT CC_KLCUSTOMER_TECHKEY NOT NULL ENABLE)';
exception when others then
  if  sqlcode=-2260 or sqlcode=-2261 or sqlcode=-2264 or sqlcode=-2275 or sqlcode=-1442 then null; else raise; end if;
 end;
/




PROMPT *** Create  constraint CC_KLCUSTOMER_FILESAB ***
begin   
 execute immediate '
  ALTER TABLE BARS.KL_CUSTOMER_PARAMS MODIFY (FILESAB CONSTRAINT CC_KLCUSTOMER_FILESAB NOT NULL ENABLE)';
exception when others then
  if  sqlcode=-2260 or sqlcode=-2261 or sqlcode=-2264 or sqlcode=-2275 or sqlcode=-1442 then null; else raise; end if;
 end;
/




PROMPT *** Create  index UK_CUSTOMER_PARAMS_RNK ***
begin   
 execute immediate '
  CREATE UNIQUE INDEX BARS.UK_CUSTOMER_PARAMS_RNK ON BARS.KL_CUSTOMER_PARAMS (RNK) 
  PCTFREE 10 INITRANS 2 MAXTRANS 255 COMPUTE STATISTICS 
  TABLESPACE BRSDYNI ';
exception when others then
  if  sqlcode=-955  then null; else raise; end if;
 end;
/



PROMPT *** Create  grants  KL_CUSTOMER_PARAMS ***
grant DELETE,INSERT,SELECT,UPDATE                                            on KL_CUSTOMER_PARAMS to ABS_ADMIN;
grant SELECT                                                                 on KL_CUSTOMER_PARAMS to BARSAQ;
grant DELETE,FLASHBACK,INSERT,SELECT,UPDATE                                  on KL_CUSTOMER_PARAMS to BARS_ACCESS_DEFROLE;
grant SELECT                                                                 on KL_CUSTOMER_PARAMS to BARS_DM;
grant DELETE,INSERT,SELECT,UPDATE                                            on KL_CUSTOMER_PARAMS to KLBX;
grant DELETE,FLASHBACK,INSERT,SELECT,UPDATE                                  on KL_CUSTOMER_PARAMS to WR_ALL_RIGHTS;
grant FLASHBACK,SELECT                                                       on KL_CUSTOMER_PARAMS to WR_REFREAD;



PROMPT *** Create SYNONYM  to KL_CUSTOMER_PARAMS ***

  CREATE OR REPLACE PUBLIC SYNONYM KL_CUSTOMER_PARAMS FOR BARS.KL_CUSTOMER_PARAMS;


PROMPT ===================================================================================== 
PROMPT *** End *** ========== Scripts /Sql/BARS/Table/KL_CUSTOMER_PARAMS.sql =========*** En
PROMPT ===================================================================================== 
