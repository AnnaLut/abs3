

PROMPT ===================================================================================== 
PROMPT *** Run *** ========== Scripts /Sql/BARS/Table/NOTARY_OB22.sql =========*** Run *** =
PROMPT ===================================================================================== 


PROMPT *** ALTER_POLICY_INFO to NOTARY_OB22 ***


BEGIN 
        execute immediate  
          'begin  
               bpa.alter_policy_info(''NOTARY_OB22'', ''CENTER'' , null, ''E'', ''E'', ''E'');
               bpa.alter_policy_info(''NOTARY_OB22'', ''FILIAL'' , ''M'', ''M'', ''M'', ''M'');
               bpa.alter_policy_info(''NOTARY_OB22'', ''WHOLE'' , null, ''E'', ''E'', ''E'');
               null;
           end; 
          '; 
END; 
/

PROMPT *** Create  table NOTARY_OB22 ***
begin 
  execute immediate '
  CREATE TABLE BARS.NOTARY_OB22 
   (	NBS CHAR(4), 
	OB22 CHAR(2), 
	CODE NUMBER(*,0), 
	NAME VARCHAR2(200)
   ) SEGMENT CREATION IMMEDIATE 
  PCTFREE 10 PCTUSED 40 INITRANS 1 MAXTRANS 255 
 NOCOMPRESS LOGGING
  TABLESPACE BRSDYND ';
exception when others then       
  if sqlcode=-955 then null; else raise; end if; 
end; 
/




PROMPT *** ALTER_POLICIES to NOTARY_OB22 ***
 exec bpa.alter_policies('NOTARY_OB22');


COMMENT ON TABLE BARS.NOTARY_OB22 IS 'Довідник ОБ22 кредитів оформлених за участі нотаріусів';
COMMENT ON COLUMN BARS.NOTARY_OB22.NBS IS 'Балансовий рахунок';
COMMENT ON COLUMN BARS.NOTARY_OB22.OB22 IS 'OB22';
COMMENT ON COLUMN BARS.NOTARY_OB22.CODE IS 'PD_IAS39 code';
COMMENT ON COLUMN BARS.NOTARY_OB22.NAME IS 'PD_IAS39 назва';




PROMPT *** Create  constraint SYS_C006807 ***
begin   
 execute immediate '
  ALTER TABLE BARS.NOTARY_OB22 MODIFY (NBS NOT NULL ENABLE NOVALIDATE)';
exception when others then
  if  sqlcode=-2260 or sqlcode=-2261 or sqlcode=-2264 or sqlcode=-2275 or sqlcode=-1442 then null; else raise; end if;
 end;
/




PROMPT *** Create  constraint SYS_C006808 ***
begin   
 execute immediate '
  ALTER TABLE BARS.NOTARY_OB22 MODIFY (OB22 NOT NULL ENABLE NOVALIDATE)';
exception when others then
  if  sqlcode=-2260 or sqlcode=-2261 or sqlcode=-2264 or sqlcode=-2275 or sqlcode=-1442 then null; else raise; end if;
 end;
/




PROMPT *** Create  constraint SYS_C006809 ***
begin   
 execute immediate '
  ALTER TABLE BARS.NOTARY_OB22 MODIFY (CODE NOT NULL ENABLE NOVALIDATE)';
exception when others then
  if  sqlcode=-2260 or sqlcode=-2261 or sqlcode=-2264 or sqlcode=-2275 or sqlcode=-1442 then null; else raise; end if;
 end;
/



PROMPT *** Create  grants  NOTARY_OB22 ***
grant SELECT                                                                 on NOTARY_OB22     to BARSREADER_ROLE;
grant DELETE,FLASHBACK,INSERT,SELECT,UPDATE                                  on NOTARY_OB22     to BARS_ACCESS_DEFROLE;
grant SELECT                                                                 on NOTARY_OB22     to BARS_DM;
grant SELECT                                                                 on NOTARY_OB22     to UPLD;
grant FLASHBACK,SELECT                                                       on NOTARY_OB22     to WR_REFREAD;



PROMPT ===================================================================================== 
PROMPT *** End *** ========== Scripts /Sql/BARS/Table/NOTARY_OB22.sql =========*** End *** =
PROMPT ===================================================================================== 
