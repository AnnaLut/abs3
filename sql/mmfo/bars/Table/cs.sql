

PROMPT ===================================================================================== 
PROMPT *** Run *** ========== Scripts /Sql/BARS/Table/CS.sql =========*** Run *** ==========
PROMPT ===================================================================================== 


PROMPT *** ALTER_POLICY_INFO to CS ***


BEGIN 
        execute immediate  
          'begin  
               bpa.alter_policy_info(''CS'', ''CENTER'' , null, null, null, null);
               bpa.alter_policy_info(''CS'', ''FILIAL'' , null, null, null, null);
               bpa.alter_policy_info(''CS'', ''WHOLE'' , null, null, null, null);
               null;
           end; 
          '; 
END; 
/

PROMPT *** Create  table CS ***
begin 
  execute immediate '
  CREATE TABLE BARS.CS 
   (	CLASS NUMBER(*,0), 
	NAME VARCHAR2(35)
   ) SEGMENT CREATION IMMEDIATE 
  PCTFREE 10 PCTUSED 40 INITRANS 1 MAXTRANS 255 
 NOCOMPRESS LOGGING
  TABLESPACE BRSDYND ';
exception when others then       
  if sqlcode=-955 then null; else raise; end if; 
end; 
/




PROMPT *** ALTER_POLICIES to CS ***
 exec bpa.alter_policies('CS');


COMMENT ON TABLE BARS.CS IS '';
COMMENT ON COLUMN BARS.CS.CLASS IS '';
COMMENT ON COLUMN BARS.CS.NAME IS '';




PROMPT *** Create  constraint XPK_CS ***
begin   
 execute immediate '
  ALTER TABLE BARS.CS ADD CONSTRAINT XPK_CS PRIMARY KEY (CLASS)
  USING INDEX PCTFREE 10 INITRANS 2 MAXTRANS 255 COMPUTE STATISTICS 
  TABLESPACE BRSDYND  ENABLE';
exception when others then
  if  sqlcode=-2260 or sqlcode=-2261 or sqlcode=-2264 or sqlcode=-2275 or sqlcode=-1442 then null; else raise; end if;
 end;
/




PROMPT *** Create  constraint SYS_C007134 ***
begin   
 execute immediate '
  ALTER TABLE BARS.CS MODIFY (CLASS NOT NULL ENABLE)';
exception when others then
  if  sqlcode=-2260 or sqlcode=-2261 or sqlcode=-2264 or sqlcode=-2275 or sqlcode=-1442 then null; else raise; end if;
 end;
/




PROMPT *** Create  index XPK_CS ***
begin   
 execute immediate '
  CREATE UNIQUE INDEX BARS.XPK_CS ON BARS.CS (CLASS) 
  PCTFREE 10 INITRANS 2 MAXTRANS 255 COMPUTE STATISTICS 
  TABLESPACE BRSDYND ';
exception when others then
  if  sqlcode=-955  then null; else raise; end if;
 end;
/



PROMPT *** Create  grants  CS ***
grant SELECT                                                                 on CS              to BARSREADER_ROLE;
grant DELETE,FLASHBACK,INSERT,SELECT,UPDATE                                  on CS              to BARS_ACCESS_DEFROLE;
grant SELECT                                                                 on CS              to BARS_DM;
grant DELETE,INSERT,SELECT,UPDATE                                            on CS              to CS;
grant SELECT                                                                 on CS              to UPLD;
grant FLASHBACK,SELECT                                                       on CS              to WR_REFREAD;



PROMPT ===================================================================================== 
PROMPT *** End *** ========== Scripts /Sql/BARS/Table/CS.sql =========*** End *** ==========
PROMPT ===================================================================================== 
