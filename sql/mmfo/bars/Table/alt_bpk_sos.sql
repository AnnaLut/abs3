

PROMPT ===================================================================================== 
PROMPT *** Run *** ========== Scripts /Sql/BARS/Table/ALT_BPK_SOS.sql =========*** Run *** =
PROMPT ===================================================================================== 


PROMPT *** ALTER_POLICY_INFO to ALT_BPK_SOS ***


BEGIN 
        execute immediate  
          'begin  
               bpa.alter_policy_info(''ALT_BPK_SOS'', ''CENTER'' , null, null, null, null);
               bpa.alter_policy_info(''ALT_BPK_SOS'', ''FILIAL'' , null, null, null, null);
               bpa.alter_policy_info(''ALT_BPK_SOS'', ''WHOLE'' , null, null, null, null);
               null;
           end; 
          '; 
END; 
/

PROMPT *** Create  table ALT_BPK_SOS ***
begin 
  execute immediate '
  CREATE TABLE BARS.ALT_BPK_SOS 
   (	ID NUMBER(3,0), 
	NAME VARCHAR2(50)
   ) SEGMENT CREATION IMMEDIATE 
  PCTFREE 10 PCTUSED 40 INITRANS 1 MAXTRANS 255 
 NOCOMPRESS LOGGING
  TABLESPACE BRSDYND ';
exception when others then       
  if sqlcode=-955 then null; else raise; end if; 
end; 
/




PROMPT *** ALTER_POLICIES to ALT_BPK_SOS ***
 exec bpa.alter_policies('ALT_BPK_SOS');


COMMENT ON TABLE BARS.ALT_BPK_SOS IS '';
COMMENT ON COLUMN BARS.ALT_BPK_SOS.ID IS '';
COMMENT ON COLUMN BARS.ALT_BPK_SOS.NAME IS '';




PROMPT *** Create  constraint PK_ALTBPKSOS ***
begin   
 execute immediate '
  ALTER TABLE BARS.ALT_BPK_SOS ADD CONSTRAINT PK_ALTBPKSOS PRIMARY KEY (ID)
  USING INDEX PCTFREE 10 INITRANS 2 MAXTRANS 255 COMPUTE STATISTICS 
  TABLESPACE BRSDYND  ENABLE';
exception when others then
  if  sqlcode=-2260 or sqlcode=-2261 or sqlcode=-2264 or sqlcode=-2275 or sqlcode=-1442 then null; else raise; end if;
 end;
/




PROMPT *** Create  index PK_ALTBPKSOS ***
begin   
 execute immediate '
  CREATE UNIQUE INDEX BARS.PK_ALTBPKSOS ON BARS.ALT_BPK_SOS (ID) 
  PCTFREE 10 INITRANS 2 MAXTRANS 255 COMPUTE STATISTICS 
  TABLESPACE BRSDYND ';
exception when others then
  if  sqlcode=-955  then null; else raise; end if;
 end;
/



PROMPT *** Create  grants  ALT_BPK_SOS ***
grant SELECT                                                                 on ALT_BPK_SOS     to BARS_ACCESS_DEFROLE;
grant SELECT                                                                 on ALT_BPK_SOS     to BARS_DM;



PROMPT ===================================================================================== 
PROMPT *** End *** ========== Scripts /Sql/BARS/Table/ALT_BPK_SOS.sql =========*** End *** =
PROMPT ===================================================================================== 
