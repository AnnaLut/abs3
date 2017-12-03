PROMPT ===================================================================================== 
PROMPT *** Run *** ========== Scripts /Sql/BARS/Table/CP_REFW.sql =========*** Run *** =====
PROMPT ===================================================================================== 


PROMPT *** ALTER_POLICY_INFO to CP_REFW ***
BEGIN 
        execute immediate  
          'begin  
               bpa.alter_policy_info(''CP_REFW'', ''CENTER'' , null, null, null, null);
               bpa.alter_policy_info(''CP_REFW'', ''FILIAL'' , null, null, null, null);
               bpa.alter_policy_info(''CP_REFW'', ''WHOLE'' , null, null, null, null);
               null;
           end; 
          '; 
END; 
/

PROMPT *** Create  table CP_REFW ***
begin 
  execute immediate '
  CREATE TABLE BARS.CP_REFW 
   (  REF NUMBER, 
  TAG VARCHAR2(7), 
  VALUE VARCHAR2(500)
   ) SEGMENT CREATION IMMEDIATE 
  PCTFREE 10 PCTUSED 40 INITRANS 1 MAXTRANS 255 
 NOCOMPRESS LOGGING
  TABLESPACE BRSDYND ';
exception when others then       
  if sqlcode=-955 then null; else raise; end if; 
end; 
/




PROMPT *** ALTER_POLICIES to CP_REFW ***
 begin
    bpa.alter_policies('CP_REFW');
end;
/

COMMENT ON TABLE BARS.CP_REFW IS 'дод. реквізити угод';
COMMENT ON COLUMN BARS.CP_REFW.REF IS 'REF сделки по ЦБ';
COMMENT ON COLUMN BARS.CP_REFW.TAG IS 'ТЭГ -мнем.код доп.реквизита';
COMMENT ON COLUMN BARS.CP_REFW.VALUE IS 'Значение доп.реквизита';




PROMPT *** Create  constraint XPK_CPREFW ***
begin   
 execute immediate '
  ALTER TABLE BARS.CP_REFW ADD CONSTRAINT XPK_CPREFW PRIMARY KEY (REF, TAG)
  USING INDEX PCTFREE 10 INITRANS 2 MAXTRANS 255 COMPUTE STATISTICS 
  TABLESPACE BRSDYND  ENABLE NOVALIDATE';
exception when others then
  if  sqlcode=-2260 or sqlcode=-2261 or sqlcode=-2264 or sqlcode=-2275 or sqlcode=-1442 then null; else raise; end if;
 end;
/

PROMPT *** MODIFY COLUMN  TAG***
begin   
 execute immediate 'ALTER TABLE BARS.CP_REFW MODIFY TAG VARCHAR2(7)';
 end;
/


PROMPT *** Create  index XPK_CPREFW ***
begin   
 execute immediate '
  CREATE UNIQUE INDEX BARS.XPK_CPREFW ON BARS.CP_REFW (REF, TAG) 
  PCTFREE 10 INITRANS 2 MAXTRANS 255 COMPUTE STATISTICS 
  TABLESPACE BRSDYND ';
exception when others then
  if  sqlcode=-955  then null; else raise; end if;
 end;
/



PROMPT *** Create  grants  CP_REFW ***
grant SELECT                                                                 on CP_REFW         to BARSUPL;
grant SELECT                                                                 on CP_REFW         to BARS_ACCESS_DEFROLE;
grant SELECT                                                                 on CP_REFW         to BARS_DM;
grant SELECT                                                                 on CP_REFW         to UPLD;



PROMPT ===================================================================================== 
PROMPT *** End *** ========== Scripts /Sql/BARS/Table/CP_REFW.sql =========*** End *** =====
PROMPT ===================================================================================== 
