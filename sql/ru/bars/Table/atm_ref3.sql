prompt ..........................................
prompt ... Створення таблиць  ATM_REF3
prompt ..........................................

exec bpa.alter_policy_info ( 'ATM_REF3', 'WHOLE' , null , null , null , null ) ;
exec bpa.alter_policy_info ( 'ATM_REF3', 'FILIAL', null , null , null , null ) ;


begin EXECUTE IMMEDIATE  '
CREATE TABLE BARS.ATM_REF3 ( acc number ,    REF1 NUMBER ,       s NUMBER       ) TABLESPACE BRSMDLD ' ;
exception when others then   if SQLCODE = -00955 then null;   else raise; end if;   -- ORA-00955: name is already used by an existing object
end;
/

exec bpa.alter_policies    ('ATM_REF3'); 
/


COMMENT ON TABLE  ATM_REF3      IS 'тимчасова табл для введення частки суми на закриття';
COMMENT ON COLUMN ATM_REF3.ref1 IS 'Реф.виникнення заборгованості';
COMMENT ON COLUMN ATM_REF3.S    IS 'Частка суми на закриття заборгованості';
COMMENT ON COLUMN ATM_REF3.acc  IS 'рахунок';
-------------------------------------------------------------------------------
