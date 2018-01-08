

PROMPT ===================================================================================== 
PROMPT *** Run *** ========== Scripts /Sql/BARS/Table/BSB.sql =========*** Run *** =========
PROMPT ===================================================================================== 


PROMPT *** ALTER_POLICY_INFO to BSB ***


BEGIN 
        execute immediate  
          'begin  
               bpa.alter_policy_info(''BSB'', ''CENTER'' , null, null, null, null);
               bpa.alter_policy_info(''BSB'', ''FILIAL'' , ''B'', ''B'', ''B'', ''B'');
               bpa.alter_policy_info(''BSB'', ''WHOLE'' , null, null, null, null);
               null;
           end; 
          '; 
END; 
/

PROMPT *** Create  table BSB ***
begin 
  execute immediate '
  CREATE TABLE BARS.BSB 
   (	BRANCH VARCHAR2(30), 
	ID NUMBER(*,0), 
	S NUMBER(38,0)
   ) SEGMENT CREATION IMMEDIATE 
  PCTFREE 10 PCTUSED 40 INITRANS 1 MAXTRANS 255 
 NOCOMPRESS LOGGING
  TABLESPACE BRSDYND ';
exception when others then       
  if sqlcode=-955 then null; else raise; end if; 
end; 
/




PROMPT *** ALTER_POLICIES to BSB ***
 exec bpa.alter_policies('BSB');


COMMENT ON TABLE BARS.BSB IS '';
COMMENT ON COLUMN BARS.BSB.BRANCH IS '';
COMMENT ON COLUMN BARS.BSB.ID IS '';
COMMENT ON COLUMN BARS.BSB.S IS '';




PROMPT *** Create  constraint PK_BSB ***
begin   
 execute immediate '
  ALTER TABLE BARS.BSB ADD CONSTRAINT PK_BSB PRIMARY KEY (BRANCH, ID)
  USING INDEX PCTFREE 10 INITRANS 2 MAXTRANS 255 COMPUTE STATISTICS 
  TABLESPACE BRSDYND  ENABLE';
exception when others then
  if  sqlcode=-2260 or sqlcode=-2261 or sqlcode=-2264 or sqlcode=-2275 or sqlcode=-1442 then null; else raise; end if;
 end;
/




PROMPT *** Create  index PK_BSB ***
begin   
 execute immediate '
  CREATE UNIQUE INDEX BARS.PK_BSB ON BARS.BSB (BRANCH, ID) 
  PCTFREE 10 INITRANS 2 MAXTRANS 255 COMPUTE STATISTICS 
  TABLESPACE BRSDYND ';
exception when others then
  if  sqlcode=-955  then null; else raise; end if;
 end;
/



PROMPT *** Create  grants  BSB ***
grant SELECT                                                                 on BSB             to BARSREADER_ROLE;
grant SELECT                                                                 on BSB             to BARS_ACCESS_DEFROLE;
grant SELECT                                                                 on BSB             to BARS_DM;
grant SELECT                                                                 on BSB             to SALGL;
grant SELECT                                                                 on BSB             to UPLD;



PROMPT ===================================================================================== 
PROMPT *** End *** ========== Scripts /Sql/BARS/Table/BSB.sql =========*** End *** =========
PROMPT ===================================================================================== 
