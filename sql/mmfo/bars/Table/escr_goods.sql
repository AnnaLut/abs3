

PROMPT ===================================================================================== 
PROMPT *** Run *** ========== Scripts /Sql/BARS/Table/ESCR_GOODS.sql =========*** Run *** ==
PROMPT ===================================================================================== 


PROMPT *** ALTER_POLICY_INFO to ESCR_GOODS ***


BEGIN 
        execute immediate  
          'begin  
               bpa.alter_policy_info(''ESCR_GOODS'', ''FILIAL'' , null, null, null, null);
               bpa.alter_policy_info(''ESCR_GOODS'', ''WHOLE'' , null, null, null, null);
               null;
           end; 
          '; 
END; 
/

PROMPT *** Create  table ESCR_GOODS ***
begin 
  execute immediate '
  CREATE TABLE BARS.ESCR_GOODS 
   (	ID NUMBER, 
	GOOD VARCHAR2(4000)
   ) SEGMENT CREATION IMMEDIATE 
  PCTFREE 10 PCTUSED 40 INITRANS 1 MAXTRANS 255 
 NOCOMPRESS LOGGING
  TABLESPACE BRSSMLD ';
exception when others then       
  if sqlcode=-955 then null; else raise; end if; 
end; 
/




PROMPT *** ALTER_POLICIES to ESCR_GOODS ***
 exec bpa.alter_policies('ESCR_GOODS');


COMMENT ON TABLE BARS.ESCR_GOODS IS 'Список основних товарів для енергоефективних заходів';
COMMENT ON COLUMN BARS.ESCR_GOODS.ID IS '';
COMMENT ON COLUMN BARS.ESCR_GOODS.GOOD IS '';




PROMPT *** Create  constraint SYS_C00118588 ***
begin   
 execute immediate '
  ALTER TABLE BARS.ESCR_GOODS MODIFY (ID NOT NULL ENABLE)';
exception when others then
  if  sqlcode=-2260 or sqlcode=-2261 or sqlcode=-2264 or sqlcode=-2275 or sqlcode=-1442 then null; else raise; end if;
 end;
/




PROMPT *** Create  constraint SYS_C00118589 ***
begin   
 execute immediate '
  ALTER TABLE BARS.ESCR_GOODS MODIFY (GOOD NOT NULL ENABLE)';
exception when others then
  if  sqlcode=-2260 or sqlcode=-2261 or sqlcode=-2264 or sqlcode=-2275 or sqlcode=-1442 then null; else raise; end if;
 end;
/




PROMPT *** Create  constraint PK_GOODS_ID ***
begin   
 execute immediate '
  ALTER TABLE BARS.ESCR_GOODS ADD CONSTRAINT PK_GOODS_ID PRIMARY KEY (ID)
  USING INDEX PCTFREE 10 INITRANS 2 MAXTRANS 255 COMPUTE STATISTICS 
  TABLESPACE BRSSMLI  ENABLE';
exception when others then
  if  sqlcode=-2260 or sqlcode=-2261 or sqlcode=-2264 or sqlcode=-2275 or sqlcode=-1442 then null; else raise; end if;
 end;
/




PROMPT *** Create  index PK_GOODS_ID ***
begin   
 execute immediate '
  CREATE UNIQUE INDEX BARS.PK_GOODS_ID ON BARS.ESCR_GOODS (ID) 
  PCTFREE 10 INITRANS 2 MAXTRANS 255 COMPUTE STATISTICS 
  TABLESPACE BRSSMLI ';
exception when others then
  if  sqlcode=-955  then null; else raise; end if;
 end;
/



PROMPT *** Create  grants  ESCR_GOODS ***
grant DELETE,INSERT,SELECT,UPDATE                                            on ESCR_GOODS      to BARS_ACCESS_DEFROLE;



PROMPT ===================================================================================== 
PROMPT *** End *** ========== Scripts /Sql/BARS/Table/ESCR_GOODS.sql =========*** End *** ==
PROMPT ===================================================================================== 
