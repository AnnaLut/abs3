

PROMPT ===================================================================================== 
PROMPT *** Run *** ========== Scripts /Sql/BARS/Table/TMP_SAL_RNK.sql =========*** Run *** =
PROMPT ===================================================================================== 


PROMPT *** ALTER_POLICY_INFO to TMP_SAL_RNK ***


BEGIN 
        execute immediate  
          'begin  
               null;
           end; 
          '; 
END; 
/

PROMPT *** Create  table TMP_SAL_RNK ***
begin 
  execute immediate '
  CREATE GLOBAL TEMPORARY TABLE BARS.TMP_SAL_RNK 
   (	FDAT DATE, 
	ACC NUMBER(38,0), 
	MFO VARCHAR2(12), 
	NLSK VARCHAR2(15), 
	KV NUMBER(38,0), 
	NLS VARCHAR2(15), 
	NMS VARCHAR2(70), 
	OKPO VARCHAR2(14), 
	RNK NUMBER
   ) ON COMMIT PRESERVE ROWS ';
exception when others then       
  if sqlcode=-955 then null; else raise; end if; 
end; 
/




PROMPT *** ALTER_POLICIES to TMP_SAL_RNK ***
 exec bpa.alter_policies('TMP_SAL_RNK');


COMMENT ON TABLE BARS.TMP_SAL_RNK IS '';
COMMENT ON COLUMN BARS.TMP_SAL_RNK.FDAT IS '';
COMMENT ON COLUMN BARS.TMP_SAL_RNK.ACC IS '';
COMMENT ON COLUMN BARS.TMP_SAL_RNK.MFO IS '';
COMMENT ON COLUMN BARS.TMP_SAL_RNK.NLSK IS '';
COMMENT ON COLUMN BARS.TMP_SAL_RNK.KV IS '';
COMMENT ON COLUMN BARS.TMP_SAL_RNK.NLS IS '';
COMMENT ON COLUMN BARS.TMP_SAL_RNK.NMS IS '';
COMMENT ON COLUMN BARS.TMP_SAL_RNK.OKPO IS '';
COMMENT ON COLUMN BARS.TMP_SAL_RNK.RNK IS '';





PROMPT ===================================================================================== 
PROMPT *** End *** ========== Scripts /Sql/BARS/Table/TMP_SAL_RNK.sql =========*** End *** =
PROMPT ===================================================================================== 
