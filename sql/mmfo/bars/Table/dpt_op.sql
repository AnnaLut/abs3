

PROMPT ===================================================================================== 
PROMPT *** Run *** ========== Scripts /Sql/BARS/Table/DPT_OP.sql =========*** Run *** ======
PROMPT ===================================================================================== 


PROMPT *** ALTER_POLICY_INFO to DPT_OP ***


BEGIN 
        execute immediate  
          'begin  
               bpa.alter_policy_info(''DPT_OP'', ''CENTER'' , null, null, null, null);
               bpa.alter_policy_info(''DPT_OP'', ''FILIAL'' , null, ''E'', ''E'', ''E'');
               bpa.alter_policy_info(''DPT_OP'', ''WHOLE'' , null, null, null, null);
               null;
           end; 
          '; 
END; 
/

PROMPT *** Create  table DPT_OP ***
begin 
  execute immediate '
  CREATE TABLE BARS.DPT_OP 
   (	ID NUMBER(38,0), 
	NAME VARCHAR2(40)
   ) SEGMENT CREATION IMMEDIATE 
  PCTFREE 10 PCTUSED 40 INITRANS 1 MAXTRANS 255 
 NOCOMPRESS LOGGING
  TABLESPACE BRSSMLD ';
exception when others then       
  if sqlcode=-955 then null; else raise; end if; 
end; 
/




PROMPT *** ALTER_POLICIES to DPT_OP ***
 exec bpa.alter_policies('DPT_OP');


COMMENT ON TABLE BARS.DPT_OP IS 'Операции с депозитными договорами';
COMMENT ON COLUMN BARS.DPT_OP.ID IS '№ п/п';
COMMENT ON COLUMN BARS.DPT_OP.NAME IS 'Наименование операции';




PROMPT *** Create  constraint CC_DPTOP_ID_NN ***
begin   
 execute immediate '
  ALTER TABLE BARS.DPT_OP MODIFY (ID CONSTRAINT CC_DPTOP_ID_NN NOT NULL ENABLE)';
exception when others then
  if  sqlcode=-2260 or sqlcode=-2261 or sqlcode=-2264 or sqlcode=-2275 or sqlcode=-1442 then null; else raise; end if;
 end;
/




PROMPT *** Create  constraint CC_DPTOP_NAME_NN ***
begin   
 execute immediate '
  ALTER TABLE BARS.DPT_OP MODIFY (NAME CONSTRAINT CC_DPTOP_NAME_NN NOT NULL ENABLE)';
exception when others then
  if  sqlcode=-2260 or sqlcode=-2261 or sqlcode=-2264 or sqlcode=-2275 or sqlcode=-1442 then null; else raise; end if;
 end;
/




PROMPT *** Create  constraint PK_DPTOP ***
begin   
 execute immediate '
  ALTER TABLE BARS.DPT_OP ADD CONSTRAINT PK_DPTOP PRIMARY KEY (ID)
  USING INDEX PCTFREE 10 INITRANS 2 MAXTRANS 255 COMPUTE STATISTICS 
  TABLESPACE BRSSMLI  ENABLE';
exception when others then
  if  sqlcode=-2260 or sqlcode=-2261 or sqlcode=-2264 or sqlcode=-2275 or sqlcode=-1442 then null; else raise; end if;
 end;
/




PROMPT *** Create  index PK_DPTOP ***
begin   
 execute immediate '
  CREATE UNIQUE INDEX BARS.PK_DPTOP ON BARS.DPT_OP (ID) 
  PCTFREE 10 INITRANS 2 MAXTRANS 255 COMPUTE STATISTICS 
  TABLESPACE BRSSMLI ';
exception when others then
  if  sqlcode=-955  then null; else raise; end if;
 end;
/



PROMPT *** Create  grants  DPT_OP ***
grant DELETE,INSERT,SELECT,UPDATE                                            on DPT_OP          to ABS_ADMIN;
grant DELETE,FLASHBACK,INSERT,SELECT,UPDATE                                  on DPT_OP          to BARS_ACCESS_DEFROLE;
grant SELECT                                                                 on DPT_OP          to BARS_DM;
grant SELECT                                                                 on DPT_OP          to DPT;
grant DELETE,INSERT,SELECT,UPDATE                                            on DPT_OP          to DPT_ADMIN;
grant SELECT                                                                 on DPT_OP          to KLBX;
grant SELECT                                                                 on DPT_OP          to START1;
grant DELETE,INSERT,SELECT,UPDATE                                            on DPT_OP          to VKLAD;
grant DELETE,FLASHBACK,INSERT,SELECT,UPDATE                                  on DPT_OP          to WR_ALL_RIGHTS;
grant FLASHBACK,SELECT                                                       on DPT_OP          to WR_REFREAD;



PROMPT ===================================================================================== 
PROMPT *** End *** ========== Scripts /Sql/BARS/Table/DPT_OP.sql =========*** End *** ======
PROMPT ===================================================================================== 
