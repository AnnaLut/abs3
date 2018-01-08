

PROMPT ===================================================================================== 
PROMPT *** Run *** ========== Scripts /Sql/BARS/Table/W4_STO_TTS.sql =========*** Run *** ==
PROMPT ===================================================================================== 


PROMPT *** ALTER_POLICY_INFO to W4_STO_TTS ***


BEGIN 
        execute immediate  
          'begin  
               bpa.alter_policy_info(''W4_STO_TTS'', ''CENTER'' , null, null, null, null);
               bpa.alter_policy_info(''W4_STO_TTS'', ''FILIAL'' , null, ''E'', ''E'', ''E'');
               bpa.alter_policy_info(''W4_STO_TTS'', ''WHOLE'' , null, null, null, null);
               null;
           end; 
          '; 
END; 
/

PROMPT *** Create  table W4_STO_TTS ***
begin 
  execute immediate '
  CREATE TABLE BARS.W4_STO_TTS 
   (	TT CHAR(3), 
	DESCRIPTION VARCHAR2(50)
   ) SEGMENT CREATION IMMEDIATE 
  PCTFREE 10 PCTUSED 40 INITRANS 1 MAXTRANS 255 
 NOCOMPRESS LOGGING
  TABLESPACE BRSSMLD ';
exception when others then       
  if sqlcode=-955 then null; else raise; end if; 
end; 
/




PROMPT *** ALTER_POLICIES to W4_STO_TTS ***
 exec bpa.alter_policies('W4_STO_TTS');


COMMENT ON TABLE BARS.W4_STO_TTS IS 'W4. Справочник кодов операций для регулярных платежей';
COMMENT ON COLUMN BARS.W4_STO_TTS.TT IS 'Код операции (TTS)';
COMMENT ON COLUMN BARS.W4_STO_TTS.DESCRIPTION IS 'Примечание';




PROMPT *** Create  constraint FK_TT ***
begin   
 execute immediate '
  ALTER TABLE BARS.W4_STO_TTS ADD CONSTRAINT FK_TT FOREIGN KEY (TT)
	  REFERENCES BARS.TTS (TT) ENABLE';
exception when others then
  if  sqlcode=-2260 or sqlcode=-2261 or sqlcode=-2264 or sqlcode=-2275 or sqlcode=-1442 then null; else raise; end if;
 end;
/




PROMPT *** Create  constraint CC_W4_STO_TTS_TT ***
begin   
 execute immediate '
  ALTER TABLE BARS.W4_STO_TTS MODIFY (TT CONSTRAINT CC_W4_STO_TTS_TT NOT NULL ENABLE NOVALIDATE)';
exception when others then
  if  sqlcode=-2260 or sqlcode=-2261 or sqlcode=-2264 or sqlcode=-2275 or sqlcode=-1442 then null; else raise; end if;
 end;
/



PROMPT *** Create  grants  W4_STO_TTS ***
grant DELETE,FLASHBACK,INSERT,SELECT,UPDATE                                  on W4_STO_TTS      to BARS_ACCESS_DEFROLE;
grant SELECT                                                                 on W4_STO_TTS      to BARS_DM;
grant DELETE,INSERT,SELECT,UPDATE                                            on W4_STO_TTS      to OBPC;
grant INSERT,SELECT,UPDATE                                                   on W4_STO_TTS      to OW;
grant FLASHBACK,SELECT                                                       on W4_STO_TTS      to WR_REFREAD;



PROMPT ===================================================================================== 
PROMPT *** End *** ========== Scripts /Sql/BARS/Table/W4_STO_TTS.sql =========*** End *** ==
PROMPT ===================================================================================== 
