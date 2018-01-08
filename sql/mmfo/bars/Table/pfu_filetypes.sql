

PROMPT ===================================================================================== 
PROMPT *** Run *** ========== Scripts /Sql/BARS/Table/PFU_FILETYPES.sql =========*** Run ***
PROMPT ===================================================================================== 


PROMPT *** ALTER_POLICY_INFO to PFU_FILETYPES ***


BEGIN 
        execute immediate  
          'begin  
               bpa.alter_policy_info(''PFU_FILETYPES'', ''FILIAL'' , null, null, null, null);
               bpa.alter_policy_info(''PFU_FILETYPES'', ''WHOLE'' , null, null, null, null);
               null;
           end; 
          '; 
END; 
/

PROMPT *** Create  table PFU_FILETYPES ***
begin 
  execute immediate '
  CREATE TABLE BARS.PFU_FILETYPES 
   (	ID NUMBER, 
	NAME VARCHAR2(100), 
	CODE VARCHAR2(20)
   ) SEGMENT CREATION IMMEDIATE 
  PCTFREE 10 PCTUSED 40 INITRANS 1 MAXTRANS 255 
 NOCOMPRESS LOGGING
  TABLESPACE BRSMDLD ';
exception when others then       
  if sqlcode=-955 then null; else raise; end if; 
end; 
/




PROMPT *** ALTER_POLICIES to PFU_FILETYPES ***
 exec bpa.alter_policies('PFU_FILETYPES');


COMMENT ON TABLE BARS.PFU_FILETYPES IS '';
COMMENT ON COLUMN BARS.PFU_FILETYPES.ID IS 'Ідентифікатор файлу';
COMMENT ON COLUMN BARS.PFU_FILETYPES.NAME IS 'Опис файлу';
COMMENT ON COLUMN BARS.PFU_FILETYPES.CODE IS 'Код файлу';




PROMPT *** Create  constraint SYS_C00109484 ***
begin   
 execute immediate '
  ALTER TABLE BARS.PFU_FILETYPES MODIFY (ID NOT NULL ENABLE NOVALIDATE)';
exception when others then
  if  sqlcode=-2260 or sqlcode=-2261 or sqlcode=-2264 or sqlcode=-2275 or sqlcode=-1442 then null; else raise; end if;
 end;
/




PROMPT *** Create  constraint PK_PFU_FILETYPES ***
begin   
 execute immediate '
  ALTER TABLE BARS.PFU_FILETYPES ADD CONSTRAINT PK_PFU_FILETYPES PRIMARY KEY (ID)
  USING INDEX PCTFREE 10 INITRANS 2 MAXTRANS 255 COMPUTE STATISTICS 
  TABLESPACE BRSDYND  ENABLE';
exception when others then
  if  sqlcode=-2260 or sqlcode=-2261 or sqlcode=-2264 or sqlcode=-2275 or sqlcode=-1442 then null; else raise; end if;
 end;
/




PROMPT *** Create  index PK_PFU_FILETYPES ***
begin   
 execute immediate '
  CREATE UNIQUE INDEX BARS.PK_PFU_FILETYPES ON BARS.PFU_FILETYPES (ID) 
  PCTFREE 10 INITRANS 2 MAXTRANS 255 COMPUTE STATISTICS 
  TABLESPACE BRSDYND ';
exception when others then
  if  sqlcode=-955  then null; else raise; end if;
 end;
/





PROMPT ===================================================================================== 
PROMPT *** End *** ========== Scripts /Sql/BARS/Table/PFU_FILETYPES.sql =========*** End ***
PROMPT ===================================================================================== 
