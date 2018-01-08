

PROMPT ===================================================================================== 
PROMPT *** Run *** ========== Scripts /Sql/BARS/Table/FINMON_DOC_MATCH.sql =========*** Run 
PROMPT ===================================================================================== 


PROMPT *** ALTER_POLICY_INFO to FINMON_DOC_MATCH ***


BEGIN 
        execute immediate  
          'begin  
               bpa.alter_policy_info(''FINMON_DOC_MATCH'', ''CENTER'' , null, null, null, null);
               bpa.alter_policy_info(''FINMON_DOC_MATCH'', ''FILIAL'' , null, null, null, null);
               bpa.alter_policy_info(''FINMON_DOC_MATCH'', ''WHOLE'' , null, null, null, null);
               null;
           end; 
          '; 
END; 
/

PROMPT *** Create  table FINMON_DOC_MATCH ***
begin 
  execute immediate '
  CREATE TABLE BARS.FINMON_DOC_MATCH 
   (	BARS_CODE NUMBER(2,0), 
	FINMON_CODE VARCHAR2(2)
   ) SEGMENT CREATION IMMEDIATE 
  PCTFREE 10 PCTUSED 40 INITRANS 1 MAXTRANS 255 
 NOCOMPRESS LOGGING
  TABLESPACE BRSDYND ';
exception when others then       
  if sqlcode=-955 then null; else raise; end if; 
end; 
/




PROMPT *** ALTER_POLICIES to FINMON_DOC_MATCH ***
 exec bpa.alter_policies('FINMON_DOC_MATCH');


COMMENT ON TABLE BARS.FINMON_DOC_MATCH IS 'Таблица перекодировки кодов документов для Фин.Мон.';
COMMENT ON COLUMN BARS.FINMON_DOC_MATCH.BARS_CODE IS 'Код документа в АБС';
COMMENT ON COLUMN BARS.FINMON_DOC_MATCH.FINMON_CODE IS 'Код документа в Фин.Мон.';




PROMPT *** Create  constraint XPK_DOC_REGION_MATCH ***
begin   
 execute immediate '
  ALTER TABLE BARS.FINMON_DOC_MATCH ADD CONSTRAINT XPK_DOC_REGION_MATCH PRIMARY KEY (BARS_CODE)
  USING INDEX PCTFREE 10 INITRANS 2 MAXTRANS 255 COMPUTE STATISTICS 
  TABLESPACE BRSDYND  ENABLE';
exception when others then
  if  sqlcode=-2260 or sqlcode=-2261 or sqlcode=-2264 or sqlcode=-2275 or sqlcode=-1442 then null; else raise; end if;
 end;
/




PROMPT *** Create  index XPK_DOC_REGION_MATCH ***
begin   
 execute immediate '
  CREATE UNIQUE INDEX BARS.XPK_DOC_REGION_MATCH ON BARS.FINMON_DOC_MATCH (BARS_CODE) 
  PCTFREE 10 INITRANS 2 MAXTRANS 255 COMPUTE STATISTICS 
  TABLESPACE BRSDYND ';
exception when others then
  if  sqlcode=-955  then null; else raise; end if;
 end;
/



PROMPT *** Create  grants  FINMON_DOC_MATCH ***
grant SELECT                                                                 on FINMON_DOC_MATCH to BARS_ACCESS_DEFROLE;
grant SELECT                                                                 on FINMON_DOC_MATCH to BARS_DM;
grant SELECT                                                                 on FINMON_DOC_MATCH to START1;



PROMPT *** Create SYNONYM  to FINMON_DOC_MATCH ***

  CREATE OR REPLACE PUBLIC SYNONYM FINMON_DOC_MATCH FOR BARS.FINMON_DOC_MATCH;


PROMPT ===================================================================================== 
PROMPT *** End *** ========== Scripts /Sql/BARS/Table/FINMON_DOC_MATCH.sql =========*** End 
PROMPT ===================================================================================== 
