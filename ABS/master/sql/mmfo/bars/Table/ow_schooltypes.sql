

PROMPT ===================================================================================== 
PROMPT *** Run *** ========== Scripts /Sql/BARS/Table/OW_SCHOOLTYPES.sql =========*** Run **
PROMPT ===================================================================================== 


PROMPT *** ALTER_POLICY_INFO to OW_SCHOOLTYPES ***


BEGIN 
        execute immediate  
          'begin  
               bpa.alter_policy_info(''OW_SCHOOLTYPES'', ''CENTER'' , null, null, null, null);
               bpa.alter_policy_info(''OW_SCHOOLTYPES'', ''FILIAL'' , null, null, null, null);
               bpa.alter_policy_info(''OW_SCHOOLTYPES'', ''WHOLE'' , null, null, null, null);
               null;
           end; 
          '; 
END; 
/

PROMPT *** Create  table OW_SCHOOLTYPES ***
begin 
  execute immediate '
  CREATE TABLE BARS.OW_SCHOOLTYPES 
   (	SCHOOLTYPEID NUMBER(*,0), 
	INFO VARCHAR2(250)
   ) SEGMENT CREATION IMMEDIATE 
  PCTFREE 10 PCTUSED 40 INITRANS 1 MAXTRANS 255 
 NOCOMPRESS LOGGING
  TABLESPACE BRSMDLD ';
exception when others then       
  if sqlcode=-955 then null; else raise; end if; 
end; 
/




PROMPT *** ALTER_POLICIES to OW_SCHOOLTYPES ***
 exec bpa.alter_policies('OW_SCHOOLTYPES');


COMMENT ON TABLE BARS.OW_SCHOOLTYPES IS 'Довідник типів шкіл';
COMMENT ON COLUMN BARS.OW_SCHOOLTYPES.SCHOOLTYPEID IS 'Ідентифікатор типу навчального закладу';
COMMENT ON COLUMN BARS.OW_SCHOOLTYPES.INFO IS 'Тип навчального закладу';




PROMPT *** Create  constraint PK_OWSCHOOLTYPES ***
begin   
 execute immediate '
  ALTER TABLE BARS.OW_SCHOOLTYPES ADD CONSTRAINT PK_OWSCHOOLTYPES PRIMARY KEY (SCHOOLTYPEID)
  USING INDEX PCTFREE 10 INITRANS 2 MAXTRANS 255 COMPUTE STATISTICS 
  TABLESPACE BRSMDLI  ENABLE';
exception when others then
  if  sqlcode=-2260 or sqlcode=-2261 or sqlcode=-2264 or sqlcode=-2275 or sqlcode=-1442 then null; else raise; end if;
 end;
/




PROMPT *** Create  index PK_OWSCHOOLTYPES ***
begin   
 execute immediate '
  CREATE UNIQUE INDEX BARS.PK_OWSCHOOLTYPES ON BARS.OW_SCHOOLTYPES (SCHOOLTYPEID) 
  PCTFREE 10 INITRANS 2 MAXTRANS 255 COMPUTE STATISTICS 
  TABLESPACE BRSMDLI ';
exception when others then
  if  sqlcode=-955  then null; else raise; end if;
 end;
/



PROMPT *** Create  grants  OW_SCHOOLTYPES ***
grant SELECT                                                                 on OW_SCHOOLTYPES  to BARSREADER_ROLE;
grant DELETE,INSERT,SELECT,UPDATE                                            on OW_SCHOOLTYPES  to BARS_ACCESS_DEFROLE;
grant SELECT                                                                 on OW_SCHOOLTYPES  to BARS_DM;
grant SELECT                                                                 on OW_SCHOOLTYPES  to UPLD;



PROMPT ===================================================================================== 
PROMPT *** End *** ========== Scripts /Sql/BARS/Table/OW_SCHOOLTYPES.sql =========*** End **
PROMPT ===================================================================================== 
