

PROMPT ===================================================================================== 
PROMPT *** Run *** ========== Scripts /Sql/BARS/Table/CP_EMI.sql =========*** Run *** ======
PROMPT ===================================================================================== 


PROMPT *** ALTER_POLICY_INFO to CP_EMI ***


BEGIN 
        execute immediate  
          'begin  
               bpa.alter_policy_info(''CP_EMI'', ''CENTER'' , null, null, null, null);
               bpa.alter_policy_info(''CP_EMI'', ''FILIAL'' , null, ''E'', ''E'', ''E'');
               bpa.alter_policy_info(''CP_EMI'', ''WHOLE'' , null, null, null, null);
               null;
           end; 
          '; 
END; 
/

PROMPT *** Create  table CP_EMI ***
begin 
  execute immediate '
  CREATE TABLE BARS.CP_EMI 
   (	EMI NUMBER, 
	NAME VARCHAR2(70)
   ) SEGMENT CREATION IMMEDIATE 
  PCTFREE 10 PCTUSED 40 INITRANS 1 MAXTRANS 255 
 NOCOMPRESS LOGGING
  TABLESPACE BRSDYND ';
exception when others then       
  if sqlcode=-955 then null; else raise; end if; 
end; 
/




PROMPT *** ALTER_POLICIES to CP_EMI ***
 exec bpa.alter_policies('CP_EMI');


COMMENT ON TABLE BARS.CP_EMI IS 'Довiдник типiв емiтента';
COMMENT ON COLUMN BARS.CP_EMI.EMI IS 'Код типу (внутр.)';
COMMENT ON COLUMN BARS.CP_EMI.NAME IS 'Назва типу емiтента';




PROMPT *** Create  constraint XPK_CP_EMI ***
begin   
 execute immediate '
  ALTER TABLE BARS.CP_EMI ADD CONSTRAINT XPK_CP_EMI PRIMARY KEY (EMI)
  USING INDEX PCTFREE 10 INITRANS 2 MAXTRANS 255 COMPUTE STATISTICS 
  TABLESPACE BRSDYND  ENABLE';
exception when others then
  if  sqlcode=-2260 or sqlcode=-2261 or sqlcode=-2264 or sqlcode=-2275 or sqlcode=-1442 then null; else raise; end if;
 end;
/




PROMPT *** Create  constraint SYS_C007802 ***
begin   
 execute immediate '
  ALTER TABLE BARS.CP_EMI MODIFY (EMI NOT NULL ENABLE)';
exception when others then
  if  sqlcode=-2260 or sqlcode=-2261 or sqlcode=-2264 or sqlcode=-2275 or sqlcode=-1442 then null; else raise; end if;
 end;
/




PROMPT *** Create  index XPK_CP_EMI ***
begin   
 execute immediate '
  CREATE UNIQUE INDEX BARS.XPK_CP_EMI ON BARS.CP_EMI (EMI) 
  PCTFREE 10 INITRANS 2 MAXTRANS 255 COMPUTE STATISTICS 
  TABLESPACE BRSDYND ';
exception when others then
  if  sqlcode=-955  then null; else raise; end if;
 end;
/



PROMPT *** Create  grants  CP_EMI ***
grant SELECT                                                                 on CP_EMI          to BARSUPL;
grant DELETE,FLASHBACK,INSERT,SELECT,UPDATE                                  on CP_EMI          to BARS_ACCESS_DEFROLE;
grant SELECT                                                                 on CP_EMI          to BARS_DM;
grant DELETE,INSERT,SELECT,UPDATE                                            on CP_EMI          to CP_ROLE;
grant DELETE,INSERT,SELECT,UPDATE                                            on CP_EMI          to START1;
grant SELECT                                                                 on CP_EMI          to UPLD;
grant FLASHBACK,SELECT                                                       on CP_EMI          to WR_REFREAD;



PROMPT ===================================================================================== 
PROMPT *** End *** ========== Scripts /Sql/BARS/Table/CP_EMI.sql =========*** End *** ======
PROMPT ===================================================================================== 
