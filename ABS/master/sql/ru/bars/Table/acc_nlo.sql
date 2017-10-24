

PROMPT ===================================================================================== 
PROMPT *** Run *** ========== Scripts /Sql/BARS/Table/ACC_NLO.sql =========*** Run *** =====
PROMPT ===================================================================================== 


PROMPT *** ALTER_POLICY_INFO to ACC_NLO ***


BEGIN 
        execute immediate  
          'begin  
               bpa.alter_policy_info(''ACC_NLO'', ''FILIAL'' , null, null, null, null);
               bpa.alter_policy_info(''ACC_NLO'', ''WHOLE'' , null, null, null, null);
               null;
           end; 
          '; 
END; 
/

PROMPT *** Create  table ACC_NLO ***
begin 
  execute immediate '
  CREATE TABLE BARS.ACC_NLO 
   (	ACC NUMBER(*,0)
   ) SEGMENT CREATION IMMEDIATE 
  PCTFREE 10 PCTUSED 40 INITRANS 1 MAXTRANS 255 
 NOCOMPRESS LOGGING
  TABLESPACE BRSDYND ';
exception when others then       
  if sqlcode=-955 then null; else raise; end if; 
end; 
/




PROMPT *** ALTER_POLICIES to ACC_NLO ***
 exec bpa.alter_policies('ACC_NLO');


COMMENT ON TABLE BARS.ACC_NLO IS '';
COMMENT ON COLUMN BARS.ACC_NLO.ACC IS '';




PROMPT *** Create  constraint PK_ACC_NLO_ACC ***
begin   
 execute immediate '
  ALTER TABLE BARS.ACC_NLO ADD CONSTRAINT PK_ACC_NLO_ACC PRIMARY KEY (ACC)
  USING INDEX PCTFREE 10 INITRANS 2 MAXTRANS 255 COMPUTE STATISTICS 
  TABLESPACE BRSDYND  ENABLE';
exception when others then
  if  sqlcode=-2260 or sqlcode=-2261 or sqlcode=-2264 or sqlcode=-2275 or sqlcode=-1442 then null; else raise; end if;
 end;
/




PROMPT *** Create  index PK_ACC_NLO_ACC ***
begin   
 execute immediate '
  CREATE UNIQUE INDEX BARS.PK_ACC_NLO_ACC ON BARS.ACC_NLO (ACC) 
  PCTFREE 10 INITRANS 2 MAXTRANS 255 COMPUTE STATISTICS 
  TABLESPACE BRSDYND ';
exception when others then
  if  sqlcode=-955  then null; else raise; end if;
 end;
/



PROMPT *** Create  grants  ACC_NLO ***
grant DELETE,INSERT,SELECT,UPDATE                                            on ACC_NLO         to BARS_ACCESS_DEFROLE;
grant SELECT                                                                 on ACC_NLO         to RCC_DEAL;
grant DELETE,INSERT,SELECT,UPDATE                                            on ACC_NLO         to START1;



PROMPT ===================================================================================== 
PROMPT *** End *** ========== Scripts /Sql/BARS/Table/ACC_NLO.sql =========*** End *** =====
PROMPT ===================================================================================== 
