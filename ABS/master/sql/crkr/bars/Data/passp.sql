begin
    execute immediate 'INSERT INTO PASSP T (PASSP, NAME, PSPTYP, NRF, REZID)
  VALUES (95, ''�������� ��� ������ (�����������)'', '' '', NULL, 2)';
 exception when others then 
    if sqlcode = -1 then null; else raise; 
    end if; 
end;
/ 


begin
    execute immediate 'INSERT INTO PASSP T (PASSP, NAME, PSPTYP, NRF, REZID)
  VALUES (96, ''������'', '' '', NULL, 1)';
 exception when others then 
    if sqlcode = -1 then null; else raise; 
    end if; 
end;
/ 


begin
    execute immediate 'INSERT INTO PASSP T (PASSP, NAME, PSPTYP, NRF, REZID)
  VALUES (97, ''�������� ��� ��������'', '' '', NULL, 1)';
 exception when others then 
    if sqlcode = -1 then null; else raise; 
    end if; 
end;
/ 


begin
    execute immediate 'INSERT INTO PASSP T (PASSP, NAME, PSPTYP, NRF, REZID)
  VALUES (98, ''�������� ��� ������'', '' '', NULL, 1)';
 exception when others then 
    if sqlcode = -1 then null; else raise; 
    end if; 
end;
/ 

begin
    execute immediate 'INSERT INTO PASSP T (PASSP, NAME, PSPTYP, NRF, REZID)
  VALUES (94, ''�� ������� ����'', '' '', NULL, 1)';
 exception when others then 
    if sqlcode = -1 then null; else raise; 
    end if; 
end;
/ 
