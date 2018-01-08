

PROMPT ===================================================================================== 
PROMPT *** Run *** ========== Scripts /Sql/BARS/Table/CCK_RESTR_UPDATE.sql =========*** Run 
PROMPT ===================================================================================== 


PROMPT *** ALTER_POLICY_INFO to CCK_RESTR_UPDATE ***


BEGIN 
        execute immediate  
          'begin  
               bpa.alter_policy_info(''CCK_RESTR_UPDATE'', ''CENTER'' , null, ''E'', ''E'', ''E'');
               bpa.alter_policy_info(''CCK_RESTR_UPDATE'', ''FILIAL'' , ''M'', ''M'', ''M'', ''M'');
               bpa.alter_policy_info(''CCK_RESTR_UPDATE'', ''WHOLE'' , null, ''E'', ''E'', ''E'');
               null;
           end; 
          '; 
END; 
/

PROMPT *** Create  table CCK_RESTR_UPDATE ***
begin 
  execute immediate '
  CREATE TABLE BARS.CCK_RESTR_UPDATE 
   (	IDUPD NUMBER(38,0), 
	CHGACTION CHAR(1), 
	EFFECTDATE DATE, 
	CHGDATE DATE, 
	DONEBY NUMBER(38,0), 
	RESTR_ID NUMBER(38,0), 
	ND NUMBER, 
	FDAT DATE, 
	VID_RESTR NUMBER, 
	TXT VARCHAR2(250), 
	SUMR NUMBER, 
	FDAT_END DATE, 
	PR_NO NUMBER, 
	S_RESTR VARCHAR2(250), 
	N_DODATOK VARCHAR2(50), 
	QTY_PAY NUMBER(3,0), 
	KF VARCHAR2(6) DEFAULT NULL
   ) SEGMENT CREATION IMMEDIATE 
  PCTFREE 10 PCTUSED 40 INITRANS 1 MAXTRANS 255 
 NOCOMPRESS LOGGING
  TABLESPACE BRSMDLD ';
exception when others then       
  if sqlcode=-955 then null; else raise; end if; 
end; 
/




PROMPT *** ALTER_POLICIES to CCK_RESTR_UPDATE ***
 exec bpa.alter_policies('CCK_RESTR_UPDATE');


COMMENT ON TABLE BARS.CCK_RESTR_UPDATE IS 'Історія змін даних про реструктуризацію кредитних договорів';
COMMENT ON COLUMN BARS.CCK_RESTR_UPDATE.DONEBY IS 'Ідентифікатор користувача, що виконав зміни';
COMMENT ON COLUMN BARS.CCK_RESTR_UPDATE.RESTR_ID IS 'Ідентифікатор реструктуризації';
COMMENT ON COLUMN BARS.CCK_RESTR_UPDATE.ND IS 'Референс КД';
COMMENT ON COLUMN BARS.CCK_RESTR_UPDATE.FDAT IS 'Дата реструктуризации';
COMMENT ON COLUMN BARS.CCK_RESTR_UPDATE.VID_RESTR IS 'Вид реструктуризации';
COMMENT ON COLUMN BARS.CCK_RESTR_UPDATE.TXT IS 'Коментар';
COMMENT ON COLUMN BARS.CCK_RESTR_UPDATE.SUMR IS 'Сума реструктуризованої заборгованості';
COMMENT ON COLUMN BARS.CCK_RESTR_UPDATE.FDAT_END IS 'Дата закінчення реструктуризації';
COMMENT ON COLUMN BARS.CCK_RESTR_UPDATE.PR_NO IS 'Ознака включення в файл #F8 (0 - не включати, 1 - включати)';
COMMENT ON COLUMN BARS.CCK_RESTR_UPDATE.S_RESTR IS '';
COMMENT ON COLUMN BARS.CCK_RESTR_UPDATE.N_DODATOK IS '';
COMMENT ON COLUMN BARS.CCK_RESTR_UPDATE.QTY_PAY IS '';
COMMENT ON COLUMN BARS.CCK_RESTR_UPDATE.KF IS '';
COMMENT ON COLUMN BARS.CCK_RESTR_UPDATE.IDUPD IS 'Ідентифікатор зміни';
COMMENT ON COLUMN BARS.CCK_RESTR_UPDATE.CHGACTION IS 'Код типу зміни';
COMMENT ON COLUMN BARS.CCK_RESTR_UPDATE.EFFECTDATE IS 'Банківська дата зміни параметрів';
COMMENT ON COLUMN BARS.CCK_RESTR_UPDATE.CHGDATE IS 'Календарна дата зміни параметрів';




PROMPT *** Create  constraint CC_CCKRESTRUPD_EFFECTDATE_NN ***
begin   
 execute immediate '
  ALTER TABLE BARS.CCK_RESTR_UPDATE MODIFY (EFFECTDATE CONSTRAINT CC_CCKRESTRUPD_EFFECTDATE_NN NOT NULL ENABLE)';
exception when others then
  if  sqlcode=-2260 or sqlcode=-2261 or sqlcode=-2264 or sqlcode=-2275 or sqlcode=-1442 then null; else raise; end if;
 end;
/




PROMPT *** Create  constraint CC_CCKRESTRUPDATE_KF_NN ***
begin   
 execute immediate '
  ALTER TABLE BARS.CCK_RESTR_UPDATE MODIFY (KF CONSTRAINT CC_CCKRESTRUPDATE_KF_NN NOT NULL ENABLE)';
exception when others then
  if  sqlcode=-2260 or sqlcode=-2261 or sqlcode=-2264 or sqlcode=-2275 or sqlcode=-1442 then null; else raise; end if;
 end;
/




PROMPT *** Create  constraint PK_CCKRESTRUPD ***
begin   
 execute immediate '
  ALTER TABLE BARS.CCK_RESTR_UPDATE ADD CONSTRAINT PK_CCKRESTRUPD PRIMARY KEY (IDUPD)
  USING INDEX PCTFREE 10 INITRANS 2 MAXTRANS 255 COMPUTE STATISTICS 
  TABLESPACE BRSMDLI  ENABLE';
exception when others then
  if  sqlcode=-2260 or sqlcode=-2261 or sqlcode=-2264 or sqlcode=-2275 or sqlcode=-1442 then null; else raise; end if;
 end;
/




PROMPT *** Create  constraint CC_CCKRESTRUPD_IDUPD_NN ***
begin   
 execute immediate '
  ALTER TABLE BARS.CCK_RESTR_UPDATE MODIFY (IDUPD CONSTRAINT CC_CCKRESTRUPD_IDUPD_NN NOT NULL ENABLE)';
exception when others then
  if  sqlcode=-2260 or sqlcode=-2261 or sqlcode=-2264 or sqlcode=-2275 or sqlcode=-1442 then null; else raise; end if;
 end;
/




PROMPT *** Create  constraint CC_CCKRESTRUPD_CHGACTION_NN ***
begin   
 execute immediate '
  ALTER TABLE BARS.CCK_RESTR_UPDATE MODIFY (CHGACTION CONSTRAINT CC_CCKRESTRUPD_CHGACTION_NN NOT NULL ENABLE)';
exception when others then
  if  sqlcode=-2260 or sqlcode=-2261 or sqlcode=-2264 or sqlcode=-2275 or sqlcode=-1442 then null; else raise; end if;
 end;
/




PROMPT *** Create  constraint CC_CCKRESTRUPD_CHGDATE_NN ***
begin   
 execute immediate '
  ALTER TABLE BARS.CCK_RESTR_UPDATE MODIFY (CHGDATE CONSTRAINT CC_CCKRESTRUPD_CHGDATE_NN NOT NULL ENABLE)';
exception when others then
  if  sqlcode=-2260 or sqlcode=-2261 or sqlcode=-2264 or sqlcode=-2275 or sqlcode=-1442 then null; else raise; end if;
 end;
/




PROMPT *** Create  constraint CC_CCKRESTRUPD_DONEBY_NN ***
begin   
 execute immediate '
  ALTER TABLE BARS.CCK_RESTR_UPDATE MODIFY (DONEBY CONSTRAINT CC_CCKRESTRUPD_DONEBY_NN NOT NULL ENABLE)';
exception when others then
  if  sqlcode=-2260 or sqlcode=-2261 or sqlcode=-2264 or sqlcode=-2275 or sqlcode=-1442 then null; else raise; end if;
 end;
/




PROMPT *** Create  constraint CC_CCKRESTRUPD_RESTRID_NN ***
begin   
 execute immediate '
  ALTER TABLE BARS.CCK_RESTR_UPDATE MODIFY (RESTR_ID CONSTRAINT CC_CCKRESTRUPD_RESTRID_NN NOT NULL ENABLE)';
exception when others then
  if  sqlcode=-2260 or sqlcode=-2261 or sqlcode=-2264 or sqlcode=-2275 or sqlcode=-1442 then null; else raise; end if;
 end;
/




PROMPT *** Create  index PK_CCKRESTRUPD ***
begin   
 execute immediate '
  CREATE UNIQUE INDEX BARS.PK_CCKRESTRUPD ON BARS.CCK_RESTR_UPDATE (IDUPD) 
  PCTFREE 10 INITRANS 2 MAXTRANS 255 COMPUTE STATISTICS 
  TABLESPACE BRSMDLI ';
exception when others then
  if  sqlcode=-955  then null; else raise; end if;
 end;
/




PROMPT *** Create  index IDX_CCKRESTRUPD_EFFECTDATE ***
begin   
 execute immediate '
  CREATE INDEX BARS.IDX_CCKRESTRUPD_EFFECTDATE ON BARS.CCK_RESTR_UPDATE (EFFECTDATE) 
  PCTFREE 10 INITRANS 2 MAXTRANS 255 COMPUTE STATISTICS 
  TABLESPACE BRSMDLI ';
exception when others then
  if  sqlcode=-955  then null; else raise; end if;
 end;
/




PROMPT *** Create  index IDX_CCKRESTRUPD_ND ***
begin   
 execute immediate '
  CREATE INDEX BARS.IDX_CCKRESTRUPD_ND ON BARS.CCK_RESTR_UPDATE (ND) 
  PCTFREE 10 INITRANS 2 MAXTRANS 255 COMPUTE STATISTICS 
  TABLESPACE BRSMDLI ';
exception when others then
  if  sqlcode=-955  then null; else raise; end if;
 end;
/




PROMPT *** Create  index IDX_CCKRESTRUPD_RESTRID ***
begin   
 execute immediate '
  CREATE INDEX BARS.IDX_CCKRESTRUPD_RESTRID ON BARS.CCK_RESTR_UPDATE (RESTR_ID) 
  PCTFREE 10 INITRANS 2 MAXTRANS 255 COMPUTE STATISTICS 
  TABLESPACE BRSMDLI ';
exception when others then
  if  sqlcode=-955  then null; else raise; end if;
 end;
/



PROMPT *** Create  grants  CCK_RESTR_UPDATE ***
grant SELECT                                                                 on CCK_RESTR_UPDATE to BARSREADER_ROLE;
grant SELECT                                                                 on CCK_RESTR_UPDATE to BARSUPL;
grant SELECT                                                                 on CCK_RESTR_UPDATE to BARS_ACCESS_DEFROLE;
grant SELECT                                                                 on CCK_RESTR_UPDATE to BARS_DM;
grant SELECT                                                                 on CCK_RESTR_UPDATE to UPLD;



PROMPT ===================================================================================== 
PROMPT *** End *** ========== Scripts /Sql/BARS/Table/CCK_RESTR_UPDATE.sql =========*** End 
PROMPT ===================================================================================== 
