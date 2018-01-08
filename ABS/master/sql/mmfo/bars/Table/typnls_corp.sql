

PROMPT ===================================================================================== 
PROMPT *** Run *** ========== Scripts /Sql/BARS/Table/TYPNLS_CORP.sql =========*** Run *** =
PROMPT ===================================================================================== 


PROMPT *** ALTER_POLICY_INFO to TYPNLS_CORP ***


BEGIN 
        execute immediate  
          'begin  
               bpa.alter_policy_info(''TYPNLS_CORP'', ''CENTER'' , null, null, null, null);
               bpa.alter_policy_info(''TYPNLS_CORP'', ''FILIAL'' , null, null, null, null);
               bpa.alter_policy_info(''TYPNLS_CORP'', ''WHOLE'' , null, null, null, null);
               null;
           end; 
          '; 
END; 
/

PROMPT *** Create  table TYPNLS_CORP ***
begin 
  execute immediate '
  CREATE TABLE BARS.TYPNLS_CORP 
   (	KOD CHAR(2), 
	TXT VARCHAR2(150)
   ) SEGMENT CREATION IMMEDIATE 
  PCTFREE 10 PCTUSED 40 INITRANS 1 MAXTRANS 255 
 NOCOMPRESS LOGGING
  TABLESPACE BRSDYND ';
exception when others then       
  if sqlcode=-955 then null; else raise; end if; 
end; 
/




PROMPT *** ALTER_POLICIES to TYPNLS_CORP ***
 exec bpa.alter_policies('TYPNLS_CORP');


COMMENT ON TABLE BARS.TYPNLS_CORP IS '';
COMMENT ON COLUMN BARS.TYPNLS_CORP.KOD IS '';
COMMENT ON COLUMN BARS.TYPNLS_CORP.TXT IS '';



PROMPT *** Create  grants  TYPNLS_CORP ***
grant FLASHBACK,SELECT                                                       on TYPNLS_CORP     to BARS_ACCESS_DEFROLE;
grant SELECT                                                                 on TYPNLS_CORP     to BARS_DM;
grant FLASHBACK,SELECT                                                       on TYPNLS_CORP     to WR_REFREAD;



PROMPT ===================================================================================== 
PROMPT *** End *** ========== Scripts /Sql/BARS/Table/TYPNLS_CORP.sql =========*** End *** =
PROMPT ===================================================================================== 
