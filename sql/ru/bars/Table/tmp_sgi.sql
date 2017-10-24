begin
  execute immediate 'ALTER TABLE TMP_SGI DROP PRIMARY KEY CASCADE';
exception when others then
  if sqlcode in (-14450,-942) then
    null;
  else
    raise;
  end if;
end;
/



begin
  execute immediate 'DROP TABLE TMP_SGI CASCADE CONSTRAINTS';
exception when others then
  if sqlcode in (-14452,-942) then
    null;
  else
    raise;
  end if;
end;
/


begin
  execute immediate 'CREATE GLOBAL TEMPORARY TABLE TMP_SGI
                     (ID        NUMBER,
                      BIN_DATA  BLOB,
                      TXT_DATA  CLOB)
                     ON COMMIT PRESERVE ROWS
                     NOCACHE';
exception when others then
  if sqlcode=-955 then
    null;
  else
    raise;
  end if;
end;
/


begin
  execute immediate 'CREATE UNIQUE INDEX PK_TMP_SGI ON TMP_SGI (ID)';
exception when others then
  if sqlcode=-955 then
    null;
  else
    raise;
  end if;
end;
/


begin
  execute immediate 'DROP PUBLIC SYNONYM TMP_SGI';
exception when others then
  if sqlcode=-1432 then
    null;
  else
    raise;
  end if;
end;
/


begin
  execute immediate 'CREATE PUBLIC SYNONYM TMP_SGI FOR TMP_SGI';
exception when others then
  if sqlcode=-955 then
    null;
  else
    raise;
  end if;
end;
/


begin
  execute immediate 'ALTER TABLE TMP_SGI ADD (CONSTRAINT PK_TMP_SGI
                     PRIMARY KEY
                     (ID)
                     USING INDEX PK_TMP_SGI)';
exception when others then
  if sqlcode in (-14450,-2275) then
    null;
  else
    raise;
  end if;
end;
/


GRANT DELETE, INSERT, SELECT, UPDATE ON TMP_SGI TO start1;
