

PROMPT ===================================================================================== 
PROMPT *** Run *** ========== Scripts /Sql/BARS/Table/CC_OTM.sql =========*** Run *** ======
PROMPT ===================================================================================== 


PROMPT *** ALTER_POLICY_INFO to CC_OTM ***


BEGIN 
        execute immediate  
          'begin  
               bpa.alter_policy_info(''CC_OTM'', ''CENTER'' , null, null, null, null);
               bpa.alter_policy_info(''CC_OTM'', ''FILIAL'' , null, ''E'', ''E'', ''E'');
               bpa.alter_policy_info(''CC_OTM'', ''WHOLE'' , null, null, null, null);
               null;
           end; 
          '; 
END; 
/

PROMPT *** Create  table CC_OTM ***
begin 
  execute immediate '
  CREATE TABLE BARS.CC_OTM 
   (	OTM NUMBER(*,0), 
	NAME VARCHAR2(35)
   ) SEGMENT CREATION IMMEDIATE 
  PCTFREE 10 PCTUSED 40 INITRANS 1 MAXTRANS 255 
 NOCOMPRESS LOGGING
  TABLESPACE BRSSMLD ';
exception when others then       
  if sqlcode=-955 then null; else raise; end if; 
end; 
/




PROMPT *** ALTER_POLICIES to CC_OTM ***
 exec bpa.alter_policies('CC_OTM');


COMMENT ON TABLE BARS.CC_OTM IS '';
COMMENT ON COLUMN BARS.CC_OTM.OTM IS '';
COMMENT ON COLUMN BARS.CC_OTM.NAME IS '';




PROMPT *** Create  constraint XPK_CC_OTM ***
begin   
 execute immediate '
  ALTER TABLE BARS.CC_OTM ADD CONSTRAINT XPK_CC_OTM PRIMARY KEY (OTM)
  USING INDEX PCTFREE 10 INITRANS 2 MAXTRANS 255 COMPUTE STATISTICS 
  TABLESPACE BRSSMLI  ENABLE';
exception when others then
  if  sqlcode=-2260 or sqlcode=-2261 or sqlcode=-2264 or sqlcode=-2275 or sqlcode=-1442 then null; else raise; end if;
 end;
/




PROMPT *** Create  constraint NK_CC_OTM_OTM ***
begin   
 execute immediate '
  ALTER TABLE BARS.CC_OTM MODIFY (OTM CONSTRAINT NK_CC_OTM_OTM NOT NULL ENABLE)';
exception when others then
  if  sqlcode=-2260 or sqlcode=-2261 or sqlcode=-2264 or sqlcode=-2275 or sqlcode=-1442 then null; else raise; end if;
 end;
/




PROMPT *** Create  index XPK_CC_OTM ***
begin   
 execute immediate '
  CREATE UNIQUE INDEX BARS.XPK_CC_OTM ON BARS.CC_OTM (OTM) 
  PCTFREE 10 INITRANS 2 MAXTRANS 255 COMPUTE STATISTICS 
  TABLESPACE BRSSMLI ';
exception when others then
  if  sqlcode=-955  then null; else raise; end if;
 end;
/



PROMPT *** Create  grants  CC_OTM ***
grant ALTER,DEBUG,DELETE,INSERT,ON COMMIT REFRESH,QUERY REWRITE,SELECT,UPDATE on CC_OTM          to BARS_ACCESS_DEFROLE;
grant SELECT                                                                 on CC_OTM          to BARS_DM;
grant ALTER,DEBUG,DELETE,INSERT,ON COMMIT REFRESH,QUERY REWRITE,SELECT,UPDATE on CC_OTM          to RCC_DEAL;
grant DELETE,FLASHBACK,INSERT,SELECT,UPDATE                                  on CC_OTM          to WR_ALL_RIGHTS;



PROMPT ===================================================================================== 
PROMPT *** End *** ========== Scripts /Sql/BARS/Table/CC_OTM.sql =========*** End *** ======
PROMPT ===================================================================================== 
