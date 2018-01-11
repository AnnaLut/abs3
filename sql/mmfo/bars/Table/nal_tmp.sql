

PROMPT ===================================================================================== 
PROMPT *** Run *** ========== Scripts /Sql/BARS/Table/NAL_TMP.sql =========*** Run *** =====
PROMPT ===================================================================================== 


PROMPT *** ALTER_POLICY_INFO to NAL_TMP ***


BEGIN 
        execute immediate  
          'begin  
               null;
           end; 
          '; 
END; 
/

PROMPT *** Create  table NAL_TMP ***
begin 
  execute immediate '
  CREATE GLOBAL TEMPORARY TABLE BARS.NAL_TMP 
   (	ID NUMBER(38,0), 
	DD CHAR(2), 
	OKPO VARCHAR2(8), 
	YYYY NUMBER(38,0), 
	K NUMBER(38,0), 
	NMS VARCHAR2(255), 
	RR VARCHAR2(10), 
	S NUMBER(38,0), 
	ORD NUMBER(38,0), 
	NMK VARCHAR2(70), 
	ADR VARCHAR2(70), 
	TEL VARCHAR2(30), 
	RUK VARCHAR2(70), 
	BUH VARCHAR2(70)
   ) ON COMMIT PRESERVE ROWS ';
exception when others then       
  if sqlcode=-955 then null; else raise; end if; 
end; 
/




PROMPT *** ALTER_POLICIES to NAL_TMP ***
 exec bpa.alter_policies('NAL_TMP');


COMMENT ON TABLE BARS.NAL_TMP IS '';
COMMENT ON COLUMN BARS.NAL_TMP.ID IS '';
COMMENT ON COLUMN BARS.NAL_TMP.DD IS '';
COMMENT ON COLUMN BARS.NAL_TMP.OKPO IS '';
COMMENT ON COLUMN BARS.NAL_TMP.YYYY IS '';
COMMENT ON COLUMN BARS.NAL_TMP.K IS '';
COMMENT ON COLUMN BARS.NAL_TMP.NMS IS '';
COMMENT ON COLUMN BARS.NAL_TMP.RR IS '';
COMMENT ON COLUMN BARS.NAL_TMP.S IS '';
COMMENT ON COLUMN BARS.NAL_TMP.ORD IS '';
COMMENT ON COLUMN BARS.NAL_TMP.NMK IS '';
COMMENT ON COLUMN BARS.NAL_TMP.ADR IS '';
COMMENT ON COLUMN BARS.NAL_TMP.TEL IS '';
COMMENT ON COLUMN BARS.NAL_TMP.RUK IS '';
COMMENT ON COLUMN BARS.NAL_TMP.BUH IS '';



PROMPT *** Create  grants  NAL_TMP ***
grant SELECT                                                                 on NAL_TMP         to BARSREADER_ROLE;
grant INSERT,SELECT,UPDATE                                                   on NAL_TMP         to BARS_ACCESS_DEFROLE;
grant SELECT                                                                 on NAL_TMP         to BARS_DM;
grant SELECT                                                                 on NAL_TMP         to NALOG;
grant INSERT,SELECT,UPDATE                                                   on NAL_TMP         to START1;
grant SELECT                                                                 on NAL_TMP         to UPLD;
grant DELETE,FLASHBACK,INSERT,SELECT,UPDATE                                  on NAL_TMP         to WR_ALL_RIGHTS;



PROMPT *** Create SYNONYM  to NAL_TMP ***

  CREATE OR REPLACE PUBLIC SYNONYM NAL_TMP FOR BARS.NAL_TMP;


PROMPT ===================================================================================== 
PROMPT *** End *** ========== Scripts /Sql/BARS/Table/NAL_TMP.sql =========*** End *** =====
PROMPT ===================================================================================== 
