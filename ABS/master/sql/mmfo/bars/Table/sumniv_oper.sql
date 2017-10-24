

PROMPT ===================================================================================== 
PROMPT *** Run *** ========== Scripts /Sql/BARS/Table/SUMNIV_OPER.sql =========*** Run *** =
PROMPT ===================================================================================== 


PROMPT *** ALTER_POLICY_INFO to SUMNIV_OPER ***


BEGIN 
        execute immediate  
          'begin  
               bpa.alter_policy_info(''SUMNIV_OPER'', ''CENTER'' , null, null, null, null);
               bpa.alter_policy_info(''SUMNIV_OPER'', ''FILIAL'' , null, null, null, null);
               bpa.alter_policy_info(''SUMNIV_OPER'', ''WHOLE'' , null, null, null, null);
               null;
           end; 
          '; 
END; 
/

PROMPT *** Create  table SUMNIV_OPER ***
begin 
  execute immediate '
  CREATE TABLE BARS.SUMNIV_OPER 
   (	CODE NUMBER, 
	NAME VARCHAR2(35), 
	SEMANTIC VARCHAR2(70)
   ) SEGMENT CREATION IMMEDIATE 
  PCTFREE 10 PCTUSED 40 INITRANS 1 MAXTRANS 255 
 NOCOMPRESS LOGGING
  TABLESPACE BRSDYND ';
exception when others then       
  if sqlcode=-955 then null; else raise; end if; 
end; 
/




PROMPT *** ALTER_POLICIES to SUMNIV_OPER ***
 exec bpa.alter_policies('SUMNIV_OPER');


COMMENT ON TABLE BARS.SUMNIV_OPER IS '';
COMMENT ON COLUMN BARS.SUMNIV_OPER.CODE IS '';
COMMENT ON COLUMN BARS.SUMNIV_OPER.NAME IS '';
COMMENT ON COLUMN BARS.SUMNIV_OPER.SEMANTIC IS '';




PROMPT *** Create  constraint XPK_SUMNIV_OPER ***
begin   
 execute immediate '
  ALTER TABLE BARS.SUMNIV_OPER ADD CONSTRAINT XPK_SUMNIV_OPER PRIMARY KEY (CODE)
  USING INDEX PCTFREE 10 INITRANS 2 MAXTRANS 255 COMPUTE STATISTICS 
  TABLESPACE BRSDYND  ENABLE';
exception when others then
  if  sqlcode=-2260 or sqlcode=-2261 or sqlcode=-2264 or sqlcode=-2275 or sqlcode=-1442 then null; else raise; end if;
 end;
/




PROMPT *** Create  constraint SYS_C006547 ***
begin   
 execute immediate '
  ALTER TABLE BARS.SUMNIV_OPER MODIFY (CODE NOT NULL ENABLE)';
exception when others then
  if  sqlcode=-2260 or sqlcode=-2261 or sqlcode=-2264 or sqlcode=-2275 or sqlcode=-1442 then null; else raise; end if;
 end;
/




PROMPT *** Create  index XPK_SUMNIV_OPER ***
begin   
 execute immediate '
  CREATE UNIQUE INDEX BARS.XPK_SUMNIV_OPER ON BARS.SUMNIV_OPER (CODE) 
  PCTFREE 10 INITRANS 2 MAXTRANS 255 COMPUTE STATISTICS 
  TABLESPACE BRSDYND ';
exception when others then
  if  sqlcode=-955  then null; else raise; end if;
 end;
/



PROMPT *** Create  grants  SUMNIV_OPER ***
grant DELETE,FLASHBACK,INSERT,SELECT,UPDATE                                  on SUMNIV_OPER     to BARS_ACCESS_DEFROLE;
grant SELECT                                                                 on SUMNIV_OPER     to BARS_DM;
grant DELETE,INSERT,SELECT,UPDATE                                            on SUMNIV_OPER     to FLAGS;
grant FLASHBACK,SELECT                                                       on SUMNIV_OPER     to WR_REFREAD;



PROMPT ===================================================================================== 
PROMPT *** End *** ========== Scripts /Sql/BARS/Table/SUMNIV_OPER.sql =========*** End *** =
PROMPT ===================================================================================== 
