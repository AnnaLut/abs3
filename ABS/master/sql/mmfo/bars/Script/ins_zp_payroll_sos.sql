begin
insert into zp_payroll_sos(sos,name)  values (1,'Прийнята');                  --Прийнята
exception when others then  
  if sqlcode = -00001 then null;   else raise; end if;   
end;
/
begin
insert into zp_payroll_sos(sos,name)  values (2,'Очікує підтвердження БО');  --Прийнята
exception when others then  
  if sqlcode = -00001 then null;   else raise; end if;   
end;
/
begin
insert into zp_payroll_sos(sos,name)  values (3,'Чернетка');  --Прийнята
exception when others then  
  if sqlcode = -00001 then null;   else raise; end if;   
end;
/
begin
insert into zp_payroll_sos(sos,name)  values (0,'Документи введені'); --оброблена
exception when others then  
  if sqlcode = -00001 then null;   else raise; end if;   
end;
/
begin
insert into zp_payroll_sos(sos,name)  values (5,'Оплачена');          --оброблена
exception when others then  
  if sqlcode = -00001 then null;   else raise; end if;   
end;
/
begin
insert into zp_payroll_sos(sos,name)  values (-1,'Відхилена');         --оброблена 
exception when others then  
  if sqlcode = -00001 then null;   else raise; end if;   
end;
/
begin
insert into zp_payroll_sos(sos,name)  values (-2,'Видалена');
exception when others then  
  if sqlcode = -00001 then null;   else raise; end if;   
end;
/
commit;
/