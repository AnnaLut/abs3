

PROMPT ===================================================================================== 
PROMPT *** Run *** ========== Scripts /Sql/BARS/Table/DPA_REJECT_CODES.sql =========*** Run 
PROMPT ===================================================================================== 


PROMPT *** ALTER_POLICY_INFO to DPA_REJECT_CODES ***


BEGIN 
        execute immediate  
          'begin  
               bpa.alter_policy_info(''DPA_REJECT_CODES'', ''CENTER'' , null, null, null, null);
               bpa.alter_policy_info(''DPA_REJECT_CODES'', ''FILIAL'' , null, ''E'', ''E'', ''E'');
               bpa.alter_policy_info(''DPA_REJECT_CODES'', ''WHOLE'' , null, null, null, null);
               null;
           end; 
          '; 
END; 
/

PROMPT *** Create  table DPA_REJECT_CODES ***
begin 
  execute immediate '
  CREATE TABLE BARS.DPA_REJECT_CODES 
   (	ERR_CODE NUMBER(2,0), 
	ERR_MSG VARCHAR2(500)
   ) SEGMENT CREATION IMMEDIATE 
  PCTFREE 10 PCTUSED 40 INITRANS 1 MAXTRANS 255 
 NOCOMPRESS LOGGING
  TABLESPACE BRSSMLD ';
exception when others then       
  if sqlcode=-955 then null; else raise; end if; 
end; 
/




PROMPT *** ALTER_POLICIES to DPA_REJECT_CODES ***
 exec bpa.alter_policies('DPA_REJECT_CODES');


COMMENT ON TABLE BARS.DPA_REJECT_CODES IS 'Коды причин отказа регистрации счета в ДПА';
COMMENT ON COLUMN BARS.DPA_REJECT_CODES.ERR_CODE IS 'Код причины отказа';
COMMENT ON COLUMN BARS.DPA_REJECT_CODES.ERR_MSG IS 'Причина отказа';




PROMPT *** Create  constraint CC_DPAREJECTCODES_ERRCODE_NN ***
begin   
 execute immediate '
  ALTER TABLE BARS.DPA_REJECT_CODES MODIFY (ERR_CODE CONSTRAINT CC_DPAREJECTCODES_ERRCODE_NN NOT NULL ENABLE)';
exception when others then
  if  sqlcode=-2260 or sqlcode=-2261 or sqlcode=-2264 or sqlcode=-2275 or sqlcode=-1442 then null; else raise; end if;
 end;
/




PROMPT *** Create  constraint PK_DPAREJECTCODES ***
begin   
 execute immediate '
  ALTER TABLE BARS.DPA_REJECT_CODES ADD CONSTRAINT PK_DPAREJECTCODES PRIMARY KEY (ERR_CODE)
  USING INDEX PCTFREE 10 INITRANS 2 MAXTRANS 255 COMPUTE STATISTICS 
  TABLESPACE BRSSMLI  ENABLE';
exception when others then
  if  sqlcode=-2260 or sqlcode=-2261 or sqlcode=-2264 or sqlcode=-2275 or sqlcode=-1442 then null; else raise; end if;
 end;
/




PROMPT *** Create  index PK_DPAREJECTCODES ***
begin   
 execute immediate '
  CREATE UNIQUE INDEX BARS.PK_DPAREJECTCODES ON BARS.DPA_REJECT_CODES (ERR_CODE) 
  PCTFREE 10 INITRANS 2 MAXTRANS 255 COMPUTE STATISTICS 
  TABLESPACE BRSSMLI ';
exception when others then
  if  sqlcode=-955  then null; else raise; end if;
 end;
/



PROMPT *** Create  grants  DPA_REJECT_CODES ***
grant DELETE,FLASHBACK,INSERT,SELECT,UPDATE                                  on DPA_REJECT_CODES to BARS_ACCESS_DEFROLE;
grant SELECT                                                                 on DPA_REJECT_CODES to BARS_DM;
grant DELETE,INSERT,SELECT,UPDATE                                            on DPA_REJECT_CODES to RPBN002;
grant DELETE,FLASHBACK,INSERT,SELECT,UPDATE                                  on DPA_REJECT_CODES to WR_ALL_RIGHTS;
grant FLASHBACK,SELECT                                                       on DPA_REJECT_CODES to WR_REFREAD;



PROMPT *** Create SYNONYM  to DPA_REJECT_CODES ***

  CREATE OR REPLACE PUBLIC SYNONYM DPA_REJECT_CODES FOR BARS.DPA_REJECT_CODES;


PROMPT ===================================================================================== 
PROMPT *** End *** ========== Scripts /Sql/BARS/Table/DPA_REJECT_CODES.sql =========*** End 
PROMPT ===================================================================================== 
