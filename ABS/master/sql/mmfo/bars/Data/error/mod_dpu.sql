PROMPT ===================================================================================== 
PROMPT *** Run *** ========== Scripts /Sql/Bars/Data/Err/mod_DPU.sql =========*** Run *** ==
PROMPT ===================================================================================== 


PROMPT *** Create/replace ERR ������ DPU ***
declare
  l_mod  varchar2(3) := 'DPU';
  l_rus  varchar2(3) := 'RUS';
  l_ukr  varchar2(3) := 'UKR';
  l_eng  varchar2(3) := 'ENG';
  l_geo  varchar2(3) := 'GEO';
  l_exc  number      := -20000;
begin
    bars_error.add_module(l_mod, '�������� ��.���', 1);

    bars_error.add_message(l_mod, 1, l_exc, l_rus, '������ ����������� ��������� ��������', '', 1, 'CANT_GET_DPUID');
    bars_error.add_message(l_mod, 1, l_exc, l_ukr, '������� ���������� ��������� ��������!', '', 1, 'CANT_GET_DPUID');

    bars_error.add_message(l_mod, 2, l_exc, l_rus, '�� ������ ������ � %s', '', 1, 'RNK_NOT_FOUND');
    bars_error.add_message(l_mod, 2, l_exc, l_ukr, '�� ��������� �볺�� � %s', '', 1, 'RNK_NOT_FOUND');

    bars_error.add_message(l_mod, 3, l_exc, l_rus, '�� ������ ��� �������� � %s', '', 1, 'VIDD_NOT_FOUND');
    bars_error.add_message(l_mod, 3, l_exc, l_ukr, '�� ��������� ��� �������� � %s', '', 1, 'VIDD_NOT_FOUND');

    bars_error.add_message(l_mod, 4, l_exc, l_rus, '������ ���������� � ����� (��� %s, ��� %s): %s', '', 1, 'ACCNUM_GENERATION_FAILED');
    bars_error.add_message(l_mod, 4, l_exc, l_ukr, '������� ���������� � ������� (��� %s, ��� %s): %s', '', 1, 'ACCNUM_GENERATION_FAILED');

    bars_error.add_message(l_mod, 5, l_exc, l_rus, '�� ������ ���� ����.�������� ��� ���� �������� � %s � ������������� %s: %s', '', 1, 'EXPENSACC_NOT_FOUND');
    bars_error.add_message(l_mod, 5, l_exc, l_ukr, '�� ��������� ������� ����.������ ��� ���� �������� � %s � �������� %s: %s', '', 1, 'EXPENSACC_NOT_FOUND');

    bars_error.add_message(l_mod, 6, l_exc, l_rus, '������ ��� �������� ���������� �������� � %s: %s', '', 1, 'OPENCOMBDEAL_FAILED');
    bars_error.add_message(l_mod, 6, l_exc, l_ukr, '������� ��� ������� ��''������� �������� � %s: %s', '', 1, 'OPENCOMBDEAL_FAILED');

    bars_error.add_message(l_mod, 7, l_exc, l_rus, '������ ��� ���������� ���������� �������� �� ����� %s/%s: %s', '', 1, 'OPENINTCARD_FAILED');
    bars_error.add_message(l_mod, 7, l_exc, l_ukr, '������� ��� ��������� ��������� ������ �� ������� %s/%s: %s', '', 1, 'OPENINTCARD_FAILED');

    bars_error.add_message(l_mod, 8, l_exc, l_rus, '������ ��� �������� ����� %s/%s: %s', '', 1, 'OPENACC_FAILED');
    bars_error.add_message(l_mod, 8, l_exc, l_ukr, '������� ��� ������� ������� %s/%s: %s', '', 1, 'OPENACC_FAILED');

    bars_error.add_message(l_mod, 9, l_exc, l_rus, '������ ��� �������� �������� � %s: %s', '', 1, 'OPENDPUDEAL_FAILED');
    bars_error.add_message(l_mod, 9, l_exc, l_ukr, '������� ��� ������� �������� � %s: %s', '', 1, 'OPENDPUDEAL_FAILED');

    bars_error.add_message(l_mod, 10, l_exc, l_rus, '����� ������������ ����� ���.���������� %s', '', 1, 'ERR_ND');
    bars_error.add_message(l_mod, 10, l_exc, l_ukr, '������� ����������� ����� ��������� ����� %s', '', 1, 'ERR_ND');

    bars_error.add_message(l_mod, 11, l_exc, l_rus, '�� ������� ����� ������������ �������� � %s', '', 1, 'GENACC_NOT_FOUND');
    bars_error.add_message(l_mod, 11, l_exc, l_ukr, '�� �������� ������� ������������ �������� � %s', '', 1, 'GENACC_NOT_FOUND');

    bars_error.add_message(l_mod, 12, l_exc, l_rus, '������ ��� �������� ������ ��� ���.���������� �%s � �������� ���.�%s: %s', '', 1, 'AGROPENACC_FAILED');
    bars_error.add_message(l_mod, 12, l_exc, l_ukr, '������� ��� ������� ������� ��� ���.����� �%s �� �������� ���.�%s: %s', '', 1, 'AGROPENACC_FAILED');

    bars_error.add_message(l_mod, 13, l_exc, l_rus, '����� �������� (%s) �������� ������.�������', '', 1, 'DEALNUM_VALUE_ERROR');
    bars_error.add_message(l_mod, 13, l_exc, l_ukr, '����� �������� (%s) ������ ������.������', '', 1, 'DEALNUM_VALUE_ERROR');

    bars_error.add_message(l_mod, 14, l_exc, l_rus, '�� ���������� ����� �������� ������!', '', 1, 'ACCMASK_NOT_FOUND');
    bars_error.add_message(l_mod, 14, l_exc, l_ukr, '�� ��������� ����� �������� �������!', '', 1, 'ACCMASK_NOT_FOUND');

    bars_error.add_message(l_mod, 15, l_exc, l_rus, '�� ������ ��� �������������� �������� ���������', '', 1, 'OP_NOT_FOUND');
    bars_error.add_message(l_mod, 15, l_exc, l_ukr, '�� �������� ��� ��� ���������� �������� ��������', '', 1, 'OP_NOT_FOUND');

    bars_error.add_message(l_mod, 16, l_exc, l_rus, '�� ������ ���������� ������� %s', '', 1, 'DPUID_NOT_FOUND');
    bars_error.add_message(l_mod, 16, l_exc, l_ukr, '�� ��������� ���������� ������ %s', '', 1, 'DPUID_NOT_FOUND');

    bars_error.add_message(l_mod, 17, l_exc, l_rus, '���������� ������� %s - �� ������������� �����������', '', 1, 'DPUID_IDSTOP_0');
    bars_error.add_message(l_mod, 17, l_exc, l_ukr, '���������� ������ %s - �� ����������� �����������', '', 1, 'DPUID_IDSTOP_0');

    bars_error.add_message(l_mod, 18, l_exc, l_rus, '���������� ������� %s - �� ������� � ����', '', 1, 'DPUID_NOT_BEGIN');
    bars_error.add_message(l_mod, 18, l_exc, l_ukr, '���������� ������ %s - �� ������� � ����', '', 1, 'DPUID_NOT_BEGIN');

    bars_error.add_message(l_mod, 19, l_exc, l_rus, '���������� ������� %s - ����������', '', 1, 'DPUID_DATO_IS_NULL');
    bars_error.add_message(l_mod, 19, l_exc, l_ukr, '���������� ������ %s - ������������', '', 1, 'DPUID_DATO_IS_NULL');

    bars_error.add_message(l_mod, 20, l_exc, l_rus, '���������� ������� %s - ���������', '', 1, 'DPUID_END');
    bars_error.add_message(l_mod, 20, l_exc, l_ukr, '���������� ������ %s - ������������', '', 1, 'DPUID_END');

    bars_error.add_message(l_mod, 21, l_exc, l_rus, '�� ������� ��������� ������ � %s', '', 1, 'IDSTOP_PARAMS_NOT_FOUND');
    bars_error.add_message(l_mod, 21, l_exc, l_ukr, '�� ������ ��������� ������ � %s', '', 1, 'IDSTOP_PARAMS_NOT_FOUND');

    bars_error.add_message(l_mod, 22, l_exc, l_rus, '���������� ��������� ����������� ���������� ������ �� ��������!', '', 1, 'ACTUALRATE_IS_NULL');
    bars_error.add_message(l_mod, 22, l_exc, l_ukr, '��������� ��������� ���� ��������� ������ �� ��������!', '', 1, 'ACTUALRATE_IS_NULL');

    bars_error.add_message(l_mod, 23, l_exc, l_rus, '���������� �������� �������� ������� ������ � %s', '', 1, 'SHPROC_NOT_FOUND');
    bars_error.add_message(l_mod, 23, l_exc, l_ukr, '��������� ��������� �������� ������ ������ � %s', '', 1, 'SHPROC_NOT_FOUND');

    bars_error.add_message(l_mod, 24, l_exc, l_rus, '����������� ������ �����!', '', 1, 'SH_IS_UNCORRECT');
    bars_error.add_message(l_mod, 24, l_exc, l_ukr, '���������� �������� �����!', '', 1, 'SH_IS_UNCORRECT');

    bars_error.add_message(l_mod, 25, l_exc, l_rus, '�� ���������� ����������� �������!', '', 1, 'MINSUM_0');
    bars_error.add_message(l_mod, 25, l_exc, l_ukr, '�� ������������ ������������ �������!', '', 1, 'MINSUM_0');

    bars_error.add_message(l_mod, 26, l_exc, l_rus, '�� ������ �������� � %s', '', 1, 'COMB_INPAYMENT_NOT_FOUND');
    bars_error.add_message(l_mod, 26, l_exc, l_ukr, '�� ��������� �������� � %s', '', 1, 'COMB_INPAYMENT_NOT_FOUND');

    bars_error.add_message(l_mod, 27, l_exc, l_rus, '�� ������ ������� (���.%s)', '', 1, 'COMB_DEAL_NOT_FOUND');
    bars_error.add_message(l_mod, 27, l_exc, l_ukr, '�� ��������� ������ (���.%s)', '', 1, 'COMB_DEAL_NOT_FOUND');

    bars_error.add_message(l_mod, 28, l_exc, l_rus, '�� ������ ���.���� �������� � %s', '', 1, 'COMB_ACC_NOT_FOUND');
    bars_error.add_message(l_mod, 28, l_exc, l_ukr, '�� ��������� ���.������� �������� � %s', '', 1, 'COMB_ACC_NOT_FOUND');

    bars_error.add_message(l_mod, 29, l_exc, l_rus, '�� ����� %s/%s ���� ���������������� ���������', '', 1, 'COMB_SALDOCHECK_FAILED');
    bars_error.add_message(l_mod, 29, l_exc, l_ukr, '�� ������� %s/%s � ���������� ���������', '', 1, 'COMB_SALDOCHECK_FAILED');

    bars_error.add_message(l_mod, 30, l_exc, l_rus, '���� %s/%s ������', '', 1, 'COMB_ACCOPENCHECK_FAILED');
    bars_error.add_message(l_mod, 30, l_exc, l_ukr, '������� %s/%s ��������', '', 1, 'COMB_ACCOPENCHECK_FAILED');

    bars_error.add_message(l_mod, 31, l_exc, l_rus, '������ ���������(%s) �� ��������� � ������� ����� %s/%s', '', 1, 'COMB_CURRENCYCHECK_FAILED');
    bars_error.add_message(l_mod, 31, l_exc, l_ukr, '������ ���������(%s) �� �������� � ������� ������� %s/%s', '', 1, 'COMB_CURRENCYCHECK_FAILED');

    bars_error.add_message(l_mod, 32, l_exc, l_rus, '�������� � %s � � %s ����������� ������ ��������', '', 1, 'COMB_CUSTCHECK_FAILED');
    bars_error.add_message(l_mod, 32, l_exc, l_ukr, '�������� � %s � � %s �������� ����� �볺����', '', 1, 'COMB_CUSTCHECK_FAILED');

    bars_error.add_message(l_mod, 33, l_exc, l_rus, '������� � %s �� ��������', '', 1, 'COMB_DEALDAT_FAILED');
    bars_error.add_message(l_mod, 33, l_exc, l_ukr, '������ � %s �� ��������', '', 1, 'COMB_DEALDAT_FAILED');

    bars_error.add_message(l_mod, 34, l_exc, l_rus, '�������� � %s � � %s - �� ���������������', '', 1, 'COMB_INVALID_DPUTYPE');
    bars_error.add_message(l_mod, 34, l_exc, l_ukr, '�������� � %s � � %s �� � ������������', '', 1, 'COMB_INVALID_DPUTYPE');

    bars_error.add_message(l_mod, 35, l_exc, l_rus, '������ ������� ��������� � %s �� ���������', '', 1, 'COMB_NLKREFUPD_FAILED');
    bars_error.add_message(l_mod, 35, l_exc, l_ukr, '������� ��������� ��������� � %s � ���������', '', 1, 'COMB_NLKREFUPD_FAILED');

    bars_error.add_message(l_mod, 36, l_exc, l_rus, '������ ���������� (%s -> %s/%s, %s -> %s/%s): %s', '', 1, 'COMB_BREAKDOWN_FAILED');
    bars_error.add_message(l_mod, 36, l_exc, l_ukr, '������� ����������� (%s -> %s/%s, %s -> %s/%s): %s', '', 1, 'COMB_BREAKDOWN_FAILED');

    bars_error.add_message(l_mod, 37, l_exc, l_rus, '�� ������� �������� ��� ���������� �������', '', 1, 'COMB_TT_NOT_FOUND');
    bars_error.add_message(l_mod, 37, l_exc, l_ukr, '�� ������� �������� ��� ����������� �����', '', 1, 'COMB_TT_NOT_FOUND');

    bars_error.add_message(l_mod, 38, l_exc, l_rus, '�� ������ ���������� ���� �� �������� � %s', '', 1, 'UPDEAL_INTACC_NOT_FOUND');
    bars_error.add_message(l_mod, 38, l_exc, l_ukr, '�� ��������� ���������� ������� �� �������� � %s', '', 1, 'UPDEAL_INTACC_NOT_FOUND');

    bars_error.add_message(l_mod, 39, l_exc, l_rus, '�� ����� ����� �������� � %s', '', 1, 'UPDEAL_NUM_NULL');
    bars_error.add_message(l_mod, 39, l_exc, l_ukr, '�� ������� ����� �������� � %s', '', 1, 'UPDEAL_NUM_NULL');

    bars_error.add_message(l_mod, 40, l_exc, l_rus, '�� ������ ���� ���������� �������� � %s', '', 1, 'UPDEAL_DATREG_NULL');
    bars_error.add_message(l_mod, 40, l_exc, l_ukr, '�� ������ ���� ���������� �������� � %s', '', 1, 'UPDEAL_DATREG_NULL');

    bars_error.add_message(l_mod, 41, l_exc, l_rus, '�� ������ ���� ������ �������� � %s', '', 1, 'UPDEAL_DATBEG_NULL');
    bars_error.add_message(l_mod, 41, l_exc, l_ukr, '�� ������ ���� ������� �������� � %s', '', 1, 'UPDEAL_DATBEG_NULL');

    bars_error.add_message(l_mod, 42, l_exc, l_rus, '�� ������ ���������� ������ �� �������� � %s', '', 1, 'UPDEAL_RATE_NULL');
    bars_error.add_message(l_mod, 42, l_exc, l_ukr, '�� ������ ��������� ������ �� �������� � %s', '', 1, 'UPDEAL_RATE_NULL');

    bars_error.add_message(l_mod, 43, l_exc, l_rus, '�� ������ ������-�� ������� %% �� �������� � %s', '', 1, 'UPDEAL_FREQ_NULL');
    bars_error.add_message(l_mod, 43, l_exc, l_ukr, '�� ������ �����-�� ������ %% �� �������� � %s', '', 1, 'UPDEAL_FREQ_NULL');

    bars_error.add_message(l_mod, 44, l_exc, l_rus, '�� ����� ����� �� ����������� �������� � %s', '', 1, 'UPDEAL_STOP_NULL');
    bars_error.add_message(l_mod, 44, l_exc, l_ukr, '�� ������� ����� �� ������������ �������� � %s', '', 1, 'UPDEAL_STOP_NULL');

    bars_error.add_message(l_mod, 45, l_exc, l_rus, '�� ������ ������������� ��� �������� � %s', '', 1, 'UPDEAL_BRANCH_NULL');
    bars_error.add_message(l_mod, 45, l_exc, l_ukr, '�� ������� ������� ��� �������� � %s', '', 1, 'UPDEAL_BRANCH_NULL');

    bars_error.add_message(l_mod, 46, l_exc, l_rus, '������ ��������� ���������� �������� � %s: %s', '', 1, 'UPDEAL_FAILED');
    bars_error.add_message(l_mod, 46, l_exc, l_ukr, '������� ���� ��������� �������� � %s: %s', '', 1, 'UPDEAL_FAILED');

    bars_error.add_message(l_mod, 47, l_exc, l_rus, '������ ����������� �������� � %s: %s', '', 1, 'UPDEAL_PROLONG_FAILED');
    bars_error.add_message(l_mod, 47, l_exc, l_ukr, '������� ����������� �������� � %s: %s', '', 1, 'UPDEAL_PROLONG_FAILED');

    bars_error.add_message(l_mod, 48, l_exc, l_rus, '�� ������� ������ �� �������� � %s �� %s', '', 1, 'UPDEAL_RATE_NOT_FOUND');
    bars_error.add_message(l_mod, 48, l_exc, l_ukr, '�� �������� ������ �� �������� � %s �� %s', '', 1, 'UPDEAL_RATE_NOT_FOUND');

    bars_error.add_message(l_mod, 49, l_exc, l_rus, '������ ��������� ������ �� �������� � %s: %s', '', 1, 'UPDEAL_RATE_FAILED');
    bars_error.add_message(l_mod, 49, l_exc, l_ukr, '������� ���� ������ �� �������� � %s: %s', '', 1, 'UPDEAL_RATE_FAILED');

    bars_error.add_message(l_mod, 50, l_exc, l_rus, '��������� �������� �� ������������� ���.����� %s (%s != %s)', '', 1, 'S180_INVALID');
    bars_error.add_message(l_mod, 50, l_exc, l_ukr, '����� �������� �� ������� ���.������� %s (%s != %s)', '', 1, 'S180_INVALID');

    bars_error.add_message(l_mod, 51, l_exc, l_rus, '��������� ���� �������� � %s �� ��������������� ���������', '', 1, 'CRTSUBDEAL_NOTVALID');
    bars_error.add_message(l_mod, 51, l_exc, l_ukr, '���� ���� �������� � %s �� ����������� ����������', '', 1, 'CRTSUBDEAL_NOTVALID');

    bars_error.add_message(l_mod, 52, l_exc, l_rus, '�� ������ ����.��� ��� ���� � %s', '', 1, 'CRTSUBDEAL_NOCOMBTYPE');
    bars_error.add_message(l_mod, 52, l_exc, l_ukr, '�� ��������� ����.��� ��� ���� � %s', '', 1, 'CRTSUBDEAL_NOCOMBTYPE');

    bars_error.add_message(l_mod, 53, l_exc, l_rus, '�� ������� ������ �� �������� � %s', '', 1, 'CRTSUBDEAL_NORATE');
    bars_error.add_message(l_mod, 53, l_exc, l_ukr, '�� �������� ������ �� �������� � %s', '', 1, 'CRTSUBDEAL_NORATE');

    bars_error.add_message(l_mod, 54, l_exc, l_rus, '������ ��� �������� ���������� �������� ��� ����.�������� � %s: %s', '', 1, 'CRTSUBDEAL_FAILED');
    bars_error.add_message(l_mod, 54, l_exc, l_ukr, '������� ��� ������� ��''������� �������� ��� ����.�������� � %s: %s', '', 1, 'CRTSUBDEAL_FAILED');

    bars_error.add_message(l_mod, 55, l_exc, l_rus, '������ ������������ �������� OB22 (%s) ��� ���.����� %s', '', 1, 'INVALID_OBB22');
    bars_error.add_message(l_mod, 55, l_exc, l_ukr, '������� ������������ �������� OB22 (%s) ��� ���.���. %s', '', 1, 'INVALID_OBB22');

    bars_error.add_message(l_mod, 56, l_exc, l_rus, '������ �������� �������� ��� �������� ���� �������� � %s: %s', '', 1, 'GEN_EXPDPTYPE_FAILED');
    bars_error.add_message(l_mod, 56, l_exc, l_ukr, '������� ��������� ������� ��� �������� ���� �������� � %s: %s', '', 1, 'GEN_EXPDPTYPE_FAILED');

    bars_error.add_message(l_mod, 57, l_exc, l_rus, '�� ������ ��� �������� � %s', '', 1, 'SETYPERATE_VIDD_NOT_FOUND');
    bars_error.add_message(l_mod, 57, l_exc, l_ukr, '�� ��������� ��� �������� � %s', '', 1, 'SETYPERATE_VIDD_NOT_FOUND');

    bars_error.add_message(l_mod, 58, l_exc, l_rus, '�� ������ ��� �������� � %s', '', 1, 'SETYPERATE_TYPEID_NOT_FOUND');
    bars_error.add_message(l_mod, 58, l_exc, l_ukr, '�� ��������� ��� �������� � %s', '', 1, 'SETYPERATE_TYPEID_NOT_FOUND');

    bars_error.add_message(l_mod, 59, l_exc, l_rus, '�� ������� ������ � %s', '', 1, 'SETYPERATE_KV_NOT_FOUND');
    bars_error.add_message(l_mod, 59, l_exc, l_ukr, '�� �������� ������ � %s', '', 1, 'SETYPERATE_KV_NOT_FOUND');

    bars_error.add_message(l_mod, 60, l_exc, l_rus, '��������� ��� �������� (%s) �� ������������� ���� (%s) ���� �������� � %s', '', 1, 'SETYPERATE_TYPEID_MISMATCH');
    bars_error.add_message(l_mod, 60, l_exc, l_ukr, '�������� ��� �������� (%s) �� ������� ���� (%s) ���� �������� � %s', '', 1, 'SETYPERATE_TYPEID_MISMATCH');

    bars_error.add_message(l_mod, 61, l_exc, l_rus, '��������� ������ (%s) �� ������������� ������ (%s) ���� �������� � %s', '', 1, 'SETYPERATE_KV_MISMATCH');
    bars_error.add_message(l_mod, 61, l_exc, l_ukr, '������� ������ (%s) �� ������� ����� (%s) ���� �������� � %s', '', 1, 'SETYPERATE_KV_MISMATCH');

    bars_error.add_message(l_mod, 62, l_exc, l_rus, '����������� ����� ����.���� (%s ���, %s ����, ���� ���. %s)', '', 1, 'SETYPERATE_TERM_INVALID');
    bars_error.add_message(l_mod, 62, l_exc, l_ukr, '���������� ������� ����.����� (%s ��, %s ���, ���� ���. %s)', '', 1, 'SETYPERATE_TERM_INVALID');

    bars_error.add_message(l_mod, 63, l_exc, l_rus, '����������� ������ ����.����� (%s, ���� ���. %s)', '', 1, 'SETYPERATE_AMNT_INVALID');
    bars_error.add_message(l_mod, 63, l_exc, l_ukr, '���������� ������ ����.���� (%s, ���� ���. %s)', '', 1, 'SETYPERATE_AMNT_INVALID');

    bars_error.add_message(l_mod, 64, l_exc, l_rus, '����������� ������ ������ (����. %s, ����. %s)', '', 1, 'SETYPERATE_RATE_INVALID');
    bars_error.add_message(l_mod, 64, l_exc, l_ukr, '���������� ����� ������ (����. %s, ����. %s)', '', 1, 'SETYPERATE_RATE_INVALID');

    bars_error.add_message(l_mod, 65, l_exc, l_rus, '������ ��� ������ ������ ��� �������� %s/%s (��� %s), ����� %s/%s � ����� %s: %s', '', 1, 'SETYPERATE_FAILED');
    bars_error.add_message(l_mod, 65, l_exc, l_ukr, '������� ��� ������ ������ ��� �������� %s/%s (��� %s), ������ %s/%s � ���� %s: %s', '', 1, 'SETYPERATE_FAILED');

    bars_error.add_message(l_mod, 66, l_exc, l_rus, '������ �� ���������� ������� �� ���.���� ���.����� (���.%s) �������������� ��.�������������', '', 1, 'GENACC_RECEIPT_LOCKED');
    bars_error.add_message(l_mod, 66, l_exc, l_ukr, '����� �� ����������� ����� �� ���.������� ���.�� (���.%s) ������������ ����� ������������', '', 1, 'GENACC_RECEIPT_LOCKED');

    bars_error.add_message(l_mod, 67, l_exc, l_rus, '������ ��� ��������� ������� �� ���������� ������� �� ���.���� ���.����� (���.%s): %s', '', 1, 'GENACC_RECEIPT_FAILED');
    bars_error.add_message(l_mod, 67, l_exc, l_ukr, '������� ��� ������� ������� �� ����������� ����� �� ���.������� ���.�� (���.%s): %s', '', 1, 'GENACC_RECEIPT_FAILED');

    bars_error.add_message(l_mod, 68, l_exc, l_rus, '���������� ������� � %s - ������� ���������.��������� �� ���.�����', '', 1, 'DEPACC_SALDO_MISMATCH');
    bars_error.add_message(l_mod, 68, l_exc, l_ukr, '���������� ������ � %s - ������� ���������.��������� �� ���.�����', '', 1, 'DEPACC_SALDO_MISMATCH');

    bars_error.add_message(l_mod, 69, l_exc, l_rus, '���������� ������� � %s - ������� ���������.��������� �� ����.�����', '', 1, 'INTACC_SALDO_MISMATCH');
    bars_error.add_message(l_mod, 69, l_exc, l_ukr, '���������� ������ � %s - ������� ���������.��������� �� ����.�����', '', 1, 'INTACC_SALDO_MISMATCH');

    bars_error.add_message(l_mod, 70, l_exc, l_rus, '�������� %s ������������� - ��� ������', '', 1, 'CLOSDEAL_DENIED_ISCLOSED');
    bars_error.add_message(l_mod, 70, l_exc, l_ukr, '�������� %s ����������� - ��� ��������', '', 1, 'CLOSDEAL_DENIED_ISCLOSED');

    bars_error.add_message(l_mod, 71, l_exc, l_rus, '�������� %s ������������� - ��������� ������� �� ����� %s/%s', '', 1, 'CLOSDEAL_DENIED_SALDO');
    bars_error.add_message(l_mod, 71, l_exc, l_ukr, '�������� %s ����������� - �������� ������� �� ������� %s/%s', '', 1, 'CLOSDEAL_DENIED_SALDO');

    bars_error.add_message(l_mod, 72, l_exc, l_rus, '�������� %s ������������� - � ������� ��� ������� �������� �� ����� %s/%s', '', 1, 'CLOSDEAL_DENIED_TURNS');
    bars_error.add_message(l_mod, 72, l_exc, l_ukr, '�������� %s ����������� - � ��������� �� �������� ������� �� ������� %s/%s', '', 1, 'CLOSDEAL_DENIED_TURNS');

    bars_error.add_message(l_mod, 73, l_exc, l_rus, '������ ��� �������� %s', '', 1, 'CLOSDEAL_FAILED');
    bars_error.add_message(l_mod, 73, l_exc, l_ukr, '������ ��� ������� %s', '', 1, 'CLOSDEAL_FAILED');

    bars_error.add_message(l_mod, 74, l_exc, l_rus, '�������� %s ������������� - ������� ���.���.����������', '', 1, 'CLOSDEAL_DENIED_ACTAGR');
    bars_error.add_message(l_mod, 74, l_exc, l_ukr, '�������� %s ����������� - ������� ���.���.�����', '', 1, 'CLOSDEAL_DENIED_ACTAGR');

    bars_error.add_message(l_mod, 75, l_exc, l_rus, '��������� ���������� ������� � ����������!', '', 1, 'MRATE_INSERT_DENIED');
    bars_error.add_message(l_mod, 75, l_exc, l_ukr, '���������� ��������� ������ � �������!', '', 1, 'MRATE_INSERT_DENIED');

    bars_error.add_message(l_mod, 76, l_exc, l_rus, '��������� �������� ������� �� �����������!', '', 1, 'MRATE_DELETE_DENIED');
    bars_error.add_message(l_mod, 76, l_exc, l_ukr, '���������� ��������� ������ � ��������!', '', 1, 'MRATE_DELETE_DENIED');

    bars_error.add_message(l_mod, 77, l_exc, l_rus, '�������� ������ (%s) ������� �� �������� {0..100}', '', 1, 'MRATE_INVALID_VALUE');
    bars_error.add_message(l_mod, 77, l_exc, l_ukr, '�������� ������ (%s) �������� �� ��� �������� {0..100}', '', 1, 'MRATE_INVALID_VALUE');

    bars_error.add_message(l_mod, 78, l_exc, l_rus, '���.������ (%s) �� ����� ���� ������ ������������ (%s)', '', 1, 'MRATE_MISMATCH');
    bars_error.add_message(l_mod, 78, l_exc, l_ukr, '̳�.������ (%s) �� ���� ���� ������ �� ����������� (%s)', '', 1, 'MRATE_MISMATCH');

    bars_error.add_message(l_mod, 79, l_exc, l_rus, '������� ������������ �������� (%s) ���� "���.������ �� ������."', '', 1, 'IRRDENIED_INVALID_VALUE');
    bars_error.add_message(l_mod, 79, l_exc, l_ukr, '������� ���������� �������� (%s) ���� "���.������ �� ������."', '', 1, 'IRRDENIED_INVALID_VALUE');

    bars_error.add_message(l_mod, 100, l_exc, l_rus, '������ ������������ �������� K013 (%s)', '', 1, 'INVALID_K013');
    bars_error.add_message(l_mod, 100, l_exc, l_ukr, '������� ������������ �������� K013 (%s)', '', 1, 'INVALID_K013');

    bars_error.add_message(l_mod, 101, l_exc, l_rus, '������ ������������ �������� S181 (%s)', '', 1, 'INVALID_S181');
    bars_error.add_message(l_mod, 101, l_exc, l_ukr, '������� ������������ �������� S181 (%s)', '', 1, 'INVALID_S181');

    bars_error.add_message(l_mod, 102, l_exc, l_rus, '����������� ������� ���� ���������� �������� (DAT_END[%s] <= ACR_DAT[%s])!', '', 1, 'UPDEAL_DATEND_INVALID');
    bars_error.add_message(l_mod, 102, l_exc, l_ukr, '���������� ������� ���� ���������� �������� (DAT_END[%s] <= ACR_DAT[%s])!', '', 1, 'UPDEAL_DATEND_INVALID');

    bars_error.add_message(l_mod, 103, l_exc, l_rus, '������� ������������ �������� ���� ���������� ��������(%s)!', '', 1, 'INVALID_PARTIAL_PAYMENT_OPTION');
    bars_error.add_message(l_mod, 103, l_exc, l_ukr, '������� ����������� �������� ���� �������� ������ (%s)!', '', 1, 'INVALID_PARTIAL_PAYMENT_OPTION');

    bars_error.add_message(l_mod, 104, l_exc, l_rus, '���� ��������� ������ s% ��������� ���� ��������� ����� s%!', '', 1, 'INVALID_DATEND_TRANCHE');
    bars_error.add_message(l_mod, 104, l_exc, l_ukr, '���� ���������� ������ %s �������� ���� ���������� �� %s!', '', 1, 'INVALID_DATEND_TRANCHE');

    bars_error.add_message(l_mod, 105, l_exc, l_rus, '�������������% s-�� ������ ��������� �������� ��������� ��������!', '', 1, 'UPDEAL_MODIFY_DENIED');
    bars_error.add_message(l_mod, 105, l_exc, l_ukr, '������������ %s-�� ���� ���������� �������� ��������� ��������!', '', 1, 'UPDEAL_MODIFY_DENIED');

    bars_error.add_message(l_mod, 106, l_exc, l_rus, '������ ������� ���������: %s', '', 1, 'PAYOUT_ERR');
    bars_error.add_message(l_mod, 106, l_exc, l_ukr, '������� ������ �������: %s', '', 1, 'PAYOUT_ERR');

    bars_error.add_message(l_mod, 107, l_exc, l_rus, '���������� ������� �������� (��� %s) � ���������� ��������� � %s: %s', '', 1, 'LINK_DOCUMENT_FAILED');
    bars_error.add_message(l_mod, 107, l_exc, l_ukr, '��������� ��`����� �������� (��� %s) � ���������� ��������� � %s: %s', '', 1, 'LINK_DOCUMENT_FAILED');

    bars_error.add_message(l_mod, 108, l_exc, l_rus, '��������� ��������� ������� ������� ��� ����������� ���������!', '', 1, 'DPUID_IDSTOP_IRREVOCABLE');
    bars_error.add_message(l_mod, 108, l_exc, l_ukr, '���������� ���������� ��������� ����� ��� ������������ ��������!', '', 1, 'DPUID_IDSTOP_IRREVOCABLE');

    bars_error.add_message(l_mod, 109, l_exc, l_rus, '�� ������ ���� �������� ����������� ������ �� ������� � ��!', '', 1, 'RET_INCOME_TAX_ACC_NOT_FOUND');
    bars_error.add_message(l_mod, 109, l_exc, l_ukr, '�� ��������� ������� ���������� ���������� ������� �� �������� � ��!', '', 1, 'RET_INCOME_TAX_ACC_NOT_FOUND');

    bars_error.add_message(l_mod, 222, l_exc, l_rus, '������� ��� �������� ������������� %s', '', 1, 'TASK_ALREADY_RUNNING');
    bars_error.add_message(l_mod, 222, l_exc, l_ukr, '�������� ��� �������� ������������ %s', '', 1, 'TASK_ALREADY_RUNNING');

    bars_error.add_message(l_mod, 666, l_exc, l_rus, '%s', '', 1, 'GENERAL_ERROR_CODE');
    bars_error.add_message(l_mod, 666, l_exc, l_ukr, '%s', '', 1, 'GENERAL_ERROR_CODE');

    bars_error.add_message(l_mod, 999, l_exc, l_rus, '������ ���������� �������. �������� - %s', '', 1, 'AUTOJOB_ERROR');
    bars_error.add_message(l_mod, 999, l_exc, l_ukr, '������� ��������� �������. �������� - %s', '', 1, 'AUTOJOB_ERROR');
  commit;
end;
/
PROMPT ===================================================================================== 
PROMPT *** End *** ========== Scripts /Sql/Bars/Data/Err/mod_DPU.sql =========*** Run *** ==
PROMPT ===================================================================================== 
