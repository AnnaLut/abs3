

PROMPT ===================================================================================== 
PROMPT *** Run *** ========== Scripts /Sql/BARS/Table/ADR_HOUSES.sql =========*** Run *** ==
PROMPT ===================================================================================== 


PROMPT *** ALTER_POLICY_INFO to ADR_HOUSES ***


BEGIN 
        execute immediate  
          'begin  
               bpa.alter_policy_info(''ADR_HOUSES'', ''FILIAL'' , null, null, null, null);
               bpa.alter_policy_info(''ADR_HOUSES'', ''WHOLE'' , null, null, null, null);
               null;
           end; 
          '; 
END; 
/

PROMPT *** Create  table ADR_HOUSES ***
begin 
  execute immediate '
  CREATE TABLE BARS.ADR_HOUSES 
   (	HOUSE_ID NUMBER(10,0), 
	STREET_ID NUMBER(10,0), 
	DISTRICT_ID NUMBER(10,0), 
	HOUSE_NUM VARCHAR2(5), 
	HOUSE_NUM_ADD VARCHAR2(15), 
	POSTAL_CODE VARCHAR2(5), 
	LATITUDE VARCHAR2(15), 
	LONGITUDE VARCHAR2(15)
   ) SEGMENT CREATION IMMEDIATE 
  PCTFREE 10 PCTUSED 40 INITRANS 1 MAXTRANS 255 
 NOCOMPRESS LOGGING
  TABLESPACE BRSDYND ';
exception when others then       
  if sqlcode=-955 then null; else raise; end if; 
end; 
/




PROMPT *** ALTER_POLICIES to ADR_HOUSES ***
 exec bpa.alter_policies('ADR_HOUSES');


COMMENT ON TABLE BARS.ADR_HOUSES IS 'Довідник номерів будинків';
COMMENT ON COLUMN BARS.ADR_HOUSES.HOUSE_ID IS 'Ід. будинку';
COMMENT ON COLUMN BARS.ADR_HOUSES.STREET_ID IS 'Ід. вулиці (в населеному пункті)';
COMMENT ON COLUMN BARS.ADR_HOUSES.DISTRICT_ID IS 'Ід. району в місті';
COMMENT ON COLUMN BARS.ADR_HOUSES.HOUSE_NUM IS 'Номер будинку';
COMMENT ON COLUMN BARS.ADR_HOUSES.HOUSE_NUM_ADD IS 'дополнительная часть номера дома (содержит дробную или буквенную часть)';
COMMENT ON COLUMN BARS.ADR_HOUSES.POSTAL_CODE IS 'Поштовий індекс будинку';
COMMENT ON COLUMN BARS.ADR_HOUSES.LATITUDE IS 'Географічні координати будинку (широта)';
COMMENT ON COLUMN BARS.ADR_HOUSES.LONGITUDE IS 'Географічні координати будинку (довгота)';




PROMPT *** Create  constraint SYS_C00109457 ***
begin   
 execute immediate '
  ALTER TABLE BARS.ADR_HOUSES MODIFY (HOUSE_ID NOT NULL ENABLE)';
exception when others then
  if  sqlcode=-2260 or sqlcode=-2261 or sqlcode=-2264 or sqlcode=-2275 or sqlcode=-1442 then null; else raise; end if;
 end;
/




PROMPT *** Create  constraint SYS_C00109458 ***
begin   
 execute immediate '
  ALTER TABLE BARS.ADR_HOUSES MODIFY (STREET_ID NOT NULL ENABLE)';
exception when others then
  if  sqlcode=-2260 or sqlcode=-2261 or sqlcode=-2264 or sqlcode=-2275 or sqlcode=-1442 then null; else raise; end if;
 end;
/



PROMPT *** Create  grants  ADR_HOUSES ***
grant SELECT                                                                 on ADR_HOUSES      to BARSREADER_ROLE;
grant SELECT                                                                 on ADR_HOUSES      to BARSUPL;
grant SELECT                                                                 on ADR_HOUSES      to BARS_ACCESS_DEFROLE;
grant SELECT                                                                 on ADR_HOUSES      to START1;
grant SELECT                                                                 on ADR_HOUSES      to UPLD;



PROMPT ===================================================================================== 
PROMPT *** End *** ========== Scripts /Sql/BARS/Table/ADR_HOUSES.sql =========*** End *** ==
PROMPT ===================================================================================== 
