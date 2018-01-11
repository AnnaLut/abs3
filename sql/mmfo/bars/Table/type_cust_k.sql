

PROMPT ===================================================================================== 
PROMPT *** Run *** ========== Scripts /Sql/BARS/Table/TYPE_CUST_K.sql =========*** Run *** =
PROMPT ===================================================================================== 


PROMPT *** ALTER_POLICY_INFO to TYPE_CUST_K ***


BEGIN 
        execute immediate  
          'begin  
               bpa.alter_policy_info(''TYPE_CUST_K'', ''CENTER'' , null, null, null, null);
               bpa.alter_policy_info(''TYPE_CUST_K'', ''FILIAL'' , null, null, null, null);
               bpa.alter_policy_info(''TYPE_CUST_K'', ''WHOLE'' , null, null, null, null);
               null;
           end; 
          '; 
END; 
/

PROMPT *** Create  table TYPE_CUST_K ***
begin 
  execute immediate '
  CREATE TABLE BARS.TYPE_CUST_K 
   (	ID NUMBER, 
	NAME VARCHAR2(35)
   ) SEGMENT CREATION IMMEDIATE 
  PCTFREE 10 PCTUSED 0 INITRANS 1 MAXTRANS 255 
 NOCOMPRESS LOGGING
  TABLESPACE BRSDYND ';
exception when others then       
  if sqlcode=-955 then null; else raise; end if; 
end; 
/




PROMPT *** ALTER_POLICIES to TYPE_CUST_K ***
 exec bpa.alter_policies('TYPE_CUST_K');


COMMENT ON TABLE BARS.TYPE_CUST_K IS 'Расширенный Тип клиента';
COMMENT ON COLUMN BARS.TYPE_CUST_K.ID IS 'Код';
COMMENT ON COLUMN BARS.TYPE_CUST_K.NAME IS 'Наименование';




PROMPT *** Create  constraint XPK_TYPE_CUST_K ***
begin   
 execute immediate '
  ALTER TABLE BARS.TYPE_CUST_K ADD CONSTRAINT XPK_TYPE_CUST_K PRIMARY KEY (ID)
  USING INDEX PCTFREE 10 INITRANS 2 MAXTRANS 255 COMPUTE STATISTICS 
  TABLESPACE BRSDYNI  ENABLE';
exception when others then
  if  sqlcode=-2260 or sqlcode=-2261 or sqlcode=-2264 or sqlcode=-2275 or sqlcode=-1442 then null; else raise; end if;
 end;
/




PROMPT *** Create  constraint NK_TYPE_CUST_K_ID ***
begin   
 execute immediate '
  ALTER TABLE BARS.TYPE_CUST_K MODIFY (ID CONSTRAINT NK_TYPE_CUST_K_ID NOT NULL ENABLE)';
exception when others then
  if  sqlcode=-2260 or sqlcode=-2261 or sqlcode=-2264 or sqlcode=-2275 or sqlcode=-1442 then null; else raise; end if;
 end;
/




PROMPT *** Create  index XPK_TYPE_CUST_K ***
begin   
 execute immediate '
  CREATE UNIQUE INDEX BARS.XPK_TYPE_CUST_K ON BARS.TYPE_CUST_K (ID) 
  PCTFREE 10 INITRANS 2 MAXTRANS 255 COMPUTE STATISTICS 
  TABLESPACE BRSDYNI ';
exception when others then
  if  sqlcode=-955  then null; else raise; end if;
 end;
/



PROMPT *** Create  grants  TYPE_CUST_K ***
grant SELECT                                                                 on TYPE_CUST_K     to BARSREADER_ROLE;
grant DELETE,FLASHBACK,INSERT,SELECT,UPDATE                                  on TYPE_CUST_K     to BARS_ACCESS_DEFROLE;
grant SELECT                                                                 on TYPE_CUST_K     to BARS_DM;
grant DELETE,INSERT,SELECT,UPDATE                                            on TYPE_CUST_K     to CC_AIM;
grant DELETE,INSERT,SELECT,UPDATE                                            on TYPE_CUST_K     to RCC_DEAL;
grant SELECT                                                                 on TYPE_CUST_K     to UPLD;
grant FLASHBACK,SELECT                                                       on TYPE_CUST_K     to WR_REFREAD;



PROMPT ===================================================================================== 
PROMPT *** End *** ========== Scripts /Sql/BARS/Table/TYPE_CUST_K.sql =========*** End *** =
PROMPT ===================================================================================== 
