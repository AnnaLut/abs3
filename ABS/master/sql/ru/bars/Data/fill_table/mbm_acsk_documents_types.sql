SET DEFINE OFF;

begin Insert into MBM_ACSK_DOCUMENTS_TYPES (ID, NAME) Values ( 1, 'Паспорт громадянина України');
exception when others then if (sqlcode = -1) then null; else raise; end if;
end;
/

begin Insert into MBM_ACSK_DOCUMENTS_TYPES (ID, NAME) Values ( 2, 'Закордонний паспорт');
exception when others then if (sqlcode = -1) then null; else raise; end if;
end;
/

begin Insert into MBM_ACSK_DOCUMENTS_TYPES (ID, NAME) Values ( 3, 'Паспорт громадянина іншої держави');
exception when others then if (sqlcode = -1) then null; else raise; end if;
end;
/

begin Insert into MBM_ACSK_DOCUMENTS_TYPES (ID, NAME) Values ( 4, 'Документ особи без громадянства');
exception when others then if (sqlcode = -1) then null; else raise; end if;
end;
/

begin Insert into MBM_ACSK_DOCUMENTS_TYPES (ID, NAME) Values ( 5, 'Інше');
exception when others then if (sqlcode = -1) then null; else raise; end if;
end;
/

COMMIT;
