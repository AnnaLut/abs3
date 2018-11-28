Prompt create table DICT_STATUS;

begin
	execute immediate '
CREATE TABLE BILLS.DICT_STATUS
(
  CODE  VARCHAR2(2 BYTE),
  NAME  VARCHAR2(100 BYTE),
  TYPE  VARCHAR2(1 BYTE), 
  CONSTRAINT XPK_DICT_STATUS
  PRIMARY KEY
  (TYPE, CODE)
  ENABLE VALIDATE
)
ORGANIZATION INDEX';
exception
	when others then
		if sqlcode = -955 then null; else raise; end if;
end;
/
