

PROMPT ===================================================================================== 
PROMPT *** Run *** ========== Scripts /Sql/BARS/Table/CP_KUPON_HIST.sql =========*** Run ***
PROMPT ===================================================================================== 


PROMPT *** ALTER_POLICY_INFO to CP_KUPON_HIST ***


BEGIN 
        execute immediate  
          'begin  
               bpa.alter_policy_info(''CP_KUPON_HIST'', ''CENTER'' , null, null, null, null);
               bpa.alter_policy_info(''CP_KUPON_HIST'', ''FILIAL'' , null, null, null, null);
               bpa.alter_policy_info(''CP_KUPON_HIST'', ''WHOLE'' , null, null, null, null);
               null;
           end; 
          '; 
END; 
/

PROMPT *** Create  table CP_KUPON_HIST ***
begin 
  execute immediate '
  CREATE TABLE BARS.CP_KUPON_HIST 
   (	ID NUMBER, 
	DAT DATE, 
	PROC NUMBER, 
	S NUMBER, 
	NOMDEKR_ NUMBER DEFAULT 0
   ) SEGMENT CREATION IMMEDIATE 
  PCTFREE 10 PCTUSED 40 INITRANS 1 MAXTRANS 255 
 NOCOMPRESS LOGGING
  TABLESPACE BRSDYND ';
exception when others then       
  if sqlcode=-955 then null; else raise; end if; 
end; 
/




PROMPT *** ALTER_POLICIES to CP_KUPON_HIST ***
 exec bpa.alter_policies('CP_KUPON_HIST');


COMMENT ON TABLE BARS.CP_KUPON_HIST IS '';
COMMENT ON COLUMN BARS.CP_KUPON_HIST.ID IS '';
COMMENT ON COLUMN BARS.CP_KUPON_HIST.DAT IS '';
COMMENT ON COLUMN BARS.CP_KUPON_HIST.PROC IS '';
COMMENT ON COLUMN BARS.CP_KUPON_HIST.S IS '';
COMMENT ON COLUMN BARS.CP_KUPON_HIST.NOMDEKR_ IS '';




PROMPT *** Create  constraint SYS_C008726 ***
begin   
 execute immediate '
  ALTER TABLE BARS.CP_KUPON_HIST MODIFY (ID NOT NULL ENABLE)';
exception when others then
  if  sqlcode=-2260 or sqlcode=-2261 or sqlcode=-2264 or sqlcode=-2275 or sqlcode=-1442 then null; else raise; end if;
 end;
/




PROMPT *** Create  constraint SYS_C008727 ***
begin   
 execute immediate '
  ALTER TABLE BARS.CP_KUPON_HIST MODIFY (DAT NOT NULL ENABLE)';
exception when others then
  if  sqlcode=-2260 or sqlcode=-2261 or sqlcode=-2264 or sqlcode=-2275 or sqlcode=-1442 then null; else raise; end if;
 end;
/




PROMPT *** Create  constraint PK_CP_KUPON_HIST ***
begin   
 execute immediate '
  ALTER TABLE BARS.CP_KUPON_HIST ADD CONSTRAINT PK_CP_KUPON_HIST PRIMARY KEY (ID, DAT)
  USING INDEX PCTFREE 10 INITRANS 2 MAXTRANS 255 COMPUTE STATISTICS 
  TABLESPACE BRSDYND  ENABLE';
exception when others then
  if  sqlcode=-2260 or sqlcode=-2261 or sqlcode=-2264 or sqlcode=-2275 or sqlcode=-1442 then null; else raise; end if;
 end;
/




PROMPT *** Create  index PK_CP_KUPON_HIST ***
begin   
 execute immediate '
  CREATE UNIQUE INDEX BARS.PK_CP_KUPON_HIST ON BARS.CP_KUPON_HIST (ID, DAT) 
  PCTFREE 10 INITRANS 2 MAXTRANS 255 COMPUTE STATISTICS 
  TABLESPACE BRSDYND ';
exception when others then
  if  sqlcode=-955  then null; else raise; end if;
 end;
/



PROMPT *** Create  grants  CP_KUPON_HIST ***
grant SELECT                                                                 on CP_KUPON_HIST   to BARSREADER_ROLE;
grant DELETE,INSERT,SELECT,UPDATE                                            on CP_KUPON_HIST   to BARS_ACCESS_DEFROLE;
grant SELECT                                                                 on CP_KUPON_HIST   to BARS_DM;
grant DELETE,INSERT,SELECT,UPDATE                                            on CP_KUPON_HIST   to START1;
grant SELECT                                                                 on CP_KUPON_HIST   to UPLD;



PROMPT ===================================================================================== 
PROMPT *** End *** ========== Scripts /Sql/BARS/Table/CP_KUPON_HIST.sql =========*** End ***
PROMPT ===================================================================================== 
