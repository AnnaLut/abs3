

PROMPT ===================================================================================== 
PROMPT *** Run *** ========== Scripts /Sql/BARS/Table/DWH_REPORT_LINKS.sql =========*** Run 
PROMPT ===================================================================================== 


PROMPT *** ALTER_POLICY_INFO to DWH_REPORT_LINKS ***


BEGIN 
        execute immediate  
          'begin  
               bpa.alter_policy_info(''DWH_REPORT_LINKS'', ''FILIAL'' , null, null, null, null);
               bpa.alter_policy_info(''DWH_REPORT_LINKS'', ''WHOLE'' , null, null, null, null);
               null;
           end; 
          '; 
END; 
/

PROMPT *** Create  table DWH_REPORT_LINKS ***
begin 
  execute immediate '
  CREATE TABLE BARS.DWH_REPORT_LINKS 
   (	REPORT_ID NUMBER, 
	MODULE_ID VARCHAR2(10)
   ) SEGMENT CREATION IMMEDIATE 
  PCTFREE 10 PCTUSED 40 INITRANS 1 MAXTRANS 255 
 NOCOMPRESS LOGGING
  TABLESPACE BRSDYND ';
exception when others then       
  if sqlcode=-955 then null; else raise; end if; 
end; 
/




PROMPT *** ALTER_POLICIES to DWH_REPORT_LINKS ***
 exec bpa.alter_policies('DWH_REPORT_LINKS');


COMMENT ON TABLE BARS.DWH_REPORT_LINKS IS 'DWH: Довідник "Привязка звітів до армів';
COMMENT ON COLUMN BARS.DWH_REPORT_LINKS.REPORT_ID IS 'Ключ звіту з DWH_REPORTS';
COMMENT ON COLUMN BARS.DWH_REPORT_LINKS.MODULE_ID IS 'Ключ модуля(АРМу) з BARS.BARS_MODULES';




PROMPT *** Create  constraint PK_DWH_REPORT_LINKS ***
begin   
 execute immediate '
  ALTER TABLE BARS.DWH_REPORT_LINKS ADD CONSTRAINT PK_DWH_REPORT_LINKS PRIMARY KEY (REPORT_ID, MODULE_ID)
  USING INDEX PCTFREE 10 INITRANS 2 MAXTRANS 255 COMPUTE STATISTICS 
  TABLESPACE BRSDYND  ENABLE';
exception when others then
  if  sqlcode=-2260 or sqlcode=-2261 or sqlcode=-2264 or sqlcode=-2275 or sqlcode=-1442 then null; else raise; end if;
 end;
/




PROMPT *** Create  index PK_DWH_REPORT_LINKS ***
begin   
 execute immediate '
  CREATE UNIQUE INDEX BARS.PK_DWH_REPORT_LINKS ON BARS.DWH_REPORT_LINKS (REPORT_ID, MODULE_ID) 
  PCTFREE 10 INITRANS 2 MAXTRANS 255 COMPUTE STATISTICS 
  TABLESPACE BRSDYND ';
exception when others then
  if  sqlcode=-955  then null; else raise; end if;
 end;
/



PROMPT *** Create  grants  DWH_REPORT_LINKS ***
grant SELECT                                                                 on DWH_REPORT_LINKS to BARSREADER_ROLE;
grant DELETE,INSERT,SELECT,UPDATE                                            on DWH_REPORT_LINKS to BARS_ACCESS_DEFROLE;
grant SELECT                                                                 on DWH_REPORT_LINKS to UPLD;



PROMPT ===================================================================================== 
PROMPT *** End *** ========== Scripts /Sql/BARS/Table/DWH_REPORT_LINKS.sql =========*** End 
PROMPT ===================================================================================== 
