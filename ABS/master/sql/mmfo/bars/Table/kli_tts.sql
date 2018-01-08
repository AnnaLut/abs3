

PROMPT ===================================================================================== 
PROMPT *** Run *** ========== Scripts /Sql/BARS/Table/KLI_TTS.sql =========*** Run *** =====
PROMPT ===================================================================================== 


PROMPT *** ALTER_POLICY_INFO to KLI_TTS ***


BEGIN 
        execute immediate  
          'begin  
               bpa.alter_policy_info(''KLI_TTS'', ''CENTER'' , null, ''E'', ''E'', ''E'');
               bpa.alter_policy_info(''KLI_TTS'', ''FILIAL'' , ''M'', ''M'', ''M'', ''M'');
               bpa.alter_policy_info(''KLI_TTS'', ''WHOLE'' , null, ''E'', ''E'', ''E'');
               null;
           end; 
          '; 
END; 
/

PROMPT *** Create  table KLI_TTS ***
begin 
  execute immediate '
  CREATE TABLE BARS.KLI_TTS 
   (	TIP VARCHAR2(3), 
	TTS CHAR(3), 
	KF VARCHAR2(6) DEFAULT sys_context(''bars_context'',''user_mfo'')
   ) SEGMENT CREATION IMMEDIATE 
  PCTFREE 10 PCTUSED 40 INITRANS 1 MAXTRANS 255 
 NOCOMPRESS LOGGING
  TABLESPACE BRSDYND ';
exception when others then       
  if sqlcode=-955 then null; else raise; end if; 
end; 
/




PROMPT *** ALTER_POLICIES to KLI_TTS ***
 exec bpa.alter_policies('KLI_TTS');


COMMENT ON TABLE BARS.KLI_TTS IS 'Справочник автоматических операций КЛИЕНТ-БАНК';
COMMENT ON COLUMN BARS.KLI_TTS.TIP IS 'Тип документа';
COMMENT ON COLUMN BARS.KLI_TTS.TTS IS 'Код операции';
COMMENT ON COLUMN BARS.KLI_TTS.KF IS '';




PROMPT *** Create  constraint FK_KLI_TTS_TTS ***
begin   
 execute immediate '
  ALTER TABLE BARS.KLI_TTS ADD CONSTRAINT FK_KLI_TTS_TTS FOREIGN KEY (TTS)
	  REFERENCES BARS.TTS (TT) ENABLE';
exception when others then
  if  sqlcode=-2260 or sqlcode=-2261 or sqlcode=-2264 or sqlcode=-2275 or sqlcode=-1442 then null; else raise; end if;
 end;
/




PROMPT *** Create  constraint CC_KLI_TTS_KF_NN ***
begin   
 execute immediate '
  ALTER TABLE BARS.KLI_TTS MODIFY (KF CONSTRAINT CC_KLI_TTS_KF_NN NOT NULL ENABLE)';
exception when others then
  if  sqlcode=-2260 or sqlcode=-2261 or sqlcode=-2264 or sqlcode=-2275 or sqlcode=-1442 then null; else raise; end if;
 end;
/



PROMPT *** Create  grants  KLI_TTS ***
grant DELETE,INSERT,SELECT,UPDATE                                            on KLI_TTS         to ABS_ADMIN;
grant DELETE,FLASHBACK,INSERT,SELECT,UPDATE                                  on KLI_TTS         to BARS_ACCESS_DEFROLE;
grant DELETE,INSERT,SELECT,UPDATE                                            on KLI_TTS         to TECH_MOM1;
grant FLASHBACK,SELECT                                                       on KLI_TTS         to WR_REFREAD;



PROMPT *** Create SYNONYM  to KLI_TTS ***

  CREATE OR REPLACE PUBLIC SYNONYM KLI_TTS FOR BARS.KLI_TTS;


PROMPT ===================================================================================== 
PROMPT *** End *** ========== Scripts /Sql/BARS/Table/KLI_TTS.sql =========*** End *** =====
PROMPT ===================================================================================== 
