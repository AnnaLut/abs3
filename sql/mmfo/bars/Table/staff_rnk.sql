

PROMPT ===================================================================================== 
PROMPT *** Run *** ========== Scripts /Sql/BARS/Table/STAFF_RNK.sql =========*** Run *** ===
PROMPT ===================================================================================== 


PROMPT *** ALTER_POLICY_INFO to STAFF_RNK ***


BEGIN 
        execute immediate  
          'begin  
               bpa.alter_policy_info(''STAFF_RNK'', ''CENTER'' , null, null, null, null);
               bpa.alter_policy_info(''STAFF_RNK'', ''FILIAL'' , null, null, null, null);
               bpa.alter_policy_info(''STAFF_RNK'', ''WHOLE'' , null, null, null, null);
               null;
           end; 
          '; 
END; 
/

PROMPT *** Create  table STAFF_RNK ***
begin 
  execute immediate '
  CREATE TABLE BARS.STAFF_RNK 
   (	ID NUMBER, 
	RNK NUMBER
   ) SEGMENT CREATION DEFERRED 
  PCTFREE 10 PCTUSED 40 INITRANS 1 MAXTRANS 255 
 NOCOMPRESS LOGGING
  TABLESPACE BRSDYND ';
exception when others then       
  if sqlcode=-955 then null; else raise; end if; 
end; 
/




PROMPT *** ALTER_POLICIES to STAFF_RNK ***
 exec bpa.alter_policies('STAFF_RNK');


COMMENT ON TABLE BARS.STAFF_RNK IS '';
COMMENT ON COLUMN BARS.STAFF_RNK.ID IS '';
COMMENT ON COLUMN BARS.STAFF_RNK.RNK IS '';




PROMPT *** Create  constraint PK_STAFF_RNK ***
begin   
 execute immediate '
  ALTER TABLE BARS.STAFF_RNK ADD CONSTRAINT PK_STAFF_RNK PRIMARY KEY (ID, RNK)
  USING INDEX PCTFREE 10 INITRANS 2 MAXTRANS 255 COMPUTE STATISTICS 
  TABLESPACE BRSDYND  ENABLE';
exception when others then
  if  sqlcode=-2260 or sqlcode=-2261 or sqlcode=-2264 or sqlcode=-2275 or sqlcode=-1442 then null; else raise; end if;
 end;
/




PROMPT *** Create  index PK_STAFF_RNK ***
begin   
 execute immediate '
  CREATE UNIQUE INDEX BARS.PK_STAFF_RNK ON BARS.STAFF_RNK (ID, RNK) 
  PCTFREE 10 INITRANS 2 MAXTRANS 255 COMPUTE STATISTICS 
  TABLESPACE BRSDYND ';
exception when others then
  if  sqlcode=-955  then null; else raise; end if;
 end;
/



PROMPT *** Create  grants  STAFF_RNK ***
grant SELECT                                                                 on STAFF_RNK       to BARSREADER_ROLE;
grant DELETE,INSERT,SELECT,UPDATE                                            on STAFF_RNK       to BARS_ACCESS_DEFROLE;
grant DELETE,INSERT,SELECT,UPDATE                                            on STAFF_RNK       to START1;
grant SELECT                                                                 on STAFF_RNK       to UPLD;



PROMPT ===================================================================================== 
PROMPT *** End *** ========== Scripts /Sql/BARS/Table/STAFF_RNK.sql =========*** End *** ===
PROMPT ===================================================================================== 
