

PROMPT ===================================================================================== 
PROMPT *** Run *** ========== Scripts /Sql/BARS/Table/DPA_PARAMS.sql =========*** Run *** ==
PROMPT ===================================================================================== 


PROMPT *** ALTER_POLICY_INFO to DPA_PARAMS ***


BEGIN 
        execute immediate  
          'begin  
               bpa.alter_policy_info(''DPA_PARAMS'', ''FILIAL'' , null, null, null, null);
               bpa.alter_policy_info(''DPA_PARAMS'', ''WHOLE'' , null, null, null, null);
               null;
           end; 
          '; 
END; 
/

PROMPT *** Create  table DPA_PARAMS ***
begin 
  execute immediate '
  CREATE TABLE BARS.DPA_PARAMS 
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




PROMPT *** ALTER_POLICIES to DPA_PARAMS ***
 exec bpa.alter_policies('DPA_PARAMS');


COMMENT ON TABLE BARS.DPA_PARAMS IS 'DPA. Параметри модуля';
COMMENT ON COLUMN BARS.DPA_PARAMS.PAR IS 'Код параметру';
COMMENT ON COLUMN BARS.DPA_PARAMS.VAL IS 'Значення';
COMMENT ON COLUMN BARS.DPA_PARAMS.COMM IS 'Назва параметру';
COMMENT ON COLUMN BARS.DPA_PARAMS.KF IS '';




PROMPT *** Create  constraint CC_DPA_PARAMS_KF_NN ***
begin   
 execute immediate '
  ALTER TABLE BARS.DPA_PARAMS MODIFY (KF CONSTRAINT CC_DPA_PARAMS_KF_NN NOT NULL ENABLE)';
exception when others then
  if  sqlcode=-2260 or sqlcode=-2261 or sqlcode=-2264 or sqlcode=-2275 or sqlcode=-1442 then null; else raise; end if;
 end;
/




PROMPT *** Create  index PK_DPA_PARAMS ***
begin   
 execute immediate '
  CREATE UNIQUE INDEX BARS.PK_DPA_PARAMS ON BARS.DPA_PARAMS (PAR) 
  PCTFREE 10 INITRANS 2 MAXTRANS 255 COMPUTE STATISTICS 
  TABLESPACE BRSDYND ';
exception when others then
  if  sqlcode=-955  then null; else raise; end if;
 end;
/



PROMPT *** Create  grants  DPA_PARAMS ***
grant SELECT                                                                 on DPA_PARAMS      to BARSREADER_ROLE;
grant DELETE,FLASHBACK,INSERT,SELECT,UPDATE                                  on DPA_PARAMS      to BARS_ACCESS_DEFROLE;
grant SELECT                                                                 on DPA_PARAMS      to UPLD;



PROMPT ===================================================================================== 
PROMPT *** End *** ========== Scripts /Sql/BARS/Table/DPA_PARAMS.sql =========*** End *** ==
PROMPT ===================================================================================== 
