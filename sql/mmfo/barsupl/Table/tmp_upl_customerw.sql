

PROMPT ===================================================================================== 
PROMPT *** Run *** ========== Scripts /Sql/BARSUPL/Table/TMP_UPL_CUSTOMERW.sql =========*** 
PROMPT ===================================================================================== 


PROMPT *** Create  table TMP_UPL_CUSTOMERW ***
begin 
  execute immediate '
  CREATE GLOBAL TEMPORARY TABLE BARSUPL.TMP_UPL_CUSTOMERW 
   (	RNK NUMBER(38,0), 
	CIGPO VARCHAR2(500), 
	K013 VARCHAR2(500), 
	GR VARCHAR2(500), 
	FGIDX VARCHAR2(500), 
	FGOBL VARCHAR2(500), 
	FGDST VARCHAR2(500), 
	FGTWN VARCHAR2(500), 
	VIPK VARCHAR2(500)
   ) ON COMMIT PRESERVE ROWS ';
exception when others then       
  if sqlcode=-955 then null; else raise; end if; 
end; 
/


COMMENT ON TABLE BARSUPL.TMP_UPL_CUSTOMERW IS '';
COMMENT ON COLUMN BARSUPL.TMP_UPL_CUSTOMERW.RNK IS '';
COMMENT ON COLUMN BARSUPL.TMP_UPL_CUSTOMERW.CIGPO IS '';
COMMENT ON COLUMN BARSUPL.TMP_UPL_CUSTOMERW.K013 IS '';
COMMENT ON COLUMN BARSUPL.TMP_UPL_CUSTOMERW.GR IS '';
COMMENT ON COLUMN BARSUPL.TMP_UPL_CUSTOMERW.FGIDX IS '';
COMMENT ON COLUMN BARSUPL.TMP_UPL_CUSTOMERW.FGOBL IS '';
COMMENT ON COLUMN BARSUPL.TMP_UPL_CUSTOMERW.FGDST IS '';
COMMENT ON COLUMN BARSUPL.TMP_UPL_CUSTOMERW.FGTWN IS '';
COMMENT ON COLUMN BARSUPL.TMP_UPL_CUSTOMERW.VIPK IS '';



PROMPT *** Create  grants  TMP_UPL_CUSTOMERW ***
grant SELECT                                                                 on TMP_UPL_CUSTOMERW to BARSREADER_ROLE;
grant SELECT                                                                 on TMP_UPL_CUSTOMERW to UPLD;



PROMPT ===================================================================================== 
PROMPT *** End *** ========== Scripts /Sql/BARSUPL/Table/TMP_UPL_CUSTOMERW.sql =========*** 
PROMPT ===================================================================================== 
