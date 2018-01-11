

PROMPT ===================================================================================== 
PROMPT *** Run *** ========== Scripts /Sql/BARS/Table/NBS_FRONT_OFFICE.sql =========*** Run 
PROMPT ===================================================================================== 


PROMPT *** ALTER_POLICY_INFO to NBS_FRONT_OFFICE ***


BEGIN 
        execute immediate  
          'begin  
               bpa.alter_policy_info(''NBS_FRONT_OFFICE'', ''FILIAL'' , null, null, null, null);
               bpa.alter_policy_info(''NBS_FRONT_OFFICE'', ''WHOLE'' , null, null, null, null);
               null;
           end; 
          '; 
END; 
/

PROMPT *** Create  table NBS_FRONT_OFFICE ***
begin 
  execute immediate '
  CREATE TABLE BARS.NBS_FRONT_OFFICE 
   (	NBS CHAR(4)
   ) SEGMENT CREATION IMMEDIATE 
  PCTFREE 10 PCTUSED 40 INITRANS 1 MAXTRANS 255 
 NOCOMPRESS LOGGING
  TABLESPACE BRSDYND ';
exception when others then       
  if sqlcode=-955 then null; else raise; end if; 
end; 
/




PROMPT *** ALTER_POLICIES to NBS_FRONT_OFFICE ***
 exec bpa.alter_policies('NBS_FRONT_OFFICE');


COMMENT ON TABLE BARS.NBS_FRONT_OFFICE IS '';
COMMENT ON COLUMN BARS.NBS_FRONT_OFFICE.NBS IS '';




PROMPT *** Create  constraint PK_NBS ***
begin   
 execute immediate '
  ALTER TABLE BARS.NBS_FRONT_OFFICE ADD CONSTRAINT PK_NBS PRIMARY KEY (NBS)
  USING INDEX PCTFREE 10 INITRANS 2 MAXTRANS 255 COMPUTE STATISTICS 
  TABLESPACE BRSDYND  ENABLE';
exception when others then
  if  sqlcode=-2260 or sqlcode=-2261 or sqlcode=-2264 or sqlcode=-2275 or sqlcode=-1442 then null; else raise; end if;
 end;
/




PROMPT *** Create  index PK_NBS ***
begin   
 execute immediate '
  CREATE UNIQUE INDEX BARS.PK_NBS ON BARS.NBS_FRONT_OFFICE (NBS) 
  PCTFREE 10 INITRANS 2 MAXTRANS 255 COMPUTE STATISTICS 
  TABLESPACE BRSDYND ';
exception when others then
  if  sqlcode=-955  then null; else raise; end if;
 end;
/



PROMPT *** Create  grants  NBS_FRONT_OFFICE ***
grant SELECT                                                                 on NBS_FRONT_OFFICE to BARSREADER_ROLE;
grant DELETE,INSERT,SELECT                                                   on NBS_FRONT_OFFICE to BARS_ACCESS_DEFROLE;
grant SELECT                                                                 on NBS_FRONT_OFFICE to UPLD;



PROMPT ===================================================================================== 
PROMPT *** End *** ========== Scripts /Sql/BARS/Table/NBS_FRONT_OFFICE.sql =========*** End 
PROMPT ===================================================================================== 
