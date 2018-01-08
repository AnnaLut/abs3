

PROMPT ===================================================================================== 
PROMPT *** Run *** ========== Scripts /Sql/BARS/Table/ZAY_COMISS.sql =========*** Run *** ==
PROMPT ===================================================================================== 


PROMPT *** ALTER_POLICY_INFO to ZAY_COMISS ***


BEGIN 
        execute immediate  
          'begin  
               bpa.alter_policy_info(''ZAY_COMISS'', ''CENTER'' , null, ''E'', ''E'', ''E'');
               bpa.alter_policy_info(''ZAY_COMISS'', ''FILIAL'' , ''M'', ''M'', ''M'', ''M'');
               bpa.alter_policy_info(''ZAY_COMISS'', ''WHOLE'' , null, ''E'', ''E'', ''E'');
               null;
           end; 
          '; 
END; 
/

PROMPT *** Create  table ZAY_COMISS ***
begin 
  execute immediate '
  CREATE TABLE BARS.ZAY_COMISS 
   (	ID NUMBER, 
	RNK NUMBER, 
	DK NUMBER, 
	KV_GRP NUMBER, 
	KV NUMBER, 
	LIMIT NUMBER, 
	RATE NUMBER, 
	FIX_SUM NUMBER DEFAULT 0, 
	DATE_ON DATE, 
	DATE_OFF DATE, 
	KF VARCHAR2(6) DEFAULT sys_context(''bars_context'',''user_mfo'')
   ) SEGMENT CREATION IMMEDIATE 
  PCTFREE 10 PCTUSED 0 INITRANS 1 MAXTRANS 255 
 NOCOMPRESS LOGGING
  TABLESPACE BRSSMLD ';
exception when others then       
  if sqlcode=-955 then null; else raise; end if; 
end; 
/




PROMPT *** ALTER_POLICIES to ZAY_COMISS ***
 exec bpa.alter_policies('ZAY_COMISS');


COMMENT ON TABLE BARS.ZAY_COMISS IS 'Справочник индивид.тарифов на покупку-продажу валюты';
COMMENT ON COLUMN BARS.ZAY_COMISS.ID IS 'Идентификатор';
COMMENT ON COLUMN BARS.ZAY_COMISS.RNK IS 'РНК';
COMMENT ON COLUMN BARS.ZAY_COMISS.DK IS '1-покупка, 2-продажа';
COMMENT ON COLUMN BARS.ZAY_COMISS.KV_GRP IS 'Категория валюты';
COMMENT ON COLUMN BARS.ZAY_COMISS.KV IS 'Валюта';
COMMENT ON COLUMN BARS.ZAY_COMISS.LIMIT IS 'Гран.сумма';
COMMENT ON COLUMN BARS.ZAY_COMISS.RATE IS 'Процент комиссии';
COMMENT ON COLUMN BARS.ZAY_COMISS.FIX_SUM IS 'Фикс.сумма комиссии';
COMMENT ON COLUMN BARS.ZAY_COMISS.DATE_ON IS 'Дата начала действия тарифа';
COMMENT ON COLUMN BARS.ZAY_COMISS.DATE_OFF IS 'Дата окончания действия тарифа';
COMMENT ON COLUMN BARS.ZAY_COMISS.KF IS '';




PROMPT *** Create  constraint CHK_ZAY_COMISS_DK ***
begin   
 execute immediate '
  ALTER TABLE BARS.ZAY_COMISS ADD CONSTRAINT CHK_ZAY_COMISS_DK CHECK (DK IN (1, 2)) ENABLE';
exception when others then
  if  sqlcode=-2260 or sqlcode=-2261 or sqlcode=-2264 or sqlcode=-2275 or sqlcode=-1442 then null; else raise; end if;
 end;
/




PROMPT *** Create  constraint PK_ZAYCOMISS ***
begin   
 execute immediate '
  ALTER TABLE BARS.ZAY_COMISS ADD CONSTRAINT PK_ZAYCOMISS PRIMARY KEY (ID)
  USING INDEX PCTFREE 10 INITRANS 2 MAXTRANS 255 COMPUTE STATISTICS 
  TABLESPACE BRSSMLI  ENABLE';
exception when others then
  if  sqlcode=-2260 or sqlcode=-2261 or sqlcode=-2264 or sqlcode=-2275 or sqlcode=-1442 then null; else raise; end if;
 end;
/




PROMPT *** Create  constraint CC_ZAYCOMISS_DK ***
begin   
 execute immediate '
  ALTER TABLE BARS.ZAY_COMISS ADD CONSTRAINT CC_ZAYCOMISS_DK CHECK (dk in (1, 2)) ENABLE';
exception when others then
  if  sqlcode=-2260 or sqlcode=-2261 or sqlcode=-2264 or sqlcode=-2275 or sqlcode=-1442 then null; else raise; end if;
 end;
/




PROMPT *** Create  constraint CC_ZAY_COMISS_ID_NN ***
begin   
 execute immediate '
  ALTER TABLE BARS.ZAY_COMISS MODIFY (ID CONSTRAINT CC_ZAY_COMISS_ID_NN NOT NULL ENABLE)';
exception when others then
  if  sqlcode=-2260 or sqlcode=-2261 or sqlcode=-2264 or sqlcode=-2275 or sqlcode=-1442 then null; else raise; end if;
 end;
/




PROMPT *** Create  constraint CC_ZAY_COMISS_DK_NN ***
begin   
 execute immediate '
  ALTER TABLE BARS.ZAY_COMISS MODIFY (DK CONSTRAINT CC_ZAY_COMISS_DK_NN NOT NULL ENABLE)';
exception when others then
  if  sqlcode=-2260 or sqlcode=-2261 or sqlcode=-2264 or sqlcode=-2275 or sqlcode=-1442 then null; else raise; end if;
 end;
/




PROMPT *** Create  constraint NK_ZAY_COMISS_ON ***
begin   
 execute immediate '
  ALTER TABLE BARS.ZAY_COMISS MODIFY (DATE_ON CONSTRAINT NK_ZAY_COMISS_ON NOT NULL ENABLE)';
exception when others then
  if  sqlcode=-2260 or sqlcode=-2261 or sqlcode=-2264 or sqlcode=-2275 or sqlcode=-1442 then null; else raise; end if;
 end;
/




PROMPT *** Create  constraint CC_ZAYCOMISS_KF_NN ***
begin   
 execute immediate '
  ALTER TABLE BARS.ZAY_COMISS MODIFY (KF CONSTRAINT CC_ZAYCOMISS_KF_NN NOT NULL ENABLE)';
exception when others then
  if  sqlcode=-2260 or sqlcode=-2261 or sqlcode=-2264 or sqlcode=-2275 or sqlcode=-1442 then null; else raise; end if;
 end;
/




PROMPT *** Create  index PK_ZAYCOMISS ***
begin   
 execute immediate '
  CREATE UNIQUE INDEX BARS.PK_ZAYCOMISS ON BARS.ZAY_COMISS (ID) 
  PCTFREE 10 INITRANS 2 MAXTRANS 255 COMPUTE STATISTICS 
  TABLESPACE BRSSMLI ';
exception when others then
  if  sqlcode=-955  then null; else raise; end if;
 end;
/



PROMPT *** Create  grants  ZAY_COMISS ***
grant FLASHBACK,SELECT                                                       on ZAY_COMISS      to BARSAQ;
grant SELECT                                                                 on ZAY_COMISS      to BARSREADER_ROLE;
grant DELETE,FLASHBACK,INSERT,SELECT,UPDATE                                  on ZAY_COMISS      to BARS_ACCESS_DEFROLE;
grant SELECT                                                                 on ZAY_COMISS      to BARS_DM;
grant SELECT                                                                 on ZAY_COMISS      to UPLD;
grant DELETE,FLASHBACK,INSERT,SELECT,UPDATE                                  on ZAY_COMISS      to WR_ALL_RIGHTS;
grant FLASHBACK,SELECT                                                       on ZAY_COMISS      to WR_REFREAD;
grant DELETE,INSERT,SELECT,UPDATE                                            on ZAY_COMISS      to ZAY;



PROMPT *** Create SYNONYM  to ZAY_COMISS ***

  CREATE OR REPLACE PUBLIC SYNONYM ZAY_COMISS FOR BARS.ZAY_COMISS;


PROMPT ===================================================================================== 
PROMPT *** End *** ========== Scripts /Sql/BARS/Table/ZAY_COMISS.sql =========*** End *** ==
PROMPT ===================================================================================== 
