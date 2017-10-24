

PROMPT ===================================================================================== 
PROMPT *** Run *** ========== Scripts /Sql/BARS/Table/REZ_DOC_MAKET.sql =========*** Run ***
PROMPT ===================================================================================== 


PROMPT *** ALTER_POLICY_INFO to REZ_DOC_MAKET ***


BEGIN 
        execute immediate  
          'begin  
               bpa.alter_policy_info(''REZ_DOC_MAKET'', ''CENTER'' , null, null, null, null);
               bpa.alter_policy_info(''REZ_DOC_MAKET'', ''FILIAL'' , ''M'', ''M'', ''M'', ''M'');
               bpa.alter_policy_info(''REZ_DOC_MAKET'', ''WHOLE'' , null, ''E'', ''E'', ''E'');
               null;
           end; 
          '; 
END; 
/

PROMPT *** Create  table REZ_DOC_MAKET ***
begin 
  execute immediate '
  CREATE TABLE BARS.REZ_DOC_MAKET 
   (	TT CHAR(3), 
	VOB NUMBER, 
	PDAT DATE, 
	VDAT DATE, 
	DATD DATE, 
	DATP DATE, 
	NAM_A VARCHAR2(38), 
	NLSA VARCHAR2(15), 
	MFOA VARCHAR2(12), 
	ID_A VARCHAR2(14), 
	NAM_B VARCHAR2(38), 
	NLSB VARCHAR2(15), 
	MFOB VARCHAR2(12), 
	ID_B VARCHAR2(14), 
	KV NUMBER(38,0), 
	S NUMBER(24,0), 
	S2 NUMBER(24,0), 
	KV2 NUMBER(38,0), 
	NAZN VARCHAR2(160), 
	USERID NUMBER, 
	BRANCH VARCHAR2(30) DEFAULT sys_context(''bars_context'',''user_branch''), 
	DK NUMBER(1,0), 
	BRANCH_A VARCHAR2(30), 
	REF NUMBER(*,0), 
	KF VARCHAR2(6) DEFAULT sys_context(''bars_context'',''user_mfo'')
   ) SEGMENT CREATION IMMEDIATE 
  PCTFREE 10 PCTUSED 40 INITRANS 1 MAXTRANS 255 
 NOCOMPRESS LOGGING
  TABLESPACE BRSMDLD ';
exception when others then       
  if sqlcode=-955 then null; else raise; end if; 
end; 
/




PROMPT *** ALTER_POLICIES to REZ_DOC_MAKET ***
 exec bpa.alter_policies('REZ_DOC_MAKET');


COMMENT ON TABLE BARS.REZ_DOC_MAKET IS 'макет проводок по резерву (основные реквизиты из oper)';
COMMENT ON COLUMN BARS.REZ_DOC_MAKET.KF IS '';
COMMENT ON COLUMN BARS.REZ_DOC_MAKET.TT IS '';
COMMENT ON COLUMN BARS.REZ_DOC_MAKET.VOB IS '';
COMMENT ON COLUMN BARS.REZ_DOC_MAKET.PDAT IS '';
COMMENT ON COLUMN BARS.REZ_DOC_MAKET.VDAT IS '';
COMMENT ON COLUMN BARS.REZ_DOC_MAKET.DATD IS '';
COMMENT ON COLUMN BARS.REZ_DOC_MAKET.DATP IS '';
COMMENT ON COLUMN BARS.REZ_DOC_MAKET.NAM_A IS '';
COMMENT ON COLUMN BARS.REZ_DOC_MAKET.NLSA IS '';
COMMENT ON COLUMN BARS.REZ_DOC_MAKET.MFOA IS '';
COMMENT ON COLUMN BARS.REZ_DOC_MAKET.ID_A IS '';
COMMENT ON COLUMN BARS.REZ_DOC_MAKET.NAM_B IS '';
COMMENT ON COLUMN BARS.REZ_DOC_MAKET.NLSB IS '';
COMMENT ON COLUMN BARS.REZ_DOC_MAKET.MFOB IS '';
COMMENT ON COLUMN BARS.REZ_DOC_MAKET.ID_B IS '';
COMMENT ON COLUMN BARS.REZ_DOC_MAKET.KV IS '';
COMMENT ON COLUMN BARS.REZ_DOC_MAKET.S IS '';
COMMENT ON COLUMN BARS.REZ_DOC_MAKET.S2 IS '';
COMMENT ON COLUMN BARS.REZ_DOC_MAKET.KV2 IS '';
COMMENT ON COLUMN BARS.REZ_DOC_MAKET.NAZN IS '';
COMMENT ON COLUMN BARS.REZ_DOC_MAKET.USERID IS '';
COMMENT ON COLUMN BARS.REZ_DOC_MAKET.BRANCH IS '';
COMMENT ON COLUMN BARS.REZ_DOC_MAKET.DK IS '';
COMMENT ON COLUMN BARS.REZ_DOC_MAKET.BRANCH_A IS '';
COMMENT ON COLUMN BARS.REZ_DOC_MAKET.REF IS 'Реф.документа';




PROMPT *** Create  constraint CC_REZDOCMAKET_KF_NN ***
begin   
 execute immediate '
  ALTER TABLE BARS.REZ_DOC_MAKET MODIFY (KF CONSTRAINT CC_REZDOCMAKET_KF_NN NOT NULL ENABLE)';
exception when others then
  if  sqlcode=-2260 or sqlcode=-2261 or sqlcode=-2264 or sqlcode=-2275 or sqlcode=-1442 then null; else raise; end if;
 end;
/




PROMPT *** Create  constraint FK_REZ6_BRANCH ***
begin   
 execute immediate '
  ALTER TABLE BARS.REZ_DOC_MAKET ADD CONSTRAINT FK_REZ6_BRANCH FOREIGN KEY (BRANCH)
	  REFERENCES BARS.BRANCH (BRANCH) DEFERRABLE ENABLE NOVALIDATE';
exception when others then
  if  sqlcode=-2260 or sqlcode=-2261 or sqlcode=-2264 or sqlcode=-2275 or sqlcode=-1442 then null; else raise; end if;
 end;
/




PROMPT *** Create  constraint FK_REZDOCMAKET_KF ***
begin   
 execute immediate '
  ALTER TABLE BARS.REZ_DOC_MAKET ADD CONSTRAINT FK_REZDOCMAKET_KF FOREIGN KEY (KF)
	  REFERENCES BARS.BANKS$BASE (MFO) ENABLE NOVALIDATE';
exception when others then
  if  sqlcode=-2260 or sqlcode=-2261 or sqlcode=-2264 or sqlcode=-2275 or sqlcode=-1442 then null; else raise; end if;
 end;
/




PROMPT *** Create  constraint CC_REZ6_BRANCH_NN ***
begin   
 execute immediate '
  ALTER TABLE BARS.REZ_DOC_MAKET MODIFY (BRANCH CONSTRAINT CC_REZ6_BRANCH_NN NOT NULL ENABLE)';
exception when others then
  if  sqlcode=-2260 or sqlcode=-2261 or sqlcode=-2264 or sqlcode=-2275 or sqlcode=-1442 then null; else raise; end if;
 end;
/



PROMPT *** Create  grants  REZ_DOC_MAKET ***
grant DELETE,INSERT,SELECT,UPDATE                                            on REZ_DOC_MAKET   to BARS_ACCESS_DEFROLE;
grant SELECT                                                                 on REZ_DOC_MAKET   to BARS_DM;
grant DELETE,INSERT,SELECT,UPDATE                                            on REZ_DOC_MAKET   to RCC_DEAL;
grant SELECT                                                                 on REZ_DOC_MAKET   to START1;
grant DELETE,FLASHBACK,INSERT,SELECT,UPDATE                                  on REZ_DOC_MAKET   to WR_ALL_RIGHTS;



PROMPT ===================================================================================== 
PROMPT *** End *** ========== Scripts /Sql/BARS/Table/REZ_DOC_MAKET.sql =========*** End ***
PROMPT ===================================================================================== 
