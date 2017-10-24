

PROMPT ===================================================================================== 
PROMPT *** Run *** ========== Scripts /Sql/BARS/Table/TMP_V2.sql =========*** Run *** ======
PROMPT ===================================================================================== 


PROMPT *** ALTER_POLICY_INFO to TMP_V2 ***


BEGIN 
        execute immediate  
          'begin  
               null;
           end; 
          '; 
END; 
/

PROMPT *** Create  table TMP_V2 ***
begin 
  execute immediate '
  CREATE GLOBAL TEMPORARY TABLE BARS.TMP_V2 
   (	FN VARCHAR2(12), 
	REC NUMBER, 
	X CHAR(1), 
	LINE VARCHAR2(200)
   ) ON COMMIT DELETE ROWS ';
exception when others then       
  if sqlcode=-955 then null; else raise; end if; 
end; 
/




PROMPT *** ALTER_POLICIES to TMP_V2 ***
 exec bpa.alter_policies('TMP_V2');


COMMENT ON TABLE BARS.TMP_V2 IS '';
COMMENT ON COLUMN BARS.TMP_V2.FN IS '';
COMMENT ON COLUMN BARS.TMP_V2.REC IS '';
COMMENT ON COLUMN BARS.TMP_V2.X IS '';
COMMENT ON COLUMN BARS.TMP_V2.LINE IS '';



PROMPT *** Create  grants  TMP_V2 ***
grant SELECT                                                                 on TMP_V2          to BARS_ACCESS_DEFROLE;
grant SELECT                                                                 on TMP_V2          to TOSS;
grant DELETE,FLASHBACK,INSERT,SELECT,UPDATE                                  on TMP_V2          to WR_ALL_RIGHTS;



PROMPT ===================================================================================== 
PROMPT *** End *** ========== Scripts /Sql/BARS/Table/TMP_V2.sql =========*** End *** ======
PROMPT ===================================================================================== 
