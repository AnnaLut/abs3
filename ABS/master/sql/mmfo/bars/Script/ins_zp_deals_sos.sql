begin
insert into zp_deals_sos(sos,name)  values (0,'Новий');
exception when others then  
  if sqlcode = -00001 then null;   else raise; end if;   
end;
/
begin
insert into zp_deals_sos(sos,name)  values (5,'Діючий');
exception when others then  
  if sqlcode = -00001 then null;   else raise; end if;   
end;
/
begin
insert into zp_deals_sos(sos,name)  values (1,'Очікує підтвердження БО');
exception when others then  
  if sqlcode = -00001 then null;   else raise; end if;   
end;
/
begin
insert into zp_deals_sos(sos,name)  values (2,'Відхилений БО');
exception when others then  
  if sqlcode = -00001 then null;   else raise; end if;   
end;
/
begin
insert into zp_deals_sos(sos,name)  values (-1,'Закритий');
exception when others then  
  if sqlcode = -00001 then null;   else raise; end if;   
end;
/
begin
insert into zp_deals_sos(sos,name)  values (-2,'Видалений');
exception when others then  
  if sqlcode = -00001 then null;   else raise; end if;   
end;
/
begin
insert into zp_deals_sos(sos,name)  values (3,'Очікує підтвердження внесених змін БО');
exception when others then  
  if sqlcode = -00001 then null;   else raise; end if;   
end;
/
begin
insert into zp_deals_sos(sos,name)  values (4,'Внесені зміни відхилені БО');
exception when others then  
  if sqlcode = -00001 then null;   else raise; end if;   
end;
/
begin
insert into zp_deals_sos(sos,name)  values (6,'Очікує підтвердження закриття БО');
exception when others then  
  if sqlcode = -00001 then null;   else raise; end if;   
end;
/
begin
insert into zp_deals_sos(sos,name)  values (7,'Закриття відхилене БО');
exception when others then  
  if sqlcode = -00001 then null;   else raise; end if;   
end;
/
commit;
/