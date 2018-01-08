

PROMPT ===================================================================================== 
PROMPT *** Run *** ========== Scripts /Sql/BARS/Table/DILER_KURS.sql =========*** Run *** ==
PROMPT ===================================================================================== 


PROMPT *** ALTER_POLICY_INFO to DILER_KURS ***


BEGIN 
        execute immediate  
          'begin  
               bpa.alter_policy_info(''DILER_KURS'', ''CENTER'' , null, null, null, null);
               bpa.alter_policy_info(''DILER_KURS'', ''FILIAL'' , null, null, null, null);
               bpa.alter_policy_info(''DILER_KURS'', ''WHOLE'' , null, null, null, null);
               null;
           end; 
          '; 
END; 
/

PROMPT *** Create  table DILER_KURS ***
begin 
  execute immediate '
  CREATE TABLE BARS.DILER_KURS 
   (	DAT DATE, 
	KV NUMBER, 
	ID NUMBER, 
	KURS_B NUMBER(35,8), 
	KURS_S NUMBER(35,8), 
	VIP_B NUMBER(35,8), 
	VIP_S NUMBER(35,8), 
	BLK NUMBER DEFAULT 0, 
	CODE NUMBER
   ) SEGMENT CREATION IMMEDIATE 
  PCTFREE 10 PCTUSED 0 INITRANS 1 MAXTRANS 255 
 NOCOMPRESS LOGGING
  TABLESPACE BRSMDLD ';
exception when others then       
  if sqlcode=-955 then null; else raise; end if; 
end; 
/




PROMPT *** ALTER_POLICIES to DILER_KURS ***
 exec bpa.alter_policies('DILER_KURS');


COMMENT ON TABLE BARS.DILER_KURS IS 'Предварит.курсы покупки/продажи валют';
COMMENT ON COLUMN BARS.DILER_KURS.DAT IS 'Дата установки';
COMMENT ON COLUMN BARS.DILER_KURS.KV IS 'Код валюты';
COMMENT ON COLUMN BARS.DILER_KURS.ID IS 'Код исполнителя';
COMMENT ON COLUMN BARS.DILER_KURS.KURS_B IS 'Курс покупки';
COMMENT ON COLUMN BARS.DILER_KURS.KURS_S IS 'Курс продажи';
COMMENT ON COLUMN BARS.DILER_KURS.VIP_B IS 'Курс покупки для vip-клиентов';
COMMENT ON COLUMN BARS.DILER_KURS.VIP_S IS 'Курс продажи для vip-клиентов';
COMMENT ON COLUMN BARS.DILER_KURS.BLK IS 'Признак блокировки ввода заявок по данной валюте';
COMMENT ON COLUMN BARS.DILER_KURS.CODE IS 'Идентификатор';




PROMPT *** Create  constraint CC_DILERKURS_BLK ***
begin   
 execute immediate '
  ALTER TABLE BARS.DILER_KURS ADD CONSTRAINT CC_DILERKURS_BLK CHECK (blk in (0, 1)) ENABLE';
exception when others then
  if  sqlcode=-2260 or sqlcode=-2261 or sqlcode=-2264 or sqlcode=-2275 or sqlcode=-1442 then null; else raise; end if;
 end;
/




PROMPT *** Create  constraint XPK_DILER_KURS ***
begin   
 execute immediate '
  ALTER TABLE BARS.DILER_KURS ADD CONSTRAINT XPK_DILER_KURS PRIMARY KEY (CODE)
  USING INDEX PCTFREE 10 INITRANS 2 MAXTRANS 255 COMPUTE STATISTICS 
  TABLESPACE BRSMDLI  ENABLE';
exception when others then
  if  sqlcode=-2260 or sqlcode=-2261 or sqlcode=-2264 or sqlcode=-2275 or sqlcode=-1442 then null; else raise; end if;
 end;
/




PROMPT *** Create  index XPK_DILER_KURS ***
begin   
 execute immediate '
  CREATE UNIQUE INDEX BARS.XPK_DILER_KURS ON BARS.DILER_KURS (CODE) 
  PCTFREE 10 INITRANS 2 MAXTRANS 255 COMPUTE STATISTICS 
  TABLESPACE BRSMDLI ';
exception when others then
  if  sqlcode=-955  then null; else raise; end if;
 end;
/




PROMPT *** Create  index XIE_DILER_KURS_KV_DAT ***
begin   
 execute immediate '
  CREATE UNIQUE INDEX BARS.XIE_DILER_KURS_KV_DAT ON BARS.DILER_KURS (KV, DAT) 
  PCTFREE 10 INITRANS 2 MAXTRANS 255 COMPUTE STATISTICS COMPRESS 1 
  TABLESPACE BRSMDLI ';
exception when others then
  if  sqlcode=-955  then null; else raise; end if;
 end;
/



PROMPT *** Create  grants  DILER_KURS ***
grant SELECT                                                                 on DILER_KURS      to BARSREADER_ROLE;
grant ALTER,DELETE,INSERT,SELECT,UPDATE                                      on DILER_KURS      to BARS_ACCESS_DEFROLE;
grant SELECT                                                                 on DILER_KURS      to BARS_DM;
grant SELECT                                                                 on DILER_KURS      to TECH_MOM1;
grant SELECT                                                                 on DILER_KURS      to UPLD;
grant DELETE,FLASHBACK,INSERT,SELECT,UPDATE                                  on DILER_KURS      to WR_ALL_RIGHTS;
grant ALTER,DELETE,INSERT,SELECT,UPDATE                                      on DILER_KURS      to ZAY;



PROMPT *** Create SYNONYM  to DILER_KURS ***

  CREATE OR REPLACE PUBLIC SYNONYM DILER_KURS FOR BARS.DILER_KURS;


PROMPT ===================================================================================== 
PROMPT *** End *** ========== Scripts /Sql/BARS/Table/DILER_KURS.sql =========*** End *** ==
PROMPT ===================================================================================== 
