

PROMPT ===================================================================================== 
PROMPT *** Run *** ========== Scripts /Sql/BARS/Table/META_COLTYPES.sql =========*** Run ***
PROMPT ===================================================================================== 


PROMPT *** ALTER_POLICY_INFO to META_COLTYPES ***


BEGIN 
        execute immediate  
          'begin  
               bpa.alter_policy_info(''META_COLTYPES'', ''FILIAL'' , null, ''E'', ''E'', ''E'');
               bpa.alter_policy_info(''META_COLTYPES'', ''WHOLE'' , null, null, null, null);
               null;
           end; 
          '; 
END; 
/

PROMPT *** Create  table META_COLTYPES ***
begin 
  execute immediate '
  CREATE TABLE BARS.META_COLTYPES 
   (	COLTYPE CHAR(1), 
	TYPENAME VARCHAR2(15)
   ) SEGMENT CREATION IMMEDIATE 
  PCTFREE 10 PCTUSED 40 INITRANS 1 MAXTRANS 255 
 NOCOMPRESS LOGGING
  TABLESPACE BRSSMLD ';
exception when others then       
  if sqlcode=-955 then null; else raise; end if; 
end; 
/




PROMPT *** ALTER_POLICIES to META_COLTYPES ***
 exec bpa.alter_policies('META_COLTYPES');


COMMENT ON TABLE BARS.META_COLTYPES IS 'Метаописание. Типы полей таблиц';
COMMENT ON COLUMN BARS.META_COLTYPES.COLTYPE IS 'Код типа поля';
COMMENT ON COLUMN BARS.META_COLTYPES.TYPENAME IS 'Наименование типа поля';




PROMPT *** Create  constraint PK_METACOLTYPES ***
begin   
 execute immediate '
  ALTER TABLE BARS.META_COLTYPES ADD CONSTRAINT PK_METACOLTYPES PRIMARY KEY (COLTYPE)
  USING INDEX PCTFREE 10 INITRANS 2 MAXTRANS 255 COMPUTE STATISTICS 
  TABLESPACE BRSSMLI  ENABLE';
exception when others then
  if  sqlcode=-2260 or sqlcode=-2261 or sqlcode=-2264 or sqlcode=-2275 or sqlcode=-1442 then null; else raise; end if;
 end;
/




PROMPT *** Create  constraint CC_METACOLTYPES_TYPENAME_NN ***
begin   
 execute immediate '
  ALTER TABLE BARS.META_COLTYPES MODIFY (TYPENAME CONSTRAINT CC_METACOLTYPES_TYPENAME_NN NOT NULL ENABLE)';
exception when others then
  if  sqlcode=-2260 or sqlcode=-2261 or sqlcode=-2264 or sqlcode=-2275 or sqlcode=-1442 then null; else raise; end if;
 end;
/




PROMPT *** Create  constraint CC_METACOLTYPES_COLTYPE_NN ***
begin   
 execute immediate '
  ALTER TABLE BARS.META_COLTYPES MODIFY (COLTYPE CONSTRAINT CC_METACOLTYPES_COLTYPE_NN NOT NULL ENABLE)';
exception when others then
  if  sqlcode=-2260 or sqlcode=-2261 or sqlcode=-2264 or sqlcode=-2275 or sqlcode=-1442 then null; else raise; end if;
 end;
/




PROMPT *** Create  index PK_METACOLTYPES ***
begin   
 execute immediate '
  CREATE UNIQUE INDEX BARS.PK_METACOLTYPES ON BARS.META_COLTYPES (COLTYPE) 
  PCTFREE 10 INITRANS 2 MAXTRANS 255 COMPUTE STATISTICS 
  TABLESPACE BRSSMLI ';
exception when others then
  if  sqlcode=-955  then null; else raise; end if;
 end;
/



PROMPT *** Create  grants  META_COLTYPES ***
grant DELETE,INSERT,SELECT,UPDATE                                            on META_COLTYPES   to ABS_ADMIN;
grant DELETE,INSERT,SELECT,UPDATE                                            on META_COLTYPES   to BARS_ACCESS_DEFROLE;
grant SELECT                                                                 on META_COLTYPES   to START1;
grant DELETE,FLASHBACK,INSERT,SELECT,UPDATE                                  on META_COLTYPES   to WR_ALL_RIGHTS;



PROMPT ===================================================================================== 
PROMPT *** End *** ========== Scripts /Sql/BARS/Table/META_COLTYPES.sql =========*** End ***
PROMPT ===================================================================================== 
