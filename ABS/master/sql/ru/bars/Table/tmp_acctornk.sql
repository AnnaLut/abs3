

PROMPT ===================================================================================== 
PROMPT *** Run *** ========== Scripts /Sql/BARS/Table/TMP_ACCTORNK.sql =========*** Run *** 
PROMPT ===================================================================================== 


PROMPT *** ALTER_POLICY_INFO to TMP_ACCTORNK ***


BEGIN 
        execute immediate  
          'begin  
               null;
           end; 
          '; 
END; 
/

PROMPT *** Create  table TMP_ACCTORNK ***
begin 
  execute immediate '
  CREATE GLOBAL TEMPORARY TABLE BARS.TMP_ACCTORNK 
   (	ACC NUMBER(22,0), 
	BRANCH VARCHAR2(30), 
	NLS VARCHAR2(14), 
	KV NUMBER(3,0), 
	NMS VARCHAR2(70), 
	DAOS DATE, 
	RNK NUMBER(22,0), 
	NMK VARCHAR2(70), 
	NEW_RNK NUMBER(22,0)
   ) ON COMMIT PRESERVE ROWS ';
exception when others then       
  if sqlcode=-955 then null; else raise; end if; 
end; 
/




PROMPT *** ALTER_POLICIES to TMP_ACCTORNK ***
 exec bpa.alter_policies('TMP_ACCTORNK');


COMMENT ON TABLE BARS.TMP_ACCTORNK IS '';
COMMENT ON COLUMN BARS.TMP_ACCTORNK.ACC IS '';
COMMENT ON COLUMN BARS.TMP_ACCTORNK.BRANCH IS '';
COMMENT ON COLUMN BARS.TMP_ACCTORNK.NLS IS '';
COMMENT ON COLUMN BARS.TMP_ACCTORNK.KV IS '';
COMMENT ON COLUMN BARS.TMP_ACCTORNK.NMS IS '';
COMMENT ON COLUMN BARS.TMP_ACCTORNK.DAOS IS '';
COMMENT ON COLUMN BARS.TMP_ACCTORNK.RNK IS '';
COMMENT ON COLUMN BARS.TMP_ACCTORNK.NMK IS '';
COMMENT ON COLUMN BARS.TMP_ACCTORNK.NEW_RNK IS '';



PROMPT *** Create  grants  TMP_ACCTORNK ***
grant SELECT                                                                 on TMP_ACCTORNK    to BARS_ACCESS_DEFROLE;
grant SELECT                                                                 on TMP_ACCTORNK    to CUST001;



PROMPT ===================================================================================== 
PROMPT *** End *** ========== Scripts /Sql/BARS/Table/TMP_ACCTORNK.sql =========*** End *** 
PROMPT ===================================================================================== 
