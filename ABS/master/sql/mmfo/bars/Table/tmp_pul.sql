

PROMPT ===================================================================================== 
PROMPT *** Run *** ========== Scripts /Sql/BARS/Table/TMP_PUL.sql =========*** Run *** =====
PROMPT ===================================================================================== 


PROMPT *** ALTER_POLICY_INFO to TMP_PUL ***


BEGIN 
        execute immediate  
          'begin  
               null;
           end; 
          '; 
END; 
/

PROMPT *** Create  table TMP_PUL ***
begin 
  execute immediate '
  CREATE GLOBAL TEMPORARY TABLE BARS.TMP_PUL 
   (	TAG VARCHAR2(128), 
	VAL VARCHAR2(128), 
	COM VARCHAR2(254)
   ) ON COMMIT PRESERVE ROWS ';
exception when others then       
  if sqlcode=-955 then null; else raise; end if; 
end; 
/




PROMPT *** ALTER_POLICIES to TMP_PUL ***
 exec bpa.alter_policies('TMP_PUL');


COMMENT ON TABLE BARS.TMP_PUL IS 'Временная таблица';
COMMENT ON COLUMN BARS.TMP_PUL.TAG IS 'Параметр';
COMMENT ON COLUMN BARS.TMP_PUL.VAL IS 'Название параметра';
COMMENT ON COLUMN BARS.TMP_PUL.COM IS 'Комментарий';




PROMPT *** Create  constraint PK_TMPPUL ***
begin   
 execute immediate '
  ALTER TABLE BARS.TMP_PUL ADD CONSTRAINT PK_TMPPUL PRIMARY KEY (TAG) ENABLE';
exception when others then
  if  sqlcode=-2260 or sqlcode=-2261 or sqlcode=-2264 or sqlcode=-2275 or sqlcode=-1442 then null; else raise; end if;
 end;
/




PROMPT *** Create  constraint SYS_C0010229 ***
begin   
 execute immediate '
  ALTER TABLE BARS.TMP_PUL MODIFY (TAG NOT NULL ENABLE)';
exception when others then
  if  sqlcode=-2260 or sqlcode=-2261 or sqlcode=-2264 or sqlcode=-2275 or sqlcode=-1442 then null; else raise; end if;
 end;
/




PROMPT *** Create  index PK_TMPPUL ***
begin   
 execute immediate '
  CREATE UNIQUE INDEX BARS.PK_TMPPUL ON BARS.TMP_PUL (TAG) ';
exception when others then
  if  sqlcode=-955  then null; else raise; end if;
 end;
/



PROMPT *** Create  grants  TMP_PUL ***
grant DELETE,INSERT,SELECT,UPDATE                                            on TMP_PUL         to ABS_ADMIN;
grant SELECT                                                                 on TMP_PUL         to BARSREADER_ROLE;
grant DELETE,INSERT,SELECT,UPDATE                                            on TMP_PUL         to BARS_ACCESS_DEFROLE;
grant SELECT                                                                 on TMP_PUL         to START1;
grant SELECT                                                                 on TMP_PUL         to UPLD;
grant DELETE,FLASHBACK,INSERT,SELECT,UPDATE                                  on TMP_PUL         to WR_ALL_RIGHTS;



PROMPT ===================================================================================== 
PROMPT *** End *** ========== Scripts /Sql/BARS/Table/TMP_PUL.sql =========*** End *** =====
PROMPT ===================================================================================== 
