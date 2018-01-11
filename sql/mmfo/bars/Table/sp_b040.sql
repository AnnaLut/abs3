

PROMPT ===================================================================================== 
PROMPT *** Run *** ========== Scripts /Sql/BARS/Table/SP_B040.sql =========*** Run *** =====
PROMPT ===================================================================================== 


PROMPT *** ALTER_POLICY_INFO to SP_B040 ***


BEGIN 
        execute immediate  
          'begin  
               bpa.alter_policy_info(''SP_B040'', ''CENTER'' , null, null, null, null);
               bpa.alter_policy_info(''SP_B040'', ''FILIAL'' , null, null, null, null);
               bpa.alter_policy_info(''SP_B040'', ''WHOLE'' , null, null, null, null);
               null;
           end; 
          '; 
END; 
/

PROMPT *** Create  table SP_B040 ***
begin 
  execute immediate '
  CREATE TABLE BARS.SP_B040 
   (	B040 VARCHAR2(20), 
	NAME VARCHAR2(100)
   ) SEGMENT CREATION DEFERRED 
  PCTFREE 10 PCTUSED 40 INITRANS 1 MAXTRANS 255 
 NOCOMPRESS LOGGING
  TABLESPACE BRSDYND ';
exception when others then       
  if sqlcode=-955 then null; else raise; end if; 
end; 
/




PROMPT *** ALTER_POLICIES to SP_B040 ***
 exec bpa.alter_policies('SP_B040');


COMMENT ON TABLE BARS.SP_B040 IS '';
COMMENT ON COLUMN BARS.SP_B040.B040 IS '';
COMMENT ON COLUMN BARS.SP_B040.NAME IS '';




PROMPT *** Create  constraint SYS_C007364 ***
begin   
 execute immediate '
  ALTER TABLE BARS.SP_B040 MODIFY (B040 NOT NULL ENABLE NOVALIDATE)';
exception when others then
  if  sqlcode=-2260 or sqlcode=-2261 or sqlcode=-2264 or sqlcode=-2275 or sqlcode=-1442 then null; else raise; end if;
 end;
/




PROMPT *** Create  constraint PK_SP_B040 ***
begin   
 execute immediate '
  ALTER TABLE BARS.SP_B040 ADD CONSTRAINT PK_SP_B040 PRIMARY KEY (B040)
  USING INDEX PCTFREE 10 INITRANS 2 MAXTRANS 255 COMPUTE STATISTICS 
  TABLESPACE BRSDYND  ENABLE NOVALIDATE';
exception when others then
  if  sqlcode=-2260 or sqlcode=-2261 or sqlcode=-2264 or sqlcode=-2275 or sqlcode=-1442 then null; else raise; end if;
 end;
/




PROMPT *** Create  index PK_SP_B040 ***
begin   
 execute immediate '
  CREATE UNIQUE INDEX BARS.PK_SP_B040 ON BARS.SP_B040 (B040) 
  PCTFREE 10 INITRANS 2 MAXTRANS 255 COMPUTE STATISTICS 
  TABLESPACE BRSDYND ';
exception when others then
  if  sqlcode=-955  then null; else raise; end if;
 end;
/



PROMPT *** Create  grants  SP_B040 ***
grant SELECT                                                                 on SP_B040         to BARSREADER_ROLE;
grant FLASHBACK,SELECT                                                       on SP_B040         to BARS_ACCESS_DEFROLE;
grant SELECT                                                                 on SP_B040         to UPLD;
grant FLASHBACK,SELECT                                                       on SP_B040         to WR_REFREAD;



PROMPT ===================================================================================== 
PROMPT *** End *** ========== Scripts /Sql/BARS/Table/SP_B040.sql =========*** End *** =====
PROMPT ===================================================================================== 
