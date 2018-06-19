
exec bars.bpa.alter_policy_info( 'NBS_SS_SD', 'WHOLE' , null, null, null, null ); 
exec bars.bpa.alter_policy_info( 'NBS_SS_SD', 'FILIAL', null, null, null, null );

begin EXECUTE IMMEDIATE ' CREATE TABLE BARS.NBS_SS_SD   ( NBS2 char(4), NBS6 char(4) )'; 


exception when others then   if SQLCODE = -00955 then null;   else raise; end if;   -- ORA-00955: name is already used by an existing object
end;
/

exec  bars.bpa.alter_policies('NBS_SS_SD'); 
commit;

COMMENT ON TABLE  BARS.NBS_SS_SD         IS '³��������� ���.��� ��� �� �� ���.��� ����.������ �����';
COMMENT ON COLUMN BARS.NBS_SS_SD.NBS2    IS '���.��� ��� ��';
COMMENT ON COLUMN BARS.NBS_SS_SD.NBS6    IS '���.��� ����.������';

GRANT DELETE, INSERT, SELECT, UPDATE ON BARS.NBS_SS_SD TO BARS_ACCESS_DEFROLE;
/
-----------------------------------------------------------

