begin
delete from sw_statuses;
--
Insert into SW_STATUSES(id,value, description) values(-1,'WAITING', '������� ���������� �� ������� � 3720');
insert into sw_statuses(id,value, description) values(0, 'CREATED','������ ��199');
insert into sw_statuses(id,value, description) values(1, 'ACSC','���������� ��� ����������');
insert into sw_statuses(id,value, description) values(2, 'RJCT','���������� ���� ���������');
insert into sw_statuses(id,value, description) values(3, 'ACSP/000','������, ���������� ���������� ������ GPI');
insert into sw_statuses(id,value, description) values(4, 'ACSP/001','������, ���������� ������, �� ������������ � GPI');
insert into sw_statuses(id,value, description) values(5, 'ACSP/002','������ �� ���� ���������� �� ����� ���� ����������� � ��� �� ����');
insert into sw_statuses(id,value, description) values(6, 'ACSP/003','������ �� ���� ���������� ������������� �� ��������� ����������� ����������');
insert into sw_statuses(id,value, description) values(7, 'ACSP/004','������ �� ���� ���������� �������������, ��������� ��������');
end;
/
commit
/

Prompt CREATE INDEX BARS.i_swjournal_uetr ON BARS.SW_JOURNAL;

begin
execute immediate 
'CREATE INDEX BARS.i_swjournal_uetr ON BARS.SW_JOURNAL
(UETR)
LOGGING
TABLESPACE BRSSMLI
STORAGE    (
            BUFFER_POOL      DEFAULT
            FLASH_CACHE      DEFAULT
            CELL_FLASH_CACHE DEFAULT
           )NOPARALLEL';
   exception when others then if sqlcode=-955 then null; else raise; end if;
     
end;
/

