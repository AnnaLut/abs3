

PROMPT ===================================================================================== 
PROMPT *** Run *** ========== Scripts /Sql/BARS/Table/TMP_BPK_REP.sql =========*** Run *** =
PROMPT ===================================================================================== 


PROMPT *** ALTER_POLICY_INFO to TMP_BPK_REP ***

DROP TABLE TMP_BPK_REP;

BEGIN 
        execute immediate  
          'begin  
               null;
           end; 
          '; 
END; 
/

PROMPT *** Create  table TMP_BPK_REP ***
begin 
  execute immediate 'CREATE TABLE BARS.TMP_BPK_REP 
( ACC NUMBER(38,0), 
	NMK VARCHAR2(70), 
	RNK NUMBER(38,0), 
	OPEN_DATE DATE, 
	NLS VARCHAR2(15), 
	KF VARCHAR2(6), 
	SUM_BORG NUMBER, 
	SUM_INT NUMBER
) TABLESPACE BRSDYND ';
exception when others then       
  if sqlcode=-955 then null; else raise; end if; 
end; 
/

prompt -- ======================================================
prompt -- Alters
prompt -- ======================================================

declare
  e_col_exists           exception;
  pragma exception_init( e_col_exists, -01430 );
begin
  execute immediate 'alter table TMP_BPK_REP add SUM_BORG number';
  dbms_output.put_line( 'Table altered.' );
exception
  when e_col_exists then
    dbms_output.put_line( 'Column "SUM_BORG" already exists in table.' );
end;
/

declare
  e_col_exists           exception;
  pragma exception_init( e_col_exists, -01430 );
begin
  execute immediate 'alter table TMP_BPK_REP add SUM_INT number';
  dbms_output.put_line( 'Table altered.' );
exception
  when e_col_exists then
    dbms_output.put_line( 'Column "SUM_INT" already exists in table.' );
end;
/

PROMPT *** ALTER_POLICIES to TMP_BPK_REP ***
exec bpa.alter_policies('TMP_BPK_REP');


COMMENT ON TABLE BARS.TMP_BPK_REP IS '';
COMMENT ON COLUMN BARS.TMP_BPK_REP.ACC IS '';
COMMENT ON COLUMN BARS.TMP_BPK_REP.NMK IS '';
COMMENT ON COLUMN BARS.TMP_BPK_REP.RNK IS '';
COMMENT ON COLUMN BARS.TMP_BPK_REP.OPEN_DATE IS '';
COMMENT ON COLUMN BARS.TMP_BPK_REP.NLS IS '';
COMMENT ON COLUMN BARS.TMP_BPK_REP.KF IS '';
COMMENT ON COLUMN BARS.TMP_BPK_REP.SUM_BORG IS '';
COMMENT ON COLUMN BARS.TMP_BPK_REP.SUM_INT IS '';



PROMPT *** Create  grants  TMP_BPK_REP ***
grant DEBUG,DELETE,FLASHBACK,INSERT,ON COMMIT REFRESH,QUERY REWRITE,SELECT,UPDATE on TMP_BPK_REP     to BARS_ACCESS_DEFROLE;



PROMPT ===================================================================================== 
PROMPT *** End *** ========== Scripts /Sql/BARS/Table/TMP_BPK_REP.sql =========*** End *** =
PROMPT ===================================================================================== 
