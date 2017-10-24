

PROMPT ===================================================================================== 
PROMPT *** Run *** ========== Scripts /Sql/BARS/Table/CLBANKS.sql =========*** Run *** =====
PROMPT ===================================================================================== 


PROMPT *** ALTER_POLICY_INFO to CLBANKS ***


BEGIN 
        execute immediate  
          'begin  
               bpa.alter_policy_info(''CLBANKS'', ''CENTER'' , null, null, null, null);
               bpa.alter_policy_info(''CLBANKS'', ''FILIAL'' , null, null, null, null);
               bpa.alter_policy_info(''CLBANKS'', ''WHOLE'' , null, null, null, null);
               null;
           end; 
          '; 
END; 
/

PROMPT *** Create  table CLBANKS ***
begin 
  execute immediate '
  CREATE TABLE BARS.CLBANKS 
   (	CLBID NUMBER, 
	NAME VARCHAR2(70)
   ) SEGMENT CREATION IMMEDIATE 
  PCTFREE 10 PCTUSED 40 INITRANS 1 MAXTRANS 255 
 NOCOMPRESS LOGGING
  TABLESPACE BRSDYND ';
exception when others then       
  if sqlcode=-955 then null; else raise; end if; 
end; 
/




PROMPT *** ALTER_POLICIES to CLBANKS ***
 exec bpa.alter_policies('CLBANKS');


COMMENT ON TABLE BARS.CLBANKS IS '';
COMMENT ON COLUMN BARS.CLBANKS.CLBID IS '';
COMMENT ON COLUMN BARS.CLBANKS.NAME IS '';




PROMPT *** Create  constraint XPK_CLBID ***
begin   
 execute immediate '
  ALTER TABLE BARS.CLBANKS ADD CONSTRAINT XPK_CLBID PRIMARY KEY (CLBID)
  USING INDEX PCTFREE 10 INITRANS 2 MAXTRANS 255 COMPUTE STATISTICS 
  TABLESPACE BRSDYND  ENABLE';
exception when others then
  if  sqlcode=-2260 or sqlcode=-2261 or sqlcode=-2264 or sqlcode=-2275 or sqlcode=-1442 then null; else raise; end if;
 end;
/




PROMPT *** Create  constraint SYS_C005072 ***
begin   
 execute immediate '
  ALTER TABLE BARS.CLBANKS MODIFY (NAME NOT NULL ENABLE)';
exception when others then
  if  sqlcode=-2260 or sqlcode=-2261 or sqlcode=-2264 or sqlcode=-2275 or sqlcode=-1442 then null; else raise; end if;
 end;
/




PROMPT *** Create  index XPK_CLBID ***
begin   
 execute immediate '
  CREATE UNIQUE INDEX BARS.XPK_CLBID ON BARS.CLBANKS (CLBID) 
  PCTFREE 10 INITRANS 2 MAXTRANS 255 COMPUTE STATISTICS 
  TABLESPACE BRSDYND ';
exception when others then
  if  sqlcode=-955  then null; else raise; end if;
 end;
/



PROMPT *** Create  grants  CLBANKS ***
grant DELETE,FLASHBACK,INSERT,SELECT,UPDATE                                  on CLBANKS         to BARS_ACCESS_DEFROLE;
grant SELECT                                                                 on CLBANKS         to BARS_DM;
grant DELETE,INSERT,SELECT,UPDATE                                            on CLBANKS         to CLBANKS;
grant FLASHBACK,SELECT                                                       on CLBANKS         to WR_REFREAD;



PROMPT ===================================================================================== 
PROMPT *** End *** ========== Scripts /Sql/BARS/Table/CLBANKS.sql =========*** End *** =====
PROMPT ===================================================================================== 
