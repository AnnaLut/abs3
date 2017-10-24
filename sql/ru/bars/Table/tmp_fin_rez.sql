

PROMPT ===================================================================================== 
PROMPT *** Run *** ========== Scripts /Sql/BARS/Table/TMP_FIN_REZ.sql =========*** Run *** =
PROMPT ===================================================================================== 


PROMPT *** ALTER_POLICY_INFO to TMP_FIN_REZ ***


BEGIN 
        execute immediate  
          'begin  
               null;
           end; 
          '; 
END; 
/

PROMPT *** Create  table TMP_FIN_REZ ***
begin 
  execute immediate '
  CREATE GLOBAL TEMPORARY TABLE BARS.TMP_FIN_REZ 
   (	NBS CHAR(4), 
	OB22 CHAR(2), 
	NLS CHAR(6), 
	KV NUMBER(*,0), 
	BRANCH VARCHAR2(30), 
	N1 NUMBER, 
	N2 NUMBER, 
	N3 NUMBER, 
	DAT1 DATE, 
	DAT2 DATE
   ) ON COMMIT PRESERVE ROWS ';
exception when others then       
  if sqlcode=-955 then null; else raise; end if; 
end; 
/




PROMPT *** ALTER_POLICIES to TMP_FIN_REZ ***
 exec bpa.alter_policies('TMP_FIN_REZ');


COMMENT ON TABLE BARS.TMP_FIN_REZ IS '';
COMMENT ON COLUMN BARS.TMP_FIN_REZ.NBS IS '';
COMMENT ON COLUMN BARS.TMP_FIN_REZ.OB22 IS '';
COMMENT ON COLUMN BARS.TMP_FIN_REZ.NLS IS '';
COMMENT ON COLUMN BARS.TMP_FIN_REZ.KV IS '';
COMMENT ON COLUMN BARS.TMP_FIN_REZ.BRANCH IS '';
COMMENT ON COLUMN BARS.TMP_FIN_REZ.N1 IS '';
COMMENT ON COLUMN BARS.TMP_FIN_REZ.N2 IS '';
COMMENT ON COLUMN BARS.TMP_FIN_REZ.N3 IS '';
COMMENT ON COLUMN BARS.TMP_FIN_REZ.DAT1 IS '';
COMMENT ON COLUMN BARS.TMP_FIN_REZ.DAT2 IS '';



PROMPT *** Create  grants  TMP_FIN_REZ ***
grant SELECT                                                                 on TMP_FIN_REZ     to BARS_ACCESS_DEFROLE;
grant SELECT                                                                 on TMP_FIN_REZ     to SALGL;



PROMPT ===================================================================================== 
PROMPT *** End *** ========== Scripts /Sql/BARS/Table/TMP_FIN_REZ.sql =========*** End *** =
PROMPT ===================================================================================== 
