

PROMPT ===================================================================================== 
PROMPT *** Run *** ========== Scripts /Sql/BARS/Table/TMP_IMPKLBX_TBL.sql =========*** Run *
PROMPT ===================================================================================== 


PROMPT *** ALTER_POLICY_INFO to TMP_IMPKLBX_TBL ***


BEGIN 
        execute immediate  
          'begin  
               null;
           end; 
          '; 
END; 
/

PROMPT *** Create  table TMP_IMPKLBX_TBL ***
begin 
  execute immediate '
  CREATE TABLE BARS.TMP_IMPKLBX_TBL 
   (	FN VARCHAR2(24), 
	N NUMBER, 
	ND VARCHAR2(10), 
	ERRCODE VARCHAR2(4), 
	ERRMSG VARCHAR2(256), 
	KV NUMBER, 
	NLSA VARCHAR2(14), 
	NLSB VARCHAR2(14), 
	S NUMBER, 
	SK NUMBER, 
	NAZN VARCHAR2(160), 
	ID NUMBER
   ) SEGMENT CREATION IMMEDIATE 
  PCTFREE 10 PCTUSED 0 INITRANS 1 MAXTRANS 255 
 NOCOMPRESS LOGGING
  TABLESPACE BRSDYND ';
exception when others then       
  if sqlcode=-955 then null; else raise; end if; 
end; 
/




PROMPT *** ALTER_POLICIES to TMP_IMPKLBX_TBL ***
 exec bpa.alter_policies('TMP_IMPKLBX_TBL');


COMMENT ON TABLE BARS.TMP_IMPKLBX_TBL IS '';
COMMENT ON COLUMN BARS.TMP_IMPKLBX_TBL.FN IS '';
COMMENT ON COLUMN BARS.TMP_IMPKLBX_TBL.N IS '';
COMMENT ON COLUMN BARS.TMP_IMPKLBX_TBL.ND IS '';
COMMENT ON COLUMN BARS.TMP_IMPKLBX_TBL.ERRCODE IS '';
COMMENT ON COLUMN BARS.TMP_IMPKLBX_TBL.ERRMSG IS '';
COMMENT ON COLUMN BARS.TMP_IMPKLBX_TBL.KV IS '';
COMMENT ON COLUMN BARS.TMP_IMPKLBX_TBL.NLSA IS '';
COMMENT ON COLUMN BARS.TMP_IMPKLBX_TBL.NLSB IS '';
COMMENT ON COLUMN BARS.TMP_IMPKLBX_TBL.S IS '';
COMMENT ON COLUMN BARS.TMP_IMPKLBX_TBL.SK IS '';
COMMENT ON COLUMN BARS.TMP_IMPKLBX_TBL.NAZN IS '';
COMMENT ON COLUMN BARS.TMP_IMPKLBX_TBL.ID IS '';



PROMPT *** Create  grants  TMP_IMPKLBX_TBL ***
grant SELECT                                                                 on TMP_IMPKLBX_TBL to BARS_DM;
grant DELETE,FLASHBACK,INSERT,SELECT,UPDATE                                  on TMP_IMPKLBX_TBL to WR_ALL_RIGHTS;



PROMPT ===================================================================================== 
PROMPT *** End *** ========== Scripts /Sql/BARS/Table/TMP_IMPKLBX_TBL.sql =========*** End *
PROMPT ===================================================================================== 
