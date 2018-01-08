

PROMPT ===================================================================================== 
PROMPT *** Run *** ========== Scripts /Sql/BARS/Table/CC_TIPD.sql =========*** Run *** =====
PROMPT ===================================================================================== 


PROMPT *** ALTER_POLICY_INFO to CC_TIPD ***


BEGIN 
        execute immediate  
          'begin  
               bpa.alter_policy_info(''CC_TIPD'', ''CENTER'' , null, null, null, null);
               bpa.alter_policy_info(''CC_TIPD'', ''FILIAL'' , null, ''E'', ''E'', ''E'');
               bpa.alter_policy_info(''CC_TIPD'', ''WHOLE'' , null, null, null, null);
               null;
           end; 
          '; 
END; 
/

PROMPT *** Create  table CC_TIPD ***
begin 
  execute immediate '
  CREATE TABLE BARS.CC_TIPD 
   (	TIPD NUMBER(1,0), 
	NAME VARCHAR2(70)
   ) SEGMENT CREATION IMMEDIATE 
  PCTFREE 10 PCTUSED 40 INITRANS 1 MAXTRANS 255 
 NOCOMPRESS LOGGING
  TABLESPACE BRSSMLD ';
exception when others then       
  if sqlcode=-955 then null; else raise; end if; 
end; 
/




PROMPT *** ALTER_POLICIES to CC_TIPD ***
 exec bpa.alter_policies('CC_TIPD');


COMMENT ON TABLE BARS.CC_TIPD IS 'Типы договоров';
COMMENT ON COLUMN BARS.CC_TIPD.TIPD IS 'Код типа договора
1 - Кредитный, 2 - Депозитный';
COMMENT ON COLUMN BARS.CC_TIPD.NAME IS 'Тип договора';




PROMPT *** Create  constraint PK_CCTIPD ***
begin   
 execute immediate '
  ALTER TABLE BARS.CC_TIPD ADD CONSTRAINT PK_CCTIPD PRIMARY KEY (TIPD)
  USING INDEX PCTFREE 10 INITRANS 2 MAXTRANS 255 COMPUTE STATISTICS 
  TABLESPACE BRSSMLI  ENABLE';
exception when others then
  if  sqlcode=-2260 or sqlcode=-2261 or sqlcode=-2264 or sqlcode=-2275 or sqlcode=-1442 then null; else raise; end if;
 end;
/




PROMPT *** Create  constraint CC_CCTIPD_TIPD_NN ***
begin   
 execute immediate '
  ALTER TABLE BARS.CC_TIPD MODIFY (TIPD CONSTRAINT CC_CCTIPD_TIPD_NN NOT NULL ENABLE)';
exception when others then
  if  sqlcode=-2260 or sqlcode=-2261 or sqlcode=-2264 or sqlcode=-2275 or sqlcode=-1442 then null; else raise; end if;
 end;
/




PROMPT *** Create  constraint CC_CCTIPD_NAME_NN ***
begin   
 execute immediate '
  ALTER TABLE BARS.CC_TIPD MODIFY (NAME CONSTRAINT CC_CCTIPD_NAME_NN NOT NULL ENABLE)';
exception when others then
  if  sqlcode=-2260 or sqlcode=-2261 or sqlcode=-2264 or sqlcode=-2275 or sqlcode=-1442 then null; else raise; end if;
 end;
/




PROMPT *** Create  index PK_CCTIPD ***
begin   
 execute immediate '
  CREATE UNIQUE INDEX BARS.PK_CCTIPD ON BARS.CC_TIPD (TIPD) 
  PCTFREE 10 INITRANS 2 MAXTRANS 255 COMPUTE STATISTICS 
  TABLESPACE BRSSMLI ';
exception when others then
  if  sqlcode=-955  then null; else raise; end if;
 end;
/



PROMPT *** Create  grants  CC_TIPD ***
grant SELECT                                                                 on CC_TIPD         to BARSREADER_ROLE;
grant ALTER,DELETE,FLASHBACK,INSERT,SELECT,UPDATE                            on CC_TIPD         to BARS_ACCESS_DEFROLE;
grant SELECT                                                                 on CC_TIPD         to BARS_DM;
grant DELETE,INSERT,SELECT,UPDATE                                            on CC_TIPD         to CC_TIPD;
grant DELETE,INSERT,SELECT,UPDATE                                            on CC_TIPD         to DPT_ADMIN;
grant ALTER,DELETE,INSERT,SELECT,UPDATE                                      on CC_TIPD         to RCC_DEAL;
grant SELECT                                                                 on CC_TIPD         to UPLD;
grant DELETE,FLASHBACK,INSERT,SELECT,UPDATE                                  on CC_TIPD         to WR_ALL_RIGHTS;
grant FLASHBACK,SELECT                                                       on CC_TIPD         to WR_REFREAD;



PROMPT ===================================================================================== 
PROMPT *** End *** ========== Scripts /Sql/BARS/Table/CC_TIPD.sql =========*** End *** =====
PROMPT ===================================================================================== 
