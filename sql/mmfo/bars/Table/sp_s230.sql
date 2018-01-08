

PROMPT ===================================================================================== 
PROMPT *** Run *** ========== Scripts /Sql/BARS/Table/SP_S230.sql =========*** Run *** =====
PROMPT ===================================================================================== 


PROMPT *** ALTER_POLICY_INFO to SP_S230 ***


BEGIN 
        execute immediate  
          'begin  
               bpa.alter_policy_info(''SP_S230'', ''CENTER'' , null, null, null, null);
               bpa.alter_policy_info(''SP_S230'', ''FILIAL'' , null, null, null, null);
               bpa.alter_policy_info(''SP_S230'', ''WHOLE'' , null, null, null, null);
               null;
           end; 
          '; 
END; 
/

PROMPT *** Create  table SP_S230 ***
begin 
  execute immediate '
  CREATE TABLE BARS.SP_S230 
   (	S230 CHAR(3), 
	TXT VARCHAR2(240)
   ) SEGMENT CREATION DEFERRED 
  PCTFREE 10 PCTUSED 40 INITRANS 1 MAXTRANS 255 
 NOCOMPRESS LOGGING
  TABLESPACE BRSDYND ';
exception when others then       
  if sqlcode=-955 then null; else raise; end if; 
end; 
/




PROMPT *** ALTER_POLICIES to SP_S230 ***
 exec bpa.alter_policies('SP_S230');


COMMENT ON TABLE BARS.SP_S230 IS '';
COMMENT ON COLUMN BARS.SP_S230.S230 IS '';
COMMENT ON COLUMN BARS.SP_S230.TXT IS '';



PROMPT *** Create  grants  SP_S230 ***
grant FLASHBACK,SELECT                                                       on SP_S230         to BARS_ACCESS_DEFROLE;
grant FLASHBACK,SELECT                                                       on SP_S230         to WR_REFREAD;



PROMPT ===================================================================================== 
PROMPT *** End *** ========== Scripts /Sql/BARS/Table/SP_S230.sql =========*** End *** =====
PROMPT ===================================================================================== 
