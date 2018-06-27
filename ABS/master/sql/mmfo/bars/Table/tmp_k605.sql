begin execute immediate 'CREATE TABLE tmp_K605 ( md int, nd number , G01 date , G02 number, G03 number,  G04 number, G05 number,  G06 number, G07 int,  G08 number,  G09 number, G10 number, G11 number, NCOL  INT) ' ;
exception when others then   if SQLCODE = - 00955 then null;   else raise; end if; --ORA-00955: name is already used by an existing object
end;
/

begin   execute immediate 'alter table    tmp_K605  add ( NCOL int )';
exception when others then     if sqlcode= -01430 then null; else raise; end if; -- ORA-01430: column being added already exists in table
end; 
/

COMMENT ON TABLE  tmp_K605      IS 'COBUSUPABS-5819.���������� ����������� ������������� � ���� ';
COMMENT ON COLUMN tmp_K605.ND   IS '��� ���';                                        
COMMENT ON COLUMN tmp_K605.G01  IS '���� ��������';                                        
COMMENT ON COLUMN tmp_K605.G02  IS '���� ���������� ����';                                        
COMMENT ON COLUMN tmp_K605.G03  IS '���� ��������� ������� �� ����, �� �������� �����, ����� ���';                                        
COMMENT ON COLUMN tmp_K605.G04  IS '���� �������� ����';                                        
COMMENT ON COLUMN tmp_K605.G05  IS '������� �������������';                                        
COMMENT ON COLUMN tmp_K605.G06  IS '������� ����������� �������������';                                        
COMMENT ON COLUMN tmp_K605.G07  IS '�-�� ��� ����������';                                        
COMMENT ON COLUMN tmp_K605.G08  IS '����� ���';                                        
COMMENT ON COLUMN tmp_K605.G09  IS '���� ���';                                        
COMMENT ON COLUMN tmp_K605.G10  IS '3% �����';                                        
COMMENT ON COLUMN tmp_K605.G11  IS '���� 3% �����';
COMMENT ON COLUMN TMP_K605.NCOL IS '���� ������';                                        

grant select on  tmp_K605 to BARS_ACCESS_DEFROLE ;
