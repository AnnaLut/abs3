prompt Adding Tips for W4
begin
  execute immediate 'insert into tips (tip, name, ord)
                     values (''KSS'', ''W4.������ �� ���'', 1000)';
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
                     values (''KR9'', ''W4.�������.���.'', 1000)';
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
                     values (''KK0'', ''W4.�������.����.'', 1000)';
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
                     values (''KKN'', ''W4.�������.�����.'', 1000)';
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
                     values (''KON'', ''W4.���.% �� ����.'', 1000)';
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
                     values (''KSP'', ''W4.������.������'', 1000)';
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
                     values (''KK9'', ''W4.������.����'', 1000)';
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
                     values (''KPN'', ''W4.������.������'', 1000)';
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
                     values (''KXN'', ''W4.���.% �-�����'', 1000)';
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
                     values (''KW4'', ''W4.�� ������ ���.'', 1000)';
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
                     values (''KDN'', ''W4.���.% �� ����.'', 1000)';
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
  (''W4G'', ''W4G.������ Way4'', 1000)';
 exception when others then 
    if sqlcode = -1 then null; else raise; 
    end if; 
end;
/ 


begin
    execute immediate 'insert into tips
  (tip, name, ord)
values
  (''W4S'', ''W4S.������ Way4'', 1000)';
 exception when others then 
    if sqlcode = -1 then null; else raise; 
    end if; 
end;
/ 


begin
    execute immediate 'insert into tips
  (tip, name, ord)
values
  (''W4W'', ''W4W.������ Way4'', 1000)';
 exception when others then 
    if sqlcode = -1 then null; else raise; 
    end if; 
end;
/ 

