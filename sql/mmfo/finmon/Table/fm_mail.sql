

PROMPT ===================================================================================== 
PROMPT *** Run *** ========== Scripts /Sql/FINMON/Table/FM_MAIL.sql =========*** Run *** ===
PROMPT ===================================================================================== 


PROMPT *** Create  table FM_MAIL ***
begin 
  execute immediate '
  CREATE TABLE FINMON.FM_MAIL 
   (	W_MAIL VARCHAR2(256), 
	ALT_MAIL VARCHAR2(256), 
	FONE VARCHAR2(13), 
	FIO VARCHAR2(256), 
	BLK NUMBER(1,0) DEFAULT 0
   ) SEGMENT CREATION DEFERRED 
  PCTFREE 10 PCTUSED 40 INITRANS 1 MAXTRANS 255 
 NOCOMPRESS LOGGING
  TABLESPACE BRSSMLD ';
exception when others then       
  if sqlcode=-955 then null; else raise; end if; 
end; 
/


COMMENT ON TABLE FINMON.FM_MAIL IS '';
COMMENT ON COLUMN FINMON.FM_MAIL.W_MAIL IS 'Рабочий почтовый ящик';
COMMENT ON COLUMN FINMON.FM_MAIL.ALT_MAIL IS 'Внешний почтовый ящик';
COMMENT ON COLUMN FINMON.FM_MAIL.FONE IS 'телефон для получения смс Формат "+380ХХХХХХХХХ"';
COMMENT ON COLUMN FINMON.FM_MAIL.FIO IS 'ФИО';
COMMENT ON COLUMN FINMON.FM_MAIL.BLK IS '0 - не блокирован / 1 - блокирован';




PROMPT *** Create  constraint SYS_C0032144 ***
begin   
 execute immediate '
  ALTER TABLE FINMON.FM_MAIL MODIFY (W_MAIL NOT NULL ENABLE)';
exception when others then
  if  sqlcode=-2260 or sqlcode=-2261 or sqlcode=-2264 or sqlcode=-2275 or sqlcode=-1442 then null; else raise; end if;
 end;
/




PROMPT *** Create  constraint SYS_C0032145 ***
begin   
 execute immediate '
  ALTER TABLE FINMON.FM_MAIL MODIFY (FIO NOT NULL ENABLE)';
exception when others then
  if  sqlcode=-2260 or sqlcode=-2261 or sqlcode=-2264 or sqlcode=-2275 or sqlcode=-1442 then null; else raise; end if;
 end;
/



PROMPT *** Create  grants  FM_MAIL ***
grant ALTER,DEBUG,DELETE,FLASHBACK,INDEX,INSERT,ON COMMIT REFRESH,QUERY REWRITE,REFERENCES,SELECT,UPDATE on FM_MAIL         to BARS;



PROMPT ===================================================================================== 
PROMPT *** End *** ========== Scripts /Sql/FINMON/Table/FM_MAIL.sql =========*** End *** ===
PROMPT ===================================================================================== 
