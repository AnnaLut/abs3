

PROMPT ===================================================================================== 
PROMPT *** Run *** ========== Scripts /Sql/BARS/Table/OW_OIC_REF.sql =========*** Run *** ==
PROMPT ===================================================================================== 


PROMPT *** ALTER_POLICY_INFO to OW_OIC_REF ***


BEGIN 
        execute immediate  
          'begin  
               bpa.alter_policy_info(''OW_OIC_REF'', ''FILIAL'' , null, null, null, null);
               bpa.alter_policy_info(''OW_OIC_REF'', ''WHOLE'' , null, ''E'', ''E'', ''E'');
               null;
           end; 
          '; 
END; 
/

PROMPT *** Create  table OW_OIC_REF ***
begin 
  execute immediate '
  CREATE TABLE BARS.OW_OIC_REF 
   (	ID NUMBER(22,0), 
	REF NUMBER(38,0)
   ) SEGMENT CREATION IMMEDIATE 
  PCTFREE 10 PCTUSED 40 INITRANS 1 MAXTRANS 255 
 NOCOMPRESS LOGGING
  TABLESPACE BRSMDLD ';
exception when others then       
  if sqlcode=-955 then null; else raise; end if; 
end; 
/




PROMPT *** ALTER_POLICIES to OW_OIC_REF ***
 exec bpa.alter_policies('OW_OIC_REF');


COMMENT ON TABLE BARS.OW_OIC_REF IS 'W4. Документы файлов';
COMMENT ON COLUMN BARS.OW_OIC_REF.ID IS 'Ид.файла';
COMMENT ON COLUMN BARS.OW_OIC_REF.REF IS 'Реф.';




PROMPT *** Create  constraint FK_OWOICREF_OPER ***
begin   
 execute immediate '
  ALTER TABLE BARS.OW_OIC_REF ADD CONSTRAINT FK_OWOICREF_OPER FOREIGN KEY (REF)
	  REFERENCES BARS.OPER (REF) ENABLE';
exception when others then
  if  sqlcode=-2260 or sqlcode=-2261 or sqlcode=-2264 or sqlcode=-2275 or sqlcode=-1442 then null; else raise; end if;
 end;
/




PROMPT *** Create  constraint FK_OWOICREF_OWFILES ***
begin   
 execute immediate '
  ALTER TABLE BARS.OW_OIC_REF ADD CONSTRAINT FK_OWOICREF_OWFILES FOREIGN KEY (ID)
	  REFERENCES BARS.OW_FILES (ID) ENABLE';
exception when others then
  if  sqlcode=-2260 or sqlcode=-2261 or sqlcode=-2264 or sqlcode=-2275 or sqlcode=-1442 then null; else raise; end if;
 end;
/




PROMPT *** Create  constraint PK_OWOICREF ***
begin   
 execute immediate '
  ALTER TABLE BARS.OW_OIC_REF ADD CONSTRAINT PK_OWOICREF PRIMARY KEY (ID, REF)
  USING INDEX PCTFREE 10 INITRANS 2 MAXTRANS 255 COMPUTE STATISTICS 
  TABLESPACE BRSMDLD  ENABLE';
exception when others then
  if  sqlcode=-2260 or sqlcode=-2261 or sqlcode=-2264 or sqlcode=-2275 or sqlcode=-1442 then null; else raise; end if;
 end;
/




PROMPT *** Create  constraint CC_OWOICREF_REF_NN ***
begin   
 execute immediate '
  ALTER TABLE BARS.OW_OIC_REF ADD CONSTRAINT CC_OWOICREF_REF_NN CHECK (ref is not null) ENABLE';
exception when others then
  if  sqlcode=-2260 or sqlcode=-2261 or sqlcode=-2264 or sqlcode=-2275 or sqlcode=-1442 then null; else raise; end if;
 end;
/




PROMPT *** Create  constraint CC_OWOICREF_ID_NN ***
begin   
 execute immediate '
  ALTER TABLE BARS.OW_OIC_REF ADD CONSTRAINT CC_OWOICREF_ID_NN CHECK (id is not null) ENABLE';
exception when others then
  if  sqlcode=-2260 or sqlcode=-2261 or sqlcode=-2264 or sqlcode=-2275 or sqlcode=-1442 then null; else raise; end if;
 end;
/




PROMPT *** Create  index PK_OWOICREF ***
begin   
 execute immediate '
  CREATE UNIQUE INDEX BARS.PK_OWOICREF ON BARS.OW_OIC_REF (ID, REF) 
  PCTFREE 10 INITRANS 2 MAXTRANS 255 COMPUTE STATISTICS 
  TABLESPACE BRSMDLD ';
exception when others then
  if  sqlcode=-955  then null; else raise; end if;
 end;
/




PROMPT *** Create  index I_OWOICREF_REF ***
begin   
 execute immediate '
  CREATE INDEX BARS.I_OWOICREF_REF ON BARS.OW_OIC_REF (REF) 
  PCTFREE 10 INITRANS 2 MAXTRANS 255 COMPUTE STATISTICS 
  TABLESPACE BRSDYND ';
exception when others then
  if  sqlcode=-955  then null; else raise; end if;
 end;
/



PROMPT *** Create  grants  OW_OIC_REF ***
grant SELECT                                                                 on OW_OIC_REF      to BARS_ACCESS_DEFROLE;
grant SELECT                                                                 on OW_OIC_REF      to OW;



PROMPT ===================================================================================== 
PROMPT *** End *** ========== Scripts /Sql/BARS/Table/OW_OIC_REF.sql =========*** End *** ==
PROMPT ===================================================================================== 
