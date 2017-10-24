begin
    execute immediate 'INSERT INTO PASSP T (PASSP, NAME, PSPTYP, NRF, REZID)
  VALUES (95, ''Свідоцтво про смерть (закордонний)'', '' '', NULL, 2)';
 exception when others then 
    if sqlcode = -1 then null; else raise; 
    end if; 
end;
/ 


begin
    execute immediate 'INSERT INTO PASSP T (PASSP, NAME, PSPTYP, NRF, REZID)
  VALUES (96, ''Заповіт'', '' '', NULL, 1)';
 exception when others then 
    if sqlcode = -1 then null; else raise; 
    end if; 
end;
/ 


begin
    execute immediate 'INSERT INTO PASSP T (PASSP, NAME, PSPTYP, NRF, REZID)
  VALUES (97, ''Свідоцтво про спадщину'', '' '', NULL, 1)';
 exception when others then 
    if sqlcode = -1 then null; else raise; 
    end if; 
end;
/ 


begin
    execute immediate 'INSERT INTO PASSP T (PASSP, NAME, PSPTYP, NRF, REZID)
  VALUES (98, ''Свідоцтво про смерть'', '' '', NULL, 1)';
 exception when others then 
    if sqlcode = -1 then null; else raise; 
    end if; 
end;
/ 

begin
    execute immediate 'INSERT INTO PASSP T (PASSP, NAME, PSPTYP, NRF, REZID)
  VALUES (94, ''За рішенням суду'', '' '', NULL, 1)';
 exception when others then 
    if sqlcode = -1 then null; else raise; 
    end if; 
end;
/ 
