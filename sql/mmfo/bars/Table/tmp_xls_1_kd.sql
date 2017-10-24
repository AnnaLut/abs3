

PROMPT ===================================================================================== 
PROMPT *** Run *** ========== Scripts /Sql/BARS/Table/TMP_XLS_1_KD.sql =========*** Run *** 
PROMPT ===================================================================================== 


PROMPT *** ALTER_POLICY_INFO to TMP_XLS_1_KD ***


BEGIN 
        execute immediate  
          'begin  
               null;
           end; 
          '; 
END; 
/

PROMPT *** Create  table TMP_XLS_1_KD ***
begin 
  execute immediate '
  CREATE TABLE BARS.TMP_XLS_1_KD 
   (	CC_ID VARCHAR2(70), 
	NMK VARCHAR2(100), 
	CC_ID_Z VARCHAR2(250), 
	CC_ID_P VARCHAR2(70), 
	CC_ID_I VARCHAR2(70), 
	CC_ID_ZI VARCHAR2(70), 
	CC_ID_PI VARCHAR2(70), 
	CC_ID_K NUMBER(22,2), 
	CC_ID_I_K NUMBER(22,2), 
	CC_ID_Z_K NUMBER(22,2), 
	CC_ID_P_K NUMBER(22,2), 
	CC_ID_ZI_K NUMBER(22,2), 
	CC_ID_PI_K NUMBER(22,2), 
	CC_ID_ST VARCHAR2(70), 
	CC_ID_STI VARCHAR2(70), 
	CC_ID_ST_K NUMBER(22,2), 
	CC_ID_STI_K NUMBER(22,2)
   ) SEGMENT CREATION IMMEDIATE 
  PCTFREE 10 PCTUSED 40 INITRANS 1 MAXTRANS 255 
 NOCOMPRESS LOGGING
  TABLESPACE BRSDYND ';
exception when others then       
  if sqlcode=-955 then null; else raise; end if; 
end; 
/




PROMPT *** ALTER_POLICIES to TMP_XLS_1_KD ***
 exec bpa.alter_policies('TMP_XLS_1_KD');


COMMENT ON TABLE BARS.TMP_XLS_1_KD IS '';
COMMENT ON COLUMN BARS.TMP_XLS_1_KD.CC_ID IS '';
COMMENT ON COLUMN BARS.TMP_XLS_1_KD.NMK IS '';
COMMENT ON COLUMN BARS.TMP_XLS_1_KD.CC_ID_Z IS '';
COMMENT ON COLUMN BARS.TMP_XLS_1_KD.CC_ID_P IS '';
COMMENT ON COLUMN BARS.TMP_XLS_1_KD.CC_ID_I IS '';
COMMENT ON COLUMN BARS.TMP_XLS_1_KD.CC_ID_ZI IS '';
COMMENT ON COLUMN BARS.TMP_XLS_1_KD.CC_ID_PI IS '';
COMMENT ON COLUMN BARS.TMP_XLS_1_KD.CC_ID_K IS '';
COMMENT ON COLUMN BARS.TMP_XLS_1_KD.CC_ID_I_K IS '';
COMMENT ON COLUMN BARS.TMP_XLS_1_KD.CC_ID_Z_K IS '';
COMMENT ON COLUMN BARS.TMP_XLS_1_KD.CC_ID_P_K IS '';
COMMENT ON COLUMN BARS.TMP_XLS_1_KD.CC_ID_ZI_K IS '';
COMMENT ON COLUMN BARS.TMP_XLS_1_KD.CC_ID_PI_K IS '';
COMMENT ON COLUMN BARS.TMP_XLS_1_KD.CC_ID_ST IS '';
COMMENT ON COLUMN BARS.TMP_XLS_1_KD.CC_ID_STI IS '';
COMMENT ON COLUMN BARS.TMP_XLS_1_KD.CC_ID_ST_K IS '';
COMMENT ON COLUMN BARS.TMP_XLS_1_KD.CC_ID_STI_K IS '';



PROMPT *** Create  grants  TMP_XLS_1_KD ***
grant SELECT                                                                 on TMP_XLS_1_KD    to BARS_DM;



PROMPT ===================================================================================== 
PROMPT *** End *** ========== Scripts /Sql/BARS/Table/TMP_XLS_1_KD.sql =========*** End *** 
PROMPT ===================================================================================== 
