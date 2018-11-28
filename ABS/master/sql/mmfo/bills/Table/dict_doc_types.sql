Prompt create table DICT_DOC_TYPES;

begin
	execute immediate '
CREATE TABLE BILLS.DICT_DOC_TYPES
(
  ID           INTEGER NOT NULL,
  CODE         VARCHAR2(20),
  DESCRIPTION  VARCHAR2(100)
)';
exception
	when others then
		if sqlcode = -955 then null; else raise; end if;
end;
/
COMMENT ON TABLE BILLS.DICT_DOC_TYPES IS 'Типи документів, які зберігаються в системі';
COMMENT ON COLUMN BILLS.DICT_DOC_TYPES.ID IS 'Ід типу';
COMMENT ON COLUMN BILLS.DICT_DOC_TYPES.CODE IS 'Код типу';
COMMENT ON COLUMN BILLS.DICT_DOC_TYPES.DESCRIPTION IS 'Опис типу';


Prompt Index DICT_DOC_TYPE_PK;
begin
	execute immediate '
CREATE UNIQUE INDEX BILLS.DICT_DOC_TYPE_PK ON BILLS.DICT_DOC_TYPES (ID)';
exception
	when others then
		if sqlcode = -955 then null; else raise; end if;
end;
/

Prompt Index XAK_DICT_DOC_TYPE;
begin
	execute immediate '
CREATE UNIQUE INDEX BILLS.XAK_DICT_DOC_TYPE ON BILLS.DICT_DOC_TYPES (CODE)';
exception
	when others then
		if sqlcode = -955 then null; else raise; end if;
end;
/
Prompt CONSTRAINT DICT_DOC_TYPE_PK;
begin
	execute immediate '
ALTER TABLE BILLS.DICT_DOC_TYPES ADD ( CONSTRAINT DICT_DOC_TYPE_PK PRIMARY KEY (ID) USING INDEX BILLS.DICT_DOC_TYPE_PK ENABLE VALIDATE)';
exception
	when others then
		if sqlcode = -2260 then null; else raise; end if;
end;
/