begin
insert into zp_deals_sos(sos,name)  values (0,'�����');
exception when others then  
  if sqlcode = -00001 then null;   else raise; end if;   
end;
/
begin
insert into zp_deals_sos(sos,name)  values (5,'ĳ����');
exception when others then  
  if sqlcode = -00001 then null;   else raise; end if;   
end;
/
begin
insert into zp_deals_sos(sos,name)  values (1,'����� ������������ ��');
exception when others then  
  if sqlcode = -00001 then null;   else raise; end if;   
end;
/
begin
insert into zp_deals_sos(sos,name)  values (2,'³�������� ��');
exception when others then  
  if sqlcode = -00001 then null;   else raise; end if;   
end;
/
begin
insert into zp_deals_sos(sos,name)  values (-1,'��������');
exception when others then  
  if sqlcode = -00001 then null;   else raise; end if;   
end;
/
begin
insert into zp_deals_sos(sos,name)  values (-2,'���������');
exception when others then  
  if sqlcode = -00001 then null;   else raise; end if;   
end;
/
begin
insert into zp_deals_sos(sos,name)  values (3,'����� ������������ �������� ��� ��');
exception when others then  
  if sqlcode = -00001 then null;   else raise; end if;   
end;
/
begin
insert into zp_deals_sos(sos,name)  values (4,'������ ���� ������� ��');
exception when others then  
  if sqlcode = -00001 then null;   else raise; end if;   
end;
/
begin
insert into zp_deals_sos(sos,name)  values (6,'����� ������������ �������� ��');
exception when others then  
  if sqlcode = -00001 then null;   else raise; end if;   
end;
/
begin
insert into zp_deals_sos(sos,name)  values (7,'�������� �������� ��');
exception when others then  
  if sqlcode = -00001 then null;   else raise; end if;   
end;
/
commit;
/