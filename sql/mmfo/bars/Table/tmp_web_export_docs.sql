

PROMPT ===================================================================================== 
PROMPT *** Run *** ========== Scripts /Sql/BARS/Table/TMP_WEB_EXPORT_DOCS.sql =========*** R
PROMPT ===================================================================================== 


PROMPT *** ALTER_POLICY_INFO to TMP_WEB_EXPORT_DOCS ***


BEGIN 
        execute immediate  
          'begin  
               null;
           end; 
          '; 
END; 
/

PROMPT *** Create  table TMP_WEB_EXPORT_DOCS ***
begin 
  execute immediate '
  CREATE GLOBAL TEMPORARY TABLE BARS.TMP_WEB_EXPORT_DOCS 
   (	NPP NUMBER, 
	REF NUMBER, 
	STMT NUMBER, 
	MFOA VARCHAR2(12), 
	NLSA VARCHAR2(15), 
	MFOB VARCHAR2(12), 
	NLSB VARCHAR2(15), 
	DK NUMBER(38,0), 
	S NUMBER(24,0), 
	VOB NUMBER(38,0), 
	ND VARCHAR2(10), 
	KV NUMBER(38,0), 
	DATD DATE, 
	DATP DATE, 
	NAM_A VARCHAR2(38), 
	NAM_B VARCHAR2(38), 
	NAZN VARCHAR2(160), 
	D_REC VARCHAR2(60), 
	NAZNS VARCHAR2(2), 
	ID_A VARCHAR2(14), 
	ID_B VARCHAR2(14), 
	REF_A VARCHAR2(9), 
	ID_O VARCHAR2(6), 
	BIS NUMBER(38,0)
   ) ON COMMIT DELETE ROWS ';
exception when others then       
  if sqlcode=-955 then null; else raise; end if; 
end; 
/




PROMPT *** ALTER_POLICIES to TMP_WEB_EXPORT_DOCS ***
 exec bpa.alter_policies('TMP_WEB_EXPORT_DOCS');


COMMENT ON TABLE BARS.TMP_WEB_EXPORT_DOCS IS '';
COMMENT ON COLUMN BARS.TMP_WEB_EXPORT_DOCS.NPP IS '';
COMMENT ON COLUMN BARS.TMP_WEB_EXPORT_DOCS.REF IS '';
COMMENT ON COLUMN BARS.TMP_WEB_EXPORT_DOCS.STMT IS '';
COMMENT ON COLUMN BARS.TMP_WEB_EXPORT_DOCS.MFOA IS '';
COMMENT ON COLUMN BARS.TMP_WEB_EXPORT_DOCS.NLSA IS '';
COMMENT ON COLUMN BARS.TMP_WEB_EXPORT_DOCS.MFOB IS '';
COMMENT ON COLUMN BARS.TMP_WEB_EXPORT_DOCS.NLSB IS '';
COMMENT ON COLUMN BARS.TMP_WEB_EXPORT_DOCS.DK IS '';
COMMENT ON COLUMN BARS.TMP_WEB_EXPORT_DOCS.S IS '';
COMMENT ON COLUMN BARS.TMP_WEB_EXPORT_DOCS.VOB IS '';
COMMENT ON COLUMN BARS.TMP_WEB_EXPORT_DOCS.ND IS '';
COMMENT ON COLUMN BARS.TMP_WEB_EXPORT_DOCS.KV IS '';
COMMENT ON COLUMN BARS.TMP_WEB_EXPORT_DOCS.DATD IS '';
COMMENT ON COLUMN BARS.TMP_WEB_EXPORT_DOCS.DATP IS '';
COMMENT ON COLUMN BARS.TMP_WEB_EXPORT_DOCS.NAM_A IS '';
COMMENT ON COLUMN BARS.TMP_WEB_EXPORT_DOCS.NAM_B IS '';
COMMENT ON COLUMN BARS.TMP_WEB_EXPORT_DOCS.NAZN IS '';
COMMENT ON COLUMN BARS.TMP_WEB_EXPORT_DOCS.D_REC IS '';
COMMENT ON COLUMN BARS.TMP_WEB_EXPORT_DOCS.NAZNS IS '';
COMMENT ON COLUMN BARS.TMP_WEB_EXPORT_DOCS.ID_A IS '';
COMMENT ON COLUMN BARS.TMP_WEB_EXPORT_DOCS.ID_B IS '';
COMMENT ON COLUMN BARS.TMP_WEB_EXPORT_DOCS.REF_A IS '';
COMMENT ON COLUMN BARS.TMP_WEB_EXPORT_DOCS.ID_O IS '';
COMMENT ON COLUMN BARS.TMP_WEB_EXPORT_DOCS.BIS IS '';




PROMPT *** Create  constraint XPK_TMP_WEB_EXPORT_DOCS ***
begin   
 execute immediate '
  ALTER TABLE BARS.TMP_WEB_EXPORT_DOCS ADD CONSTRAINT XPK_TMP_WEB_EXPORT_DOCS PRIMARY KEY (REF, STMT, BIS) ENABLE';
exception when others then
  if  sqlcode=-2260 or sqlcode=-2261 or sqlcode=-2264 or sqlcode=-2275 or sqlcode=-1442 then null; else raise; end if;
 end;
/




PROMPT *** Create  index XPK_TMP_WEB_EXPORT_DOCS ***
begin   
 execute immediate '
  CREATE UNIQUE INDEX BARS.XPK_TMP_WEB_EXPORT_DOCS ON BARS.TMP_WEB_EXPORT_DOCS (REF, STMT, BIS) ';
exception when others then
  if  sqlcode=-955  then null; else raise; end if;
 end;
/



PROMPT *** Create  grants  TMP_WEB_EXPORT_DOCS ***
grant SELECT                                                                 on TMP_WEB_EXPORT_DOCS to BARSREADER_ROLE;
grant SELECT                                                                 on TMP_WEB_EXPORT_DOCS to BARS_ACCESS_DEFROLE;
grant SELECT                                                                 on TMP_WEB_EXPORT_DOCS to UPLD;
grant DELETE,FLASHBACK,INSERT,SELECT,UPDATE                                  on TMP_WEB_EXPORT_DOCS to WR_ALL_RIGHTS;
grant SELECT                                                                 on TMP_WEB_EXPORT_DOCS to WR_IMPEXP;



PROMPT *** Create SYNONYM  to TMP_WEB_EXPORT_DOCS ***

  CREATE OR REPLACE PUBLIC SYNONYM TMP_WEB_EXPORT_DOCS FOR BARS.TMP_WEB_EXPORT_DOCS;


PROMPT ===================================================================================== 
PROMPT *** End *** ========== Scripts /Sql/BARS/Table/TMP_WEB_EXPORT_DOCS.sql =========*** E
PROMPT ===================================================================================== 
