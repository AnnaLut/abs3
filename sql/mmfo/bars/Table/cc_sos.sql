

PROMPT ===================================================================================== 
PROMPT *** Run *** ========== Scripts /Sql/BARS/Table/CC_SOS.sql =========*** Run *** ======
PROMPT ===================================================================================== 


PROMPT *** ALTER_POLICY_INFO to CC_SOS ***


BEGIN 
        execute immediate  
          'begin  
               bpa.alter_policy_info(''CC_SOS'', ''CENTER'' , null, null, null, null);
               bpa.alter_policy_info(''CC_SOS'', ''FILIAL'' , null, ''E'', ''E'', ''E'');
               bpa.alter_policy_info(''CC_SOS'', ''WHOLE'' , null, null, null, null);
               null;
           end; 
          '; 
END; 
/

PROMPT *** Create  table CC_SOS ***
begin 
  execute immediate '
  CREATE TABLE BARS.CC_SOS 
   (	SOS NUMBER(*,0), 
	NAME VARCHAR2(35)
   ) SEGMENT CREATION IMMEDIATE 
  PCTFREE 10 PCTUSED 40 INITRANS 1 MAXTRANS 255 
 NOCOMPRESS LOGGING
  TABLESPACE BRSSMLD ';
exception when others then       
  if sqlcode=-955 then null; else raise; end if; 
end; 
/




PROMPT *** ALTER_POLICIES to CC_SOS ***
 exec bpa.alter_policies('CC_SOS');


COMMENT ON TABLE BARS.CC_SOS IS 'Состояние заявки на кредит';
COMMENT ON COLUMN BARS.CC_SOS.SOS IS 'Код состояния';
COMMENT ON COLUMN BARS.CC_SOS.NAME IS 'Состояние заявки';




PROMPT *** Create  constraint XPK_CC_SOS ***
begin   
 execute immediate '
  ALTER TABLE BARS.CC_SOS ADD CONSTRAINT XPK_CC_SOS PRIMARY KEY (SOS)
  USING INDEX PCTFREE 10 INITRANS 2 MAXTRANS 255 COMPUTE STATISTICS 
  TABLESPACE BRSSMLI  ENABLE';
exception when others then
  if  sqlcode=-2260 or sqlcode=-2261 or sqlcode=-2264 or sqlcode=-2275 or sqlcode=-1442 then null; else raise; end if;
 end;
/




PROMPT *** Create  constraint NK_CC_SOS_SOS ***
begin   
 execute immediate '
  ALTER TABLE BARS.CC_SOS MODIFY (SOS CONSTRAINT NK_CC_SOS_SOS NOT NULL ENABLE)';
exception when others then
  if  sqlcode=-2260 or sqlcode=-2261 or sqlcode=-2264 or sqlcode=-2275 or sqlcode=-1442 then null; else raise; end if;
 end;
/




PROMPT *** Create  index XPK_CC_SOS ***
begin   
 execute immediate '
  CREATE UNIQUE INDEX BARS.XPK_CC_SOS ON BARS.CC_SOS (SOS) 
  PCTFREE 10 INITRANS 2 MAXTRANS 255 COMPUTE STATISTICS 
  TABLESPACE BRSSMLI ';
exception when others then
  if  sqlcode=-955  then null; else raise; end if;
 end;
/



PROMPT *** Create  grants  CC_SOS ***
grant SELECT                                                                 on CC_SOS          to BARSREADER_ROLE;
grant SELECT                                                                 on CC_SOS          to BARSUPL;
grant ALTER,DELETE,FLASHBACK,INSERT,SELECT,UPDATE                            on CC_SOS          to BARS_ACCESS_DEFROLE;
grant SELECT                                                                 on CC_SOS          to BARS_DM;
grant DELETE,INSERT,SELECT,UPDATE                                            on CC_SOS          to CC_SOS;
grant ALTER,DELETE,INSERT,SELECT,UPDATE                                      on CC_SOS          to RCC_DEAL;
grant SELECT                                                                 on CC_SOS          to UPLD;
grant DELETE,FLASHBACK,INSERT,SELECT,UPDATE                                  on CC_SOS          to WR_ALL_RIGHTS;
grant FLASHBACK,SELECT                                                       on CC_SOS          to WR_REFREAD;



PROMPT ===================================================================================== 
PROMPT *** End *** ========== Scripts /Sql/BARS/Table/CC_SOS.sql =========*** End *** ======
PROMPT ===================================================================================== 
