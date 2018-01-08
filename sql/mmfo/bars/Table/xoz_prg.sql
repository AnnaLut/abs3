exec bpa.alter_policy_info( 'XOZ_PRG', 'WHOLE' , null, null, null, null ); 
exec bpa.alter_policy_info( 'XOZ_PRG', 'FILIAL', null, null, null, null );

begin    execute immediate ' CREATE TABLE BARS.XOZ_PRG (    PRG     INTEGER,  NAME    VARCHAR2(100 BYTE),  DETALI  VARCHAR2(250 BYTE)) ';
exception when others then   if SQLCODE = - 00955 then null;   else raise; end if; 
--ORA-00955: name is already used by an existing object
end;
/

exec  bpa.alter_policies('XOZ_PRG'); 

COMMENT ON TABLE BARS.XOZ_PRG IS 'Довідник проектів';
COMMENT ON COLUMN BARS.XOZ_PRG.PRG IS 'Код проекту';
COMMENT ON COLUMN BARS.XOZ_PRG.NAME IS 'Назва проекту';
COMMENT ON COLUMN BARS.XOZ_PRG.DETALI IS 'Короткий зміст проекту';

begin    execute immediate ' ALTER TABLE BARS.XOZ_PRG ADD (  CONSTRAINT PK_XOZPRG  PRIMARY KEY  (PRG)) ';
exception when others then   if SQLCODE = - 02260 then null;   else raise; end if; --ORA-02260: table can have only one primary key
end;
/
GRANT SELECT ON BARS.XOZ_PRG TO BARS_ACCESS_DEFROLE;