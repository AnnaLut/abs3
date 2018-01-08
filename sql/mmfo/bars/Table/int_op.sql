

PROMPT ===================================================================================== 
PROMPT *** Run *** ========== Scripts /Sql/BARS/Table/INT_OP.sql =========*** Run *** ======
PROMPT ===================================================================================== 


PROMPT *** ALTER_POLICY_INFO to INT_OP ***


BEGIN 
        execute immediate  
          'begin  
               bpa.alter_policy_info(''INT_OP'', ''CENTER'' , null, null, null, null);
               bpa.alter_policy_info(''INT_OP'', ''FILIAL'' , null, ''E'', ''E'', ''E'');
               bpa.alter_policy_info(''INT_OP'', ''WHOLE'' , null, null, null, null);
               null;
           end; 
          '; 
END; 
/

PROMPT *** Create  table INT_OP ***
begin 
  execute immediate '
  CREATE TABLE BARS.INT_OP 
   (	OP NUMBER(2,0), 
	SEMANTIC VARCHAR2(2)
   ) SEGMENT CREATION IMMEDIATE 
  PCTFREE 10 PCTUSED 40 INITRANS 1 MAXTRANS 255 
 NOCOMPRESS LOGGING
  TABLESPACE BRSSMLD ';
exception when others then       
  if sqlcode=-955 then null; else raise; end if; 
end; 
/




PROMPT *** ALTER_POLICIES to INT_OP ***
 exec bpa.alter_policies('INT_OP');


COMMENT ON TABLE BARS.INT_OP IS 'Таблица видов операций';
COMMENT ON COLUMN BARS.INT_OP.OP IS 'Код вида операции';
COMMENT ON COLUMN BARS.INT_OP.SEMANTIC IS 'Семантика';




PROMPT *** Create  constraint PK_INTOP ***
begin   
 execute immediate '
  ALTER TABLE BARS.INT_OP ADD CONSTRAINT PK_INTOP PRIMARY KEY (OP)
  USING INDEX PCTFREE 10 INITRANS 2 MAXTRANS 255 COMPUTE STATISTICS 
  TABLESPACE BRSSMLI  ENABLE';
exception when others then
  if  sqlcode=-2260 or sqlcode=-2261 or sqlcode=-2264 or sqlcode=-2275 or sqlcode=-1442 then null; else raise; end if;
 end;
/




PROMPT *** Create  constraint CC_INTOP_OP_NN ***
begin   
 execute immediate '
  ALTER TABLE BARS.INT_OP MODIFY (OP CONSTRAINT CC_INTOP_OP_NN NOT NULL ENABLE)';
exception when others then
  if  sqlcode=-2260 or sqlcode=-2261 or sqlcode=-2264 or sqlcode=-2275 or sqlcode=-1442 then null; else raise; end if;
 end;
/




PROMPT *** Create  index PK_INTOP ***
begin   
 execute immediate '
  CREATE UNIQUE INDEX BARS.PK_INTOP ON BARS.INT_OP (OP) 
  PCTFREE 10 INITRANS 2 MAXTRANS 255 COMPUTE STATISTICS 
  TABLESPACE BRSSMLI ';
exception when others then
  if  sqlcode=-955  then null; else raise; end if;
 end;
/



PROMPT *** Create  grants  INT_OP ***
grant DELETE,INSERT,SELECT,UPDATE                                            on INT_OP          to ABS_ADMIN;
grant SELECT                                                                 on INT_OP          to BARS010;
grant DELETE,FLASHBACK,INSERT,SELECT,UPDATE                                  on INT_OP          to BARS_ACCESS_DEFROLE;
grant SELECT                                                                 on INT_OP          to BARS_DM;
grant SELECT                                                                 on INT_OP          to DPT;
grant SELECT                                                                 on INT_OP          to START1;
grant DELETE,FLASHBACK,INSERT,SELECT,UPDATE                                  on INT_OP          to WR_ALL_RIGHTS;
grant FLASHBACK,SELECT                                                       on INT_OP          to WR_REFREAD;



PROMPT ===================================================================================== 
PROMPT *** End *** ========== Scripts /Sql/BARS/Table/INT_OP.sql =========*** End *** ======
PROMPT ===================================================================================== 
