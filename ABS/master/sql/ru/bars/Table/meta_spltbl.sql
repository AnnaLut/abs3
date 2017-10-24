

PROMPT ===================================================================================== 
PROMPT *** Run *** ========== Scripts /Sql/BARS/Table/META_SPLTBL.sql =========*** Run *** =
PROMPT ===================================================================================== 


PROMPT *** ALTER_POLICY_INFO to META_SPLTBL ***


BEGIN 
        execute immediate  
          'begin  
               bpa.alter_policy_info(''META_SPLTBL'', ''FILIAL'' , null, ''E'', ''E'', ''E'');
               bpa.alter_policy_info(''META_SPLTBL'', ''WHOLE'' , null, null, null, null);
               null;
           end; 
          '; 
END; 
/

PROMPT *** Create  table META_SPLTBL ***
begin 
  execute immediate '
  CREATE TABLE BARS.META_SPLTBL 
   (	TABID NUMBER(38,0), 
	SPL_TABID NUMBER(38,0), 
	SPL_NAME VARCHAR2(30), 
	SPL_CODE VARCHAR2(30), 
	FLAG_INS NUMBER(1,0), 
	FLAG_DEL NUMBER(1,0), 
	FLAG_UPD NUMBER(1,0), 
	PROC_NAME VARCHAR2(254)
   ) SEGMENT CREATION DEFERRED 
  PCTFREE 10 PCTUSED 40 INITRANS 1 MAXTRANS 255 
 NOCOMPRESS LOGGING
  TABLESPACE BRSSMLD ';
exception when others then       
  if sqlcode=-955 then null; else raise; end if; 
end; 
/




PROMPT *** ALTER_POLICIES to META_SPLTBL ***
 exec bpa.alter_policies('META_SPLTBL');


COMMENT ON TABLE BARS.META_SPLTBL IS 'Метаопис...';
COMMENT ON COLUMN BARS.META_SPLTBL.TABID IS 'Код таблицы';
COMMENT ON COLUMN BARS.META_SPLTBL.SPL_TABID IS 'Код связанной таблицы';
COMMENT ON COLUMN BARS.META_SPLTBL.SPL_NAME IS '';
COMMENT ON COLUMN BARS.META_SPLTBL.SPL_CODE IS 'Код фильтра';
COMMENT ON COLUMN BARS.META_SPLTBL.FLAG_INS IS '';
COMMENT ON COLUMN BARS.META_SPLTBL.FLAG_DEL IS '';
COMMENT ON COLUMN BARS.META_SPLTBL.FLAG_UPD IS '';
COMMENT ON COLUMN BARS.META_SPLTBL.PROC_NAME IS '';




PROMPT *** Create  constraint FK_METASPLTBL_METATABLES2 ***
begin   
 execute immediate '
  ALTER TABLE BARS.META_SPLTBL ADD CONSTRAINT FK_METASPLTBL_METATABLES2 FOREIGN KEY (SPL_TABID)
	  REFERENCES BARS.META_TABLES (TABID) ENABLE';
exception when others then
  if  sqlcode=-2260 or sqlcode=-2261 or sqlcode=-2264 or sqlcode=-2275 or sqlcode=-1442 then null; else raise; end if;
 end;
/




PROMPT *** Create  constraint FK_METASPLTBL_METATABLES ***
begin   
 execute immediate '
  ALTER TABLE BARS.META_SPLTBL ADD CONSTRAINT FK_METASPLTBL_METATABLES FOREIGN KEY (TABID)
	  REFERENCES BARS.META_TABLES (TABID) ENABLE';
exception when others then
  if  sqlcode=-2260 or sqlcode=-2261 or sqlcode=-2264 or sqlcode=-2275 or sqlcode=-1442 then null; else raise; end if;
 end;
/




PROMPT *** Create  constraint FK_METASPLTBL_METAFILTERCODES ***
begin   
 execute immediate '
  ALTER TABLE BARS.META_SPLTBL ADD CONSTRAINT FK_METASPLTBL_METAFILTERCODES FOREIGN KEY (SPL_CODE)
	  REFERENCES BARS.META_FILTERCODES (CODE) ENABLE';
exception when others then
  if  sqlcode=-2260 or sqlcode=-2261 or sqlcode=-2264 or sqlcode=-2275 or sqlcode=-1442 then null; else raise; end if;
 end;
/




PROMPT *** Create  constraint PK_METASPLTBL ***
begin   
 execute immediate '
  ALTER TABLE BARS.META_SPLTBL ADD CONSTRAINT PK_METASPLTBL PRIMARY KEY (TABID)
  USING INDEX PCTFREE 10 INITRANS 2 MAXTRANS 255 COMPUTE STATISTICS 
  TABLESPACE BRSSMLD  ENABLE';
exception when others then
  if  sqlcode=-2260 or sqlcode=-2261 or sqlcode=-2264 or sqlcode=-2275 or sqlcode=-1442 then null; else raise; end if;
 end;
/




PROMPT *** Create  constraint CC_METASPLTBL_FLAGUPD ***
begin   
 execute immediate '
  ALTER TABLE BARS.META_SPLTBL ADD CONSTRAINT CC_METASPLTBL_FLAGUPD CHECK (flag_upd in (0,1)) ENABLE';
exception when others then
  if  sqlcode=-2260 or sqlcode=-2261 or sqlcode=-2264 or sqlcode=-2275 or sqlcode=-1442 then null; else raise; end if;
 end;
/




PROMPT *** Create  constraint CC_METASPLTBL_FLAGINS ***
begin   
 execute immediate '
  ALTER TABLE BARS.META_SPLTBL ADD CONSTRAINT CC_METASPLTBL_FLAGINS CHECK (flag_ins in (0,1)) ENABLE';
exception when others then
  if  sqlcode=-2260 or sqlcode=-2261 or sqlcode=-2264 or sqlcode=-2275 or sqlcode=-1442 then null; else raise; end if;
 end;
/




PROMPT *** Create  constraint CC_METASPLTBL_FLAGDEL ***
begin   
 execute immediate '
  ALTER TABLE BARS.META_SPLTBL ADD CONSTRAINT CC_METASPLTBL_FLAGDEL CHECK (flag_del in (0,1)) ENABLE';
exception when others then
  if  sqlcode=-2260 or sqlcode=-2261 or sqlcode=-2264 or sqlcode=-2275 or sqlcode=-1442 then null; else raise; end if;
 end;
/




PROMPT *** Create  constraint CC_METASPLTBL_FLAGUPD_NN ***
begin   
 execute immediate '
  ALTER TABLE BARS.META_SPLTBL MODIFY (FLAG_UPD CONSTRAINT CC_METASPLTBL_FLAGUPD_NN NOT NULL ENABLE)';
exception when others then
  if  sqlcode=-2260 or sqlcode=-2261 or sqlcode=-2264 or sqlcode=-2275 or sqlcode=-1442 then null; else raise; end if;
 end;
/




PROMPT *** Create  constraint CC_METASPLTBL_FLAGDEL_NN ***
begin   
 execute immediate '
  ALTER TABLE BARS.META_SPLTBL MODIFY (FLAG_DEL CONSTRAINT CC_METASPLTBL_FLAGDEL_NN NOT NULL ENABLE)';
exception when others then
  if  sqlcode=-2260 or sqlcode=-2261 or sqlcode=-2264 or sqlcode=-2275 or sqlcode=-1442 then null; else raise; end if;
 end;
/




PROMPT *** Create  constraint CC_METASPLTBL_FLAGINS_NN ***
begin   
 execute immediate '
  ALTER TABLE BARS.META_SPLTBL MODIFY (FLAG_INS CONSTRAINT CC_METASPLTBL_FLAGINS_NN NOT NULL ENABLE)';
exception when others then
  if  sqlcode=-2260 or sqlcode=-2261 or sqlcode=-2264 or sqlcode=-2275 or sqlcode=-1442 then null; else raise; end if;
 end;
/




PROMPT *** Create  constraint CC_METASPLTBL_SPLCODE_NN ***
begin   
 execute immediate '
  ALTER TABLE BARS.META_SPLTBL MODIFY (SPL_CODE CONSTRAINT CC_METASPLTBL_SPLCODE_NN NOT NULL ENABLE)';
exception when others then
  if  sqlcode=-2260 or sqlcode=-2261 or sqlcode=-2264 or sqlcode=-2275 or sqlcode=-1442 then null; else raise; end if;
 end;
/




PROMPT *** Create  constraint CC_METASPLTBL_SPLTABID_NN ***
begin   
 execute immediate '
  ALTER TABLE BARS.META_SPLTBL MODIFY (SPL_TABID CONSTRAINT CC_METASPLTBL_SPLTABID_NN NOT NULL ENABLE)';
exception when others then
  if  sqlcode=-2260 or sqlcode=-2261 or sqlcode=-2264 or sqlcode=-2275 or sqlcode=-1442 then null; else raise; end if;
 end;
/




PROMPT *** Create  constraint CC_METASPLTBL_TABID_NN ***
begin   
 execute immediate '
  ALTER TABLE BARS.META_SPLTBL MODIFY (TABID CONSTRAINT CC_METASPLTBL_TABID_NN NOT NULL ENABLE)';
exception when others then
  if  sqlcode=-2260 or sqlcode=-2261 or sqlcode=-2264 or sqlcode=-2275 or sqlcode=-1442 then null; else raise; end if;
 end;
/




PROMPT *** Create  index PK_METASPLTBL ***
begin   
 execute immediate '
  CREATE UNIQUE INDEX BARS.PK_METASPLTBL ON BARS.META_SPLTBL (TABID) 
  PCTFREE 10 INITRANS 2 MAXTRANS 255 COMPUTE STATISTICS 
  TABLESPACE BRSSMLD ';
exception when others then
  if  sqlcode=-955  then null; else raise; end if;
 end;
/



PROMPT *** Create  grants  META_SPLTBL ***
grant DELETE,INSERT,SELECT,UPDATE                                            on META_SPLTBL     to BARS_ACCESS_DEFROLE;



PROMPT ===================================================================================== 
PROMPT *** End *** ========== Scripts /Sql/BARS/Table/META_SPLTBL.sql =========*** End *** =
PROMPT ===================================================================================== 
