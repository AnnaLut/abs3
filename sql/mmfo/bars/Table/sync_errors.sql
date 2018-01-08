

PROMPT ===================================================================================== 
PROMPT *** Run *** ========== Scripts /Sql/BARS/Table/SYNC_ERRORS.sql =========*** Run *** =
PROMPT ===================================================================================== 


PROMPT *** ALTER_POLICY_INFO to SYNC_ERRORS ***


BEGIN 
        execute immediate  
          'begin  
               bpa.alter_policy_info(''SYNC_ERRORS'', ''CENTER'' , null, null, null, null);
               bpa.alter_policy_info(''SYNC_ERRORS'', ''FILIAL'' , null, null, null, null);
               bpa.alter_policy_info(''SYNC_ERRORS'', ''WHOLE'' , null, null, null, null);
               null;
           end; 
          '; 
END; 
/

PROMPT *** Create  table SYNC_ERRORS ***
begin 
  execute immediate '
  CREATE GLOBAL TEMPORARY TABLE BARS.SYNC_ERRORS 
   (	COMPONENT VARCHAR2(32), 
	ERR_TXT VARCHAR2(4000)
   ) ON COMMIT PRESERVE ROWS ';
exception when others then       
  if sqlcode=-955 then null; else raise; end if; 
end; 
/




PROMPT *** ALTER_POLICIES to SYNC_ERRORS ***
 exec bpa.alter_policies('SYNC_ERRORS');


COMMENT ON TABLE BARS.SYNC_ERRORS IS 'Тимчасова таблиця результатів (помилок) виконання компонентів WEB-сервісу передачі даних';
COMMENT ON COLUMN BARS.SYNC_ERRORS.COMPONENT IS 'Позначення компоненту';
COMMENT ON COLUMN BARS.SYNC_ERRORS.ERR_TXT IS 'Опис результату виконання (помилки)';




PROMPT *** Create  constraint PK_SYNCERRORS ***
begin   
 execute immediate '
  ALTER TABLE BARS.SYNC_ERRORS ADD CONSTRAINT PK_SYNCERRORS PRIMARY KEY (COMPONENT) ENABLE';
exception when others then
  if  sqlcode=-2260 or sqlcode=-2261 or sqlcode=-2264 or sqlcode=-2275 or sqlcode=-1442 then null; else raise; end if;
 end;
/




PROMPT *** Create  index PK_SYNCERRORS ***
begin   
 execute immediate '
  CREATE UNIQUE INDEX BARS.PK_SYNCERRORS ON BARS.SYNC_ERRORS (COMPONENT) ';
exception when others then
  if  sqlcode=-955  then null; else raise; end if;
 end;
/



PROMPT *** Create  grants  SYNC_ERRORS ***
grant DELETE,INSERT,SELECT,UPDATE                                            on SYNC_ERRORS     to BARS_ACCESS_DEFROLE;
grant DELETE,INSERT,SELECT,UPDATE                                            on SYNC_ERRORS     to CIM_ROLE;



PROMPT ===================================================================================== 
PROMPT *** End *** ========== Scripts /Sql/BARS/Table/SYNC_ERRORS.sql =========*** End *** =
PROMPT ===================================================================================== 
