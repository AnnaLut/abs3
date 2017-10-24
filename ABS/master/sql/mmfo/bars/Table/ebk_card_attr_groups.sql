

PROMPT ===================================================================================== 
PROMPT *** Run *** ========== Scripts /Sql/BARS/Table/EBK_CARD_ATTR_GROUPS.sql =========*** 
PROMPT ===================================================================================== 


PROMPT *** ALTER_POLICY_INFO to EBK_CARD_ATTR_GROUPS ***


BEGIN 
        execute immediate  
          'begin  
               bpa.alter_policy_info(''EBK_CARD_ATTR_GROUPS'', ''CENTER'' , null, null, null, null);
               bpa.alter_policy_info(''EBK_CARD_ATTR_GROUPS'', ''FILIAL'' , null, null, null, null);
               bpa.alter_policy_info(''EBK_CARD_ATTR_GROUPS'', ''WHOLE'' , null, null, null, null);
               null;
           end; 
          '; 
END; 
/

PROMPT *** Create  table EBK_CARD_ATTR_GROUPS ***
begin 
  execute immediate '
  CREATE TABLE BARS.EBK_CARD_ATTR_GROUPS 
   (	ID NUMBER(1,0), 
	NAME VARCHAR2(50)
   ) SEGMENT CREATION IMMEDIATE 
  PCTFREE 10 PCTUSED 40 INITRANS 1 MAXTRANS 255 
 NOCOMPRESS LOGGING
  TABLESPACE BRSDYND ';
exception when others then       
  if sqlcode=-955 then null; else raise; end if; 
end; 
/




PROMPT *** ALTER_POLICIES to EBK_CARD_ATTR_GROUPS ***
 exec bpa.alter_policies('EBK_CARD_ATTR_GROUPS');


COMMENT ON TABLE BARS.EBK_CARD_ATTR_GROUPS IS 'Таблица групп реквизитов клиента';
COMMENT ON COLUMN BARS.EBK_CARD_ATTR_GROUPS.ID IS '';
COMMENT ON COLUMN BARS.EBK_CARD_ATTR_GROUPS.NAME IS '';




PROMPT *** Create  constraint SYS_C0012078 ***
begin   
 execute immediate '
  ALTER TABLE BARS.EBK_CARD_ATTR_GROUPS ADD PRIMARY KEY (ID)
  USING INDEX PCTFREE 10 INITRANS 2 MAXTRANS 255 COMPUTE STATISTICS 
  TABLESPACE BRSDYND  ENABLE';
exception when others then
  if  sqlcode=-2260 or sqlcode=-2261 or sqlcode=-2264 or sqlcode=-2275 or sqlcode=-1442 then null; else raise; end if;
 end;
/




PROMPT *** Create  index SYS_C0012078 ***
begin   
 execute immediate '
  CREATE UNIQUE INDEX BARS.SYS_C0012078 ON BARS.EBK_CARD_ATTR_GROUPS (ID) 
  PCTFREE 10 INITRANS 2 MAXTRANS 255 COMPUTE STATISTICS 
  TABLESPACE BRSDYND ';
exception when others then
  if  sqlcode=-955  then null; else raise; end if;
 end;
/



PROMPT *** Create  grants  EBK_CARD_ATTR_GROUPS ***
grant DELETE,INSERT,SELECT,UPDATE                                            on EBK_CARD_ATTR_GROUPS to BARS_ACCESS_DEFROLE;
grant SELECT                                                                 on EBK_CARD_ATTR_GROUPS to BARS_DM;



PROMPT ===================================================================================== 
PROMPT *** End *** ========== Scripts /Sql/BARS/Table/EBK_CARD_ATTR_GROUPS.sql =========*** 
PROMPT ===================================================================================== 
