

PROMPT ===================================================================================== 
PROMPT *** Run *** ========== Scripts /Sql/BARS/Table/TMP_RNK_KAT.sql =========*** Run *** =
PROMPT ===================================================================================== 


PROMPT *** ALTER_POLICY_INFO to TMP_RNK_KAT ***


BEGIN 
        execute immediate  
          'begin  
               null;
           end; 
          '; 
END; 
/

PROMPT *** Create  table TMP_RNK_KAT ***
begin 
  execute immediate '
  CREATE GLOBAL TEMPORARY TABLE BARS.TMP_RNK_KAT 
   (	RNK NUMBER(*,0), 
	KAT NUMBER, 
	ISTVAL NUMBER
   ) ON COMMIT PRESERVE ROWS ';
exception when others then       
  if sqlcode=-955 then null; else raise; end if; 
end; 
/




PROMPT *** ALTER_POLICIES to TMP_RNK_KAT ***
 exec bpa.alter_policies('TMP_RNK_KAT');


COMMENT ON TABLE BARS.TMP_RNK_KAT IS 'Максимальная категория качества по РНК';
COMMENT ON COLUMN BARS.TMP_RNK_KAT.RNK IS 'Рег.номер клиента';
COMMENT ON COLUMN BARS.TMP_RNK_KAT.KAT IS 'Категория качества';
COMMENT ON COLUMN BARS.TMP_RNK_KAT.ISTVAL IS 'Источник валютной выручки';




PROMPT *** Create  constraint PK_TMP_RNK_KAT ***
begin   
 execute immediate '
  ALTER TABLE BARS.TMP_RNK_KAT ADD CONSTRAINT PK_TMP_RNK_KAT PRIMARY KEY (RNK, ISTVAL) ENABLE NOVALIDATE';
exception when others then
  if  sqlcode=-2260 or sqlcode=-2261 or sqlcode=-2264 or sqlcode=-2275 or sqlcode=-1442 then null; else raise; end if;
 end;
/




PROMPT *** Create  index PK_TMP_RNK_KAT ***
begin   
 execute immediate '
  CREATE UNIQUE INDEX BARS.PK_TMP_RNK_KAT ON BARS.TMP_RNK_KAT (RNK, ISTVAL) ';
exception when others then
  if  sqlcode=-955  then null; else raise; end if;
 end;
/



PROMPT *** Create  grants  TMP_RNK_KAT ***
grant DELETE,INSERT,SELECT,UPDATE                                            on TMP_RNK_KAT     to BARS_ACCESS_DEFROLE;
grant SELECT                                                                 on TMP_RNK_KAT     to BARS_DM;
grant DELETE,INSERT,SELECT,UPDATE                                            on TMP_RNK_KAT     to START1;



PROMPT ===================================================================================== 
PROMPT *** End *** ========== Scripts /Sql/BARS/Table/TMP_RNK_KAT.sql =========*** End *** =
PROMPT ===================================================================================== 
