

PROMPT ===================================================================================== 
PROMPT *** Run *** ========== Scripts /Sql/BARS/Table/PFU_EPP_KILLED.sql =========*** Run **
PROMPT ===================================================================================== 


PROMPT *** ALTER_POLICY_INFO to PFU_EPP_KILLED ***


BEGIN 
        execute immediate  
          'begin  
               bpa.alter_policy_info(''PFU_EPP_KILLED'', ''FILIAL'' , null, null, null, null);
               bpa.alter_policy_info(''PFU_EPP_KILLED'', ''WHOLE'' , null, null, null, null);
               null;
           end; 
          '; 
END; 
/

PROMPT *** Create  table PFU_EPP_KILLED ***
begin 
  execute immediate '
  CREATE TABLE BARS.PFU_EPP_KILLED 
   (	EPP_NUMBER VARCHAR2(12), 
	KILL_TYPE NUMBER(1,0), 
	KILL_DATE DATE, 
	STATE NUMBER(1,0)
   ) SEGMENT CREATION IMMEDIATE 
  PCTFREE 10 PCTUSED 40 INITRANS 1 MAXTRANS 255 
 NOCOMPRESS LOGGING
  TABLESPACE BRSMDLI ';
exception when others then       
  if sqlcode=-955 then null; else raise; end if; 
end; 
/




PROMPT *** ALTER_POLICIES to PFU_EPP_KILLED ***
 exec bpa.alter_policies('PFU_EPP_KILLED');


COMMENT ON TABLE BARS.PFU_EPP_KILLED IS 'Информация по причинам удаления ЕПП';
COMMENT ON COLUMN BARS.PFU_EPP_KILLED.EPP_NUMBER IS '';
COMMENT ON COLUMN BARS.PFU_EPP_KILLED.KILL_TYPE IS '';
COMMENT ON COLUMN BARS.PFU_EPP_KILLED.KILL_DATE IS '';
COMMENT ON COLUMN BARS.PFU_EPP_KILLED.STATE IS '';




PROMPT *** Create  constraint SYS_C00109506 ***
begin   
 execute immediate '
  ALTER TABLE BARS.PFU_EPP_KILLED MODIFY (EPP_NUMBER NOT NULL ENABLE)';
exception when others then
  if  sqlcode=-2260 or sqlcode=-2261 or sqlcode=-2264 or sqlcode=-2275 or sqlcode=-1442 then null; else raise; end if;
 end;
/




PROMPT *** Create  constraint SYS_C00109507 ***
begin   
 execute immediate '
  ALTER TABLE BARS.PFU_EPP_KILLED MODIFY (KILL_TYPE NOT NULL ENABLE)';
exception when others then
  if  sqlcode=-2260 or sqlcode=-2261 or sqlcode=-2264 or sqlcode=-2275 or sqlcode=-1442 then null; else raise; end if;
 end;
/




PROMPT *** Create  constraint SYS_C00109508 ***
begin   
 execute immediate '
  ALTER TABLE BARS.PFU_EPP_KILLED MODIFY (KILL_DATE NOT NULL ENABLE)';
exception when others then
  if  sqlcode=-2260 or sqlcode=-2261 or sqlcode=-2264 or sqlcode=-2275 or sqlcode=-1442 then null; else raise; end if;
 end;
/




PROMPT *** Create  constraint SYS_C00109509 ***
begin   
 execute immediate '
  ALTER TABLE BARS.PFU_EPP_KILLED MODIFY (STATE NOT NULL ENABLE)';
exception when others then
  if  sqlcode=-2260 or sqlcode=-2261 or sqlcode=-2264 or sqlcode=-2275 or sqlcode=-1442 then null; else raise; end if;
 end;
/



PROMPT *** Create  grants  PFU_EPP_KILLED ***
grant SELECT                                                                 on PFU_EPP_KILLED  to BARSREADER_ROLE;
grant SELECT                                                                 on PFU_EPP_KILLED  to BARS_ACCESS_DEFROLE;
grant SELECT                                                                 on PFU_EPP_KILLED  to UPLD;



PROMPT ===================================================================================== 
PROMPT *** End *** ========== Scripts /Sql/BARS/Table/PFU_EPP_KILLED.sql =========*** End **
PROMPT ===================================================================================== 
