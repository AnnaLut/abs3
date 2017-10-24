

PROMPT ===================================================================================== 
PROMPT *** Run *** ========== Scripts /Sql/BARS/Table/REP_LICNAZNTT.sql =========*** Run ***
PROMPT ===================================================================================== 


PROMPT *** ALTER_POLICY_INFO to REP_LICNAZNTT ***


BEGIN 
        execute immediate  
          'begin  
               bpa.alter_policy_info(''REP_LICNAZNTT'', ''CENTER'' , null, null, null, null);
               bpa.alter_policy_info(''REP_LICNAZNTT'', ''FILIAL'' , null, ''E'', ''E'', ''E'');
               bpa.alter_policy_info(''REP_LICNAZNTT'', ''WHOLE'' , null, null, null, null);
               null;
           end; 
          '; 
END; 
/

PROMPT *** Create  table REP_LICNAZNTT ***
begin 
  execute immediate '
  CREATE TABLE BARS.REP_LICNAZNTT 
   (	TT VARCHAR2(3)
   ) SEGMENT CREATION IMMEDIATE 
  PCTFREE 10 PCTUSED 40 INITRANS 1 MAXTRANS 255 
 NOCOMPRESS LOGGING
  TABLESPACE BRSSMLD ';
exception when others then       
  if sqlcode=-955 then null; else raise; end if; 
end; 
/




PROMPT *** ALTER_POLICIES to REP_LICNAZNTT ***
 exec bpa.alter_policies('REP_LICNAZNTT');


COMMENT ON TABLE BARS.REP_LICNAZNTT IS 'Список операций по которым производить поиск назначения по OPER для выписок';
COMMENT ON COLUMN BARS.REP_LICNAZNTT.TT IS '';




PROMPT *** Create  constraint XPK_REP_LICNAZNTT ***
begin   
 execute immediate '
  ALTER TABLE BARS.REP_LICNAZNTT ADD CONSTRAINT XPK_REP_LICNAZNTT PRIMARY KEY (TT)
  USING INDEX PCTFREE 10 INITRANS 2 MAXTRANS 255 COMPUTE STATISTICS 
  TABLESPACE BRSSMLI  ENABLE';
exception when others then
  if  sqlcode=-2260 or sqlcode=-2261 or sqlcode=-2264 or sqlcode=-2275 or sqlcode=-1442 then null; else raise; end if;
 end;
/




PROMPT *** Create  index XPK_REP_LICNAZNTT ***
begin   
 execute immediate '
  CREATE UNIQUE INDEX BARS.XPK_REP_LICNAZNTT ON BARS.REP_LICNAZNTT (TT) 
  PCTFREE 10 INITRANS 2 MAXTRANS 255 COMPUTE STATISTICS 
  TABLESPACE BRSSMLI ';
exception when others then
  if  sqlcode=-955  then null; else raise; end if;
 end;
/



PROMPT *** Create  grants  REP_LICNAZNTT ***
grant SELECT                                                                 on REP_LICNAZNTT   to BARS_DM;



PROMPT ===================================================================================== 
PROMPT *** End *** ========== Scripts /Sql/BARS/Table/REP_LICNAZNTT.sql =========*** End ***
PROMPT ===================================================================================== 
