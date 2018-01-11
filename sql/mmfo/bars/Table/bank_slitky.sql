

PROMPT ===================================================================================== 
PROMPT *** Run *** ========== Scripts /Sql/BARS/Table/BANK_SLITKY.sql =========*** Run *** =
PROMPT ===================================================================================== 


PROMPT *** ALTER_POLICY_INFO to BANK_SLITKY ***


BEGIN 
        execute immediate  
          'begin  
               bpa.alter_policy_info(''BANK_SLITKY'', ''CENTER'' , null, null, null, null);
               bpa.alter_policy_info(''BANK_SLITKY'', ''FILIAL'' , ''F'', null, ''B'', ''N'');
               bpa.alter_policy_info(''BANK_SLITKY'', ''WHOLE'' , null, null, null, null);
               null;
           end; 
          '; 
END; 
/

PROMPT *** Create  table BANK_SLITKY ***
begin 
  execute immediate '
  CREATE TABLE BARS.BANK_SLITKY 
   (	KOD NUMBER, 
	MET NUMBER, 
	VES NUMBER, 
	CENA NUMBER, 
	NAME VARCHAR2(70), 
	CENA_K NUMBER, 
	BRANCH VARCHAR2(30) DEFAULT sys_context(''bars_context'',''user_branch''), 
	TYPE_ NUMBER, 
	VES_UN NUMBER, 
	NLS_3800 VARCHAR2(15), 
	NAME_COMMENT VARCHAR2(160), 
	KURS_P NUMBER, 
	KURS_K NUMBER
   ) SEGMENT CREATION IMMEDIATE 
  PCTFREE 10 PCTUSED 40 INITRANS 1 MAXTRANS 255 
 NOCOMPRESS LOGGING
  TABLESPACE BRSSMLD ';
exception when others then       
  if sqlcode=-955 then null; else raise; end if; 
end; 
/




PROMPT *** ALTER_POLICIES to BANK_SLITKY ***
 exec bpa.alter_policies('BANK_SLITKY');


COMMENT ON TABLE BARS.BANK_SLITKY IS 'Види банк?вських метал?в в зливках';
COMMENT ON COLUMN BARS.BANK_SLITKY.KOD IS 'Код зливку';
COMMENT ON COLUMN BARS.BANK_SLITKY.MET IS 'Код металу';
COMMENT ON COLUMN BARS.BANK_SLITKY.VES IS 'Вага зливку в гр.';
COMMENT ON COLUMN BARS.BANK_SLITKY.CENA IS 'Комерцiйна ціна продажу';
COMMENT ON COLUMN BARS.BANK_SLITKY.NAME IS 'Назва зливку';
COMMENT ON COLUMN BARS.BANK_SLITKY.CENA_K IS 'Комерцiйна ціна купiвлi';
COMMENT ON COLUMN BARS.BANK_SLITKY.BRANCH IS 'Код безбалансового отделения';
COMMENT ON COLUMN BARS.BANK_SLITKY.TYPE_ IS 'Тип виробу 1 - зливок , 2 - монета.';
COMMENT ON COLUMN BARS.BANK_SLITKY.VES_UN IS 'Вага зливка в унц?ях';
COMMENT ON COLUMN BARS.BANK_SLITKY.NLS_3800 IS 'Рахунок валютної позиц?ї';
COMMENT ON COLUMN BARS.BANK_SLITKY.NAME_COMMENT IS 'Назва зливку (детальне)';
COMMENT ON COLUMN BARS.BANK_SLITKY.KURS_P IS 'Комерцiйний курс продажу';
COMMENT ON COLUMN BARS.BANK_SLITKY.KURS_K IS 'Комерцiйний курс купiвлi';




PROMPT *** Create  constraint CC_BANKSL_MET_NN ***
begin   
 execute immediate '
  ALTER TABLE BARS.BANK_SLITKY ADD CONSTRAINT CC_BANKSL_MET_NN CHECK (MET IS NOT NULL) ENABLE';
exception when others then
  if  sqlcode=-2260 or sqlcode=-2261 or sqlcode=-2264 or sqlcode=-2275 or sqlcode=-1442 then null; else raise; end if;
 end;
/




PROMPT *** Create  constraint XPK_BANK_SLITKY ***
begin   
 execute immediate '
  ALTER TABLE BARS.BANK_SLITKY ADD CONSTRAINT XPK_BANK_SLITKY PRIMARY KEY (KOD, BRANCH)
  USING INDEX PCTFREE 10 INITRANS 2 MAXTRANS 255 COMPUTE STATISTICS 
  TABLESPACE BRSSMLI  ENABLE';
exception when others then
  if  sqlcode=-2260 or sqlcode=-2261 or sqlcode=-2264 or sqlcode=-2275 or sqlcode=-1442 then null; else raise; end if;
 end;
/




PROMPT *** Create  constraint CC_BANKSL_KOD_NN ***
begin   
 execute immediate '
  ALTER TABLE BARS.BANK_SLITKY ADD CONSTRAINT CC_BANKSL_KOD_NN CHECK (KOD IS NOT NULL) ENABLE';
exception when others then
  if  sqlcode=-2260 or sqlcode=-2261 or sqlcode=-2264 or sqlcode=-2275 or sqlcode=-1442 then null; else raise; end if;
 end;
/




PROMPT *** Create  constraint CC_BANKSL_BRANCH_NN ***
begin   
 execute immediate '
  ALTER TABLE BARS.BANK_SLITKY ADD CONSTRAINT CC_BANKSL_BRANCH_NN CHECK (BRANCH IS NOT NULL) ENABLE';
exception when others then
  if  sqlcode=-2260 or sqlcode=-2261 or sqlcode=-2264 or sqlcode=-2275 or sqlcode=-1442 then null; else raise; end if;
 end;
/




PROMPT *** Create  index XPK_BANK_SLITKY ***
begin   
 execute immediate '
  CREATE UNIQUE INDEX BARS.XPK_BANK_SLITKY ON BARS.BANK_SLITKY (KOD, BRANCH) 
  PCTFREE 10 INITRANS 2 MAXTRANS 255 COMPUTE STATISTICS 
  TABLESPACE BRSSMLI ';
exception when others then
  if  sqlcode=-955  then null; else raise; end if;
 end;
/



PROMPT *** Create  grants  BANK_SLITKY ***
grant SELECT                                                                 on BANK_SLITKY     to BARSREADER_ROLE;
grant DELETE,INSERT,SELECT,UPDATE                                            on BANK_SLITKY     to BARS_ACCESS_DEFROLE;
grant SELECT                                                                 on BANK_SLITKY     to BARS_DM;
grant DELETE,INSERT,SELECT,UPDATE                                            on BANK_SLITKY     to PYOD001;
grant SELECT                                                                 on BANK_SLITKY     to UPLD;
grant DELETE,FLASHBACK,INSERT,SELECT,UPDATE                                  on BANK_SLITKY     to WR_ALL_RIGHTS;



PROMPT *** Create SYNONYM  to BANK_SLITKY ***

  CREATE OR REPLACE PUBLIC SYNONYM BANK_SLITKY FOR BARS.BANK_SLITKY;


PROMPT ===================================================================================== 
PROMPT *** End *** ========== Scripts /Sql/BARS/Table/BANK_SLITKY.sql =========*** End *** =
PROMPT ===================================================================================== 
