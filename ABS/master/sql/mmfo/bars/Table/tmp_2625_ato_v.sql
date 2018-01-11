

PROMPT ===================================================================================== 
PROMPT *** Run *** ========== Scripts /Sql/BARS/Table/TMP_2625_ATO_V.sql =========*** Run **
PROMPT ===================================================================================== 


PROMPT *** ALTER_POLICY_INFO to TMP_2625_ATO_V ***


BEGIN 
        execute immediate  
          'begin  
               null;
           end; 
          '; 
END; 
/

PROMPT *** Create  table TMP_2625_ATO_V ***
begin 
  execute immediate '
  CREATE TABLE BARS.TMP_2625_ATO_V 
   (	NMK VARCHAR2(48), 
	OKPO VARCHAR2(10), 
	NLS NUMBER, 
	MOBP VARCHAR2(13), 
	OSTC_35703579 VARCHAR2(13), 
	STATUS VARCHAR2(28), 
	NUMB_CARD VARCHAR2(16), 
	STATUS_CARD VARCHAR2(48), 
	PRODUCT VARCHAR2(17), 
	CARD_TYPE VARCHAR2(34), 
	DATE_OPEN VARCHAR2(10), 
	TERM NUMBER, 
	BRANCH VARCHAR2(22), 
	DAPP VARCHAR2(10), 
	SUMM VARCHAR2(10), 
	OSTC VARCHAR2(15), 
	PILG VARCHAR2(5), 
	ACC NUMBER
   ) SEGMENT CREATION IMMEDIATE 
  PCTFREE 10 PCTUSED 40 INITRANS 1 MAXTRANS 255 
 NOCOMPRESS LOGGING
  TABLESPACE BRSDYND ';
exception when others then       
  if sqlcode=-955 then null; else raise; end if; 
end; 
/




PROMPT *** ALTER_POLICIES to TMP_2625_ATO_V ***
 exec bpa.alter_policies('TMP_2625_ATO_V');


COMMENT ON TABLE BARS.TMP_2625_ATO_V IS '';
COMMENT ON COLUMN BARS.TMP_2625_ATO_V.NMK IS '';
COMMENT ON COLUMN BARS.TMP_2625_ATO_V.OKPO IS '';
COMMENT ON COLUMN BARS.TMP_2625_ATO_V.NLS IS '';
COMMENT ON COLUMN BARS.TMP_2625_ATO_V.MOBP IS '';
COMMENT ON COLUMN BARS.TMP_2625_ATO_V.OSTC_35703579 IS '';
COMMENT ON COLUMN BARS.TMP_2625_ATO_V.STATUS IS '';
COMMENT ON COLUMN BARS.TMP_2625_ATO_V.NUMB_CARD IS '';
COMMENT ON COLUMN BARS.TMP_2625_ATO_V.STATUS_CARD IS '';
COMMENT ON COLUMN BARS.TMP_2625_ATO_V.PRODUCT IS '';
COMMENT ON COLUMN BARS.TMP_2625_ATO_V.CARD_TYPE IS '';
COMMENT ON COLUMN BARS.TMP_2625_ATO_V.DATE_OPEN IS '';
COMMENT ON COLUMN BARS.TMP_2625_ATO_V.TERM IS '';
COMMENT ON COLUMN BARS.TMP_2625_ATO_V.BRANCH IS '';
COMMENT ON COLUMN BARS.TMP_2625_ATO_V.DAPP IS '';
COMMENT ON COLUMN BARS.TMP_2625_ATO_V.SUMM IS '';
COMMENT ON COLUMN BARS.TMP_2625_ATO_V.OSTC IS '';
COMMENT ON COLUMN BARS.TMP_2625_ATO_V.PILG IS '';
COMMENT ON COLUMN BARS.TMP_2625_ATO_V.ACC IS '';



PROMPT *** Create  grants  TMP_2625_ATO_V ***
grant SELECT                                                                 on TMP_2625_ATO_V  to UPLD;



PROMPT ===================================================================================== 
PROMPT *** End *** ========== Scripts /Sql/BARS/Table/TMP_2625_ATO_V.sql =========*** End **
PROMPT ===================================================================================== 
