

PROMPT ===================================================================================== 
PROMPT *** Run *** ========== Scripts /Sql/BARS/Table/BPK_PROECT.sql =========*** Run *** ==
PROMPT ===================================================================================== 


PROMPT *** ALTER_POLICY_INFO to BPK_PROECT ***


BEGIN 
        execute immediate  
          'begin  
               bpa.alter_policy_info(''BPK_PROECT'', ''FILIAL'' , null, null, null, null);
               bpa.alter_policy_info(''BPK_PROECT'', ''WHOLE'' , null, null, null, null);
               null;
           end; 
          '; 
END; 
/

PROMPT *** Create  table BPK_PROECT ***
begin 
  execute immediate '
  CREATE TABLE BARS.BPK_PROECT 
   (	ID NUMBER(22,0), 
	NAME VARCHAR2(100), 
	OKPO VARCHAR2(10), 
	PRODUCT_CODE VARCHAR2(30), 
	OKPO_N NUMBER(22,0), 
	USED_W4 NUMBER(22,0), 
	ID_CM NUMBER
   ) SEGMENT CREATION IMMEDIATE 
  PCTFREE 10 PCTUSED 40 INITRANS 1 MAXTRANS 255 
 NOCOMPRESS LOGGING
  TABLESPACE BRSSMLD ';
exception when others then       
  if sqlcode=-955 then null; else raise; end if; 
end; 
/




PROMPT *** ALTER_POLICIES to BPK_PROECT ***
 exec bpa.alter_policies('BPK_PROECT');


COMMENT ON TABLE BARS.BPK_PROECT IS '';
COMMENT ON COLUMN BARS.BPK_PROECT.PRODUCT_CODE IS '';
COMMENT ON COLUMN BARS.BPK_PROECT.OKPO_N IS 'Код системной организациим';
COMMENT ON COLUMN BARS.BPK_PROECT.USED_W4 IS 'Используется для Way4';
COMMENT ON COLUMN BARS.BPK_PROECT.ID_CM IS '';
COMMENT ON COLUMN BARS.BPK_PROECT.ID IS '';
COMMENT ON COLUMN BARS.BPK_PROECT.NAME IS '';
COMMENT ON COLUMN BARS.BPK_PROECT.OKPO IS '';




PROMPT *** Create  constraint FK_BPK_PROECT_W4PRODUC ***
begin   
 execute immediate '
  ALTER TABLE BARS.BPK_PROECT ADD CONSTRAINT FK_BPK_PROECT_W4PRODUC FOREIGN KEY (PRODUCT_CODE)
	  REFERENCES BARS.W4_PRODUCT (CODE) ENABLE';
exception when others then
  if  sqlcode=-2260 or sqlcode=-2261 or sqlcode=-2264 or sqlcode=-2275 or sqlcode=-1442 then null; else raise; end if;
 end;
/




PROMPT *** Create  constraint PK_BPKPROECT ***
begin   
 execute immediate '
  ALTER TABLE BARS.BPK_PROECT ADD CONSTRAINT PK_BPKPROECT PRIMARY KEY (ID)
  USING INDEX PCTFREE 10 INITRANS 2 MAXTRANS 255 COMPUTE STATISTICS 
  TABLESPACE BRSSMLI  ENABLE';
exception when others then
  if  sqlcode=-2260 or sqlcode=-2261 or sqlcode=-2264 or sqlcode=-2275 or sqlcode=-1442 then null; else raise; end if;
 end;
/




PROMPT *** Create  constraint CC_BPKPROECT_ID_NN ***
begin   
 execute immediate '
  ALTER TABLE BARS.BPK_PROECT MODIFY (ID CONSTRAINT CC_BPKPROECT_ID_NN NOT NULL ENABLE)';
exception when others then
  if  sqlcode=-2260 or sqlcode=-2261 or sqlcode=-2264 or sqlcode=-2275 or sqlcode=-1442 then null; else raise; end if;
 end;
/




PROMPT *** Create  index PK_BPKPROECT ***
begin   
 execute immediate '
  CREATE UNIQUE INDEX BARS.PK_BPKPROECT ON BARS.BPK_PROECT (ID) 
  PCTFREE 10 INITRANS 2 MAXTRANS 255 COMPUTE STATISTICS 
  TABLESPACE BRSSMLI ';
exception when others then
  if  sqlcode=-955  then null; else raise; end if;
 end;
/



PROMPT *** Create  grants  BPK_PROECT ***
grant DELETE,FLASHBACK,INSERT,SELECT,UPDATE                                  on BPK_PROECT      to BARS_ACCESS_DEFROLE;
grant SELECT                                                                 on BPK_PROECT      to BARS_DM;
grant DELETE,INSERT,SELECT,UPDATE                                            on BPK_PROECT      to CUST001;
grant DELETE,INSERT,SELECT,UPDATE                                            on BPK_PROECT      to OBPC;
grant DELETE,INSERT,SELECT,UPDATE                                            on BPK_PROECT      to OW;
grant FLASHBACK,SELECT                                                       on BPK_PROECT      to WR_REFREAD;



PROMPT ===================================================================================== 
PROMPT *** End *** ========== Scripts /Sql/BARS/Table/BPK_PROECT.sql =========*** End *** ==
PROMPT ===================================================================================== 
