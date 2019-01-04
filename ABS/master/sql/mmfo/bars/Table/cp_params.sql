

PROMPT ===================================================================================== 
PROMPT *** Run *** ========== Scripts /Sql/BARS/Table/cp_params.sql =========*** Run *** ==
PROMPT ===================================================================================== 


PROMPT *** ALTER_POLICY_INFO to cp_params ***


BEGIN 
        execute immediate  
          'begin  
               bpa.alter_policy_info(''CP_PARAMS'', ''FILIAL'' , null, null, null, null);
               bpa.alter_policy_info(''CP_PARAMS'', ''WHOLE'' , null, null, null, null);
               null;
           end; 
          '; 
END; 
/

PROMPT *** Create  table cp_params ***
begin 
  execute immediate '
  CREATE TABLE BARS.cp_params 
   (	PAR_NAME VARCHAR2(128), 
	PAR_VALUE VARCHAR2(255), 
	PAR_COMMENT VARCHAR2(4000)
   ) SEGMENT CREATION IMMEDIATE 
  PCTFREE 10 PCTUSED 40 INITRANS 1 MAXTRANS 255 
 NOCOMPRESS LOGGING
  TABLESPACE BRSMDLD ROWDEPENDENCIES ';
exception when others then       
  if sqlcode=-955 then null; else raise; end if; 
end; 
/




PROMPT *** ALTER_POLICIES to cp_params ***
 exec bpa.alter_policies('CP_PARAMS');


COMMENT ON TABLE BARS.cp_params IS 'Параметри модуля CP version 1.0';
COMMENT ON COLUMN BARS.cp_params.PAR_NAME IS 'Ім"я параметра';
COMMENT ON COLUMN BARS.cp_params.PAR_VALUE IS 'Значення параметру';
COMMENT ON COLUMN BARS.cp_params.PAR_COMMENT IS 'Коментар';


PROMPT *** Create  index IDX_U_CPPARAMS ***
begin   
 execute immediate '
  CREATE UNIQUE INDEX BARS.IDX_U_CPPARAMS ON BARS.cp_params (PAR_NAME) 
  PCTFREE 10 INITRANS 2 MAXTRANS 255 COMPUTE STATISTICS 
  TABLESPACE BRSMDLI ';
exception when others then
  if  sqlcode=-955  then null; else raise; end if;
 end;
/



PROMPT *** Create  grants  cp_params ***
grant SELECT                                                                 on cp_params      to BARSREADER_ROLE;
grant DELETE,INSERT,SELECT,UPDATE                                            on cp_params      to BARS_ACCESS_DEFROLE;
grant SELECT                                                                 on cp_params      to BARS_DM;
grant DELETE,INSERT,SELECT,UPDATE                                            on cp_params      to CP_ROLE;
grant SELECT                                                                 on cp_params      to UPLD;



PROMPT ===================================================================================== 
PROMPT *** End *** ========== Scripts /Sql/BARS/Table/cp_params.sql =========*** End *** ==
PROMPT ===================================================================================== 
