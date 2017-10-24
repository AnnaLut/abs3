

PROMPT ===================================================================================== 
PROMPT *** Run *** ========== Scripts /Sql/BARS/Table/TMP_OFFE_NLS.sql =========*** Run *** 
PROMPT ===================================================================================== 


PROMPT *** ALTER_POLICY_INFO to TMP_OFFE_NLS ***


BEGIN 
        execute immediate  
          'begin  
               null;
           end; 
          '; 
END; 
/

PROMPT *** Create  table TMP_OFFE_NLS ***
begin 
  execute immediate '
  CREATE TABLE BARS.TMP_OFFE_NLS 
   (	OFF_E VARCHAR2(4), 
	NLS NUMBER(14,0), 
	I_VA NUMBER(3,0), 
	ISP NUMBER(3,0), 
	GR NUMBER(2,0), 
	PR_V VARCHAR2(2), 
	TRNZ NUMBER(1,0), 
	NEW NUMBER(1,0), 
	KFIL NUMBER(4,0), 
	CLOSE NUMBER(1,0), 
	BLK NUMBER(1,0), 
	ARREST NUMBER(1,0), 
	STRANG NUMBER(1,0), 
	BLK_D NUMBER(1,0), 
	BLK_K NUMBER(1,0)
   ) SEGMENT CREATION IMMEDIATE 
  PCTFREE 10 PCTUSED 40 INITRANS 1 MAXTRANS 255 
 NOCOMPRESS LOGGING
  TABLESPACE BRSDYND ';
exception when others then       
  if sqlcode=-955 then null; else raise; end if; 
end; 
/




PROMPT *** ALTER_POLICIES to TMP_OFFE_NLS ***
 exec bpa.alter_policies('TMP_OFFE_NLS');


COMMENT ON TABLE BARS.TMP_OFFE_NLS IS '';
COMMENT ON COLUMN BARS.TMP_OFFE_NLS.OFF_E IS '';
COMMENT ON COLUMN BARS.TMP_OFFE_NLS.NLS IS '';
COMMENT ON COLUMN BARS.TMP_OFFE_NLS.I_VA IS '';
COMMENT ON COLUMN BARS.TMP_OFFE_NLS.ISP IS '';
COMMENT ON COLUMN BARS.TMP_OFFE_NLS.GR IS '';
COMMENT ON COLUMN BARS.TMP_OFFE_NLS.PR_V IS '';
COMMENT ON COLUMN BARS.TMP_OFFE_NLS.TRNZ IS '';
COMMENT ON COLUMN BARS.TMP_OFFE_NLS.NEW IS '';
COMMENT ON COLUMN BARS.TMP_OFFE_NLS.KFIL IS '';
COMMENT ON COLUMN BARS.TMP_OFFE_NLS.CLOSE IS '';
COMMENT ON COLUMN BARS.TMP_OFFE_NLS.BLK IS '';
COMMENT ON COLUMN BARS.TMP_OFFE_NLS.ARREST IS '';
COMMENT ON COLUMN BARS.TMP_OFFE_NLS.STRANG IS '';
COMMENT ON COLUMN BARS.TMP_OFFE_NLS.BLK_D IS '';
COMMENT ON COLUMN BARS.TMP_OFFE_NLS.BLK_K IS '';





PROMPT ===================================================================================== 
PROMPT *** End *** ========== Scripts /Sql/BARS/Table/TMP_OFFE_NLS.sql =========*** End *** 
PROMPT ===================================================================================== 
