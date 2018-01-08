

PROMPT ===================================================================================== 
PROMPT *** Run *** ========== Scripts /Sql/BARS/Table/TMP_SAL.sql =========*** Run *** =====
PROMPT ===================================================================================== 


PROMPT *** ALTER_POLICY_INFO to TMP_SAL ***


BEGIN 
        execute immediate  
          'begin  
               null;
           end; 
          '; 
END; 
/

PROMPT *** Create  table TMP_SAL ***
begin 
  execute immediate '
  CREATE GLOBAL TEMPORARY TABLE BARS.TMP_SAL 
   (	KV NUMBER, 
	NBS VARCHAR2(10), 
	NLS VARCHAR2(14), 
	NMS VARCHAR2(35), 
	OSTQD NUMBER, 
	OSTQK NUMBER, 
	DOSQ NUMBER, 
	KOSQ NUMBER, 
	OSTIQD NUMBER, 
	OSTIQK NUMBER, 
	OB22 VARCHAR2(2), 
	BRANCH VARCHAR2(30)
   ) ON COMMIT PRESERVE ROWS ';
exception when others then       
  if sqlcode=-955 then null; else raise; end if; 
end; 
/




PROMPT *** ALTER_POLICIES to TMP_SAL ***
 exec bpa.alter_policies('TMP_SAL');


COMMENT ON TABLE BARS.TMP_SAL IS 'Временная таблица счетов для процедуры P_SAL_SNP';
COMMENT ON COLUMN BARS.TMP_SAL.KV IS '';
COMMENT ON COLUMN BARS.TMP_SAL.NBS IS '';
COMMENT ON COLUMN BARS.TMP_SAL.NLS IS '';
COMMENT ON COLUMN BARS.TMP_SAL.NMS IS '';
COMMENT ON COLUMN BARS.TMP_SAL.OSTQD IS '';
COMMENT ON COLUMN BARS.TMP_SAL.OSTQK IS '';
COMMENT ON COLUMN BARS.TMP_SAL.DOSQ IS '';
COMMENT ON COLUMN BARS.TMP_SAL.KOSQ IS '';
COMMENT ON COLUMN BARS.TMP_SAL.OSTIQD IS '';
COMMENT ON COLUMN BARS.TMP_SAL.OSTIQK IS '';
COMMENT ON COLUMN BARS.TMP_SAL.OB22 IS '';
COMMENT ON COLUMN BARS.TMP_SAL.BRANCH IS '';



PROMPT *** Create  grants  TMP_SAL ***
grant SELECT                                                                 on TMP_SAL         to BARS_ACCESS_DEFROLE;
grant SELECT                                                                 on TMP_SAL         to RPBN001;



PROMPT ===================================================================================== 
PROMPT *** End *** ========== Scripts /Sql/BARS/Table/TMP_SAL.sql =========*** End *** =====
PROMPT ===================================================================================== 
