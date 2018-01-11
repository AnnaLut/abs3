

PROMPT ===================================================================================== 
PROMPT *** Run *** ========== Scripts /Sql/BARS/Table/SPR_RNBO_CODES.sql =========*** Run **
PROMPT ===================================================================================== 


PROMPT *** ALTER_POLICY_INFO to SPR_RNBO_CODES ***


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

PROMPT *** Create  table SPR_RNBO_CODES ***
begin 
  execute immediate '
  CREATE TABLE BARS.SPR_RNBO_CODES 
   (	CODE VARCHAR2(2), 
	TXT VARCHAR2(60), 
	 CONSTRAINT PK_SPR_RNBO_CODES PRIMARY KEY (CODE) ENABLE
   ) ORGANIZATION INDEX NOCOMPRESS PCTFREE 10 INITRANS 2 MAXTRANS 255 LOGGING
  TABLESPACE BRSDYND 
 PCTTHRESHOLD 50';
exception when others then       
  if sqlcode=-955 then null; else raise; end if; 
end; 
/




PROMPT *** ALTER_POLICIES to SPR_RNBO_CODES ***
 exec bpa.alter_policies('SPR_RNBO_CODES');


COMMENT ON TABLE BARS.SPR_RNBO_CODES IS 'Довідник кодів санкцій';
COMMENT ON COLUMN BARS.SPR_RNBO_CODES.CODE IS 'Код санкції';
COMMENT ON COLUMN BARS.SPR_RNBO_CODES.TXT IS 'Текстовий опис';




PROMPT *** Create  constraint PK_SPR_RNBO_CODES ***
begin   
 execute immediate '
  ALTER TABLE BARS.SPR_RNBO_CODES ADD CONSTRAINT PK_SPR_RNBO_CODES PRIMARY KEY (CODE)
  USING INDEX PCTFREE 10 INITRANS 2 MAXTRANS 255 COMPUTE STATISTICS 
  TABLESPACE BRSDYND  ENABLE';
exception when others then
  if  sqlcode=-2260 or sqlcode=-2261 or sqlcode=-2264 or sqlcode=-2275 or sqlcode=-1442 then null; else raise; end if;
 end;
/




PROMPT *** Create  index PK_SPR_RNBO_CODES ***
begin   
 execute immediate '
  CREATE UNIQUE INDEX BARS.PK_SPR_RNBO_CODES ON BARS.SPR_RNBO_CODES (CODE) 
  PCTFREE 10 INITRANS 2 MAXTRANS 255 COMPUTE STATISTICS 
  TABLESPACE BRSDYND ';
exception when others then
  if  sqlcode=-955  then null; else raise; end if;
 end;
/



PROMPT *** Create  grants  SPR_RNBO_CODES ***
grant DELETE,INSERT,SELECT,UPDATE                                            on SPR_RNBO_CODES  to ABS_ADMIN;
grant SELECT                                                                 on SPR_RNBO_CODES  to BARS_ACCESS_DEFROLE;
grant SELECT                                                                 on SPR_RNBO_CODES  to START1;
grant DELETE,INSERT,SELECT,UPDATE                                            on SPR_RNBO_CODES  to WR_ALL_RIGHTS;



PROMPT *** Create SYNONYM  to SPR_RNBO_CODES ***

  CREATE OR REPLACE PUBLIC SYNONYM SPR_RNBO_CODES FOR BARS.SPR_RNBO_CODES;


PROMPT ===================================================================================== 
PROMPT *** End *** ========== Scripts /Sql/BARS/Table/SPR_RNBO_CODES.sql =========*** End **
PROMPT ===================================================================================== 
