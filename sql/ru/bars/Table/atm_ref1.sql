prompt ####################################################################################
prompt ... ��������� ������� ATM_REF1  + ATM_REF2  D:\K\MMFO\kwt_2924\Sql\Table\ATM_tbl.sql 
prompt ..........................................

exec bpa.alter_policy_info ( 'ATM_REF1', 'WHOLE' , null , null , null , null ) ;
exec bpa.alter_policy_info ( 'ATM_REF1', 'FILIAL', null , null , null , null ) ;

begin EXECUTE IMMEDIATE  'CREATE TABLE bars.ATM_REF1 (acc number, ref1 number ) ' ;
exception when others then   if SQLCODE = -00955 then null;   else raise; end if;   -- ORA-00955: name is already used by an existing object
end;
/
exec bpa.alter_policies    ('ATM_REF1'); 
commit;


begin  EXECUTE IMMEDIATE 'ALTER TABLE  bars.ATM_REF1 add  CONSTRAINT XPK_ATMREF1 PRIMARY KEY  (ref1) ' ;
exception when others then   if SQLCODE = -02260 then null;   else raise; end if;   -- ORA-02260: table can have only one primary key
end;
/


COMMENT ON TABLE  ATM_REF1      IS '��������� �������� �� ������ � ����������';
COMMENT ON COLUMN ATM_REF1.acc  IS '��� ������� 2924/07-08';
COMMENT ON COLUMN ATM_REF1.ref1 IS '���.���������� �������������';

grant delete, insert on bars.ATM_REF1  TO BARS_ACCESS_DEFROLE;

