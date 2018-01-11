

PROMPT ===================================================================================== 
PROMPT *** Run *** ========== Scripts /Sql/BARS/Table/BANK_MON.sql =========*** Run *** ====
PROMPT ===================================================================================== 


PROMPT *** ALTER_POLICY_INFO to BANK_MON ***


BEGIN 
        execute immediate  
          'begin  
               bpa.alter_policy_info(''BANK_MON'', ''CENTER'' , null, null, null, null);
               bpa.alter_policy_info(''BANK_MON'', ''FILIAL'' , null, null, null, null);
               bpa.alter_policy_info(''BANK_MON'', ''WHOLE'' , null, null, null, null);
               null;
           end; 
          '; 
END; 
/

PROMPT *** Create  table BANK_MON ***
begin 
  execute immediate '
  CREATE TABLE BARS.BANK_MON 
   (	NAME_MON VARCHAR2(100), 
	NOM_MON NUMBER, 
	CENA_NBU NUMBER, 
	KOD NUMBER, 
	NAME_ VARCHAR2(150), 
	TYPE NUMBER, 
	CASE NUMBER, 
	CENA_NBU_OTP NUMBER, 
	TYPE_MET NUMBER(*,0), 
	KOL NUMBER, 
	RAZR NUMBER, 
	KOD_NBU VARCHAR2(11), 
	BRANCH VARCHAR2(30)
   ) SEGMENT CREATION IMMEDIATE 
  PCTFREE 10 PCTUSED 40 INITRANS 1 MAXTRANS 255 
 NOCOMPRESS LOGGING
  TABLESPACE BRSDYND ';
exception when others then       
  if sqlcode=-955 then null; else raise; end if; 
end; 
/




PROMPT *** ALTER_POLICIES to BANK_MON ***
 exec bpa.alter_policies('BANK_MON');


COMMENT ON TABLE BARS.BANK_MON IS 'Справочник юбилейных монет';
COMMENT ON COLUMN BARS.BANK_MON.NAME_MON IS 'Наименование монеты';
COMMENT ON COLUMN BARS.BANK_MON.NOM_MON IS 'Номинал (заполняется только для современых грн., которые являются средством платежа)';
COMMENT ON COLUMN BARS.BANK_MON.CENA_NBU IS 'Стоимость приобретения в НБУ';
COMMENT ON COLUMN BARS.BANK_MON.KOD IS 'Код монеты';
COMMENT ON COLUMN BARS.BANK_MON.NAME_ IS 'Полное наименование монеты';
COMMENT ON COLUMN BARS.BANK_MON.TYPE IS 'Тип 0-монеты, 1- упаковка';
COMMENT ON COLUMN BARS.BANK_MON.CASE IS 'Футляр, будет ставиться цена футляра, идущего с данной монетой';
COMMENT ON COLUMN BARS.BANK_MON.CENA_NBU_OTP IS 'Отпускная цена НБУ на день продажи';
COMMENT ON COLUMN BARS.BANK_MON.TYPE_MET IS 'Драгоценный металл   - 1, недрагоценный - 0, упаковка - 3';
COMMENT ON COLUMN BARS.BANK_MON.KOL IS '';
COMMENT ON COLUMN BARS.BANK_MON.RAZR IS '';
COMMENT ON COLUMN BARS.BANK_MON.KOD_NBU IS '';
COMMENT ON COLUMN BARS.BANK_MON.BRANCH IS '';




PROMPT *** Create  constraint XPK_BANK_MON ***
begin   
 execute immediate '
  ALTER TABLE BARS.BANK_MON ADD CONSTRAINT XPK_BANK_MON PRIMARY KEY (KOD, BRANCH)
  USING INDEX PCTFREE 10 INITRANS 2 MAXTRANS 255 COMPUTE STATISTICS 
  TABLESPACE BRSDYND  ENABLE';
exception when others then
  if  sqlcode=-2260 or sqlcode=-2261 or sqlcode=-2264 or sqlcode=-2275 or sqlcode=-1442 then null; else raise; end if;
 end;
/




PROMPT *** Create  constraint SYS_C009168 ***
begin   
 execute immediate '
  ALTER TABLE BARS.BANK_MON MODIFY (NAME_MON NOT NULL ENABLE)';
exception when others then
  if  sqlcode=-2260 or sqlcode=-2261 or sqlcode=-2264 or sqlcode=-2275 or sqlcode=-1442 then null; else raise; end if;
 end;
/




PROMPT *** Create  constraint SYS_C009169 ***
begin   
 execute immediate '
  ALTER TABLE BARS.BANK_MON MODIFY (NOM_MON NOT NULL ENABLE)';
exception when others then
  if  sqlcode=-2260 or sqlcode=-2261 or sqlcode=-2264 or sqlcode=-2275 or sqlcode=-1442 then null; else raise; end if;
 end;
/




PROMPT *** Create  constraint SYS_C009170 ***
begin   
 execute immediate '
  ALTER TABLE BARS.BANK_MON MODIFY (CENA_NBU NOT NULL ENABLE)';
exception when others then
  if  sqlcode=-2260 or sqlcode=-2261 or sqlcode=-2264 or sqlcode=-2275 or sqlcode=-1442 then null; else raise; end if;
 end;
/




PROMPT *** Create  constraint SYS_C009171 ***
begin   
 execute immediate '
  ALTER TABLE BARS.BANK_MON MODIFY (KOD NOT NULL ENABLE)';
exception when others then
  if  sqlcode=-2260 or sqlcode=-2261 or sqlcode=-2264 or sqlcode=-2275 or sqlcode=-1442 then null; else raise; end if;
 end;
/




PROMPT *** Create  constraint SYS_C009172 ***
begin   
 execute immediate '
  ALTER TABLE BARS.BANK_MON MODIFY (TYPE NOT NULL ENABLE)';
exception when others then
  if  sqlcode=-2260 or sqlcode=-2261 or sqlcode=-2264 or sqlcode=-2275 or sqlcode=-1442 then null; else raise; end if;
 end;
/




PROMPT *** Create  constraint SYS_C009173 ***
begin   
 execute immediate '
  ALTER TABLE BARS.BANK_MON MODIFY (CENA_NBU_OTP NOT NULL ENABLE)';
exception when others then
  if  sqlcode=-2260 or sqlcode=-2261 or sqlcode=-2264 or sqlcode=-2275 or sqlcode=-1442 then null; else raise; end if;
 end;
/




PROMPT *** Create  index XPK_BANK_MON ***
begin   
 execute immediate '
  CREATE UNIQUE INDEX BARS.XPK_BANK_MON ON BARS.BANK_MON (KOD, BRANCH) 
  PCTFREE 10 INITRANS 2 MAXTRANS 255 COMPUTE STATISTICS 
  TABLESPACE BRSDYND ';
exception when others then
  if  sqlcode=-955  then null; else raise; end if;
 end;
/



PROMPT *** Create  grants  BANK_MON ***
grant SELECT                                                                 on BANK_MON        to BARSREADER_ROLE;
grant SELECT                                                                 on BANK_MON        to BARSUPL;
grant DELETE,FLASHBACK,INSERT,SELECT,UPDATE                                  on BANK_MON        to BARS_ACCESS_DEFROLE;
grant SELECT                                                                 on BANK_MON        to BARS_DM;
grant DELETE,INSERT,SELECT,UPDATE                                            on BANK_MON        to PYOD001;
grant SELECT                                                                 on BANK_MON        to UPLD;
grant DELETE,FLASHBACK,INSERT,SELECT,UPDATE                                  on BANK_MON        to WR_ALL_RIGHTS;
grant DELETE,FLASHBACK,INSERT,SELECT,UPDATE                                  on BANK_MON        to WR_REFREAD;



PROMPT ===================================================================================== 
PROMPT *** End *** ========== Scripts /Sql/BARS/Table/BANK_MON.sql =========*** End *** ====
PROMPT ===================================================================================== 
