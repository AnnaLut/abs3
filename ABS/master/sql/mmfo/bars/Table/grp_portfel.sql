

PROMPT ===================================================================================== 
PROMPT *** Run *** ========== Scripts /Sql/BARS/Table/GRP_PORTFEL.sql =========*** Run *** =
PROMPT ===================================================================================== 


PROMPT *** ALTER_POLICY_INFO to GRP_PORTFEL ***


BEGIN 
        execute immediate  
          'begin  
               bpa.alter_policy_info(''GRP_PORTFEL'', ''CENTER'' , null, null, null, null);
               bpa.alter_policy_info(''GRP_PORTFEL'', ''FILIAL'' , null, ''E'', ''E'', ''E'');
               bpa.alter_policy_info(''GRP_PORTFEL'', ''WHOLE'' , null, null, null, null);
               null;
           end; 
          '; 
END; 
/

PROMPT *** Create  table GRP_PORTFEL ***
begin 
  execute immediate '
  CREATE TABLE BARS.GRP_PORTFEL 
   (	GRP NUMBER(*,0), 
	NAME VARCHAR2(120), 
	NAME_SHORT VARCHAR2(50)
   ) SEGMENT CREATION IMMEDIATE 
  PCTFREE 10 PCTUSED 40 INITRANS 1 MAXTRANS 255 
 NOCOMPRESS LOGGING
  TABLESPACE BRSDYND ';
exception when others then       
  if sqlcode=-955 then null; else raise; end if; 
end; 
/




PROMPT *** ALTER_POLICIES to GRP_PORTFEL ***
 exec bpa.alter_policies('GRP_PORTFEL');


COMMENT ON TABLE BARS.GRP_PORTFEL IS 'Довідник груп несуттєвих фінансових актівів';
COMMENT ON COLUMN BARS.GRP_PORTFEL.GRP IS 'Ном.групи';
COMMENT ON COLUMN BARS.GRP_PORTFEL.NAME IS 'Назва';
COMMENT ON COLUMN BARS.GRP_PORTFEL.NAME_SHORT IS 'Назва коротка';




PROMPT *** Create  constraint PK_GRPPORTFEL ***
begin   
 execute immediate '
  ALTER TABLE BARS.GRP_PORTFEL ADD CONSTRAINT PK_GRPPORTFEL PRIMARY KEY (GRP)
  USING INDEX PCTFREE 10 INITRANS 2 MAXTRANS 255 COMPUTE STATISTICS 
  TABLESPACE BRSDYND  ENABLE';
exception when others then
  if  sqlcode=-2260 or sqlcode=-2261 or sqlcode=-2264 or sqlcode=-2275 or sqlcode=-1442 then null; else raise; end if;
 end;
/




PROMPT *** Create  index PK_GRPPORTFEL ***
begin   
 execute immediate '
  CREATE UNIQUE INDEX BARS.PK_GRPPORTFEL ON BARS.GRP_PORTFEL (GRP) 
  PCTFREE 10 INITRANS 2 MAXTRANS 255 COMPUTE STATISTICS 
  TABLESPACE BRSDYND ';
exception when others then
  if  sqlcode=-955  then null; else raise; end if;
 end;
/



PROMPT *** Create  grants  GRP_PORTFEL ***
grant SELECT                                                                 on GRP_PORTFEL     to BARSREADER_ROLE;
grant SELECT                                                                 on GRP_PORTFEL     to RCC_DEAL;
grant SELECT                                                                 on GRP_PORTFEL     to START1;
grant SELECT                                                                 on GRP_PORTFEL     to UPLD;



PROMPT ===================================================================================== 
PROMPT *** End *** ========== Scripts /Sql/BARS/Table/GRP_PORTFEL.sql =========*** End *** =
PROMPT ===================================================================================== 
