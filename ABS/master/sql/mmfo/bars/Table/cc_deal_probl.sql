

PROMPT ===================================================================================== 
PROMPT *** Run *** ========== Scripts /Sql/BARS/Table/CC_DEAL_PROBL.sql =========*** Run ***
PROMPT ===================================================================================== 


PROMPT *** ALTER_POLICY_INFO to CC_DEAL_PROBL ***


BEGIN 
        execute immediate  
          'begin  
               bpa.alter_policy_info(''CC_DEAL_PROBL'', ''FILIAL'' , null, null, null, null);
               bpa.alter_policy_info(''CC_DEAL_PROBL'', ''WHOLE'' , null, null, null, null);
               null;
           end; 
          '; 
END; 
/

PROMPT *** Create  table CC_DEAL_PROBL ***
begin 
  execute immediate '
  CREATE TABLE BARS.CC_DEAL_PROBL 
   (	ND NUMBER(38,0), 
	KF VARCHAR2(6), 
	BRANCH VARCHAR2(30), 
	OKPO VARCHAR2(14), 
	NMK VARCHAR2(70), 
	CC_ID VARCHAR2(50), 
	SDATE DATE, 
	WDATE DATE, 
	PROD VARCHAR2(100), 
	KV NUMBER(3,0), 
	ST_NOM_NG NUMBER(24,2), 
	ST_EQV_NG NUMBER(24,2), 
	SP_NOM_NG NUMBER(24,2), 
	SP_EQV_NG NUMBER(24,2), 
	ST_NOM_OD NUMBER(24,2), 
	ST_EQV_OD NUMBER(24,2), 
	SP_NOM_OD NUMBER(24,2), 
	SP_EQV_OD NUMBER(24,2), 
	KAT_J NUMBER(*,0), 
	DAT_MAX_ZB DATE, 
	DAT_SP_NOBAL DATE, 
	DAT_P_KK DATE, 
	POG_SS_NOM NUMBER(24,2), 
	POG_SS_EQV NUMBER(24,2), 
	POG_SN_NOM NUMBER(24,2), 
	POG_SN_EQV NUMBER(24,2)
   ) SEGMENT CREATION IMMEDIATE 
  PCTFREE 10 PCTUSED 0 INITRANS 1 MAXTRANS 255 
 NOCOMPRESS LOGGING
  TABLESPACE BRSDYND ';
exception when others then       
  if sqlcode=-955 then null; else raise; end if; 
end; 
/




PROMPT *** ALTER_POLICIES to CC_DEAL_PROBL ***
 exec bpa.alter_policies('CC_DEAL_PROBL');


COMMENT ON TABLE BARS.CC_DEAL_PROBL IS '';
COMMENT ON COLUMN BARS.CC_DEAL_PROBL.ND IS '';
COMMENT ON COLUMN BARS.CC_DEAL_PROBL.KF IS '';
COMMENT ON COLUMN BARS.CC_DEAL_PROBL.BRANCH IS '';
COMMENT ON COLUMN BARS.CC_DEAL_PROBL.OKPO IS '';
COMMENT ON COLUMN BARS.CC_DEAL_PROBL.NMK IS '';
COMMENT ON COLUMN BARS.CC_DEAL_PROBL.CC_ID IS '';
COMMENT ON COLUMN BARS.CC_DEAL_PROBL.SDATE IS '';
COMMENT ON COLUMN BARS.CC_DEAL_PROBL.WDATE IS '';
COMMENT ON COLUMN BARS.CC_DEAL_PROBL.PROD IS '';
COMMENT ON COLUMN BARS.CC_DEAL_PROBL.KV IS '';
COMMENT ON COLUMN BARS.CC_DEAL_PROBL.ST_NOM_NG IS '';
COMMENT ON COLUMN BARS.CC_DEAL_PROBL.ST_EQV_NG IS '';
COMMENT ON COLUMN BARS.CC_DEAL_PROBL.SP_NOM_NG IS '';
COMMENT ON COLUMN BARS.CC_DEAL_PROBL.SP_EQV_NG IS '';
COMMENT ON COLUMN BARS.CC_DEAL_PROBL.ST_NOM_OD IS '';
COMMENT ON COLUMN BARS.CC_DEAL_PROBL.ST_EQV_OD IS '';
COMMENT ON COLUMN BARS.CC_DEAL_PROBL.SP_NOM_OD IS '';
COMMENT ON COLUMN BARS.CC_DEAL_PROBL.SP_EQV_OD IS '';
COMMENT ON COLUMN BARS.CC_DEAL_PROBL.KAT_J IS '';
COMMENT ON COLUMN BARS.CC_DEAL_PROBL.DAT_MAX_ZB IS '';
COMMENT ON COLUMN BARS.CC_DEAL_PROBL.DAT_SP_NOBAL IS '';
COMMENT ON COLUMN BARS.CC_DEAL_PROBL.DAT_P_KK IS '';
COMMENT ON COLUMN BARS.CC_DEAL_PROBL.POG_SS_NOM IS '';
COMMENT ON COLUMN BARS.CC_DEAL_PROBL.POG_SS_EQV IS '';
COMMENT ON COLUMN BARS.CC_DEAL_PROBL.POG_SN_NOM IS '';
COMMENT ON COLUMN BARS.CC_DEAL_PROBL.POG_SN_EQV IS '';



PROMPT *** Create  grants  CC_DEAL_PROBL ***
grant SELECT                                                                 on CC_DEAL_PROBL   to BARSREADER_ROLE;
grant DELETE,INSERT,SELECT,UPDATE                                            on CC_DEAL_PROBL   to BARS_ACCESS_DEFROLE;
grant DELETE,INSERT,SELECT,UPDATE                                            on CC_DEAL_PROBL   to RCC_DEAL;
grant SELECT                                                                 on CC_DEAL_PROBL   to UPLD;



PROMPT ===================================================================================== 
PROMPT *** End *** ========== Scripts /Sql/BARS/Table/CC_DEAL_PROBL.sql =========*** End ***
PROMPT ===================================================================================== 
