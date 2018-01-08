

PROMPT ===================================================================================== 
PROMPT *** Run *** ========== Scripts /Sql/BARS/Table/W4_SPARAM.sql =========*** Run *** ===
PROMPT ===================================================================================== 


PROMPT *** ALTER_POLICY_INFO to W4_SPARAM ***


BEGIN 
        execute immediate  
          'begin  
               bpa.alter_policy_info(''W4_SPARAM'', ''CENTER'' , null, null, null, null);
               bpa.alter_policy_info(''W4_SPARAM'', ''FILIAL'' , null, null, null, null);
               bpa.alter_policy_info(''W4_SPARAM'', ''WHOLE'' , null, null, null, null);
               null;
           end; 
          '; 
END; 
/

PROMPT *** Create  table W4_SPARAM ***
begin 
  execute immediate '
  CREATE TABLE BARS.W4_SPARAM 
   (	GRP_CODE VARCHAR2(32), 
	TIP CHAR(3), 
	NBS CHAR(4), 
	SP_ID NUMBER(22,0), 
	VALUE VARCHAR2(254)
   ) SEGMENT CREATION IMMEDIATE 
  PCTFREE 10 PCTUSED 40 INITRANS 1 MAXTRANS 255 
 NOCOMPRESS LOGGING
  TABLESPACE BRSSMLD ';
exception when others then       
  if sqlcode=-955 then null; else raise; end if; 
end; 
/




PROMPT *** ALTER_POLICIES to W4_SPARAM ***
 exec bpa.alter_policies('W4_SPARAM');


COMMENT ON TABLE BARS.W4_SPARAM IS 'OpenWay. Спецпараметры счетов модуля';
COMMENT ON COLUMN BARS.W4_SPARAM.GRP_CODE IS 'Код группы продуктов';
COMMENT ON COLUMN BARS.W4_SPARAM.TIP IS 'Тип счета';
COMMENT ON COLUMN BARS.W4_SPARAM.NBS IS 'НБС';
COMMENT ON COLUMN BARS.W4_SPARAM.SP_ID IS 'Ид. спецпараметра';
COMMENT ON COLUMN BARS.W4_SPARAM.VALUE IS 'Значение спецпараметра';




PROMPT *** Create  constraint PK_W4SPARAM ***
begin   
 execute immediate '
  ALTER TABLE BARS.W4_SPARAM ADD CONSTRAINT PK_W4SPARAM PRIMARY KEY (GRP_CODE, TIP, NBS, SP_ID)
  USING INDEX PCTFREE 10 INITRANS 2 MAXTRANS 255 COMPUTE STATISTICS 
  TABLESPACE BRSSMLD  ENABLE';
exception when others then
  if  sqlcode=-2260 or sqlcode=-2261 or sqlcode=-2264 or sqlcode=-2275 or sqlcode=-1442 then null; else raise; end if;
 end;
/




PROMPT *** Create  constraint FK_W4SPARAM_W4PRODUCTGROUPS ***
begin   
 execute immediate '
  ALTER TABLE BARS.W4_SPARAM ADD CONSTRAINT FK_W4SPARAM_W4PRODUCTGROUPS FOREIGN KEY (GRP_CODE)
	  REFERENCES BARS.W4_PRODUCT_GROUPS (CODE) ENABLE';
exception when others then
  if  sqlcode=-2260 or sqlcode=-2261 or sqlcode=-2264 or sqlcode=-2275 or sqlcode=-1442 then null; else raise; end if;
 end;
/




PROMPT *** Create  constraint FK_W4SPARAM_SPARAMLIST ***
begin   
 execute immediate '
  ALTER TABLE BARS.W4_SPARAM ADD CONSTRAINT FK_W4SPARAM_SPARAMLIST FOREIGN KEY (SP_ID)
	  REFERENCES BARS.SPARAM_LIST (SPID) ENABLE';
exception when others then
  if  sqlcode=-2260 or sqlcode=-2261 or sqlcode=-2264 or sqlcode=-2275 or sqlcode=-1442 then null; else raise; end if;
 end;
/




PROMPT *** Create  constraint FK_W4SPARAM_PS ***
begin   
 execute immediate '
  ALTER TABLE BARS.W4_SPARAM ADD CONSTRAINT FK_W4SPARAM_PS FOREIGN KEY (NBS)
	  REFERENCES BARS.PS (NBS) ENABLE';
exception when others then
  if  sqlcode=-2260 or sqlcode=-2261 or sqlcode=-2264 or sqlcode=-2275 or sqlcode=-1442 then null; else raise; end if;
 end;
/




PROMPT *** Create  constraint FK_W4SPARAM_TIPS ***
begin   
 execute immediate '
  ALTER TABLE BARS.W4_SPARAM ADD CONSTRAINT FK_W4SPARAM_TIPS FOREIGN KEY (TIP)
	  REFERENCES BARS.TIPS (TIP) ENABLE';
exception when others then
  if  sqlcode=-2260 or sqlcode=-2261 or sqlcode=-2264 or sqlcode=-2275 or sqlcode=-1442 then null; else raise; end if;
 end;
/




PROMPT *** Create  index PK_W4SPARAM ***
begin   
 execute immediate '
  CREATE UNIQUE INDEX BARS.PK_W4SPARAM ON BARS.W4_SPARAM (GRP_CODE, TIP, NBS, SP_ID) 
  PCTFREE 10 INITRANS 2 MAXTRANS 255 COMPUTE STATISTICS 
  TABLESPACE BRSSMLD ';
exception when others then
  if  sqlcode=-955  then null; else raise; end if;
 end;
/



PROMPT *** Create  grants  W4_SPARAM ***
grant DELETE,FLASHBACK,INSERT,SELECT,UPDATE                                  on W4_SPARAM       to BARS_ACCESS_DEFROLE;
grant SELECT                                                                 on W4_SPARAM       to BARS_DM;
grant DELETE,INSERT,SELECT,UPDATE                                            on W4_SPARAM       to OW;
grant FLASHBACK,SELECT                                                       on W4_SPARAM       to WR_REFREAD;



PROMPT ===================================================================================== 
PROMPT *** End *** ========== Scripts /Sql/BARS/Table/W4_SPARAM.sql =========*** End *** ===
PROMPT ===================================================================================== 
