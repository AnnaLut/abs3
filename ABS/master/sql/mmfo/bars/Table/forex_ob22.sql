

PROMPT ===================================================================================== 
PROMPT *** Run *** ========== Scripts /Sql/BARS/Table/FOREX_OB22.sql =========*** Run *** ==
PROMPT ===================================================================================== 


PROMPT *** ALTER_POLICY_INFO to FOREX_OB22 ***


BEGIN 
        execute immediate  
          'begin  
               bpa.alter_policy_info(''FOREX_OB22'', ''CENTER'' , null, null, null, null);
               bpa.alter_policy_info(''FOREX_OB22'', ''FILIAL'' , null, null, null, null);
               bpa.alter_policy_info(''FOREX_OB22'', ''WHOLE'' , null, null, null, null);
               null;
           end; 
          '; 
END; 
/

PROMPT *** Create  table FOREX_OB22 ***
begin 
  execute immediate '
  CREATE TABLE BARS.FOREX_OB22 
   (	ID NUMBER(*,0), 
	KOD VARCHAR2(15), 
	S9A VARCHAR2(15), 
	S9P VARCHAR2(15), 
	S3D VARCHAR2(15), 
	S3K VARCHAR2(15), 
	S62 VARCHAR2(15), 
	S1T VARCHAR2(15), 
	S38 VARCHAR2(15), 
	P_SPOT NUMBER(*,0), 
	NAME VARCHAR2(20), 
	S9AV VARCHAR2(15), 
	S9PV VARCHAR2(15)
   ) SEGMENT CREATION IMMEDIATE 
  PCTFREE 10 PCTUSED 40 INITRANS 1 MAXTRANS 255 
 NOCOMPRESS LOGGING
  TABLESPACE BRSDYND ';
exception when others then       
  if sqlcode=-955 then null; else raise; end if; 
end; 
/




PROMPT *** ALTER_POLICIES to FOREX_OB22 ***
 exec bpa.alter_policies('FOREX_OB22');


COMMENT ON TABLE BARS.FOREX_OB22 IS 'ФОРЕКС: Схема облiку по продуктам.';
COMMENT ON COLUMN BARS.FOREX_OB22.ID IS 'Числовий~код';
COMMENT ON COLUMN BARS.FOREX_OB22.KOD IS 'Символьний~код';
COMMENT ON COLUMN BARS.FOREX_OB22.S9A IS 'БР/Об22~позаб.вимоги для звич.форекс та ДЕПО-СВОПА';
COMMENT ON COLUMN BARS.FOREX_OB22.S9P IS 'БР/Об22~позаб.зобов. для звич.форекс та ДЕПО-СВОПА';
COMMENT ON COLUMN BARS.FOREX_OB22.S3D IS 'БР/Об22~Деб.для переоц.позабал';
COMMENT ON COLUMN BARS.FOREX_OB22.S3K IS 'БР/Об22~Крд.для переоц.позабал';
COMMENT ON COLUMN BARS.FOREX_OB22.S62 IS 'БР/Об22~Резул.переоц.позабал';
COMMENT ON COLUMN BARS.FOREX_OB22.S1T IS 'БР/Об22~Торг.рах';
COMMENT ON COLUMN BARS.FOREX_OB22.S38 IS 'БР/Об22~Вал.поз';
COMMENT ON COLUMN BARS.FOREX_OB22.P_SPOT IS 'Признак розрахунку РКР-3 від СЗККВ/СЗКПВ по рах.вал.поз';
COMMENT ON COLUMN BARS.FOREX_OB22.NAME IS '';
COMMENT ON COLUMN BARS.FOREX_OB22.S9AV IS 'БР/Об22~позаб.вимоги для ВАЛ-СВОПА';
COMMENT ON COLUMN BARS.FOREX_OB22.S9PV IS 'БР/Об22~позаб.зобов. для ВАЛ-СВОПА';




PROMPT *** Create  constraint PK_FOREXOB22 ***
begin   
 execute immediate '
  ALTER TABLE BARS.FOREX_OB22 ADD CONSTRAINT PK_FOREXOB22 PRIMARY KEY (ID)
  USING INDEX PCTFREE 10 INITRANS 2 MAXTRANS 255 COMPUTE STATISTICS 
  TABLESPACE BRSDYND  ENABLE';
exception when others then
  if  sqlcode=-2260 or sqlcode=-2261 or sqlcode=-2264 or sqlcode=-2275 or sqlcode=-1442 then null; else raise; end if;
 end;
/




PROMPT *** Create  constraint UK_FOREXOB22_KOD ***
begin   
 execute immediate '
  ALTER TABLE BARS.FOREX_OB22 ADD CONSTRAINT UK_FOREXOB22_KOD UNIQUE (KOD)
  USING INDEX PCTFREE 10 INITRANS 2 MAXTRANS 255 COMPUTE STATISTICS 
  TABLESPACE BRSDYND  ENABLE';
exception when others then
  if  sqlcode=-2260 or sqlcode=-2261 or sqlcode=-2264 or sqlcode=-2275 or sqlcode=-1442 then null; else raise; end if;
 end;
/




PROMPT *** Create  index UK_FOREXOB22_KOD ***
begin   
 execute immediate '
  CREATE UNIQUE INDEX BARS.UK_FOREXOB22_KOD ON BARS.FOREX_OB22 (KOD) 
  PCTFREE 10 INITRANS 2 MAXTRANS 255 COMPUTE STATISTICS 
  TABLESPACE BRSDYND ';
exception when others then
  if  sqlcode=-955  then null; else raise; end if;
 end;
/




PROMPT *** Create  index PK_FOREXOB22 ***
begin   
 execute immediate '
  CREATE UNIQUE INDEX BARS.PK_FOREXOB22 ON BARS.FOREX_OB22 (ID) 
  PCTFREE 10 INITRANS 2 MAXTRANS 255 COMPUTE STATISTICS 
  TABLESPACE BRSDYND ';
exception when others then
  if  sqlcode=-955  then null; else raise; end if;
 end;
/



PROMPT *** Create  grants  FOREX_OB22 ***
grant DELETE,FLASHBACK,INSERT,SELECT,UPDATE                                  on FOREX_OB22      to BARS_ACCESS_DEFROLE;
grant SELECT                                                                 on FOREX_OB22      to BARS_DM;
grant DELETE,INSERT,SELECT,UPDATE                                            on FOREX_OB22      to RCH_1;
grant SELECT,UPDATE                                                          on FOREX_OB22      to START1;
grant FLASHBACK,SELECT                                                       on FOREX_OB22      to WR_REFREAD;



PROMPT ===================================================================================== 
PROMPT *** End *** ========== Scripts /Sql/BARS/Table/FOREX_OB22.sql =========*** End *** ==
PROMPT ===================================================================================== 
