
PROMPT *** Drop index IDX_SALDOA_KF_FDAT_ACC ***
declare
    index_doesnt_exist exception;
    pragma exception_init(index_doesnt_exist, -1418);
begin
    execute immediate 'DROP INDEX BARS.IDX_SALDOA_KF_FDAT_ACC';
exception
    when index_doesnt_exist then
         null;
end;
/

PROMPT *** Drop constraint FK_SALDOA_ACCOUNTS2 ***
declare
    constraint_doesnt_exist exception;
    pragma exception_init(constraint_doesnt_exist, -2443);
begin
    execute immediate 'ALTER TABLE BARS.SALDOA drop CONSTRAINT FK_SALDOA_ACCOUNTS2';
exception
    when constraint_doesnt_exist then
         null;
end;
/


PROMPT *** Create constraint FK_SALDOA_ACCOUNTS2 ***
declare
    constraint_already_exists exception;
    pragma exception_init(constraint_already_exists, -2275);
begin
    execute immediate 'ALTER TABLE BARS.SALDOA ADD CONSTRAINT FK_SALDOA_ACCOUNTS2 FOREIGN KEY (ACC) REFERENCES BARS.ACCOUNTS (ACC) ENABLE NOVALIDATE';
exception
    when constraint_already_exists then
         null;
end;
/


