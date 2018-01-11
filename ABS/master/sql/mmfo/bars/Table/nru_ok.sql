

PROMPT ===================================================================================== 
PROMPT *** Run *** ========== Scripts /Sql/BARS/Table/NRU_OK.sql =========*** Run *** ======
PROMPT ===================================================================================== 


PROMPT *** ALTER_POLICY_INFO to NRU_OK ***


BEGIN 
        execute immediate  
          'begin  
               bpa.alter_policy_info(''NRU_OK'', ''FILIAL'' , null, null, null, null);
               bpa.alter_policy_info(''NRU_OK'', ''WHOLE'' , null, null, null, null);
               null;
           end; 
          '; 
END; 
/

PROMPT *** Create  table NRU_OK ***
begin 
  execute immediate '
  CREATE TABLE BARS.NRU_OK 
   (	ACC NUMBER, 
	ERR VARCHAR2(70), 
	SERR VARCHAR2(70)
   ) SEGMENT CREATION IMMEDIATE 
  PCTFREE 10 PCTUSED 40 INITRANS 1 MAXTRANS 255 
 NOCOMPRESS LOGGING
  TABLESPACE BRSDYND ';
exception when others then       
  if sqlcode=-955 then null; else raise; end if; 
end; 
/




PROMPT *** ALTER_POLICIES to NRU_OK ***
 exec bpa.alter_policies('NRU_OK');


COMMENT ON TABLE BARS.NRU_OK IS 'Рахунки-претенденти на НЕРУХОМІ';
COMMENT ON COLUMN BARS.NRU_OK.ACC IS 'ACC.рах';
COMMENT ON COLUMN BARS.NRU_OK.ERR IS '';
COMMENT ON COLUMN BARS.NRU_OK.SERR IS 'Помилка';




PROMPT *** Create  constraint XPK_NRUOK ***
begin   
 execute immediate '
  ALTER TABLE BARS.NRU_OK ADD CONSTRAINT XPK_NRUOK PRIMARY KEY (ACC)
  USING INDEX PCTFREE 10 INITRANS 2 MAXTRANS 255 COMPUTE STATISTICS 
  TABLESPACE BRSDYND  ENABLE';
exception when others then
  if  sqlcode=-2260 or sqlcode=-2261 or sqlcode=-2264 or sqlcode=-2275 or sqlcode=-1442 then null; else raise; end if;
 end;
/




PROMPT *** Create  index XPK_NRUOK ***
begin   
 execute immediate '
  CREATE UNIQUE INDEX BARS.XPK_NRUOK ON BARS.NRU_OK (ACC) 
  PCTFREE 10 INITRANS 2 MAXTRANS 255 COMPUTE STATISTICS 
  TABLESPACE BRSDYND ';
exception when others then
  if  sqlcode=-955  then null; else raise; end if;
 end;
/



PROMPT *** Create  grants  NRU_OK ***
grant SELECT                                                                 on NRU_OK          to BARSREADER_ROLE;
grant SELECT                                                                 on NRU_OK          to UPLD;



PROMPT ===================================================================================== 
PROMPT *** End *** ========== Scripts /Sql/BARS/Table/NRU_OK.sql =========*** End *** ======
PROMPT ===================================================================================== 
