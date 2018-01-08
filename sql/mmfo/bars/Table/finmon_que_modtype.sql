

PROMPT ===================================================================================== 
PROMPT *** Run *** ========== Scripts /Sql/BARS/Table/FINMON_QUE_MODTYPE.sql =========*** Ru
PROMPT ===================================================================================== 


PROMPT *** ALTER_POLICY_INFO to FINMON_QUE_MODTYPE ***


BEGIN 
        execute immediate  
          'begin  
               bpa.alter_policy_info(''FINMON_QUE_MODTYPE'', ''CENTER'' , null, null, null, null);
               bpa.alter_policy_info(''FINMON_QUE_MODTYPE'', ''FILIAL'' , null, ''E'', ''E'', ''E'');
               bpa.alter_policy_info(''FINMON_QUE_MODTYPE'', ''WHOLE'' , null, null, null, null);
               null;
           end; 
          '; 
END; 
/

PROMPT *** Create  table FINMON_QUE_MODTYPE ***
begin 
  execute immediate '
  CREATE TABLE BARS.FINMON_QUE_MODTYPE 
   (	MOD_TYPE VARCHAR2(1), 
	MOD_NAME VARCHAR2(50)
   ) SEGMENT CREATION IMMEDIATE 
  PCTFREE 10 PCTUSED 40 INITRANS 1 MAXTRANS 255 
 NOCOMPRESS LOGGING
  TABLESPACE BRSSMLD ';
exception when others then       
  if sqlcode=-955 then null; else raise; end if; 
end; 
/




PROMPT *** ALTER_POLICIES to FINMON_QUE_MODTYPE ***
 exec bpa.alter_policies('FINMON_QUE_MODTYPE');


COMMENT ON TABLE BARS.FINMON_QUE_MODTYPE IS 'Список типов модификации очереди фин.мон.';
COMMENT ON COLUMN BARS.FINMON_QUE_MODTYPE.MOD_TYPE IS 'Тип модификации';
COMMENT ON COLUMN BARS.FINMON_QUE_MODTYPE.MOD_NAME IS 'Наименование';




PROMPT *** Create  constraint XPK_FINMON_QUE_MODTYPE ***
begin   
 execute immediate '
  ALTER TABLE BARS.FINMON_QUE_MODTYPE ADD CONSTRAINT XPK_FINMON_QUE_MODTYPE PRIMARY KEY (MOD_TYPE)
  USING INDEX PCTFREE 10 INITRANS 2 MAXTRANS 255 COMPUTE STATISTICS 
  TABLESPACE BRSSMLI  ENABLE';
exception when others then
  if  sqlcode=-2260 or sqlcode=-2261 or sqlcode=-2264 or sqlcode=-2275 or sqlcode=-1442 then null; else raise; end if;
 end;
/




PROMPT *** Create  index XPK_FINMON_QUE_MODTYPE ***
begin   
 execute immediate '
  CREATE UNIQUE INDEX BARS.XPK_FINMON_QUE_MODTYPE ON BARS.FINMON_QUE_MODTYPE (MOD_TYPE) 
  PCTFREE 10 INITRANS 2 MAXTRANS 255 COMPUTE STATISTICS 
  TABLESPACE BRSSMLI ';
exception when others then
  if  sqlcode=-955  then null; else raise; end if;
 end;
/



PROMPT *** Create  grants  FINMON_QUE_MODTYPE ***
grant SELECT                                                                 on FINMON_QUE_MODTYPE to BARSREADER_ROLE;
grant SELECT                                                                 on FINMON_QUE_MODTYPE to BARS_ACCESS_DEFROLE;
grant SELECT                                                                 on FINMON_QUE_MODTYPE to BARS_DM;
grant SELECT                                                                 on FINMON_QUE_MODTYPE to FINMON01;
grant SELECT                                                                 on FINMON_QUE_MODTYPE to UPLD;



PROMPT *** Create SYNONYM  to FINMON_QUE_MODTYPE ***

  CREATE OR REPLACE PUBLIC SYNONYM FINMON_QUE_MODTYPE FOR BARS.FINMON_QUE_MODTYPE;


PROMPT ===================================================================================== 
PROMPT *** End *** ========== Scripts /Sql/BARS/Table/FINMON_QUE_MODTYPE.sql =========*** En
PROMPT ===================================================================================== 
