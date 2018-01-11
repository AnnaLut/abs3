

PROMPT ===================================================================================== 
PROMPT *** Run *** ========== Scripts /Sql/BARS/Table/BU_PLAN.sql =========*** Run *** =====
PROMPT ===================================================================================== 


PROMPT *** ALTER_POLICY_INFO to BU_PLAN ***


BEGIN 
        execute immediate  
          'begin  
               bpa.alter_policy_info(''BU_PLAN'', ''CENTER'' , null, null, null, null);
               bpa.alter_policy_info(''BU_PLAN'', ''FILIAL'' , null, null, null, null);
               bpa.alter_policy_info(''BU_PLAN'', ''WHOLE'' , null, null, null, null);
               null;
           end; 
          '; 
END; 
/

PROMPT *** Create  table BU_PLAN ***
begin 
  execute immediate '
  CREATE TABLE BARS.BU_PLAN 
   (	PDAT DATE, 
	ID NUMBER(*,0), 
	SP NUMBER, 
	BRANCH VARCHAR2(30)
   ) SEGMENT CREATION IMMEDIATE 
  PCTFREE 10 PCTUSED 40 INITRANS 1 MAXTRANS 255 
 NOCOMPRESS LOGGING
  TABLESPACE BRSDYND ';
exception when others then       
  if sqlcode=-955 then null; else raise; end if; 
end; 
/




PROMPT *** ALTER_POLICIES to BU_PLAN ***
 exec bpa.alter_policies('BU_PLAN');


COMMENT ON TABLE BARS.BU_PLAN IS '';
COMMENT ON COLUMN BARS.BU_PLAN.PDAT IS '';
COMMENT ON COLUMN BARS.BU_PLAN.ID IS '';
COMMENT ON COLUMN BARS.BU_PLAN.SP IS '';
COMMENT ON COLUMN BARS.BU_PLAN.BRANCH IS '';




PROMPT *** Create  constraint XPK_BUPLAN ***
begin   
 execute immediate '
  ALTER TABLE BARS.BU_PLAN ADD CONSTRAINT XPK_BUPLAN PRIMARY KEY (BRANCH, PDAT, ID)
  USING INDEX PCTFREE 10 INITRANS 2 MAXTRANS 255 COMPUTE STATISTICS 
  TABLESPACE BRSDYND  ENABLE';
exception when others then
  if  sqlcode=-2260 or sqlcode=-2261 or sqlcode=-2264 or sqlcode=-2275 or sqlcode=-1442 then null; else raise; end if;
 end;
/




PROMPT *** Create  index XPK_BUPLAN ***
begin   
 execute immediate '
  CREATE UNIQUE INDEX BARS.XPK_BUPLAN ON BARS.BU_PLAN (BRANCH, PDAT, ID) 
  PCTFREE 10 INITRANS 2 MAXTRANS 255 COMPUTE STATISTICS 
  TABLESPACE BRSDYND ';
exception when others then
  if  sqlcode=-955  then null; else raise; end if;
 end;
/



PROMPT *** Create  grants  BU_PLAN ***
grant SELECT                                                                 on BU_PLAN         to BARSREADER_ROLE;
grant DELETE,FLASHBACK,INSERT,SELECT,UPDATE                                  on BU_PLAN         to BARS_ACCESS_DEFROLE;
grant SELECT                                                                 on BU_PLAN         to BARS_DM;
grant DELETE,INSERT,SELECT,UPDATE                                            on BU_PLAN         to BU;
grant DELETE,INSERT,SELECT,UPDATE                                            on BU_PLAN         to SALGL;
grant SELECT                                                                 on BU_PLAN         to UPLD;
grant FLASHBACK,SELECT                                                       on BU_PLAN         to WR_REFREAD;



PROMPT ===================================================================================== 
PROMPT *** End *** ========== Scripts /Sql/BARS/Table/BU_PLAN.sql =========*** End *** =====
PROMPT ===================================================================================== 
