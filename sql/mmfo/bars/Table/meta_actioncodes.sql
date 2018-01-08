

PROMPT ===================================================================================== 
PROMPT *** Run *** ========== Scripts /Sql/BARS/Table/META_ACTIONCODES.sql =========*** Run 
PROMPT ===================================================================================== 


PROMPT *** ALTER_POLICY_INFO to META_ACTIONCODES ***


BEGIN 
        execute immediate  
          'begin  
               bpa.alter_policy_info(''META_ACTIONCODES'', ''CENTER'' , null, null, null, null);
               bpa.alter_policy_info(''META_ACTIONCODES'', ''FILIAL'' , null, null, null, null);
               bpa.alter_policy_info(''META_ACTIONCODES'', ''WHOLE'' , null, null, null, null);
               null;
           end; 
          '; 
END; 
/

PROMPT *** Create  table META_ACTIONCODES ***
begin 
  execute immediate '
  CREATE TABLE BARS.META_ACTIONCODES 
   (	CODE VARCHAR2(30), 
	NAME VARCHAR2(100)
   ) SEGMENT CREATION IMMEDIATE 
  PCTFREE 10 PCTUSED 40 INITRANS 1 MAXTRANS 255 
 NOCOMPRESS LOGGING
  TABLESPACE BRSSMLD ';
exception when others then       
  if sqlcode=-955 then null; else raise; end if; 
end; 
/




PROMPT *** ALTER_POLICIES to META_ACTIONCODES ***
 exec bpa.alter_policies('META_ACTIONCODES');


COMMENT ON TABLE BARS.META_ACTIONCODES IS '������������. �������� ��� ���������';
COMMENT ON COLUMN BARS.META_ACTIONCODES.CODE IS '��� ��������';
COMMENT ON COLUMN BARS.META_ACTIONCODES.NAME IS '������������ ��������';




PROMPT *** Create  constraint CC_METAACTIONCODES_CODE_NN ***
begin   
 execute immediate '
  ALTER TABLE BARS.META_ACTIONCODES MODIFY (CODE CONSTRAINT CC_METAACTIONCODES_CODE_NN NOT NULL ENABLE)';
exception when others then
  if  sqlcode=-2260 or sqlcode=-2261 or sqlcode=-2264 or sqlcode=-2275 or sqlcode=-1442 then null; else raise; end if;
 end;
/




PROMPT *** Create  constraint PK_METAACTIONCODES ***
begin   
 execute immediate '
  ALTER TABLE BARS.META_ACTIONCODES ADD CONSTRAINT PK_METAACTIONCODES PRIMARY KEY (CODE)
  USING INDEX PCTFREE 10 INITRANS 2 MAXTRANS 255 COMPUTE STATISTICS 
  TABLESPACE BRSSMLI  ENABLE';
exception when others then
  if  sqlcode=-2260 or sqlcode=-2261 or sqlcode=-2264 or sqlcode=-2275 or sqlcode=-1442 then null; else raise; end if;
 end;
/




PROMPT *** Create  index PK_METAACTIONCODES ***
begin   
 execute immediate '
  CREATE UNIQUE INDEX BARS.PK_METAACTIONCODES ON BARS.META_ACTIONCODES (CODE) 
  PCTFREE 10 INITRANS 2 MAXTRANS 255 COMPUTE STATISTICS 
  TABLESPACE BRSSMLI ';
exception when others then
  if  sqlcode=-955  then null; else raise; end if;
 end;
/



PROMPT *** Create  grants  META_ACTIONCODES ***
grant SELECT                                                                 on META_ACTIONCODES to BARSREADER_ROLE;
grant SELECT                                                                 on META_ACTIONCODES to BARS_ACCESS_DEFROLE;
grant SELECT                                                                 on META_ACTIONCODES to BARS_DM;
grant SELECT                                                                 on META_ACTIONCODES to UPLD;
grant DELETE,FLASHBACK,INSERT,SELECT,UPDATE                                  on META_ACTIONCODES to WR_ALL_RIGHTS;



PROMPT *** Create SYNONYM  to META_ACTIONCODES ***

  CREATE OR REPLACE PUBLIC SYNONYM META_ACTIONCODES FOR BARS.META_ACTIONCODES;


PROMPT ===================================================================================== 
PROMPT *** End *** ========== Scripts /Sql/BARS/Table/META_ACTIONCODES.sql =========*** End 
PROMPT ===================================================================================== 
