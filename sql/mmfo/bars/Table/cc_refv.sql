

PROMPT ===================================================================================== 
PROMPT *** Run *** ========== Scripts /Sql/BARS/Table/CC_REFV.sql =========*** Run *** =====
PROMPT ===================================================================================== 


PROMPT *** ALTER_POLICY_INFO to CC_REFV ***


BEGIN 
        execute immediate  
          'begin  
               bpa.alter_policy_info(''CC_REFV'', ''CENTER'' , null, null, null, null);
               bpa.alter_policy_info(''CC_REFV'', ''FILIAL'' , null, null, null, null);
               bpa.alter_policy_info(''CC_REFV'', ''WHOLE'' , null, null, null, null);
               null;
           end; 
          '; 
END; 
/

PROMPT *** Create  table CC_REFV ***
begin 
  execute immediate '
  CREATE TABLE BARS.CC_REFV 
   (	ND NUMBER(*,0), 
	REF NUMBER(*,0)
   ) SEGMENT CREATION IMMEDIATE 
  PCTFREE 10 PCTUSED 40 INITRANS 1 MAXTRANS 255 
 NOCOMPRESS LOGGING
  TABLESPACE BRSMDLD ';
exception when others then       
  if sqlcode=-955 then null; else raise; end if; 
end; 
/




PROMPT *** ALTER_POLICIES to CC_REFV ***
 exec bpa.alter_policies('CC_REFV');


COMMENT ON TABLE BARS.CC_REFV IS '';
COMMENT ON COLUMN BARS.CC_REFV.ND IS '';
COMMENT ON COLUMN BARS.CC_REFV.REF IS '';




PROMPT *** Create  constraint XPK_CC_REFV ***
begin   
 execute immediate '
  ALTER TABLE BARS.CC_REFV ADD CONSTRAINT XPK_CC_REFV PRIMARY KEY (REF)
  USING INDEX PCTFREE 10 INITRANS 2 MAXTRANS 255 COMPUTE STATISTICS 
  TABLESPACE BRSMDLI  ENABLE';
exception when others then
  if  sqlcode=-2260 or sqlcode=-2261 or sqlcode=-2264 or sqlcode=-2275 or sqlcode=-1442 then null; else raise; end if;
 end;
/




PROMPT *** Create  constraint R_CCDEAL_CCREFV ***
begin   
 execute immediate '
  ALTER TABLE BARS.CC_REFV ADD CONSTRAINT R_CCDEAL_CCREFV FOREIGN KEY (ND)
	  REFERENCES BARS.CC_DEAL (ND) DEFERRABLE ENABLE NOVALIDATE';
exception when others then
  if  sqlcode=-2260 or sqlcode=-2261 or sqlcode=-2264 or sqlcode=-2275 or sqlcode=-1442 then null; else raise; end if;
 end;
/




PROMPT *** Create  constraint NK_CC_REFV_ND ***
begin   
 execute immediate '
  ALTER TABLE BARS.CC_REFV MODIFY (ND CONSTRAINT NK_CC_REFV_ND NOT NULL ENABLE)';
exception when others then
  if  sqlcode=-2260 or sqlcode=-2261 or sqlcode=-2264 or sqlcode=-2275 or sqlcode=-1442 then null; else raise; end if;
 end;
/




PROMPT *** Create  constraint NK_CC_REFV_REF ***
begin   
 execute immediate '
  ALTER TABLE BARS.CC_REFV MODIFY (REF CONSTRAINT NK_CC_REFV_REF NOT NULL ENABLE)';
exception when others then
  if  sqlcode=-2260 or sqlcode=-2261 or sqlcode=-2264 or sqlcode=-2275 or sqlcode=-1442 then null; else raise; end if;
 end;
/




PROMPT *** Create  index XPK_CC_REFV ***
begin   
 execute immediate '
  CREATE UNIQUE INDEX BARS.XPK_CC_REFV ON BARS.CC_REFV (REF) 
  PCTFREE 10 INITRANS 2 MAXTRANS 255 COMPUTE STATISTICS 
  TABLESPACE BRSMDLI ';
exception when others then
  if  sqlcode=-955  then null; else raise; end if;
 end;
/



PROMPT *** Create  grants  CC_REFV ***
grant ALTER,DELETE,INSERT,SELECT,UPDATE                                      on CC_REFV         to BARS_ACCESS_DEFROLE;
grant SELECT                                                                 on CC_REFV         to BARS_DM;
grant ALTER,DELETE,INSERT,SELECT,UPDATE                                      on CC_REFV         to RCC_DEAL;
grant DELETE,FLASHBACK,INSERT,SELECT,UPDATE                                  on CC_REFV         to WR_ALL_RIGHTS;



PROMPT ===================================================================================== 
PROMPT *** End *** ========== Scripts /Sql/BARS/Table/CC_REFV.sql =========*** End *** =====
PROMPT ===================================================================================== 
