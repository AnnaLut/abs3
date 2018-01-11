

PROMPT ===================================================================================== 
PROMPT *** Run *** ========== Scripts /Sql/BARS/Table/FP.sql =========*** Run *** ==========
PROMPT ===================================================================================== 


PROMPT *** ALTER_POLICY_INFO to FP ***


BEGIN 
        execute immediate  
          'begin  
               bpa.alter_policy_info(''FP'', ''CENTER'' , null, null, null, null);
               bpa.alter_policy_info(''FP'', ''FILIAL'' , null, null, null, null);
               bpa.alter_policy_info(''FP'', ''WHOLE'' , null, null, null, null);
               null;
           end; 
          '; 
END; 
/

PROMPT *** Create  table FP ***
begin 
  execute immediate '
  CREATE TABLE BARS.FP 
   (	FP NUMBER(*,0), 
	NAME VARCHAR2(35), 
	COMM VARCHAR2(35)
   ) SEGMENT CREATION DEFERRED 
  PCTFREE 10 PCTUSED 40 INITRANS 1 MAXTRANS 255 
 NOCOMPRESS LOGGING
  TABLESPACE BRSDYND ';
exception when others then       
  if sqlcode=-955 then null; else raise; end if; 
end; 
/




PROMPT *** ALTER_POLICIES to FP ***
 exec bpa.alter_policies('FP');


COMMENT ON TABLE BARS.FP IS '';
COMMENT ON COLUMN BARS.FP.FP IS '';
COMMENT ON COLUMN BARS.FP.NAME IS '';
COMMENT ON COLUMN BARS.FP.COMM IS '';




PROMPT *** Create  constraint SYS_C0010031 ***
begin   
 execute immediate '
  ALTER TABLE BARS.FP MODIFY (FP NOT NULL ENABLE)';
exception when others then
  if  sqlcode=-2260 or sqlcode=-2261 or sqlcode=-2264 or sqlcode=-2275 or sqlcode=-1442 then null; else raise; end if;
 end;
/




PROMPT *** Create  constraint XPK_FP ***
begin   
 execute immediate '
  ALTER TABLE BARS.FP ADD CONSTRAINT XPK_FP PRIMARY KEY (FP)
  USING INDEX PCTFREE 10 INITRANS 2 MAXTRANS 255 COMPUTE STATISTICS 
  TABLESPACE BRSDYND  ENABLE';
exception when others then
  if  sqlcode=-2260 or sqlcode=-2261 or sqlcode=-2264 or sqlcode=-2275 or sqlcode=-1442 then null; else raise; end if;
 end;
/




PROMPT *** Create  index XPK_FP ***
begin   
 execute immediate '
  CREATE UNIQUE INDEX BARS.XPK_FP ON BARS.FP (FP) 
  PCTFREE 10 INITRANS 2 MAXTRANS 255 COMPUTE STATISTICS 
  TABLESPACE BRSDYND ';
exception when others then
  if  sqlcode=-955  then null; else raise; end if;
 end;
/



PROMPT *** Create  grants  FP ***
grant SELECT                                                                 on FP              to BARSREADER_ROLE;
grant DELETE,FLASHBACK,INSERT,SELECT,UPDATE                                  on FP              to BARS_ACCESS_DEFROLE;
grant SELECT                                                                 on FP              to BARS_DM;
grant DELETE,INSERT,SELECT,UPDATE                                            on FP              to FP;
grant SELECT                                                                 on FP              to UPLD;
grant FLASHBACK,SELECT                                                       on FP              to WR_REFREAD;



PROMPT ===================================================================================== 
PROMPT *** End *** ========== Scripts /Sql/BARS/Table/FP.sql =========*** End *** ==========
PROMPT ===================================================================================== 
