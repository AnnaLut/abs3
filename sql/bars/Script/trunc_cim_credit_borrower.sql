declare
begin
  for cur in (SELECT c.owner, c.table_name, c.constraint_name
                FROM dba_constraints c, dba_constraints c2
               WHERE c.constraint_type = 'R'
                 AND c2.owner = c.r_owner
                 AND c2.constraint_name = c.r_constraint_name
                 AND c2.owner = 'BARS'
                 AND c2.table_name = 'CIM_CREDIT_BORROWER') loop
    execute immediate 'ALTER TABLE ' || cur.table_name ||
                      ' DROP CONSTRAINT ' || cur.constraint_name;
  end loop;
end;
/
truncate table cim_credit_borrower;
/