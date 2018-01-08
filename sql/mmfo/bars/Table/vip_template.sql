

PROMPT ===================================================================================== 
PROMPT *** Run *** ========== Scripts /Sql/BARS/Table/VIP_TEMPLATE.sql =========*** Run *** 
PROMPT ===================================================================================== 


PROMPT *** ALTER_POLICY_INFO to VIP_TEMPLATE ***


BEGIN 
        execute immediate  
          'begin  
               bpa.alter_policy_info(''VIP_TEMPLATE'', ''FILIAL'' , null, null, null, null);
               bpa.alter_policy_info(''VIP_TEMPLATE'', ''WHOLE'' , null, null, null, null);
               null;
           end; 
          '; 
END; 
/

PROMPT *** Create  table VIP_TEMPLATE ***
begin 
  execute immediate '
  CREATE TABLE BARS.VIP_TEMPLATE 
   (	TEMPLATE CLOB
   ) SEGMENT CREATION DEFERRED 
  PCTFREE 10 PCTUSED 40 INITRANS 1 MAXTRANS 255 
 NOCOMPRESS LOGGING
  TABLESPACE BRSDYND 
 LOB (TEMPLATE) STORE AS BASICFILE (
  TABLESPACE BRSDYND ENABLE STORAGE IN ROW CHUNK 8192 RETENTION 
  NOCACHE LOGGING ) ';
exception when others then       
  if sqlcode=-955 then null; else raise; end if; 
end; 
/




PROMPT *** ALTER_POLICIES to VIP_TEMPLATE ***
 exec bpa.alter_policies('VIP_TEMPLATE');


COMMENT ON TABLE BARS.VIP_TEMPLATE IS '';
COMMENT ON COLUMN BARS.VIP_TEMPLATE.TEMPLATE IS '';



PROMPT *** Create  grants  VIP_TEMPLATE ***
grant DELETE,INSERT,SELECT,UPDATE                                            on VIP_TEMPLATE    to BARS_ACCESS_DEFROLE;



PROMPT ===================================================================================== 
PROMPT *** End *** ========== Scripts /Sql/BARS/Table/VIP_TEMPLATE.sql =========*** End *** 
PROMPT ===================================================================================== 
