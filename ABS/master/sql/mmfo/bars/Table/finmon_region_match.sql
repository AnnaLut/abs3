

PROMPT ===================================================================================== 
PROMPT *** Run *** ========== Scripts /Sql/BARS/Table/FINMON_REGION_MATCH.sql =========*** R
PROMPT ===================================================================================== 


PROMPT *** ALTER_POLICY_INFO to FINMON_REGION_MATCH ***


BEGIN 
        execute immediate  
          'begin  
               bpa.alter_policy_info(''FINMON_REGION_MATCH'', ''CENTER'' , null, null, null, null);
               bpa.alter_policy_info(''FINMON_REGION_MATCH'', ''FILIAL'' , null, null, null, null);
               bpa.alter_policy_info(''FINMON_REGION_MATCH'', ''WHOLE'' , null, null, null, null);
               null;
           end; 
          '; 
END; 
/

PROMPT *** Create  table FINMON_REGION_MATCH ***
begin 
  execute immediate '
  CREATE TABLE BARS.FINMON_REGION_MATCH 
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




PROMPT *** ALTER_POLICIES to FINMON_REGION_MATCH ***
 exec bpa.alter_policies('FINMON_REGION_MATCH');


COMMENT ON TABLE BARS.FINMON_REGION_MATCH IS 'Таблица перекодировки кодов областей для Фин.Мон.';
COMMENT ON COLUMN BARS.FINMON_REGION_MATCH.BARS_CODE IS 'Код области в АБС';
COMMENT ON COLUMN BARS.FINMON_REGION_MATCH.FINMON_CODE IS 'Код области в Фин.Мон.';




PROMPT *** Create  constraint XPK_FINMON_REGION_MATCH ***
begin   
 execute immediate '
  ALTER TABLE BARS.FINMON_REGION_MATCH ADD CONSTRAINT XPK_FINMON_REGION_MATCH PRIMARY KEY (BARS_CODE)
  USING INDEX PCTFREE 10 INITRANS 2 MAXTRANS 255 COMPUTE STATISTICS 
  TABLESPACE BRSDYND  ENABLE';
exception when others then
  if  sqlcode=-2260 or sqlcode=-2261 or sqlcode=-2264 or sqlcode=-2275 or sqlcode=-1442 then null; else raise; end if;
 end;
/




PROMPT *** Create  index XPK_FINMON_REGION_MATCH ***
begin   
 execute immediate '
  CREATE UNIQUE INDEX BARS.XPK_FINMON_REGION_MATCH ON BARS.FINMON_REGION_MATCH (BARS_CODE) 
  PCTFREE 10 INITRANS 2 MAXTRANS 255 COMPUTE STATISTICS 
  TABLESPACE BRSDYND ';
exception when others then
  if  sqlcode=-955  then null; else raise; end if;
 end;
/



PROMPT *** Create  grants  FINMON_REGION_MATCH ***
grant SELECT                                                                 on FINMON_REGION_MATCH to BARSREADER_ROLE;
grant ALTER,DEBUG,DELETE,FLASHBACK,INSERT,ON COMMIT REFRESH,QUERY REWRITE,SELECT,UPDATE on FINMON_REGION_MATCH to BARS_ACCESS_DEFROLE;
grant SELECT                                                                 on FINMON_REGION_MATCH to BARS_DM;
grant ALTER,DEBUG,DELETE,FLASHBACK,INSERT,ON COMMIT REFRESH,QUERY REWRITE,SELECT,UPDATE on FINMON_REGION_MATCH to FINMON01;
grant SELECT                                                                 on FINMON_REGION_MATCH to START1;
grant SELECT                                                                 on FINMON_REGION_MATCH to UPLD;



PROMPT *** Create SYNONYM  to FINMON_REGION_MATCH ***

  CREATE OR REPLACE PUBLIC SYNONYM FINMON_REGION_MATCH FOR BARS.FINMON_REGION_MATCH;


PROMPT ===================================================================================== 
PROMPT *** End *** ========== Scripts /Sql/BARS/Table/FINMON_REGION_MATCH.sql =========*** E
PROMPT ===================================================================================== 
