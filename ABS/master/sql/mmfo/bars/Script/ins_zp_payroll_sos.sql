begin
insert into zp_payroll_sos(sos,name)  values (1,'��������');                  --��������
exception when others then  
  if sqlcode = -00001 then null;   else raise; end if;   
end;
/
begin
insert into zp_payroll_sos(sos,name)  values (2,'����� ������������ ��');  --��������
exception when others then  
  if sqlcode = -00001 then null;   else raise; end if;   
end;
/
begin
insert into zp_payroll_sos(sos,name)  values (3,'��������');  --��������
exception when others then  
  if sqlcode = -00001 then null;   else raise; end if;   
end;
/
begin
insert into zp_payroll_sos(sos,name)  values (0,'��������� ������'); --���������
exception when others then  
  if sqlcode = -00001 then null;   else raise; end if;   
end;
/
begin
insert into zp_payroll_sos(sos,name)  values (5,'��������');          --���������
exception when others then  
  if sqlcode = -00001 then null;   else raise; end if;   
end;
/
begin
insert into zp_payroll_sos(sos,name)  values (-1,'³�������');         --��������� 
exception when others then  
  if sqlcode = -00001 then null;   else raise; end if;   
end;
/
begin
insert into zp_payroll_sos(sos,name)  values (-2,'��������');
exception when others then  
  if sqlcode = -00001 then null;   else raise; end if;   
end;
/
commit;
/