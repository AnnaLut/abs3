

PROMPT ===================================================================================== 
PROMPT *** Run *** ========== Scripts /Sql/BARS/Table/CP_INFO.sql =========*** Run *** =====
PROMPT ===================================================================================== 


PROMPT *** ALTER_POLICY_INFO to CP_INFO ***


BEGIN 
        execute immediate  
          'begin  
               bpa.alter_policy_info(''CP_INFO'', ''CENTER'' , null, null, null, null);
               bpa.alter_policy_info(''CP_INFO'', ''FILIAL'' , null, null, null, null);
               bpa.alter_policy_info(''CP_INFO'', ''WHOLE'' , null, null, null, null);
               null;
           end; 
          '; 
END; 
/

PROMPT *** Create  table CP_INFO ***
begin 
  execute immediate '
  CREATE TABLE BARS.CP_INFO 
   (	ID NUMBER, 
	FDAT DATE, 
	BYR NUMBER, 
	NOMIN NUMBER, 
	STOIM NUMBER
   ) SEGMENT CREATION IMMEDIATE 
  PCTFREE 10 PCTUSED 40 INITRANS 1 MAXTRANS 255 
 NOCOMPRESS LOGGING
  TABLESPACE BRSDYND ';
exception when others then       
  if sqlcode=-955 then null; else raise; end if; 
end; 
/




PROMPT *** ALTER_POLICIES to CP_INFO ***
 exec bpa.alter_policies('CP_INFO');


COMMENT ON TABLE BARS.CP_INFO IS '';
COMMENT ON COLUMN BARS.CP_INFO.ID IS '';
COMMENT ON COLUMN BARS.CP_INFO.FDAT IS '';
COMMENT ON COLUMN BARS.CP_INFO.BYR IS '';
COMMENT ON COLUMN BARS.CP_INFO.NOMIN IS '';
COMMENT ON COLUMN BARS.CP_INFO.STOIM IS '';




PROMPT *** Create  constraint XPK_CP_INFO ***
begin   
 execute immediate '
  ALTER TABLE BARS.CP_INFO ADD CONSTRAINT XPK_CP_INFO PRIMARY KEY (ID, FDAT)
  USING INDEX PCTFREE 10 INITRANS 2 MAXTRANS 255 COMPUTE STATISTICS 
  TABLESPACE BRSDYND  ENABLE';
exception when others then
  if  sqlcode=-2260 or sqlcode=-2261 or sqlcode=-2264 or sqlcode=-2275 or sqlcode=-1442 then null; else raise; end if;
 end;
/




PROMPT *** Create  constraint SYS_C005370 ***
begin   
 execute immediate '
  ALTER TABLE BARS.CP_INFO MODIFY (ID NOT NULL ENABLE)';
exception when others then
  if  sqlcode=-2260 or sqlcode=-2261 or sqlcode=-2264 or sqlcode=-2275 or sqlcode=-1442 then null; else raise; end if;
 end;
/




PROMPT *** Create  constraint SYS_C005371 ***
begin   
 execute immediate '
  ALTER TABLE BARS.CP_INFO MODIFY (FDAT NOT NULL ENABLE)';
exception when others then
  if  sqlcode=-2260 or sqlcode=-2261 or sqlcode=-2264 or sqlcode=-2275 or sqlcode=-1442 then null; else raise; end if;
 end;
/




PROMPT *** Create  index XPK_CP_INFO ***
begin   
 execute immediate '
  CREATE UNIQUE INDEX BARS.XPK_CP_INFO ON BARS.CP_INFO (ID, FDAT) 
  PCTFREE 10 INITRANS 2 MAXTRANS 255 COMPUTE STATISTICS 
  TABLESPACE BRSDYND ';
exception when others then
  if  sqlcode=-955  then null; else raise; end if;
 end;
/



PROMPT *** Create  grants  CP_INFO ***
grant SELECT                                                                 on CP_INFO         to BARSREADER_ROLE;
grant DELETE,FLASHBACK,INSERT,SELECT,UPDATE                                  on CP_INFO         to BARS_ACCESS_DEFROLE;
grant SELECT                                                                 on CP_INFO         to BARS_DM;
grant DELETE,INSERT,SELECT,UPDATE                                            on CP_INFO         to CP_ROLE;
grant SELECT                                                                 on CP_INFO         to UPLD;
grant FLASHBACK,SELECT                                                       on CP_INFO         to WR_REFREAD;



PROMPT ===================================================================================== 
PROMPT *** End *** ========== Scripts /Sql/BARS/Table/CP_INFO.sql =========*** End *** =====
PROMPT ===================================================================================== 
