

PROMPT ===================================================================================== 
PROMPT *** Run *** ========== Scripts /Sql/BARS/Table/IDDOC.sql =========*** Run *** =======
PROMPT ===================================================================================== 


PROMPT *** ALTER_POLICY_INFO to IDDOC ***


BEGIN 
        execute immediate  
          'begin  
               bpa.alter_policy_info(''IDDOC'', ''CENTER'' , null, null, null, null);
               bpa.alter_policy_info(''IDDOC'', ''FILIAL'' , null, ''E'', ''E'', ''E'');
               bpa.alter_policy_info(''IDDOC'', ''WHOLE'' , null, null, null, null);
               null;
           end; 
          '; 
END; 
/

PROMPT *** Create  table IDDOC ***
begin 
  execute immediate '
  CREATE TABLE BARS.IDDOC 
   (	IDDOC NUMBER(38,0), 
	 CONSTRAINT PK_IDDOC PRIMARY KEY (IDDOC) ENABLE
   ) ORGANIZATION INDEX NOCOMPRESS PCTFREE 10 INITRANS 2 MAXTRANS 255 LOGGING
  TABLESPACE BRSDYNI 
 PCTTHRESHOLD 50';
exception when others then       
  if sqlcode=-955 then null; else raise; end if; 
end; 
/




PROMPT *** ALTER_POLICIES to IDDOC ***
 exec bpa.alter_policies('IDDOC');


COMMENT ON TABLE BARS.IDDOC IS 'Идентификаторы принятых из ODB документов';
COMMENT ON COLUMN BARS.IDDOC.IDDOC IS 'идентификатор ODB';




PROMPT *** Create  constraint CC_IDDOC_IDDOC_NN ***
begin   
 execute immediate '
  ALTER TABLE BARS.IDDOC MODIFY (IDDOC CONSTRAINT CC_IDDOC_IDDOC_NN NOT NULL ENABLE)';
exception when others then
  if  sqlcode=-2260 or sqlcode=-2261 or sqlcode=-2264 or sqlcode=-2275 or sqlcode=-1442 then null; else raise; end if;
 end;
/




PROMPT *** Create  constraint PK_IDDOC ***
begin   
 execute immediate '
  ALTER TABLE BARS.IDDOC ADD CONSTRAINT PK_IDDOC PRIMARY KEY (IDDOC)
  USING INDEX PCTFREE 10 INITRANS 2 MAXTRANS 255 COMPUTE STATISTICS 
  TABLESPACE BRSDYNI  ENABLE';
exception when others then
  if  sqlcode=-2260 or sqlcode=-2261 or sqlcode=-2264 or sqlcode=-2275 or sqlcode=-1442 then null; else raise; end if;
 end;
/




PROMPT *** Create  index PK_IDDOC ***
begin   
 execute immediate '
  CREATE UNIQUE INDEX BARS.PK_IDDOC ON BARS.IDDOC (IDDOC) 
  PCTFREE 10 INITRANS 2 MAXTRANS 255 COMPUTE STATISTICS 
  TABLESPACE BRSDYNI ';
exception when others then
  if  sqlcode=-955  then null; else raise; end if;
 end;
/



PROMPT *** Create  grants  IDDOC ***
grant SELECT                                                                 on IDDOC           to BARS_DM;
grant DELETE,FLASHBACK,INSERT,SELECT,UPDATE                                  on IDDOC           to WR_ALL_RIGHTS;



PROMPT ===================================================================================== 
PROMPT *** End *** ========== Scripts /Sql/BARS/Table/IDDOC.sql =========*** End *** =======
PROMPT ===================================================================================== 
