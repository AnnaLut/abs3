begin
  bpa.alter_policy_info('lic_nbs_dksu','FILIAL',null,null,null,null);
  bpa.alter_policy_info('lic_nbs_dksu','WHOLE',null,null,null,null);
  
end;
/



begin 
  execute immediate 
    ' CREATE TABLE BARS.lic_nbs_dksu'||
    ' ('||
    '   NBS      CHAR(4 Byte)'||
    ' )'||
    ' TABLESPACE BRSSMLD'||
    ' RESULT_CACHE (MODE DEFAULT)'||
    ' PCTUSED    0'||
    ' PCTFREE    10'||
    ' INITRANS   1'||
    ' MAXTRANS   255'||
    ' STORAGE    ('||
    '             INITIAL          64K'||
    '             NEXT             64K'||
    '             MAXSIZE          UNLIMITED'||
    '             MINEXTENTS       1'||
    '             MAXEXTENTS       UNLIMITED'||
    '             PCTINCREASE      0'||
    '             BUFFER_POOL      DEFAULT'||
    '             FLASH_CACHE      DEFAULT'||
    '             CELL_FLASH_CACHE DEFAULT'||
    '            )'||
    ' LOGGING '||
    ' NOCOMPRESS '||
    ' NOCACHE'||
    ' NOPARALLEL'||
    ' MONITORING';
exception when others then 
  if sqlcode=-955 then null; else raise; end if;
end;
/
begin 
  execute immediate 
    ' CREATE UNIQUE INDEX BARS.PK_NBS_DKSU_LIC ON BARS.lic_nbs_dksu'||
    ' (NBS)'||
    ' LOGGING'||
    ' TABLESPACE BRSSMLI'||
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

begin 
  execute immediate 
    ' ALTER TABLE BARS.lic_nbs_dksu ADD ('||
    '     CONSTRAINT PK_NBS_DKSU'||
    '   PRIMARY KEY'||
    '   (NBS)'||
    '   USING INDEX BARS.PK_NBS_DKSU_LIC'||
    '   ENABLE VALIDATE) ';
exception when others then 
  if sqlcode=-2260 or sqlcode=-2261 then null; else raise; end if;
end;
/

COMMENT ON COLUMN lic_nbs_dksu.NBS  IS 'аюк.явер';

GRANT INSERT, SELECT, UPDATE ON BARS.lic_nbs_dksu TO BARS_ACCESS_DEFROLE;

GRANT INSERT, SELECT, UPDATE ON BARS.lic_nbs_dksu TO START1;

GRANT SELECT, FLASHBACK ON BARS.lic_nbs_dksu TO WR_REFREAD;

