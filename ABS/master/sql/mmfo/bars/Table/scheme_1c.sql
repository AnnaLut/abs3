

PROMPT ===================================================================================== 
PROMPT *** Run *** ========== Scripts /Sql/BARS/Table/SCHEME_1C.sql =========*** Run *** ===
PROMPT ===================================================================================== 


PROMPT *** ALTER_POLICY_INFO to SCHEME_1C ***


BEGIN 
        execute immediate  
          'begin  
               bpa.alter_policy_info(''SCHEME_1C'', ''CENTER'' , null, null, null, null);
               bpa.alter_policy_info(''SCHEME_1C'', ''FILIAL'' , null, null, null, null);
               bpa.alter_policy_info(''SCHEME_1C'', ''WHOLE'' , null, null, null, null);
               null;
           end; 
          '; 
END; 
/

PROMPT *** Create  table SCHEME_1C ***
begin 
  execute immediate '
  CREATE TABLE BARS.SCHEME_1C 
   (	RECID NUMBER, 
	NBSDB VARCHAR2(14), 
	NBSKD VARCHAR2(14), 
	OB40 VARCHAR2(4)
   ) SEGMENT CREATION IMMEDIATE 
  PCTFREE 10 PCTUSED 40 INITRANS 1 MAXTRANS 255 
 NOCOMPRESS LOGGING
  TABLESPACE BRSDYND ';
exception when others then       
  if sqlcode=-955 then null; else raise; end if; 
end; 
/




PROMPT *** ALTER_POLICIES to SCHEME_1C ***
 exec bpa.alter_policies('SCHEME_1C');


COMMENT ON TABLE BARS.SCHEME_1C IS '';
COMMENT ON COLUMN BARS.SCHEME_1C.RECID IS '';
COMMENT ON COLUMN BARS.SCHEME_1C.NBSDB IS '';
COMMENT ON COLUMN BARS.SCHEME_1C.NBSKD IS '';
COMMENT ON COLUMN BARS.SCHEME_1C.OB40 IS '';




PROMPT *** Create  constraint XPK_SCHEME_1C ***
begin   
 execute immediate '
  ALTER TABLE BARS.SCHEME_1C ADD CONSTRAINT XPK_SCHEME_1C PRIMARY KEY (RECID)
  USING INDEX PCTFREE 10 INITRANS 2 MAXTRANS 255 COMPUTE STATISTICS 
  TABLESPACE BRSDYND  ENABLE';
exception when others then
  if  sqlcode=-2260 or sqlcode=-2261 or sqlcode=-2264 or sqlcode=-2275 or sqlcode=-1442 then null; else raise; end if;
 end;
/




PROMPT *** Create  constraint SYS_C008618 ***
begin   
 execute immediate '
  ALTER TABLE BARS.SCHEME_1C MODIFY (RECID NOT NULL ENABLE)';
exception when others then
  if  sqlcode=-2260 or sqlcode=-2261 or sqlcode=-2264 or sqlcode=-2275 or sqlcode=-1442 then null; else raise; end if;
 end;
/




PROMPT *** Create  constraint SYS_C008619 ***
begin   
 execute immediate '
  ALTER TABLE BARS.SCHEME_1C MODIFY (NBSDB NOT NULL ENABLE)';
exception when others then
  if  sqlcode=-2260 or sqlcode=-2261 or sqlcode=-2264 or sqlcode=-2275 or sqlcode=-1442 then null; else raise; end if;
 end;
/




PROMPT *** Create  constraint SYS_C008620 ***
begin   
 execute immediate '
  ALTER TABLE BARS.SCHEME_1C MODIFY (NBSKD NOT NULL ENABLE)';
exception when others then
  if  sqlcode=-2260 or sqlcode=-2261 or sqlcode=-2264 or sqlcode=-2275 or sqlcode=-1442 then null; else raise; end if;
 end;
/




PROMPT *** Create  constraint SYS_C008621 ***
begin   
 execute immediate '
  ALTER TABLE BARS.SCHEME_1C MODIFY (OB40 NOT NULL ENABLE)';
exception when others then
  if  sqlcode=-2260 or sqlcode=-2261 or sqlcode=-2264 or sqlcode=-2275 or sqlcode=-1442 then null; else raise; end if;
 end;
/




PROMPT *** Create  index XPK_SCHEME_1C ***
begin   
 execute immediate '
  CREATE UNIQUE INDEX BARS.XPK_SCHEME_1C ON BARS.SCHEME_1C (RECID) 
  PCTFREE 10 INITRANS 2 MAXTRANS 255 COMPUTE STATISTICS 
  TABLESPACE BRSDYND ';
exception when others then
  if  sqlcode=-955  then null; else raise; end if;
 end;
/



PROMPT *** Create  grants  SCHEME_1C ***
grant DELETE,FLASHBACK,INSERT,SELECT,UPDATE                                  on SCHEME_1C       to BARS_ACCESS_DEFROLE;
grant SELECT                                                                 on SCHEME_1C       to BARS_DM;
grant SELECT                                                                 on SCHEME_1C       to SBB_LZ;
grant DELETE,INSERT,SELECT,UPDATE                                            on SCHEME_1C       to SCHEME_1C;
grant FLASHBACK,SELECT                                                       on SCHEME_1C       to WR_REFREAD;



PROMPT ===================================================================================== 
PROMPT *** End *** ========== Scripts /Sql/BARS/Table/SCHEME_1C.sql =========*** End *** ===
PROMPT ===================================================================================== 
