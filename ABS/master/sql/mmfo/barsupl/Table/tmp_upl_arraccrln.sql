

PROMPT ===================================================================================== 
PROMPT *** Run *** ========== Scripts /Sql/BARSUPL/Table/TMP_UPL_ARRACCRLN.sql =========*** 
PROMPT ===================================================================================== 


PROMPT *** Create  table TMP_UPL_ARRACCRLN ***
begin 
  execute immediate '
  CREATE GLOBAL TEMPORARY TABLE BARSUPL.TMP_UPL_ARRACCRLN 
   (	ARRTYPE NUMBER(1,0), 
	ND NUMBER(15,0), 
	ACC NUMBER(15,0), 
	KF VARCHAR2(6)
   ) ON COMMIT PRESERVE ROWS ';
exception when others then       
  if sqlcode=-955 then null; else raise; end if; 
end; 
/


COMMENT ON TABLE BARSUPL.TMP_UPL_ARRACCRLN IS '';
COMMENT ON COLUMN BARSUPL.TMP_UPL_ARRACCRLN.ARRTYPE IS '';
COMMENT ON COLUMN BARSUPL.TMP_UPL_ARRACCRLN.ND IS '';
COMMENT ON COLUMN BARSUPL.TMP_UPL_ARRACCRLN.ACC IS '';
COMMENT ON COLUMN BARSUPL.TMP_UPL_ARRACCRLN.KF IS '';





PROMPT ===================================================================================== 
PROMPT *** End *** ========== Scripts /Sql/BARSUPL/Table/TMP_UPL_ARRACCRLN.sql =========*** 
PROMPT ===================================================================================== 
