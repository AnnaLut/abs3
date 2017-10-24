begin
 execute immediate 'drop user sbon cascade';
exception when others then if (sqlcode = -01918) then null; else raise; end if;
end;
/
-- Create the user 
create user sbon identified by &&sbon_pass
  default tablespace brsmdld
  quota unlimited on brsmdld;


grant execute on SYS.DBMS_SCHEDULER to SBON;
-- Grant/Revoke role privileges 
grant connect to SBON;
-- Grant/Revoke system privileges 
grant create any job to SBON;
grant create any procedure to SBON;
grant create any sequence to SBON;
grant create any table to SBON;
grant create any type to SBON;
grant create any view to SBON;
/


