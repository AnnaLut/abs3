

PROMPT ===================================================================================== 
PROMPT *** Run *** ========== Scripts /Sql/BARS/Table/TMP_Z.sql =========*** Run *** =======
PROMPT ===================================================================================== 


PROMPT *** ALTER_POLICY_INFO to TMP_Z ***


BEGIN 
        execute immediate  
          'begin  
               null;
           end; 
          '; 
END; 
/

PROMPT *** Create  table TMP_Z ***
begin 
  execute immediate '
  CREATE GLOBAL TEMPORARY TABLE BARS.TMP_Z 
   (	FN CHAR(12), 
	DAT DATE, 
	N NUMBER, 
	SDE NUMBER(24,0), 
	SKR NUMBER(24,0), 
	ERRK NUMBER
   ) ON COMMIT DELETE ROWS ';
exception when others then       
  if sqlcode=-955 then null; else raise; end if; 
end; 
/




PROMPT *** ALTER_POLICIES to TMP_Z ***
 exec bpa.alter_policies('TMP_Z');


COMMENT ON TABLE BARS.TMP_Z IS '';
COMMENT ON COLUMN BARS.TMP_Z.FN IS '';
COMMENT ON COLUMN BARS.TMP_Z.DAT IS '';
COMMENT ON COLUMN BARS.TMP_Z.N IS '';
COMMENT ON COLUMN BARS.TMP_Z.SDE IS '';
COMMENT ON COLUMN BARS.TMP_Z.SKR IS '';
COMMENT ON COLUMN BARS.TMP_Z.ERRK IS '';



PROMPT *** Create  grants  TMP_Z ***
grant SELECT                                                                 on TMP_Z           to BARSREADER_ROLE;
grant INSERT                                                                 on TMP_Z           to BARS_ACCESS_DEFROLE;
grant INSERT                                                                 on TMP_Z           to TOSS;
grant SELECT                                                                 on TMP_Z           to UPLD;
grant DELETE,FLASHBACK,INSERT,SELECT,UPDATE                                  on TMP_Z           to WR_ALL_RIGHTS;



PROMPT ===================================================================================== 
PROMPT *** End *** ========== Scripts /Sql/BARS/Table/TMP_Z.sql =========*** End *** =======
PROMPT ===================================================================================== 
