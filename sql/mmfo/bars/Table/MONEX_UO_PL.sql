

PROMPT ===================================================================================== 
PROMPT *** Run *** ========== Scripts /Sql/BARS/Table/MONEX_UO_PL.sql =========*** Run *** =
PROMPT ===================================================================================== 


PROMPT *** ALTER_POLICY_INFO to MONEX_UO_PL ***


BEGIN 
        execute immediate  
          'begin  
               bpa.alter_policy_info(''MONEX_UO_PL'', ''FILIAL'' , null, null, null, null);
               bpa.alter_policy_info(''MONEX_UO_PL'', ''WHOLE'' , null, null, null, null);
               null;
           end; 
          '; 
END; 
/

PROMPT *** Create  table MONEX_UO_PL ***
begin 
  execute immediate '
  CREATE TABLE BARS.MONEX_UO_PL 
   (  ID NUMBER(*,0), 
  MV VARCHAR2(5), 
  MFO VARCHAR2(6), 
  NLS VARCHAR2(19), 
  NLS_KOM VARCHAR2(15)
   ) SEGMENT CREATION IMMEDIATE 
  PCTFREE 10 PCTUSED 40 INITRANS 1 MAXTRANS 255 
 NOCOMPRESS LOGGING
  TABLESPACE BRSDYND ';
exception when others then       
  if sqlcode=-955 then null; else raise; end if; 
end; 
/




PROMPT *** ALTER_POLICIES to MONEX_UO_PL ***
 exec bpa.alter_policies('MONEX_UO_PL');


COMMENT ON TABLE BARS.MONEX_UO_PL IS 'Додаткові пл.реквізити ЮО для різних СТП';
COMMENT ON COLUMN BARS.MONEX_UO_PL.ID IS '№ пп';
COMMENT ON COLUMN BARS.MONEX_UO_PL.MV IS 'Тип системи СТП по "НБУ" ';
COMMENT ON COLUMN BARS.MONEX_UO_PL.MFO IS 'Пл.рекв.МФО';
COMMENT ON COLUMN BARS.MONEX_UO_PL.NLS IS 'Пл.рекв.Рах.';
COMMENT ON COLUMN BARS.MONEX_UO_PL.NLS_KOM IS 'Альтерн.рах.суб.агента(викороистовувати для комісії)';




PROMPT *** Create  constraint XPK_MONEXUOPL ***
begin   
 execute immediate '
  ALTER TABLE BARS.MONEX_UO_PL ADD CONSTRAINT XPK_MONEXUOPL PRIMARY KEY (MV, ID)
  USING INDEX PCTFREE 10 INITRANS 2 MAXTRANS 255 COMPUTE STATISTICS 
  TABLESPACE BRSDYND  ENABLE';
exception when others then
  if  sqlcode=-2260 or sqlcode=-2261 or sqlcode=-2264 or sqlcode=-2275 or sqlcode=-1442 then null; else raise; end if;
 end;
/




PROMPT *** Create  index XPK_MONEXUOPL ***
begin   
 execute immediate '
  CREATE UNIQUE INDEX BARS.XPK_MONEXUOPL ON BARS.MONEX_UO_PL (MV, ID) 
  PCTFREE 10 INITRANS 2 MAXTRANS 255 COMPUTE STATISTICS 
  TABLESPACE BRSDYND ';
exception when others then
  if  sqlcode=-955  then null; else raise; end if;
 end;
/



PROMPT *** Create  grants  MONEX_UO_PL ***
grant DELETE,INSERT,SELECT,UPDATE                                            on MONEX_UO_PL     to BARS_ACCESS_DEFROLE;



PROMPT ===================================================================================== 
PROMPT *** End *** ========== Scripts /Sql/BARS/Table/MONEX_UO_PL.sql =========*** End *** =
PROMPT ===================================================================================== 
