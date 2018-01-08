

PROMPT ===================================================================================== 
PROMPT *** Run *** ========== Scripts /Sql/BARS/Table/DPT_CASH.sql =========*** Run *** ====
PROMPT ===================================================================================== 


PROMPT *** ALTER_POLICY_INFO to DPT_CASH ***


BEGIN 
        execute immediate  
          'begin  
               bpa.alter_policy_info(''DPT_CASH'', ''CENTER'' , null, null, null, null);
               bpa.alter_policy_info(''DPT_CASH'', ''FILIAL'' , null, null, null, null);
               bpa.alter_policy_info(''DPT_CASH'', ''WHOLE'' , null, null, null, null);
               null;
           end; 
          '; 
END; 
/

PROMPT *** Create  table DPT_CASH ***
begin 
  execute immediate '
  CREATE TABLE BARS.DPT_CASH 
   (	NLS VARCHAR2(15), 
	FLAG NUMBER(1,0) DEFAULT 0
   ) SEGMENT CREATION IMMEDIATE 
  PCTFREE 10 PCTUSED 40 INITRANS 1 MAXTRANS 255 
 NOCOMPRESS LOGGING
  TABLESPACE BRSDYND ';
exception when others then       
  if sqlcode=-955 then null; else raise; end if; 
end; 
/




PROMPT *** ALTER_POLICIES to DPT_CASH ***
 exec bpa.alter_policies('DPT_CASH');


COMMENT ON TABLE BARS.DPT_CASH IS '';
COMMENT ON COLUMN BARS.DPT_CASH.NLS IS '';
COMMENT ON COLUMN BARS.DPT_CASH.FLAG IS '';



PROMPT *** Create  grants  DPT_CASH ***
grant SELECT                                                                 on DPT_CASH        to BARSREADER_ROLE;
grant DELETE,FLASHBACK,INSERT,SELECT,UPDATE                                  on DPT_CASH        to BARS_ACCESS_DEFROLE;
grant SELECT                                                                 on DPT_CASH        to BARS_DM;
grant SELECT                                                                 on DPT_CASH        to UPLD;
grant DELETE,INSERT,SELECT,UPDATE                                            on DPT_CASH        to VKLAD;
grant FLASHBACK,SELECT                                                       on DPT_CASH        to WR_REFREAD;



PROMPT ===================================================================================== 
PROMPT *** End *** ========== Scripts /Sql/BARS/Table/DPT_CASH.sql =========*** End *** ====
PROMPT ===================================================================================== 
