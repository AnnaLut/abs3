

PROMPT ===================================================================================== 
PROMPT *** Run *** ========== Scripts /Sql/BARSAQ/Table/ZAYAVKA_ID_MAP.sql =========*** Run 
PROMPT ===================================================================================== 


PROMPT *** Create  table ZAYAVKA_ID_MAP ***
begin 
  execute immediate '
  CREATE TABLE BARSAQ.ZAYAVKA_ID_MAP 
   (	IDZ NUMBER(*,0), 
	DOC_ID NUMBER(*,0), 
	SIGN01 VARCHAR2(200), 
	SIGN02 VARCHAR2(200), 
	 CONSTRAINT PK_ZIDMAP PRIMARY KEY (IDZ) ENABLE
   ) ORGANIZATION INDEX NOCOMPRESS PCTFREE 10 INITRANS 2 MAXTRANS 255 LOGGING
  TABLESPACE BRSDYND 
 PCTTHRESHOLD 50';
exception when others then       
  if sqlcode=-955 then null; else raise; end if; 
end; 
/


COMMENT ON TABLE BARSAQ.ZAYAVKA_ID_MAP IS 'Заявки на купівлю/продаж валюти - Первинні документи';
COMMENT ON COLUMN BARSAQ.ZAYAVKA_ID_MAP.SIGN01 IS 'ПІБ першого підписанта';
COMMENT ON COLUMN BARSAQ.ZAYAVKA_ID_MAP.SIGN02 IS 'ПІБ другого підписанта';
COMMENT ON COLUMN BARSAQ.ZAYAVKA_ID_MAP.IDZ IS 'ID заявки';
COMMENT ON COLUMN BARSAQ.ZAYAVKA_ID_MAP.DOC_ID IS 'ID первинного документу';




PROMPT *** Create  constraint CC_ZIDMAP_IDZ_NN ***
begin   
 execute immediate '
  ALTER TABLE BARSAQ.ZAYAVKA_ID_MAP MODIFY (IDZ CONSTRAINT CC_ZIDMAP_IDZ_NN NOT NULL ENABLE)';
exception when others then
  if  sqlcode=-2260 or sqlcode=-2261 or sqlcode=-2264 or sqlcode=-2275 or sqlcode=-1442 then null; else raise; end if;
 end;
/




PROMPT *** Create  constraint CC_ZIDMAP_DOCID_NN ***
begin   
 execute immediate '
  ALTER TABLE BARSAQ.ZAYAVKA_ID_MAP MODIFY (DOC_ID CONSTRAINT CC_ZIDMAP_DOCID_NN NOT NULL ENABLE)';
exception when others then
  if  sqlcode=-2260 or sqlcode=-2261 or sqlcode=-2264 or sqlcode=-2275 or sqlcode=-1442 then null; else raise; end if;
 end;
/




PROMPT *** Create  constraint PK_ZIDMAP ***
begin   
 execute immediate '
  ALTER TABLE BARSAQ.ZAYAVKA_ID_MAP ADD CONSTRAINT PK_ZIDMAP PRIMARY KEY (IDZ)
  USING INDEX PCTFREE 10 INITRANS 2 MAXTRANS 255 COMPUTE STATISTICS 
  TABLESPACE BRSDYND  ENABLE';
exception when others then
  if  sqlcode=-2260 or sqlcode=-2261 or sqlcode=-2264 or sqlcode=-2275 or sqlcode=-1442 then null; else raise; end if;
 end;
/




PROMPT *** Create  index PK_ZIDMAP ***
begin   
 execute immediate '
  CREATE UNIQUE INDEX BARSAQ.PK_ZIDMAP ON BARSAQ.ZAYAVKA_ID_MAP (IDZ) 
  PCTFREE 10 INITRANS 2 MAXTRANS 255 COMPUTE STATISTICS 
  TABLESPACE BRSDYND ';
exception when others then
  if  sqlcode=-955  then null; else raise; end if;
 end;
/



PROMPT *** Create  grants  ZAYAVKA_ID_MAP ***
grant SELECT                                                                 on ZAYAVKA_ID_MAP  to BARS with grant option;
grant SELECT                                                                 on ZAYAVKA_ID_MAP  to BARS_ACCESS_DEFROLE;



PROMPT ===================================================================================== 
PROMPT *** End *** ========== Scripts /Sql/BARSAQ/Table/ZAYAVKA_ID_MAP.sql =========*** End 
PROMPT ===================================================================================== 
