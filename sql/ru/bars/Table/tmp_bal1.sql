

PROMPT ===================================================================================== 
PROMPT *** Run *** ========== Scripts /Sql/BARS/Table/TMP_BAL1.sql =========*** Run *** ====
PROMPT ===================================================================================== 


PROMPT *** ALTER_POLICY_INFO to TMP_BAL1 ***


BEGIN 
        execute immediate  
          'begin  
               null;
           end; 
          '; 
END; 
/

PROMPT *** Create  table TMP_BAL1 ***
begin 
  execute immediate '
  CREATE GLOBAL TEMPORARY TABLE BARS.TMP_BAL1 
   (	ID NUMBER(*,0), 
	B1 NUMBER(38,0), 
	KV NUMBER(38,0), 
	NAMV VARCHAR2(35), 
	K NUMBER(38,0), 
	R NUMBER(38,0), 
	G NUMBER(38,0), 
	NBS VARCHAR2(7), 
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




PROMPT *** ALTER_POLICIES to TMP_BAL1 ***
 exec bpa.alter_policies('TMP_BAL1');


COMMENT ON TABLE BARS.TMP_BAL1 IS '';
COMMENT ON COLUMN BARS.TMP_BAL1.ID IS '';
COMMENT ON COLUMN BARS.TMP_BAL1.B1 IS '';
COMMENT ON COLUMN BARS.TMP_BAL1.KV IS '';
COMMENT ON COLUMN BARS.TMP_BAL1.NAMV IS '';
COMMENT ON COLUMN BARS.TMP_BAL1.K IS '';
COMMENT ON COLUMN BARS.TMP_BAL1.R IS '';
COMMENT ON COLUMN BARS.TMP_BAL1.G IS '';
COMMENT ON COLUMN BARS.TMP_BAL1.NBS IS '';
COMMENT ON COLUMN BARS.TMP_BAL1.DOS IS '';
COMMENT ON COLUMN BARS.TMP_BAL1.KOS IS '';
COMMENT ON COLUMN BARS.TMP_BAL1.OSTD IS '';
COMMENT ON COLUMN BARS.TMP_BAL1.OSTK IS '';
COMMENT ON COLUMN BARS.TMP_BAL1.SK IS '';
COMMENT ON COLUMN BARS.TMP_BAL1.SR IS '';
COMMENT ON COLUMN BARS.TMP_BAL1.SG IS '';
COMMENT ON COLUMN BARS.TMP_BAL1.SB1 IS '';
COMMENT ON COLUMN BARS.TMP_BAL1.DAT IS '';



PROMPT *** Create  grants  TMP_BAL1 ***
grant SELECT                                                                 on TMP_BAL1        to BARS_ACCESS_DEFROLE;
grant SELECT                                                                 on TMP_BAL1        to RPBN001;
grant DELETE,FLASHBACK,INSERT,SELECT,UPDATE                                  on TMP_BAL1        to WR_ALL_RIGHTS;



PROMPT ===================================================================================== 
PROMPT *** End *** ========== Scripts /Sql/BARS/Table/TMP_BAL1.sql =========*** End *** ====
PROMPT ===================================================================================== 
