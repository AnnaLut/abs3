

PROMPT ===================================================================================== 
PROMPT *** Run *** ========== Scripts /Sql/BARS/Table/GRP_REZ_NBS.sql =========*** Run *** =
PROMPT ===================================================================================== 


PROMPT *** ALTER_POLICY_INFO to GRP_REZ_NBS ***


BEGIN 
        execute immediate  
          'begin  
               bpa.alter_policy_info(''GRP_REZ_NBS'', ''CENTER'' , null, null, null, null);
               bpa.alter_policy_info(''GRP_REZ_NBS'', ''FILIAL'' , null, null, null, null);
               bpa.alter_policy_info(''GRP_REZ_NBS'', ''WHOLE'' , null, null, null, null);
               null;
           end; 
          '; 
END; 
/

PROMPT *** Create  table GRP_REZ_NBS ***
begin 
  execute immediate '
  CREATE TABLE BARS.GRP_REZ_NBS 
   (	GRP NUMBER(*,0), 
	NBS VARCHAR2(4), 
	OB22 VARCHAR2(2)
   ) SEGMENT CREATION IMMEDIATE 
  PCTFREE 10 PCTUSED 40 INITRANS 1 MAXTRANS 255 
 NOCOMPRESS LOGGING
  TABLESPACE BRSDYND ';
exception when others then       
  if sqlcode=-955 then null; else raise; end if; 
end; 
/




PROMPT *** ALTER_POLICIES to GRP_REZ_NBS ***
 exec bpa.alter_policies('GRP_REZ_NBS');


COMMENT ON TABLE BARS.GRP_REZ_NBS IS 'Довідник груп резерву';
COMMENT ON COLUMN BARS.GRP_REZ_NBS.GRP IS 'Группа';
COMMENT ON COLUMN BARS.GRP_REZ_NBS.NBS IS 'Бал.рах.';
COMMENT ON COLUMN BARS.GRP_REZ_NBS.OB22 IS 'ОБ22';




PROMPT *** Create  constraint PK_GRPREZNBS ***
begin   
 execute immediate '
  ALTER TABLE BARS.GRP_REZ_NBS ADD CONSTRAINT PK_GRPREZNBS PRIMARY KEY (GRP, NBS, OB22)
  USING INDEX PCTFREE 10 INITRANS 2 MAXTRANS 255 COMPUTE STATISTICS 
  TABLESPACE BRSDYND  ENABLE';
exception when others then
  if  sqlcode=-2260 or sqlcode=-2261 or sqlcode=-2264 or sqlcode=-2275 or sqlcode=-1442 then null; else raise; end if;
 end;
/




PROMPT *** Create  index PK_GRPREZNBS ***
begin   
 execute immediate '
  CREATE UNIQUE INDEX BARS.PK_GRPREZNBS ON BARS.GRP_REZ_NBS (GRP, NBS, OB22) 
  PCTFREE 10 INITRANS 2 MAXTRANS 255 COMPUTE STATISTICS 
  TABLESPACE BRSDYND ';
exception when others then
  if  sqlcode=-955  then null; else raise; end if;
 end;
/



PROMPT *** Create  grants  GRP_REZ_NBS ***
grant SELECT                                                                 on GRP_REZ_NBS     to BARSREADER_ROLE;
grant DELETE,INSERT,SELECT,UPDATE                                            on GRP_REZ_NBS     to BARS_ACCESS_DEFROLE;
grant SELECT                                                                 on GRP_REZ_NBS     to BARS_DM;
grant DELETE,INSERT,SELECT,UPDATE                                            on GRP_REZ_NBS     to RCC_DEAL;
grant SELECT                                                                 on GRP_REZ_NBS     to START1;
grant SELECT                                                                 on GRP_REZ_NBS     to UPLD;



PROMPT ===================================================================================== 
PROMPT *** End *** ========== Scripts /Sql/BARS/Table/GRP_REZ_NBS.sql =========*** End *** =
PROMPT ===================================================================================== 
