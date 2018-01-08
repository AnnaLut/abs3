

PROMPT ===================================================================================== 
PROMPT *** Run *** ========== Scripts /Sql/BARS/Table/TMP_KJ.sql =========*** Run *** ======
PROMPT ===================================================================================== 


PROMPT *** ALTER_POLICY_INFO to TMP_KJ ***


BEGIN 
        execute immediate  
          'begin  
               null;
           end; 
          '; 
END; 
/

PROMPT *** Create  table TMP_KJ ***
begin 
  execute immediate '
  CREATE GLOBAL TEMPORARY TABLE BARS.TMP_KJ 
   (	ACC NUMBER(*,0), 
	ID NUMBER(*,0), 
	DK NUMBER(*,0), 
	UD NUMBER(*,0), 
	KAS VARCHAR2(90), 
	ND VARCHAR2(10), 
	NLS VARCHAR2(15), 
	S NUMBER(*,0), 
	SK NUMBER(*,0), 
	FDAT DATE, 
	REF NUMBER(*,0), 
	TT CHAR(3)
   ) ON COMMIT PRESERVE ROWS ';
exception when others then       
  if sqlcode=-955 then null; else raise; end if; 
end; 
/




PROMPT *** ALTER_POLICIES to TMP_KJ ***
 exec bpa.alter_policies('TMP_KJ');


COMMENT ON TABLE BARS.TMP_KJ IS '';
COMMENT ON COLUMN BARS.TMP_KJ.ACC IS '';
COMMENT ON COLUMN BARS.TMP_KJ.ID IS '';
COMMENT ON COLUMN BARS.TMP_KJ.DK IS '';
COMMENT ON COLUMN BARS.TMP_KJ.UD IS '';
COMMENT ON COLUMN BARS.TMP_KJ.KAS IS '';
COMMENT ON COLUMN BARS.TMP_KJ.ND IS '';
COMMENT ON COLUMN BARS.TMP_KJ.NLS IS '';
COMMENT ON COLUMN BARS.TMP_KJ.S IS '';
COMMENT ON COLUMN BARS.TMP_KJ.SK IS '';
COMMENT ON COLUMN BARS.TMP_KJ.FDAT IS '';
COMMENT ON COLUMN BARS.TMP_KJ.REF IS '';
COMMENT ON COLUMN BARS.TMP_KJ.TT IS '';



PROMPT *** Create  grants  TMP_KJ ***
grant SELECT                                                                 on TMP_KJ          to BARSREADER_ROLE;
grant SELECT                                                                 on TMP_KJ          to BARS_ACCESS_DEFROLE;
grant SELECT                                                                 on TMP_KJ          to BARS_DM;
grant SELECT                                                                 on TMP_KJ          to RPBN001;
grant SELECT                                                                 on TMP_KJ          to UPLD;
grant DELETE,FLASHBACK,INSERT,SELECT,UPDATE                                  on TMP_KJ          to WR_ALL_RIGHTS;



PROMPT *** Create SYNONYM  to TMP_KJ ***

  CREATE OR REPLACE PUBLIC SYNONYM TMP_KJ FOR BARS.TMP_KJ;


PROMPT ===================================================================================== 
PROMPT *** End *** ========== Scripts /Sql/BARS/Table/TMP_KJ.sql =========*** End *** ======
PROMPT ===================================================================================== 
