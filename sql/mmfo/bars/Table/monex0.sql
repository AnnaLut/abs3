

PROMPT ===================================================================================== 
PROMPT *** Run *** ========== Scripts /Sql/BARS/Table/MONEX0.sql =========*** Run *** ======
PROMPT ===================================================================================== 


PROMPT *** ALTER_POLICY_INFO to MONEX0 ***


BEGIN 
        execute immediate  
          'begin  
               bpa.alter_policy_info(''MONEX0'', ''CENTER'' , null, null, null, null);
               bpa.alter_policy_info(''MONEX0'', ''FILIAL'' , null, null, null, null);
               bpa.alter_policy_info(''MONEX0'', ''WHOLE'' , null, null, null, null);
               null;
           end; 
          '; 
END; 
/

PROMPT *** Create  table MONEX0 ***
begin 
  execute immediate '
  CREATE TABLE BARS.MONEX0 
   (	OB22 CHAR(2), 
	NAME VARCHAR2(25), 
	NLST VARCHAR2(14), 
	OB22_2809 CHAR(2), 
	OB22_KOM CHAR(2), 
	KOD_NBU VARCHAR2(5), 
	MFOB VARCHAR2(12), 
	NLSB VARCHAR2(15), 
	ID NUMBER(*,0)
   ) SEGMENT CREATION IMMEDIATE 
  PCTFREE 10 PCTUSED 40 INITRANS 1 MAXTRANS 255 
 NOCOMPRESS LOGGING
  TABLESPACE BRSDYND ';
exception when others then       
  if sqlcode=-955 then null; else raise; end if; 
end; 
/




PROMPT *** ALTER_POLICIES to MONEX0 ***
 exec bpa.alter_policies('MONEX0');


COMMENT ON TABLE BARS.MONEX0 IS '';
COMMENT ON COLUMN BARS.MONEX0.ID IS '';
COMMENT ON COLUMN BARS.MONEX0.OB22 IS 'код об22 для 2909';
COMMENT ON COLUMN BARS.MONEX0.NAME IS '';
COMMENT ON COLUMN BARS.MONEX0.NLST IS '';
COMMENT ON COLUMN BARS.MONEX0.OB22_2809 IS '';
COMMENT ON COLUMN BARS.MONEX0.OB22_KOM IS '';
COMMENT ON COLUMN BARS.MONEX0.KOD_NBU IS 'код(Псевдо для Шв.коп) по НБУ - он же - Ключ системы';
COMMENT ON COLUMN BARS.MONEX0.MFOB IS 'Банк ЮЛ - оператора системы';
COMMENT ON COLUMN BARS.MONEX0.NLSB IS 'Расчетный счет ЮЛ - оператора системы';




PROMPT *** Create  constraint XPK_MONEX0N ***
begin   
 execute immediate '
  ALTER TABLE BARS.MONEX0 ADD CONSTRAINT XPK_MONEX0N PRIMARY KEY (KOD_NBU)
  USING INDEX PCTFREE 10 INITRANS 2 MAXTRANS 255 COMPUTE STATISTICS 
  TABLESPACE BRSDYND  ENABLE';
exception when others then
  if  sqlcode=-2260 or sqlcode=-2261 or sqlcode=-2264 or sqlcode=-2275 or sqlcode=-1442 then null; else raise; end if;
 end;
/




PROMPT *** Create  index XPK_MONEX0N ***
begin   
 execute immediate '
  CREATE UNIQUE INDEX BARS.XPK_MONEX0N ON BARS.MONEX0 (KOD_NBU) 
  PCTFREE 10 INITRANS 2 MAXTRANS 255 COMPUTE STATISTICS 
  TABLESPACE BRSDYND ';
exception when others then
  if  sqlcode=-955  then null; else raise; end if;
 end;
/



PROMPT *** Create  grants  MONEX0 ***
grant SELECT                                                                 on MONEX0          to BARSREADER_ROLE;
grant DELETE,FLASHBACK,INSERT,SELECT,UPDATE                                  on MONEX0          to BARS_ACCESS_DEFROLE;
grant SELECT                                                                 on MONEX0          to BARS_DM;
grant DELETE,INSERT,SELECT,UPDATE                                            on MONEX0          to PYOD001;
grant DELETE,INSERT,SELECT,UPDATE                                            on MONEX0          to START1;
grant SELECT                                                                 on MONEX0          to UPLD;
grant FLASHBACK,SELECT                                                       on MONEX0          to WR_REFREAD;



PROMPT ===================================================================================== 
PROMPT *** End *** ========== Scripts /Sql/BARS/Table/MONEX0.sql =========*** End *** ======
PROMPT ===================================================================================== 
