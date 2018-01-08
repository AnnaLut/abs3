

PROMPT ===================================================================================== 
PROMPT *** Run *** ========== Scripts /Sql/BARS/Table/NRU_BAL.sql =========*** Run *** =====
PROMPT ===================================================================================== 


PROMPT *** ALTER_POLICY_INFO to NRU_BAL ***


BEGIN 
        execute immediate  
          'begin  
               bpa.alter_policy_info(''NRU_BAL'', ''FILIAL'' , null, null, null, null);
               bpa.alter_policy_info(''NRU_BAL'', ''WHOLE'' , null, null, null, null);
               null;
           end; 
          '; 
END; 
/

PROMPT *** Create  table NRU_BAL ***
begin 
  execute immediate '
  CREATE TABLE BARS.NRU_BAL 
   (	NBS CHAR(4), 
	OB22 CHAR(2)
   ) SEGMENT CREATION IMMEDIATE 
  PCTFREE 10 PCTUSED 40 INITRANS 1 MAXTRANS 255 
 NOCOMPRESS LOGGING
  TABLESPACE BRSDYND ';
exception when others then       
  if sqlcode=-955 then null; else raise; end if; 
end; 
/




PROMPT *** ALTER_POLICIES to NRU_BAL ***
 exec bpa.alter_policies('NRU_BAL');


COMMENT ON TABLE BARS.NRU_BAL IS 'Перелік бал.рах та аналітик для визначення НЕРУХОМИХ по ЮО';
COMMENT ON COLUMN BARS.NRU_BAL.NBS IS 'Бал.рах';
COMMENT ON COLUMN BARS.NRU_BAL.OB22 IS 'Аналітика об22';





PROMPT ===================================================================================== 
PROMPT *** End *** ========== Scripts /Sql/BARS/Table/NRU_BAL.sql =========*** End *** =====
PROMPT ===================================================================================== 
