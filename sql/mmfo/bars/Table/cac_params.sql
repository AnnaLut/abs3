

PROMPT ===================================================================================== 
PROMPT *** Run *** ========== Scripts /Sql/BARS/Table/CAC_PARAMS.sql =========*** Run *** ==
PROMPT ===================================================================================== 


PROMPT *** ALTER_POLICY_INFO to CAC_PARAMS ***


BEGIN 
        execute immediate  
          'begin  
               bpa.alter_policy_info(''CAC_PARAMS'', ''CENTER'' , null, null, null, null);
               bpa.alter_policy_info(''CAC_PARAMS'', ''FILIAL'' , null, null, null, null);
               bpa.alter_policy_info(''CAC_PARAMS'', ''WHOLE'' , null, null, null, null);
               null;
           end; 
          '; 
END; 
/

PROMPT *** Create  table CAC_PARAMS ***
begin 
  execute immediate '
  CREATE TABLE BARS.CAC_PARAMS 
   (	NAME VARCHAR2(128), 
	VALUE VARCHAR2(4000), 
	DESCRIPTION VARCHAR2(4000)
   ) SEGMENT CREATION IMMEDIATE 
  PCTFREE 10 PCTUSED 40 INITRANS 1 MAXTRANS 255 
 NOCOMPRESS LOGGING
  TABLESPACE BRSMDLD ROWDEPENDENCIES ';
exception when others then       
  if sqlcode=-955 then null; else raise; end if; 
end; 
/




PROMPT *** ALTER_POLICIES to CAC_PARAMS ***
 exec bpa.alter_policies('CAC_PARAMS');


COMMENT ON TABLE BARS.CAC_PARAMS IS 'Параметри модуля CAC version 1.0';
COMMENT ON COLUMN BARS.CAC_PARAMS.NAME IS 'Ім'я параметра';
COMMENT ON COLUMN BARS.CAC_PARAMS.VALUE IS 'Значення параметру';
COMMENT ON COLUMN BARS.CAC_PARAMS.DESCRIPTION IS 'Коментар';




PROMPT *** Create  constraint PK_CACPARAMS ***
begin   
 execute immediate '
  ALTER TABLE BARS.CAC_PARAMS ADD CONSTRAINT PK_CACPARAMS PRIMARY KEY (NAME)
  USING INDEX PCTFREE 10 INITRANS 2 MAXTRANS 255 COMPUTE STATISTICS 
  TABLESPACE BRSMDLI  ENABLE';
exception when others then
  if  sqlcode=-2260 or sqlcode=-2261 or sqlcode=-2264 or sqlcode=-2275 or sqlcode=-1442 then null; else raise; end if;
 end;
/




PROMPT *** Create  constraint CC_CACPARAMS_PARNAME_NN ***
begin   
 execute immediate '
  ALTER TABLE BARS.CAC_PARAMS MODIFY (NAME CONSTRAINT CC_CACPARAMS_PARNAME_NN NOT NULL ENABLE)';
exception when others then
  if  sqlcode=-2260 or sqlcode=-2261 or sqlcode=-2264 or sqlcode=-2275 or sqlcode=-1442 then null; else raise; end if;
 end;
/




PROMPT *** Create  index PK_CACPARAMS ***
begin   
 execute immediate '
  CREATE UNIQUE INDEX BARS.PK_CACPARAMS ON BARS.CAC_PARAMS (NAME) 
  PCTFREE 10 INITRANS 2 MAXTRANS 255 COMPUTE STATISTICS 
  TABLESPACE BRSMDLI ';
exception when others then
  if  sqlcode=-955  then null; else raise; end if;
 end;
/



PROMPT *** Create  grants  CAC_PARAMS ***
grant SELECT                                                                 on CAC_PARAMS      to BARS_ACCESS_DEFROLE;
grant SELECT                                                                 on CAC_PARAMS      to BARS_DM;
grant SELECT                                                                 on CAC_PARAMS      to START1;



PROMPT ===================================================================================== 
PROMPT *** End *** ========== Scripts /Sql/BARS/Table/CAC_PARAMS.sql =========*** End *** ==
PROMPT ===================================================================================== 
