BEGIN INSERT INTO CC_VIDD (VIDD,CUSTTYPE,TIPD,NAME) VALUES (351, 2, 1, '������.��������'); 
exception when others then   if SQLCODE = - 00001 then null;   else raise; end if; -- ORA-00001: unique constraint (BARS.PK_CCVIDD) violated
end;
/

BEGIN INSERT INTO ps ( nbs ,NAME) VALUES ('4600', '������' ); 
exception when others then   if SQLCODE = - 00001 then null;   else raise; end if; -- ORA-00001: unique constraint (BARS.PK_PS) violated
end;
/

BEGIN INSERT INTO ps ( nbs ,NAME) VALUES ('4609', '������' ); 
exception when others then   if SQLCODE = - 00001 then null;   else raise; end if; --ORA-00001: unique constraint (BARS.PK_PS) violated
end;
/


BEGIN INSERT INTO sb_ob22 ( r020, ob22, txt) values ('4600','01', '����� ������������ �� ����������� ��������� ����������� �� ���������� � ������ (������)' );
exception when others then   if SQLCODE = - 00001 then null;   else raise; end if; -- ORA-00001: unique constraint (BARS.PK_CCVIDD) violated
end;
/

BEGIN INSERT INTO sb_ob22 ( r020, ob22, txt) values ('4609','01', '����� ������������ �� ����������� ��������� ����������� �� ���������� � ������ (������)' );
exception when others then   if SQLCODE = - 00001 then null;   else raise; end if; -- ORA-00001: unique constraint (BARS.PK_CCVIDD) violated
end;
/

BEGIN INSERT INTO sb_ob22 ( r020, ob22, txt) values ('4600','02', '����� ������������ �� ����������� ������.����������� �� ���������� � ������ (������)' ) ;
exception when others then   if SQLCODE = - 00001 then null;   else raise; end if; -- ORA-00001: unique constraint (BARS.PK_CCVIDD) violated
end;
/

BEGIN INSERT INTO sb_ob22 ( r020, ob22, txt) values ('4609','02', '����� ������������ �� ����������� ������.����������� �� ���������� � ������ (������)' ) ;
exception when others then   if SQLCODE = - 00001 then null;   else raise; end if; -- ORA-00001: unique constraint (BARS.PK_CCVIDD) violated
end;
/


BEGIN INSERT INTO sb_ob22 ( r020, ob22, txt) values ('4600','03', '����� ������������ �� ����� �� ���� ���������� �� ���������� � ������ (������)' ) ;
exception when others then   if SQLCODE = - 00001 then null;   else raise; end if; -- ORA-00001: unique constraint (BARS.PK_CCVIDD) violated
end;
/

BEGIN INSERT INTO sb_ob22 ( r020, ob22, txt) values ('4609','03', '����� ������������ �� ����� �� ���� ���������� �� ���������� � ������ (������)' ) ;
exception when others then   if SQLCODE = - 00001 then null;   else raise; end if; -- ORA-00001: unique constraint (BARS.PK_CCVIDD) violated
end;
/

commit;
------------------------

BEGIN INSERT INTO sb_ob22 ( r020, ob22, txt) values ('3615','04', '������������ ������������� �� ���������� � ������ (������)' ) ;
exception when others then   if SQLCODE = - 00001 then null;   else raise; end if; -- ORA-00001: unique constraint (BARS.PK_CCVIDD) violated
end;
/

BEGIN INSERT INTO sb_ob22 ( r020, ob22, txt) values ('3618','01', '������������ ������������� �� �������' ) ;
exception when others then   if SQLCODE = - 00001 then null;   else raise; end if; -- ORA-00001: unique constraint (BARS.PK_CCVIDD) violated
end;
/

BEGIN INSERT INTO sb_ob22 ( r020, ob22, txt) values ('7028','01', '�������� ������� �� ���������� ������� (�������), ���� ������������ �� �������.����������' ) ;
exception when others then   if SQLCODE = - 00001 then null;   else raise; end if; -- ORA-00001: unique constraint (BARS.PK_CCVIDD) violated
end;
/

BEGIN INSERT INTO sb_ob22 ( r020, ob22, txt) values ('7399','67', 'I��� ��������� �������' ) ;
exception when others then   if SQLCODE = - 00001 then null;   else raise; end if; -- ORA-00001: unique constraint (BARS.PK_CCVIDD) violated
end;
/
commit;
