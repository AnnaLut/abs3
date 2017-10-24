

PROMPT ===================================================================================== 
PROMPT *** Run *** ========== Scripts /Sql/BARS/Table/SV_OWNER_GROUP.sql =========*** Run **
PROMPT ===================================================================================== 


PROMPT *** ALTER_POLICY_INFO to SV_OWNER_GROUP ***


BEGIN 
        execute immediate  
          'begin  
               bpa.alter_policy_info(''SV_OWNER_GROUP'', ''CENTER'' , null, null, null, null);
               bpa.alter_policy_info(''SV_OWNER_GROUP'', ''FILIAL'' , null, null, null, null);
               bpa.alter_policy_info(''SV_OWNER_GROUP'', ''WHOLE'' , null, null, null, null);
               null;
           end; 
          '; 
END; 
/

PROMPT *** Create  table SV_OWNER_GROUP ***
begin 
  execute immediate '
  CREATE TABLE BARS.SV_OWNER_GROUP 
   (	ID NUMBER(10,0), 
	NAME VARCHAR2(250)
   ) SEGMENT CREATION DEFERRED 
  PCTFREE 10 PCTUSED 40 INITRANS 1 MAXTRANS 255 
 NOCOMPRESS LOGGING
  TABLESPACE BRSDYND ';
exception when others then       
  if sqlcode=-955 then null; else raise; end if; 
end; 
/




PROMPT *** ALTER_POLICIES to SV_OWNER_GROUP ***
 exec bpa.alter_policies('SV_OWNER_GROUP');


COMMENT ON TABLE BARS.SV_OWNER_GROUP IS 'Група осіб, яка є власником істотної участі в банку';
COMMENT ON COLUMN BARS.SV_OWNER_GROUP.ID IS 'Ід.';
COMMENT ON COLUMN BARS.SV_OWNER_GROUP.NAME IS 'Назва групи';




PROMPT *** Create  constraint PK_SVOWNERGROUP ***
begin   
 execute immediate '
  ALTER TABLE BARS.SV_OWNER_GROUP ADD CONSTRAINT PK_SVOWNERGROUP PRIMARY KEY (ID)
  USING INDEX PCTFREE 10 INITRANS 2 MAXTRANS 255 COMPUTE STATISTICS 
  TABLESPACE BRSDYND  ENABLE';
exception when others then
  if  sqlcode=-2260 or sqlcode=-2261 or sqlcode=-2264 or sqlcode=-2275 or sqlcode=-1442 then null; else raise; end if;
 end;
/




PROMPT *** Create  constraint CC_SVOWNERGROUP_NAME_NN ***
begin   
 execute immediate '
  ALTER TABLE BARS.SV_OWNER_GROUP ADD CONSTRAINT CC_SVOWNERGROUP_NAME_NN CHECK (NAME IS NOT NULL) ENABLE';
exception when others then
  if  sqlcode=-2260 or sqlcode=-2261 or sqlcode=-2264 or sqlcode=-2275 or sqlcode=-1442 then null; else raise; end if;
 end;
/




PROMPT *** Create  constraint CC_SVOWNERGROUP_ID_NN ***
begin   
 execute immediate '
  ALTER TABLE BARS.SV_OWNER_GROUP ADD CONSTRAINT CC_SVOWNERGROUP_ID_NN CHECK (ID IS NOT NULL) ENABLE';
exception when others then
  if  sqlcode=-2260 or sqlcode=-2261 or sqlcode=-2264 or sqlcode=-2275 or sqlcode=-1442 then null; else raise; end if;
 end;
/




PROMPT *** Create  index PK_SVOWNERGROUP ***
begin   
 execute immediate '
  CREATE UNIQUE INDEX BARS.PK_SVOWNERGROUP ON BARS.SV_OWNER_GROUP (ID) 
  PCTFREE 10 INITRANS 2 MAXTRANS 255 COMPUTE STATISTICS 
  TABLESPACE BRSDYND ';
exception when others then
  if  sqlcode=-955  then null; else raise; end if;
 end;
/



PROMPT *** Create  grants  SV_OWNER_GROUP ***
grant DELETE,FLASHBACK,INSERT,SELECT,UPDATE                                  on SV_OWNER_GROUP  to BARS_ACCESS_DEFROLE;
grant DELETE,INSERT,SELECT,UPDATE                                            on SV_OWNER_GROUP  to RPBN002;
grant DELETE,INSERT,SELECT,UPDATE                                            on SV_OWNER_GROUP  to START1;
grant FLASHBACK,SELECT                                                       on SV_OWNER_GROUP  to WR_REFREAD;



PROMPT ===================================================================================== 
PROMPT *** End *** ========== Scripts /Sql/BARS/Table/SV_OWNER_GROUP.sql =========*** End **
PROMPT ===================================================================================== 
