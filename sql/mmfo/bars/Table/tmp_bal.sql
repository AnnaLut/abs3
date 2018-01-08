

PROMPT ===================================================================================== 
PROMPT *** Run *** ========== Scripts /Sql/BARS/Table/TMP_BAL.sql =========*** Run *** =====
PROMPT ===================================================================================== 


PROMPT *** ALTER_POLICY_INFO to TMP_BAL ***


BEGIN 
        execute immediate  
          'begin  
               null;
           end; 
          '; 
END; 
/

PROMPT *** Create  table TMP_BAL ***
begin 
  execute immediate '
  CREATE GLOBAL TEMPORARY TABLE BARS.TMP_BAL 
   (	ID NUMBER(*,0), 
	B1 NUMBER(38,0), 
	KV NUMBER(38,0), 
	NAMV VARCHAR2(35), 
	K NUMBER(38,0), 
	R NUMBER(38,0), 
	G NUMBER(38,0), 
	NBS VARCHAR2(10), 
	DOS NUMBER(38,0), 
	KOS NUMBER(38,0), 
	OSTD NUMBER(38,0), 
	OSTK NUMBER(38,0), 
	SK VARCHAR2(90), 
	SR VARCHAR2(90), 
	SG VARCHAR2(90), 
	SB1 VARCHAR2(90), 
	DAT VARCHAR2(12)
   ) ON COMMIT PRESERVE ROWS ';
exception when others then       
  if sqlcode=-955 then null; else raise; end if; 
end; 
/




PROMPT *** ALTER_POLICIES to TMP_BAL ***
 exec bpa.alter_policies('TMP_BAL');


COMMENT ON TABLE BARS.TMP_BAL IS '';
COMMENT ON COLUMN BARS.TMP_BAL.ID IS '';
COMMENT ON COLUMN BARS.TMP_BAL.B1 IS '';
COMMENT ON COLUMN BARS.TMP_BAL.KV IS '';
COMMENT ON COLUMN BARS.TMP_BAL.NAMV IS '';
COMMENT ON COLUMN BARS.TMP_BAL.K IS '';
COMMENT ON COLUMN BARS.TMP_BAL.R IS '';
COMMENT ON COLUMN BARS.TMP_BAL.G IS '';
COMMENT ON COLUMN BARS.TMP_BAL.NBS IS '';
COMMENT ON COLUMN BARS.TMP_BAL.DOS IS '';
COMMENT ON COLUMN BARS.TMP_BAL.KOS IS '';
COMMENT ON COLUMN BARS.TMP_BAL.OSTD IS '';
COMMENT ON COLUMN BARS.TMP_BAL.OSTK IS '';
COMMENT ON COLUMN BARS.TMP_BAL.SK IS '';
COMMENT ON COLUMN BARS.TMP_BAL.SR IS '';
COMMENT ON COLUMN BARS.TMP_BAL.SG IS '';
COMMENT ON COLUMN BARS.TMP_BAL.SB1 IS '';
COMMENT ON COLUMN BARS.TMP_BAL.DAT IS '';



PROMPT *** Create  grants  TMP_BAL ***
grant SELECT                                                                 on TMP_BAL         to BARSREADER_ROLE;
grant SELECT                                                                 on TMP_BAL         to BARS_ACCESS_DEFROLE;
grant SELECT                                                                 on TMP_BAL         to RPBN001;
grant SELECT                                                                 on TMP_BAL         to UPLD;
grant DELETE,FLASHBACK,INSERT,SELECT,UPDATE                                  on TMP_BAL         to WR_ALL_RIGHTS;



PROMPT *** Create SYNONYM  to TMP_BAL ***

  CREATE OR REPLACE PUBLIC SYNONYM TMP_BAL FOR BARS.TMP_BAL;


PROMPT ===================================================================================== 
PROMPT *** End *** ========== Scripts /Sql/BARS/Table/TMP_BAL.sql =========*** End *** =====
PROMPT ===================================================================================== 
