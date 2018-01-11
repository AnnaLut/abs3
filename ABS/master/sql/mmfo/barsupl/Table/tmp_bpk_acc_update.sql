

PROMPT ===================================================================================== 
PROMPT *** Run *** ========== Scripts /Sql/BARSUPL/Table/TMP_BPK_ACC_UPDATE.sql =========***
PROMPT ===================================================================================== 


PROMPT *** Create  table TMP_BPK_ACC_UPDATE ***
begin 
  execute immediate '
  CREATE GLOBAL TEMPORARY TABLE BARSUPL.TMP_BPK_ACC_UPDATE 
   (	IDUPD NUMBER(15,0), 
	CHGACTION CHAR(1), 
	EFFECTDATE DATE, 
	CHGDATE DATE, 
	DONEBY NUMBER, 
	ACC_9129 NUMBER(38,0), 
	KF VARCHAR2(6), 
	ND NUMBER(10,0), 
	PRODUCT_ID NUMBER(38,0), 
	ACC_TIP VARCHAR2(4), 
	ACC_ID NUMBER(38,0)
   ) ON COMMIT PRESERVE ROWS ';
exception when others then       
  if sqlcode=-955 then null; else raise; end if; 
end; 
/


COMMENT ON TABLE BARSUPL.TMP_BPK_ACC_UPDATE IS '';
COMMENT ON COLUMN BARSUPL.TMP_BPK_ACC_UPDATE.IDUPD IS '';
COMMENT ON COLUMN BARSUPL.TMP_BPK_ACC_UPDATE.CHGACTION IS '';
COMMENT ON COLUMN BARSUPL.TMP_BPK_ACC_UPDATE.EFFECTDATE IS '';
COMMENT ON COLUMN BARSUPL.TMP_BPK_ACC_UPDATE.CHGDATE IS '';
COMMENT ON COLUMN BARSUPL.TMP_BPK_ACC_UPDATE.DONEBY IS '';
COMMENT ON COLUMN BARSUPL.TMP_BPK_ACC_UPDATE.ACC_9129 IS '';
COMMENT ON COLUMN BARSUPL.TMP_BPK_ACC_UPDATE.KF IS '';
COMMENT ON COLUMN BARSUPL.TMP_BPK_ACC_UPDATE.ND IS '';
COMMENT ON COLUMN BARSUPL.TMP_BPK_ACC_UPDATE.PRODUCT_ID IS '';
COMMENT ON COLUMN BARSUPL.TMP_BPK_ACC_UPDATE.ACC_TIP IS '';
COMMENT ON COLUMN BARSUPL.TMP_BPK_ACC_UPDATE.ACC_ID IS '';



PROMPT *** Create  grants  TMP_BPK_ACC_UPDATE ***
grant SELECT                                                                 on TMP_BPK_ACC_UPDATE to BARSREADER_ROLE;
grant SELECT                                                                 on TMP_BPK_ACC_UPDATE to UPLD;



PROMPT ===================================================================================== 
PROMPT *** End *** ========== Scripts /Sql/BARSUPL/Table/TMP_BPK_ACC_UPDATE.sql =========***
PROMPT ===================================================================================== 
