

PROMPT ===================================================================================== 
PROMPT *** Run *** ========== Scripts /Sql/BARS/Table/W4_TIPS.sql =========*** Run *** =====
PROMPT ===================================================================================== 


PROMPT *** ALTER_POLICY_INFO to W4_TIPS ***


BEGIN 
        execute immediate  
          'begin  
               bpa.alter_policy_info(''W4_TIPS'', ''CENTER'' , null, null, null, null);
               bpa.alter_policy_info(''W4_TIPS'', ''FILIAL'' , null, ''E'', ''E'', ''E'');
               bpa.alter_policy_info(''W4_TIPS'', ''WHOLE'' , null, null, null, null);
               null;
           end; 
          '; 
END; 
/

PROMPT *** Create  table W4_TIPS ***
begin 
  execute immediate '
  CREATE TABLE BARS.W4_TIPS 
   (	TIP CHAR(3), 
	TERM_MIN NUMBER(10,0), 
	TERM_MAX NUMBER(10,0)
   ) SEGMENT CREATION IMMEDIATE 
  PCTFREE 10 PCTUSED 40 INITRANS 1 MAXTRANS 255 
 NOCOMPRESS LOGGING
  TABLESPACE BRSSMLD ';
exception when others then       
  if sqlcode=-955 then null; else raise; end if; 
end; 
/




PROMPT *** ALTER_POLICIES to W4_TIPS ***
 exec bpa.alter_policies('W4_TIPS');


COMMENT ON TABLE BARS.W4_TIPS IS 'OW. “ипы Ѕѕ ';
COMMENT ON COLUMN BARS.W4_TIPS.TIP IS '“ип счета';
COMMENT ON COLUMN BARS.W4_TIPS.TERM_MIN IS 'Min кол-во мес€цев действи€ карты';
COMMENT ON COLUMN BARS.W4_TIPS.TERM_MAX IS 'Max кол-во мес€цев действи€ карты';




PROMPT *** Create  constraint CC_W4TIPS_TERMMIN_NN ***
begin   
 execute immediate '
  ALTER TABLE BARS.W4_TIPS ADD CONSTRAINT CC_W4TIPS_TERMMIN_NN CHECK (term_min is not null) ENABLE';
exception when others then
  if  sqlcode=-2260 or sqlcode=-2261 or sqlcode=-2264 or sqlcode=-2275 or sqlcode=-1442 then null; else raise; end if;
 end;
/




PROMPT *** Create  constraint CC_W4TIPS_TERMMAX_NN ***
begin   
 execute immediate '
  ALTER TABLE BARS.W4_TIPS ADD CONSTRAINT CC_W4TIPS_TERMMAX_NN CHECK (term_max is not null) ENABLE';
exception when others then
  if  sqlcode=-2260 or sqlcode=-2261 or sqlcode=-2264 or sqlcode=-2275 or sqlcode=-1442 then null; else raise; end if;
 end;
/




PROMPT *** Create  constraint PK_W4TIPS ***
begin   
 execute immediate '
  ALTER TABLE BARS.W4_TIPS ADD CONSTRAINT PK_W4TIPS PRIMARY KEY (TIP)
  USING INDEX PCTFREE 10 INITRANS 2 MAXTRANS 255 COMPUTE STATISTICS 
  TABLESPACE BRSSMLD  ENABLE';
exception when others then
  if  sqlcode=-2260 or sqlcode=-2261 or sqlcode=-2264 or sqlcode=-2275 or sqlcode=-1442 then null; else raise; end if;
 end;
/




PROMPT *** Create  index PK_W4TIPS ***
begin   
 execute immediate '
  CREATE UNIQUE INDEX BARS.PK_W4TIPS ON BARS.W4_TIPS (TIP) 
  PCTFREE 10 INITRANS 2 MAXTRANS 255 COMPUTE STATISTICS 
  TABLESPACE BRSSMLD ';
exception when others then
  if  sqlcode=-955  then null; else raise; end if;
 end;
/



PROMPT *** Create  grants  W4_TIPS ***
grant SELECT                                                                 on W4_TIPS         to BARSREADER_ROLE;
grant DELETE,INSERT,SELECT,UPDATE                                            on W4_TIPS         to BARS_ACCESS_DEFROLE;
grant SELECT                                                                 on W4_TIPS         to BARS_DM;
grant DELETE,INSERT,SELECT,UPDATE                                            on W4_TIPS         to OW;
grant SELECT                                                                 on W4_TIPS         to UPLD;



PROMPT ===================================================================================== 
PROMPT *** End *** ========== Scripts /Sql/BARS/Table/W4_TIPS.sql =========*** End *** =====
PROMPT ===================================================================================== 
