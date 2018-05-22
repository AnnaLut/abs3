

PROMPT ===================================================================================== 
PROMPT *** Run *** ========== Scripts /Sql/BARS/Table/CF_MAPPING_DOCTYPE.sql =========*** Ru
PROMPT ===================================================================================== 


PROMPT *** ALTER_POLICY_INFO to CF_MAPPING_DOCTYPE ***


BEGIN 
        execute immediate  
          'begin  
               bpa.alter_policy_info(''CF_MAPPING_DOCTYPE'', ''FILIAL'' , null, null, null, null);
               bpa.alter_policy_info(''CF_MAPPING_DOCTYPE'', ''WHOLE'' , null, null, null, null);
               null;
           end; 
          '; 
END; 
/

PROMPT *** Create  table CF_MAPPING_DOCTYPE ***
begin 
  execute immediate '
  CREATE TABLE BARS.CF_MAPPING_DOCTYPE 
   (    TYPE_CF NUMBER(2,0), 
    NAME_CF VARCHAR2(200), 
    TYPE_ABS NUMBER(2,0), 
    NAME_ABS VARCHAR2(200)
   ) SEGMENT CREATION DEFERRED 
  PCTFREE 10 PCTUSED 0 INITRANS 1 MAXTRANS 255 
 NOCOMPRESS LOGGING
  TABLESPACE BRSDYND ';
exception when others then       
  if sqlcode=-955 then null; else raise; end if; 
end; 
/




PROMPT *** ALTER_POLICIES to CF_MAPPING_DOCTYPE ***
 exec bpa.alter_policies('CF_MAPPING_DOCTYPE');


COMMENT ON TABLE BARS.CF_MAPPING_DOCTYPE IS 'Типи документів для синхронізації CF';
COMMENT ON COLUMN BARS.CF_MAPPING_DOCTYPE.TYPE_CF IS 'Код документа CF';
COMMENT ON COLUMN BARS.CF_MAPPING_DOCTYPE.NAME_CF IS 'Назва документа CF';
COMMENT ON COLUMN BARS.CF_MAPPING_DOCTYPE.TYPE_ABS IS 'Код документа ABS';
COMMENT ON COLUMN BARS.CF_MAPPING_DOCTYPE.NAME_ABS IS 'Назва документа ABS';




PROMPT *** Create  constraint PK_CFMAPPINGDOCTYPE ***
begin   
 execute immediate '
  ALTER TABLE BARS.CF_MAPPING_DOCTYPE ADD CONSTRAINT PK_CFMAPPINGDOCTYPE PRIMARY KEY (TYPE_CF, TYPE_ABS)
  USING INDEX PCTFREE 10 INITRANS 2 MAXTRANS 255 COMPUTE STATISTICS 
  TABLESPACE BRSDYNI  ENABLE';
exception when others then
  if  sqlcode=-2260 or sqlcode=-2261 or sqlcode=-2264 or sqlcode=-2275 or sqlcode=-1442 then null; else raise; end if;
 end;
/




PROMPT *** Create  index PK_CFMAPPINGDOCTYPE ***
begin   
 execute immediate '
  CREATE UNIQUE INDEX BARS.PK_CFMAPPINGDOCTYPE ON BARS.CF_MAPPING_DOCTYPE (TYPE_CF, TYPE_ABS) 
  PCTFREE 10 INITRANS 2 MAXTRANS 255 COMPUTE STATISTICS 
  TABLESPACE BRSDYNI ';
exception when others then
  if  sqlcode=-955  then null; else raise; end if;
 end;
/



PROMPT *** Create  grants  CF_MAPPING_DOCTYPE ***
grant SELECT                                                                 on CF_MAPPING_DOCTYPE to BARS_ACCESS_DEFROLE;



PROMPT ===================================================================================== 
PROMPT *** End *** ========== Scripts /Sql/BARS/Table/CF_MAPPING_DOCTYPE.sql =========*** En
PROMPT ===================================================================================== 
