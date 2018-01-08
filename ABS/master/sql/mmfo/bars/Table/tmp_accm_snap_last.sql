

PROMPT ===================================================================================== 
PROMPT *** Run *** ========== Scripts /Sql/BARS/Table/TMP_ACCM_SNAP_LAST.sql =========*** Ru
PROMPT ===================================================================================== 


PROMPT *** ALTER_POLICY_INFO to TMP_ACCM_SNAP_LAST ***


BEGIN 
        execute immediate  
          'begin  
               null;
           end; 
          '; 
END; 
/

PROMPT *** Create  table TMP_ACCM_SNAP_LAST ***
begin 
  execute immediate '
  CREATE GLOBAL TEMPORARY TABLE BARS.TMP_ACCM_SNAP_LAST 
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




PROMPT *** ALTER_POLICIES to TMP_ACCM_SNAP_LAST ***
 exec bpa.alter_policies('TMP_ACCM_SNAP_LAST');


COMMENT ON TABLE BARS.TMP_ACCM_SNAP_LAST IS 'Временная таблица счетов для процедуры P_SAL_SNP';
COMMENT ON COLUMN BARS.TMP_ACCM_SNAP_LAST.ACC IS '';
COMMENT ON COLUMN BARS.TMP_ACCM_SNAP_LAST.RNK IS '';
COMMENT ON COLUMN BARS.TMP_ACCM_SNAP_LAST.OST IS '';
COMMENT ON COLUMN BARS.TMP_ACCM_SNAP_LAST.OSTQ IS '';
COMMENT ON COLUMN BARS.TMP_ACCM_SNAP_LAST.DOS IS '';
COMMENT ON COLUMN BARS.TMP_ACCM_SNAP_LAST.DOSQ IS '';
COMMENT ON COLUMN BARS.TMP_ACCM_SNAP_LAST.KOS IS '';
COMMENT ON COLUMN BARS.TMP_ACCM_SNAP_LAST.KOSQ IS '';




PROMPT *** Create  constraint PK_TMPACCMSNAPL ***
begin   
 execute immediate '
  ALTER TABLE BARS.TMP_ACCM_SNAP_LAST ADD CONSTRAINT PK_TMPACCMSNAPL PRIMARY KEY (ACC) ENABLE';
exception when others then
  if  sqlcode=-2260 or sqlcode=-2261 or sqlcode=-2264 or sqlcode=-2275 or sqlcode=-1442 then null; else raise; end if;
 end;
/




PROMPT *** Create  constraint CC_TMPACCMSNAPL_ACC_NN ***
begin   
 execute immediate '
  ALTER TABLE BARS.TMP_ACCM_SNAP_LAST MODIFY (ACC CONSTRAINT CC_TMPACCMSNAPL_ACC_NN NOT NULL ENABLE)';
exception when others then
  if  sqlcode=-2260 or sqlcode=-2261 or sqlcode=-2264 or sqlcode=-2275 or sqlcode=-1442 then null; else raise; end if;
 end;
/




PROMPT *** Create  index PK_TMPACCMSNAPL ***
begin   
 execute immediate '
  CREATE UNIQUE INDEX BARS.PK_TMPACCMSNAPL ON BARS.TMP_ACCM_SNAP_LAST (ACC) ';
exception when others then
  if  sqlcode=-955  then null; else raise; end if;
 end;
/



PROMPT *** Create  grants  TMP_ACCM_SNAP_LAST ***
grant SELECT                                                                 on TMP_ACCM_SNAP_LAST to BARSREADER_ROLE;
grant DELETE,INSERT,SELECT,UPDATE                                            on TMP_ACCM_SNAP_LAST to BARS_ACCESS_DEFROLE;
grant DELETE,INSERT,SELECT,UPDATE                                            on TMP_ACCM_SNAP_LAST to START1;
grant SELECT                                                                 on TMP_ACCM_SNAP_LAST to UPLD;



PROMPT ===================================================================================== 
PROMPT *** End *** ========== Scripts /Sql/BARS/Table/TMP_ACCM_SNAP_LAST.sql =========*** En
PROMPT ===================================================================================== 
