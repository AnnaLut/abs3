

PROMPT ===================================================================================== 
PROMPT *** Run *** ========== Scripts /Sql/BARS/Table/ZAG_NOK.sql =========*** Run *** =====
PROMPT ===================================================================================== 


PROMPT *** ALTER_POLICY_INFO to ZAG_NOK ***


BEGIN 
        execute immediate  
          'begin  
               bpa.alter_policy_info(''ZAG_NOK'', ''CENTER'' , null, null, null, null);
               bpa.alter_policy_info(''ZAG_NOK'', ''FILIAL'' , null, null, null, null);
               bpa.alter_policy_info(''ZAG_NOK'', ''WHOLE'' , null, null, null, null);
               null;
           end; 
          '; 
END; 
/

PROMPT *** Create  table ZAG_NOK ***
begin 
  execute immediate '
  CREATE TABLE BARS.ZAG_NOK 
   (	FN VARCHAR2(12), 
	REC NUMBER, 
	DAT DATE
   ) SEGMENT CREATION IMMEDIATE 
  PCTFREE 10 PCTUSED 40 INITRANS 1 MAXTRANS 255 
 NOCOMPRESS LOGGING
  TABLESPACE BRSDYND ';
exception when others then       
  if sqlcode=-955 then null; else raise; end if; 
end; 
/




PROMPT *** ALTER_POLICIES to ZAG_NOK ***
 exec bpa.alter_policies('ZAG_NOK');


COMMENT ON TABLE BARS.ZAG_NOK IS '';
COMMENT ON COLUMN BARS.ZAG_NOK.FN IS '';
COMMENT ON COLUMN BARS.ZAG_NOK.REC IS '';
COMMENT ON COLUMN BARS.ZAG_NOK.DAT IS '';




PROMPT *** Create  constraint XPK_ZAG_NOKK ***
begin   
 execute immediate '
  ALTER TABLE BARS.ZAG_NOK ADD CONSTRAINT XPK_ZAG_NOKK PRIMARY KEY (FN, REC)
  USING INDEX PCTFREE 10 INITRANS 2 MAXTRANS 255 COMPUTE STATISTICS 
  TABLESPACE BRSDYND  ENABLE';
exception when others then
  if  sqlcode=-2260 or sqlcode=-2261 or sqlcode=-2264 or sqlcode=-2275 or sqlcode=-1442 then null; else raise; end if;
 end;
/




PROMPT *** Create  constraint SYS_C004949 ***
begin   
 execute immediate '
  ALTER TABLE BARS.ZAG_NOK MODIFY (FN NOT NULL ENABLE)';
exception when others then
  if  sqlcode=-2260 or sqlcode=-2261 or sqlcode=-2264 or sqlcode=-2275 or sqlcode=-1442 then null; else raise; end if;
 end;
/




PROMPT *** Create  constraint SYS_C004950 ***
begin   
 execute immediate '
  ALTER TABLE BARS.ZAG_NOK MODIFY (REC NOT NULL ENABLE)';
exception when others then
  if  sqlcode=-2260 or sqlcode=-2261 or sqlcode=-2264 or sqlcode=-2275 or sqlcode=-1442 then null; else raise; end if;
 end;
/




PROMPT *** Create  index XPK_ZAG_NOKK ***
begin   
 execute immediate '
  CREATE UNIQUE INDEX BARS.XPK_ZAG_NOKK ON BARS.ZAG_NOK (FN, REC) 
  PCTFREE 10 INITRANS 2 MAXTRANS 255 COMPUTE STATISTICS 
  TABLESPACE BRSDYND ';
exception when others then
  if  sqlcode=-955  then null; else raise; end if;
 end;
/



PROMPT *** Create  grants  ZAG_NOK ***
grant SELECT                                                                 on ZAG_NOK         to BARSREADER_ROLE;
grant ALTER,DELETE,INSERT,SELECT,UPDATE                                      on ZAG_NOK         to BARS_ACCESS_DEFROLE;
grant SELECT                                                                 on ZAG_NOK         to BARS_DM;
grant ALTER,DELETE,INSERT,SELECT,UPDATE                                      on ZAG_NOK         to NOKK;
grant DELETE,INSERT,SELECT                                                   on ZAG_NOK         to SBB_LZ;
grant DELETE,INSERT,SELECT                                                   on ZAG_NOK         to SBB_NC;
grant ALTER,DELETE,INSERT,SELECT,UPDATE                                      on ZAG_NOK         to START1;
grant SELECT                                                                 on ZAG_NOK         to UPLD;



PROMPT ===================================================================================== 
PROMPT *** End *** ========== Scripts /Sql/BARS/Table/ZAG_NOK.sql =========*** End *** =====
PROMPT ===================================================================================== 
