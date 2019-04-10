prompt Loading ZVT_SECTOR...

begin
begin insert into ZVT_SECTOR (sector_id, name) values (1, 'Сектор супроводження касових операцій'); exception when others then null; end;
begin insert into ZVT_SECTOR (sector_id, name) values (2, 'Сектор контролю операцій та перевірки щоденної звітності'); exception when others then null; end;
begin insert into ZVT_SECTOR (sector_id, name) values (3, 'Сектор сканування документів'); exception when others then null; end;
begin insert into ZVT_SECTOR (sector_id, name) values (4, 'Сектор супроводження касових та інших операцій'); exception when others then null; end;
begin insert into ZVT_SECTOR (sector_id, name) values (5, 'Сектор організації бухгалтерського обліку, звітності та контролю'); exception when others then null; end;
begin insert into ZVT_SECTOR (sector_id, name) values (6, 'Сектор податкового обліку'); exception when others then null; end;
begin insert into ZVT_SECTOR (sector_id, name) values (7, 'Сектор супроводження кредитних операцій фізичних осіб'); exception when others then null; end;
begin insert into ZVT_SECTOR (sector_id, name) values (8, 'Сектор супроводження операцій за платіжними картками'); exception when others then null; end;
begin insert into ZVT_SECTOR (sector_id, name) values (9, 'Сектор супроводження рахунків юридичних осіб'); exception when others then null; end;
begin insert into ZVT_SECTOR (sector_id, name) values (10, 'Сектор обліку господарських операцій'); exception when others then null; end;
begin insert into ZVT_SECTOR (sector_id, name) values (11, 'Сектор оплати праці'); exception when others then null; end;
begin insert into ZVT_SECTOR (sector_id, name) values (12, 'Сектор супроводження вкладних (депозитних) операцій'); exception when others then null; end;
begin insert into ZVT_SECTOR (sector_id, name) values (13, 'Сектор супроводження кредитних операцій юридичних осіб'); exception when others then null; end;

end;
/
commit;
prompt Done.
