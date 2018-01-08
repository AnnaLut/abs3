

PROMPT ===================================================================================== 
PROMPT *** Run *** ========== Scripts /Sql/BARS/Table/CC_KOL_SP.sql =========*** Run *** ===
PROMPT ===================================================================================== 


PROMPT *** ALTER_POLICY_INFO to CC_KOL_SP ***


BEGIN 
        execute immediate  
          'begin  
               bpa.alter_policy_info(''CC_KOL_SP'', ''CENTER'' , null, null, null, null);
               bpa.alter_policy_info(''CC_KOL_SP'', ''FILIAL'' , null, null, null, null);
               bpa.alter_policy_info(''CC_KOL_SP'', ''WHOLE'' , null, null, null, null);
               null;
           end; 
          '; 
END; 
/

PROMPT *** Create  table CC_KOL_SP ***
begin 
  execute immediate '
  CREATE TABLE BARS.CC_KOL_SP 
   (	ND NUMBER(*,0), 
	FDAT DATE, 
	SP NUMBER(38,0), 
	SPN NUMBER(38,0), 
	RNK NUMBER, 
	SPO NUMBER, 
	ID VARCHAR2(5)
   ) SEGMENT CREATION IMMEDIATE 
  PCTFREE 10 PCTUSED 40 INITRANS 1 MAXTRANS 255 
 NOCOMPRESS LOGGING
  TABLESPACE BRSDYND ';
exception when others then       
  if sqlcode=-955 then null; else raise; end if; 
end; 
/




PROMPT *** ALTER_POLICIES to CC_KOL_SP ***
 exec bpa.alter_policies('CC_KOL_SP');


COMMENT ON TABLE BARS.CC_KOL_SP IS 'Кол-во дней просрочки по отч.датам';
COMMENT ON COLUMN BARS.CC_KOL_SP.ND IS 'Реф.КД';
COMMENT ON COLUMN BARS.CC_KOL_SP.FDAT IS 'Отч.дата';
COMMENT ON COLUMN BARS.CC_KOL_SP.SP IS 'Кол. дней просроч тела';
COMMENT ON COLUMN BARS.CC_KOL_SP.SPN IS 'Кол. дней просроч %';
COMMENT ON COLUMN BARS.CC_KOL_SP.RNK IS 'рег № кл';
COMMENT ON COLUMN BARS.CC_KOL_SP.SPO IS 'кол дней просрочки по общ платежу ?????';
COMMENT ON COLUMN BARS.CC_KOL_SP.ID IS 'Код портфеля';




PROMPT *** Create  constraint PK_CCKOLSP ***
begin   
 execute immediate '
  ALTER TABLE BARS.CC_KOL_SP ADD CONSTRAINT PK_CCKOLSP PRIMARY KEY (ND, FDAT)
  USING INDEX PCTFREE 10 INITRANS 2 MAXTRANS 255 COMPUTE STATISTICS 
  TABLESPACE BRSDYNI  ENABLE NOVALIDATE';
exception when others then
  if  sqlcode=-2260 or sqlcode=-2261 or sqlcode=-2264 or sqlcode=-2275 or sqlcode=-1442 then null; else raise; end if;
 end;
/




PROMPT *** Create  constraint CCKOLSP_SP_NN ***
begin   
 execute immediate '
  ALTER TABLE BARS.CC_KOL_SP MODIFY (SP CONSTRAINT CCKOLSP_SP_NN NOT NULL ENABLE NOVALIDATE)';
exception when others then
  if  sqlcode=-2260 or sqlcode=-2261 or sqlcode=-2264 or sqlcode=-2275 or sqlcode=-1442 then null; else raise; end if;
 end;
/




PROMPT *** Create  constraint CCKOLSP_ND_NN ***
begin   
 execute immediate '
  ALTER TABLE BARS.CC_KOL_SP MODIFY (ND CONSTRAINT CCKOLSP_ND_NN NOT NULL ENABLE NOVALIDATE)';
exception when others then
  if  sqlcode=-2260 or sqlcode=-2261 or sqlcode=-2264 or sqlcode=-2275 or sqlcode=-1442 then null; else raise; end if;
 end;
/




PROMPT *** Create  constraint CCKOLSP_FDAT_NN ***
begin   
 execute immediate '
  ALTER TABLE BARS.CC_KOL_SP MODIFY (FDAT CONSTRAINT CCKOLSP_FDAT_NN NOT NULL ENABLE NOVALIDATE)';
exception when others then
  if  sqlcode=-2260 or sqlcode=-2261 or sqlcode=-2264 or sqlcode=-2275 or sqlcode=-1442 then null; else raise; end if;
 end;
/




PROMPT *** Create  constraint CCKOLSP_SPN_NN ***
begin   
 execute immediate '
  ALTER TABLE BARS.CC_KOL_SP MODIFY (SPN CONSTRAINT CCKOLSP_SPN_NN NOT NULL ENABLE NOVALIDATE)';
exception when others then
  if  sqlcode=-2260 or sqlcode=-2261 or sqlcode=-2264 or sqlcode=-2275 or sqlcode=-1442 then null; else raise; end if;
 end;
/




PROMPT *** Create  index PK_CCKOLSP ***
begin   
 execute immediate '
  CREATE UNIQUE INDEX BARS.PK_CCKOLSP ON BARS.CC_KOL_SP (ND, FDAT) 
  PCTFREE 10 INITRANS 2 MAXTRANS 255 COMPUTE STATISTICS 
  TABLESPACE BRSDYNI ';
exception when others then
  if  sqlcode=-955  then null; else raise; end if;
 end;
/



PROMPT *** Create  grants  CC_KOL_SP ***
grant SELECT                                                                 on CC_KOL_SP       to BARSREADER_ROLE;
grant SELECT                                                                 on CC_KOL_SP       to BARS_ACCESS_DEFROLE;
grant SELECT                                                                 on CC_KOL_SP       to BARS_DM;
grant SELECT                                                                 on CC_KOL_SP       to RCC_DEAL;
grant SELECT                                                                 on CC_KOL_SP       to UPLD;



PROMPT ===================================================================================== 
PROMPT *** End *** ========== Scripts /Sql/BARS/Table/CC_KOL_SP.sql =========*** End *** ===
PROMPT ===================================================================================== 
