

PROMPT ===================================================================================== 
PROMPT *** Run *** ========== Scripts /Sql/BARS/Table/CP_ACCTYPES.sql =========*** Run *** =
PROMPT ===================================================================================== 


PROMPT *** ALTER_POLICY_INFO to CP_ACCTYPES ***


BEGIN 
        execute immediate  
          'begin  
               bpa.alter_policy_info(''CP_ACCTYPES'', ''CENTER'' , null, null, null, null);
               bpa.alter_policy_info(''CP_ACCTYPES'', ''FILIAL'' , null, null, null, null);
               bpa.alter_policy_info(''CP_ACCTYPES'', ''WHOLE'' , null, null, null, null);
               null;
           end; 
          '; 
END; 
/

PROMPT *** Create  table CP_ACCTYPES ***
begin 
  execute immediate '
  CREATE TABLE BARS.CP_ACCTYPES 
   (	TYPE VARCHAR2(5), 
	NAME VARCHAR2(50)
   ) SEGMENT CREATION IMMEDIATE 
  PCTFREE 10 PCTUSED 40 INITRANS 1 MAXTRANS 255 
 NOCOMPRESS LOGGING
  TABLESPACE BRSSMLD ';
exception when others then       
  if sqlcode=-955 then null; else raise; end if; 
end; 
/




PROMPT *** ALTER_POLICIES to CP_ACCTYPES ***
 exec bpa.alter_policies('CP_ACCTYPES');


COMMENT ON TABLE BARS.CP_ACCTYPES IS 'Типи рахунків угоди ЦП';
COMMENT ON COLUMN BARS.CP_ACCTYPES.TYPE IS 'Тип рахунку';
COMMENT ON COLUMN BARS.CP_ACCTYPES.NAME IS 'Назва типу';




PROMPT *** Create  constraint XPK_CP_ACCTYPES ***
begin   
 execute immediate '
  ALTER TABLE BARS.CP_ACCTYPES ADD CONSTRAINT XPK_CP_ACCTYPES PRIMARY KEY (TYPE)
  USING INDEX PCTFREE 10 INITRANS 2 MAXTRANS 255 COMPUTE STATISTICS 
  TABLESPACE BRSSMLI  ENABLE';
exception when others then
  if  sqlcode=-2260 or sqlcode=-2261 or sqlcode=-2264 or sqlcode=-2275 or sqlcode=-1442 then null; else raise; end if;
 end;
/




PROMPT *** Create  constraint SYS_C006198 ***
begin   
 execute immediate '
  ALTER TABLE BARS.CP_ACCTYPES MODIFY (TYPE NOT NULL ENABLE)';
exception when others then
  if  sqlcode=-2260 or sqlcode=-2261 or sqlcode=-2264 or sqlcode=-2275 or sqlcode=-1442 then null; else raise; end if;
 end;
/




PROMPT *** Create  index XPK_CP_ACCTYPES ***
begin   
 execute immediate '
  CREATE UNIQUE INDEX BARS.XPK_CP_ACCTYPES ON BARS.CP_ACCTYPES (TYPE) 
  PCTFREE 10 INITRANS 2 MAXTRANS 255 COMPUTE STATISTICS 
  TABLESPACE BRSSMLI ';
exception when others then
  if  sqlcode=-955  then null; else raise; end if;
 end;
/



PROMPT *** Create  grants  CP_ACCTYPES ***
grant SELECT                                                                 on CP_ACCTYPES     to BARSREADER_ROLE;
grant DELETE,INSERT,SELECT,UPDATE                                            on CP_ACCTYPES     to BARS_ACCESS_DEFROLE;
grant SELECT                                                                 on CP_ACCTYPES     to BARS_DM;
grant SELECT                                                                 on CP_ACCTYPES     to UPLD;



PROMPT ===================================================================================== 
PROMPT *** End *** ========== Scripts /Sql/BARS/Table/CP_ACCTYPES.sql =========*** End *** =
PROMPT ===================================================================================== 
