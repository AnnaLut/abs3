

PROMPT ===================================================================================== 
PROMPT *** Run *** ========== Scripts /Sql/BARS/Table/TMP_REZ0.sql =========*** Run *** ====
PROMPT ===================================================================================== 


PROMPT *** ALTER_POLICY_INFO to TMP_REZ0 ***


BEGIN 
        execute immediate  
          'begin  
               null;
           end; 
          '; 
END; 
/

PROMPT *** Create  table TMP_REZ0 ***
begin 
  execute immediate '
  CREATE GLOBAL TEMPORARY TABLE BARS.TMP_REZ0 
   (	ID NUMBER(*,0), 
	NAME VARCHAR2(60), 
	PR_NV NUMBER(5,2), 
	PR_IV NUMBER(5,2), 
	NAM1 VARCHAR2(40), 
	OST0 NUMBER, 
	OST1 NUMBER, 
	OST0F NUMBER, 
	OST1F NUMBER
   ) ON COMMIT PRESERVE ROWS ';
exception when others then       
  if sqlcode=-955 then null; else raise; end if; 
end; 
/




PROMPT *** ALTER_POLICIES to TMP_REZ0 ***
 exec bpa.alter_policies('TMP_REZ0');


COMMENT ON TABLE BARS.TMP_REZ0 IS '';
COMMENT ON COLUMN BARS.TMP_REZ0.ID IS '';
COMMENT ON COLUMN BARS.TMP_REZ0.NAME IS '';
COMMENT ON COLUMN BARS.TMP_REZ0.PR_NV IS '';
COMMENT ON COLUMN BARS.TMP_REZ0.PR_IV IS '';
COMMENT ON COLUMN BARS.TMP_REZ0.NAM1 IS '';
COMMENT ON COLUMN BARS.TMP_REZ0.OST0 IS '';
COMMENT ON COLUMN BARS.TMP_REZ0.OST1 IS '';
COMMENT ON COLUMN BARS.TMP_REZ0.OST0F IS '';
COMMENT ON COLUMN BARS.TMP_REZ0.OST1F IS '';



PROMPT *** Create  grants  TMP_REZ0 ***
grant SELECT                                                                 on TMP_REZ0        to BARS_ACCESS_DEFROLE;
grant SELECT                                                                 on TMP_REZ0        to SALGL;
grant DELETE,FLASHBACK,INSERT,SELECT,UPDATE                                  on TMP_REZ0        to WR_ALL_RIGHTS;



PROMPT ===================================================================================== 
PROMPT *** End *** ========== Scripts /Sql/BARS/Table/TMP_REZ0.sql =========*** End *** ====
PROMPT ===================================================================================== 
