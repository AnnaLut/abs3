

PROMPT ===================================================================================== 
PROMPT *** Run *** ========== Scripts /Sql/BARSAQ/Table/MONEX_MV_UO.sql =========*** Run ***
PROMPT ===================================================================================== 


PROMPT *** Create  table MONEX_MV_UO ***
begin 
  execute immediate '
  CREATE TABLE BARSAQ.MONEX_MV_UO 
   (	MV VARCHAR2(5), 
	UO NUMBER, 
	OB22_2909 VARCHAR2(15), 
	OB22_2809 VARCHAR2(15), 
	OB22_KOM VARCHAR2(15)
   ) SEGMENT CREATION IMMEDIATE 
  PCTFREE 10 PCTUSED 40 INITRANS 1 MAXTRANS 255 
 NOCOMPRESS LOGGING
  TABLESPACE AQTS ';
exception when others then       
  if sqlcode=-955 then null; else raise; end if; 
end; 
/


COMMENT ON TABLE BARSAQ.MONEX_MV_UO IS 'Зв`язки систем СТП та їх користувачів-ЮО';
COMMENT ON COLUMN BARSAQ.MONEX_MV_UO.MV IS 'Тип системи СТП по "НБУ" ';
COMMENT ON COLUMN BARSAQ.MONEX_MV_UO.UO IS '№ ЮО~користувача СТП';
COMMENT ON COLUMN BARSAQ.MONEX_MV_UO.OB22_2909 IS 'Бал+ОБ22 кред.заборг.';
COMMENT ON COLUMN BARSAQ.MONEX_MV_UO.OB22_2809 IS 'Бал+ОБ22 дебіт.заборг.';
COMMENT ON COLUMN BARSAQ.MONEX_MV_UO.OB22_KOM IS 'Бал+ОБ22 комісії';




PROMPT *** Create  constraint CC_MONEXUOMV_29_NN ***
begin   
 execute immediate '
  ALTER TABLE BARSAQ.MONEX_MV_UO MODIFY (OB22_2909 CONSTRAINT CC_MONEXUOMV_29_NN NOT NULL ENABLE)';
exception when others then
  if  sqlcode=-2260 or sqlcode=-2261 or sqlcode=-2264 or sqlcode=-2275 or sqlcode=-1442 then null; else raise; end if;
 end;
/




PROMPT *** Create  constraint CC_MONEXUOMV_28_NN ***
begin   
 execute immediate '
  ALTER TABLE BARSAQ.MONEX_MV_UO MODIFY (OB22_2809 CONSTRAINT CC_MONEXUOMV_28_NN NOT NULL ENABLE)';
exception when others then
  if  sqlcode=-2260 or sqlcode=-2261 or sqlcode=-2264 or sqlcode=-2275 or sqlcode=-1442 then null; else raise; end if;
 end;
/




PROMPT *** Create  constraint CC_MONEXUOMV_61_NN ***
begin   
 execute immediate '
  ALTER TABLE BARSAQ.MONEX_MV_UO MODIFY (OB22_KOM CONSTRAINT CC_MONEXUOMV_61_NN NOT NULL ENABLE)';
exception when others then
  if  sqlcode=-2260 or sqlcode=-2261 or sqlcode=-2264 or sqlcode=-2275 or sqlcode=-1442 then null; else raise; end if;
 end;
/




PROMPT *** Create  constraint XPK_MONEXMVUO ***
begin   
 execute immediate '
  ALTER TABLE BARSAQ.MONEX_MV_UO ADD CONSTRAINT XPK_MONEXMVUO PRIMARY KEY (MV, UO)
  USING INDEX PCTFREE 10 INITRANS 2 MAXTRANS 255 COMPUTE STATISTICS 
  TABLESPACE AQTS  ENABLE';
exception when others then
  if  sqlcode=-2260 or sqlcode=-2261 or sqlcode=-2264 or sqlcode=-2275 or sqlcode=-1442 then null; else raise; end if;
 end;
/




PROMPT *** Create  index XPK_MONEXMVUO ***
begin   
 execute immediate '
  CREATE UNIQUE INDEX BARSAQ.XPK_MONEXMVUO ON BARSAQ.MONEX_MV_UO (MV, UO) 
  PCTFREE 10 INITRANS 2 MAXTRANS 255 COMPUTE STATISTICS 
  TABLESPACE AQTS ';
exception when others then
  if  sqlcode=-955  then null; else raise; end if;
 end;
/



PROMPT *** Create  grants  MONEX_MV_UO ***
grant SELECT                                                                 on MONEX_MV_UO     to BARSREADER_ROLE;
grant ALTER,DEBUG,DELETE,FLASHBACK,INSERT,ON COMMIT REFRESH,QUERY REWRITE,SELECT,UPDATE on MONEX_MV_UO     to START1;



PROMPT ===================================================================================== 
PROMPT *** End *** ========== Scripts /Sql/BARSAQ/Table/MONEX_MV_UO.sql =========*** End ***
PROMPT ===================================================================================== 
