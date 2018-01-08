

PROMPT ===================================================================================== 
PROMPT *** Run *** ========== Scripts /Sql/BARS/Table/INT_USER.sql =========*** Run *** ====
PROMPT ===================================================================================== 


PROMPT *** ALTER_POLICY_INFO to INT_USER ***


BEGIN 
        execute immediate  
          'begin  
               bpa.alter_policy_info(''INT_USER'', ''CENTER'' , null, null, null, null);
               bpa.alter_policy_info(''INT_USER'', ''FILIAL'' , null, null, null, null);
               bpa.alter_policy_info(''INT_USER'', ''WHOLE'' , null, null, null, null);
               null;
           end; 
          '; 
END; 
/

PROMPT *** Create  table INT_USER ***
begin 
  execute immediate '
  CREATE TABLE BARS.INT_USER 
   (	USERID NUMBER(38,0), 
	PROCMAN NUMBER(38,0), 
	KV NUMBER(1,0), 
	ORD NUMBER(5,0)
   ) SEGMENT CREATION IMMEDIATE 
  PCTFREE 10 PCTUSED 40 INITRANS 1 MAXTRANS 255 
 NOCOMPRESS LOGGING
  TABLESPACE BRSSMLD ';
exception when others then       
  if sqlcode=-955 then null; else raise; end if; 
end; 
/




PROMPT *** ALTER_POLICIES to INT_USER ***
 exec bpa.alter_policies('INT_USER');


COMMENT ON TABLE BARS.INT_USER IS 'Исполнитель по нач %% <-> Распорядитель';
COMMENT ON COLUMN BARS.INT_USER.USERID IS 'Код исполнителя';
COMMENT ON COLUMN BARS.INT_USER.PROCMAN IS 'Код распорядителя';
COMMENT ON COLUMN BARS.INT_USER.KV IS 'Признак вал ~0-грн~1-вал';
COMMENT ON COLUMN BARS.INT_USER.ORD IS '';




PROMPT *** Create  constraint PK_INTUSER ***
begin   
 execute immediate '
  ALTER TABLE BARS.INT_USER ADD CONSTRAINT PK_INTUSER PRIMARY KEY (USERID, PROCMAN, KV)
  USING INDEX PCTFREE 10 INITRANS 2 MAXTRANS 255 COMPUTE STATISTICS 
  TABLESPACE BRSSMLI  ENABLE';
exception when others then
  if  sqlcode=-2260 or sqlcode=-2261 or sqlcode=-2264 or sqlcode=-2275 or sqlcode=-1442 then null; else raise; end if;
 end;
/




PROMPT *** Create  constraint CC_INTUSER_USERID_NN ***
begin   
 execute immediate '
  ALTER TABLE BARS.INT_USER MODIFY (USERID CONSTRAINT CC_INTUSER_USERID_NN NOT NULL ENABLE)';
exception when others then
  if  sqlcode=-2260 or sqlcode=-2261 or sqlcode=-2264 or sqlcode=-2275 or sqlcode=-1442 then null; else raise; end if;
 end;
/




PROMPT *** Create  constraint CC_INTUSER_PROCMAN_NN ***
begin   
 execute immediate '
  ALTER TABLE BARS.INT_USER MODIFY (PROCMAN CONSTRAINT CC_INTUSER_PROCMAN_NN NOT NULL ENABLE)';
exception when others then
  if  sqlcode=-2260 or sqlcode=-2261 or sqlcode=-2264 or sqlcode=-2275 or sqlcode=-1442 then null; else raise; end if;
 end;
/




PROMPT *** Create  constraint CC_INTUSER_ORD_NN ***
begin   
 execute immediate '
  ALTER TABLE BARS.INT_USER MODIFY (ORD CONSTRAINT CC_INTUSER_ORD_NN NOT NULL ENABLE)';
exception when others then
  if  sqlcode=-2260 or sqlcode=-2261 or sqlcode=-2264 or sqlcode=-2275 or sqlcode=-1442 then null; else raise; end if;
 end;
/




PROMPT *** Create  index PK_INTUSER ***
begin   
 execute immediate '
  CREATE UNIQUE INDEX BARS.PK_INTUSER ON BARS.INT_USER (USERID, PROCMAN, KV) 
  PCTFREE 10 INITRANS 2 MAXTRANS 255 COMPUTE STATISTICS 
  TABLESPACE BRSSMLI ';
exception when others then
  if  sqlcode=-955  then null; else raise; end if;
 end;
/



PROMPT *** Create  grants  INT_USER ***
grant DELETE,INSERT,SELECT,UPDATE                                            on INT_USER        to ABS_ADMIN;
grant SELECT                                                                 on INT_USER        to BARS010;
grant SELECT                                                                 on INT_USER        to BARSREADER_ROLE;
grant DELETE,FLASHBACK,INSERT,SELECT,UPDATE                                  on INT_USER        to BARS_ACCESS_DEFROLE;
grant SELECT                                                                 on INT_USER        to BARS_DM;
grant DELETE,INSERT,SELECT,UPDATE                                            on INT_USER        to DPT_ADMIN;
grant SELECT                                                                 on INT_USER        to FOREX;
grant DELETE,INSERT,SELECT,UPDATE                                            on INT_USER        to INT_USER;
grant SELECT                                                                 on INT_USER        to RPBN001;
grant SELECT                                                                 on INT_USER        to START1;
grant SELECT                                                                 on INT_USER        to UPLD;
grant SELECT                                                                 on INT_USER        to WR_ACRINT;
grant DELETE,FLASHBACK,INSERT,SELECT,UPDATE                                  on INT_USER        to WR_ALL_RIGHTS;
grant FLASHBACK,SELECT                                                       on INT_USER        to WR_REFREAD;



PROMPT ===================================================================================== 
PROMPT *** End *** ========== Scripts /Sql/BARS/Table/INT_USER.sql =========*** End *** ====
PROMPT ===================================================================================== 
