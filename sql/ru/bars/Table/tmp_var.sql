

PROMPT ===================================================================================== 
PROMPT *** Run *** ========== Scripts /Sql/BARS/Table/TMP_VAR.sql =========*** Run *** =====
PROMPT ===================================================================================== 


PROMPT *** ALTER_POLICY_INFO to TMP_VAR ***


BEGIN 
        execute immediate  
          'begin  
               null;
           end; 
          '; 
END; 
/

PROMPT *** Create  table TMP_VAR ***
begin 
  execute immediate '
  CREATE GLOBAL TEMPORARY TABLE BARS.TMP_VAR 
   (	KV NUMBER(*,0), 
	BSUM NUMBER(*,0), 
	RATE_O NUMBER(9,4), 
	LCV CHAR(3), 
	NAME VARCHAR2(35), 
	NLS VARCHAR2(15), 
	OSTC NUMBER, 
	OSTQ NUMBER, 
	VAR_95 NUMBER, 
	VAR_99 NUMBER, 
	VOL NUMBER
   ) ON COMMIT DELETE ROWS ';
exception when others then       
  if sqlcode=-955 then null; else raise; end if; 
end; 
/




PROMPT *** ALTER_POLICIES to TMP_VAR ***
 exec bpa.alter_policies('TMP_VAR');


COMMENT ON TABLE BARS.TMP_VAR IS '';
COMMENT ON COLUMN BARS.TMP_VAR.KV IS '';
COMMENT ON COLUMN BARS.TMP_VAR.BSUM IS '';
COMMENT ON COLUMN BARS.TMP_VAR.RATE_O IS '';
COMMENT ON COLUMN BARS.TMP_VAR.LCV IS '';
COMMENT ON COLUMN BARS.TMP_VAR.NAME IS '';
COMMENT ON COLUMN BARS.TMP_VAR.NLS IS '';
COMMENT ON COLUMN BARS.TMP_VAR.OSTC IS '';
COMMENT ON COLUMN BARS.TMP_VAR.OSTQ IS '';
COMMENT ON COLUMN BARS.TMP_VAR.VAR_95 IS '';
COMMENT ON COLUMN BARS.TMP_VAR.VAR_99 IS '';
COMMENT ON COLUMN BARS.TMP_VAR.VOL IS '';



PROMPT *** Create  grants  TMP_VAR ***
grant SELECT                                                                 on TMP_VAR         to BARS_ACCESS_DEFROLE;
grant SELECT                                                                 on TMP_VAR         to RPBN001;
grant DELETE,FLASHBACK,INSERT,SELECT,UPDATE                                  on TMP_VAR         to WR_ALL_RIGHTS;



PROMPT ===================================================================================== 
PROMPT *** End *** ========== Scripts /Sql/BARS/Table/TMP_VAR.sql =========*** End *** =====
PROMPT ===================================================================================== 
