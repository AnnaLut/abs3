

PROMPT ===================================================================================== 
PROMPT *** Run *** ========== Scripts /Sql/BARS/Table/BL_REASON_DICT.sql =========*** Run **
PROMPT ===================================================================================== 


PROMPT *** ALTER_POLICY_INFO to BL_REASON_DICT ***


BEGIN 
        execute immediate  
          'begin  
               bpa.alter_policy_info(''BL_REASON_DICT'', ''CENTER'' , null, null, null, null);
               bpa.alter_policy_info(''BL_REASON_DICT'', ''FILIAL'' , null, null, null, null);
               bpa.alter_policy_info(''BL_REASON_DICT'', ''WHOLE'' , null, null, null, null);
               null;
           end; 
          '; 
END; 
/

PROMPT *** Create  table BL_REASON_DICT ***
begin 
  execute immediate '
  CREATE TABLE BARS.BL_REASON_DICT 
   (	REASON_GROUP NUMBER, 
	REASON VARCHAR2(100)
   ) SEGMENT CREATION IMMEDIATE 
  PCTFREE 10 PCTUSED 40 INITRANS 1 MAXTRANS 255 
 NOCOMPRESS LOGGING
  TABLESPACE BRSSMLD ';
exception when others then       
  if sqlcode=-955 then null; else raise; end if; 
end; 
/




PROMPT *** ALTER_POLICIES to BL_REASON_DICT ***
 exec bpa.alter_policies('BL_REASON_DICT');


COMMENT ON TABLE BARS.BL_REASON_DICT IS 'ÑÏÐÀÂÎ×ÍÈÊ ÏÐÈ×ÈÍ ÏÎÑÒÀÍÎÂÊÈ Â ×ÅÐÍÛÉ ÑÏÈÑÎÊ';
COMMENT ON COLUMN BARS.BL_REASON_DICT.REASON_GROUP IS 'Link to BL_REASON';
COMMENT ON COLUMN BARS.BL_REASON_DICT.REASON IS 'Ïðè÷èíà ïîñòàíîâêè â ÷åðíûé ñïèñîê';




PROMPT *** Create  constraint BL_DICT_PK ***
begin   
 execute immediate '
  ALTER TABLE BARS.BL_REASON_DICT ADD CONSTRAINT BL_DICT_PK PRIMARY KEY (REASON_GROUP)
  USING INDEX PCTFREE 10 INITRANS 2 MAXTRANS 255 COMPUTE STATISTICS 
  TABLESPACE BRSSMLI  ENABLE';
exception when others then
  if  sqlcode=-2260 or sqlcode=-2261 or sqlcode=-2264 or sqlcode=-2275 or sqlcode=-1442 then null; else raise; end if;
 end;
/




PROMPT *** Create  index BL_DICT_I ***
begin   
 execute immediate '
  CREATE UNIQUE INDEX BARS.BL_DICT_I ON BARS.BL_REASON_DICT (REASON_GROUP) 
  PCTFREE 10 INITRANS 2 MAXTRANS 255 COMPUTE STATISTICS 
  TABLESPACE BRSSMLI ';
exception when others then
  if  sqlcode=-955  then null; else raise; end if;
 end;
/



PROMPT *** Create  grants  BL_REASON_DICT ***
grant SELECT                                                                 on BL_REASON_DICT  to BARS_DM;
grant DELETE,INSERT,SELECT,UPDATE                                            on BL_REASON_DICT  to RBL;



PROMPT ===================================================================================== 
PROMPT *** End *** ========== Scripts /Sql/BARS/Table/BL_REASON_DICT.sql =========*** End **
PROMPT ===================================================================================== 
