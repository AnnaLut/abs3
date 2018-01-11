

PROMPT ===================================================================================== 
PROMPT *** Run *** ========== Scripts /Sql/BARS/Table/NLK_TT.sql =========*** Run *** ======
PROMPT ===================================================================================== 


PROMPT *** ALTER_POLICY_INFO to NLK_TT ***


BEGIN 
        execute immediate  
          'begin  
               bpa.alter_policy_info(''NLK_TT'', ''FILIAL'' , null, null, null, null);
               bpa.alter_policy_info(''NLK_TT'', ''WHOLE'' , null, null, null, null);
               null;
           end; 
          '; 
END; 
/

PROMPT *** Create  table NLK_TT ***
begin 
  execute immediate '
  CREATE TABLE BARS.NLK_TT 
   (	ID VARCHAR2(32), 
	TT CHAR(3)
   ) SEGMENT CREATION IMMEDIATE 
  PCTFREE 10 PCTUSED 40 INITRANS 1 MAXTRANS 255 
 NOCOMPRESS LOGGING
  TABLESPACE BRSDYND ';
exception when others then       
  if sqlcode=-955 then null; else raise; end if; 
end; 
/




PROMPT *** ALTER_POLICIES to NLK_TT ***
 exec bpa.alter_policies('NLK_TT');


COMMENT ON TABLE BARS.NLK_TT IS 'Перелік операцій для картотеки';
COMMENT ON COLUMN BARS.NLK_TT.ID IS 'ІД картотеки';
COMMENT ON COLUMN BARS.NLK_TT.TT IS 'Код операції операцій ';




PROMPT *** Create  constraint PK_NLKTT ***
begin   
 execute immediate '
  ALTER TABLE BARS.NLK_TT ADD CONSTRAINT PK_NLKTT PRIMARY KEY (TT, ID)
  USING INDEX PCTFREE 10 INITRANS 2 MAXTRANS 255 COMPUTE STATISTICS 
  TABLESPACE BRSDYND  ENABLE';
exception when others then
  if  sqlcode=-2260 or sqlcode=-2261 or sqlcode=-2264 or sqlcode=-2275 or sqlcode=-1442 then null; else raise; end if;
 end;
/




PROMPT *** Create  index PK_NLKTT ***
begin   
 execute immediate '
  CREATE UNIQUE INDEX BARS.PK_NLKTT ON BARS.NLK_TT (TT, ID) 
  PCTFREE 10 INITRANS 2 MAXTRANS 255 COMPUTE STATISTICS 
  TABLESPACE BRSDYND ';
exception when others then
  if  sqlcode=-955  then null; else raise; end if;
 end;
/




PROMPT *** Create  index IDX_NLKTT_I1 ***
begin   
 execute immediate '
  CREATE INDEX BARS.IDX_NLKTT_I1 ON BARS.NLK_TT (ID) 
  PCTFREE 10 INITRANS 2 MAXTRANS 255 COMPUTE STATISTICS 
  TABLESPACE BRSDYND ';
exception when others then
  if  sqlcode=-955  then null; else raise; end if;
 end;
/



PROMPT *** Create  grants  NLK_TT ***
grant SELECT                                                                 on NLK_TT          to BARSREADER_ROLE;
grant DELETE,INSERT,SELECT,UPDATE                                            on NLK_TT          to BARS_ACCESS_DEFROLE;
grant DELETE,INSERT,SELECT,UPDATE                                            on NLK_TT          to START1;
grant SELECT                                                                 on NLK_TT          to UPLD;



PROMPT ===================================================================================== 
PROMPT *** End *** ========== Scripts /Sql/BARS/Table/NLK_TT.sql =========*** End *** ======
PROMPT ===================================================================================== 
