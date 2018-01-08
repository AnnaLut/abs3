

PROMPT ===================================================================================== 
PROMPT *** Run *** ========== Scripts /Sql/BARS/Table/BU2.sql =========*** Run *** =========
PROMPT ===================================================================================== 


PROMPT *** ALTER_POLICY_INFO to BU2 ***


BEGIN 
        execute immediate  
          'begin  
               bpa.alter_policy_info(''BU2'', ''CENTER'' , null, null, null, null);
               bpa.alter_policy_info(''BU2'', ''FILIAL'' , null, ''E'', ''E'', ''E'');
               bpa.alter_policy_info(''BU2'', ''WHOLE'' , null, null, null, null);
               null;
           end; 
          '; 
END; 
/

PROMPT *** Create  table BU2 ***
begin 
  execute immediate '
  CREATE TABLE BARS.BU2 
   (	ID NUMBER, 
	NBS VARCHAR2(6), 
	PAP NUMBER
   ) SEGMENT CREATION IMMEDIATE 
  PCTFREE 10 PCTUSED 40 INITRANS 1 MAXTRANS 255 
 NOCOMPRESS LOGGING
  TABLESPACE BRSDYND ';
exception when others then       
  if sqlcode=-955 then null; else raise; end if; 
end; 
/




PROMPT *** ALTER_POLICIES to BU2 ***
 exec bpa.alter_policies('BU2');


COMMENT ON TABLE BARS.BU2 IS '';
COMMENT ON COLUMN BARS.BU2.ID IS 'ID';
COMMENT ON COLUMN BARS.BU2.NBS IS 'Номер балансового счёта';
COMMENT ON COLUMN BARS.BU2.PAP IS 'Признак актива/пассива';




PROMPT *** Create  constraint PK_BU2 ***
begin   
 execute immediate '
  ALTER TABLE BARS.BU2 ADD CONSTRAINT PK_BU2 PRIMARY KEY (ID, NBS, PAP)
  USING INDEX PCTFREE 10 INITRANS 2 MAXTRANS 255 COMPUTE STATISTICS 
  TABLESPACE BRSDYND  ENABLE';
exception when others then
  if  sqlcode=-2260 or sqlcode=-2261 or sqlcode=-2264 or sqlcode=-2275 or sqlcode=-1442 then null; else raise; end if;
 end;
/




PROMPT *** Create  constraint CC_BU2_ID_NN ***
begin   
 execute immediate '
  ALTER TABLE BARS.BU2 ADD CONSTRAINT CC_BU2_ID_NN CHECK (ID IS NOT NULL) ENABLE';
exception when others then
  if  sqlcode=-2260 or sqlcode=-2261 or sqlcode=-2264 or sqlcode=-2275 or sqlcode=-1442 then null; else raise; end if;
 end;
/




PROMPT *** Create  index PK_BU2 ***
begin   
 execute immediate '
  CREATE UNIQUE INDEX BARS.PK_BU2 ON BARS.BU2 (ID, NBS, PAP) 
  PCTFREE 10 INITRANS 2 MAXTRANS 255 COMPUTE STATISTICS 
  TABLESPACE BRSDYND ';
exception when others then
  if  sqlcode=-955  then null; else raise; end if;
 end;
/



PROMPT *** Create  grants  BU2 ***
grant ALTER,DEBUG,DELETE,FLASHBACK,INSERT,ON COMMIT REFRESH,QUERY REWRITE,SELECT,UPDATE on BU2             to ABS_ADMIN;
grant SELECT                                                                 on BU2             to BARSREADER_ROLE;
grant ALTER,DEBUG,DELETE,FLASHBACK,INSERT,ON COMMIT REFRESH,QUERY REWRITE,SELECT,UPDATE on BU2             to BARS_ACCESS_DEFROLE;
grant SELECT                                                                 on BU2             to BARS_DM;
grant DELETE,INSERT,SELECT,UPDATE                                            on BU2             to BU;
grant SELECT                                                                 on BU2             to SALGL;
grant SELECT                                                                 on BU2             to UPLD;
grant DELETE,FLASHBACK,INSERT,SELECT,UPDATE                                  on BU2             to WR_ALL_RIGHTS;
grant FLASHBACK,SELECT                                                       on BU2             to WR_REFREAD;



PROMPT ===================================================================================== 
PROMPT *** End *** ========== Scripts /Sql/BARS/Table/BU2.sql =========*** End *** =========
PROMPT ===================================================================================== 
