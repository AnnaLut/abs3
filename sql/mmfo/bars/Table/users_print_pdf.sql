

PROMPT ===================================================================================== 
PROMPT *** Run *** ========== Scripts /Sql/BARS/Table/USERS_PRINT_PDF.sql =========*** Run *
PROMPT ===================================================================================== 


PROMPT *** ALTER_POLICY_INFO to USERS_PRINT_PDF ***


BEGIN 
        execute immediate  
          'begin  
               bpa.alter_policy_info(''USERS_PRINT_PDF'', ''CENTER'' , null, null, null, null);
               bpa.alter_policy_info(''USERS_PRINT_PDF'', ''FILIAL'' , null, null, null, null);
               bpa.alter_policy_info(''USERS_PRINT_PDF'', ''WHOLE'' , null, null, null, null);
               null;
           end; 
          '; 
END; 
/

PROMPT *** Create  table USERS_PRINT_PDF ***
begin 
  execute immediate '
  CREATE TABLE BARS.USERS_PRINT_PDF 
   (	ID NUMBER(*,0), 
	PRINT_PDF VARCHAR2(1)
   ) SEGMENT CREATION DEFERRED 
  PCTFREE 10 PCTUSED 40 INITRANS 1 MAXTRANS 255 
 NOCOMPRESS LOGGING
  TABLESPACE BRSDYND ';
exception when others then       
  if sqlcode=-955 then null; else raise; end if; 
end; 
/




PROMPT *** ALTER_POLICIES to USERS_PRINT_PDF ***
 exec bpa.alter_policies('USERS_PRINT_PDF');


COMMENT ON TABLE BARS.USERS_PRINT_PDF IS 'Перелік користувачів для друку квитанцій в форматі PDF';
COMMENT ON COLUMN BARS.USERS_PRINT_PDF.ID IS 'Ід. користувача';
COMMENT ON COLUMN BARS.USERS_PRINT_PDF.PRINT_PDF IS 'Друк PDF 1-так, 2-ні';



PROMPT *** Create  grants  USERS_PRINT_PDF ***
grant SELECT                                                                 on USERS_PRINT_PDF to BARS_ACCESS_DEFROLE;



PROMPT ===================================================================================== 
PROMPT *** End *** ========== Scripts /Sql/BARS/Table/USERS_PRINT_PDF.sql =========*** End *
PROMPT ===================================================================================== 
