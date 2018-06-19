prompt ---------------------------------------------------------------
prompt 00.TABLE CREATE TABLE RECLASS9
prompt ---------------------------------------------------------------

exec bars.bpa.alter_policy_info( 'RECLASS9', 'WHOLE' , null, null, null, null ); 
exec bars.bpa.alter_policy_info( 'RECLASS9', 'FILIAL', null, null, null, null );

begin  EXECUTE IMMEDIATE 'CREATE TABLE BARS.RECLASS9 (  FROM_PROD  CHAR(6 BYTE),  TO_K9      INTEGER,  TO_PROD    CHAR(6 BYTE) )  ' ;
exception when others then   if SQLCODE = -00955 then null;   else raise; end if;   -- ORA-00955: name is already used by an existing object
end;
/

exec  bars.bpa.alter_policies('RECLASS9'); 

begin EXECUTE IMMEDIATE 'ALTER TABLE BARS.RECLASS9 ADD (  CONSTRAINT XPK_RECLASS9  PRIMARY KEY  (FROM_PROD, TO_K9)  ) '; 
exception when others then   if SQLCODE = -02260 then null;   else raise; end if;   --  ORA-02260: table can have only one primary key
end;
/


GRANT DELETE, INSERT, SELECT, UPDATE ON BARS.RECLASS9 TO BARS_ACCESS_DEFROLE;

COMMENT ON TABLE BARS.RECLASS9 IS '"Вектори" перекласифікації Активів по МСФЗ-9';
COMMENT ON COLUMN BARS.RECLASS9.FROM_PROD IS 'FROM:~З якого~Продукту ?';
COMMENT ON COLUMN BARS.RECLASS9.TO_K9 IS 'TO:~ В яку~"Корзину" ?';
COMMENT ON COLUMN BARS.RECLASS9.TO_PROD IS 'TO:~ В який~Продукт ?';
