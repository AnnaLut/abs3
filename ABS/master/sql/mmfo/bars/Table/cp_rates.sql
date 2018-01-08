

PROMPT ===================================================================================== 
PROMPT *** Run *** ========== Scripts /Sql/BARS/Table/CP_RATES.sql =========*** Run *** ====
PROMPT ===================================================================================== 


PROMPT *** ALTER_POLICY_INFO to CP_RATES ***


BEGIN 
        execute immediate  
          'begin  
               bpa.alter_policy_info(''CP_RATES'', ''CENTER'' , null, null, null, ''E'');
               bpa.alter_policy_info(''CP_RATES'', ''FILIAL'' , null, null, null, null);
               bpa.alter_policy_info(''CP_RATES'', ''WHOLE'' , null, null, null, null);
               null;
           end; 
          '; 
END; 
/

PROMPT *** Create  table CP_RATES ***
begin 
  execute immediate '
  CREATE TABLE BARS.CP_RATES 
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
	IDU NUMBER, 
	PRI NUMBER(*,0)
   ) SEGMENT CREATION IMMEDIATE 
  PCTFREE 10 PCTUSED 40 INITRANS 1 MAXTRANS 255 
 NOCOMPRESS LOGGING
  TABLESPACE BRSDYND ';
exception when others then       
  if sqlcode=-955 then null; else raise; end if; 
end; 
/




PROMPT *** ALTER_POLICIES to CP_RATES ***
 exec bpa.alter_policies('CP_RATES');


COMMENT ON TABLE BARS.CP_RATES IS 'Таблиця котировочних курсів ЦП';
COMMENT ON COLUMN BARS.CP_RATES.ID IS 'Код ЦП';
COMMENT ON COLUMN BARS.CP_RATES.VDATE IS 'Дата котирування';
COMMENT ON COLUMN BARS.CP_RATES.BSUM IS 'Базова сума';
COMMENT ON COLUMN BARS.CP_RATES.RATE_O IS 'Справедлива вартість';
COMMENT ON COLUMN BARS.CP_RATES.RATE_B IS 'Курс ...';
COMMENT ON COLUMN BARS.CP_RATES.RATE_S IS 'Курс ...';
COMMENT ON COLUMN BARS.CP_RATES.IDB IS 'Код біржі';
COMMENT ON COLUMN BARS.CP_RATES.DY IS 'DY';
COMMENT ON COLUMN BARS.CP_RATES.KOEFF IS 'Коефіцієнт';
COMMENT ON COLUMN BARS.CP_RATES.PRO IS 'Ознака грязної/чистої ціни (1/інше)';
COMMENT ON COLUMN BARS.CP_RATES.IDU IS 'Код користувача, що вносив зміни';
COMMENT ON COLUMN BARS.CP_RATES.PRI IS 'Як вносились зміни: null-невідомо,1-вручну,2-через процедуру синхронізіції з Bloomberg';




PROMPT *** Create  constraint XPK_CP_RATES ***
begin   
 execute immediate '
  ALTER TABLE BARS.CP_RATES ADD CONSTRAINT XPK_CP_RATES PRIMARY KEY (ID, VDATE)
  USING INDEX PCTFREE 10 INITRANS 2 MAXTRANS 255 COMPUTE STATISTICS 
  TABLESPACE BRSDYND  ENABLE';
exception when others then
  if  sqlcode=-2260 or sqlcode=-2261 or sqlcode=-2264 or sqlcode=-2275 or sqlcode=-1442 then null; else raise; end if;
 end;
/




PROMPT *** Create  constraint SYS_C008044 ***
begin   
 execute immediate '
  ALTER TABLE BARS.CP_RATES MODIFY (ID NOT NULL ENABLE)';
exception when others then
  if  sqlcode=-2260 or sqlcode=-2261 or sqlcode=-2264 or sqlcode=-2275 or sqlcode=-1442 then null; else raise; end if;
 end;
/




PROMPT *** Create  constraint SYS_C008045 ***
begin   
 execute immediate '
  ALTER TABLE BARS.CP_RATES MODIFY (VDATE NOT NULL ENABLE)';
exception when others then
  if  sqlcode=-2260 or sqlcode=-2261 or sqlcode=-2264 or sqlcode=-2275 or sqlcode=-1442 then null; else raise; end if;
 end;
/




PROMPT *** Create  constraint SYS_C008046 ***
begin   
 execute immediate '
  ALTER TABLE BARS.CP_RATES MODIFY (BSUM NOT NULL ENABLE)';
exception when others then
  if  sqlcode=-2260 or sqlcode=-2261 or sqlcode=-2264 or sqlcode=-2275 or sqlcode=-1442 then null; else raise; end if;
 end;
/




PROMPT *** Create  constraint SYS_C008047 ***
begin   
 execute immediate '
  ALTER TABLE BARS.CP_RATES MODIFY (RATE_O NOT NULL ENABLE)';
exception when others then
  if  sqlcode=-2260 or sqlcode=-2261 or sqlcode=-2264 or sqlcode=-2275 or sqlcode=-1442 then null; else raise; end if;
 end;
/




PROMPT *** Create  index XPK_CP_RATES ***
begin   
 execute immediate '
  CREATE UNIQUE INDEX BARS.XPK_CP_RATES ON BARS.CP_RATES (ID, VDATE) 
  PCTFREE 10 INITRANS 2 MAXTRANS 255 COMPUTE STATISTICS 
  TABLESPACE BRSDYND ';
exception when others then
  if  sqlcode=-955  then null; else raise; end if;
 end;
/



PROMPT *** Create  grants  CP_RATES ***
grant SELECT                                                                 on CP_RATES        to BARSREADER_ROLE;
grant DELETE,FLASHBACK,INSERT,SELECT,UPDATE                                  on CP_RATES        to BARS_ACCESS_DEFROLE;
grant SELECT                                                                 on CP_RATES        to BARS_DM;
grant DELETE,INSERT,SELECT,UPDATE                                            on CP_RATES        to CP_ROLE;
grant SELECT                                                                 on CP_RATES        to UPLD;
grant FLASHBACK,SELECT                                                       on CP_RATES        to WR_REFREAD;



PROMPT ===================================================================================== 
PROMPT *** End *** ========== Scripts /Sql/BARS/Table/CP_RATES.sql =========*** End *** ====
PROMPT ===================================================================================== 
