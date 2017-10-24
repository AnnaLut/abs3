

PROMPT ===================================================================================== 
PROMPT *** Run *** ========== Scripts /Sql/BARS/Table/PRVN_FLOW_DEALS_OLD.sql =========*** R
PROMPT ===================================================================================== 


PROMPT *** ALTER_POLICY_INFO to PRVN_FLOW_DEALS_OLD ***


BEGIN 
        execute immediate  
          'begin  
               null;
           end; 
          '; 
END; 
/

PROMPT *** Create  table PRVN_FLOW_DEALS_OLD ***
begin 
  execute immediate '
  CREATE TABLE BARS.PRVN_FLOW_DEALS_OLD 
   (	ND NUMBER, 
	ACC NUMBER, 
	ID NUMBER, 
	DAT_ADD DATE, 
	VIDD NUMBER, 
	SDATE DATE, 
	KV8 NUMBER(*,0), 
	FL2 NUMBER(*,0), 
	ZDAT DATE, 
	OST NUMBER, 
	IR NUMBER, 
	IRR0 NUMBER, 
	RNK NUMBER, 
	WDATE DATE, 
	KV NUMBER(*,0), 
	I_CR9 NUMBER(*,0), 
	PR_TR NUMBER(*,0), 
	ACC8 NUMBER, 
	OST8 NUMBER, 
	K NUMBER, 
	OSTQ NUMBER, 
	OST8Q NUMBER, 
	TIP CHAR(3), 
	DAOS DATE
   ) SEGMENT CREATION DEFERRED 
  PCTFREE 10 PCTUSED 40 INITRANS 1 MAXTRANS 255 
 NOCOMPRESS LOGGING
  TABLESPACE BRSDYND ';
exception when others then       
  if sqlcode=-955 then null; else raise; end if; 
end; 
/




PROMPT *** ALTER_POLICIES to PRVN_FLOW_DEALS_OLD ***
 exec bpa.alter_policies('PRVN_FLOW_DEALS_OLD');


COMMENT ON TABLE BARS.PRVN_FLOW_DEALS_OLD IS 'Таблиця КД-угод для сховища';
COMMENT ON COLUMN BARS.PRVN_FLOW_DEALS_OLD.ND IS 'Реф КД АБС';
COMMENT ON COLUMN BARS.PRVN_FLOW_DEALS_OLD.ACC IS 'АСС норм тіла(рах)';
COMMENT ON COLUMN BARS.PRVN_FLOW_DEALS_OLD.ID IS 'Ід в табл ';
COMMENT ON COLUMN BARS.PRVN_FLOW_DEALS_OLD.DAT_ADD IS 'Дата внесення';
COMMENT ON COLUMN BARS.PRVN_FLOW_DEALS_OLD.VIDD IS 'Вид КД';
COMMENT ON COLUMN BARS.PRVN_FLOW_DEALS_OLD.SDATE IS 'Дата початку';
COMMENT ON COLUMN BARS.PRVN_FLOW_DEALS_OLD.KV8 IS 'код вал КД';
COMMENT ON COLUMN BARS.PRVN_FLOW_DEALS_OLD.FL2 IS '1=% за попередній день(anuitet)';
COMMENT ON COLUMN BARS.PRVN_FLOW_DEALS_OLD.ZDAT IS 'Ост.звітна дата';
COMMENT ON COLUMN BARS.PRVN_FLOW_DEALS_OLD.OST IS 'Залишок по рах';
COMMENT ON COLUMN BARS.PRVN_FLOW_DEALS_OLD.IR IS 'Діюча ном.ставка по рах.';
COMMENT ON COLUMN BARS.PRVN_FLOW_DEALS_OLD.IRR0 IS 'Діюча еф.ставка по КД';
COMMENT ON COLUMN BARS.PRVN_FLOW_DEALS_OLD.RNK IS 'РНК позичальника';
COMMENT ON COLUMN BARS.PRVN_FLOW_DEALS_OLD.WDATE IS 'Дата заверш';
COMMENT ON COLUMN BARS.PRVN_FLOW_DEALS_OLD.KV IS 'код вал рах.';
COMMENT ON COLUMN BARS.PRVN_FLOW_DEALS_OLD.I_CR9 IS 'Востанавл=0, НеВостанавл CR9=1';
COMMENT ON COLUMN BARS.PRVN_FLOW_DEALS_OLD.PR_TR IS 'Признак траншей (0-НЕТ/1-ДА)';
COMMENT ON COLUMN BARS.PRVN_FLOW_DEALS_OLD.ACC8 IS 'АССС тіла(КД)';
COMMENT ON COLUMN BARS.PRVN_FLOW_DEALS_OLD.OST8 IS 'Залишок по дог';
COMMENT ON COLUMN BARS.PRVN_FLOW_DEALS_OLD.K IS 'Коеф = Рах/Угода ';
COMMENT ON COLUMN BARS.PRVN_FLOW_DEALS_OLD.OSTQ IS 'Залишок-екв по рах';
COMMENT ON COLUMN BARS.PRVN_FLOW_DEALS_OLD.OST8Q IS 'Залишок-екв по дог';
COMMENT ON COLUMN BARS.PRVN_FLOW_DEALS_OLD.TIP IS '';
COMMENT ON COLUMN BARS.PRVN_FLOW_DEALS_OLD.DAOS IS 'Дата відкр.рах ';




PROMPT *** Create  constraint PK_PRVNFLOWDEALS ***
begin   
 execute immediate '
  ALTER TABLE BARS.PRVN_FLOW_DEALS_OLD ADD CONSTRAINT PK_PRVNFLOWDEALS PRIMARY KEY (ID)
  USING INDEX PCTFREE 10 INITRANS 2 MAXTRANS 255 COMPUTE STATISTICS 
  TABLESPACE BRSDYND  ENABLE';
exception when others then
  if  sqlcode=-2260 or sqlcode=-2261 or sqlcode=-2264 or sqlcode=-2275 or sqlcode=-1442 then null; else raise; end if;
 end;
/




PROMPT *** Create  index PK_PRVNFLOWDEALS ***
begin   
 execute immediate '
  CREATE UNIQUE INDEX BARS.PK_PRVNFLOWDEALS ON BARS.PRVN_FLOW_DEALS_OLD (ID) 
  PCTFREE 10 INITRANS 2 MAXTRANS 255 COMPUTE STATISTICS 
  TABLESPACE BRSDYND ';
exception when others then
  if  sqlcode=-955  then null; else raise; end if;
 end;
/




PROMPT *** Create  index I1_PRVNFLOWDEALS ***
begin   
 execute immediate '
  CREATE INDEX BARS.I1_PRVNFLOWDEALS ON BARS.PRVN_FLOW_DEALS_OLD (ND, ACC) 
  PCTFREE 10 INITRANS 2 MAXTRANS 255 COMPUTE STATISTICS 
  TABLESPACE BRSDYND ';
exception when others then
  if  sqlcode=-955  then null; else raise; end if;
 end;
/



PROMPT *** Create  grants  PRVN_FLOW_DEALS_OLD ***
grant SELECT,UPDATE                                                          on PRVN_FLOW_DEALS_OLD to START1;



PROMPT ===================================================================================== 
PROMPT *** End *** ========== Scripts /Sql/BARS/Table/PRVN_FLOW_DEALS_OLD.sql =========*** E
PROMPT ===================================================================================== 
