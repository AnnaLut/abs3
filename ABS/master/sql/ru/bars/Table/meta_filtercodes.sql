

PROMPT ===================================================================================== 
PROMPT *** Run *** ========== Scripts /Sql/BARS/Table/META_FILTERCODES.sql =========*** Run 
PROMPT ===================================================================================== 


PROMPT *** ALTER_POLICY_INFO to META_FILTERCODES ***


BEGIN 
        execute immediate  
          'begin  
               bpa.alter_policy_info(''META_FILTERCODES'', ''FILIAL'' , null, ''E'', ''E'', ''E'');
               bpa.alter_policy_info(''META_FILTERCODES'', ''WHOLE'' , null, null, null, null);
               null;
           end; 
          '; 
END; 
/

PROMPT *** Create  table META_FILTERCODES ***
begin 
  execute immediate '
  CREATE TABLE BARS.META_FILTERCODES 
   (	CODE VARCHAR2(30), 
	NAME VARCHAR2(254), 
	CONDITION VARCHAR2(2000)
   ) SEGMENT CREATION IMMEDIATE 
  PCTFREE 10 PCTUSED 40 INITRANS 1 MAXTRANS 255 
 NOCOMPRESS LOGGING
  TABLESPACE BRSSMLD ';
exception when others then       
  if sqlcode=-955 then null; else raise; end if; 
end; 
/




PROMPT *** ALTER_POLICIES to META_FILTERCODES ***
 exec bpa.alter_policies('META_FILTERCODES');


COMMENT ON TABLE BARS.META_FILTERCODES IS 'Метаопис...';
COMMENT ON COLUMN BARS.META_FILTERCODES.CODE IS 'Код фильтра';
COMMENT ON COLUMN BARS.META_FILTERCODES.NAME IS 'Наименование фильтра';
COMMENT ON COLUMN BARS.META_FILTERCODES.CONDITION IS 'Условие фильтра';




PROMPT *** Create  constraint PK_METAFILTERCODES ***
begin   
 execute immediate '
  ALTER TABLE BARS.META_FILTERCODES ADD CONSTRAINT PK_METAFILTERCODES PRIMARY KEY (CODE)
  USING INDEX PCTFREE 10 INITRANS 2 MAXTRANS 255 COMPUTE STATISTICS 
  TABLESPACE BRSSMLI  ENABLE';
exception when others then
  if  sqlcode=-2260 or sqlcode=-2261 or sqlcode=-2264 or sqlcode=-2275 or sqlcode=-1442 then null; else raise; end if;
 end;
/




PROMPT *** Create  constraint CC_METAFILTERCODES_CODE_NN ***
begin   
 execute immediate '
  ALTER TABLE BARS.META_FILTERCODES MODIFY (CODE CONSTRAINT CC_METAFILTERCODES_CODE_NN NOT NULL ENABLE)';
exception when others then
  if  sqlcode=-2260 or sqlcode=-2261 or sqlcode=-2264 or sqlcode=-2275 or sqlcode=-1442 then null; else raise; end if;
 end;
/




PROMPT *** Create  index PK_METAFILTERCODES ***
begin   
 execute immediate '
  CREATE UNIQUE INDEX BARS.PK_METAFILTERCODES ON BARS.META_FILTERCODES (CODE) 
  PCTFREE 10 INITRANS 2 MAXTRANS 255 COMPUTE STATISTICS 
  TABLESPACE BRSSMLI ';
exception when others then
  if  sqlcode=-955  then null; else raise; end if;
 end;
/



PROMPT *** Create  grants  META_FILTERCODES ***
grant SELECT                                                                 on META_FILTERCODES to BARS_ACCESS_DEFROLE;
grant SELECT                                                                 on META_FILTERCODES to START1;
grant DELETE,FLASHBACK,INSERT,SELECT,UPDATE                                  on META_FILTERCODES to WR_ALL_RIGHTS;
grant SELECT                                                                 on META_FILTERCODES to WR_METATAB;



PROMPT *** Create SYNONYM  to META_FILTERCODES ***

  CREATE OR REPLACE PUBLIC SYNONYM META_FILTERCODES FOR BARS.META_FILTERCODES;


PROMPT ===================================================================================== 
PROMPT *** End *** ========== Scripts /Sql/BARS/Table/META_FILTERCODES.sql =========*** End 
PROMPT ===================================================================================== 
