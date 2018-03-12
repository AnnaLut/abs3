

PROMPT ===================================================================================== 
PROMPT *** Run *** ========== Scripts /Sql/BARS/Table/ACCOUNTSW.sql =========*** Run *** ===
PROMPT ===================================================================================== 


PROMPT *** ALTER_POLICY_INFO to ACCOUNTSW ***


BEGIN 
        execute immediate  
          'begin  
               bpa.alter_policy_info(''ACCOUNTSW'', ''CENTER'' , null, ''E'', ''E'', ''E'');
               bpa.alter_policy_info(''ACCOUNTSW'', ''FILIAL'' , ''M'', ''M'', ''M'', ''M'');
               bpa.alter_policy_info(''ACCOUNTSW'', ''WHOLE'' , null, ''E'', ''E'', ''E'');
               null;
           end; 
          '; 
END; 
/

PROMPT *** Create  table ACCOUNTSW ***
begin 
  execute immediate '
  CREATE TABLE BARS.ACCOUNTSW 
   (	ACC NUMBER(38,0), 
	TAG VARCHAR2(8 CHAR), 
	VALUE VARCHAR2(254), 
	KF VARCHAR2(6 CHAR) DEFAULT sys_context(''bars_context'',''user_mfo'')
   ) SEGMENT CREATION DEFERRED 
  PCTFREE 10 PCTUSED 40 INITRANS 1 MAXTRANS 255 
  TABLESPACE BRSMDLD 
  PARTITION BY LIST (TAG) 
 (PARTITION P_W4_SEC  VALUES (''W4_SEC'') SEGMENT CREATION IMMEDIATE 
  PCTFREE 10 PCTUSED 40 INITRANS 1 MAXTRANS 255 
 NOCOMPRESS LOGGING 
  TABLESPACE BRSMDLD , 
 PARTITION P_W4_EFN  VALUES (''W4_EFN'') SEGMENT CREATION IMMEDIATE 
  PCTFREE 10 PCTUSED 40 INITRANS 1 MAXTRANS 255 
 NOCOMPRESS LOGGING 
  TABLESPACE BRSMDLD , 
 PARTITION P_W4_ELN  VALUES (''W4_ELN'') SEGMENT CREATION IMMEDIATE 
  PCTFREE 10 PCTUSED 40 INITRANS 1 MAXTRANS 255 
 NOCOMPRESS LOGGING 
  TABLESPACE BRSMDLD , 
 PARTITION P_PK_TERM  VALUES (''PK_TERM'') SEGMENT CREATION IMMEDIATE 
  PCTFREE 10 PCTUSED 40 INITRANS 1 MAXTRANS 255 
 NOCOMPRESS LOGGING 
  TABLESPACE BRSMDLD , 
 PARTITION P_PK_WORK  VALUES (''PK_WORK'') SEGMENT CREATION IMMEDIATE 
  PCTFREE 10 PCTUSED 40 INITRANS 1 MAXTRANS 255 
 NOCOMPRESS LOGGING 
  TABLESPACE BRSMDLD , 
 PARTITION P_PK_OFFIC  VALUES (''PK_OFFIC'') SEGMENT CREATION IMMEDIATE 
  PCTFREE 10 PCTUSED 40 INITRANS 1 MAXTRANS 255 
 NOCOMPRESS LOGGING 
  TABLESPACE BRSMDLD , 
 PARTITION P_KOTLD  VALUES (''KOTLD'') SEGMENT CREATION IMMEDIATE 
  PCTFREE 10 PCTUSED 40 INITRANS 1 MAXTRANS 255 
 NOCOMPRESS LOGGING 
  TABLESPACE BRSMDLD , 
 PARTITION P_KOTLN  VALUES (''KOTLN'') SEGMENT CREATION IMMEDIATE 
  PCTFREE 10 PCTUSED 40 INITRANS 1 MAXTRANS 255 
 NOCOMPRESS LOGGING 
  TABLESPACE BRSMDLD , 
 PARTITION P_OST_D  VALUES (''OST_D'') SEGMENT CREATION IMMEDIATE 
  PCTFREE 10 PCTUSED 40 INITRANS 1 MAXTRANS 255 
 NOCOMPRESS LOGGING 
  TABLESPACE BRSMDLD , 
 PARTITION P_NBS_Z  VALUES (''NBS_Z'') SEGMENT CREATION IMMEDIATE 
  PCTFREE 10 PCTUSED 40 INITRANS 1 MAXTRANS 255 
 NOCOMPRESS LOGGING 
  TABLESPACE BRSMDLD , 
 PARTITION P_ZPR_D  VALUES (''ZPR_D'') SEGMENT CREATION IMMEDIATE 
  PCTFREE 10 PCTUSED 40 INITRANS 1 MAXTRANS 255 
 NOCOMPRESS LOGGING 
  TABLESPACE BRSMDLD , 
 PARTITION P_NPR_D  VALUES (''NPR_D'') SEGMENT CREATION IMMEDIATE 
  PCTFREE 10 PCTUSED 40 INITRANS 1 MAXTRANS 255 
 NOCOMPRESS LOGGING 
  TABLESPACE BRSMDLD , 
 PARTITION P_KOTLZ  VALUES (''KOTLZ'') SEGMENT CREATION IMMEDIATE 
  PCTFREE 10 PCTUSED 40 INITRANS 1 MAXTRANS 255 
 NOCOMPRESS LOGGING 
  TABLESPACE BRSMDLD , 
 PARTITION P_NBS_D  VALUES (''NBS_D'') SEGMENT CREATION IMMEDIATE 
  PCTFREE 10 PCTUSED 40 INITRANS 1 MAXTRANS 255 
 NOCOMPRESS LOGGING 
  TABLESPACE BRSMDLD , 
 PARTITION P_ASVO  VALUES (''%ASVO'') SEGMENT CREATION IMMEDIATE 
  PCTFREE 10 PCTUSED 40 INITRANS 1 MAXTRANS 255 
 NOCOMPRESS LOGGING 
  TABLESPACE BRSMDLD , 
 PARTITION P_KKASV  VALUES (''KKASV'') SEGMENT CREATION IMMEDIATE 
  PCTFREE 10 PCTUSED 40 INITRANS 1 MAXTRANS 255 
 NOCOMPRESS LOGGING 
  TABLESPACE BRSMDLD , 
 PARTITION P_NBS_N  VALUES (''NBS_N'') SEGMENT CREATION IMMEDIATE 
  PCTFREE 10 PCTUSED 40 INITRANS 1 MAXTRANS 255 
 NOCOMPRESS LOGGING 
  TABLESPACE BRSMDLD , 
 PARTITION P_NSC_A  VALUES (''NSC_A'') SEGMENT CREATION IMMEDIATE 
  PCTFREE 10 PCTUSED 40 INITRANS 1 MAXTRANS 255 
 NOCOMPRESS LOGGING 
  TABLESPACE BRSMDLD , 
 PARTITION P_OB22D  VALUES (''OB22D'') SEGMENT CREATION IMMEDIATE 
  PCTFREE 10 PCTUSED 40 INITRANS 1 MAXTRANS 255 
 NOCOMPRESS LOGGING 
  TABLESPACE BRSMDLD , 
 PARTITION P_OB22N  VALUES (''OB22N'') SEGMENT CREATION IMMEDIATE 
  PCTFREE 10 PCTUSED 40 INITRANS 1 MAXTRANS 255 
 NOCOMPRESS LOGGING 
  TABLESPACE BRSMDLD , 
 PARTITION P_PRV_D  VALUES (''PRV_D'') SEGMENT CREATION IMMEDIATE 
  PCTFREE 10 PCTUSED 40 INITRANS 1 MAXTRANS 255 
 NOCOMPRESS LOGGING 
  TABLESPACE BRSMDLD , 
 PARTITION P_KKFFA  VALUES (''KKFFA'') SEGMENT CREATION IMMEDIATE 
  PCTFREE 10 PCTUSED 40 INITRANS 1 MAXTRANS 255 
 NOCOMPRESS LOGGING 
  TABLESPACE BRSMDLD , 
 PARTITION P_OB22Z  VALUES (''OB22Z'') SEGMENT CREATION IMMEDIATE 
  PCTFREE 10 PCTUSED 40 INITRANS 1 MAXTRANS 255 
 NOCOMPRESS LOGGING 
  TABLESPACE BRSMDLD , 
 PARTITION P_PK_IBB  VALUES (''PK_IBB'') SEGMENT CREATION IMMEDIATE 
  PCTFREE 10 PCTUSED 40 INITRANS 1 MAXTRANS 255 
 NOCOMPRESS LOGGING 
  TABLESPACE BRSMDLD , 
 PARTITION P_RCLOS  VALUES (''RCLOS'') SEGMENT CREATION IMMEDIATE 
  PCTFREE 10 PCTUSED 40 INITRANS 1 MAXTRANS 255 
 NOCOMPRESS LOGGING 
  TABLESPACE BRSMDLD , 
 PARTITION P_PK_PRCT  VALUES (''PK_PRCT'') SEGMENT CREATION IMMEDIATE 
  PCTFREE 10 PCTUSED 40 INITRANS 1 MAXTRANS 255 
 NOCOMPRESS LOGGING 
  TABLESPACE BRSMDLD , 
 PARTITION P_MAXCRSUM  VALUES (''MAXCRSUM'') SEGMENT CREATION IMMEDIATE 
  PCTFREE 10 PCTUSED 40 INITRANS 1 MAXTRANS 255 
 NOCOMPRESS LOGGING 
  TABLESPACE BRSMDLD , 
 PARTITION P_IMPS6  VALUES (''IMPS6'') SEGMENT CREATION IMMEDIATE 
  PCTFREE 10 PCTUSED 40 INITRANS 1 MAXTRANS 255 
 NOCOMPRESS LOGGING 
  TABLESPACE BRSMDLD , 
 PARTITION P_PRPCRSUM  VALUES (''PRPCRSUM'') SEGMENT CREATION IMMEDIATE 
  PCTFREE 10 PCTUSED 40 INITRANS 1 MAXTRANS 255 
 NOCOMPRESS LOGGING 
  TABLESPACE BRSMDLD , 
 PARTITION P_DESCRSUM  VALUES (''DESCRSUM'') SEGMENT CREATION IMMEDIATE 
  PCTFREE 10 PCTUSED 40 INITRANS 1 MAXTRANS 255 
 NOCOMPRESS LOGGING 
  TABLESPACE BRSMDLD , 
 PARTITION P_SETCRSUM  VALUES (''SETCRSUM'') SEGMENT CREATION IMMEDIATE 
  PCTFREE 10 PCTUSED 40 INITRANS 1 MAXTRANS 255 
 NOCOMPRESS LOGGING 
  TABLESPACE BRSMDLD , 
 PARTITION P_IS6S5  VALUES (''IS6S5'') SEGMENT CREATION IMMEDIATE 
  PCTFREE 10 PCTUSED 40 INITRANS 1 MAXTRANS 255 
 NOCOMPRESS LOGGING 
  TABLESPACE BRSMDLD , 
 PARTITION P_PK_STR  VALUES (''PK_STR'') SEGMENT CREATION IMMEDIATE 
  PCTFREE 10 PCTUSED 40 INITRANS 1 MAXTRANS 255 
 NOCOMPRESS LOGGING 
  TABLESPACE BRSMDLD , 
 PARTITION P_PK_IDAT  VALUES (''PK_IDAT'') SEGMENT CREATION IMMEDIATE 
  PCTFREE 10 PCTUSED 40 INITRANS 1 MAXTRANS 255 
 NOCOMPRESS LOGGING 
  TABLESPACE BRSMDLD , 
 PARTITION P_W4_KPROC  VALUES (''W4_KPROC'') SEGMENT CREATION IMMEDIATE 
  PCTFREE 10 PCTUSED 40 INITRANS 1 MAXTRANS 255 
 NOCOMPRESS LOGGING 
  TABLESPACE BRSMDLD , 
 PARTITION P_PK_SCHEM  VALUES (''PK_SCHEM'') SEGMENT CREATION IMMEDIATE 
  PCTFREE 10 PCTUSED 40 INITRANS 1 MAXTRANS 255 
 NOCOMPRESS LOGGING 
  TABLESPACE BRSMDLD , 
 PARTITION P_MEG_REGD  VALUES (''MEG_REGD'') SEGMENT CREATION IMMEDIATE 
  PCTFREE 10 PCTUSED 40 INITRANS 1 MAXTRANS 255 
 NOCOMPRESS LOGGING 
  TABLESPACE BRSMDLD , 
 PARTITION P_MEG_DNPR  VALUES (''MEG_DNPR'') SEGMENT CREATION IMMEDIATE 
  PCTFREE 10 PCTUSED 40 INITRANS 1 MAXTRANS 255 
 NOCOMPRESS LOGGING 
  TABLESPACE BRSMDLD , 
 PARTITION P_MEG_DEPN  VALUES (''MEG_DEPN'') SEGMENT CREATION IMMEDIATE 
  PCTFREE 10 PCTUSED 40 INITRANS 1 MAXTRANS 255 
 NOCOMPRESS LOGGING 
  TABLESPACE BRSMDLD , 
 PARTITION P_MEG_TDOK  VALUES (''MEG_TDOK'') SEGMENT CREATION IMMEDIATE 
  PCTFREE 10 PCTUSED 40 INITRANS 1 MAXTRANS 255 
 NOCOMPRESS LOGGING 
  TABLESPACE BRSMDLD , 
 PARTITION P_MEG_DZPR  VALUES (''MEG_DZPR'') SEGMENT CREATION IMMEDIATE 
  PCTFREE 10 PCTUSED 40 INITRANS 1 MAXTRANS 255 
 NOCOMPRESS LOGGING 
  TABLESPACE BRSMDLD , 
 PARTITION P_MEG_BEGS  VALUES (''MEG_BEGS'') SEGMENT CREATION IMMEDIATE 
  PCTFREE 10 PCTUSED 40 INITRANS 1 MAXTRANS 255 
 NOCOMPRESS LOGGING 
  TABLESPACE BRSMDLD , 
 PARTITION P_MEG_BRAO  VALUES (''MEG_BRAO'') SEGMENT CREATION IMMEDIATE 
  PCTFREE 10 PCTUSED 40 INITRANS 1 MAXTRANS 255 
 NOCOMPRESS LOGGING 
  TABLESPACE BRSMDLD , 
 PARTITION P_PK_ODB  VALUES (''PK_ODB'') SEGMENT CREATION IMMEDIATE 
  PCTFREE 10 PCTUSED 40 INITRANS 1 MAXTRANS 255 
 NOCOMPRESS LOGGING 
  TABLESPACE BRSMDLD , 
 PARTITION P_PK_NAME  VALUES (''PK_NAME'') SEGMENT CREATION IMMEDIATE 
  PCTFREE 10 PCTUSED 40 INITRANS 1 MAXTRANS 255 
 NOCOMPRESS LOGGING 
  TABLESPACE BRSMDLD , 
 PARTITION P_PK_PCODW  VALUES (''PK_PCODW'') SEGMENT CREATION IMMEDIATE 
  PCTFREE 10 PCTUSED 40 INITRANS 1 MAXTRANS 255 
 NOCOMPRESS LOGGING 
  TABLESPACE BRSMDLD , 
 PARTITION P_PK_CITYW  VALUES (''PK_CITYW'') SEGMENT CREATION IMMEDIATE 
  PCTFREE 10 PCTUSED 40 INITRANS 1 MAXTRANS 255 
 NOCOMPRESS LOGGING 
  TABLESPACE BRSMDLD , 
 PARTITION P_PK_CNTRW  VALUES (''PK_CNTRW'') SEGMENT CREATION IMMEDIATE 
  PCTFREE 10 PCTUSED 40 INITRANS 1 MAXTRANS 255 
 NOCOMPRESS LOGGING 
  TABLESPACE BRSMDLD , 
 PARTITION P_PK_STRTW  VALUES (''PK_STRTW'') SEGMENT CREATION IMMEDIATE 
  PCTFREE 10 PCTUSED 40 INITRANS 1 MAXTRANS 255 
 NOCOMPRESS LOGGING 
  TABLESPACE BRSMDLD , 
 PARTITION P_PK_PHONE  VALUES (''PK_PHONE'') SEGMENT CREATION IMMEDIATE 
  PCTFREE 10 PCTUSED 40 INITRANS 1 MAXTRANS 255 
 NOCOMPRESS LOGGING 
  TABLESPACE BRSMDLD , 
 PARTITION P_PK_ODAT  VALUES (''PK_ODAT'') SEGMENT CREATION IMMEDIATE 
  PCTFREE 10 PCTUSED 40 INITRANS 1 MAXTRANS 255 
 NOCOMPRESS LOGGING 
  TABLESPACE BRSMDLD , 
 PARTITION P_CONSOL  VALUES (''CONSOL'') SEGMENT CREATION IMMEDIATE 
  PCTFREE 10 PCTUSED 40 INITRANS 1 MAXTRANS 255 
 NOCOMPRESS LOGGING 
  TABLESPACE BRSMDLD , 
 PARTITION P_SHTAR  VALUES (''SHTAR'') SEGMENT CREATION IMMEDIATE 
  PCTFREE 10 PCTUSED 40 INITRANS 1 MAXTRANS 255 
 NOCOMPRESS LOGGING 
  TABLESPACE BRSMDLD , 
 PARTITION P_DPAOTYPE  VALUES (''DPAOTYPE'') SEGMENT CREATION IMMEDIATE 
  PCTFREE 10 PCTUSED 40 INITRANS 1 MAXTRANS 255 
 NOCOMPRESS LOGGING 
  TABLESPACE BRSMDLD , 
 PARTITION P_B040  VALUES (''B040'') SEGMENT CREATION IMMEDIATE 
  PCTFREE 10 PCTUSED 40 INITRANS 1 MAXTRANS 255 
 NOCOMPRESS LOGGING 
  TABLESPACE BRSMDLD , 
 PARTITION P_CORPV  VALUES (''CORPV'') SEGMENT CREATION IMMEDIATE 
  PCTFREE 10 PCTUSED 40 INITRANS 1 MAXTRANS 255 
 NOCOMPRESS LOGGING 
  TABLESPACE BRSMDLD , 
 PARTITION P_KODU  VALUES (''KODU'') SEGMENT CREATION IMMEDIATE 
  PCTFREE 10 PCTUSED 40 INITRANS 1 MAXTRANS 255 
 NOCOMPRESS LOGGING 
  TABLESPACE BRSMDLD , 
 PARTITION P_SBO_DNPR  VALUES (''SBO_DNPR'') SEGMENT CREATION IMMEDIATE 
  PCTFREE 10 PCTUSED 40 INITRANS 1 MAXTRANS 255 
 NOCOMPRESS LOGGING 
  TABLESPACE BRSMDLD , 
 PARTITION P_SBO_DZPR  VALUES (''SBO_DZPR'') SEGMENT CREATION IMMEDIATE 
  PCTFREE 10 PCTUSED 40 INITRANS 1 MAXTRANS 255 
 NOCOMPRESS LOGGING 
  TABLESPACE BRSMDLD , 
 PARTITION P_SBO_BEGS  VALUES (''SBO_BEGS'') SEGMENT CREATION IMMEDIATE 
  PCTFREE 10 PCTUSED 40 INITRANS 1 MAXTRANS 255 
 NOCOMPRESS LOGGING 
  TABLESPACE BRSMDLD , 
 PARTITION P_SBO_BRAO  VALUES (''SBO_BRAO'') SEGMENT CREATION IMMEDIATE 
  PCTFREE 10 PCTUSED 40 INITRANS 1 MAXTRANS 255 
 NOCOMPRESS LOGGING 
  TABLESPACE BRSMDLD , 
 PARTITION P_SBO_DEPN  VALUES (''SBO_DEPN'') SEGMENT CREATION IMMEDIATE 
  PCTFREE 10 PCTUSED 40 INITRANS 1 MAXTRANS 255 
 NOCOMPRESS LOGGING 
  TABLESPACE BRSMDLD , 
 PARTITION P_SBO_REGD  VALUES (''SBO_REGD'') SEGMENT CREATION IMMEDIATE 
  PCTFREE 10 PCTUSED 40 INITRANS 1 MAXTRANS 255 
 NOCOMPRESS LOGGING 
  TABLESPACE BRSMDLD , 
 PARTITION P_SBO_TDOK  VALUES (''SBO_TDOK'') SEGMENT CREATION IMMEDIATE 
  PCTFREE 10 PCTUSED 40 INITRANS 1 MAXTRANS 255 
 NOCOMPRESS LOGGING 
  TABLESPACE BRSMDLD , 
 PARTITION P_DEFAULT  VALUES (DEFAULT) SEGMENT CREATION IMMEDIATE 
  PCTFREE 10 PCTUSED 40 INITRANS 1 MAXTRANS 255 
 NOCOMPRESS LOGGING 
  TABLESPACE BRSMDLD ) ';
exception when others then       
  if sqlcode=-955 then null; else raise; end if; 
end; 
/




PROMPT *** ALTER_POLICIES to ACCOUNTSW ***
 exec bpa.alter_policies('ACCOUNTSW');


COMMENT ON TABLE BARS.ACCOUNTSW IS '��������� �������� ���.���������� �����';
COMMENT ON COLUMN BARS.ACCOUNTSW.ACC IS 'ACC �����';
COMMENT ON COLUMN BARS.ACCOUNTSW.TAG IS '��� ���.���������';
COMMENT ON COLUMN BARS.ACCOUNTSW.VALUE IS '�������� ���.���������';
COMMENT ON COLUMN BARS.ACCOUNTSW.KF IS '';




PROMPT *** Create  constraint SYS_C0060800 ***
begin   
 execute immediate '
  ALTER TABLE BARS.ACCOUNTSW MODIFY (ACC NOT NULL ENABLE)';
exception when others then
  if  sqlcode=-2260 or sqlcode=-2261 or sqlcode=-2264 or sqlcode=-2275 or sqlcode=-1442 then null; else raise; end if;
 end;
/




PROMPT *** Create  constraint SYS_C0060801 ***
begin   
 execute immediate '
  ALTER TABLE BARS.ACCOUNTSW MODIFY (TAG NOT NULL ENABLE)';
exception when others then
  if  sqlcode=-2260 or sqlcode=-2261 or sqlcode=-2264 or sqlcode=-2275 or sqlcode=-1442 then null; else raise; end if;
 end;
/




PROMPT *** Create  constraint PK_ACCOUNTSW ***
begin   
 execute immediate '
  ALTER TABLE BARS.ACCOUNTSW ADD CONSTRAINT PK_ACCOUNTSW PRIMARY KEY (ACC, TAG)
  USING INDEX PCTFREE 10 INITRANS 2 MAXTRANS 255 
  TABLESPACE BRSMDLI  LOCAL
 (PARTITION P_01 
  PCTFREE 10 INITRANS 2 MAXTRANS 255 LOGGING 
  TABLESPACE BRSMDLI , 
 PARTITION P_02 
  PCTFREE 10 INITRANS 2 MAXTRANS 255 LOGGING 
  TABLESPACE BRSMDLI , 
 PARTITION P_03 
  PCTFREE 10 INITRANS 2 MAXTRANS 255 LOGGING 
  TABLESPACE BRSMDLI , 
 PARTITION P_04 
  PCTFREE 10 INITRANS 2 MAXTRANS 255 LOGGING 
  TABLESPACE BRSMDLI , 
 PARTITION P_05 
  PCTFREE 10 INITRANS 2 MAXTRANS 255 LOGGING 
  TABLESPACE BRSMDLI , 
 PARTITION P_06 
  PCTFREE 10 INITRANS 2 MAXTRANS 255 LOGGING 
  TABLESPACE BRSMDLI , 
 PARTITION P_07 
  PCTFREE 10 INITRANS 2 MAXTRANS 255 LOGGING 
  TABLESPACE BRSMDLI , 
 PARTITION P_08 
  PCTFREE 10 INITRANS 2 MAXTRANS 255 LOGGING 
  TABLESPACE BRSMDLI , 
 PARTITION P_09 
  PCTFREE 10 INITRANS 2 MAXTRANS 255 LOGGING 
  TABLESPACE BRSMDLI , 
 PARTITION P_10 
  PCTFREE 10 INITRANS 2 MAXTRANS 255 LOGGING 
  TABLESPACE BRSMDLI , 
 PARTITION P_11 
  PCTFREE 10 INITRANS 2 MAXTRANS 255 LOGGING 
  TABLESPACE BRSMDLI , 
 PARTITION P_12 
  PCTFREE 10 INITRANS 2 MAXTRANS 255 LOGGING 
  TABLESPACE BRSMDLI , 
 PARTITION P_13 
  PCTFREE 10 INITRANS 2 MAXTRANS 255 LOGGING 
  TABLESPACE BRSMDLI , 
 PARTITION P_14 
  PCTFREE 10 INITRANS 2 MAXTRANS 255 LOGGING 
  TABLESPACE BRSMDLI , 
 PARTITION P_15 
  PCTFREE 10 INITRANS 2 MAXTRANS 255 LOGGING 
  TABLESPACE BRSMDLI , 
 PARTITION P_16 
  PCTFREE 10 INITRANS 2 MAXTRANS 255 LOGGING 
  TABLESPACE BRSMDLI , 
 PARTITION P_17 
  PCTFREE 10 INITRANS 2 MAXTRANS 255 LOGGING 
  TABLESPACE BRSMDLI , 
 PARTITION P_18 
  PCTFREE 10 INITRANS 2 MAXTRANS 255 LOGGING 
  TABLESPACE BRSMDLI , 
 PARTITION P_19 
  PCTFREE 10 INITRANS 2 MAXTRANS 255 LOGGING 
  TABLESPACE BRSMDLI , 
 PARTITION P_20 
  PCTFREE 10 INITRANS 2 MAXTRANS 255 LOGGING 
  TABLESPACE BRSMDLI , 
 PARTITION P_21 
  PCTFREE 10 INITRANS 2 MAXTRANS 255 LOGGING 
  TABLESPACE BRSMDLI , 
 PARTITION P_22 
  PCTFREE 10 INITRANS 2 MAXTRANS 255 LOGGING 
  TABLESPACE BRSMDLI , 
 PARTITION P_23 
  PCTFREE 10 INITRANS 2 MAXTRANS 255 LOGGING 
  TABLESPACE BRSMDLI , 
 PARTITION P_24 
  PCTFREE 10 INITRANS 2 MAXTRANS 255 LOGGING 
  TABLESPACE BRSMDLI , 
 PARTITION P_25 
  PCTFREE 10 INITRANS 2 MAXTRANS 255 LOGGING 
  TABLESPACE BRSMDLI , 
 PARTITION P_26 
  PCTFREE 10 INITRANS 2 MAXTRANS 255 LOGGING 
  TABLESPACE BRSMDLI , 
 PARTITION P_27 
  PCTFREE 10 INITRANS 2 MAXTRANS 255 LOGGING 
  TABLESPACE BRSMDLI , 
 PARTITION P_28 
  PCTFREE 10 INITRANS 2 MAXTRANS 255 LOGGING 
  TABLESPACE BRSMDLI , 
 PARTITION P_29 
  PCTFREE 10 INITRANS 2 MAXTRANS 255 LOGGING 
  TABLESPACE BRSMDLI , 
 PARTITION P_30 
  PCTFREE 10 INITRANS 2 MAXTRANS 255 LOGGING 
  TABLESPACE BRSMDLI , 
 PARTITION P_31 
  PCTFREE 10 INITRANS 2 MAXTRANS 255 LOGGING 
  TABLESPACE BRSMDLI , 
 PARTITION P_32 
  PCTFREE 10 INITRANS 2 MAXTRANS 255 LOGGING 
  TABLESPACE BRSMDLI , 
 PARTITION P_33 
  PCTFREE 10 INITRANS 2 MAXTRANS 255 LOGGING 
  TABLESPACE BRSMDLI , 
 PARTITION P_34 
  PCTFREE 10 INITRANS 2 MAXTRANS 255 LOGGING 
  TABLESPACE BRSMDLI , 
 PARTITION P_35 
  PCTFREE 10 INITRANS 2 MAXTRANS 255 LOGGING 
  TABLESPACE BRSMDLI , 
 PARTITION P_36 
  PCTFREE 10 INITRANS 2 MAXTRANS 255 LOGGING 
  TABLESPACE BRSMDLI , 
 PARTITION P_37 
  PCTFREE 10 INITRANS 2 MAXTRANS 255 LOGGING 
  TABLESPACE BRSMDLI , 
 PARTITION P_38 
  PCTFREE 10 INITRANS 2 MAXTRANS 255 LOGGING 
  TABLESPACE BRSMDLI , 
 PARTITION P_39 
  PCTFREE 10 INITRANS 2 MAXTRANS 255 LOGGING 
  TABLESPACE BRSMDLI , 
 PARTITION P_40 
  PCTFREE 10 INITRANS 2 MAXTRANS 255 LOGGING 
  TABLESPACE BRSMDLI , 
 PARTITION P_41 
  PCTFREE 10 INITRANS 2 MAXTRANS 255 LOGGING 
  TABLESPACE BRSMDLI , 
 PARTITION P_42 
  PCTFREE 10 INITRANS 2 MAXTRANS 255 LOGGING 
  TABLESPACE BRSMDLI , 
 PARTITION P_43 
  PCTFREE 10 INITRANS 2 MAXTRANS 255 LOGGING 
  TABLESPACE BRSMDLI , 
 PARTITION P_44 
  PCTFREE 10 INITRANS 2 MAXTRANS 255 LOGGING 
  TABLESPACE BRSMDLI , 
 PARTITION P_45 
  PCTFREE 10 INITRANS 2 MAXTRANS 255 LOGGING 
  TABLESPACE BRSMDLI , 
 PARTITION P_46 
  PCTFREE 10 INITRANS 2 MAXTRANS 255 LOGGING 
  TABLESPACE BRSMDLI , 
 PARTITION P_47 
  PCTFREE 10 INITRANS 2 MAXTRANS 255 LOGGING 
  TABLESPACE BRSMDLI , 
 PARTITION P_48 
  PCTFREE 10 INITRANS 2 MAXTRANS 255 LOGGING 
  TABLESPACE BRSMDLI , 
 PARTITION P_49 
  PCTFREE 10 INITRANS 2 MAXTRANS 255 LOGGING 
  TABLESPACE BRSMDLI , 
 PARTITION P_50 
  PCTFREE 10 INITRANS 2 MAXTRANS 255 LOGGING 
  TABLESPACE BRSMDLI , 
 PARTITION P_51 
  PCTFREE 10 INITRANS 2 MAXTRANS 255 LOGGING 
  TABLESPACE BRSMDLI , 
 PARTITION P_52 
  PCTFREE 10 INITRANS 2 MAXTRANS 255 LOGGING 
  TABLESPACE BRSMDLI , 
 PARTITION P_53 
  PCTFREE 10 INITRANS 2 MAXTRANS 255 LOGGING 
  TABLESPACE BRSMDLI , 
 PARTITION P_54 
  PCTFREE 10 INITRANS 2 MAXTRANS 255 LOGGING 
  TABLESPACE BRSMDLI , 
 PARTITION P_55 
  PCTFREE 10 INITRANS 2 MAXTRANS 255 LOGGING 
  TABLESPACE BRSMDLI , 
 PARTITION P_56 
  PCTFREE 10 INITRANS 2 MAXTRANS 255 LOGGING 
  TABLESPACE BRSMDLI , 
 PARTITION P_57 
  PCTFREE 10 INITRANS 2 MAXTRANS 255 LOGGING 
  TABLESPACE BRSMDLI , 
 PARTITION P_58 
  PCTFREE 10 INITRANS 2 MAXTRANS 255 LOGGING 
  TABLESPACE BRSMDLI , 
 PARTITION P_59 
  PCTFREE 10 INITRANS 2 MAXTRANS 255 LOGGING 
  TABLESPACE BRSMDLI , 
 PARTITION P_60 
  PCTFREE 10 INITRANS 2 MAXTRANS 255 LOGGING 
  TABLESPACE BRSMDLI , 
 PARTITION P_61 
  PCTFREE 10 INITRANS 2 MAXTRANS 255 LOGGING 
  TABLESPACE BRSMDLI , 
 PARTITION P_62 
  PCTFREE 10 INITRANS 2 MAXTRANS 255 LOGGING 
  TABLESPACE BRSMDLI , 
 PARTITION P_63 
  PCTFREE 10 INITRANS 2 MAXTRANS 255 LOGGING 
  TABLESPACE BRSMDLI , 
 PARTITION P_64 
  PCTFREE 10 INITRANS 2 MAXTRANS 255 LOGGING 
  TABLESPACE BRSMDLI , 
 PARTITION P_65 
  PCTFREE 10 INITRANS 2 MAXTRANS 255 LOGGING 
  TABLESPACE BRSMDLI ) COMPRESS 1  ENABLE';
exception when others then
  if  sqlcode=-2260 or sqlcode=-2261 or sqlcode=-2264 or sqlcode=-2275 or sqlcode=-1442 then null; else raise; end if;
 end;
/




PROMPT *** Create  constraint FK_ACCOUNTSW_ACC ***
begin   
 execute immediate '
  ALTER TABLE BARS.ACCOUNTSW ADD CONSTRAINT FK_ACCOUNTSW_ACC FOREIGN KEY (ACC)
	  REFERENCES BARS.ACCOUNTS (ACC) ENABLE NOVALIDATE';
exception when others then
  if  sqlcode=-2260 or sqlcode=-2261 or sqlcode=-2264 or sqlcode=-2275 or sqlcode=-1442 then null; else raise; end if;
 end;
/




PROMPT *** Create  constraint FK_ACCOUNTSW_ACCOUNTS2 ***
begin   
 execute immediate '
  ALTER TABLE BARS.ACCOUNTSW ADD CONSTRAINT FK_ACCOUNTSW_ACCOUNTS2 FOREIGN KEY (KF, ACC)
	  REFERENCES BARS.ACCOUNTS (KF, ACC) ENABLE NOVALIDATE';
exception when others then
  if  sqlcode=-2260 or sqlcode=-2261 or sqlcode=-2264 or sqlcode=-2275 or sqlcode=-1442 then null; else raise; end if;
 end;
/




PROMPT *** Create  constraint FK_ACCOUNTSW_KF ***
begin   
 execute immediate '
  ALTER TABLE BARS.ACCOUNTSW ADD CONSTRAINT FK_ACCOUNTSW_KF FOREIGN KEY (KF)
	  REFERENCES BARS.BANKS$BASE (MFO) ENABLE NOVALIDATE';
exception when others then
  if  sqlcode=-2260 or sqlcode=-2261 or sqlcode=-2264 or sqlcode=-2275 or sqlcode=-1442 then null; else raise; end if;
 end;
/




PROMPT *** Create  constraint FK_ACCOUNTSW_ACCOUNTSFIELD ***
begin   
 execute immediate '
  ALTER TABLE BARS.ACCOUNTSW ADD CONSTRAINT FK_ACCOUNTSW_ACCOUNTSFIELD FOREIGN KEY (TAG)
	  REFERENCES BARS.ACCOUNTS_FIELD (TAG) ENABLE NOVALIDATE';
exception when others then
  if  sqlcode=-2260 or sqlcode=-2261 or sqlcode=-2264 or sqlcode=-2275 or sqlcode=-1442 then null; else raise; end if;
 end;
/




PROMPT *** Create  index PK_ACCOUNTSW ***
begin   
 execute immediate '
  CREATE UNIQUE INDEX BARS.PK_ACCOUNTSW ON BARS.ACCOUNTSW (ACC, TAG) 
  PCTFREE 10 INITRANS 2 MAXTRANS 255 
  TABLESPACE BRSMDLI  LOCAL
 (PARTITION P_01 
  PCTFREE 10 INITRANS 2 MAXTRANS 255 LOGGING 
  TABLESPACE BRSMDLI , 
 PARTITION P_02 
  PCTFREE 10 INITRANS 2 MAXTRANS 255 LOGGING 
  TABLESPACE BRSMDLI , 
 PARTITION P_03 
  PCTFREE 10 INITRANS 2 MAXTRANS 255 LOGGING 
  TABLESPACE BRSMDLI , 
 PARTITION P_04 
  PCTFREE 10 INITRANS 2 MAXTRANS 255 LOGGING 
  TABLESPACE BRSMDLI , 
 PARTITION P_05 
  PCTFREE 10 INITRANS 2 MAXTRANS 255 LOGGING 
  TABLESPACE BRSMDLI , 
 PARTITION P_06 
  PCTFREE 10 INITRANS 2 MAXTRANS 255 LOGGING 
  TABLESPACE BRSMDLI , 
 PARTITION P_07 
  PCTFREE 10 INITRANS 2 MAXTRANS 255 LOGGING 
  TABLESPACE BRSMDLI , 
 PARTITION P_08 
  PCTFREE 10 INITRANS 2 MAXTRANS 255 LOGGING 
  TABLESPACE BRSMDLI , 
 PARTITION P_09 
  PCTFREE 10 INITRANS 2 MAXTRANS 255 LOGGING 
  TABLESPACE BRSMDLI , 
 PARTITION P_10 
  PCTFREE 10 INITRANS 2 MAXTRANS 255 LOGGING 
  TABLESPACE BRSMDLI , 
 PARTITION P_11 
  PCTFREE 10 INITRANS 2 MAXTRANS 255 LOGGING 
  TABLESPACE BRSMDLI , 
 PARTITION P_12 
  PCTFREE 10 INITRANS 2 MAXTRANS 255 LOGGING 
  TABLESPACE BRSMDLI , 
 PARTITION P_13 
  PCTFREE 10 INITRANS 2 MAXTRANS 255 LOGGING 
  TABLESPACE BRSMDLI , 
 PARTITION P_14 
  PCTFREE 10 INITRANS 2 MAXTRANS 255 LOGGING 
  TABLESPACE BRSMDLI , 
 PARTITION P_15 
  PCTFREE 10 INITRANS 2 MAXTRANS 255 LOGGING 
  TABLESPACE BRSMDLI , 
 PARTITION P_16 
  PCTFREE 10 INITRANS 2 MAXTRANS 255 LOGGING 
  TABLESPACE BRSMDLI , 
 PARTITION P_17 
  PCTFREE 10 INITRANS 2 MAXTRANS 255 LOGGING 
  TABLESPACE BRSMDLI , 
 PARTITION P_18 
  PCTFREE 10 INITRANS 2 MAXTRANS 255 LOGGING 
  TABLESPACE BRSMDLI , 
 PARTITION P_19 
  PCTFREE 10 INITRANS 2 MAXTRANS 255 LOGGING 
  TABLESPACE BRSMDLI , 
 PARTITION P_20 
  PCTFREE 10 INITRANS 2 MAXTRANS 255 LOGGING 
  TABLESPACE BRSMDLI , 
 PARTITION P_21 
  PCTFREE 10 INITRANS 2 MAXTRANS 255 LOGGING 
  TABLESPACE BRSMDLI , 
 PARTITION P_22 
  PCTFREE 10 INITRANS 2 MAXTRANS 255 LOGGING 
  TABLESPACE BRSMDLI , 
 PARTITION P_23 
  PCTFREE 10 INITRANS 2 MAXTRANS 255 LOGGING 
  TABLESPACE BRSMDLI , 
 PARTITION P_24 
  PCTFREE 10 INITRANS 2 MAXTRANS 255 LOGGING 
  TABLESPACE BRSMDLI , 
 PARTITION P_25 
  PCTFREE 10 INITRANS 2 MAXTRANS 255 LOGGING 
  TABLESPACE BRSMDLI , 
 PARTITION P_26 
  PCTFREE 10 INITRANS 2 MAXTRANS 255 LOGGING 
  TABLESPACE BRSMDLI , 
 PARTITION P_27 
  PCTFREE 10 INITRANS 2 MAXTRANS 255 LOGGING 
  TABLESPACE BRSMDLI , 
 PARTITION P_28 
  PCTFREE 10 INITRANS 2 MAXTRANS 255 LOGGING 
  TABLESPACE BRSMDLI , 
 PARTITION P_29 
  PCTFREE 10 INITRANS 2 MAXTRANS 255 LOGGING 
  TABLESPACE BRSMDLI , 
 PARTITION P_30 
  PCTFREE 10 INITRANS 2 MAXTRANS 255 LOGGING 
  TABLESPACE BRSMDLI , 
 PARTITION P_31 
  PCTFREE 10 INITRANS 2 MAXTRANS 255 LOGGING 
  TABLESPACE BRSMDLI , 
 PARTITION P_32 
  PCTFREE 10 INITRANS 2 MAXTRANS 255 LOGGING 
  TABLESPACE BRSMDLI , 
 PARTITION P_33 
  PCTFREE 10 INITRANS 2 MAXTRANS 255 LOGGING 
  TABLESPACE BRSMDLI , 
 PARTITION P_34 
  PCTFREE 10 INITRANS 2 MAXTRANS 255 LOGGING 
  TABLESPACE BRSMDLI , 
 PARTITION P_35 
  PCTFREE 10 INITRANS 2 MAXTRANS 255 LOGGING 
  TABLESPACE BRSMDLI , 
 PARTITION P_36 
  PCTFREE 10 INITRANS 2 MAXTRANS 255 LOGGING 
  TABLESPACE BRSMDLI , 
 PARTITION P_37 
  PCTFREE 10 INITRANS 2 MAXTRANS 255 LOGGING 
  TABLESPACE BRSMDLI , 
 PARTITION P_38 
  PCTFREE 10 INITRANS 2 MAXTRANS 255 LOGGING 
  TABLESPACE BRSMDLI , 
 PARTITION P_39 
  PCTFREE 10 INITRANS 2 MAXTRANS 255 LOGGING 
  TABLESPACE BRSMDLI , 
 PARTITION P_40 
  PCTFREE 10 INITRANS 2 MAXTRANS 255 LOGGING 
  TABLESPACE BRSMDLI , 
 PARTITION P_41 
  PCTFREE 10 INITRANS 2 MAXTRANS 255 LOGGING 
  TABLESPACE BRSMDLI , 
 PARTITION P_42 
  PCTFREE 10 INITRANS 2 MAXTRANS 255 LOGGING 
  TABLESPACE BRSMDLI , 
 PARTITION P_43 
  PCTFREE 10 INITRANS 2 MAXTRANS 255 LOGGING 
  TABLESPACE BRSMDLI , 
 PARTITION P_44 
  PCTFREE 10 INITRANS 2 MAXTRANS 255 LOGGING 
  TABLESPACE BRSMDLI , 
 PARTITION P_45 
  PCTFREE 10 INITRANS 2 MAXTRANS 255 LOGGING 
  TABLESPACE BRSMDLI , 
 PARTITION P_46 
  PCTFREE 10 INITRANS 2 MAXTRANS 255 LOGGING 
  TABLESPACE BRSMDLI , 
 PARTITION P_47 
  PCTFREE 10 INITRANS 2 MAXTRANS 255 LOGGING 
  TABLESPACE BRSMDLI , 
 PARTITION P_48 
  PCTFREE 10 INITRANS 2 MAXTRANS 255 LOGGING 
  TABLESPACE BRSMDLI , 
 PARTITION P_49 
  PCTFREE 10 INITRANS 2 MAXTRANS 255 LOGGING 
  TABLESPACE BRSMDLI , 
 PARTITION P_50 
  PCTFREE 10 INITRANS 2 MAXTRANS 255 LOGGING 
  TABLESPACE BRSMDLI , 
 PARTITION P_51 
  PCTFREE 10 INITRANS 2 MAXTRANS 255 LOGGING 
  TABLESPACE BRSMDLI , 
 PARTITION P_52 
  PCTFREE 10 INITRANS 2 MAXTRANS 255 LOGGING 
  TABLESPACE BRSMDLI , 
 PARTITION P_53 
  PCTFREE 10 INITRANS 2 MAXTRANS 255 LOGGING 
  TABLESPACE BRSMDLI , 
 PARTITION P_54 
  PCTFREE 10 INITRANS 2 MAXTRANS 255 LOGGING 
  TABLESPACE BRSMDLI , 
 PARTITION P_55 
  PCTFREE 10 INITRANS 2 MAXTRANS 255 LOGGING 
  TABLESPACE BRSMDLI , 
 PARTITION P_56 
  PCTFREE 10 INITRANS 2 MAXTRANS 255 LOGGING 
  TABLESPACE BRSMDLI , 
 PARTITION P_57 
  PCTFREE 10 INITRANS 2 MAXTRANS 255 LOGGING 
  TABLESPACE BRSMDLI , 
 PARTITION P_58 
  PCTFREE 10 INITRANS 2 MAXTRANS 255 LOGGING 
  TABLESPACE BRSMDLI , 
 PARTITION P_59 
  PCTFREE 10 INITRANS 2 MAXTRANS 255 LOGGING 
  TABLESPACE BRSMDLI , 
 PARTITION P_60 
  PCTFREE 10 INITRANS 2 MAXTRANS 255 LOGGING 
  TABLESPACE BRSMDLI , 
 PARTITION P_61 
  PCTFREE 10 INITRANS 2 MAXTRANS 255 LOGGING 
  TABLESPACE BRSMDLI , 
 PARTITION P_62 
  PCTFREE 10 INITRANS 2 MAXTRANS 255 LOGGING 
  TABLESPACE BRSMDLI , 
 PARTITION P_63 
  PCTFREE 10 INITRANS 2 MAXTRANS 255 LOGGING 
  TABLESPACE BRSMDLI , 
 PARTITION P_64 
  PCTFREE 10 INITRANS 2 MAXTRANS 255 LOGGING 
  TABLESPACE BRSMDLI , 
 PARTITION P_65 
  PCTFREE 10 INITRANS 2 MAXTRANS 255 LOGGING 
  TABLESPACE BRSMDLI ) COMPRESS 1 ';
exception when others then
  if  sqlcode=-955  then null; else raise; end if;
 end;
/



PROMPT *** Create  grants  ACCOUNTSW ***
grant DELETE,INSERT,SELECT,UPDATE                                            on ACCOUNTSW       to ACCOUNTSW;
grant SELECT                                                                 on ACCOUNTSW       to BARSUPL;
grant DELETE,INSERT,SELECT,UPDATE                                            on ACCOUNTSW       to BARS_ACCESS_DEFROLE;
grant SELECT                                                                 on ACCOUNTSW       to BARS_DM;
grant DELETE,INSERT,SELECT,UPDATE                                            on ACCOUNTSW       to CUST001;
grant DELETE,INSERT,SELECT,UPDATE                                            on ACCOUNTSW       to OBPC;
grant SELECT                                                                 on ACCOUNTSW       to RPBN001;
grant SELECT                                                                 on ACCOUNTSW       to RPBN002;
grant SELECT                                                                 on ACCOUNTSW       to START1;
grant SELECT                                                                 on ACCOUNTSW       to UPLD;
grant DELETE,FLASHBACK,INSERT,SELECT,UPDATE                                  on ACCOUNTSW       to WR_ALL_RIGHTS;



PROMPT ===================================================================================== 
PROMPT *** End *** ========== Scripts /Sql/BARS/Table/ACCOUNTSW.sql =========*** End *** ===
PROMPT ===================================================================================== 
