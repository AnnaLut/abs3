

PROMPT ===================================================================================== 
PROMPT *** Run *** ========== Scripts /Sql/BARS/Table/ACC_NLO_1414.sql =========*** Run *** 
PROMPT ===================================================================================== 


PROMPT *** ALTER_POLICY_INFO to ACC_NLO_1414 ***


BEGIN 
        execute immediate  
          'begin  
               bpa.alter_policy_info(''ACC_NLO_1414'', ''FILIAL'' , ''M'', ''M'', ''M'', ''M'');
               bpa.alter_policy_info(''ACC_NLO_1414'', ''WHOLE'' , null, ''E'', ''E'', ''E'');
               null;
           end; 
          '; 
END; 
/

PROMPT *** Create  table ACC_NLO_1414 ***
begin 
  execute immediate '
  CREATE TABLE BARS.ACC_NLO_1414 
   (	ACC NUMBER(*,0), 
	KF VARCHAR2(6) DEFAULT sys_context(''bars_context'',''user_mfo'')
   ) SEGMENT CREATION IMMEDIATE 
  PCTFREE 10 PCTUSED 40 INITRANS 1 MAXTRANS 255 
 NOCOMPRESS LOGGING
  TABLESPACE BRSDYND ';
exception when others then       
  if sqlcode=-955 then null; else raise; end if; 
end; 
/




PROMPT *** ALTER_POLICIES to ACC_NLO_1414 ***
 exec bpa.alter_policies('ACC_NLO_1414');


COMMENT ON TABLE BARS.ACC_NLO_1414 IS '';
COMMENT ON COLUMN BARS.ACC_NLO_1414.ACC IS '';
COMMENT ON COLUMN BARS.ACC_NLO_1414.KF IS '';




PROMPT *** Create  constraint CC_ACCNLO1414_KF_NN ***
begin   
 execute immediate '
  ALTER TABLE BARS.ACC_NLO_1414 MODIFY (KF CONSTRAINT CC_ACCNLO1414_KF_NN NOT NULL ENABLE)';
exception when others then
  if  sqlcode=-2260 or sqlcode=-2261 or sqlcode=-2264 or sqlcode=-2275 or sqlcode=-1442 then null; else raise; end if;
 end;
/




PROMPT *** Create  constraint PK_ACC_NLO_1414 ***
begin   
 execute immediate '
  ALTER TABLE BARS.ACC_NLO_1414 ADD CONSTRAINT PK_ACC_NLO_1414 PRIMARY KEY (ACC)
  USING INDEX PCTFREE 10 INITRANS 2 MAXTRANS 255 COMPUTE STATISTICS 
  TABLESPACE BRSDYND  ENABLE';
exception when others then
  if  sqlcode=-2260 or sqlcode=-2261 or sqlcode=-2264 or sqlcode=-2275 or sqlcode=-1442 then null; else raise; end if;
 end;
/




PROMPT *** Create  index PK_ACC_NLO_1414 ***
begin   
 execute immediate '
  CREATE UNIQUE INDEX BARS.PK_ACC_NLO_1414 ON BARS.ACC_NLO_1414 (ACC) 
  PCTFREE 10 INITRANS 2 MAXTRANS 255 COMPUTE STATISTICS 
  TABLESPACE BRSDYND ';
exception when others then
  if  sqlcode=-955  then null; else raise; end if;
 end;
/



PROMPT *** Create  grants  ACC_NLO_1414 ***
grant DELETE,INSERT,SELECT,UPDATE                                            on ACC_NLO_1414    to BARS_ACCESS_DEFROLE;
grant DELETE,INSERT,SELECT,UPDATE                                            on ACC_NLO_1414    to RCC_DEAL;
grant DELETE,INSERT,SELECT,UPDATE                                            on ACC_NLO_1414    to START1;



PROMPT ===================================================================================== 
PROMPT *** End *** ========== Scripts /Sql/BARS/Table/ACC_NLO_1414.sql =========*** End *** 
PROMPT ===================================================================================== 
