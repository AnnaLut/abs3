

PROMPT ===================================================================================== 
PROMPT *** Run *** ========== Scripts /Sql/BARS/Table/MONEX_MV_UO.sql =========*** Run *** =
PROMPT ===================================================================================== 


PROMPT *** ALTER_POLICY_INFO to MONEX_MV_UO ***


BEGIN 
        execute immediate  
          'begin  
               bpa.alter_policy_info(''MONEX_MV_UO'', ''FILIAL'' , null, null, null, null);
               bpa.alter_policy_info(''MONEX_MV_UO'', ''WHOLE'' , null, null, null, null);
               null;
           end; 
          '; 
END; 
/

PROMPT *** Create  table MONEX_MV_UO ***
begin 
  execute immediate '
  CREATE TABLE BARS.MONEX_MV_UO 
   (	MV VARCHAR2(5), 
	UO NUMBER, 
	OB22_2909 VARCHAR2(15), 
	OB22_2809 VARCHAR2(15), 
	OB22_KOM VARCHAR2(15)
   ) SEGMENT CREATION IMMEDIATE 
  PCTFREE 10 PCTUSED 40 INITRANS 1 MAXTRANS 255 
 NOCOMPRESS LOGGING
  TABLESPACE BRSDYND ';
exception when others then       
  if sqlcode=-955 then null; else raise; end if; 
end; 
/




PROMPT *** ALTER_POLICIES to MONEX_MV_UO ***
 exec bpa.alter_policies('MONEX_MV_UO');


COMMENT ON TABLE BARS.MONEX_MV_UO IS 'Зв`язки систем СТП та їх користувачів-ЮО';
COMMENT ON COLUMN BARS.MONEX_MV_UO.MV IS 'Тип системи СТП по "НБУ" ';
COMMENT ON COLUMN BARS.MONEX_MV_UO.UO IS '№ ЮО~користувача СТП';
COMMENT ON COLUMN BARS.MONEX_MV_UO.OB22_2909 IS 'Бал+ОБ22 кред.заборг.';
COMMENT ON COLUMN BARS.MONEX_MV_UO.OB22_2809 IS 'Бал+ОБ22 дебіт.заборг.';
COMMENT ON COLUMN BARS.MONEX_MV_UO.OB22_KOM IS 'Бал+ОБ22 комісії';




PROMPT *** Create  constraint FK_MONEXMVUO_MV ***
begin   
 execute immediate '
  ALTER TABLE BARS.MONEX_MV_UO ADD CONSTRAINT FK_MONEXMVUO_MV FOREIGN KEY (MV)
	  REFERENCES BARS.MONEX0 (KOD_NBU) ENABLE';
exception when others then
  if  sqlcode=-2260 or sqlcode=-2261 or sqlcode=-2264 or sqlcode=-2275 or sqlcode=-1442 then null; else raise; end if;
 end;
/




PROMPT *** Create  constraint CC_MONEXUOMV_29_NN ***
begin   
 execute immediate '
  ALTER TABLE BARS.MONEX_MV_UO MODIFY (OB22_2909 CONSTRAINT CC_MONEXUOMV_29_NN NOT NULL ENABLE)';
exception when others then
  if  sqlcode=-2260 or sqlcode=-2261 or sqlcode=-2264 or sqlcode=-2275 or sqlcode=-1442 then null; else raise; end if;
 end;
/




PROMPT *** Create  constraint FK_MONEXMVUO_UO ***
begin   
 execute immediate '
  ALTER TABLE BARS.MONEX_MV_UO ADD CONSTRAINT FK_MONEXMVUO_UO FOREIGN KEY (UO)
	  REFERENCES BARS.MONEX_UO (ID) ENABLE';
exception when others then
  if  sqlcode=-2260 or sqlcode=-2261 or sqlcode=-2264 or sqlcode=-2275 or sqlcode=-1442 then null; else raise; end if;
 end;
/




PROMPT *** Create  constraint XPK_MONEXMVUO ***
begin   
 execute immediate '
  ALTER TABLE BARS.MONEX_MV_UO ADD CONSTRAINT XPK_MONEXMVUO PRIMARY KEY (MV, UO)
  USING INDEX PCTFREE 10 INITRANS 2 MAXTRANS 255 COMPUTE STATISTICS 
  TABLESPACE BRSDYND  ENABLE';
exception when others then
  if  sqlcode=-2260 or sqlcode=-2261 or sqlcode=-2264 or sqlcode=-2275 or sqlcode=-1442 then null; else raise; end if;
 end;
/




PROMPT *** Create  constraint CC_MONEXUOMV_28_NN ***
begin   
 execute immediate '
  ALTER TABLE BARS.MONEX_MV_UO MODIFY (OB22_2809 CONSTRAINT CC_MONEXUOMV_28_NN NOT NULL ENABLE)';
exception when others then
  if  sqlcode=-2260 or sqlcode=-2261 or sqlcode=-2264 or sqlcode=-2275 or sqlcode=-1442 then null; else raise; end if;
 end;
/




PROMPT *** Create  constraint CC_MONEXUOMV_61_NN ***
begin   
 execute immediate '
  ALTER TABLE BARS.MONEX_MV_UO MODIFY (OB22_KOM CONSTRAINT CC_MONEXUOMV_61_NN NOT NULL ENABLE)';
exception when others then
  if  sqlcode=-2260 or sqlcode=-2261 or sqlcode=-2264 or sqlcode=-2275 or sqlcode=-1442 then null; else raise; end if;
 end;
/




PROMPT *** Create  index XPK_MONEXMVUO ***
begin   
 execute immediate '
  CREATE UNIQUE INDEX BARS.XPK_MONEXMVUO ON BARS.MONEX_MV_UO (MV, UO) 
  PCTFREE 10 INITRANS 2 MAXTRANS 255 COMPUTE STATISTICS 
  TABLESPACE BRSDYND ';
exception when others then
  if  sqlcode=-955  then null; else raise; end if;
 end;
/



PROMPT *** Create  grants  MONEX_MV_UO ***
grant DELETE,INSERT,SELECT,UPDATE                                            on MONEX_MV_UO     to BARS_ACCESS_DEFROLE;
grant ALTER,DEBUG,DELETE,FLASHBACK,INSERT,ON COMMIT REFRESH,QUERY REWRITE,SELECT,UPDATE on MONEX_MV_UO     to START1;



PROMPT ===================================================================================== 
PROMPT *** End *** ========== Scripts /Sql/BARS/Table/MONEX_MV_UO.sql =========*** End *** =
PROMPT ===================================================================================== 
