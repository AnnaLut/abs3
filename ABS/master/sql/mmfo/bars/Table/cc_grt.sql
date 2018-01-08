

PROMPT ===================================================================================== 
PROMPT *** Run *** ========== Scripts /Sql/BARS/Table/CC_GRT.sql =========*** Run *** ======
PROMPT ===================================================================================== 


PROMPT *** ALTER_POLICY_INFO to CC_GRT ***


BEGIN 
        execute immediate  
          'begin  
               bpa.alter_policy_info(''CC_GRT'', ''CENTER'' , null, null, null, null);
               bpa.alter_policy_info(''CC_GRT'', ''FILIAL'' , null, null, null, null);
               bpa.alter_policy_info(''CC_GRT'', ''WHOLE'' , null, null, null, null);
               null;
           end; 
          '; 
END; 
/

PROMPT *** Create  table CC_GRT ***
begin 
  execute immediate '
  CREATE TABLE BARS.CC_GRT 
   (	ND NUMBER(38,0), 
	GRT_DEAL_ID NUMBER(38,0), 
	 CONSTRAINT PK_CCGRT PRIMARY KEY (ND, GRT_DEAL_ID) ENABLE
   ) ORGANIZATION INDEX NOCOMPRESS PCTFREE 10 INITRANS 2 MAXTRANS 255 LOGGING
  TABLESPACE BRSDYND 
 PCTTHRESHOLD 50';
exception when others then       
  if sqlcode=-955 then null; else raise; end if; 
end; 
/




PROMPT *** ALTER_POLICIES to CC_GRT ***
 exec bpa.alter_policies('CC_GRT');


COMMENT ON TABLE BARS.CC_GRT IS 'Cвязь кредитных договоров и договоров обеспечения';
COMMENT ON COLUMN BARS.CC_GRT.ND IS 'Идетнификатор кредитного договора';
COMMENT ON COLUMN BARS.CC_GRT.GRT_DEAL_ID IS 'Идентификатор договора обеспечения';




PROMPT *** Create  constraint CC_CCGRT_ND_NN ***
begin   
 execute immediate '
  ALTER TABLE BARS.CC_GRT MODIFY (ND CONSTRAINT CC_CCGRT_ND_NN NOT NULL ENABLE)';
exception when others then
  if  sqlcode=-2260 or sqlcode=-2261 or sqlcode=-2264 or sqlcode=-2275 or sqlcode=-1442 then null; else raise; end if;
 end;
/




PROMPT *** Create  constraint CC_CCGRT_GRTDEALID_NN ***
begin   
 execute immediate '
  ALTER TABLE BARS.CC_GRT MODIFY (GRT_DEAL_ID CONSTRAINT CC_CCGRT_GRTDEALID_NN NOT NULL ENABLE)';
exception when others then
  if  sqlcode=-2260 or sqlcode=-2261 or sqlcode=-2264 or sqlcode=-2275 or sqlcode=-1442 then null; else raise; end if;
 end;
/




PROMPT *** Create  constraint PK_CCGRT ***
begin   
 execute immediate '
  ALTER TABLE BARS.CC_GRT ADD CONSTRAINT PK_CCGRT PRIMARY KEY (ND, GRT_DEAL_ID)
  USING INDEX PCTFREE 10 INITRANS 2 MAXTRANS 255 COMPUTE STATISTICS 
  TABLESPACE BRSDYND  ENABLE';
exception when others then
  if  sqlcode=-2260 or sqlcode=-2261 or sqlcode=-2264 or sqlcode=-2275 or sqlcode=-1442 then null; else raise; end if;
 end;
/




PROMPT *** Create  index PK_CCGRT ***
begin   
 execute immediate '
  CREATE UNIQUE INDEX BARS.PK_CCGRT ON BARS.CC_GRT (ND, GRT_DEAL_ID) 
  PCTFREE 10 INITRANS 2 MAXTRANS 255 COMPUTE STATISTICS 
  TABLESPACE BRSDYND ';
exception when others then
  if  sqlcode=-955  then null; else raise; end if;
 end;
/



PROMPT *** Create  grants  CC_GRT ***
grant SELECT                                                                 on CC_GRT          to BARSREADER_ROLE;
grant SELECT                                                                 on CC_GRT          to BARSUPL;
grant DELETE,INSERT,SELECT,UPDATE                                            on CC_GRT          to BARS_ACCESS_DEFROLE;
grant SELECT                                                                 on CC_GRT          to BARS_DM;
grant DELETE,INSERT,SELECT,UPDATE                                            on CC_GRT          to START1;



PROMPT ===================================================================================== 
PROMPT *** End *** ========== Scripts /Sql/BARS/Table/CC_GRT.sql =========*** End *** ======
PROMPT ===================================================================================== 
