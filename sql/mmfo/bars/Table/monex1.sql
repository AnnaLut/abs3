

PROMPT ===================================================================================== 
PROMPT *** Run *** ========== Scripts /Sql/BARS/Table/MONEX1.sql =========*** Run *** ======
PROMPT ===================================================================================== 


PROMPT *** ALTER_POLICY_INFO to MONEX1 ***


BEGIN 
        execute immediate  
          'begin  
               bpa.alter_policy_info(''MONEX1'', ''CENTER'' , null, null, null, null);
               bpa.alter_policy_info(''MONEX1'', ''FILIAL'' , null, null, null, null);
               bpa.alter_policy_info(''MONEX1'', ''WHOLE'' , null, null, null, null);
               null;
           end; 
          '; 
END; 
/

PROMPT *** Create  table MONEX1 ***
begin 
  execute immediate '
  CREATE TABLE BARS.MONEX1 
   (	BRANCH VARCHAR2(22), 
	NAME VARCHAR2(38), 
	ID_B VARCHAR2(14), 
	NLS_2909 VARCHAR2(14), 
	NLK_2909 VARCHAR2(14), 
	NLS_2809 VARCHAR2(14), 
	NLK_2809 VARCHAR2(14), 
	NLS_0000 VARCHAR2(14), 
	NLK_0000 VARCHAR2(14)
   ) SEGMENT CREATION DEFERRED 
  PCTFREE 10 PCTUSED 40 INITRANS 1 MAXTRANS 255 
 NOCOMPRESS LOGGING
  TABLESPACE BRSDYND ';
exception when others then       
  if sqlcode=-955 then null; else raise; end if; 
end; 
/




PROMPT *** ALTER_POLICIES to MONEX1 ***
 exec bpa.alter_policies('MONEX1');


COMMENT ON TABLE BARS.MONEX1 IS '';
COMMENT ON COLUMN BARS.MONEX1.BRANCH IS '';
COMMENT ON COLUMN BARS.MONEX1.NAME IS '';
COMMENT ON COLUMN BARS.MONEX1.ID_B IS '';
COMMENT ON COLUMN BARS.MONEX1.NLS_2909 IS '';
COMMENT ON COLUMN BARS.MONEX1.NLK_2909 IS '';
COMMENT ON COLUMN BARS.MONEX1.NLS_2809 IS '';
COMMENT ON COLUMN BARS.MONEX1.NLK_2809 IS '';
COMMENT ON COLUMN BARS.MONEX1.NLS_0000 IS '';
COMMENT ON COLUMN BARS.MONEX1.NLK_0000 IS '';




PROMPT *** Create  constraint XPK_MONEX1 ***
begin   
 execute immediate '
  ALTER TABLE BARS.MONEX1 ADD CONSTRAINT XPK_MONEX1 PRIMARY KEY (BRANCH)
  USING INDEX PCTFREE 10 INITRANS 2 MAXTRANS 255 COMPUTE STATISTICS 
  TABLESPACE BRSDYND  ENABLE';
exception when others then
  if  sqlcode=-2260 or sqlcode=-2261 or sqlcode=-2264 or sqlcode=-2275 or sqlcode=-1442 then null; else raise; end if;
 end;
/




PROMPT *** Create  index XPK_MONEX1 ***
begin   
 execute immediate '
  CREATE UNIQUE INDEX BARS.XPK_MONEX1 ON BARS.MONEX1 (BRANCH) 
  PCTFREE 10 INITRANS 2 MAXTRANS 255 COMPUTE STATISTICS 
  TABLESPACE BRSDYND ';
exception when others then
  if  sqlcode=-955  then null; else raise; end if;
 end;
/



PROMPT *** Create  grants  MONEX1 ***
grant SELECT                                                                 on MONEX1          to BARSREADER_ROLE;
grant DELETE,INSERT,SELECT,UPDATE                                            on MONEX1          to BARS_ACCESS_DEFROLE;
grant DELETE,INSERT,SELECT,UPDATE                                            on MONEX1          to START1;
grant SELECT                                                                 on MONEX1          to UPLD;



PROMPT ===================================================================================== 
PROMPT *** End *** ========== Scripts /Sql/BARS/Table/MONEX1.sql =========*** End *** ======
PROMPT ===================================================================================== 
