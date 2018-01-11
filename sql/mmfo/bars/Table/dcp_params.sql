

PROMPT ===================================================================================== 
PROMPT *** Run *** ========== Scripts /Sql/BARS/Table/DCP_PARAMS.sql =========*** Run *** ==
PROMPT ===================================================================================== 


PROMPT *** ALTER_POLICY_INFO to DCP_PARAMS ***


BEGIN 
        execute immediate  
          'begin  
               bpa.alter_policy_info(''DCP_PARAMS'', ''FILIAL'' , null, null, null, null);
               bpa.alter_policy_info(''DCP_PARAMS'', ''WHOLE'' , null, null, null, null);
               null;
           end; 
          '; 
END; 
/

PROMPT *** Create  table DCP_PARAMS ***
begin 
  execute immediate '
  CREATE TABLE BARS.DCP_PARAMS 
   (	PAR VARCHAR2(10), 
	VAL VARCHAR2(100), 
	COMM VARCHAR2(100), 
	KF VARCHAR2(6) DEFAULT sys_context(''bars_context'',''user_mfo'')
   ) SEGMENT CREATION IMMEDIATE 
  PCTFREE 10 PCTUSED 40 INITRANS 1 MAXTRANS 255 
 NOCOMPRESS LOGGING
  TABLESPACE BRSSMLD ';
exception when others then       
  if sqlcode=-955 then null; else raise; end if; 
end; 
/




PROMPT *** ALTER_POLICIES to DCP_PARAMS ***
 exec bpa.alter_policies('DCP_PARAMS');


COMMENT ON TABLE BARS.DCP_PARAMS IS 'DCP. Параметри модуля';
COMMENT ON COLUMN BARS.DCP_PARAMS.PAR IS 'Код параметру';
COMMENT ON COLUMN BARS.DCP_PARAMS.VAL IS 'Значення';
COMMENT ON COLUMN BARS.DCP_PARAMS.COMM IS 'Назва параметру';
COMMENT ON COLUMN BARS.DCP_PARAMS.KF IS '';




PROMPT *** Create  constraint CC_DCP_PARAMS_KF_NN ***
begin   
 execute immediate '
  ALTER TABLE BARS.DCP_PARAMS MODIFY (KF CONSTRAINT CC_DCP_PARAMS_KF_NN NOT NULL ENABLE)';
exception when others then
  if  sqlcode=-2260 or sqlcode=-2261 or sqlcode=-2264 or sqlcode=-2275 or sqlcode=-1442 then null; else raise; end if;
 end;
/




PROMPT *** Create  index PK_DCP_PARAMS ***
begin   
 execute immediate '
  CREATE UNIQUE INDEX BARS.PK_DCP_PARAMS ON BARS.DCP_PARAMS (PAR) 
  PCTFREE 10 INITRANS 2 MAXTRANS 255 COMPUTE STATISTICS 
  TABLESPACE BRSSMLI ';
exception when others then
  if  sqlcode=-955  then null; else raise; end if;
 end;
/



PROMPT *** Create  grants  DCP_PARAMS ***
grant SELECT                                                                 on DCP_PARAMS      to BARSREADER_ROLE;
grant DELETE,FLASHBACK,INSERT,SELECT,UPDATE                                  on DCP_PARAMS      to BARS_ACCESS_DEFROLE;
grant SELECT                                                                 on DCP_PARAMS      to UPLD;



PROMPT ===================================================================================== 
PROMPT *** End *** ========== Scripts /Sql/BARS/Table/DCP_PARAMS.sql =========*** End *** ==
PROMPT ===================================================================================== 
