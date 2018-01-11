

PROMPT ===================================================================================== 
PROMPT *** Run *** ========== Scripts /Sql/BARS/Table/ADR_PHONE_CODES.sql =========*** Run *
PROMPT ===================================================================================== 


PROMPT *** ALTER_POLICY_INFO to ADR_PHONE_CODES ***


BEGIN 
        execute immediate  
          'begin  
               bpa.alter_policy_info(''ADR_PHONE_CODES'', ''FILIAL'' , null, null, null, null);
               bpa.alter_policy_info(''ADR_PHONE_CODES'', ''WHOLE'' , null, null, null, null);
               null;
           end; 
          '; 
END; 
/

PROMPT *** Create  table ADR_PHONE_CODES ***
begin 
  execute immediate '
  CREATE TABLE BARS.ADR_PHONE_CODES 
   (	PHONE_CODE_ID NUMBER(10,0), 
	PHONE_CODE VARCHAR2(10), 
	PHONE_ADD_NUM VARCHAR2(10)
   ) SEGMENT CREATION IMMEDIATE 
  PCTFREE 10 PCTUSED 40 INITRANS 1 MAXTRANS 255 
 NOCOMPRESS LOGGING
  TABLESPACE BRSDYND ';
exception when others then       
  if sqlcode=-955 then null; else raise; end if; 
end; 
/




PROMPT *** ALTER_POLICIES to ADR_PHONE_CODES ***
 exec bpa.alter_policies('ADR_PHONE_CODES');


COMMENT ON TABLE BARS.ADR_PHONE_CODES IS 'Довідник телефонних кодів';
COMMENT ON COLUMN BARS.ADR_PHONE_CODES.PHONE_CODE_ID IS 'Ід. телефонного коду';
COMMENT ON COLUMN BARS.ADR_PHONE_CODES.PHONE_CODE IS 'Телефонний код';
COMMENT ON COLUMN BARS.ADR_PHONE_CODES.PHONE_ADD_NUM IS 'Додатковий номер';




PROMPT *** Create  constraint SYS_C00109433 ***
begin   
 execute immediate '
  ALTER TABLE BARS.ADR_PHONE_CODES MODIFY (PHONE_CODE_ID NOT NULL ENABLE)';
exception when others then
  if  sqlcode=-2260 or sqlcode=-2261 or sqlcode=-2264 or sqlcode=-2275 or sqlcode=-1442 then null; else raise; end if;
 end;
/




PROMPT *** Create  constraint SYS_C00109434 ***
begin   
 execute immediate '
  ALTER TABLE BARS.ADR_PHONE_CODES MODIFY (PHONE_CODE NOT NULL ENABLE)';
exception when others then
  if  sqlcode=-2260 or sqlcode=-2261 or sqlcode=-2264 or sqlcode=-2275 or sqlcode=-1442 then null; else raise; end if;
 end;
/



PROMPT *** Create  grants  ADR_PHONE_CODES ***
grant SELECT                                                                 on ADR_PHONE_CODES to BARSREADER_ROLE;
grant SELECT                                                                 on ADR_PHONE_CODES to BARSUPL;
grant SELECT                                                                 on ADR_PHONE_CODES to BARS_ACCESS_DEFROLE;
grant SELECT                                                                 on ADR_PHONE_CODES to START1;
grant SELECT                                                                 on ADR_PHONE_CODES to UPLD;



PROMPT ===================================================================================== 
PROMPT *** End *** ========== Scripts /Sql/BARS/Table/ADR_PHONE_CODES.sql =========*** End *
PROMPT ===================================================================================== 
