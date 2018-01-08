

PROMPT ===================================================================================== 
PROMPT *** Run *** ========== Scripts /Sql/BARS/Table/ANI3.sql =========*** Run *** ========
PROMPT ===================================================================================== 


PROMPT *** ALTER_POLICY_INFO to ANI3 ***


BEGIN 
        execute immediate  
          'begin  
               bpa.alter_policy_info(''ANI3'', ''CENTER'' , null, null, null, null);
               bpa.alter_policy_info(''ANI3'', ''FILIAL'' , null, null, null, null);
               bpa.alter_policy_info(''ANI3'', ''WHOLE'' , null, null, null, null);
               null;
           end; 
          '; 
END; 
/

PROMPT *** Create  table ANI3 ***
begin 
  execute immediate '
  CREATE TABLE BARS.ANI3 
   (	ID NUMBER(*,0), 
	NBS CHAR(4), 
	PAP NUMBER(*,0), 
	S180 CHAR(1), 
	PRT NUMBER(*,0)
   ) SEGMENT CREATION IMMEDIATE 
  PCTFREE 10 PCTUSED 40 INITRANS 1 MAXTRANS 255 
 NOCOMPRESS LOGGING
  TABLESPACE BRSDYND ';
exception when others then       
  if sqlcode=-955 then null; else raise; end if; 
end; 
/




PROMPT *** ALTER_POLICIES to ANI3 ***
 exec bpa.alter_policies('ANI3');


COMMENT ON TABLE BARS.ANI3 IS 'Номенклатура трансферных цен';
COMMENT ON COLUMN BARS.ANI3.ID IS 'Код~базовой~% ставки';
COMMENT ON COLUMN BARS.ANI3.NBS IS 'Бал~сч.';
COMMENT ON COLUMN BARS.ANI3.PAP IS 'АКТ~ПАС.';
COMMENT ON COLUMN BARS.ANI3.S180 IS 'Код~срока';
COMMENT ON COLUMN BARS.ANI3.PRT IS 'Признак~1=ставка~2=маржа';




PROMPT *** Create  constraint XPK_ANI3 ***
begin   
 execute immediate '
  ALTER TABLE BARS.ANI3 ADD CONSTRAINT XPK_ANI3 PRIMARY KEY (NBS, PAP, S180)
  USING INDEX PCTFREE 10 INITRANS 2 MAXTRANS 255 COMPUTE STATISTICS 
  TABLESPACE BRSDYNI  ENABLE';
exception when others then
  if  sqlcode=-2260 or sqlcode=-2261 or sqlcode=-2264 or sqlcode=-2275 or sqlcode=-1442 then null; else raise; end if;
 end;
/




PROMPT *** Create  index XPK_ANI3 ***
begin   
 execute immediate '
  CREATE UNIQUE INDEX BARS.XPK_ANI3 ON BARS.ANI3 (NBS, PAP, S180) 
  PCTFREE 10 INITRANS 2 MAXTRANS 255 COMPUTE STATISTICS 
  TABLESPACE BRSDYNI ';
exception when others then
  if  sqlcode=-955  then null; else raise; end if;
 end;
/



PROMPT *** Create  grants  ANI3 ***
grant SELECT                                                                 on ANI3            to BARSREADER_ROLE;
grant DELETE,INSERT,SELECT,UPDATE                                            on ANI3            to BARS_ACCESS_DEFROLE;
grant SELECT                                                                 on ANI3            to BARS_DM;
grant DELETE,INSERT,SELECT,UPDATE                                            on ANI3            to SALGL;
grant SELECT                                                                 on ANI3            to UPLD;
grant DELETE,FLASHBACK,INSERT,SELECT,UPDATE                                  on ANI3            to WR_ALL_RIGHTS;



PROMPT ===================================================================================== 
PROMPT *** End *** ========== Scripts /Sql/BARS/Table/ANI3.sql =========*** End *** ========
PROMPT ===================================================================================== 
