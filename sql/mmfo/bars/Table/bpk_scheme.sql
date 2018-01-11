

PROMPT ===================================================================================== 
PROMPT *** Run *** ========== Scripts /Sql/BARS/Table/BPK_SCHEME.sql =========*** Run *** ==
PROMPT ===================================================================================== 


PROMPT *** ALTER_POLICY_INFO to BPK_SCHEME ***


BEGIN 
        execute immediate  
          'begin  
               bpa.alter_policy_info(''BPK_SCHEME'', ''CENTER'' , null, null, null, null);
               bpa.alter_policy_info(''BPK_SCHEME'', ''FILIAL'' , null, ''E'', ''E'', ''E'');
               bpa.alter_policy_info(''BPK_SCHEME'', ''WHOLE'' , null, null, null, null);
               null;
           end; 
          '; 
END; 
/

PROMPT *** Create  table BPK_SCHEME ***
begin 
  execute immediate '
  CREATE TABLE BARS.BPK_SCHEME 
   (	ID NUMBER(22,0), 
	NAME VARCHAR2(70)
   ) SEGMENT CREATION IMMEDIATE 
  PCTFREE 10 PCTUSED 40 INITRANS 1 MAXTRANS 255 
 NOCOMPRESS LOGGING
  TABLESPACE BRSSMLD ';
exception when others then       
  if sqlcode=-955 then null; else raise; end if; 
end; 
/




PROMPT *** ALTER_POLICIES to BPK_SCHEME ***
 exec bpa.alter_policies('BPK_SCHEME');


COMMENT ON TABLE BARS.BPK_SCHEME IS 'БПК. Тип схеми обслуговування';
COMMENT ON COLUMN BARS.BPK_SCHEME.ID IS 'Код схеми';
COMMENT ON COLUMN BARS.BPK_SCHEME.NAME IS 'Назва';




PROMPT *** Create  constraint PK_BPKSCHEME ***
begin   
 execute immediate '
  ALTER TABLE BARS.BPK_SCHEME ADD CONSTRAINT PK_BPKSCHEME PRIMARY KEY (ID)
  USING INDEX PCTFREE 10 INITRANS 2 MAXTRANS 255 COMPUTE STATISTICS 
  TABLESPACE BRSSMLI  ENABLE';
exception when others then
  if  sqlcode=-2260 or sqlcode=-2261 or sqlcode=-2264 or sqlcode=-2275 or sqlcode=-1442 then null; else raise; end if;
 end;
/




PROMPT *** Create  constraint CC_BPKSCHEME_ID_NN ***
begin   
 execute immediate '
  ALTER TABLE BARS.BPK_SCHEME MODIFY (ID CONSTRAINT CC_BPKSCHEME_ID_NN NOT NULL ENABLE NOVALIDATE)';
exception when others then
  if  sqlcode=-2260 or sqlcode=-2261 or sqlcode=-2264 or sqlcode=-2275 or sqlcode=-1442 then null; else raise; end if;
 end;
/




PROMPT *** Create  index PK_BPKSCHEME ***
begin   
 execute immediate '
  CREATE UNIQUE INDEX BARS.PK_BPKSCHEME ON BARS.BPK_SCHEME (ID) 
  PCTFREE 10 INITRANS 2 MAXTRANS 255 COMPUTE STATISTICS 
  TABLESPACE BRSSMLI ';
exception when others then
  if  sqlcode=-955  then null; else raise; end if;
 end;
/



PROMPT *** Create  grants  BPK_SCHEME ***
grant SELECT                                                                 on BPK_SCHEME      to BARSREADER_ROLE;
grant DELETE,INSERT,SELECT,UPDATE                                            on BPK_SCHEME      to BARS_ACCESS_DEFROLE;
grant SELECT                                                                 on BPK_SCHEME      to BARS_DM;
grant SELECT                                                                 on BPK_SCHEME      to CUST001;
grant DELETE,INSERT,SELECT,UPDATE                                            on BPK_SCHEME      to OBPC;
grant SELECT                                                                 on BPK_SCHEME      to UPLD;



PROMPT ===================================================================================== 
PROMPT *** End *** ========== Scripts /Sql/BARS/Table/BPK_SCHEME.sql =========*** End *** ==
PROMPT ===================================================================================== 
