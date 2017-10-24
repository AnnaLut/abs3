

PROMPT ===================================================================================== 
PROMPT *** Run *** ========== Scripts /Sql/BARS/Table/GSP.sql =========*** Run *** =========
PROMPT ===================================================================================== 


PROMPT *** ALTER_POLICY_INFO to GSP ***


BEGIN 
        execute immediate  
          'begin  
               bpa.alter_policy_info(''GSP'', ''CENTER'' , null, null, null, null);
               bpa.alter_policy_info(''GSP'', ''FILIAL'' , null, null, null, null);
               bpa.alter_policy_info(''GSP'', ''WHOLE'' , null, null, null, null);
               null;
           end; 
          '; 
END; 
/

PROMPT *** Create  table GSP ***
begin 
  execute immediate '
  CREATE TABLE BARS.GSP 
   (	ID NUMBER(*,0), 
	NAME VARCHAR2(30)
   ) SEGMENT CREATION DEFERRED 
  PCTFREE 10 PCTUSED 40 INITRANS 1 MAXTRANS 255 
 NOCOMPRESS LOGGING
  TABLESPACE BRSDYND ';
exception when others then       
  if sqlcode=-955 then null; else raise; end if; 
end; 
/




PROMPT *** ALTER_POLICIES to GSP ***
 exec bpa.alter_policies('GSP');


COMMENT ON TABLE BARS.GSP IS '';
COMMENT ON COLUMN BARS.GSP.ID IS '';
COMMENT ON COLUMN BARS.GSP.NAME IS '';




PROMPT *** Create  constraint SYS_C008617 ***
begin   
 execute immediate '
  ALTER TABLE BARS.GSP MODIFY (ID NOT NULL ENABLE)';
exception when others then
  if  sqlcode=-2260 or sqlcode=-2261 or sqlcode=-2264 or sqlcode=-2275 or sqlcode=-1442 then null; else raise; end if;
 end;
/




PROMPT *** Create  constraint XPK_GSP ***
begin   
 execute immediate '
  ALTER TABLE BARS.GSP ADD CONSTRAINT XPK_GSP PRIMARY KEY (ID)
  USING INDEX PCTFREE 10 INITRANS 2 MAXTRANS 255 COMPUTE STATISTICS 
  TABLESPACE BRSDYND  ENABLE';
exception when others then
  if  sqlcode=-2260 or sqlcode=-2261 or sqlcode=-2264 or sqlcode=-2275 or sqlcode=-1442 then null; else raise; end if;
 end;
/




PROMPT *** Create  index XPK_GSP ***
begin   
 execute immediate '
  CREATE UNIQUE INDEX BARS.XPK_GSP ON BARS.GSP (ID) 
  PCTFREE 10 INITRANS 2 MAXTRANS 255 COMPUTE STATISTICS 
  TABLESPACE BRSDYND ';
exception when others then
  if  sqlcode=-955  then null; else raise; end if;
 end;
/



PROMPT *** Create  grants  GSP ***
grant DELETE,INSERT,SELECT,UPDATE                                            on GSP             to BARS_ACCESS_DEFROLE;
grant SELECT                                                                 on GSP             to BARS_DM;
grant DELETE,INSERT,SELECT,UPDATE                                            on GSP             to START1;



PROMPT ===================================================================================== 
PROMPT *** End *** ========== Scripts /Sql/BARS/Table/GSP.sql =========*** End *** =========
PROMPT ===================================================================================== 
