

PROMPT ===================================================================================== 
PROMPT *** Run *** ========== Scripts /Sql/BARS/Table/TMP_BANK_EMPLOYEE_PROT.sql =========**
PROMPT ===================================================================================== 


PROMPT *** ALTER_POLICY_INFO to TMP_BANK_EMPLOYEE_PROT ***


BEGIN 
        execute immediate  
          'begin  
               null;
           end; 
          '; 
END; 
/

PROMPT *** Create  table TMP_BANK_EMPLOYEE_PROT ***
begin 
  execute immediate '
  CREATE TABLE BARS.TMP_BANK_EMPLOYEE_PROT 
   (	PL VARCHAR2(64), 
	NMK VARCHAR2(70), 
	OKPO VARCHAR2(14), 
	SER VARCHAR2(10), 
	NUMDOC VARCHAR2(10)
   ) SEGMENT CREATION IMMEDIATE 
  PCTFREE 10 PCTUSED 40 INITRANS 1 MAXTRANS 255 
 NOCOMPRESS LOGGING
  TABLESPACE BRSDYND ';
exception when others then       
  if sqlcode=-955 then null; else raise; end if; 
end; 
/




PROMPT *** ALTER_POLICIES to TMP_BANK_EMPLOYEE_PROT ***
 exec bpa.alter_policies('TMP_BANK_EMPLOYEE_PROT');


COMMENT ON TABLE BARS.TMP_BANK_EMPLOYEE_PROT IS '';
COMMENT ON COLUMN BARS.TMP_BANK_EMPLOYEE_PROT.PL IS 'Результат імпорту';
COMMENT ON COLUMN BARS.TMP_BANK_EMPLOYEE_PROT.NMK IS 'Назва клієнта';
COMMENT ON COLUMN BARS.TMP_BANK_EMPLOYEE_PROT.OKPO IS 'Ідентифікаційний код';
COMMENT ON COLUMN BARS.TMP_BANK_EMPLOYEE_PROT.SER IS 'Серія документа';
COMMENT ON COLUMN BARS.TMP_BANK_EMPLOYEE_PROT.NUMDOC IS 'Номер документа';



PROMPT *** Create  grants  TMP_BANK_EMPLOYEE_PROT ***
grant SELECT                                                                 on TMP_BANK_EMPLOYEE_PROT to BARS_ACCESS_DEFROLE;
grant SELECT                                                                 on TMP_BANK_EMPLOYEE_PROT to RCC_DEAL;
grant SELECT                                                                 on TMP_BANK_EMPLOYEE_PROT to START1;



PROMPT ===================================================================================== 
PROMPT *** End *** ========== Scripts /Sql/BARS/Table/TMP_BANK_EMPLOYEE_PROT.sql =========**
PROMPT ===================================================================================== 
