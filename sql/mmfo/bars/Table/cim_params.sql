

PROMPT ===================================================================================== 
PROMPT *** Run *** ========== Scripts /Sql/BARS/Table/CIM_PARAMS.sql =========*** Run *** ==
PROMPT ===================================================================================== 


PROMPT *** ALTER_POLICY_INFO to CIM_PARAMS ***


BEGIN 
        execute immediate  
          'begin  
               bpa.alter_policy_info(''CIM_PARAMS'', ''CENTER'' , null, null, null, null);
               bpa.alter_policy_info(''CIM_PARAMS'', ''FILIAL'' , ''M'', ''M'', ''M'', ''M'');
               bpa.alter_policy_info(''CIM_PARAMS'', ''WHOLE'' , null, null, null, null);
               null;
           end; 
          '; 
END; 
/

PROMPT *** Create  table CIM_PARAMS ***
begin 
  execute immediate '
  CREATE TABLE BARS.CIM_PARAMS 
   (	PAR_NAME VARCHAR2(128), 
	PAR_VALUE VARCHAR2(4000), 
	PAR_COMMENT VARCHAR2(4000), 
	GLOBAL NUMBER(*,0), 
	KF VARCHAR2(6) DEFAULT sys_context(''bars_context'',''user_mfo'')
   ) SEGMENT CREATION IMMEDIATE 
  PCTFREE 10 PCTUSED 40 INITRANS 1 MAXTRANS 255 
 NOCOMPRESS LOGGING
  TABLESPACE BRSMDLD ROWDEPENDENCIES ';
exception when others then       
  if sqlcode=-955 then null; else raise; end if; 
end; 
/




PROMPT *** ALTER_POLICIES to CIM_PARAMS ***
 exec bpa.alter_policies('CIM_PARAMS');


COMMENT ON TABLE BARS.CIM_PARAMS IS 'Параметри модуля CIM version 1.0';
COMMENT ON COLUMN BARS.CIM_PARAMS.KF IS '';
COMMENT ON COLUMN BARS.CIM_PARAMS.PAR_NAME IS 'Ім'я параметра';
COMMENT ON COLUMN BARS.CIM_PARAMS.PAR_VALUE IS 'Значення параметру';
COMMENT ON COLUMN BARS.CIM_PARAMS.PAR_COMMENT IS 'Коментар';
COMMENT ON COLUMN BARS.CIM_PARAMS.GLOBAL IS 'Ознака глобального параметру (1 - глобальний,  0 - локальний';




PROMPT *** Create  constraint PK_CIMPARAMS ***
begin   
 execute immediate '
  ALTER TABLE BARS.CIM_PARAMS ADD CONSTRAINT PK_CIMPARAMS PRIMARY KEY (PAR_NAME, KF)
  USING INDEX PCTFREE 10 INITRANS 2 MAXTRANS 255 COMPUTE STATISTICS 
  TABLESPACE BRSDYND  ENABLE';
exception when others then
  if  sqlcode=-2260 or sqlcode=-2261 or sqlcode=-2264 or sqlcode=-2275 or sqlcode=-1442 then null; else raise; end if;
 end;
/




PROMPT *** Create  constraint CC_CIMPARAMS_PARNAME_NN ***
begin   
 execute immediate '
  ALTER TABLE BARS.CIM_PARAMS MODIFY (PAR_NAME CONSTRAINT CC_CIMPARAMS_PARNAME_NN NOT NULL ENABLE NOVALIDATE)';
exception when others then
  if  sqlcode=-2260 or sqlcode=-2261 or sqlcode=-2264 or sqlcode=-2275 or sqlcode=-1442 then null; else raise; end if;
 end;
/




PROMPT *** Create  index PK_CIMPARAMS ***
begin   
 execute immediate '
  CREATE UNIQUE INDEX BARS.PK_CIMPARAMS ON BARS.CIM_PARAMS (PAR_NAME, KF) 
  PCTFREE 10 INITRANS 2 MAXTRANS 255 COMPUTE STATISTICS 
  TABLESPACE BRSDYND ';
exception when others then
  if  sqlcode=-955  then null; else raise; end if;
 end;
/



PROMPT *** Create  grants  CIM_PARAMS ***
grant SELECT                                                                 on CIM_PARAMS      to BARSREADER_ROLE;
grant DELETE,INSERT,SELECT,UPDATE                                            on CIM_PARAMS      to BARS_ACCESS_DEFROLE;
grant SELECT                                                                 on CIM_PARAMS      to BARS_DM;
grant DELETE,INSERT,SELECT,UPDATE                                            on CIM_PARAMS      to CIM_ROLE;
grant SELECT                                                                 on CIM_PARAMS      to UPLD;



PROMPT ===================================================================================== 
PROMPT *** End *** ========== Scripts /Sql/BARS/Table/CIM_PARAMS.sql =========*** End *** ==
PROMPT ===================================================================================== 
