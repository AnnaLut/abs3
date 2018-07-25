begin
BARS_POLICY_ADM.ALTER_POLICY_INFO('SW_STATUSES', 'WHOLE', null, null, null, null);
BARS_POLICY_ADM.ALTER_POLICY_INFO('SW_STATUSES', 'FILIAL', null, null, null, null);
end;
/
commit
/
begin
execute immediate 'create table sw_statuses(id number, value varchar2(32), description varchar2(250))';
exception when others then if(sqlcode=-955) then null; else raise; end if;
end;
/
begin
execute immediate 'CREATE UNIQUE INDEX BARS.PK_SW_STATUSES ON BARS.SW_STATUSES
(ID, VALUE)
LOGGING
TABLESPACE BRSSMLI
STORAGE    (
            BUFFER_POOL      DEFAULT
            FLASH_CACHE      DEFAULT
            CELL_FLASH_CACHE DEFAULT
           )
NOPARALLEL';
exception when others then if(sqlcode=-955) then null; else raise; end if;
end;
/

begin
execute immediate 'ALTER TABLE BARS.SW_STATUSES
  ADD CONSTRAINT PK_SW_STATUSES
  PRIMARY KEY (ID, VALUE)';
exception when others then if(sqlcode=-2260) then null; else raise; end if;
end;
/


begin
BARS_POLICY_ADM.ALTER_POLICIES('SW_STATUSES');
end;
/
commit
/

