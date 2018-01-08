

PROMPT ===================================================================================== 
PROMPT *** Run *** ========== Scripts /Sql/BARSAQ/Table/MONEX_UO.sql =========*** Run *** ==
PROMPT ===================================================================================== 


PROMPT *** Create  table MONEX_UO ***
begin 
  execute immediate '
  CREATE TABLE BARSAQ.MONEX_UO 
   (	ID NUMBER, 
	NAME VARCHAR2(38), 
	MFO VARCHAR2(6), 
	NLS VARCHAR2(15), 
	OKPO VARCHAR2(10), 
	RNK NUMBER
   ) SEGMENT CREATION IMMEDIATE 
  PCTFREE 10 PCTUSED 40 INITRANS 1 MAXTRANS 255 
 NOCOMPRESS LOGGING
  TABLESPACE AQTS ';
exception when others then       
  if sqlcode=-955 then null; else raise; end if; 
end; 
/


COMMENT ON TABLE BARSAQ.MONEX_UO IS 'Довідник ЮО, що працюють в СТП';
COMMENT ON COLUMN BARSAQ.MONEX_UO.ID IS '№ пп';
COMMENT ON COLUMN BARSAQ.MONEX_UO.NAME IS 'Назва ЮО, що працює в СТП';
COMMENT ON COLUMN BARSAQ.MONEX_UO.MFO IS 'Пл.рекв.МФО';
COMMENT ON COLUMN BARSAQ.MONEX_UO.NLS IS 'Пл.рекв.Рах.';
COMMENT ON COLUMN BARSAQ.MONEX_UO.OKPO IS 'Пл.рекв.Ід.код';
COMMENT ON COLUMN BARSAQ.MONEX_UO.RNK IS 'РНК';




PROMPT *** Create  constraint CC_MONEXUO_ID_NN ***
begin   
 execute immediate '
  ALTER TABLE BARSAQ.MONEX_UO MODIFY (ID CONSTRAINT CC_MONEXUO_ID_NN NOT NULL ENABLE)';
exception when others then
  if  sqlcode=-2260 or sqlcode=-2261 or sqlcode=-2264 or sqlcode=-2275 or sqlcode=-1442 then null; else raise; end if;
 end;
/




PROMPT *** Create  constraint CC_MONEXUO_NAME_NN ***
begin   
 execute immediate '
  ALTER TABLE BARSAQ.MONEX_UO MODIFY (NAME CONSTRAINT CC_MONEXUO_NAME_NN NOT NULL ENABLE)';
exception when others then
  if  sqlcode=-2260 or sqlcode=-2261 or sqlcode=-2264 or sqlcode=-2275 or sqlcode=-1442 then null; else raise; end if;
 end;
/




PROMPT *** Create  constraint XPK_MONEXUO ***
begin   
 execute immediate '
  ALTER TABLE BARSAQ.MONEX_UO ADD CONSTRAINT XPK_MONEXUO PRIMARY KEY (ID)
  USING INDEX PCTFREE 10 INITRANS 2 MAXTRANS 255 COMPUTE STATISTICS 
  TABLESPACE AQTS  ENABLE';
exception when others then
  if  sqlcode=-2260 or sqlcode=-2261 or sqlcode=-2264 or sqlcode=-2275 or sqlcode=-1442 then null; else raise; end if;
 end;
/




PROMPT *** Create  index XPK_MONEXUO ***
begin   
 execute immediate '
  CREATE UNIQUE INDEX BARSAQ.XPK_MONEXUO ON BARSAQ.MONEX_UO (ID) 
  PCTFREE 10 INITRANS 2 MAXTRANS 255 COMPUTE STATISTICS 
  TABLESPACE AQTS ';
exception when others then
  if  sqlcode=-955  then null; else raise; end if;
 end;
/



PROMPT *** Create  grants  MONEX_UO ***
grant ALTER,DEBUG,DELETE,FLASHBACK,INSERT,ON COMMIT REFRESH,QUERY REWRITE,SELECT,UPDATE on MONEX_UO        to START1;



PROMPT ===================================================================================== 
PROMPT *** End *** ========== Scripts /Sql/BARSAQ/Table/MONEX_UO.sql =========*** End *** ==
PROMPT ===================================================================================== 
