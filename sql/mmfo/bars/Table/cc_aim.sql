

PROMPT ===================================================================================== 
PROMPT *** Run *** ========== Scripts /Sql/BARS/Table/CC_AIM.sql =========*** Run *** ======
PROMPT ===================================================================================== 


PROMPT *** ALTER_POLICY_INFO to CC_AIM ***


BEGIN 
        execute immediate  
          'begin  
               bpa.alter_policy_info(''CC_AIM'', ''CENTER'' , null, null, null, null);
               bpa.alter_policy_info(''CC_AIM'', ''FILIAL'' , null, ''E'', ''E'', ''E'');
               bpa.alter_policy_info(''CC_AIM'', ''WHOLE'' , null, null, null, null);
               null;
           end; 
          '; 
END; 
/

PROMPT *** Create  table CC_AIM ***
begin 
  execute immediate '
  CREATE TABLE BARS.CC_AIM 
   (	AIM NUMBER(*,0), 
	NAME VARCHAR2(35), 
	NBS CHAR(4), 
	NBS2 CHAR(4), 
	NBSF CHAR(4), 
	NBSF2 CHAR(4), 
	D_CLOSE DATE
   ) SEGMENT CREATION IMMEDIATE 
  PCTFREE 10 PCTUSED 40 INITRANS 1 MAXTRANS 255 
 NOCOMPRESS LOGGING
  TABLESPACE BRSSMLD ';
exception when others then       
  if sqlcode=-955 then null; else raise; end if; 
end; 
/




PROMPT *** ALTER_POLICIES to CC_AIM ***
 exec bpa.alter_policies('CC_AIM');


COMMENT ON TABLE BARS.CC_AIM IS 'Целевое назначение КД и сообв Бал.сч';
COMMENT ON COLUMN BARS.CC_AIM.AIM IS 'Код цели';
COMMENT ON COLUMN BARS.CC_AIM.NAME IS 'Наименование';
COMMENT ON COLUMN BARS.CC_AIM.NBS IS 'БС для ЮЛ - долгосрочн';
COMMENT ON COLUMN BARS.CC_AIM.NBS2 IS '';
COMMENT ON COLUMN BARS.CC_AIM.NBSF IS 'БС для ФЛ - краткосроч';
COMMENT ON COLUMN BARS.CC_AIM.NBSF2 IS 'БС для ФЛ - долгосрочн';
COMMENT ON COLUMN BARS.CC_AIM.D_CLOSE IS '';




PROMPT *** Create  constraint NK_CC_AIM_AIM ***
begin   
 execute immediate '
  ALTER TABLE BARS.CC_AIM MODIFY (AIM CONSTRAINT NK_CC_AIM_AIM NOT NULL ENABLE)';
exception when others then
  if  sqlcode=-2260 or sqlcode=-2261 or sqlcode=-2264 or sqlcode=-2275 or sqlcode=-1442 then null; else raise; end if;
 end;
/




PROMPT *** Create  constraint XPK_CC_AIM ***
begin   
 execute immediate '
  ALTER TABLE BARS.CC_AIM ADD CONSTRAINT XPK_CC_AIM PRIMARY KEY (AIM)
  USING INDEX PCTFREE 10 INITRANS 2 MAXTRANS 255 COMPUTE STATISTICS 
  TABLESPACE BRSSMLI  ENABLE';
exception when others then
  if  sqlcode=-2260 or sqlcode=-2261 or sqlcode=-2264 or sqlcode=-2275 or sqlcode=-1442 then null; else raise; end if;
 end;
/




PROMPT *** Create  index XPK_CC_AIM ***
begin   
 execute immediate '
  CREATE UNIQUE INDEX BARS.XPK_CC_AIM ON BARS.CC_AIM (AIM) 
  PCTFREE 10 INITRANS 2 MAXTRANS 255 COMPUTE STATISTICS 
  TABLESPACE BRSSMLI ';
exception when others then
  if  sqlcode=-955  then null; else raise; end if;
 end;
/



PROMPT *** Create  grants  CC_AIM ***
grant SELECT                                                                 on CC_AIM          to BARSREADER_ROLE;
grant DELETE,FLASHBACK,INSERT,SELECT,UPDATE                                  on CC_AIM          to BARS_ACCESS_DEFROLE;
grant SELECT                                                                 on CC_AIM          to BARS_DM;
grant DELETE,INSERT,SELECT,UPDATE                                            on CC_AIM          to CC_AIM;
grant DELETE,INSERT,SELECT,UPDATE                                            on CC_AIM          to RCC_DEAL;
grant SELECT                                                                 on CC_AIM          to UPLD;
grant DELETE,FLASHBACK,INSERT,SELECT,UPDATE                                  on CC_AIM          to WR_ALL_RIGHTS;
grant SELECT                                                                 on CC_AIM          to WR_CREDIT;
grant FLASHBACK,SELECT                                                       on CC_AIM          to WR_REFREAD;



PROMPT ===================================================================================== 
PROMPT *** End *** ========== Scripts /Sql/BARS/Table/CC_AIM.sql =========*** End *** ======
PROMPT ===================================================================================== 
