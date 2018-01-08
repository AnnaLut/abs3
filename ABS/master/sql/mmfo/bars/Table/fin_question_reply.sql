

PROMPT ===================================================================================== 
PROMPT *** Run *** ========== Scripts /Sql/BARS/Table/FIN_QUESTION_REPLY.sql =========*** Ru
PROMPT ===================================================================================== 


PROMPT *** ALTER_POLICY_INFO to FIN_QUESTION_REPLY ***


BEGIN 
        execute immediate  
          'begin  
               bpa.alter_policy_info(''FIN_QUESTION_REPLY'', ''CENTER'' , null, null, null, null);
               bpa.alter_policy_info(''FIN_QUESTION_REPLY'', ''FILIAL'' , null, null, null, null);
               bpa.alter_policy_info(''FIN_QUESTION_REPLY'', ''WHOLE'' , null, null, null, null);
               null;
           end; 
          '; 
END; 
/

PROMPT *** Create  table FIN_QUESTION_REPLY ***
begin 
  execute immediate '
  CREATE TABLE BARS.FIN_QUESTION_REPLY 
   (	KOD VARCHAR2(4), 
	NAME VARCHAR2(160), 
	ORD NUMBER(*,0), 
	VAL NUMBER(38,2), 
	IDF NUMBER(*,0), 
	REPL_S NUMBER(35,2), 
	NAMEP VARCHAR2(170)
   ) SEGMENT CREATION IMMEDIATE 
  PCTFREE 10 PCTUSED 40 INITRANS 1 MAXTRANS 255 
 NOCOMPRESS LOGGING
  TABLESPACE BRSDYND ';
exception when others then       
  if sqlcode=-955 then null; else raise; end if; 
end; 
/




PROMPT *** ALTER_POLICIES to FIN_QUESTION_REPLY ***
 exec bpa.alter_policies('FIN_QUESTION_REPLY');


COMMENT ON TABLE BARS.FIN_QUESTION_REPLY IS ' Відповіді інтегральних показників НБУ№23';
COMMENT ON COLUMN BARS.FIN_QUESTION_REPLY.KOD IS 'Код ІП';
COMMENT ON COLUMN BARS.FIN_QUESTION_REPLY.NAME IS 'Текст відповіді ІП';
COMMENT ON COLUMN BARS.FIN_QUESTION_REPLY.ORD IS '№ п/п';
COMMENT ON COLUMN BARS.FIN_QUESTION_REPLY.VAL IS 'Значення';
COMMENT ON COLUMN BARS.FIN_QUESTION_REPLY.IDF IS '';
COMMENT ON COLUMN BARS.FIN_QUESTION_REPLY.REPL_S IS '';
COMMENT ON COLUMN BARS.FIN_QUESTION_REPLY.NAMEP IS 'Текст відповіді ІП (повна)';




PROMPT *** Create  constraint UK_FINQUESTIONREPLY ***
begin   
 execute immediate '
  ALTER TABLE BARS.FIN_QUESTION_REPLY ADD CONSTRAINT UK_FINQUESTIONREPLY UNIQUE (KOD, IDF, ORD)
  USING INDEX PCTFREE 10 INITRANS 2 MAXTRANS 255 COMPUTE STATISTICS 
  TABLESPACE BRSDYND  ENABLE';
exception when others then
  if  sqlcode=-2260 or sqlcode=-2261 or sqlcode=-2264 or sqlcode=-2275 or sqlcode=-1442 then null; else raise; end if;
 end;
/




PROMPT *** Create  index UK_FINQUESTIONREPLY ***
begin   
 execute immediate '
  CREATE UNIQUE INDEX BARS.UK_FINQUESTIONREPLY ON BARS.FIN_QUESTION_REPLY (KOD, IDF, ORD) 
  PCTFREE 10 INITRANS 2 MAXTRANS 255 COMPUTE STATISTICS 
  TABLESPACE BRSDYND ';
exception when others then
  if  sqlcode=-955  then null; else raise; end if;
 end;
/



PROMPT *** Create  grants  FIN_QUESTION_REPLY ***
grant SELECT                                                                 on FIN_QUESTION_REPLY to BARSREADER_ROLE;
grant DELETE,FLASHBACK,INSERT,SELECT,UPDATE                                  on FIN_QUESTION_REPLY to BARS_ACCESS_DEFROLE;
grant SELECT                                                                 on FIN_QUESTION_REPLY to BARS_DM;
grant SELECT                                                                 on FIN_QUESTION_REPLY to UPLD;



PROMPT ===================================================================================== 
PROMPT *** End *** ========== Scripts /Sql/BARS/Table/FIN_QUESTION_REPLY.sql =========*** En
PROMPT ===================================================================================== 
