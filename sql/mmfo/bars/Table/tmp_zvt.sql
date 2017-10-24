

PROMPT ===================================================================================== 
PROMPT *** Run *** ========== Scripts /Sql/BARS/Table/TMP_ZVT.sql =========*** Run *** =====
PROMPT ===================================================================================== 


PROMPT *** ALTER_POLICY_INFO to TMP_ZVT ***


BEGIN 
        execute immediate  
          'begin  
               null;
           end; 
          '; 
END; 
/

PROMPT *** Create  table TMP_ZVT ***
begin 
  execute immediate '
  CREATE GLOBAL TEMPORARY TABLE BARS.TMP_ZVT 
   (	REF NUMBER, 
	STMT NUMBER, 
	DK NUMBER(*,0), 
	S NUMBER, 
	SQ NUMBER, 
	ACCD NUMBER, 
	ACCK NUMBER, 
	TT CHAR(3)
   ) ON COMMIT PRESERVE ROWS ';
exception when others then       
  if sqlcode=-955 then null; else raise; end if; 
end; 
/




PROMPT *** ALTER_POLICIES to TMP_ZVT ***
 exec bpa.alter_policies('TMP_ZVT');


COMMENT ON TABLE BARS.TMP_ZVT IS 'Временная табл. для накоплений по отчету Бухгалтерского свода дня';
COMMENT ON COLUMN BARS.TMP_ZVT.REF IS '';
COMMENT ON COLUMN BARS.TMP_ZVT.STMT IS '';
COMMENT ON COLUMN BARS.TMP_ZVT.DK IS '';
COMMENT ON COLUMN BARS.TMP_ZVT.S IS '';
COMMENT ON COLUMN BARS.TMP_ZVT.SQ IS '';
COMMENT ON COLUMN BARS.TMP_ZVT.ACCD IS '';
COMMENT ON COLUMN BARS.TMP_ZVT.ACCK IS '';
COMMENT ON COLUMN BARS.TMP_ZVT.TT IS '';




PROMPT *** Create  index I_TMPZVT ***
begin   
 execute immediate '
  CREATE INDEX BARS.I_TMPZVT ON BARS.TMP_ZVT (DK, REF, STMT) ';
exception when others then
  if  sqlcode=-955  then null; else raise; end if;
 end;
/



PROMPT *** Create  grants  TMP_ZVT ***
grant DELETE,INSERT,SELECT,UPDATE                                            on TMP_ZVT         to BARS_ACCESS_DEFROLE;
grant DELETE,INSERT,SELECT,UPDATE                                            on TMP_ZVT         to START1;



PROMPT ===================================================================================== 
PROMPT *** End *** ========== Scripts /Sql/BARS/Table/TMP_ZVT.sql =========*** End *** =====
PROMPT ===================================================================================== 
