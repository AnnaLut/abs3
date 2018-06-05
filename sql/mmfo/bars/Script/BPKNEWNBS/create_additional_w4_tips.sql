prompt Adding Tips for W4
begin
  execute immediate 'insert into tips (tip, name, ord)
                     values (''KSS'', ''W4.Кредит на БПК'', 1000)';
exception
  when others then
    if sqlcode = -1 then
      null;
    else
      raise;
    end if;
end;
/ 


begin
  execute immediate 'insert into tips(tip, name, ord)
                     values (''KR9'', ''W4.Невикор.ліміт.'', 1000)';
exception
  when others then
    if sqlcode = -1 then
      null;
    else
      raise;
    end if;
end;
/ 


begin
  execute immediate 'insert into tips (tip, name, ord)
                     values (''KK0'', ''W4.Нарахов.коміс.'', 1000)';
exception
  when others then
    if sqlcode = -1 then
      null;
    else
      raise;
    end if;
end;
/ 


begin
  execute immediate 'insert into tips (tip, name, ord)
                     values (''KKN'', ''W4.Нарахов.процн.'', 1000)';
exception
  when others then
    if sqlcode = -1 then
      null;
    else
      raise;
    end if;
end;
/ 


begin
  execute immediate 'insert into tips (tip, name, ord)
                     values (''KON'', ''W4.Нар.% за овер.'', 1000)';
exception
  when others then
    if sqlcode = -1 then
      null;
    else
      raise;
    end if;
end;
/ 


begin
  execute immediate 'insert into tips (tip, name, ord)
                     values (''KSP'', ''W4.Простр.кредит'', 1000)';
exception
  when others then
    if sqlcode = -1 then
      null;
    else
      raise;
    end if;
end;
/ 


begin
  execute immediate 'insert into tips (tip, name, ord)
                     values (''KK9'', ''W4.Простр.комісі'', 1000)';
exception
  when others then
    if sqlcode = -1 then
      null;
    else
      raise;
    end if;
end;
/ 


begin
  execute immediate 'insert into tips (tip, name, ord)
                     values (''KPN'', ''W4.Простр.процен'', 1000)';
exception
  when others then
    if sqlcode = -1 then
      null;
    else
      raise;
    end if;
end;
/ 


begin
  execute immediate 'insert into tips (tip, name, ord)
                     values (''KXN'', ''W4.Нар.% Х-оверд'', 1000)';
exception
  when others then
    if sqlcode = -1 then
      null;
    else
      raise;
    end if;
end;
/ 


begin
  execute immediate 'insert into tips (tip, name, ord)
                     values (''KW4'', ''W4.На вимогу Моб.'', 1000)';
exception
  when others then
    if sqlcode = -1 then
      null;
    else
      raise;
    end if;
end;
/ 


begin
  execute immediate 'insert into tips (tip, name, ord)
                     values (''KDN'', ''W4.Нар.% за кошт.'', 1000)';
exception
  when others then
    if sqlcode = -1 then
      null;
    else
      raise;
    end if;
end;
/

begin
    execute immediate 'insert into tips
  (tip, name, ord)
values
  (''W4G'', ''W4G.Картка Way4'', 1000)';
 exception when others then 
    if sqlcode = -1 then null; else raise; 
    end if; 
end;
/ 


begin
    execute immediate 'insert into tips
  (tip, name, ord)
values
  (''W4S'', ''W4S.Картка Way4'', 1000)';
 exception when others then 
    if sqlcode = -1 then null; else raise; 
    end if; 
end;
/ 


begin
    execute immediate 'insert into tips
  (tip, name, ord)
values
  (''W4W'', ''W4W.Картка Way4'', 1000)';
 exception when others then 
    if sqlcode = -1 then null; else raise; 
    end if; 
end;
/ 

