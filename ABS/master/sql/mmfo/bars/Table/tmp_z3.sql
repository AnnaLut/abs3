

PROMPT ===================================================================================== 
PROMPT *** Run *** ========== Scripts /Sql/BARS/Table/TMP_Z3.sql =========*** Run *** ======
PROMPT ===================================================================================== 


PROMPT *** ALTER_POLICY_INFO to TMP_Z3 ***


BEGIN 
        execute immediate  
          'begin  
               null;
           end; 
          '; 
END; 
/

PROMPT *** Create  table TMP_Z3 ***
begin 
  execute immediate '
  CREATE GLOBAL TEMPORARY TABLE BARS.TMP_Z3 
   (	ID1 CHAR(1), 
	ID2 CHAR(1), 
	N NUMBER, 
	S NUMBER(*,0)
   ) ON COMMIT DELETE ROWS ';
exception when others then       
  if sqlcode=-955 then null; else raise; end if; 
end; 
/




PROMPT *** ALTER_POLICIES to TMP_Z3 ***
 exec bpa.alter_policies('TMP_Z3');


COMMENT ON TABLE BARS.TMP_Z3 IS '';
COMMENT ON COLUMN BARS.TMP_Z3.ID1 IS '';
COMMENT ON COLUMN BARS.TMP_Z3.ID2 IS '';
COMMENT ON COLUMN BARS.TMP_Z3.N IS '';
COMMENT ON COLUMN BARS.TMP_Z3.S IS '';



PROMPT *** Create  grants  TMP_Z3 ***
grant SELECT                                                                 on TMP_Z3          to BARSREADER_ROLE;
grant SELECT                                                                 on TMP_Z3          to BARS_ACCESS_DEFROLE;
grant SELECT                                                                 on TMP_Z3          to TOSS;
grant SELECT                                                                 on TMP_Z3          to UPLD;
grant DELETE,FLASHBACK,INSERT,SELECT,UPDATE                                  on TMP_Z3          to WR_ALL_RIGHTS;



PROMPT ===================================================================================== 
PROMPT *** End *** ========== Scripts /Sql/BARS/Table/TMP_Z3.sql =========*** End *** ======
PROMPT ===================================================================================== 
