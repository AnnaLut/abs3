begin 
  execute immediate 
    ' CREATE INDEX BARS.IDX_ASVOIMMOBILE_DZAGR ON BARS.ASVO_IMMOBILE'||
    ' (DZAGR)'||
    ' NOLOGGING'||
    ' STORAGE    ('||
    '             BUFFER_POOL      DEFAULT'||
    '             FLASH_CACHE      DEFAULT'||
    '             CELL_FLASH_CACHE DEFAULT'||
    '            )'||
    ' NOPARALLEL';
	exception when others then 
  if sqlcode=-955 then null; else raise; end if;
end;
/