

PROMPT ===================================================================================== 
PROMPT *** Run *** ========== Scripts /Sql/PFU/Table/PFU_EPP_BRANCH.sql =========*** Run ***
PROMPT ===================================================================================== 


PROMPT *** Create  table PFU_EPP_BRANCH ***
begin 
  execute immediate '
  CREATE TABLE PFU.PFU_EPP_BRANCH 
   (	BRANCH VARCHAR2(30), 
	NAME VARCHAR2(70), 
	EPPWORK NUMBER(1,0) DEFAULT 0, 
	DATE_OPENED DATE, 
	DATE_CLOSED DATE
   ) SEGMENT CREATION DEFERRED 
  PCTFREE 10 PCTUSED 40 INITRANS 1 MAXTRANS 255 
 NOCOMPRESS LOGGING
  TABLESPACE BRSBIGD ';
exception when others then       
  if sqlcode=-955 then null; else raise; end if; 
end; 
/


COMMENT ON TABLE PFU.PFU_EPP_BRANCH IS 'Бранчи с признаком работы с ЕПП';
COMMENT ON COLUMN PFU.PFU_EPP_BRANCH.BRANCH IS '';
COMMENT ON COLUMN PFU.PFU_EPP_BRANCH.NAME IS '';
COMMENT ON COLUMN PFU.PFU_EPP_BRANCH.EPPWORK IS '';
COMMENT ON COLUMN PFU.PFU_EPP_BRANCH.DATE_OPENED IS '';
COMMENT ON COLUMN PFU.PFU_EPP_BRANCH.DATE_CLOSED IS '';





PROMPT ===================================================================================== 
PROMPT *** End *** ========== Scripts /Sql/PFU/Table/PFU_EPP_BRANCH.sql =========*** End ***
PROMPT ===================================================================================== 
