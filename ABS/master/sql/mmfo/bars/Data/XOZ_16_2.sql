BEGIN INSERT INTO ps ( nbs ,NAME) VALUES ('6360', '����� �� ���������� �������� ����`����� �� ����.ĳ��.' ); 
exception when others then   if SQLCODE = - 00001 then null;   else raise; end if; -- ORA-00001: unique constraint 
end;
/

BEGIN INSERT INTO sb_ob22 ( r020, ob22, txt) values ('6360','01', '����� �� ���������� �������� �����`����� �� ����.ĳ��.' );
exception when others then   if SQLCODE = - 00001 then null;   else raise; end if; -- ORA-00001: unique constraint 
end;
/


BEGIN INSERT INTO ps ( nbs ,NAME) VALUES ('7360', '������� �� ���������� �������� �����`����� �� ����.ĳ��.' ); 
exception when others then   if SQLCODE = - 00001 then null;   else raise; end if; --ORA-00001: unique constraint 
end;
/

BEGIN INSERT INTO sb_ob22 ( r020, ob22, txt) values ('7360','01', '������� �� ���������� �������� �����`����� �� ����.ĳ��.' );
exception when others then   if SQLCODE = - 00001 then null;   else raise; end if; -- ORA-00001: unique constraint
end;
/

commit;

