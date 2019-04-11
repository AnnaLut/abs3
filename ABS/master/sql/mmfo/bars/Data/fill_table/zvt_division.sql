prompt Importing table zvt_division...

begin
begin insert into ZVT_DIVISION (division_id, name) values (1, 'Управління супроводження операцій з платіжними картами'); exception when others then null; end;
begin insert into ZVT_DIVISION (division_id, name) values (2, 'Управління супроводження рахунків корпоративного і ММСБ'); exception when others then null; end;
begin insert into ZVT_DIVISION (division_id, name) values (3, 'Управління супроводження активних операцій корпоративного бізнесу'); exception when others then null; end;
begin insert into ZVT_DIVISION (division_id, name) values (4, 'Регіональне управління'); exception when others then null; end;
begin insert into ZVT_DIVISION (division_id, name) values (5, 'Управління супроводження та контролю активних операцій роздрібного і ММСБ'); exception when others then null; end;
begin insert into ZVT_DIVISION (division_id, name) values (6, 'Управління супроводження та контролю касових операцій'); exception when others then null; end;
begin insert into ZVT_DIVISION (division_id, name) values (7, 'Управління обліку внутрішньобанківських операцій центрального апарату банку'); exception when others then null; end;
begin insert into ZVT_DIVISION (division_id, name) values (8, 'Управління супроводження рахунків банків і казначейських операцій'); exception when others then null; end;
begin insert into ZVT_DIVISION (division_id, name) values (9, 'Управління супроводження та контролю пасивних операцій роздрібного бізнесу'); exception when others then null; end;
begin insert into ZVT_DIVISION (division_id, name) values (10, 'Управління супроводження платежів'); exception when others then null; end;
end;
/
commit;
prompt Done.