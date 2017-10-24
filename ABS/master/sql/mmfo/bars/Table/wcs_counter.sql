

PROMPT ===================================================================================== 
PROMPT *** Run *** ========== Scripts /Sql/BARS/Table/WCS_COUNTER.sql =========*** Run *** =
PROMPT ===================================================================================== 


PROMPT *** ALTER_POLICY_INFO to WCS_COUNTER ***


BEGIN 
        execute immediate  
          'begin  
               bpa.alter_policy_info(''WCS_COUNTER'', ''CENTER'' , null, null, null, null);
               bpa.alter_policy_info(''WCS_COUNTER'', ''FILIAL'' , null, null, null, null);
               bpa.alter_policy_info(''WCS_COUNTER'', ''WHOLE'' , null, null, null, null);
               null;
           end; 
          '; 
END; 
/

PROMPT *** Create  table WCS_COUNTER ***
begin 
  execute immediate '
  CREATE TABLE BARS.WCS_COUNTER 
   (	IDX NUMBER
   ) SEGMENT CREATION IMMEDIATE 
  PCTFREE 10 PCTUSED 40 INITRANS 1 MAXTRANS 255 
 NOCOMPRESS LOGGING
  TABLESPACE BRSSMLD ';
exception when others then       
  if sqlcode=-955 then null; else raise; end if; 
end; 
/




PROMPT *** ALTER_POLICIES to WCS_COUNTER ***
 exec bpa.alter_policies('WCS_COUNTER');


COMMENT ON TABLE BARS.WCS_COUNTER IS 'Счетчик';
COMMENT ON COLUMN BARS.WCS_COUNTER.IDX IS 'Последовательное число';




PROMPT *** Create  constraint PK_WCSCOUNTER ***
begin   
 execute immediate '
  ALTER TABLE BARS.WCS_COUNTER ADD CONSTRAINT PK_WCSCOUNTER PRIMARY KEY (IDX)
  USING INDEX PCTFREE 10 INITRANS 2 MAXTRANS 255 COMPUTE STATISTICS 
  TABLESPACE BRSSMLD  ENABLE';
exception when others then
  if  sqlcode=-2260 or sqlcode=-2261 or sqlcode=-2264 or sqlcode=-2275 or sqlcode=-1442 then null; else raise; end if;
 end;
/




PROMPT *** Create  index PK_WCSCOUNTER ***
begin   
 execute immediate '
  CREATE UNIQUE INDEX BARS.PK_WCSCOUNTER ON BARS.WCS_COUNTER (IDX) 
  PCTFREE 10 INITRANS 2 MAXTRANS 255 COMPUTE STATISTICS 
  TABLESPACE BRSSMLD ';
exception when others then
  if  sqlcode=-955  then null; else raise; end if;
 end;
/



PROMPT *** Create  grants  WCS_COUNTER ***
grant SELECT                                                                 on WCS_COUNTER     to BARS_ACCESS_DEFROLE;
grant SELECT                                                                 on WCS_COUNTER     to BARS_DM;



PROMPT ===================================================================================== 
PROMPT *** End *** ========== Scripts /Sql/BARS/Table/WCS_COUNTER.sql =========*** End *** =
PROMPT ===================================================================================== 
