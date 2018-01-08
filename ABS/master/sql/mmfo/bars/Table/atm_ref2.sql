prompt ####################################################################################
prompt ... Створення таблиць ATM_REF1  + ATM_REF2  D:\K\MMFO\kwt_2924\Sql\Table\ATM_tbl.sql 
prompt ..........................................

--------------------------------------------------------------------------------

exec bpa.alter_policy_info ( 'ATM_REF2', 'WHOLE' , null , null , null , null ) ;
exec bpa.alter_policy_info ( 'ATM_REF2', 'FILIAL', null , null , null , null ) ;

begin EXECUTE IMMEDIATE  'CREATE TABLE bars.ATM_REF2 (ref1 number , ref2 number) ' ;
exception when others then   if SQLCODE = -00955 then null;   else raise; end if;   -- ORA-00955: name is already used by an existing object
end;
/
exec bpa.alter_policies    ('ATM_REF2'); 
commit;


begin  EXECUTE IMMEDIATE 'ALTER TABLE  bars.ATM_REF2 add  CONSTRAINT XPK_ATMREF2 PRIMARY KEY  (ref1, ref2) ' ;
exception when others then   if SQLCODE = -02260 then null;   else raise; end if;   -- ORA-02260: table can have only one primary key
end;
/
begin  EXECUTE IMMEDIATE 'ALTER TABLE  bars.ATM_REF2 ADD ( CONSTRAINT FK_ATMREF2 FOREIGN KEY (ref1)  REFERENCES ATM_REF1 (ref1) )';
exception when others then   if SQLCODE = -02275 then null;   else raise; end if;   -- ORA-02275: such a referential constraint already exists in the table
end;
/

COMMENT ON TABLE  ATM_REF2      IS 'Картотека  розыбраних надлишків та нестач в банкоматах';
COMMENT ON COLUMN ATM_REF2.ref1 IS 'Реф.виникнення заборгованості';
COMMENT ON COLUMN ATM_REF2.ref2 IS 'Реф.закриття заборгованості';
-------------------------------------------------------------------------------
