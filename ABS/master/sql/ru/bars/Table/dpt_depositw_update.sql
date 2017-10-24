

PROMPT ===================================================================================== 
PROMPT *** Run *** ========== Scripts /Sql/BARS/Table/DPT_DEPOSITW_UPDATE.sql =========*** R
PROMPT ===================================================================================== 


PROMPT *** ALTER_POLICY_INFO to DPT_DEPOSITW_UPDATE ***


BEGIN 
        execute immediate  
          'begin  
               bpa.alter_policy_info(''DPT_DEPOSITW_UPDATE'', ''FILIAL'' , null, null, null, null);
               bpa.alter_policy_info(''DPT_DEPOSITW_UPDATE'', ''WHOLE'' , null, null, null, null);
               null;
           end; 
          '; 
END; 
/

PROMPT *** Create  table DPT_DEPOSITW_UPDATE ***
begin 
  execute immediate '
  CREATE TABLE BARS.DPT_DEPOSITW_UPDATE 
   (	IDUPD NUMBER(38,0), 
	CHGACTION NUMBER(1,0), 
	CHGDATE DATE, 
	BDATE DATE, 
	DONEBY NUMBER(38,0), 
	DPT_ID NUMBER(38,0), 
	TAG CHAR(5), 
	VALUE VARCHAR2(500)
   ) SEGMENT CREATION IMMEDIATE 
  PCTFREE 10 PCTUSED 40 INITRANS 1 MAXTRANS 255 
 NOCOMPRESS LOGGING
  TABLESPACE BRSBIGD ';
exception when others then       
  if sqlcode=-955 then null; else raise; end if; 
end; 
/




PROMPT *** ALTER_POLICIES to DPT_DEPOSITW_UPDATE ***
 exec bpa.alter_policies('DPT_DEPOSITW_UPDATE');


COMMENT ON TABLE BARS.DPT_DEPOSITW_UPDATE IS 'Історія змін дод. параметрів депозитів ФО';
COMMENT ON COLUMN BARS.DPT_DEPOSITW_UPDATE.IDUPD IS 'Ідентифікатор зміни параметру';
COMMENT ON COLUMN BARS.DPT_DEPOSITW_UPDATE.CHGACTION IS 'Тип зміни параметру';
COMMENT ON COLUMN BARS.DPT_DEPOSITW_UPDATE.CHGDATE IS 'Календарна дата зміни параметру';
COMMENT ON COLUMN BARS.DPT_DEPOSITW_UPDATE.BDATE IS 'Банківська дата зміни параметру';
COMMENT ON COLUMN BARS.DPT_DEPOSITW_UPDATE.DONEBY IS 'Ідентифікатор користувача, що виконав зміни';
COMMENT ON COLUMN BARS.DPT_DEPOSITW_UPDATE.DPT_ID IS 'Ідентифікатор вкладу ФО';
COMMENT ON COLUMN BARS.DPT_DEPOSITW_UPDATE.TAG IS 'Код дод. параметру';
COMMENT ON COLUMN BARS.DPT_DEPOSITW_UPDATE.VALUE IS 'Значення дод. параметру';




PROMPT *** Create  constraint PK_DEPOSITWUPDATE ***
begin   
 execute immediate '
  ALTER TABLE BARS.DPT_DEPOSITW_UPDATE ADD CONSTRAINT PK_DEPOSITWUPDATE PRIMARY KEY (IDUPD)
  USING INDEX PCTFREE 10 INITRANS 2 MAXTRANS 255 COMPUTE STATISTICS 
  TABLESPACE BRSDYND  ENABLE';
exception when others then
  if  sqlcode=-2260 or sqlcode=-2261 or sqlcode=-2264 or sqlcode=-2275 or sqlcode=-1442 then null; else raise; end if;
 end;
/




PROMPT *** Create  constraint CC_DEPOSITWUPDATE_TAG_NN ***
begin   
 execute immediate '
  ALTER TABLE BARS.DPT_DEPOSITW_UPDATE MODIFY (TAG CONSTRAINT CC_DEPOSITWUPDATE_TAG_NN NOT NULL ENABLE)';
exception when others then
  if  sqlcode=-2260 or sqlcode=-2261 or sqlcode=-2264 or sqlcode=-2275 or sqlcode=-1442 then null; else raise; end if;
 end;
/




PROMPT *** Create  constraint CC_DEPOSITWUPDATE_DPTID_NN ***
begin   
 execute immediate '
  ALTER TABLE BARS.DPT_DEPOSITW_UPDATE MODIFY (DPT_ID CONSTRAINT CC_DEPOSITWUPDATE_DPTID_NN NOT NULL ENABLE)';
exception when others then
  if  sqlcode=-2260 or sqlcode=-2261 or sqlcode=-2264 or sqlcode=-2275 or sqlcode=-1442 then null; else raise; end if;
 end;
/




PROMPT *** Create  constraint CC_DEPOSITWUPDATE_DONEBY_NN ***
begin   
 execute immediate '
  ALTER TABLE BARS.DPT_DEPOSITW_UPDATE MODIFY (DONEBY CONSTRAINT CC_DEPOSITWUPDATE_DONEBY_NN NOT NULL ENABLE)';
exception when others then
  if  sqlcode=-2260 or sqlcode=-2261 or sqlcode=-2264 or sqlcode=-2275 or sqlcode=-1442 then null; else raise; end if;
 end;
/




PROMPT *** Create  constraint CC_DEPOSITWUPDATE_BDATE_NN ***
begin   
 execute immediate '
  ALTER TABLE BARS.DPT_DEPOSITW_UPDATE MODIFY (BDATE CONSTRAINT CC_DEPOSITWUPDATE_BDATE_NN NOT NULL ENABLE)';
exception when others then
  if  sqlcode=-2260 or sqlcode=-2261 or sqlcode=-2264 or sqlcode=-2275 or sqlcode=-1442 then null; else raise; end if;
 end;
/




PROMPT *** Create  constraint CC_DEPOSITWUPDATE_CHGDATE_NN ***
begin   
 execute immediate '
  ALTER TABLE BARS.DPT_DEPOSITW_UPDATE MODIFY (CHGDATE CONSTRAINT CC_DEPOSITWUPDATE_CHGDATE_NN NOT NULL ENABLE)';
exception when others then
  if  sqlcode=-2260 or sqlcode=-2261 or sqlcode=-2264 or sqlcode=-2275 or sqlcode=-1442 then null; else raise; end if;
 end;
/




PROMPT *** Create  constraint CC_DEPOSITWUPDATE_CHGACTION_NN ***
begin   
 execute immediate '
  ALTER TABLE BARS.DPT_DEPOSITW_UPDATE MODIFY (CHGACTION CONSTRAINT CC_DEPOSITWUPDATE_CHGACTION_NN NOT NULL ENABLE)';
exception when others then
  if  sqlcode=-2260 or sqlcode=-2261 or sqlcode=-2264 or sqlcode=-2275 or sqlcode=-1442 then null; else raise; end if;
 end;
/




PROMPT *** Create  constraint CC_DEPOSITWUPDATE_IDUPD_NN ***
begin   
 execute immediate '
  ALTER TABLE BARS.DPT_DEPOSITW_UPDATE MODIFY (IDUPD CONSTRAINT CC_DEPOSITWUPDATE_IDUPD_NN NOT NULL ENABLE)';
exception when others then
  if  sqlcode=-2260 or sqlcode=-2261 or sqlcode=-2264 or sqlcode=-2275 or sqlcode=-1442 then null; else raise; end if;
 end;
/




PROMPT *** Create  index PK_DEPOSITWUPDATE ***
begin   
 execute immediate '
  CREATE UNIQUE INDEX BARS.PK_DEPOSITWUPDATE ON BARS.DPT_DEPOSITW_UPDATE (IDUPD) 
  PCTFREE 10 INITRANS 2 MAXTRANS 255 COMPUTE STATISTICS 
  TABLESPACE BRSDYND ';
exception when others then
  if  sqlcode=-955  then null; else raise; end if;
 end;
/




PROMPT *** Create  index I2_DEPOSITWUPDATE ***
begin   
 execute immediate '
  CREATE INDEX BARS.I2_DEPOSITWUPDATE ON BARS.DPT_DEPOSITW_UPDATE (DPT_ID, BDATE) 
  PCTFREE 10 INITRANS 2 MAXTRANS 255 COMPUTE STATISTICS 
  TABLESPACE BRSBIGI ';
exception when others then
  if  sqlcode=-955  then null; else raise; end if;
 end;
/





PROMPT ===================================================================================== 
PROMPT *** End *** ========== Scripts /Sql/BARS/Table/DPT_DEPOSITW_UPDATE.sql =========*** E
PROMPT ===================================================================================== 
