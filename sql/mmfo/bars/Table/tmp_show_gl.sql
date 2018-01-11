

PROMPT ===================================================================================== 
PROMPT *** Run *** ========== Scripts /Sql/BARS/Table/TMP_SHOW_GL.sql =========*** Run *** =
PROMPT ===================================================================================== 


PROMPT *** ALTER_POLICY_INFO to TMP_SHOW_GL ***


BEGIN 
        execute immediate  
          'begin  
               null;
           end; 
          '; 
END; 
/

PROMPT *** Create  table TMP_SHOW_GL ***
begin 
  execute immediate '
  CREATE GLOBAL TEMPORARY TABLE BARS.TMP_SHOW_GL 
   (	NBS CHAR(4), 
	DOSR NUMBER, 
	KOSR NUMBER, 
	DOSQ NUMBER, 
	KOSQ NUMBER, 
	OSTD NUMBER, 
	OSTK NUMBER
   ) ON COMMIT PRESERVE ROWS ';
exception when others then       
  if sqlcode=-955 then null; else raise; end if; 
end; 
/




PROMPT *** ALTER_POLICIES to TMP_SHOW_GL ***
 exec bpa.alter_policies('TMP_SHOW_GL');


COMMENT ON TABLE BARS.TMP_SHOW_GL IS '';
COMMENT ON COLUMN BARS.TMP_SHOW_GL.NBS IS '';
COMMENT ON COLUMN BARS.TMP_SHOW_GL.DOSR IS '';
COMMENT ON COLUMN BARS.TMP_SHOW_GL.KOSR IS '';
COMMENT ON COLUMN BARS.TMP_SHOW_GL.DOSQ IS '';
COMMENT ON COLUMN BARS.TMP_SHOW_GL.KOSQ IS '';
COMMENT ON COLUMN BARS.TMP_SHOW_GL.OSTD IS '';
COMMENT ON COLUMN BARS.TMP_SHOW_GL.OSTK IS '';



PROMPT *** Create  grants  TMP_SHOW_GL ***
grant SELECT                                                                 on TMP_SHOW_GL     to BARSREADER_ROLE;
grant SELECT                                                                 on TMP_SHOW_GL     to BARS_ACCESS_DEFROLE;
grant SELECT                                                                 on TMP_SHOW_GL     to BARS_DM;
grant SELECT                                                                 on TMP_SHOW_GL     to CUST001;
grant SELECT                                                                 on TMP_SHOW_GL     to SALGL;
grant SELECT                                                                 on TMP_SHOW_GL     to UPLD;
grant DELETE,FLASHBACK,INSERT,SELECT,UPDATE                                  on TMP_SHOW_GL     to WR_ALL_RIGHTS;



PROMPT ===================================================================================== 
PROMPT *** End *** ========== Scripts /Sql/BARS/Table/TMP_SHOW_GL.sql =========*** End *** =
PROMPT ===================================================================================== 
