

PROMPT ===================================================================================== 
PROMPT *** Run *** ========== Scripts /Sql/BARS/Table/REZ_OB_BANKS.sql =========*** Run *** 
PROMPT ===================================================================================== 


PROMPT *** ALTER_POLICY_INFO to REZ_OB_BANKS ***


BEGIN 
        execute immediate  
          'begin  
               bpa.alter_policy_info(''REZ_OB_BANKS'', ''FILIAL'' , null, ''E'', ''E'', ''E'');
               bpa.alter_policy_info(''REZ_OB_BANKS'', ''WHOLE'' , null, null, null, null);
               null;
           end; 
          '; 
END; 
/

PROMPT *** Create  table REZ_OB_BANKS ***
begin 
  execute immediate '
  CREATE TABLE BARS.REZ_OB_BANKS 
   (	FIN NUMBER(*,0), 
	OBS NUMBER(*,0), 
	VNCRR VARCHAR2(4), 
	KHIST NUMBER(*,0), 
	NEINF NUMBER(*,0), 
	KAT23 NUMBER(*,0), 
	K23 NUMBER, 
	K2 NUMBER
   ) SEGMENT CREATION IMMEDIATE 
  PCTFREE 10 PCTUSED 40 INITRANS 1 MAXTRANS 255 
 NOCOMPRESS LOGGING
  TABLESPACE BRSDYND ';
exception when others then       
  if sqlcode=-955 then null; else raise; end if; 
end; 
/




PROMPT *** ALTER_POLICIES to REZ_OB_BANKS ***
 exec bpa.alter_policies('REZ_OB_BANKS');


COMMENT ON TABLE BARS.REZ_OB_BANKS IS 'ОБ:Знач пок ризику для Банкiв-боржникiв';
COMMENT ON COLUMN BARS.REZ_OB_BANKS.FIN IS 'Клас';
COMMENT ON COLUMN BARS.REZ_OB_BANKS.OBS IS 'Обслуговування';
COMMENT ON COLUMN BARS.REZ_OB_BANKS.VNCRR IS 'Min(ВН.кр.рейт)';
COMMENT ON COLUMN BARS.REZ_OB_BANKS.KHIST IS 'Кр.iсторiя';
COMMENT ON COLUMN BARS.REZ_OB_BANKS.NEINF IS 'Iнша негат.iнф.';
COMMENT ON COLUMN BARS.REZ_OB_BANKS.KAT23 IS 'Кат.якостi';
COMMENT ON COLUMN BARS.REZ_OB_BANKS.K23 IS 'Показник ризику';
COMMENT ON COLUMN BARS.REZ_OB_BANKS.K2 IS '';




PROMPT *** Create  constraint PK_REZOBBANKS ***
begin   
 execute immediate '
  ALTER TABLE BARS.REZ_OB_BANKS ADD CONSTRAINT PK_REZOBBANKS PRIMARY KEY (FIN, OBS, VNCRR, KHIST, NEINF)
  USING INDEX PCTFREE 10 INITRANS 2 MAXTRANS 255 COMPUTE STATISTICS 
  TABLESPACE BRSDYND  ENABLE';
exception when others then
  if  sqlcode=-2260 or sqlcode=-2261 or sqlcode=-2264 or sqlcode=-2275 or sqlcode=-1442 then null; else raise; end if;
 end;
/




PROMPT *** Create  index PK_REZOBBANKS ***
begin   
 execute immediate '
  CREATE UNIQUE INDEX BARS.PK_REZOBBANKS ON BARS.REZ_OB_BANKS (FIN, OBS, VNCRR, KHIST, NEINF) 
  PCTFREE 10 INITRANS 2 MAXTRANS 255 COMPUTE STATISTICS 
  TABLESPACE BRSDYND ';
exception when others then
  if  sqlcode=-955  then null; else raise; end if;
 end;
/



PROMPT *** Create  grants  REZ_OB_BANKS ***
grant DELETE,FLASHBACK,INSERT,SELECT,UPDATE                                  on REZ_OB_BANKS    to BARS_ACCESS_DEFROLE;
grant DELETE,INSERT,SELECT,UPDATE                                            on REZ_OB_BANKS    to START1;
grant FLASHBACK,SELECT                                                       on REZ_OB_BANKS    to WR_REFREAD;



PROMPT ===================================================================================== 
PROMPT *** End *** ========== Scripts /Sql/BARS/Table/REZ_OB_BANKS.sql =========*** End *** 
PROMPT ===================================================================================== 
