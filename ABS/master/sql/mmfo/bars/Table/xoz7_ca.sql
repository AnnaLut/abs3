exec bpa.alter_policy_info( 'XOZ7_CA', 'WHOLE' , null, null, null, null ); 
exec bpa.alter_policy_info( 'XOZ7_CA', 'FILIAL', null, null, null, null );


begin  execute immediate ' CREATE TABLE BARS.XOZ7_CA (REc NUMBER, acc7 NUMBER, s7 NUMBER, kodz varchar2(10), ob40 varchar2(3), nazn varchar2(160) )  ' ;
exception when others then   if SQLCODE = - 00955 then null;   else raise; end if; --ORA-00955: name is already used by an existing object
end;
/

exec  bpa.alter_policies('XOZ7_CA'); 

COMMENT ON TABLE  BARS.XOZ7_CA      IS '������������ ������� � �� �� �� ��� ��� ������';
COMMENT ON COLUMN BARS.XOZ7_CA.rec  IS 'REC ���.������. �� ������� � ��';
COMMENT ON COLUMN BARS.XOZ7_CA.acc7 IS '��� ���� 7 �� � ��';
COMMENT ON COLUMN BARS.XOZ7_CA.s7   IS '����. �� ������������� � ����� ���';