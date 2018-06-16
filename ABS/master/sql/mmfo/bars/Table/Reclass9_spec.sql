exec bars.bpa.alter_policy_info( 'RECLASS9_SPEC', 'WHOLE' , null, null, null, null ); 
exec bars.bpa.alter_policy_info( 'RECLASS9_SPEC', 'FILIAL', null, null, null, null );

begin EXECUTE IMMEDIATE 'CREATE TABLE RECLASS9_SPEC( 
      R020_OLD char(4), R011_OLD VARCHAR2 (1), R013_old VARCHAR2 (1),       
      R020_NEW char(4), R011_NEW VARCHAR2 (1), R013_NEW VARCHAR2 (1)    ) ' ;
exception when others then   if SQLCODE = -00955 then null;   else raise; end if;   -- ORA-00955: name is already used by an existing object
end;
/
exec  bars.bpa.alter_policies('RECLASS9_SPEC'); 



COMMENT ON TABLE  RECLASS9_SPEC            IS 'Спец.пар. при перекласифікації Активів по МСФЗ-9';
COMMENT ON COLUMN RECLASS9_SPEC.R020_OLD   IS 'R020_OLD'  ;
COMMENT ON COLUMN RECLASS9_SPEC.R011_OLD   IS 'R011_OLD'  ;
COMMENT ON COLUMN RECLASS9_SPEC.R013_old   IS 'R013_old'  ;

COMMENT ON COLUMN RECLASS9_SPEC.R020_NEW   IS 'R020_NEW'  ;
COMMENT ON COLUMN RECLASS9_SPEC.R011_NEW   IS 'R011_NEW'  ;
COMMENT ON COLUMN RECLASS9_SPEC.R013_NEW   IS 'R013_NEW'  ;
                                   
GRANT DELETE, INSERT, SELECT, UPDATE ON BARS.RECLASS9_SPEC TO BARS_ACCESS_DEFROLE;
/

                                                                                                                                     