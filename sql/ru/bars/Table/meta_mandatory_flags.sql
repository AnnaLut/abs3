

PROMPT ===================================================================================== 
PROMPT *** Run *** ========== Scripts /Sql/BARS/Table/META_MANDATORY_FLAGS.sql =========*** 
PROMPT ===================================================================================== 


PROMPT *** ALTER_POLICY_INFO to META_MANDATORY_FLAGS ***


BEGIN 
        execute immediate  
          'begin  
               bpa.alter_policy_info(''META_MANDATORY_FLAGS'', ''FILIAL'' , null, ''E'', ''E'', ''E'');
               bpa.alter_policy_info(''META_MANDATORY_FLAGS'', ''WHOLE'' , null, null, null, null);
               null;
           end; 
          '; 
END; 
/

PROMPT *** Create  table META_MANDATORY_FLAGS ***
begin 
  execute immediate '
  CREATE TABLE BARS.META_MANDATORY_FLAGS 
   (	MANDATORY_FLAG_ID NUMBER(1,0), 
	MANDATORY_FLAG_NAME VARCHAR2(64 CHAR)
   ) SEGMENT CREATION IMMEDIATE 
  PCTFREE 10 PCTUSED 40 INITRANS 1 MAXTRANS 255 
 NOCOMPRESS LOGGING
  TABLESPACE BRSSMLD ';
exception when others then       
  if sqlcode=-955 then null; else raise; end if; 
end; 
/




PROMPT *** ALTER_POLICIES to META_MANDATORY_FLAGS ***
 exec bpa.alter_policies('META_MANDATORY_FLAGS');


COMMENT ON TABLE BARS.META_MANDATORY_FLAGS IS 'Таблиця ознак обовязковості заповнення';
COMMENT ON COLUMN BARS.META_MANDATORY_FLAGS.MANDATORY_FLAG_ID IS 'Код ознаки';
COMMENT ON COLUMN BARS.META_MANDATORY_FLAGS.MANDATORY_FLAG_NAME IS 'Назва ознаки';




PROMPT *** Create  constraint PK_META_MANDATORY_FLAGS ***
begin   
 execute immediate '
  ALTER TABLE BARS.META_MANDATORY_FLAGS ADD CONSTRAINT PK_META_MANDATORY_FLAGS PRIMARY KEY (MANDATORY_FLAG_ID)
  USING INDEX PCTFREE 10 INITRANS 2 MAXTRANS 255 COMPUTE STATISTICS 
  TABLESPACE BRSSMLI  ENABLE';
exception when others then
  if  sqlcode=-2260 or sqlcode=-2261 or sqlcode=-2264 or sqlcode=-2275 or sqlcode=-1442 then null; else raise; end if;
 end;
/




PROMPT *** Create  constraint CC_METAMNDF_FNAME_NN ***
begin   
 execute immediate '
  ALTER TABLE BARS.META_MANDATORY_FLAGS MODIFY (MANDATORY_FLAG_NAME CONSTRAINT CC_METAMNDF_FNAME_NN NOT NULL ENABLE)';
exception when others then
  if  sqlcode=-2260 or sqlcode=-2261 or sqlcode=-2264 or sqlcode=-2275 or sqlcode=-1442 then null; else raise; end if;
 end;
/




PROMPT *** Create  constraint CC_METAMNDF_FID_NN ***
begin   
 execute immediate '
  ALTER TABLE BARS.META_MANDATORY_FLAGS MODIFY (MANDATORY_FLAG_ID CONSTRAINT CC_METAMNDF_FID_NN NOT NULL ENABLE)';
exception when others then
  if  sqlcode=-2260 or sqlcode=-2261 or sqlcode=-2264 or sqlcode=-2275 or sqlcode=-1442 then null; else raise; end if;
 end;
/




PROMPT *** Create  index PK_META_MANDATORY_FLAGS ***
begin   
 execute immediate '
  CREATE UNIQUE INDEX BARS.PK_META_MANDATORY_FLAGS ON BARS.META_MANDATORY_FLAGS (MANDATORY_FLAG_ID) 
  PCTFREE 10 INITRANS 2 MAXTRANS 255 COMPUTE STATISTICS 
  TABLESPACE BRSSMLI ';
exception when others then
  if  sqlcode=-955  then null; else raise; end if;
 end;
/



PROMPT *** Create  grants  META_MANDATORY_FLAGS ***
grant SELECT                                                                 on META_MANDATORY_FLAGS to BARS_ACCESS_DEFROLE;
grant SELECT                                                                 on META_MANDATORY_FLAGS to START1;
grant DELETE,INSERT,SELECT,UPDATE                                            on META_MANDATORY_FLAGS to WR_ALL_RIGHTS;



PROMPT ===================================================================================== 
PROMPT *** End *** ========== Scripts /Sql/BARS/Table/META_MANDATORY_FLAGS.sql =========*** 
PROMPT ===================================================================================== 
