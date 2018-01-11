

PROMPT ===================================================================================== 
PROMPT *** Run *** ========== Scripts /Sql/BARS/Table/CP_RATES_UPDATE.sql =========*** Run *
PROMPT ===================================================================================== 


PROMPT *** ALTER_POLICY_INFO to CP_RATES_UPDATE ***


BEGIN 
        execute immediate  
          'begin  
               bpa.alter_policy_info(''CP_RATES_UPDATE'', ''CENTER'' , null, null, null, null);
               bpa.alter_policy_info(''CP_RATES_UPDATE'', ''FILIAL'' , null, null, null, null);
               bpa.alter_policy_info(''CP_RATES_UPDATE'', ''WHOLE'' , null, null, null, null);
               null;
           end; 
          '; 
END; 
/

PROMPT *** Create  table CP_RATES_UPDATE ***
begin 
  execute immediate '
  CREATE TABLE BARS.CP_RATES_UPDATE 
   (	ID NUMBER, 
	VDATE DATE, 
	BSUM NUMBER, 
	RATE_O NUMBER, 
	RATE_B NUMBER, 
	RATE_S NUMBER, 
	IDB NUMBER, 
	DY CHAR(1), 
	KOEFF NUMBER(8,5), 
	PRO NUMBER(*,0), 
	ACTION NUMBER(1,0), 
	IDUPD NUMBER, 
	WHEN TIMESTAMP (6), 
	USERID NUMBER, 
	PRI NUMBER(*,0), 
	KF VARCHAR2(6) DEFAULT sys_context(''bars_context'',''user_mfo'')
   ) SEGMENT CREATION IMMEDIATE 
  PCTFREE 10 PCTUSED 40 INITRANS 1 MAXTRANS 255 
 NOCOMPRESS LOGGING
  TABLESPACE BRSDYND ';
exception when others then       
  if sqlcode=-955 then null; else raise; end if; 
end; 
/




PROMPT *** ALTER_POLICIES to CP_RATES_UPDATE ***
 exec bpa.alter_policies('CP_RATES_UPDATE');


COMMENT ON TABLE BARS.CP_RATES_UPDATE IS 'Таблиця історії котировочних курсів ЦП';
COMMENT ON COLUMN BARS.CP_RATES_UPDATE.KF IS '';
COMMENT ON COLUMN BARS.CP_RATES_UPDATE.ID IS 'Код ЦП';
COMMENT ON COLUMN BARS.CP_RATES_UPDATE.VDATE IS 'Дата котирування';
COMMENT ON COLUMN BARS.CP_RATES_UPDATE.BSUM IS 'Базова сума';
COMMENT ON COLUMN BARS.CP_RATES_UPDATE.RATE_O IS 'Справедлива вартість';
COMMENT ON COLUMN BARS.CP_RATES_UPDATE.RATE_B IS 'Курс ...';
COMMENT ON COLUMN BARS.CP_RATES_UPDATE.RATE_S IS 'Курс ...';
COMMENT ON COLUMN BARS.CP_RATES_UPDATE.IDB IS 'Код біржі';
COMMENT ON COLUMN BARS.CP_RATES_UPDATE.DY IS 'DY';
COMMENT ON COLUMN BARS.CP_RATES_UPDATE.KOEFF IS 'Коефіцієнт';
COMMENT ON COLUMN BARS.CP_RATES_UPDATE.PRO IS 'Ознака грязної/чистої ціни (1/інше)';
COMMENT ON COLUMN BARS.CP_RATES_UPDATE.ACTION IS 'Дія з курсом (-1 видалення, 0 - вставка, 1 - модифікація)';
COMMENT ON COLUMN BARS.CP_RATES_UPDATE.IDUPD IS 'Ідентифікатор зміни';
COMMENT ON COLUMN BARS.CP_RATES_UPDATE.WHEN IS 'Дата зміни';
COMMENT ON COLUMN BARS.CP_RATES_UPDATE.USERID IS 'Ідентифікатор користувача, який здійснив зміну';
COMMENT ON COLUMN BARS.CP_RATES_UPDATE.PRI IS 'Як вносились зміни: null-невідомо,1-вручну,2-через процедуру синхронізіції з Bloomberg';




PROMPT *** Create  constraint XPK_CP_RATESW ***
begin   
 execute immediate '
  ALTER TABLE BARS.CP_RATES_UPDATE ADD CONSTRAINT XPK_CP_RATESW PRIMARY KEY (ID, VDATE, IDUPD)
  USING INDEX PCTFREE 10 INITRANS 2 MAXTRANS 255 COMPUTE STATISTICS 
  TABLESPACE BRSDYNI  ENABLE';
exception when others then
  if  sqlcode=-2260 or sqlcode=-2261 or sqlcode=-2264 or sqlcode=-2275 or sqlcode=-1442 then null; else raise; end if;
 end;
/




PROMPT *** Create  constraint SYS_C008824 ***
begin   
 execute immediate '
  ALTER TABLE BARS.CP_RATES_UPDATE MODIFY (ID NOT NULL ENABLE)';
exception when others then
  if  sqlcode=-2260 or sqlcode=-2261 or sqlcode=-2264 or sqlcode=-2275 or sqlcode=-1442 then null; else raise; end if;
 end;
/




PROMPT *** Create  constraint SYS_C008825 ***
begin   
 execute immediate '
  ALTER TABLE BARS.CP_RATES_UPDATE MODIFY (VDATE NOT NULL ENABLE)';
exception when others then
  if  sqlcode=-2260 or sqlcode=-2261 or sqlcode=-2264 or sqlcode=-2275 or sqlcode=-1442 then null; else raise; end if;
 end;
/




PROMPT *** Create  constraint SYS_C008826 ***
begin   
 execute immediate '
  ALTER TABLE BARS.CP_RATES_UPDATE MODIFY (BSUM NOT NULL ENABLE)';
exception when others then
  if  sqlcode=-2260 or sqlcode=-2261 or sqlcode=-2264 or sqlcode=-2275 or sqlcode=-1442 then null; else raise; end if;
 end;
/




PROMPT *** Create  constraint SYS_C008827 ***
begin   
 execute immediate '
  ALTER TABLE BARS.CP_RATES_UPDATE MODIFY (RATE_O NOT NULL ENABLE)';
exception when others then
  if  sqlcode=-2260 or sqlcode=-2261 or sqlcode=-2264 or sqlcode=-2275 or sqlcode=-1442 then null; else raise; end if;
 end;
/




PROMPT *** Create  index XPK_CP_RATESW ***
begin   
 execute immediate '
  CREATE UNIQUE INDEX BARS.XPK_CP_RATESW ON BARS.CP_RATES_UPDATE (ID, VDATE, IDUPD) 
  PCTFREE 10 INITRANS 2 MAXTRANS 255 COMPUTE STATISTICS 
  TABLESPACE BRSDYNI ';
exception when others then
  if  sqlcode=-955  then null; else raise; end if;
 end;
/



PROMPT *** Create  grants  CP_RATES_UPDATE ***
grant SELECT                                                                 on CP_RATES_UPDATE to BARSREADER_ROLE;
grant DELETE,INSERT,SELECT,UPDATE                                            on CP_RATES_UPDATE to BARS_ACCESS_DEFROLE;
grant SELECT                                                                 on CP_RATES_UPDATE to BARS_DM;
grant DELETE,INSERT,SELECT,UPDATE                                            on CP_RATES_UPDATE to CP_ROLE;
grant SELECT                                                                 on CP_RATES_UPDATE to UPLD;



PROMPT ===================================================================================== 
PROMPT *** End *** ========== Scripts /Sql/BARS/Table/CP_RATES_UPDATE.sql =========*** End *
PROMPT ===================================================================================== 
