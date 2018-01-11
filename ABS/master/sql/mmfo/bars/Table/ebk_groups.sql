

PROMPT ===================================================================================== 
PROMPT *** Run *** ========== Scripts /Sql/BARS/Table/EBK_GROUPS.sql =========*** Run *** ==
PROMPT ===================================================================================== 


PROMPT *** ALTER_POLICY_INFO to EBK_GROUPS ***


BEGIN 
        execute immediate  
          'begin  
               bpa.alter_policy_info(''EBK_GROUPS'', ''CENTER'' , null, null, null, null);
               bpa.alter_policy_info(''EBK_GROUPS'', ''FILIAL'' , null, null, null, null);
               bpa.alter_policy_info(''EBK_GROUPS'', ''WHOLE'' , null, null, null, null);
               null;
           end; 
          '; 
END; 
/

PROMPT *** Create  table EBK_GROUPS ***
begin 
  execute immediate '
  CREATE TABLE BARS.EBK_GROUPS 
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




PROMPT *** ALTER_POLICIES to EBK_GROUPS ***
 exec bpa.alter_policies('EBK_GROUPS');


COMMENT ON TABLE BARS.EBK_GROUPS IS 'Таблица групп клиентов по продуктам';
COMMENT ON COLUMN BARS.EBK_GROUPS.ID IS '';
COMMENT ON COLUMN BARS.EBK_GROUPS.NAME IS '';




PROMPT *** Create  constraint SYS_C0012899 ***
begin   
 execute immediate '
  ALTER TABLE BARS.EBK_GROUPS ADD PRIMARY KEY (ID)
  USING INDEX PCTFREE 10 INITRANS 2 MAXTRANS 255 COMPUTE STATISTICS 
  TABLESPACE BRSDYND  ENABLE';
exception when others then
  if  sqlcode=-2260 or sqlcode=-2261 or sqlcode=-2264 or sqlcode=-2275 or sqlcode=-1442 then null; else raise; end if;
 end;
/




PROMPT *** Create  index SYS_C0012899 ***
begin   
 execute immediate '
  CREATE UNIQUE INDEX BARS.SYS_C0012899 ON BARS.EBK_GROUPS (ID) 
  PCTFREE 10 INITRANS 2 MAXTRANS 255 COMPUTE STATISTICS 
  TABLESPACE BRSDYND ';
exception when others then
  if  sqlcode=-955  then null; else raise; end if;
 end;
/



PROMPT *** Create  grants  EBK_GROUPS ***
grant SELECT                                                                 on EBK_GROUPS      to BARSREADER_ROLE;
grant SELECT                                                                 on EBK_GROUPS      to BARS_ACCESS_DEFROLE;
grant SELECT                                                                 on EBK_GROUPS      to BARS_DM;
grant SELECT                                                                 on EBK_GROUPS      to UPLD;



PROMPT ===================================================================================== 
PROMPT *** End *** ========== Scripts /Sql/BARS/Table/EBK_GROUPS.sql =========*** End *** ==
PROMPT ===================================================================================== 
