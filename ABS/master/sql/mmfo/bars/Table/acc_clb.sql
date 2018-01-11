

PROMPT ===================================================================================== 
PROMPT *** Run *** ========== Scripts /Sql/BARS/Table/ACC_CLB.sql =========*** Run *** =====
PROMPT ===================================================================================== 


PROMPT *** ALTER_POLICY_INFO to ACC_CLB ***


BEGIN 
        execute immediate  
          'begin  
               bpa.alter_policy_info(''ACC_CLB'', ''CENTER'' , null, null, null, null);
               bpa.alter_policy_info(''ACC_CLB'', ''FILIAL'' , null, null, null, null);
               bpa.alter_policy_info(''ACC_CLB'', ''WHOLE'' , null, null, null, null);
               null;
           end; 
          '; 
END; 
/

PROMPT *** Create  table ACC_CLB ***
begin 
  execute immediate '
  CREATE TABLE BARS.ACC_CLB 
   (	ACC NUMBER, 
	CLBID NUMBER
   ) SEGMENT CREATION IMMEDIATE 
  PCTFREE 10 PCTUSED 40 INITRANS 1 MAXTRANS 255 
 NOCOMPRESS LOGGING
  TABLESPACE BRSDYND ';
exception when others then       
  if sqlcode=-955 then null; else raise; end if; 
end; 
/




PROMPT *** ALTER_POLICIES to ACC_CLB ***
 exec bpa.alter_policies('ACC_CLB');


COMMENT ON TABLE BARS.ACC_CLB IS '';
COMMENT ON COLUMN BARS.ACC_CLB.ACC IS '';
COMMENT ON COLUMN BARS.ACC_CLB.CLBID IS '';




PROMPT *** Create  constraint XPK_ACC_CLB ***
begin   
 execute immediate '
  ALTER TABLE BARS.ACC_CLB ADD CONSTRAINT XPK_ACC_CLB PRIMARY KEY (ACC)
  USING INDEX PCTFREE 10 INITRANS 2 MAXTRANS 255 COMPUTE STATISTICS 
  TABLESPACE BRSDYND  ENABLE';
exception when others then
  if  sqlcode=-2260 or sqlcode=-2261 or sqlcode=-2264 or sqlcode=-2275 or sqlcode=-1442 then null; else raise; end if;
 end;
/




PROMPT *** Create  constraint SYS_C009055 ***
begin   
 execute immediate '
  ALTER TABLE BARS.ACC_CLB MODIFY (ACC NOT NULL ENABLE)';
exception when others then
  if  sqlcode=-2260 or sqlcode=-2261 or sqlcode=-2264 or sqlcode=-2275 or sqlcode=-1442 then null; else raise; end if;
 end;
/




PROMPT *** Create  index XPK_ACC_CLB ***
begin   
 execute immediate '
  CREATE UNIQUE INDEX BARS.XPK_ACC_CLB ON BARS.ACC_CLB (ACC) 
  PCTFREE 10 INITRANS 2 MAXTRANS 255 COMPUTE STATISTICS 
  TABLESPACE BRSDYND ';
exception when others then
  if  sqlcode=-955  then null; else raise; end if;
 end;
/



PROMPT *** Create  grants  ACC_CLB ***
grant SELECT                                                                 on ACC_CLB         to BARSREADER_ROLE;
grant DELETE,INSERT,SELECT,UPDATE                                            on ACC_CLB         to BARS_ACCESS_DEFROLE;
grant SELECT                                                                 on ACC_CLB         to BARS_DM;
grant DELETE,INSERT,SELECT,UPDATE                                            on ACC_CLB         to START1;
grant SELECT                                                                 on ACC_CLB         to UPLD;



PROMPT ===================================================================================== 
PROMPT *** End *** ========== Scripts /Sql/BARS/Table/ACC_CLB.sql =========*** End *** =====
PROMPT ===================================================================================== 
