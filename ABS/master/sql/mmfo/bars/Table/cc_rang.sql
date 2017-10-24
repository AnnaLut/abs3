

PROMPT ===================================================================================== 
PROMPT *** Run *** ========== Scripts /Sql/BARS/Table/CC_RANG.sql =========*** Run *** =====
PROMPT ===================================================================================== 


PROMPT *** ALTER_POLICY_INFO to CC_RANG ***


BEGIN 
        execute immediate  
          'begin  
               bpa.alter_policy_info(''CC_RANG'', ''CENTER'' , null, null, null, null);
               bpa.alter_policy_info(''CC_RANG'', ''FILIAL'' , null, ''E'', ''E'', ''E'');
               bpa.alter_policy_info(''CC_RANG'', ''WHOLE'' , null, null, null, null);
               null;
           end; 
          '; 
END; 
/

PROMPT *** Create  table CC_RANG ***
begin 
  execute immediate '
  CREATE TABLE BARS.CC_RANG 
   (	TIP CHAR(3), 
	ORD NUMBER(*,0), 
	COMM VARCHAR2(60), 
	RANG NUMBER(*,0) DEFAULT NULL, 
	TYPE_PRIOR NUMBER
   ) SEGMENT CREATION IMMEDIATE 
  PCTFREE 10 PCTUSED 40 INITRANS 1 MAXTRANS 255 
 NOCOMPRESS LOGGING
  TABLESPACE BRSDYND ';
exception when others then       
  if sqlcode=-955 then null; else raise; end if; 
end; 
/




PROMPT *** ALTER_POLICIES to CC_RANG ***
 exec bpa.alter_policies('CC_RANG');


COMMENT ON TABLE BARS.CC_RANG IS 'Очередь задолженностей при гашении кредита';
COMMENT ON COLUMN BARS.CC_RANG.TIP IS 'Вид~залодж.';
COMMENT ON COLUMN BARS.CC_RANG.ORD IS '№ ~п/п';
COMMENT ON COLUMN BARS.CC_RANG.COMM IS '';
COMMENT ON COLUMN BARS.CC_RANG.RANG IS 'Код шаблона для авто разбора счета SG';
COMMENT ON COLUMN BARS.CC_RANG.TYPE_PRIOR IS 'При 1 - приоритет погашения устанавливать сразу  по всем договорам к которым привязан счет гашения';




PROMPT *** Create  constraint FK_CC_RANG_RANG ***
begin   
 execute immediate '
  ALTER TABLE BARS.CC_RANG ADD CONSTRAINT FK_CC_RANG_RANG FOREIGN KEY (RANG)
	  REFERENCES BARS.CC_RANG_NAME (RANG) ENABLE NOVALIDATE';
exception when others then
  if  sqlcode=-2260 or sqlcode=-2261 or sqlcode=-2264 or sqlcode=-2275 or sqlcode=-1442 then null; else raise; end if;
 end;
/




PROMPT *** Create  constraint FK_CC_RANG_TIP ***
begin   
 execute immediate '
  ALTER TABLE BARS.CC_RANG ADD CONSTRAINT FK_CC_RANG_TIP FOREIGN KEY (TIP)
	  REFERENCES BARS.TIPS (TIP) ENABLE';
exception when others then
  if  sqlcode=-2260 or sqlcode=-2261 or sqlcode=-2264 or sqlcode=-2275 or sqlcode=-1442 then null; else raise; end if;
 end;
/




PROMPT *** Create  constraint NK_CC_RANG_TIP ***
begin   
 execute immediate '
  ALTER TABLE BARS.CC_RANG MODIFY (TIP CONSTRAINT NK_CC_RANG_TIP NOT NULL ENABLE)';
exception when others then
  if  sqlcode=-2260 or sqlcode=-2261 or sqlcode=-2264 or sqlcode=-2275 or sqlcode=-1442 then null; else raise; end if;
 end;
/




PROMPT *** Create  constraint NK_CC_RANG_ORD ***
begin   
 execute immediate '
  ALTER TABLE BARS.CC_RANG MODIFY (ORD CONSTRAINT NK_CC_RANG_ORD NOT NULL ENABLE)';
exception when others then
  if  sqlcode=-2260 or sqlcode=-2261 or sqlcode=-2264 or sqlcode=-2275 or sqlcode=-1442 then null; else raise; end if;
 end;
/




PROMPT *** Create  constraint CC_RANG_ID_RANG_NN ***
begin   
 execute immediate '
  ALTER TABLE BARS.CC_RANG MODIFY (RANG CONSTRAINT CC_RANG_ID_RANG_NN NOT NULL ENABLE)';
exception when others then
  if  sqlcode=-2260 or sqlcode=-2261 or sqlcode=-2264 or sqlcode=-2275 or sqlcode=-1442 then null; else raise; end if;
 end;
/




PROMPT *** Create  constraint XPK_CC_RANG ***
begin   
 execute immediate '
  ALTER TABLE BARS.CC_RANG ADD CONSTRAINT XPK_CC_RANG PRIMARY KEY (TIP, RANG)
  USING INDEX PCTFREE 10 INITRANS 2 MAXTRANS 255 COMPUTE STATISTICS 
  TABLESPACE BRSDYND  ENABLE';
exception when others then
  if  sqlcode=-2260 or sqlcode=-2261 or sqlcode=-2264 or sqlcode=-2275 or sqlcode=-1442 then null; else raise; end if;
 end;
/




PROMPT *** Create  index XPK_CC_RANG ***
begin   
 execute immediate '
  CREATE UNIQUE INDEX BARS.XPK_CC_RANG ON BARS.CC_RANG (TIP, RANG) 
  PCTFREE 10 INITRANS 2 MAXTRANS 255 COMPUTE STATISTICS 
  TABLESPACE BRSDYND ';
exception when others then
  if  sqlcode=-955  then null; else raise; end if;
 end;
/



PROMPT *** Create  grants  CC_RANG ***
grant DELETE,FLASHBACK,INSERT,SELECT,UPDATE                                  on CC_RANG         to BARS_ACCESS_DEFROLE;
grant SELECT                                                                 on CC_RANG         to BARS_DM;
grant DELETE,INSERT,SELECT,UPDATE                                            on CC_RANG         to RCC_DEAL;
grant DELETE,FLASHBACK,INSERT,SELECT,UPDATE                                  on CC_RANG         to WR_ALL_RIGHTS;
grant FLASHBACK,SELECT                                                       on CC_RANG         to WR_REFREAD;



PROMPT *** Create SYNONYM  to CC_RANG ***

  CREATE OR REPLACE PUBLIC SYNONYM CC_RANG FOR BARS.CC_RANG;


PROMPT ===================================================================================== 
PROMPT *** End *** ========== Scripts /Sql/BARS/Table/CC_RANG.sql =========*** End *** =====
PROMPT ===================================================================================== 
