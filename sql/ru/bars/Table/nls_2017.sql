exec bpa.alter_policy_info( 'NLS_2017', 'WHOLE' , null, null, null, null ); 
exec bpa.alter_policy_info( 'NLS_2017', 'FILIAL', null, null, null, null );


begin  execute immediate ' CREATE TABLE BARS.NLS_2017      (
                          nls_old varchar2(15), 
						  nls_new varchar2(15), 
						  KF varchar2(6) ) ' ;
       exception when others then   if SQLCODE = - 00955 then null;   else raise; end if; 
--ORA-00955: name is already used by an existing object
end;
/


begin  EXECUTE IMMEDIATE 'ALTER TABLE  bars.NLS_2017  ADD (KF varchar2(6) ) ' ;
exception when others then   if SQLCODE = - 01430 then null;   else raise; end if; -- ORA-01430: column being added already exists in table
end;
/

begin
 EXECUTE IMMEDIATE ' ALTER TABLE  BARS.NLS_2017 ADD   CONSTRAINT XPK_NLS2017  PRIMARY KEY  (KF, NLS_old) ' ;
exception when others then  null ; ---if SQLCODE = - 06512 then null;   else raise; end if; 
--ORA-00955: name is already used by an existing object
end;
/

exec  bpa.alter_policies('NLS_2017'); 

COMMENT ON TABLE  BARS.NLS_2017 IS 'Майбутны рах	';