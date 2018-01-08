

PROMPT ===================================================================================== 
PROMPT *** Run *** ========== Scripts /Sql/BARS/Table/CC_KOL_TBLANK.sql =========*** Run ***
PROMPT ===================================================================================== 


PROMPT *** ALTER_POLICY_INFO to CC_KOL_TBLANK ***


BEGIN 
        execute immediate  
          'begin  
               bpa.alter_policy_info(''CC_KOL_TBLANK'', ''CENTER'' , null, null, null, null);
               bpa.alter_policy_info(''CC_KOL_TBLANK'', ''FILIAL'' , null, ''E'', ''E'', ''E'');
               bpa.alter_policy_info(''CC_KOL_TBLANK'', ''WHOLE'' , null, null, null, null);
               null;
           end; 
          '; 
END; 
/

PROMPT *** Create  table CC_KOL_TBLANK ***
begin 
  execute immediate '
  CREATE TABLE BARS.CC_KOL_TBLANK 
   (	TBLANK VARCHAR2(10), 
	TXT VARCHAR2(50)
   ) SEGMENT CREATION IMMEDIATE 
  PCTFREE 10 PCTUSED 40 INITRANS 1 MAXTRANS 255 
 NOCOMPRESS LOGGING
  TABLESPACE BRSDYND ';
exception when others then       
  if sqlcode=-955 then null; else raise; end if; 
end; 
/




PROMPT *** ALTER_POLICIES to CC_KOL_TBLANK ***
 exec bpa.alter_policies('CC_KOL_TBLANK');


COMMENT ON TABLE BARS.CC_KOL_TBLANK IS '';
COMMENT ON COLUMN BARS.CC_KOL_TBLANK.TBLANK IS '';
COMMENT ON COLUMN BARS.CC_KOL_TBLANK.TXT IS '';




PROMPT *** Create  constraint PK_CC_KOL_TBLANK ***
begin   
 execute immediate '
  ALTER TABLE BARS.CC_KOL_TBLANK ADD CONSTRAINT PK_CC_KOL_TBLANK PRIMARY KEY (TBLANK)
  USING INDEX PCTFREE 10 INITRANS 2 MAXTRANS 255 COMPUTE STATISTICS 
  TABLESPACE BRSDYND  ENABLE';
exception when others then
  if  sqlcode=-2260 or sqlcode=-2261 or sqlcode=-2264 or sqlcode=-2275 or sqlcode=-1442 then null; else raise; end if;
 end;
/




PROMPT *** Create  constraint SYS_C006138 ***
begin   
 execute immediate '
  ALTER TABLE BARS.CC_KOL_TBLANK MODIFY (TBLANK NOT NULL ENABLE)';
exception when others then
  if  sqlcode=-2260 or sqlcode=-2261 or sqlcode=-2264 or sqlcode=-2275 or sqlcode=-1442 then null; else raise; end if;
 end;
/




PROMPT *** Create  constraint SYS_C006139 ***
begin   
 execute immediate '
  ALTER TABLE BARS.CC_KOL_TBLANK MODIFY (TXT NOT NULL ENABLE)';
exception when others then
  if  sqlcode=-2260 or sqlcode=-2261 or sqlcode=-2264 or sqlcode=-2275 or sqlcode=-1442 then null; else raise; end if;
 end;
/




PROMPT *** Create  index PK_CC_KOL_TBLANK ***
begin   
 execute immediate '
  CREATE UNIQUE INDEX BARS.PK_CC_KOL_TBLANK ON BARS.CC_KOL_TBLANK (TBLANK) 
  PCTFREE 10 INITRANS 2 MAXTRANS 255 COMPUTE STATISTICS 
  TABLESPACE BRSDYND ';
exception when others then
  if  sqlcode=-955  then null; else raise; end if;
 end;
/



PROMPT *** Create  grants  CC_KOL_TBLANK ***
grant SELECT                                                                 on CC_KOL_TBLANK   to BARSREADER_ROLE;
grant ALTER,DELETE,INSERT,SELECT,UPDATE                                      on CC_KOL_TBLANK   to BARS_ACCESS_DEFROLE;
grant SELECT                                                                 on CC_KOL_TBLANK   to BARS_DM;
grant ALTER,DELETE,INSERT,SELECT,UPDATE                                      on CC_KOL_TBLANK   to RCC_DEAL;
grant SELECT                                                                 on CC_KOL_TBLANK   to UPLD;



PROMPT ===================================================================================== 
PROMPT *** End *** ========== Scripts /Sql/BARS/Table/CC_KOL_TBLANK.sql =========*** End ***
PROMPT ===================================================================================== 
