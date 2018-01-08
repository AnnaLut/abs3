

PROMPT ===================================================================================== 
PROMPT *** Run *** ========== Scripts /Sql/BARS/Table/REZ0A.sql =========*** Run *** =======
PROMPT ===================================================================================== 


PROMPT *** ALTER_POLICY_INFO to REZ0A ***


BEGIN 
        execute immediate  
          'begin  
               bpa.alter_policy_info(''REZ0A'', ''CENTER'' , null, null, null, null);
               bpa.alter_policy_info(''REZ0A'', ''FILIAL'' , null, null, null, null);
               bpa.alter_policy_info(''REZ0A'', ''WHOLE'' , null, null, null, null);
               null;
           end; 
          '; 
END; 
/

PROMPT *** Create  table REZ0A ***
begin 
  execute immediate '
  CREATE TABLE BARS.REZ0A 
   (	NBS CHAR(4), 
	PR_ NUMBER(5,2)
   ) SEGMENT CREATION IMMEDIATE 
  PCTFREE 10 PCTUSED 40 INITRANS 1 MAXTRANS 255 
 NOCOMPRESS LOGGING
  TABLESPACE BRSDYND ';
exception when others then       
  if sqlcode=-955 then null; else raise; end if; 
end; 
/




PROMPT *** ALTER_POLICIES to REZ0A ***
 exec bpa.alter_policies('REZ0A');


COMMENT ON TABLE BARS.REZ0A IS 'Активи банку для розрахунку резерву (БР та %)';
COMMENT ON COLUMN BARS.REZ0A.NBS IS '';
COMMENT ON COLUMN BARS.REZ0A.PR_ IS '';




PROMPT *** Create  constraint XPK_REZ0A ***
begin   
 execute immediate '
  ALTER TABLE BARS.REZ0A ADD CONSTRAINT XPK_REZ0A PRIMARY KEY (NBS)
  USING INDEX PCTFREE 10 INITRANS 2 MAXTRANS 255 COMPUTE STATISTICS 
  TABLESPACE BRSDYNI  ENABLE';
exception when others then
  if  sqlcode=-2260 or sqlcode=-2261 or sqlcode=-2264 or sqlcode=-2275 or sqlcode=-1442 then null; else raise; end if;
 end;
/




PROMPT *** Create  index XPK_REZ0A ***
begin   
 execute immediate '
  CREATE UNIQUE INDEX BARS.XPK_REZ0A ON BARS.REZ0A (NBS) 
  PCTFREE 10 INITRANS 2 MAXTRANS 255 COMPUTE STATISTICS 
  TABLESPACE BRSDYNI ';
exception when others then
  if  sqlcode=-955  then null; else raise; end if;
 end;
/



PROMPT *** Create  grants  REZ0A ***
grant SELECT                                                                 on REZ0A           to BARS_ACCESS_DEFROLE;
grant SELECT                                                                 on REZ0A           to BARS_DM;
grant SELECT                                                                 on REZ0A           to SALGL;
grant DELETE,FLASHBACK,INSERT,SELECT,UPDATE                                  on REZ0A           to WR_ALL_RIGHTS;



PROMPT ===================================================================================== 
PROMPT *** End *** ========== Scripts /Sql/BARS/Table/REZ0A.sql =========*** End *** =======
PROMPT ===================================================================================== 
