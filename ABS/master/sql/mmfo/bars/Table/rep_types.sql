

PROMPT ===================================================================================== 
PROMPT *** Run *** ========== Scripts /Sql/BARS/Table/REP_TYPES.sql =========*** Run *** ===
PROMPT ===================================================================================== 


PROMPT *** ALTER_POLICY_INFO to REP_TYPES ***


BEGIN 
        execute immediate  
          'begin  
               bpa.alter_policy_info(''REP_TYPES'', ''CENTER'' , null, null, null, null);
               bpa.alter_policy_info(''REP_TYPES'', ''FILIAL'' , null, ''E'', ''E'', ''E'');
               bpa.alter_policy_info(''REP_TYPES'', ''WHOLE'' , null, null, null, null);
               null;
           end; 
          '; 
END; 
/

PROMPT *** Create  table REP_TYPES ***
begin 
  execute immediate '
  CREATE TABLE BARS.REP_TYPES 
   (	TYPEID NUMBER, 
	DESCRIPT VARCHAR2(200)
   ) SEGMENT CREATION IMMEDIATE 
  PCTFREE 10 PCTUSED 40 INITRANS 1 MAXTRANS 255 
 NOCOMPRESS LOGGING
  TABLESPACE BRSSMLD ';
exception when others then       
  if sqlcode=-955 then null; else raise; end if; 
end; 
/




PROMPT *** ALTER_POLICIES to REP_TYPES ***
 exec bpa.alter_policies('REP_TYPES');


COMMENT ON TABLE BARS.REP_TYPES IS 'Список типов отчетов, которые можно формировать на основании каталогизированных отчетов.';
COMMENT ON COLUMN BARS.REP_TYPES.TYPEID IS '';
COMMENT ON COLUMN BARS.REP_TYPES.DESCRIPT IS '';




PROMPT *** Create  constraint XPK_REP_TYPES ***
begin   
 execute immediate '
  ALTER TABLE BARS.REP_TYPES ADD CONSTRAINT XPK_REP_TYPES PRIMARY KEY (TYPEID)
  USING INDEX PCTFREE 10 INITRANS 2 MAXTRANS 255 COMPUTE STATISTICS 
  TABLESPACE BRSSMLI  ENABLE';
exception when others then
  if  sqlcode=-2260 or sqlcode=-2261 or sqlcode=-2264 or sqlcode=-2275 or sqlcode=-1442 then null; else raise; end if;
 end;
/




PROMPT *** Create  index XPK_REP_TYPES ***
begin   
 execute immediate '
  CREATE UNIQUE INDEX BARS.XPK_REP_TYPES ON BARS.REP_TYPES (TYPEID) 
  PCTFREE 10 INITRANS 2 MAXTRANS 255 COMPUTE STATISTICS 
  TABLESPACE BRSSMLI ';
exception when others then
  if  sqlcode=-955  then null; else raise; end if;
 end;
/



PROMPT *** Create  grants  REP_TYPES ***
grant SELECT                                                                 on REP_TYPES       to BARSREADER_ROLE;
grant SELECT                                                                 on REP_TYPES       to BARS_ACCESS_DEFROLE;
grant SELECT                                                                 on REP_TYPES       to BARS_DM;
grant SELECT                                                                 on REP_TYPES       to RPBN001;
grant SELECT                                                                 on REP_TYPES       to UPLD;



PROMPT ===================================================================================== 
PROMPT *** End *** ========== Scripts /Sql/BARS/Table/REP_TYPES.sql =========*** End *** ===
PROMPT ===================================================================================== 
