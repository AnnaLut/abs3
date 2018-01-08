

PROMPT ===================================================================================== 
PROMPT *** Run *** ========== Scripts /Sql/BARS/Table/NBS_OB22_PAR_REZ.sql =========*** Run 
PROMPT ===================================================================================== 


PROMPT *** ALTER_POLICY_INFO to NBS_OB22_PAR_REZ ***


BEGIN 
        execute immediate  
          'begin  
               bpa.alter_policy_info(''NBS_OB22_PAR_REZ'', ''FILIAL'' , null, null, null, null);
               bpa.alter_policy_info(''NBS_OB22_PAR_REZ'', ''WHOLE'' , null, null, null, null);
               null;
           end; 
          '; 
END; 
/

PROMPT *** Create  table NBS_OB22_PAR_REZ ***
begin 
  execute immediate '
  CREATE TABLE BARS.NBS_OB22_PAR_REZ 
   (	NBS_REZ CHAR(4), 
	OB22_REZ VARCHAR2(2), 
	RZ NUMBER, 
	CU NUMBER, 
	PAR_RNK VARCHAR2(20), 
	NMK VARCHAR2(70), 
	CODCAGENT NUMBER, 
	ISE VARCHAR2(5), 
	VED VARCHAR2(5), 
	SED VARCHAR2(4), 
	NAZN VARCHAR2(500)
   ) SEGMENT CREATION IMMEDIATE 
  PCTFREE 10 PCTUSED 40 INITRANS 1 MAXTRANS 255 
 NOCOMPRESS LOGGING
  TABLESPACE BRSDYND ';
exception when others then       
  if sqlcode=-955 then null; else raise; end if; 
end; 
/




PROMPT *** ALTER_POLICIES to NBS_OB22_PAR_REZ ***
 exec bpa.alter_policies('NBS_OB22_PAR_REZ');


COMMENT ON TABLE BARS.NBS_OB22_PAR_REZ IS 'Параметри рахунків резерву';
COMMENT ON COLUMN BARS.NBS_OB22_PAR_REZ.NBS_REZ IS 'Номер бал. рахунку резерву';
COMMENT ON COLUMN BARS.NBS_OB22_PAR_REZ.OB22_REZ IS 'ОБ22 рахунку резерву';
COMMENT ON COLUMN BARS.NBS_OB22_PAR_REZ.RZ IS '1 - Резидент/ 2 - нерезидент';
COMMENT ON COLUMN BARS.NBS_OB22_PAR_REZ.CU IS 'Тип клиента';
COMMENT ON COLUMN BARS.NBS_OB22_PAR_REZ.PAR_RNK IS 'Параметр РНК';
COMMENT ON COLUMN BARS.NBS_OB22_PAR_REZ.NMK IS 'Назва клієнта';
COMMENT ON COLUMN BARS.NBS_OB22_PAR_REZ.CODCAGENT IS 'Резидент/нерезидент';
COMMENT ON COLUMN BARS.NBS_OB22_PAR_REZ.ISE IS 'Код сектора экономики';
COMMENT ON COLUMN BARS.NBS_OB22_PAR_REZ.VED IS 'Вид экономичческой деятельности';
COMMENT ON COLUMN BARS.NBS_OB22_PAR_REZ.SED IS 'Код отрасли экономики';
COMMENT ON COLUMN BARS.NBS_OB22_PAR_REZ.NAZN IS 'Назначение платежа';




PROMPT *** Create  constraint PK_NBSOB22PARREZ ***
begin   
 execute immediate '
  ALTER TABLE BARS.NBS_OB22_PAR_REZ ADD CONSTRAINT PK_NBSOB22PARREZ PRIMARY KEY (NBS_REZ, OB22_REZ, RZ)
  USING INDEX PCTFREE 10 INITRANS 2 MAXTRANS 255 COMPUTE STATISTICS 
  TABLESPACE BRSDYND  ENABLE';
exception when others then
  if  sqlcode=-2260 or sqlcode=-2261 or sqlcode=-2264 or sqlcode=-2275 or sqlcode=-1442 then null; else raise; end if;
 end;
/




PROMPT *** Create  index PK_NBSOB22PARREZ ***
begin   
 execute immediate '
  CREATE UNIQUE INDEX BARS.PK_NBSOB22PARREZ ON BARS.NBS_OB22_PAR_REZ (NBS_REZ, OB22_REZ, RZ) 
  PCTFREE 10 INITRANS 2 MAXTRANS 255 COMPUTE STATISTICS 
  TABLESPACE BRSDYND ';
exception when others then
  if  sqlcode=-955  then null; else raise; end if;
 end;
/



PROMPT *** Create  grants  NBS_OB22_PAR_REZ ***
grant SELECT                                                                 on NBS_OB22_PAR_REZ to BARSREADER_ROLE;
grant SELECT                                                                 on NBS_OB22_PAR_REZ to BARS_ACCESS_DEFROLE;
grant SELECT                                                                 on NBS_OB22_PAR_REZ to RCC_DEAL;
grant SELECT                                                                 on NBS_OB22_PAR_REZ to START1;
grant SELECT                                                                 on NBS_OB22_PAR_REZ to UPLD;



PROMPT ===================================================================================== 
PROMPT *** End *** ========== Scripts /Sql/BARS/Table/NBS_OB22_PAR_REZ.sql =========*** End 
PROMPT ===================================================================================== 
