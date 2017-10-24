

PROMPT ===================================================================================== 
PROMPT *** Run *** ========== Scripts /Sql/BARS/Table/TMP_ACCM_SNAP_FIRST.sql =========*** R
PROMPT ===================================================================================== 


PROMPT *** ALTER_POLICY_INFO to TMP_ACCM_SNAP_FIRST ***


BEGIN 
        execute immediate  
          'begin  
               null;
           end; 
          '; 
END; 
/

PROMPT *** Create  table TMP_ACCM_SNAP_FIRST ***
begin 
  execute immediate '
  CREATE GLOBAL TEMPORARY TABLE BARS.TMP_ACCM_SNAP_FIRST 
   (	ACC NUMBER(38,0), 
	RNK NUMBER, 
	OST NUMBER, 
	OSTQ NUMBER, 
	DOS NUMBER, 
	DOSQ NUMBER, 
	KOS NUMBER, 
	KOSQ NUMBER
   ) ON COMMIT DELETE ROWS ';
exception when others then       
  if sqlcode=-955 then null; else raise; end if; 
end; 
/




PROMPT *** ALTER_POLICIES to TMP_ACCM_SNAP_FIRST ***
 exec bpa.alter_policies('TMP_ACCM_SNAP_FIRST');


COMMENT ON TABLE BARS.TMP_ACCM_SNAP_FIRST IS 'Временная таблица счетов для процедуры P_SAL_SNP';
COMMENT ON COLUMN BARS.TMP_ACCM_SNAP_FIRST.ACC IS '';
COMMENT ON COLUMN BARS.TMP_ACCM_SNAP_FIRST.RNK IS '';
COMMENT ON COLUMN BARS.TMP_ACCM_SNAP_FIRST.OST IS '';
COMMENT ON COLUMN BARS.TMP_ACCM_SNAP_FIRST.OSTQ IS '';
COMMENT ON COLUMN BARS.TMP_ACCM_SNAP_FIRST.DOS IS '';
COMMENT ON COLUMN BARS.TMP_ACCM_SNAP_FIRST.DOSQ IS '';
COMMENT ON COLUMN BARS.TMP_ACCM_SNAP_FIRST.KOS IS '';
COMMENT ON COLUMN BARS.TMP_ACCM_SNAP_FIRST.KOSQ IS '';




PROMPT *** Create  constraint CC_TMPACCMSNAPF_ACC_NN ***
begin   
 execute immediate '
  ALTER TABLE BARS.TMP_ACCM_SNAP_FIRST MODIFY (ACC CONSTRAINT CC_TMPACCMSNAPF_ACC_NN NOT NULL ENABLE)';
exception when others then
  if  sqlcode=-2260 or sqlcode=-2261 or sqlcode=-2264 or sqlcode=-2275 or sqlcode=-1442 then null; else raise; end if;
 end;
/




PROMPT *** Create  constraint PK_TMPACCMSNAPF ***
begin   
 execute immediate '
  ALTER TABLE BARS.TMP_ACCM_SNAP_FIRST ADD CONSTRAINT PK_TMPACCMSNAPF PRIMARY KEY (ACC) ENABLE';
exception when others then
  if  sqlcode=-2260 or sqlcode=-2261 or sqlcode=-2264 or sqlcode=-2275 or sqlcode=-1442 then null; else raise; end if;
 end;
/




PROMPT *** Create  index PK_TMPACCMSNAPF ***
begin   
 execute immediate '
  CREATE UNIQUE INDEX BARS.PK_TMPACCMSNAPF ON BARS.TMP_ACCM_SNAP_FIRST (ACC) ';
exception when others then
  if  sqlcode=-955  then null; else raise; end if;
 end;
/



PROMPT *** Create  grants  TMP_ACCM_SNAP_FIRST ***
grant DELETE,INSERT,SELECT,UPDATE                                            on TMP_ACCM_SNAP_FIRST to BARS_ACCESS_DEFROLE;
grant DELETE,INSERT,SELECT,UPDATE                                            on TMP_ACCM_SNAP_FIRST to START1;



PROMPT ===================================================================================== 
PROMPT *** End *** ========== Scripts /Sql/BARS/Table/TMP_ACCM_SNAP_FIRST.sql =========*** E
PROMPT ===================================================================================== 
