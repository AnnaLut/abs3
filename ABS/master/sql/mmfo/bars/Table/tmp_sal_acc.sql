

PROMPT ===================================================================================== 
PROMPT *** Run *** ========== Scripts /Sql/BARS/Table/TMP_SAL_ACC.sql =========*** Run *** =
PROMPT ===================================================================================== 


PROMPT *** ALTER_POLICY_INFO to TMP_SAL_ACC ***


BEGIN 
        execute immediate  
          'begin  
               null;
           end; 
          '; 
END; 
/

PROMPT *** Create  table TMP_SAL_ACC ***
begin 
  execute immediate '
  CREATE GLOBAL TEMPORARY TABLE BARS.TMP_SAL_ACC 
   (	ACC NUMBER(*,0), 
	KV NUMBER(*,0), 
	NBS CHAR(4), 
	NLS VARCHAR2(15), 
	NMS VARCHAR2(70), 
	OB22 CHAR(2), 
	BRANCH VARCHAR2(30), 
	DAOS DATE, 
	DAZS DATE, 
	DAPP DATE, 
	DAPPQ DATE
   ) ON COMMIT DELETE ROWS ';
exception when others then       
  if sqlcode=-955 then null; else raise; end if; 
end; 
/




PROMPT *** ALTER_POLICIES to TMP_SAL_ACC ***
 exec bpa.alter_policies('TMP_SAL_ACC');


COMMENT ON TABLE BARS.TMP_SAL_ACC IS 'Временная таблица счетов для процедуры P_SAL_SNP';
COMMENT ON COLUMN BARS.TMP_SAL_ACC.ACC IS '';
COMMENT ON COLUMN BARS.TMP_SAL_ACC.KV IS '';
COMMENT ON COLUMN BARS.TMP_SAL_ACC.NBS IS '';
COMMENT ON COLUMN BARS.TMP_SAL_ACC.NLS IS '';
COMMENT ON COLUMN BARS.TMP_SAL_ACC.NMS IS '';
COMMENT ON COLUMN BARS.TMP_SAL_ACC.OB22 IS '';
COMMENT ON COLUMN BARS.TMP_SAL_ACC.BRANCH IS '';
COMMENT ON COLUMN BARS.TMP_SAL_ACC.DAOS IS '';
COMMENT ON COLUMN BARS.TMP_SAL_ACC.DAZS IS '';
COMMENT ON COLUMN BARS.TMP_SAL_ACC.DAPP IS '';
COMMENT ON COLUMN BARS.TMP_SAL_ACC.DAPPQ IS '';



PROMPT *** Create  grants  TMP_SAL_ACC ***
grant SELECT                                                                 on TMP_SAL_ACC     to BARSREADER_ROLE;
grant DELETE,INSERT,SELECT,UPDATE                                            on TMP_SAL_ACC     to BARS_ACCESS_DEFROLE;
grant DELETE,INSERT,SELECT,UPDATE                                            on TMP_SAL_ACC     to START1;
grant SELECT                                                                 on TMP_SAL_ACC     to UPLD;



PROMPT ===================================================================================== 
PROMPT *** End *** ========== Scripts /Sql/BARS/Table/TMP_SAL_ACC.sql =========*** End *** =
PROMPT ===================================================================================== 
