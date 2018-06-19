prompt ---------------------------------------------------------------
prompt 000. CREATE TABLE RECLASS9_SPEC
prompt ---------------------------------------------------------------


exec bars.bpa.alter_policy_info( 'RECLASS9_SPEC', 'WHOLE' , null, null, null, null ); 
exec bars.bpa.alter_policy_info( 'RECLASS9_SPEC', 'FILIAL', null, null, null, null );

begin  EXECUTE IMMEDIATE '
CREATE TABLE BARS.RECLASS9_SPEC
( R020_OLD  CHAR(4 BYTE),
  R011_OLD  VARCHAR2(1 BYTE),
  R013_OLD  VARCHAR2(1 BYTE),
  R020_NEW  CHAR(4 BYTE),
  R011_NEW  VARCHAR2(1 BYTE),
  R013_NEW  VARCHAR2(1 BYTE)
) ' ;
exception when others then   if SQLCODE = -00955 then null;   else raise; end if;   -- ORA-00955: name is already used by an existing object
end;
/

exec  bars.bpa.alter_policies('RECLASS9_SPEC'); 

COMMENT ON TABLE BARS.RECLASS9_SPEC IS 'Спец.пар. при перекласифікації Активів по МСФЗ-9';
COMMENT ON COLUMN BARS.RECLASS9_SPEC.R020_OLD IS 'R020_OLD';
COMMENT ON COLUMN BARS.RECLASS9_SPEC.R011_OLD IS 'R011_OLD';
COMMENT ON COLUMN BARS.RECLASS9_SPEC.R013_OLD IS 'R013_old';
COMMENT ON COLUMN BARS.RECLASS9_SPEC.R020_NEW IS 'R020_NEW';
COMMENT ON COLUMN BARS.RECLASS9_SPEC.R011_NEW IS 'R011_NEW';
COMMENT ON COLUMN BARS.RECLASS9_SPEC.R013_NEW IS 'R013_NEW';

GRANT DELETE, INSERT, SELECT, UPDATE ON BARS.RECLASS9_SPEC TO BARS_ACCESS_DEFROLE;

begin EXECUTE IMMEDIATE 'ALTER TABLE bars.RECLASS9_SPEC add  CONSTRAINT XPK_RECLASS9SPEC  PRIMARY KEY  ( R020_OLD, R011_OLD, R013_old, R020_NEW )  ' ;
exception when others then   if SQLCODE = -02260 then null;   else raise; end if;   -- ORA-02260: table can have only one primary key
end;
/
                                                                                                                                     