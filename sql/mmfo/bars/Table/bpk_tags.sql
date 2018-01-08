

PROMPT ===================================================================================== 
PROMPT *** Run *** ========== Scripts /Sql/BARS/Table/BPK_TAGS.sql =========*** Run *** ====
PROMPT ===================================================================================== 


PROMPT *** ALTER_POLICY_INFO to BPK_TAGS ***


BEGIN 
        execute immediate  
          'begin  
               bpa.alter_policy_info(''BPK_TAGS'', ''CENTER'' , null, null, null, null);
               bpa.alter_policy_info(''BPK_TAGS'', ''FILIAL'' , null, ''E'', ''E'', ''E'');
               bpa.alter_policy_info(''BPK_TAGS'', ''WHOLE'' , null, null, null, null);
               null;
           end; 
          '; 
END; 
/

PROMPT *** Create  table BPK_TAGS ***
begin 
  execute immediate '
  CREATE TABLE BARS.BPK_TAGS 
   (	TAG VARCHAR2(30), 
	NAME VARCHAR2(100), 
	TYPE VARCHAR2(1)
   ) SEGMENT CREATION IMMEDIATE 
  PCTFREE 10 PCTUSED 40 INITRANS 1 MAXTRANS 255 
 NOCOMPRESS LOGGING
  TABLESPACE BRSSMLD ';
exception when others then       
  if sqlcode=-955 then null; else raise; end if; 
end; 
/




PROMPT *** ALTER_POLICIES to BPK_TAGS ***
 exec bpa.alter_policies('BPK_TAGS');


COMMENT ON TABLE BARS.BPK_TAGS IS 'БПК. Довідник реквізитів договорів';
COMMENT ON COLUMN BARS.BPK_TAGS.TAG IS 'Код';
COMMENT ON COLUMN BARS.BPK_TAGS.NAME IS 'Назва';
COMMENT ON COLUMN BARS.BPK_TAGS.TYPE IS '';




PROMPT *** Create  constraint PK_BPKTAGS ***
begin   
 execute immediate '
  ALTER TABLE BARS.BPK_TAGS ADD CONSTRAINT PK_BPKTAGS PRIMARY KEY (TAG)
  USING INDEX PCTFREE 10 INITRANS 2 MAXTRANS 255 COMPUTE STATISTICS 
  TABLESPACE BRSSMLI  ENABLE';
exception when others then
  if  sqlcode=-2260 or sqlcode=-2261 or sqlcode=-2264 or sqlcode=-2275 or sqlcode=-1442 then null; else raise; end if;
 end;
/




PROMPT *** Create  constraint CC_BPKTAGS_TYPE ***
begin   
 execute immediate '
  ALTER TABLE BARS.BPK_TAGS ADD CONSTRAINT CC_BPKTAGS_TYPE CHECK (type in (''C'', ''N'', ''D'')) ENABLE NOVALIDATE';
exception when others then
  if  sqlcode=-2260 or sqlcode=-2261 or sqlcode=-2264 or sqlcode=-2275 or sqlcode=-1442 then null; else raise; end if;
 end;
/




PROMPT *** Create  index PK_BPKTAGS ***
begin   
 execute immediate '
  CREATE UNIQUE INDEX BARS.PK_BPKTAGS ON BARS.BPK_TAGS (TAG) 
  PCTFREE 10 INITRANS 2 MAXTRANS 255 COMPUTE STATISTICS 
  TABLESPACE BRSSMLI ';
exception when others then
  if  sqlcode=-955  then null; else raise; end if;
 end;
/



PROMPT *** Create  grants  BPK_TAGS ***
grant DELETE,INSERT,SELECT,UPDATE                                            on BPK_TAGS        to BARS_ACCESS_DEFROLE;
grant SELECT                                                                 on BPK_TAGS        to BARS_DM;
grant DELETE,INSERT,SELECT,UPDATE                                            on BPK_TAGS        to OW;



PROMPT ===================================================================================== 
PROMPT *** End *** ========== Scripts /Sql/BARS/Table/BPK_TAGS.sql =========*** End *** ====
PROMPT ===================================================================================== 
