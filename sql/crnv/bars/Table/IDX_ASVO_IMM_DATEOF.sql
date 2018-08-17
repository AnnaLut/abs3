begin 
  execute immediate 
    ' CREATE INDEX BARS.IDX_ASVOIMMOBILE_DATEOF ON BARS.ASVO_IMMOBILE'||
    ' (DATE_OFF)'||
    ' NOLOGGING'||
    ' TABLESPACE BRSDYND'||
    ' PCTFREE    10'||
    ' INITRANS   2'||
    ' MAXTRANS   255'||
    ' STORAGE    ('||
    '             INITIAL          128K'||
    '             NEXT             128K'||
    '             MAXSIZE          UNLIMITED'||
    '             MINEXTENTS       1'||
    '             MAXEXTENTS       UNLIMITED'||
    '             PCTINCREASE      0'||
    '             BUFFER_POOL      DEFAULT'||
    '             FLASH_CACHE      DEFAULT'||
    '             CELL_FLASH_CACHE DEFAULT'||
    '            )'||
    ' NOPARALLEL';
exception when others then 
  if sqlcode=-955 then null; else raise; end if;
end;
/