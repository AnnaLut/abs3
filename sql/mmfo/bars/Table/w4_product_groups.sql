

PROMPT ===================================================================================== 
PROMPT *** Run *** ========== Scripts /Sql/BARS/Table/W4_PRODUCT_GROUPS.sql =========*** Run
PROMPT ===================================================================================== 


PROMPT *** ALTER_POLICY_INFO to W4_PRODUCT_GROUPS ***


BEGIN 
        execute immediate  
          'begin  
               bpa.alter_policy_info(''W4_PRODUCT_GROUPS'', ''CENTER'' , null, null, null, null);
               bpa.alter_policy_info(''W4_PRODUCT_GROUPS'', ''FILIAL'' , null, ''E'', ''E'', ''E'');
               bpa.alter_policy_info(''W4_PRODUCT_GROUPS'', ''WHOLE'' , null, null, null, null);
               null;
           end; 
          '; 
END; 
/

PROMPT *** Create  table W4_PRODUCT_GROUPS ***
begin 
  execute immediate '
  CREATE TABLE BARS.W4_PRODUCT_GROUPS 
   (	CODE VARCHAR2(32), 
	NAME VARCHAR2(100), 
	SCHEME_ID NUMBER(22,0), 
	DATE_OPEN DATE, 
	DATE_CLOSE DATE, 
	CLIENT_TYPE NUMBER(1,0)
   ) SEGMENT CREATION IMMEDIATE 
  PCTFREE 10 PCTUSED 40 INITRANS 1 MAXTRANS 255 
 NOCOMPRESS LOGGING
  TABLESPACE BRSSMLD ';
exception when others then       
  if sqlcode=-955 then null; else raise; end if; 
end; 
/




PROMPT *** ALTER_POLICIES to W4_PRODUCT_GROUPS ***
 exec bpa.alter_policies('W4_PRODUCT_GROUPS');


COMMENT ON TABLE BARS.W4_PRODUCT_GROUPS IS 'W4. Справочник групп продуктов';
COMMENT ON COLUMN BARS.W4_PRODUCT_GROUPS.CODE IS 'Код группы продуктов';
COMMENT ON COLUMN BARS.W4_PRODUCT_GROUPS.NAME IS 'Наименование';
COMMENT ON COLUMN BARS.W4_PRODUCT_GROUPS.SCHEME_ID IS 'Код схемы счетов';
COMMENT ON COLUMN BARS.W4_PRODUCT_GROUPS.DATE_OPEN IS 'Дата начала действия группы продуктов';
COMMENT ON COLUMN BARS.W4_PRODUCT_GROUPS.DATE_CLOSE IS 'Дата окончания действия группы подуктов';
COMMENT ON COLUMN BARS.W4_PRODUCT_GROUPS.CLIENT_TYPE IS '';




PROMPT *** Create  constraint FK_W4PRODUCTGROUPS_BPKSCHEME ***
begin   
 execute immediate '
  ALTER TABLE BARS.W4_PRODUCT_GROUPS ADD CONSTRAINT FK_W4PRODUCTGROUPS_BPKSCHEME FOREIGN KEY (SCHEME_ID)
	  REFERENCES BARS.BPK_SCHEME (ID) ENABLE';
exception when others then
  if  sqlcode=-2260 or sqlcode=-2261 or sqlcode=-2264 or sqlcode=-2275 or sqlcode=-1442 then null; else raise; end if;
 end;
/




PROMPT *** Create  constraint CC_W4PRODUCTGROUPS_CLIENTTYPE ***
begin   
 execute immediate '
  ALTER TABLE BARS.W4_PRODUCT_GROUPS ADD CONSTRAINT CC_W4PRODUCTGROUPS_CLIENTTYPE CHECK (client_type in (1,2)) ENABLE NOVALIDATE';
exception when others then
  if  sqlcode=-2260 or sqlcode=-2261 or sqlcode=-2264 or sqlcode=-2275 or sqlcode=-1442 then null; else raise; end if;
 end;
/




PROMPT *** Create  constraint PK_W4PRODUCTGROUPS ***
begin   
 execute immediate '
  ALTER TABLE BARS.W4_PRODUCT_GROUPS ADD CONSTRAINT PK_W4PRODUCTGROUPS PRIMARY KEY (CODE)
  USING INDEX PCTFREE 10 INITRANS 2 MAXTRANS 255 COMPUTE STATISTICS 
  TABLESPACE BRSSMLI  ENABLE';
exception when others then
  if  sqlcode=-2260 or sqlcode=-2261 or sqlcode=-2264 or sqlcode=-2275 or sqlcode=-1442 then null; else raise; end if;
 end;
/




PROMPT *** Create  constraint CC_W4PRODUCTGROUPS_CODE_NN ***
begin   
 execute immediate '
  ALTER TABLE BARS.W4_PRODUCT_GROUPS MODIFY (CODE CONSTRAINT CC_W4PRODUCTGROUPS_CODE_NN NOT NULL ENABLE NOVALIDATE)';
exception when others then
  if  sqlcode=-2260 or sqlcode=-2261 or sqlcode=-2264 or sqlcode=-2275 or sqlcode=-1442 then null; else raise; end if;
 end;
/




PROMPT *** Create  constraint CC_W4PRODUCTGROUPS_CTYPE_NN ***
begin   
 execute immediate '
  ALTER TABLE BARS.W4_PRODUCT_GROUPS MODIFY (CLIENT_TYPE CONSTRAINT CC_W4PRODUCTGROUPS_CTYPE_NN NOT NULL ENABLE NOVALIDATE)';
exception when others then
  if  sqlcode=-2260 or sqlcode=-2261 or sqlcode=-2264 or sqlcode=-2275 or sqlcode=-1442 then null; else raise; end if;
 end;
/




PROMPT *** Create  index PK_W4PRODUCTGROUPS ***
begin   
 execute immediate '
  CREATE UNIQUE INDEX BARS.PK_W4PRODUCTGROUPS ON BARS.W4_PRODUCT_GROUPS (CODE) 
  PCTFREE 10 INITRANS 2 MAXTRANS 255 COMPUTE STATISTICS 
  TABLESPACE BRSSMLI ';
exception when others then
  if  sqlcode=-955  then null; else raise; end if;
 end;
/



PROMPT *** Create  grants  W4_PRODUCT_GROUPS ***
grant SELECT                                                                 on W4_PRODUCT_GROUPS to BARSUPL;
grant DELETE,FLASHBACK,INSERT,SELECT,UPDATE                                  on W4_PRODUCT_GROUPS to BARS_ACCESS_DEFROLE;
grant SELECT                                                                 on W4_PRODUCT_GROUPS to BARS_DM;
grant DELETE,INSERT,SELECT,UPDATE                                            on W4_PRODUCT_GROUPS to OW;
grant SELECT                                                                 on W4_PRODUCT_GROUPS to UPLD;
grant FLASHBACK,SELECT                                                       on W4_PRODUCT_GROUPS to WR_REFREAD;



PROMPT ===================================================================================== 
PROMPT *** End *** ========== Scripts /Sql/BARS/Table/W4_PRODUCT_GROUPS.sql =========*** End
PROMPT ===================================================================================== 
