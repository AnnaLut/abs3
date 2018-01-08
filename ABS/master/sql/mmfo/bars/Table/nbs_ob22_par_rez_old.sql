PROMPT ===================================================================================== 
PROMPT *** Run *** ========== Scripts /Sql/BARS/Table/NBS_OB22_PAR_REZ_OLD.sql =========*** Run 
PROMPT ===================================================================================== 


PROMPT *** ALTER_POLICY_INFO to NBS_OB22_PAR_REZ_OLD ***


BEGIN 
        execute immediate  
          'begin  
               bpa.alter_policy_info(''NBS_OB22_PAR_REZ_OLD'', ''FILIAL'' , null, null, null, null);
               bpa.alter_policy_info(''NBS_OB22_PAR_REZ_OLD'', ''WHOLE'' , null, null, null, null);
               null;
           end; 
          '; 
END; 
/

PROMPT *** Create  table NBS_OB22_PAR_REZ_OLD ***
begin 
  execute immediate '
  CREATE TABLE BARS.NBS_OB22_PAR_REZ_OLD 
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
  TABLESPACE BRSMDLD';
exception when others then       
  if sqlcode=-955 then null; else raise; end if; 
end; 
/
                      
PROMPT *** ALTER_POLICIES to NBS_OB22_PAR_REZ_OLD ***
 exec bpa.alter_policies('NBS_OB22_PAR_REZ_OLD');


COMMENT ON TABLE BARS.NBS_OB22_PAR_REZ_OLD IS 'Параметри рахунків резерву';
COMMENT ON COLUMN BARS.NBS_OB22_PAR_REZ_OLD.NBS_REZ IS 'Номер бал. рахунку резерву';
COMMENT ON COLUMN BARS.NBS_OB22_PAR_REZ_OLD.OB22_REZ IS 'ОБ22 рахунку резерву';
COMMENT ON COLUMN BARS.NBS_OB22_PAR_REZ_OLD.RZ IS '1 - Резидент/ 2 - нерезидент';
COMMENT ON COLUMN BARS.NBS_OB22_PAR_REZ_OLD.CU IS 'Тип клиента';
COMMENT ON COLUMN BARS.NBS_OB22_PAR_REZ_OLD.PAR_RNK IS 'Параметр РНК';
COMMENT ON COLUMN BARS.NBS_OB22_PAR_REZ_OLD.NMK IS 'Назва клієнта';
COMMENT ON COLUMN BARS.NBS_OB22_PAR_REZ_OLD.CODCAGENT IS 'Резидент/нерезидент';
COMMENT ON COLUMN BARS.NBS_OB22_PAR_REZ_OLD.ISE IS 'Код сектора экономики';
COMMENT ON COLUMN BARS.NBS_OB22_PAR_REZ_OLD.VED IS 'Вид экономичческой деятельности';
COMMENT ON COLUMN BARS.NBS_OB22_PAR_REZ_OLD.SED IS 'Код отрасли экономики';
COMMENT ON COLUMN BARS.NBS_OB22_PAR_REZ_OLD.NAZN IS 'Назначение платежа';




PROMPT *** Create  constraint PK_NBSOB22PARREZ ***
begin   
 execute immediate '
  ALTER TABLE BARS.NBS_OB22_PAR_REZ_OLD ADD CONSTRAINT PK_NBSOB22PARREZ PRIMARY KEY (NBS_REZ, OB22_REZ, RZ)
  USING INDEX PCTFREE 10 INITRANS 2 MAXTRANS 255 COMPUTE STATISTICS 
  TABLESPACE BRSMDLI  ENABLE';
exception when others then
  if  sqlcode=-2260 or sqlcode=-2261 or sqlcode=-2264 or sqlcode=-2275 or sqlcode=-1442 then null; else raise; end if;
 end;
/




PROMPT *** Create  index PK_NBSOB22PARREZ ***
begin   
 execute immediate '
  CREATE UNIQUE INDEX BARS.PK_NBSOB22PARREZ ON BARS.NBS_OB22_PAR_REZ_OLD (NBS_REZ, OB22_REZ, RZ) 
  PCTFREE 10 INITRANS 2 MAXTRANS 255 COMPUTE STATISTICS 
  TABLESPACE BRSMDLI ';
exception when others then
  if  sqlcode=-955  then null; else raise; end if;
 end;
/



PROMPT *** Create  grants  NBS_OB22_PAR_REZ_OLD ***
grant SELECT                                                                 on NBS_OB22_PAR_REZ_OLD to BARS_ACCESS_DEFROLE;
grant SELECT                                                                 on NBS_OB22_PAR_REZ_OLD to RCC_DEAL;
grant SELECT                                                                 on NBS_OB22_PAR_REZ_OLD to START1;



PROMPT ===================================================================================== 
PROMPT *** End *** ========== Scripts /Sql/BARS/Table/NBS_OB22_PAR_REZ_OLD.sql =========*** End 
PROMPT ===================================================================================== 
