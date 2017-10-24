SET DEFINE OFF;

begin Insert into MBM_ACSK_REGIONS (ID, NAME) Values (1, 'Київ');
exception when others then if (sqlcode = -1) then null; else raise; end if;
end;
/

begin Insert into MBM_ACSK_REGIONS (ID, NAME) Values (2, 'Волинська обл');
exception when others then if (sqlcode = -1) then null; else raise; end if;
end;
/

begin Insert into MBM_ACSK_REGIONS (ID, NAME) Values ( 3, 'Вінницька обл');
exception when others then if (sqlcode = -1) then null; else raise; end if;
end;
/

begin Insert into MBM_ACSK_REGIONS (ID, NAME) Values ( 4, 'Дніпропетровська обл');
exception when others then if (sqlcode = -1) then null; else raise; end if;
end;
/

begin Insert into MBM_ACSK_REGIONS (ID, NAME) Values ( 5, 'Донецька обл');
exception when others then if (sqlcode = -1) then null; else raise; end if;
end;
/

begin Insert into MBM_ACSK_REGIONS (ID, NAME) Values ( 6, 'Житомирська обл');
exception when others then if (sqlcode = -1) then null; else raise; end if;
end;
/

begin Insert into MBM_ACSK_REGIONS (ID, NAME) Values ( 7, 'Закарпатська обл');
exception when others then if (sqlcode = -1) then null; else raise; end if;
end;
/

begin Insert into MBM_ACSK_REGIONS (ID, NAME) Values ( 8, 'Запорізька обл');
exception when others then if (sqlcode = -1) then null; else raise; end if;
end;
/

begin Insert into MBM_ACSK_REGIONS (ID, NAME) Values ( 9, 'Івано-Франківська обл');
exception when others then if (sqlcode = -1) then null; else raise; end if;
end;
/

begin Insert into MBM_ACSK_REGIONS (ID, NAME) Values ( 10, 'Кіровоградська обл');
exception when others then if (sqlcode = -1) then null; else raise; end if;
end;
/

begin Insert into MBM_ACSK_REGIONS (ID, NAME) Values ( 11, 'Київська обл');
exception when others then if (sqlcode = -1) then null; else raise; end if;
end;
/

begin Insert into MBM_ACSK_REGIONS (ID, NAME) Values ( 12, 'Львівська обл');
exception when others then if (sqlcode = -1) then null; else raise; end if;
end;
/

begin Insert into MBM_ACSK_REGIONS (ID, NAME) Values ( 13, 'Луганська обл');
exception when others then if (sqlcode = -1) then null; else raise; end if;
end;
/

begin Insert into MBM_ACSK_REGIONS (ID, NAME) Values ( 14, 'Миколаївська обл');
exception when others then if (sqlcode = -1) then null; else raise; end if;
end;
/

begin Insert into MBM_ACSK_REGIONS (ID, NAME) Values ( 15, 'Одеська обл');
exception when others then if (sqlcode = -1) then null; else raise; end if;
end;
/

begin Insert into MBM_ACSK_REGIONS (ID, NAME) Values ( 16, 'Полтавська обл');
exception when others then if (sqlcode = -1) then null; else raise; end if;
end;
/

begin Insert into MBM_ACSK_REGIONS (ID, NAME) Values ( 17, 'Рівенська обл');
exception when others then if (sqlcode = -1) then null; else raise; end if;
end;
/

begin Insert into MBM_ACSK_REGIONS (ID, NAME) Values ( 18, 'Сумська обл');
exception when others then if (sqlcode = -1) then null; else raise; end if;
end;
/

begin Insert into MBM_ACSK_REGIONS (ID, NAME) Values ( 19, 'Тернопільська обл');
exception when others then if (sqlcode = -1) then null; else raise; end if;
end;
/

begin Insert into MBM_ACSK_REGIONS (ID, NAME) Values ( 20, 'Черкаська обл');
exception when others then if (sqlcode = -1) then null; else raise; end if;
end;
/

begin Insert into MBM_ACSK_REGIONS (ID, NAME) Values ( 21, 'Чернівецька обл');
exception when others then if (sqlcode = -1) then null; else raise; end if;
end;
/

begin Insert into MBM_ACSK_REGIONS (ID, NAME) Values ( 22, 'Чернігівська обл');
exception when others then if (sqlcode = -1) then null; else raise; end if;
end;
/

begin Insert into MBM_ACSK_REGIONS (ID, NAME) Values ( 23, 'Харківська обл');
exception when others then if (sqlcode = -1) then null; else raise; end if;
end;
/

begin Insert into MBM_ACSK_REGIONS (ID, NAME) Values ( 24, 'Херсонська обл');
exception when others then if (sqlcode = -1) then null; else raise; end if;
end;
/

begin Insert into MBM_ACSK_REGIONS (ID, NAME) Values ( 25, 'Хмельницька обл');
exception when others then if (sqlcode = -1) then null; else raise; end if;
end;
/

begin Insert into MBM_ACSK_REGIONS (ID, NAME) Values ( 26, 'АРК Крим');
exception when others then if (sqlcode = -1) then null; else raise; end if;
end;
/

begin Insert into MBM_ACSK_REGIONS (ID, NAME) Values ( 27, 'Севастополь');
exception when others then if (sqlcode = -1) then null; else raise; end if;
end;
/

COMMIT;