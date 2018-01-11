

PROMPT ===================================================================================== 
PROMPT *** Run *** ========== Scripts /Sql/BARS/Table/TMP_2625_GOLD_V.sql =========*** Run *
PROMPT ===================================================================================== 


PROMPT *** ALTER_POLICY_INFO to TMP_2625_GOLD_V ***


BEGIN 
        execute immediate  
          'begin  
               null;
           end; 
          '; 
END; 
/

PROMPT *** Create  table TMP_2625_GOLD_V ***
begin 
  execute immediate '
  CREATE TABLE BARS.TMP_2625_GOLD_V 
   (	FIO VARCHAR2(100), 
	OKPO VARCHAR2(10), 
	NLS VARCHAR2(16), 
	OKPO_ORG VARCHAR2(16), 
	SUM_ZP VARCHAR2(20), 
	DAPP VARCHAR2(10), 
	MPNO VARCHAR2(15), 
	PRODUCT VARCHAR2(35), 
	NAME_BPK VARCHAR2(100), 
	EMBOS_NAME VARCHAR2(35), 
	DATE_OPEN VARCHAR2(10), 
	TERM VARCHAR2(4), 
	KL VARCHAR2(10), 
	SMS VARCHAR2(30), 
	BRANCH VARCHAR2(25), 
	BUSH VARCHAR2(10), 
	PM VARCHAR2(30), 
	ZP_06 VARCHAR2(30), 
	ZP_07 VARCHAR2(30), 
	ZP_08 VARCHAR2(30), 
	NAME_ORG VARCHAR2(150)
   ) SEGMENT CREATION IMMEDIATE 
  PCTFREE 10 PCTUSED 40 INITRANS 1 MAXTRANS 255 
 NOCOMPRESS LOGGING
  TABLESPACE BRSDYND ';
exception when others then       
  if sqlcode=-955 then null; else raise; end if; 
end; 
/




PROMPT *** ALTER_POLICIES to TMP_2625_GOLD_V ***
 exec bpa.alter_policies('TMP_2625_GOLD_V');


COMMENT ON TABLE BARS.TMP_2625_GOLD_V IS '';
COMMENT ON COLUMN BARS.TMP_2625_GOLD_V.FIO IS '';
COMMENT ON COLUMN BARS.TMP_2625_GOLD_V.OKPO IS '';
COMMENT ON COLUMN BARS.TMP_2625_GOLD_V.NLS IS '';
COMMENT ON COLUMN BARS.TMP_2625_GOLD_V.OKPO_ORG IS '';
COMMENT ON COLUMN BARS.TMP_2625_GOLD_V.SUM_ZP IS '';
COMMENT ON COLUMN BARS.TMP_2625_GOLD_V.DAPP IS '';
COMMENT ON COLUMN BARS.TMP_2625_GOLD_V.MPNO IS '';
COMMENT ON COLUMN BARS.TMP_2625_GOLD_V.PRODUCT IS '';
COMMENT ON COLUMN BARS.TMP_2625_GOLD_V.NAME_BPK IS '';
COMMENT ON COLUMN BARS.TMP_2625_GOLD_V.EMBOS_NAME IS '';
COMMENT ON COLUMN BARS.TMP_2625_GOLD_V.DATE_OPEN IS '';
COMMENT ON COLUMN BARS.TMP_2625_GOLD_V.TERM IS '';
COMMENT ON COLUMN BARS.TMP_2625_GOLD_V.KL IS '';
COMMENT ON COLUMN BARS.TMP_2625_GOLD_V.SMS IS '';
COMMENT ON COLUMN BARS.TMP_2625_GOLD_V.BRANCH IS '';
COMMENT ON COLUMN BARS.TMP_2625_GOLD_V.BUSH IS '';
COMMENT ON COLUMN BARS.TMP_2625_GOLD_V.PM IS '';
COMMENT ON COLUMN BARS.TMP_2625_GOLD_V.ZP_06 IS '';
COMMENT ON COLUMN BARS.TMP_2625_GOLD_V.ZP_07 IS '';
COMMENT ON COLUMN BARS.TMP_2625_GOLD_V.ZP_08 IS '';
COMMENT ON COLUMN BARS.TMP_2625_GOLD_V.NAME_ORG IS '';



PROMPT *** Create  grants  TMP_2625_GOLD_V ***
grant SELECT                                                                 on TMP_2625_GOLD_V to UPLD;



PROMPT ===================================================================================== 
PROMPT *** End *** ========== Scripts /Sql/BARS/Table/TMP_2625_GOLD_V.sql =========*** End *
PROMPT ===================================================================================== 
