

PROMPT ===================================================================================== 
PROMPT *** Run *** ========== Scripts /Sql/BARS/Table/TMP_ARJK_OPER.sql =========*** Run ***
PROMPT ===================================================================================== 


PROMPT *** ALTER_POLICY_INFO to TMP_ARJK_OPER ***


BEGIN 
        execute immediate  
          'begin  
               null;
           end; 
          '; 
END; 
/

PROMPT *** Create  table TMP_ARJK_OPER ***
begin 
  execute immediate '
  CREATE GLOBAL TEMPORARY TABLE BARS.TMP_ARJK_OPER 
   (	REF NUMBER, 
	VDAT DATE, 
	KV NUMBER(*,0), 
	NLSA VARCHAR2(15), 
	NLSB VARCHAR2(15), 
	NAZN VARCHAR2(160), 
	S NUMBER, 
	S2 NUMBER, 
	NAM_B VARCHAR2(38), 
	ND VARCHAR2(10), 
	BBBBOO VARCHAR2(40), 
	NND VARCHAR2(40), 
	DIN VARCHAR2(40)
   ) ON COMMIT PRESERVE ROWS ';
exception when others then       
  if sqlcode=-955 then null; else raise; end if; 
end; 
/




PROMPT *** ALTER_POLICIES to TMP_ARJK_OPER ***
 exec bpa.alter_policies('TMP_ARJK_OPER');


COMMENT ON TABLE BARS.TMP_ARJK_OPER IS '';
COMMENT ON COLUMN BARS.TMP_ARJK_OPER.REF IS '';
COMMENT ON COLUMN BARS.TMP_ARJK_OPER.VDAT IS '';
COMMENT ON COLUMN BARS.TMP_ARJK_OPER.KV IS '';
COMMENT ON COLUMN BARS.TMP_ARJK_OPER.NLSA IS '';
COMMENT ON COLUMN BARS.TMP_ARJK_OPER.NLSB IS '';
COMMENT ON COLUMN BARS.TMP_ARJK_OPER.NAZN IS '';
COMMENT ON COLUMN BARS.TMP_ARJK_OPER.S IS '';
COMMENT ON COLUMN BARS.TMP_ARJK_OPER.S2 IS '';
COMMENT ON COLUMN BARS.TMP_ARJK_OPER.NAM_B IS '';
COMMENT ON COLUMN BARS.TMP_ARJK_OPER.ND IS '';
COMMENT ON COLUMN BARS.TMP_ARJK_OPER.BBBBOO IS '';
COMMENT ON COLUMN BARS.TMP_ARJK_OPER.NND IS '';
COMMENT ON COLUMN BARS.TMP_ARJK_OPER.DIN IS '';



PROMPT *** Create  grants  TMP_ARJK_OPER ***
grant SELECT                                                                 on TMP_ARJK_OPER   to BARSREADER_ROLE;
grant DELETE,INSERT,SELECT,UPDATE                                            on TMP_ARJK_OPER   to BARS_ACCESS_DEFROLE;
grant DELETE,INSERT,SELECT,UPDATE                                            on TMP_ARJK_OPER   to START1;
grant SELECT                                                                 on TMP_ARJK_OPER   to UPLD;



PROMPT *** Create SYNONYM  to TMP_ARJK_OPER ***

  CREATE OR REPLACE PUBLIC SYNONYM ADD_PL_INS FOR BARS.TMP_ARJK_OPER;


PROMPT ===================================================================================== 
PROMPT *** End *** ========== Scripts /Sql/BARS/Table/TMP_ARJK_OPER.sql =========*** End ***
PROMPT ===================================================================================== 
