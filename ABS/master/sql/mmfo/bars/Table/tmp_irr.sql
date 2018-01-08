

PROMPT ===================================================================================== 
PROMPT *** Run *** ========== Scripts /Sql/BARS/Table/TMP_IRR.sql =========*** Run *** =====
PROMPT ===================================================================================== 


PROMPT *** ALTER_POLICY_INFO to TMP_IRR ***


BEGIN 
        execute immediate  
          'begin  
               null;
           end; 
          '; 
END; 
/

PROMPT *** Create  table TMP_IRR ***
begin 
  execute immediate '
  CREATE GLOBAL TEMPORARY TABLE BARS.TMP_IRR 
   (	D DATE, 
	N NUMBER(38,0), 
	S NUMBER
   ) ON COMMIT PRESERVE ROWS ';
exception when others then       
  if sqlcode=-955 then null; else raise; end if; 
end; 
/




PROMPT *** ALTER_POLICIES to TMP_IRR ***
 exec bpa.alter_policies('TMP_IRR');


COMMENT ON TABLE BARS.TMP_IRR IS '';
COMMENT ON COLUMN BARS.TMP_IRR.D IS '';
COMMENT ON COLUMN BARS.TMP_IRR.N IS '';
COMMENT ON COLUMN BARS.TMP_IRR.S IS '';



PROMPT *** Create  grants  TMP_IRR ***
grant SELECT                                                                 on TMP_IRR         to BARSREADER_ROLE;
grant DELETE,INSERT,SELECT,UPDATE                                            on TMP_IRR         to BARS_ACCESS_DEFROLE;
grant DELETE,INSERT,SELECT,UPDATE                                            on TMP_IRR         to CP_ROLE;
grant DELETE,INSERT,SELECT,UPDATE                                            on TMP_IRR         to FOREX;
grant DELETE,INSERT,SELECT,UPDATE                                            on TMP_IRR         to RCC_DEAL;
grant SELECT                                                                 on TMP_IRR         to UPLD;



PROMPT *** Create SYNONYM  to TMP_IRR ***

  CREATE OR REPLACE PUBLIC SYNONYM TMP_IRR FOR BARS.TMP_IRR;


PROMPT ===================================================================================== 
PROMPT *** End *** ========== Scripts /Sql/BARS/Table/TMP_IRR.sql =========*** End *** =====
PROMPT ===================================================================================== 
