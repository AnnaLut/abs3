
exec bc.home;

BEGIN 
        execute immediate  
          'begin  
               bpa.alter_policy_info(''SPR_RNBO_CODES'', ''FILIAL'' , null, null, null, null);
               bpa.alter_policy_info(''SPR_RNBO_CODES'', ''WHOLE'' , null, null, null, null);
               null;
           end; 
          '; 
END; 
/

begin
    execute immediate 'DROP TABLE BARS.SPR_RNBO_CODES CASCADE CONSTRAINTS';
exception
    when others then null;
end;
/    

PROMPT      Create  SPR_RNBO_CODES
begin 
  execute immediate '
  CREATE TABLE BARS.SPR_RNBO_CODES 
   (	CODE    VARCHAR2(2), 
	TXT     VARCHAR2(60), 
	 CONSTRAINT PK_SPR_RNBO_CODES PRIMARY KEY (CODE) ENABLE
   ) ORGANIZATION INDEX LOGGING ';
exception when others then       
  if sqlcode=-955 then null; else raise; end if; 
end; 
/

COMMENT ON  TABLE BARS.SPR_RNBO_CODES IS 'Довідник кодів санкцій';
COMMENT ON COLUMN BARS.SPR_RNBO_CODES.CODE IS 'Код санкції';
COMMENT ON COLUMN BARS.SPR_RNBO_CODES.TXT  IS 'Текстовий опис';

create or replace public synonym SPR_RNBO_CODES for bars.SPR_RNBO_CODES;

PROMPT    Create  grants  SPR_RNBO_CODES

grant DELETE,INSERT,SELECT,UPDATE  on SPR_RNBO_CODES to ABS_ADMIN;
grant SELECT                       on SPR_RNBO_CODES to BARS_ACCESS_DEFROLE;
grant SELECT                       on SPR_RNBO_CODES to START1;
grant DELETE,INSERT,SELECT,UPDATE  on SPR_RNBO_CODES to WR_ALL_RIGHTS;

exec bpa.alter_policies('SPR_RNBO_CODES');

