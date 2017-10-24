

PROMPT ===================================================================================== 
PROMPT *** Run *** ========== Scripts /Sql/BARS/Table/REZ_NAL.sql =========*** Run *** =====
PROMPT ===================================================================================== 


PROMPT *** ALTER_POLICY_INFO to REZ_NAL ***


BEGIN 
        execute immediate  
          'begin  
               bpa.alter_policy_info(''REZ_NAL'', ''CENTER'' , null, null, null, null);
               bpa.alter_policy_info(''REZ_NAL'', ''FILIAL'' , null, null, null, null);
               bpa.alter_policy_info(''REZ_NAL'', ''WHOLE'' , null, null, null, null);
               null;
           end; 
          '; 
END; 
/

PROMPT *** Create  table REZ_NAL ***
begin 
  execute immediate '
  CREATE TABLE BARS.REZ_NAL 
   (	NAL VARCHAR2(1), 
	NAME VARCHAR2(100)
   ) SEGMENT CREATION IMMEDIATE 
  PCTFREE 10 PCTUSED 40 INITRANS 1 MAXTRANS 255 
 NOCOMPRESS LOGGING
  TABLESPACE BRSDYND ';
exception when others then       
  if sqlcode=-955 then null; else raise; end if; 
end; 
/




PROMPT *** ALTER_POLICIES to REZ_NAL ***
 exec bpa.alter_policies('REZ_NAL');


COMMENT ON TABLE BARS.REZ_NAL IS 'Довідник груп формування резерву';
COMMENT ON COLUMN BARS.REZ_NAL.NAL IS 'Группа';
COMMENT ON COLUMN BARS.REZ_NAL.NAME IS 'Назва';




PROMPT *** Create  constraint PK_REZNAL ***
begin   
 execute immediate '
  ALTER TABLE BARS.REZ_NAL ADD CONSTRAINT PK_REZNAL PRIMARY KEY (NAL)
  USING INDEX PCTFREE 10 INITRANS 2 MAXTRANS 255 COMPUTE STATISTICS 
  TABLESPACE BRSDYND  ENABLE';
exception when others then
  if  sqlcode=-2260 or sqlcode=-2261 or sqlcode=-2264 or sqlcode=-2275 or sqlcode=-1442 then null; else raise; end if;
 end;
/




PROMPT *** Create  index PK_REZNAL ***
begin   
 execute immediate '
  CREATE UNIQUE INDEX BARS.PK_REZNAL ON BARS.REZ_NAL (NAL) 
  PCTFREE 10 INITRANS 2 MAXTRANS 255 COMPUTE STATISTICS 
  TABLESPACE BRSDYND ';
exception when others then
  if  sqlcode=-955  then null; else raise; end if;
 end;
/



PROMPT *** Create  grants  REZ_NAL ***
grant SELECT                                                                 on REZ_NAL         to BARS_ACCESS_DEFROLE;
grant SELECT                                                                 on REZ_NAL         to RCC_DEAL;
grant SELECT                                                                 on REZ_NAL         to START1;



PROMPT ===================================================================================== 
PROMPT *** End *** ========== Scripts /Sql/BARS/Table/REZ_NAL.sql =========*** End *** =====
PROMPT ===================================================================================== 
