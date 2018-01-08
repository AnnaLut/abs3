

PROMPT ===================================================================================== 
PROMPT *** Run *** ========== Scripts /Sql/BARS/Table/ACC_OVER_DEAL_HIST.sql =========*** Ru
PROMPT ===================================================================================== 


PROMPT *** ALTER_POLICY_INFO to ACC_OVER_DEAL_HIST ***


BEGIN 
        execute immediate  
          'begin  
               bpa.alter_policy_info(''ACC_OVER_DEAL_HIST'', ''CENTER'' , null, null, null, null);
               bpa.alter_policy_info(''ACC_OVER_DEAL_HIST'', ''FILIAL'' , null, null, null, null);
               bpa.alter_policy_info(''ACC_OVER_DEAL_HIST'', ''WHOLE'' , null, null, null, null);
               null;
           end; 
          '; 
END; 
/

PROMPT *** Create  table ACC_OVER_DEAL_HIST ***
begin 
  execute immediate '
  CREATE TABLE BARS.ACC_OVER_DEAL_HIST 
   (	DT DATE, 
	RESULT VARCHAR2(1000)
   ) SEGMENT CREATION IMMEDIATE 
  PCTFREE 10 PCTUSED 40 INITRANS 1 MAXTRANS 255 
 NOCOMPRESS LOGGING
  TABLESPACE BRSDYND ';
exception when others then       
  if sqlcode=-955 then null; else raise; end if; 
end; 
/




PROMPT *** ALTER_POLICIES to ACC_OVER_DEAL_HIST ***
 exec bpa.alter_policies('ACC_OVER_DEAL_HIST');


COMMENT ON TABLE BARS.ACC_OVER_DEAL_HIST IS '';
COMMENT ON COLUMN BARS.ACC_OVER_DEAL_HIST.DT IS '';
COMMENT ON COLUMN BARS.ACC_OVER_DEAL_HIST.RESULT IS '';




PROMPT *** Create  index IDX_ACC_OV_HIST ***
begin   
 execute immediate '
  CREATE UNIQUE INDEX BARS.IDX_ACC_OV_HIST ON BARS.ACC_OVER_DEAL_HIST (DT) 
  PCTFREE 10 INITRANS 2 MAXTRANS 255 COMPUTE STATISTICS 
  TABLESPACE BRSDYND ';
exception when others then
  if  sqlcode=-955  then null; else raise; end if;
 end;
/



PROMPT *** Create  grants  ACC_OVER_DEAL_HIST ***
grant SELECT                                                                 on ACC_OVER_DEAL_HIST to BARSREADER_ROLE;
grant DELETE,INSERT,SELECT,UPDATE                                            on ACC_OVER_DEAL_HIST to BARS_ACCESS_DEFROLE;
grant SELECT                                                                 on ACC_OVER_DEAL_HIST to BARS_DM;
grant DELETE,INSERT,SELECT,UPDATE                                            on ACC_OVER_DEAL_HIST to RPBN002;
grant DELETE,INSERT,SELECT,UPDATE                                            on ACC_OVER_DEAL_HIST to START1;
grant SELECT                                                                 on ACC_OVER_DEAL_HIST to UPLD;



PROMPT *** Create SYNONYM  to ACC_OVER_DEAL_HIST ***

  CREATE OR REPLACE PUBLIC SYNONYM ACC_OVER_DEAL_HIST FOR BARS.ACC_OVER_DEAL_HIST;


PROMPT ===================================================================================== 
PROMPT *** End *** ========== Scripts /Sql/BARS/Table/ACC_OVER_DEAL_HIST.sql =========*** En
PROMPT ===================================================================================== 
