PROMPT ===================================================================================== 
PROMPT *** Run *** ========== Scripts /Sql/BARS/Table/OW_BATCH_FILETYPES.sql =========*** Ru
PROMPT ===================================================================================== 


PROMPT *** ALTER_POLICY_INFO to OW_BATCH_FILETYPES ***


BEGIN 
        execute immediate  
          'begin  
               bpa.alter_policy_info(''OW_BATCH_FILETYPES'', ''WHOLE'' , null, null, null, null);
               null;
           end; 
          '; 
END; 
/

PROMPT *** Create  table OW_BATCH_FILETYPES ***
begin 
  execute immediate '
  CREATE TABLE BARS.OW_BATCH_FILETYPES 
   (	ID NUMBER, 
	    DESCR VARCHAR2(250),
      CODE VARCHAR2(30)
   ) SEGMENT CREATION IMMEDIATE 
  PCTFREE 10 PCTUSED 40 INITRANS 1 MAXTRANS 255 
 NOCOMPRESS LOGGING
  TABLESPACE BRSDYND ';
exception when others then       
  if sqlcode=-955 then null; else raise; end if; 
end; 
/

-- Add/modify columns 
begin
    execute immediate 'alter table OW_BATCH_FILETYPES add code varchar2(30)';
 exception when others then 
    if sqlcode = -1430 then null; else raise; 
    end if; 
end;
/ 

PROMPT *** ALTER_POLICIES to OW_BATCH_FILETYPES ***
 exec bpa.alter_policies('OW_BATCH_FILETYPES');


COMMENT ON TABLE BARS.OW_BATCH_FILETYPES IS '';
COMMENT ON COLUMN BARS.OW_BATCH_FILETYPES.ID IS 'Ідентифікатор';
COMMENT ON COLUMN BARS.OW_BATCH_FILETYPES.DESCR IS 'Опис';
COMMENT ON COLUMN BARS.OW_BATCH_FILETYPES.CODE IS 'Код';





PROMPT *** Create  constraint PK_OW_BATCH_FILETYPES ***
begin   
 execute immediate '
  ALTER TABLE BARS.OW_BATCH_FILETYPES ADD CONSTRAINT PK_OW_BATCH_FILETYPES PRIMARY KEY (ID)
  USING INDEX PCTFREE 10 INITRANS 2 MAXTRANS 255 COMPUTE STATISTICS 
  TABLESPACE BRSDYND  ENABLE';
exception when others then
  if  sqlcode=-2260 or sqlcode=-2261 or sqlcode=-2264 or sqlcode=-2275 or sqlcode=-1442 then null; else raise; end if;
 end;
/




PROMPT *** Create  index PK_OW_BATCH_FILETYPES ***
begin   
 execute immediate '
  CREATE UNIQUE INDEX BARS.PK_OW_BATCH_FILETYPES ON BARS.OW_BATCH_FILETYPES (ID) 
  PCTFREE 10 INITRANS 2 MAXTRANS 255 COMPUTE STATISTICS 
  TABLESPACE BRSDYND ';
exception when others then
  if  sqlcode=-955  then null; else raise; end if;
 end;
/



PROMPT *** Create  grants  OW_BATCH_FILETYPES ***
grant SELECT                                                                 on OW_BATCH_FILETYPES to BARS_ACCESS_DEFROLE;



PROMPT ===================================================================================== 
PROMPT *** End *** ========== Scripts /Sql/BARS/Table/OW_BATCH_FILETYPES.sql =========*** En
PROMPT ===================================================================================== 
