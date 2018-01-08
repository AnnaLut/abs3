

PROMPT ===================================================================================== 
PROMPT *** Run *** ========== Scripts /Sql/BARS/Table/WCS_BCK_PARAMS.sql =========*** Run **
PROMPT ===================================================================================== 


PROMPT *** ALTER_POLICY_INFO to WCS_BCK_PARAMS ***


BEGIN 
        execute immediate  
          'begin  
               bpa.alter_policy_info(''WCS_BCK_PARAMS'', ''CENTER'' , null, null, null, null);
               bpa.alter_policy_info(''WCS_BCK_PARAMS'', ''FILIAL'' , null, null, null, null);
               bpa.alter_policy_info(''WCS_BCK_PARAMS'', ''WHOLE'' , null, null, null, null);
               null;
           end; 
          '; 
END; 
/

PROMPT *** Create  table WCS_BCK_PARAMS ***
begin 
  execute immediate '
  CREATE TABLE BARS.WCS_BCK_PARAMS 
   (	PARAM_NAME VARCHAR2(12), 
	PARAM_VALUE VARCHAR2(128)
   ) SEGMENT CREATION IMMEDIATE 
  PCTFREE 10 PCTUSED 40 INITRANS 1 MAXTRANS 255 
 NOCOMPRESS LOGGING
  TABLESPACE BRSSMLD ';
exception when others then       
  if sqlcode=-955 then null; else raise; end if; 
end; 
/




PROMPT *** ALTER_POLICIES to WCS_BCK_PARAMS ***
 exec bpa.alter_policies('WCS_BCK_PARAMS');


COMMENT ON TABLE BARS.WCS_BCK_PARAMS IS 'Таблица параметров кредитного бюро';
COMMENT ON COLUMN BARS.WCS_BCK_PARAMS.PARAM_NAME IS 'Наименование параметра';
COMMENT ON COLUMN BARS.WCS_BCK_PARAMS.PARAM_VALUE IS 'Значение парамтера';




PROMPT *** Create  constraint PK_WCSBCKPARAMS ***
begin   
 execute immediate '
  ALTER TABLE BARS.WCS_BCK_PARAMS ADD CONSTRAINT PK_WCSBCKPARAMS PRIMARY KEY (PARAM_NAME)
  USING INDEX PCTFREE 10 INITRANS 2 MAXTRANS 255 COMPUTE STATISTICS 
  TABLESPACE BRSSMLD  ENABLE';
exception when others then
  if  sqlcode=-2260 or sqlcode=-2261 or sqlcode=-2264 or sqlcode=-2275 or sqlcode=-1442 then null; else raise; end if;
 end;
/




PROMPT *** Create  index PK_WCSBCKPARAMS ***
begin   
 execute immediate '
  CREATE UNIQUE INDEX BARS.PK_WCSBCKPARAMS ON BARS.WCS_BCK_PARAMS (PARAM_NAME) 
  PCTFREE 10 INITRANS 2 MAXTRANS 255 COMPUTE STATISTICS 
  TABLESPACE BRSSMLD ';
exception when others then
  if  sqlcode=-955  then null; else raise; end if;
 end;
/



PROMPT *** Create  grants  WCS_BCK_PARAMS ***
grant SELECT                                                                 on WCS_BCK_PARAMS  to BARSREADER_ROLE;
grant DELETE,INSERT,SELECT,UPDATE                                            on WCS_BCK_PARAMS  to BARS_ACCESS_DEFROLE;
grant SELECT                                                                 on WCS_BCK_PARAMS  to BARS_DM;
grant DELETE,INSERT,SELECT,UPDATE                                            on WCS_BCK_PARAMS  to START1;
grant SELECT                                                                 on WCS_BCK_PARAMS  to UPLD;



PROMPT ===================================================================================== 
PROMPT *** End *** ========== Scripts /Sql/BARS/Table/WCS_BCK_PARAMS.sql =========*** End **
PROMPT ===================================================================================== 
