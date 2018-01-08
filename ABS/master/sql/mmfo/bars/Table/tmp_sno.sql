

PROMPT ===================================================================================== 
PROMPT *** Run *** ========== Scripts /Sql/BARS/Table/TMP_SNO.sql =========*** Run *** =====
PROMPT ===================================================================================== 


PROMPT *** ALTER_POLICY_INFO to TMP_SNO ***


BEGIN 
        execute immediate  
          'begin  
               null;
           end; 
          '; 
END; 
/

PROMPT *** Create  table TMP_SNO ***
begin 
  execute immediate '
  CREATE GLOBAL TEMPORARY TABLE BARS.TMP_SNO 
   (	ID NUMBER(*,0), 
	DAT DATE, 
	OSTF NUMBER, 
	IR NUMBER, 
	BR NUMBER, 
	BRN NUMBER, 
	OTM NUMBER, 
	S NUMBER, 
	OP NUMBER, 
	SA NUMBER
   ) ON COMMIT PRESERVE ROWS ';
exception when others then       
  if sqlcode=-955 then null; else raise; end if; 
end; 
/




PROMPT *** ALTER_POLICIES to TMP_SNO ***
 exec bpa.alter_policies('TMP_SNO');


COMMENT ON TABLE BARS.TMP_SNO IS '';
COMMENT ON COLUMN BARS.TMP_SNO.ID IS '';
COMMENT ON COLUMN BARS.TMP_SNO.DAT IS '';
COMMENT ON COLUMN BARS.TMP_SNO.OSTF IS '';
COMMENT ON COLUMN BARS.TMP_SNO.IR IS '';
COMMENT ON COLUMN BARS.TMP_SNO.BR IS '';
COMMENT ON COLUMN BARS.TMP_SNO.BRN IS '';
COMMENT ON COLUMN BARS.TMP_SNO.OTM IS '';
COMMENT ON COLUMN BARS.TMP_SNO.S IS '';
COMMENT ON COLUMN BARS.TMP_SNO.OP IS '';
COMMENT ON COLUMN BARS.TMP_SNO.SA IS '';



PROMPT *** Create  grants  TMP_SNO ***
grant SELECT                                                                 on TMP_SNO         to BARSREADER_ROLE;
grant SELECT                                                                 on TMP_SNO         to UPLD;



PROMPT ===================================================================================== 
PROMPT *** End *** ========== Scripts /Sql/BARS/Table/TMP_SNO.sql =========*** End *** =====
PROMPT ===================================================================================== 
