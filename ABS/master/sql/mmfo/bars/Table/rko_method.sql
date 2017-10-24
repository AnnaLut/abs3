

PROMPT ===================================================================================== 
PROMPT *** Run *** ========== Scripts /Sql/BARS/Table/RKO_METHOD.sql =========*** Run *** ==
PROMPT ===================================================================================== 


PROMPT *** ALTER_POLICY_INFO to RKO_METHOD ***


BEGIN 
        execute immediate  
          'begin  
               bpa.alter_policy_info(''RKO_METHOD'', ''CENTER'' , null, ''E'', ''E'', ''E'');
               bpa.alter_policy_info(''RKO_METHOD'', ''FILIAL'' , null, null, null, null);
               bpa.alter_policy_info(''RKO_METHOD'', ''WHOLE'' , null, ''E'', ''E'', ''E'');
               null;
           end; 
          '; 
END; 
/

PROMPT *** Create  table RKO_METHOD ***
begin 
  execute immediate '
  CREATE TABLE BARS.RKO_METHOD 
   (	ACC NUMBER(22,0), 
	ID_TARIF NUMBER(10,0), 
	ID_RATE NUMBER(10,0)
   ) SEGMENT CREATION DEFERRED 
  PCTFREE 10 PCTUSED 40 INITRANS 1 MAXTRANS 255 
 NOCOMPRESS LOGGING
  TABLESPACE BRSSMLD ';
exception when others then       
  if sqlcode=-955 then null; else raise; end if; 
end; 
/




PROMPT *** ALTER_POLICIES to RKO_METHOD ***
 exec bpa.alter_policies('RKO_METHOD');


COMMENT ON TABLE BARS.RKO_METHOD IS 'РКО. Спосіб зміни';
COMMENT ON COLUMN BARS.RKO_METHOD.ACC IS '';
COMMENT ON COLUMN BARS.RKO_METHOD.ID_TARIF IS 'Спосіб зміни тарифів за договором банківського рахунку';
COMMENT ON COLUMN BARS.RKO_METHOD.ID_RATE IS 'Спосіб зміни процентної ставки за договором банківського рахунку';




PROMPT *** Create  constraint PK_RKOMETHOD ***
begin   
 execute immediate '
  ALTER TABLE BARS.RKO_METHOD ADD CONSTRAINT PK_RKOMETHOD PRIMARY KEY (ACC)
  USING INDEX PCTFREE 10 INITRANS 2 MAXTRANS 255 COMPUTE STATISTICS 
  TABLESPACE BRSSMLD  ENABLE';
exception when others then
  if  sqlcode=-2260 or sqlcode=-2261 or sqlcode=-2264 or sqlcode=-2275 or sqlcode=-1442 then null; else raise; end if;
 end;
/




PROMPT *** Create  constraint CC_RKOMETHOD_ACC_NN ***
begin   
 execute immediate '
  ALTER TABLE BARS.RKO_METHOD MODIFY (ACC CONSTRAINT CC_RKOMETHOD_ACC_NN NOT NULL ENABLE)';
exception when others then
  if  sqlcode=-2260 or sqlcode=-2261 or sqlcode=-2264 or sqlcode=-2275 or sqlcode=-1442 then null; else raise; end if;
 end;
/




PROMPT *** Create  index PK_RKOMETHOD ***
begin   
 execute immediate '
  CREATE UNIQUE INDEX BARS.PK_RKOMETHOD ON BARS.RKO_METHOD (ACC) 
  PCTFREE 10 INITRANS 2 MAXTRANS 255 COMPUTE STATISTICS 
  TABLESPACE BRSSMLD ';
exception when others then
  if  sqlcode=-955  then null; else raise; end if;
 end;
/



PROMPT *** Create  grants  RKO_METHOD ***
grant DELETE,INSERT,SELECT,UPDATE                                            on RKO_METHOD      to BARS_ACCESS_DEFROLE;
grant DELETE,INSERT,SELECT,UPDATE                                            on RKO_METHOD      to CUST001;



PROMPT ===================================================================================== 
PROMPT *** End *** ========== Scripts /Sql/BARS/Table/RKO_METHOD.sql =========*** End *** ==
PROMPT ===================================================================================== 
