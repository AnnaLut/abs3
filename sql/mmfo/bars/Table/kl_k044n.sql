

PROMPT ===================================================================================== 
PROMPT *** Run *** ========== Scripts /Sql/BARS/Table/KL_K044N.sql =========*** Run *** ====
PROMPT ===================================================================================== 


PROMPT *** ALTER_POLICY_INFO to KL_K044N ***


BEGIN 
        execute immediate  
          'begin  
               bpa.alter_policy_info(''KL_K044N'', ''CENTER'' , null, null, null, null);
               bpa.alter_policy_info(''KL_K044N'', ''FILIAL'' , null, null, null, null);
               bpa.alter_policy_info(''KL_K044N'', ''WHOLE'' , null, null, null, null);
               null;
           end; 
          '; 
END; 
/

PROMPT *** Create  table KL_K044N ***
begin 
  execute immediate '
  CREATE TABLE BARS.KL_K044N 
   (	K044 CHAR(2), 
	K040 CHAR(3)
   ) SEGMENT CREATION IMMEDIATE 
  PCTFREE 10 PCTUSED 40 INITRANS 1 MAXTRANS 255 
 NOCOMPRESS LOGGING
  TABLESPACE BRSDYNI ';
exception when others then       
  if sqlcode=-955 then null; else raise; end if; 
end; 
/




PROMPT *** ALTER_POLICIES to KL_K044N ***
 exec bpa.alter_policies('KL_K044N');


COMMENT ON TABLE BARS.KL_K044N IS '';
COMMENT ON COLUMN BARS.KL_K044N.K044 IS '';
COMMENT ON COLUMN BARS.KL_K044N.K040 IS '';




PROMPT *** Create  constraint PK_KL_K044N ***
begin   
 execute immediate '
  ALTER TABLE BARS.KL_K044N ADD CONSTRAINT PK_KL_K044N PRIMARY KEY (K044, K040)
  USING INDEX PCTFREE 10 INITRANS 2 MAXTRANS 255 COMPUTE STATISTICS 
  TABLESPACE BRSDYND  ENABLE';
exception when others then
  if  sqlcode=-2260 or sqlcode=-2261 or sqlcode=-2264 or sqlcode=-2275 or sqlcode=-1442 then null; else raise; end if;
 end;
/




PROMPT *** Create  index PK_KL_K044N ***
begin   
 execute immediate '
  CREATE UNIQUE INDEX BARS.PK_KL_K044N ON BARS.KL_K044N (K044, K040) 
  PCTFREE 10 INITRANS 2 MAXTRANS 255 COMPUTE STATISTICS 
  TABLESPACE BRSDYND ';
exception when others then
  if  sqlcode=-955  then null; else raise; end if;
 end;
/



PROMPT *** Create  grants  KL_K044N ***
grant DELETE,INSERT,SELECT,UPDATE                                            on KL_K044N        to BARS_ACCESS_DEFROLE;
grant DELETE,INSERT,SELECT,UPDATE                                            on KL_K044N        to RPBN002;
grant SELECT                                                                 on KL_K044N        to START1;



PROMPT ===================================================================================== 
PROMPT *** End *** ========== Scripts /Sql/BARS/Table/KL_K044N.sql =========*** End *** ====
PROMPT ===================================================================================== 
