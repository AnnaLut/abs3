

PROMPT ===================================================================================== 
PROMPT *** Run *** ========== Scripts /Sql/BARS/Table/KOATUU_REGION_CODE.sql =========*** Ru
PROMPT ===================================================================================== 


PROMPT *** ALTER_POLICY_INFO to KOATUU_REGION_CODE ***


BEGIN 
        execute immediate  
          'begin  
               bpa.alter_policy_info(''KOATUU_REGION_CODE'', ''CENTER'' , null, ''E'', ''E'', ''E'');
               bpa.alter_policy_info(''KOATUU_REGION_CODE'', ''FILIAL'' , ''M'', ''M'', ''M'', ''M'');
               bpa.alter_policy_info(''KOATUU_REGION_CODE'', ''WHOLE'' , null, ''E'', ''E'', ''E'');
               null;
           end; 
          '; 
END; 
/

PROMPT *** Create  table KOATUU_REGION_CODE ***
begin 
  execute immediate '
  CREATE TABLE BARS.KOATUU_REGION_CODE 
   (	REGION VARCHAR2(64), 
	CODE VARCHAR2(4)
   ) SEGMENT CREATION IMMEDIATE 
  PCTFREE 10 PCTUSED 40 INITRANS 1 MAXTRANS 255 
 NOCOMPRESS LOGGING
  TABLESPACE BRSDYND ';
exception when others then       
  if sqlcode=-955 then null; else raise; end if; 
end; 
/




PROMPT *** ALTER_POLICIES to KOATUU_REGION_CODE ***
 exec bpa.alter_policies('KOATUU_REGION_CODE');


COMMENT ON TABLE BARS.KOATUU_REGION_CODE IS 'Коди регіонів України згідно класифікації КОАТУУ';
COMMENT ON COLUMN BARS.KOATUU_REGION_CODE.REGION IS 'Регіон';
COMMENT ON COLUMN BARS.KOATUU_REGION_CODE.CODE IS 'Код';




PROMPT *** Create  constraint PK_KOATUU_REGION_CODE ***
begin   
 execute immediate '
  ALTER TABLE BARS.KOATUU_REGION_CODE ADD CONSTRAINT PK_KOATUU_REGION_CODE PRIMARY KEY (CODE)
  USING INDEX PCTFREE 10 INITRANS 2 MAXTRANS 255 COMPUTE STATISTICS 
  TABLESPACE BRSDYND  ENABLE';
exception when others then
  if  sqlcode=-2260 or sqlcode=-2261 or sqlcode=-2264 or sqlcode=-2275 or sqlcode=-1442 then null; else raise; end if;
 end;
/




PROMPT *** Create  constraint CC_KOATUU_REGION_CODE_REGION ***
begin   
 execute immediate '
  ALTER TABLE BARS.KOATUU_REGION_CODE MODIFY (REGION CONSTRAINT CC_KOATUU_REGION_CODE_REGION NOT NULL ENABLE)';
exception when others then
  if  sqlcode=-2260 or sqlcode=-2261 or sqlcode=-2264 or sqlcode=-2275 or sqlcode=-1442 then null; else raise; end if;
 end;
/




PROMPT *** Create  constraint CC_KOATUU_REGION_CODE_CODE ***
begin   
 execute immediate '
  ALTER TABLE BARS.KOATUU_REGION_CODE MODIFY (CODE CONSTRAINT CC_KOATUU_REGION_CODE_CODE NOT NULL ENABLE)';
exception when others then
  if  sqlcode=-2260 or sqlcode=-2261 or sqlcode=-2264 or sqlcode=-2275 or sqlcode=-1442 then null; else raise; end if;
 end;
/




PROMPT *** Create  index PK_KOATUU_REGION_CODE ***
begin   
 execute immediate '
  CREATE UNIQUE INDEX BARS.PK_KOATUU_REGION_CODE ON BARS.KOATUU_REGION_CODE (CODE) 
  PCTFREE 10 INITRANS 2 MAXTRANS 255 COMPUTE STATISTICS 
  TABLESPACE BRSDYND ';
exception when others then
  if  sqlcode=-955  then null; else raise; end if;
 end;
/



PROMPT *** Create  grants  KOATUU_REGION_CODE ***
grant DELETE,INSERT,SELECT,UPDATE                                            on KOATUU_REGION_CODE to BARS_ACCESS_DEFROLE;
grant SELECT                                                                 on KOATUU_REGION_CODE to BARS_DM;
grant DELETE,INSERT,SELECT,UPDATE                                            on KOATUU_REGION_CODE to CUST001;



PROMPT *** Create SYNONYM  to KOATUU_REGION_CODE ***

  CREATE OR REPLACE PUBLIC SYNONYM KOATUU_REGION_CODE FOR BARS.KOATUU_REGION_CODE;


PROMPT ===================================================================================== 
PROMPT *** End *** ========== Scripts /Sql/BARS/Table/KOATUU_REGION_CODE.sql =========*** En
PROMPT ===================================================================================== 
