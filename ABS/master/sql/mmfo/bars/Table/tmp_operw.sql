

PROMPT ===================================================================================== 
PROMPT *** Run *** ========== Scripts /Sql/BARS/Table/TMP_OPERW.sql =========*** Run *** ===
PROMPT ===================================================================================== 


PROMPT *** ALTER_POLICY_INFO to TMP_OPERW ***


BEGIN 
        execute immediate  
          'begin  
               null;
           end; 
          '; 
END; 
/

PROMPT *** Create  table TMP_OPERW ***
begin 
  execute immediate '
  CREATE GLOBAL TEMPORARY TABLE BARS.TMP_OPERW 
   (	TT CHAR(3), 
	TAG CHAR(5), 
	NOM NUMBER(*,0), 
	VALUE VARCHAR2(200), 
	ORD NUMBER(*,0), 
	BROWSER VARCHAR2(250), 
	DVAL VARCHAR2(100), 
	OPT CHAR(1)
   ) ON COMMIT PRESERVE ROWS ';
exception when others then       
  if sqlcode=-955 then null; else raise; end if; 
end; 
/




PROMPT *** ALTER_POLICIES to TMP_OPERW ***
 exec bpa.alter_policies('TMP_OPERW');


COMMENT ON TABLE BARS.TMP_OPERW IS '';
COMMENT ON COLUMN BARS.TMP_OPERW.TT IS '';
COMMENT ON COLUMN BARS.TMP_OPERW.TAG IS '';
COMMENT ON COLUMN BARS.TMP_OPERW.NOM IS '';
COMMENT ON COLUMN BARS.TMP_OPERW.VALUE IS '';
COMMENT ON COLUMN BARS.TMP_OPERW.ORD IS '';
COMMENT ON COLUMN BARS.TMP_OPERW.BROWSER IS '';
COMMENT ON COLUMN BARS.TMP_OPERW.DVAL IS '';
COMMENT ON COLUMN BARS.TMP_OPERW.OPT IS '';



PROMPT *** Create  grants  TMP_OPERW ***
grant SELECT                                                                 on TMP_OPERW       to BARSREADER_ROLE;
grant DELETE,INSERT,SELECT,UPDATE                                            on TMP_OPERW       to BARS_ACCESS_DEFROLE;
grant DELETE,INSERT,SELECT,UPDATE                                            on TMP_OPERW       to PYOD001;
grant DELETE,INSERT,SELECT,UPDATE                                            on TMP_OPERW       to R_KP;
grant SELECT                                                                 on TMP_OPERW       to START1;
grant SELECT                                                                 on TMP_OPERW       to UPLD;
grant DELETE,FLASHBACK,INSERT,SELECT,UPDATE                                  on TMP_OPERW       to WR_ALL_RIGHTS;



PROMPT *** Create SYNONYM  to TMP_OPERW ***

  CREATE OR REPLACE PUBLIC SYNONYM PROT_IRR FOR BARS.TMP_OPERW;


PROMPT ===================================================================================== 
PROMPT *** End *** ========== Scripts /Sql/BARS/Table/TMP_OPERW.sql =========*** End *** ===
PROMPT ===================================================================================== 
