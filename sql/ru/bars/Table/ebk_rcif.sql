

PROMPT ===================================================================================== 
PROMPT *** Run *** ========== Scripts /Sql/BARS/Table/EBK_RCIF.sql =========*** Run *** ====
PROMPT ===================================================================================== 


PROMPT *** ALTER_POLICY_INFO to EBK_RCIF ***


BEGIN 
        execute immediate  
          'begin  
               bpa.alter_policy_info(''EBK_RCIF'', ''FILIAL'' , null, null, null, null);
               bpa.alter_policy_info(''EBK_RCIF'', ''WHOLE'' , null, null, null, null);
               null;
           end; 
          '; 
END; 
/

PROMPT *** Create  table EBK_RCIF ***
begin 
  execute immediate '
  CREATE TABLE BARS.EBK_RCIF 
   (	RCIF NUMBER(38,0), 
	SEND NUMBER(1,0), 
	 CONSTRAINT PK_EBK_RCIF PRIMARY KEY (RCIF, SEND) ENABLE
   ) ORGANIZATION INDEX NOCOMPRESS PCTFREE 10 INITRANS 2 MAXTRANS 255 LOGGING
  TABLESPACE BRSDYND 
 PCTTHRESHOLD 50';
exception when others then       
  if sqlcode=-955 then null; else raise; end if; 
end; 
/




PROMPT *** ALTER_POLICIES to EBK_RCIF ***
 exec bpa.alter_policies('EBK_RCIF');


COMMENT ON TABLE BARS.EBK_RCIF IS 'Таблица идентификатора мастер-карточки на уровне РУ, равен РНК';
COMMENT ON COLUMN BARS.EBK_RCIF.RCIF IS '';
COMMENT ON COLUMN BARS.EBK_RCIF.SEND IS '';




PROMPT *** Create  constraint PK_EBK_RCIF ***
begin   
 execute immediate '
  ALTER TABLE BARS.EBK_RCIF ADD CONSTRAINT PK_EBK_RCIF PRIMARY KEY (RCIF, SEND)
  USING INDEX PCTFREE 10 INITRANS 2 MAXTRANS 255 COMPUTE STATISTICS 
  TABLESPACE BRSDYND  ENABLE';
exception when others then
  if  sqlcode=-2260 or sqlcode=-2261 or sqlcode=-2264 or sqlcode=-2275 or sqlcode=-1442 then null; else raise; end if;
 end;
/




PROMPT *** Create  index PK_EBK_RCIF ***
begin   
 execute immediate '
  CREATE UNIQUE INDEX BARS.PK_EBK_RCIF ON BARS.EBK_RCIF (RCIF, SEND) 
  PCTFREE 10 INITRANS 2 MAXTRANS 255 COMPUTE STATISTICS 
  TABLESPACE BRSDYND ';
exception when others then
  if  sqlcode=-955  then null; else raise; end if;
 end;
/



PROMPT *** Create  grants  EBK_RCIF ***
grant DELETE,INSERT,SELECT,UPDATE                                            on EBK_RCIF        to BARS_ACCESS_DEFROLE;



PROMPT ===================================================================================== 
PROMPT *** End *** ========== Scripts /Sql/BARS/Table/EBK_RCIF.sql =========*** End *** ====
PROMPT ===================================================================================== 
