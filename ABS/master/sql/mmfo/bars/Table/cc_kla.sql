

PROMPT ===================================================================================== 
PROMPT *** Run *** ========== Scripts /Sql/BARS/Table/CC_KLA.sql =========*** Run *** ======
PROMPT ===================================================================================== 


PROMPT *** ALTER_POLICY_INFO to CC_KLA ***


BEGIN 
        execute immediate  
          'begin  
               bpa.alter_policy_info(''CC_KLA'', ''CENTER'' , null, null, null, null);
               bpa.alter_policy_info(''CC_KLA'', ''FILIAL'' , null, ''E'', ''E'', ''E'');
               bpa.alter_policy_info(''CC_KLA'', ''WHOLE'' , null, null, null, null);
               null;
           end; 
          '; 
END; 
/

PROMPT *** Create  table CC_KLA ***
begin 
  execute immediate '
  CREATE TABLE BARS.CC_KLA 
   (	ID NUMBER(*,0), 
	NAME VARCHAR2(35), 
	VIDD NUMBER(*,0)
   ) SEGMENT CREATION IMMEDIATE 
  PCTFREE 10 PCTUSED 40 INITRANS 1 MAXTRANS 255 
 NOCOMPRESS LOGGING
  TABLESPACE BRSSMLD ';
exception when others then       
  if sqlcode=-955 then null; else raise; end if; 
end; 
/




PROMPT *** ALTER_POLICIES to CC_KLA ***
 exec bpa.alter_policies('CC_KLA');


COMMENT ON TABLE BARS.CC_KLA IS 'Классификация заявок на кредит';
COMMENT ON COLUMN BARS.CC_KLA.ID IS 'Код';
COMMENT ON COLUMN BARS.CC_KLA.NAME IS 'Наименование';
COMMENT ON COLUMN BARS.CC_KLA.VIDD IS 'Вид дог.по КП';




PROMPT *** Create  constraint FK_CC_KLA_VIDD ***
begin   
 execute immediate '
  ALTER TABLE BARS.CC_KLA ADD CONSTRAINT FK_CC_KLA_VIDD FOREIGN KEY (VIDD)
	  REFERENCES BARS.CC_VIDD (VIDD) ENABLE';
exception when others then
  if  sqlcode=-2260 or sqlcode=-2261 or sqlcode=-2264 or sqlcode=-2275 or sqlcode=-1442 then null; else raise; end if;
 end;
/




PROMPT *** Create  constraint XPK_CC_KLA ***
begin   
 execute immediate '
  ALTER TABLE BARS.CC_KLA ADD CONSTRAINT XPK_CC_KLA PRIMARY KEY (ID)
  USING INDEX PCTFREE 10 INITRANS 2 MAXTRANS 255 COMPUTE STATISTICS 
  TABLESPACE BRSSMLI  ENABLE';
exception when others then
  if  sqlcode=-2260 or sqlcode=-2261 or sqlcode=-2264 or sqlcode=-2275 or sqlcode=-1442 then null; else raise; end if;
 end;
/




PROMPT *** Create  index XPK_CC_KLA ***
begin   
 execute immediate '
  CREATE UNIQUE INDEX BARS.XPK_CC_KLA ON BARS.CC_KLA (ID) 
  PCTFREE 10 INITRANS 2 MAXTRANS 255 COMPUTE STATISTICS 
  TABLESPACE BRSSMLI ';
exception when others then
  if  sqlcode=-955  then null; else raise; end if;
 end;
/



PROMPT *** Create  grants  CC_KLA ***
grant DELETE,FLASHBACK,INSERT,SELECT,UPDATE                                  on CC_KLA          to BARS_ACCESS_DEFROLE;
grant SELECT                                                                 on CC_KLA          to BARS_DM;
grant DELETE,INSERT,SELECT,UPDATE                                            on CC_KLA          to RCC_DEAL;
grant DELETE,FLASHBACK,INSERT,SELECT,UPDATE                                  on CC_KLA          to WR_ALL_RIGHTS;
grant FLASHBACK,SELECT                                                       on CC_KLA          to WR_REFREAD;



PROMPT ===================================================================================== 
PROMPT *** End *** ========== Scripts /Sql/BARS/Table/CC_KLA.sql =========*** End *** ======
PROMPT ===================================================================================== 
