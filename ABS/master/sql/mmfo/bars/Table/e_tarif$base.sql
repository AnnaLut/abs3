

PROMPT ===================================================================================== 
PROMPT *** Run *** ========== Scripts /Sql/BARS/Table/E_TARIF$BASE.sql =========*** Run *** 
PROMPT ===================================================================================== 


PROMPT *** ALTER_POLICY_INFO to E_TARIF$BASE ***


BEGIN 
        execute immediate  
          'begin  
               bpa.alter_policy_info(''E_TARIF$BASE'', ''CENTER'' , null, null, null, null);
               bpa.alter_policy_info(''E_TARIF$BASE'', ''FILIAL'' , null, ''E'', ''E'', ''E'');
               bpa.alter_policy_info(''E_TARIF$BASE'', ''WHOLE'' , null, null, null, null);
               null;
           end; 
          '; 
END; 
/

PROMPT *** Create  table E_TARIF$BASE ***
begin 
  execute immediate '
  CREATE TABLE BARS.E_TARIF$BASE 
   (	ID NUMBER(*,0), 
	NAME VARCHAR2(120), 
	SUMT1 NUMBER, 
	SUMT NUMBER, 
	KF VARCHAR2(6) DEFAULT sys_context(''bars_context'',''user_mfo''), 
	NLS6 VARCHAR2(120), 
	NDS NUMBER, 
	BRANCH VARCHAR2(30) DEFAULT sys_context(''bars_context'',''user_branch'')
   ) SEGMENT CREATION IMMEDIATE 
  PCTFREE 10 PCTUSED 40 INITRANS 1 MAXTRANS 255 
 NOCOMPRESS LOGGING
  TABLESPACE BRSDYND ';
exception when others then       
  if sqlcode=-955 then null; else raise; end if; 
end; 
/




PROMPT *** ALTER_POLICIES to E_TARIF$BASE ***
 exec bpa.alter_policies('E_TARIF$BASE');


COMMENT ON TABLE BARS.E_TARIF$BASE IS 'Довідник електроних послуг';
COMMENT ON COLUMN BARS.E_TARIF$BASE.ID IS 'Код послуги';
COMMENT ON COLUMN BARS.E_TARIF$BASE.NAME IS 'Назва послуги';
COMMENT ON COLUMN BARS.E_TARIF$BASE.SUMT1 IS '';
COMMENT ON COLUMN BARS.E_TARIF$BASE.SUMT IS 'Тариф загальний';
COMMENT ON COLUMN BARS.E_TARIF$BASE.KF IS '';
COMMENT ON COLUMN BARS.E_TARIF$BASE.NLS6 IS 'Рах-к доходів банку';
COMMENT ON COLUMN BARS.E_TARIF$BASE.NDS IS '';
COMMENT ON COLUMN BARS.E_TARIF$BASE.BRANCH IS '';




PROMPT *** Create  constraint FK_ETARIF$BASE_BRANCH ***
begin   
 execute immediate '
  ALTER TABLE BARS.E_TARIF$BASE ADD CONSTRAINT FK_ETARIF$BASE_BRANCH FOREIGN KEY (BRANCH)
	  REFERENCES BARS.BRANCH (BRANCH) DEFERRABLE ENABLE';
exception when others then
  if  sqlcode=-2260 or sqlcode=-2261 or sqlcode=-2264 or sqlcode=-2275 or sqlcode=-1442 then null; else raise; end if;
 end;
/




PROMPT *** Create  constraint FK_ETARIF$_KF ***
begin   
 execute immediate '
  ALTER TABLE BARS.E_TARIF$BASE ADD CONSTRAINT FK_ETARIF$_KF FOREIGN KEY (KF)
	  REFERENCES BARS.BANKS$BASE (MFO) ENABLE';
exception when others then
  if  sqlcode=-2260 or sqlcode=-2261 or sqlcode=-2264 or sqlcode=-2275 or sqlcode=-1442 then null; else raise; end if;
 end;
/




PROMPT *** Create  constraint NK_E_TARIF$_ID ***
begin   
 execute immediate '
  ALTER TABLE BARS.E_TARIF$BASE MODIFY (ID CONSTRAINT NK_E_TARIF$_ID NOT NULL ENABLE)';
exception when others then
  if  sqlcode=-2260 or sqlcode=-2261 or sqlcode=-2264 or sqlcode=-2275 or sqlcode=-1442 then null; else raise; end if;
 end;
/




PROMPT *** Create  constraint CC_ETARIF_KF_NN ***
begin   
 execute immediate '
  ALTER TABLE BARS.E_TARIF$BASE MODIFY (KF CONSTRAINT CC_ETARIF_KF_NN NOT NULL ENABLE)';
exception when others then
  if  sqlcode=-2260 or sqlcode=-2261 or sqlcode=-2264 or sqlcode=-2275 or sqlcode=-1442 then null; else raise; end if;
 end;
/




PROMPT *** Create  constraint CC_ETARIF$BASE_BRANCH_NN ***
begin   
 execute immediate '
  ALTER TABLE BARS.E_TARIF$BASE MODIFY (BRANCH CONSTRAINT CC_ETARIF$BASE_BRANCH_NN NOT NULL ENABLE)';
exception when others then
  if  sqlcode=-2260 or sqlcode=-2261 or sqlcode=-2264 or sqlcode=-2275 or sqlcode=-1442 then null; else raise; end if;
 end;
/




PROMPT *** Create  constraint XPK_E_TARIF$ ***
begin   
 execute immediate '
  ALTER TABLE BARS.E_TARIF$BASE ADD CONSTRAINT XPK_E_TARIF$ PRIMARY KEY (ID, KF)
  USING INDEX PCTFREE 10 INITRANS 2 MAXTRANS 255 COMPUTE STATISTICS 
  TABLESPACE BRSDYNI  ENABLE';
exception when others then
  if  sqlcode=-2260 or sqlcode=-2261 or sqlcode=-2264 or sqlcode=-2275 or sqlcode=-1442 then null; else raise; end if;
 end;
/




PROMPT *** Create  index XPK_E_TARIF$ ***
begin   
 execute immediate '
  CREATE UNIQUE INDEX BARS.XPK_E_TARIF$ ON BARS.E_TARIF$BASE (ID, KF) 
  PCTFREE 10 INITRANS 2 MAXTRANS 255 COMPUTE STATISTICS 
  TABLESPACE BRSDYNI ';
exception when others then
  if  sqlcode=-955  then null; else raise; end if;
 end;
/



PROMPT *** Create  grants  E_TARIF$BASE ***
grant SELECT                                                                 on E_TARIF$BASE    to BARS_DM;
grant DELETE,FLASHBACK,INSERT,SELECT,UPDATE                                  on E_TARIF$BASE    to WR_ALL_RIGHTS;



PROMPT ===================================================================================== 
PROMPT *** End *** ========== Scripts /Sql/BARS/Table/E_TARIF$BASE.sql =========*** End *** 
PROMPT ===================================================================================== 
