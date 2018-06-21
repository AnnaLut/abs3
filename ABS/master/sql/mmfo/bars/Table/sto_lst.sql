

PROMPT ===================================================================================== 
PROMPT *** Run *** ========== Scripts /Sql/BARS/Table/STO_LST.sql =========*** Run *** =====
PROMPT ===================================================================================== 


PROMPT *** ALTER_POLICY_INFO to STO_LST ***


BEGIN 
        execute immediate  
          'begin  
               bpa.alter_policy_info(''STO_LST'', ''CENTER'' , null, ''E'', ''E'', ''E'');
               bpa.alter_policy_info(''STO_LST'', ''FILIAL'' , ''M'', ''M'', ''M'', ''M'');
               bpa.alter_policy_info(''STO_LST'', ''WHOLE'' , null, ''E'', ''E'', ''E'');
               null;
           end; 
          '; 
END; 
/

PROMPT *** Create  table STO_LST ***
begin 
  execute immediate '
  CREATE TABLE BARS.STO_LST 
   (	IDS NUMBER, 
	RNK NUMBER(*,0), 
	NAME VARCHAR2(100), 
	SDAT DATE DEFAULT SYSDATE, 
	IDG NUMBER(*,0), 
	KF VARCHAR2(6) DEFAULT sys_context(''bars_context'',''user_mfo''), 
	BRANCH VARCHAR2(30) DEFAULT sys_context(''bars_context'',''user_branch'')
   ) SEGMENT CREATION IMMEDIATE 
  PCTFREE 10 PCTUSED 40 INITRANS 1 MAXTRANS 255 
 NOCOMPRESS LOGGING
  TABLESPACE BRSDYND ';
exception when others then       
  if sqlcode=-955 then null; else raise; end if; 
end; 
/




PROMPT *** ALTER_POLICIES to STO_LST ***
 exec bpa.alter_policies('STO_LST');


COMMENT ON TABLE BARS.STO_LST IS 'Договора на рег.платежи';
COMMENT ON COLUMN BARS.STO_LST.IDS IS 'Реф Договора';
COMMENT ON COLUMN BARS.STO_LST.RNK IS 'RNK Поручителя';
COMMENT ON COLUMN BARS.STO_LST.NAME IS 'Детали Договора';
COMMENT ON COLUMN BARS.STO_LST.SDAT IS 'Дата Договора';
COMMENT ON COLUMN BARS.STO_LST.IDG IS 'Ид группы';
COMMENT ON COLUMN BARS.STO_LST.KF IS '';
COMMENT ON COLUMN BARS.STO_LST.BRANCH IS '';




PROMPT *** Create  constraint PK_STOLST ***
begin   
 execute immediate '
  ALTER TABLE BARS.STO_LST ADD CONSTRAINT PK_STOLST PRIMARY KEY (IDS)
  USING INDEX PCTFREE 10 INITRANS 2 MAXTRANS 255 COMPUTE STATISTICS 
  TABLESPACE BRSDYNI  ENABLE';
exception when others then
  if  sqlcode=-2260 or sqlcode=-2261 or sqlcode=-2264 or sqlcode=-2275 or sqlcode=-1442 then null; else raise; end if;
 end;
/




PROMPT *** Create  constraint UK_STOLST ***
begin   
 execute immediate '
  ALTER TABLE BARS.STO_LST ADD CONSTRAINT UK_STOLST UNIQUE (KF, IDS)
  USING INDEX PCTFREE 10 INITRANS 2 MAXTRANS 255 COMPUTE STATISTICS 
  TABLESPACE BRSDYNI  ENABLE';
exception when others then
  if  sqlcode=-2260 or sqlcode=-2261 or sqlcode=-2264 or sqlcode=-2275 or sqlcode=-1442 then null; else raise; end if;
 end;
/




PROMPT *** Create  constraint CC_STOLST_IDS_NN ***
begin   
 execute immediate '
  ALTER TABLE BARS.STO_LST MODIFY (IDS CONSTRAINT CC_STOLST_IDS_NN NOT NULL ENABLE)';
exception when others then
  if  sqlcode=-2260 or sqlcode=-2261 or sqlcode=-2264 or sqlcode=-2275 or sqlcode=-1442 then null; else raise; end if;
 end;
/




PROMPT *** Create  constraint CC_STOLST_RNK_NN ***
begin   
 execute immediate '
  ALTER TABLE BARS.STO_LST MODIFY (RNK CONSTRAINT CC_STOLST_RNK_NN NOT NULL ENABLE)';
exception when others then
  if  sqlcode=-2260 or sqlcode=-2261 or sqlcode=-2264 or sqlcode=-2275 or sqlcode=-1442 then null; else raise; end if;
 end;
/




PROMPT *** Create  constraint CC_STOLST_SDAT_NN ***
begin   
 execute immediate '
  ALTER TABLE BARS.STO_LST MODIFY (SDAT CONSTRAINT CC_STOLST_SDAT_NN NOT NULL ENABLE)';
exception when others then
  if  sqlcode=-2260 or sqlcode=-2261 or sqlcode=-2264 or sqlcode=-2275 or sqlcode=-1442 then null; else raise; end if;
 end;
/




PROMPT *** Create  constraint CC_STOLST_IDG_NN ***
begin   
 execute immediate '
  ALTER TABLE BARS.STO_LST MODIFY (IDG CONSTRAINT CC_STOLST_IDG_NN NOT NULL ENABLE)';
exception when others then
  if  sqlcode=-2260 or sqlcode=-2261 or sqlcode=-2264 or sqlcode=-2275 or sqlcode=-1442 then null; else raise; end if;
 end;
/




PROMPT *** Create  constraint CC_STOLST_KF_NN ***
begin   
 execute immediate '
  ALTER TABLE BARS.STO_LST MODIFY (KF CONSTRAINT CC_STOLST_KF_NN NOT NULL ENABLE)';
exception when others then
  if  sqlcode=-2260 or sqlcode=-2261 or sqlcode=-2264 or sqlcode=-2275 or sqlcode=-1442 then null; else raise; end if;
 end;
/




PROMPT *** Create  constraint CC_STOLST_BRANCH_NN ***
begin   
 execute immediate '
  ALTER TABLE BARS.STO_LST MODIFY (BRANCH CONSTRAINT CC_STOLST_BRANCH_NN NOT NULL ENABLE)';
exception when others then
  if  sqlcode=-2260 or sqlcode=-2261 or sqlcode=-2264 or sqlcode=-2275 or sqlcode=-1442 then null; else raise; end if;
 end;
/




PROMPT *** Create  index PK_STOLST ***
begin   
 execute immediate '
  CREATE UNIQUE INDEX BARS.PK_STOLST ON BARS.STO_LST (IDS) 
  PCTFREE 10 INITRANS 2 MAXTRANS 255 COMPUTE STATISTICS 
  TABLESPACE BRSDYNI ';
exception when others then
  if  sqlcode=-955  then null; else raise; end if;
 end;
/




PROMPT *** Create  index UK_STOLST ***
begin   
 execute immediate '
  CREATE UNIQUE INDEX BARS.UK_STOLST ON BARS.STO_LST (KF, IDS) 
  PCTFREE 10 INITRANS 2 MAXTRANS 255 COMPUTE STATISTICS 
  TABLESPACE BRSDYNI ';
exception when others then
  if  sqlcode=-955  then null; else raise; end if;
 end;
/

PROMPT *** DROP   constraint FK_STOLST_STOGRP ***
begin
 execute immediate '
   ALTER TABLE BARS.STO_LST DROP CONSTRAINT FK_STOLST_STOGRP
   ';
exception when others then 
  if  sqlcode=-02443 then null; else raise; end if;
end ;
/


PROMPT *** Create  grants  STO_LST ***
grant SELECT                                                                 on STO_LST         to BARSREADER_ROLE;
grant SELECT                                                                 on STO_LST         to BARSUPL;
grant DELETE,INSERT,SELECT,UPDATE                                            on STO_LST         to BARS_ACCESS_DEFROLE;
grant SELECT                                                                 on STO_LST         to BARS_DM;
grant DELETE,INSERT,SELECT,UPDATE                                            on STO_LST         to STO;
grant SELECT                                                                 on STO_LST         to UPLD;
grant DELETE,FLASHBACK,INSERT,SELECT,UPDATE                                  on STO_LST         to WR_ALL_RIGHTS;



PROMPT ===================================================================================== 
PROMPT *** End *** ========== Scripts /Sql/BARS/Table/STO_LST.sql =========*** End *** =====
PROMPT ===================================================================================== 
