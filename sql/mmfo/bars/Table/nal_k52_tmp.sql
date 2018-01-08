

PROMPT ===================================================================================== 
PROMPT *** Run *** ========== Scripts /Sql/BARS/Table/NAL_K52_TMP.sql =========*** Run *** =
PROMPT ===================================================================================== 


PROMPT *** ALTER_POLICY_INFO to NAL_K52_TMP ***


BEGIN 
        execute immediate  
          'begin  
               null;
           end; 
          '; 
END; 
/

PROMPT *** Create  table NAL_K52_TMP ***
begin 
  execute immediate '
  CREATE GLOBAL TEMPORARY TABLE BARS.NAL_K52_TMP 
   (	ID NUMBER(38,0), 
	RNK NUMBER(38,0), 
	NMK VARCHAR2(100), 
	NOM VARCHAR2(10), 
	YYYY NUMBER(38,0), 
	K NUMBER(38,0), 
	K523 NUMBER(38,0), 
	K524 NUMBER(38,0), 
	K525 NUMBER(38,0), 
	K526 NUMBER(38,0), 
	K527 NUMBER(38,0), 
	R06 NUMBER, 
	R07 NUMBER, 
	RUK VARCHAR2(70), 
	BUH VARCHAR2(70), 
	ORD NUMBER(38,0), 
	R5 NUMBER(38,2), 
	R6 NUMBER(38,12), 
	R7 NUMBER(38,2)
   ) ON COMMIT PRESERVE ROWS ';
exception when others then       
  if sqlcode=-955 then null; else raise; end if; 
end; 
/




PROMPT *** ALTER_POLICIES to NAL_K52_TMP ***
 exec bpa.alter_policies('NAL_K52_TMP');


COMMENT ON TABLE BARS.NAL_K52_TMP IS '';
COMMENT ON COLUMN BARS.NAL_K52_TMP.ID IS '';
COMMENT ON COLUMN BARS.NAL_K52_TMP.RNK IS '';
COMMENT ON COLUMN BARS.NAL_K52_TMP.NMK IS '';
COMMENT ON COLUMN BARS.NAL_K52_TMP.NOM IS '';
COMMENT ON COLUMN BARS.NAL_K52_TMP.YYYY IS '';
COMMENT ON COLUMN BARS.NAL_K52_TMP.K IS '';
COMMENT ON COLUMN BARS.NAL_K52_TMP.K523 IS '';
COMMENT ON COLUMN BARS.NAL_K52_TMP.K524 IS '';
COMMENT ON COLUMN BARS.NAL_K52_TMP.K525 IS '';
COMMENT ON COLUMN BARS.NAL_K52_TMP.K526 IS '';
COMMENT ON COLUMN BARS.NAL_K52_TMP.K527 IS '';
COMMENT ON COLUMN BARS.NAL_K52_TMP.R06 IS '';
COMMENT ON COLUMN BARS.NAL_K52_TMP.R07 IS '';
COMMENT ON COLUMN BARS.NAL_K52_TMP.RUK IS '';
COMMENT ON COLUMN BARS.NAL_K52_TMP.BUH IS '';
COMMENT ON COLUMN BARS.NAL_K52_TMP.ORD IS '';
COMMENT ON COLUMN BARS.NAL_K52_TMP.R5 IS '';
COMMENT ON COLUMN BARS.NAL_K52_TMP.R6 IS '';
COMMENT ON COLUMN BARS.NAL_K52_TMP.R7 IS '';



PROMPT *** Create  grants  NAL_K52_TMP ***
grant DELETE,INSERT,SELECT,UPDATE                                            on NAL_K52_TMP     to BARS_ACCESS_DEFROLE;
grant DELETE,INSERT,SELECT,UPDATE                                            on NAL_K52_TMP     to NALOG;
grant DELETE,FLASHBACK,INSERT,SELECT,UPDATE                                  on NAL_K52_TMP     to WR_ALL_RIGHTS;



PROMPT *** Create SYNONYM  to NAL_K52_TMP ***

  CREATE OR REPLACE PUBLIC SYNONYM NAL_K52_TMP FOR BARS.NAL_K52_TMP;


PROMPT ===================================================================================== 
PROMPT *** End *** ========== Scripts /Sql/BARS/Table/NAL_K52_TMP.sql =========*** End *** =
PROMPT ===================================================================================== 
