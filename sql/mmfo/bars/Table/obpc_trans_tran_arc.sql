

PROMPT ===================================================================================== 
PROMPT *** Run *** ========== Scripts /Sql/BARS/Table/OBPC_TRANS_TRAN_ARC.sql =========*** R
PROMPT ===================================================================================== 


PROMPT *** ALTER_POLICY_INFO to OBPC_TRANS_TRAN_ARC ***


BEGIN 
        execute immediate  
          'begin  
               bpa.alter_policy_info(''OBPC_TRANS_TRAN_ARC'', ''CENTER'' , null, null, null, null);
               bpa.alter_policy_info(''OBPC_TRANS_TRAN_ARC'', ''FILIAL'' , null, null, null, null);
               bpa.alter_policy_info(''OBPC_TRANS_TRAN_ARC'', ''WHOLE'' , null, null, null, null);
               null;
           end; 
          '; 
END; 
/

PROMPT *** Create  table OBPC_TRANS_TRAN_ARC ***
begin 
  execute immediate '
  CREATE TABLE BARS.OBPC_TRANS_TRAN_ARC 
   (	TRAN_TYPE CHAR(2), 
	TIP CHAR(3), 
	TRANSIT VARCHAR2(15)
   ) SEGMENT CREATION DEFERRED 
  PCTFREE 10 PCTUSED 40 INITRANS 1 MAXTRANS 255 
 NOCOMPRESS LOGGING
  TABLESPACE BRSDYND ';
exception when others then       
  if sqlcode=-955 then null; else raise; end if; 
end; 
/




PROMPT *** ALTER_POLICIES to OBPC_TRANS_TRAN_ARC ***
 exec bpa.alter_policies('OBPC_TRANS_TRAN_ARC');


COMMENT ON TABLE BARS.OBPC_TRANS_TRAN_ARC IS '';
COMMENT ON COLUMN BARS.OBPC_TRANS_TRAN_ARC.TRAN_TYPE IS '';
COMMENT ON COLUMN BARS.OBPC_TRANS_TRAN_ARC.TIP IS '';
COMMENT ON COLUMN BARS.OBPC_TRANS_TRAN_ARC.TRANSIT IS '';



PROMPT *** Create  grants  OBPC_TRANS_TRAN_ARC ***
grant SELECT                                                                 on OBPC_TRANS_TRAN_ARC to BARSREADER_ROLE;
grant DELETE,INSERT,SELECT,UPDATE                                            on OBPC_TRANS_TRAN_ARC to BARS_ACCESS_DEFROLE;
grant DELETE,INSERT,SELECT,UPDATE                                            on OBPC_TRANS_TRAN_ARC to START1;
grant SELECT                                                                 on OBPC_TRANS_TRAN_ARC to UPLD;



PROMPT ===================================================================================== 
PROMPT *** End *** ========== Scripts /Sql/BARS/Table/OBPC_TRANS_TRAN_ARC.sql =========*** E
PROMPT ===================================================================================== 
